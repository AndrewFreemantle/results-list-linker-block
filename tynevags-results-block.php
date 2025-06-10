<?php
/*
Plugin Name: Tynevags Results Block
Description: WordPress block plugin for displaying race result links.
Version: 0.1.4
Author: Andrew Freemantle
*/

if ( ! defined( 'ABSPATH' ) ) {
	exit; // Exit if accessed directly
}

// Enqueue block assets
function tynevags_results_block_enqueue_assets() {
	wp_enqueue_script(
		'tynevags-results-block',
		plugins_url( 'build/index.js', __FILE__ ),
		array( 'wp-blocks', 'wp-element', 'wp-editor', 'wp-components', 'wp-i18n' ),
		'0.1.0',
		true
	);
	wp_enqueue_style(
		'tynevags-results-block-style',
		plugins_url( 'build/style-index.css', __FILE__ ),
		array(),
		'0.1.0'
	);
}
add_action( 'enqueue_block_editor_assets', 'tynevags_results_block_enqueue_assets' );
add_action( 'enqueue_block_assets', 'tynevags_results_block_enqueue_assets' );

// Register block
function tynevags_results_block_register() {
	register_block_type( __DIR__ . '/build', array(
		'render_callback' => 'tynevags_results_block_render',
	) );
}
add_action( 'init', 'tynevags_results_block_register' );

// Render callback for dynamic results block
function tynevags_results_block_render( $attributes, $content ) {
	global $wpdb;
	$view = 'race_links_view';
	$results = $wpdb->get_results( "SELECT * FROM $view ORDER BY date DESC" );
	if ( empty( $results ) ) {
		return '<div class="tynevags-results-block">No results found.</div>';
	}

	$output = '<div class="tynevags-results-block">';
	$current_year = null;
	$latest = true;
	foreach ( $results as $row ) {
		$year = date( 'Y', strtotime( $row->date ) );
		if ( $year !== $current_year ) {
			if ( $current_year !== null ) {
				$output .= '</ul>';
			}
			$output .= '<h3 class="tynevags-results-block__year">' . esc_html( $year ) . '</h3><ul class="tynevags-results-block__list">';
			$current_year = $year;
		}

		// Build filter params from block attributes
		$filter_params = array();
		if ( ! empty( $attributes['filters'] ) && is_array( $attributes['filters'] ) ) {
			foreach ( $attributes['filters'] as $filter ) {
				$col = isset($filter['columnIndex']) ? $filter['columnIndex'] : '';
				$val_key = isset($filter['filterValue']) ? $filter['filterValue'] : '';
				$isEscaped = isset($filter['isEscaped']) ? $filter['isEscaped'] : true;
				$is_range = !empty($filter['isRange']);

				if ( $col && $val_key && isset($row->{$val_key}) ) {
					if ( $isEscaped ) {
						$value = rawurlencode( $row->{$val_key} );
					} else {
						$value = $row->{$val_key};
					}

					if ( $is_range ) {
						$value = $value . '|' . $value;
					}
					$filter_params[ intval($col) ] = $value;
				}
			}
		}

		// Use selected results page or fallback to current permalink
		$results_page_url = '';
		if ( ! empty( $attributes['resultsPage'] ) ) {
			$results_page_url = get_permalink( $attributes['resultsPage'] );
		}
		if ( ! $results_page_url ) {
			$results_page_url = get_permalink();
		}

		// Build the query string manually to avoid encoding square brackets
		$query_string = '';
		if ( ! empty( $filter_params ) ) {
			$pairs = array();
			foreach ( $filter_params as $key => $value ) {
				$pairs[] = 'wdt_column_filter[' . $key . ']' . '=' . $value;
			}
			$query_string = implode( '&', $pairs );
		}
		$link_url = $results_page_url;
		if ( $query_string ) {
			$link_url .= ( strpos( $results_page_url, '?' ) === false ? '?' : '&' ) . $query_string;
		}

		$link_text = date( 'jS M Y', strtotime( $row->date ) ) . ' - ' . esc_html( $row->distance ) . ' Mile ' . esc_html( $row->event_type ) . ' (' . esc_html( $row->course ) . ')';
		$output .= '<li>';
		if ( $latest ) {
			$output .= '<strong>LATEST: </strong>';
			$latest = false;
		}
		$output .= '<a href="' . $link_url . '">' . esc_html( $link_text ) . '</a></li>';
	}
	$output .= '</ul></div>';
	return $output;
}
