<?php
/*
Plugin Name: Results List Linker Block
Description: WordPress block plugin for displaying a list of results as links.
Version: 0.1.8
Author: Andrew Freemantle
Author URI: https://github.com/AndrewFreemantle/results-list-linker-block
*/

// NOTE: The following code must be run within a WordPress environment.
// If you see 'Undefined function' errors, ensure this file is loaded by WordPress.

if ( ! defined( 'ABSPATH' ) ) {
	exit; // Exit if accessed directly
}

// Add WordPress escaping and permalink functions if not already loaded
if ( ! function_exists( 'esc_html' ) ) {
    require_once ABSPATH . 'wp-includes/formatting.php';
}
if ( ! function_exists( 'esc_attr' ) ) {
    require_once ABSPATH . 'wp-includes/formatting.php';
}
if ( ! function_exists( 'get_permalink' ) ) {
    require_once ABSPATH . 'wp-includes/link-template.php';
}

// Enqueue block assets
function results_list_linker_block_enqueue_assets() {
	wp_enqueue_script(
		'results-list-linker-block',
		plugins_url( 'build/index.js', __FILE__ ),
		array( 'wp-blocks', 'wp-element', 'wp-editor', 'wp-components', 'wp-i18n' ),
		'0.1.6',
		true
	);
	wp_enqueue_style(
		'results-list-linker-block-style',
		plugins_url( 'build/style-index.css', __FILE__ ),
		array(),
		'0.1.6'
	);
}
add_action( 'enqueue_block_editor_assets', 'results_list_linker_block_enqueue_assets' );
add_action( 'enqueue_block_assets', 'results_list_linker_block_enqueue_assets' );

// Register block
function results_list_linker_block_register() {
	register_block_type( __DIR__ . '/build', array(
		'render_callback' => 'results_list_linker_block_render',
	) );
}
add_action( 'init', 'results_list_linker_block_register' );

// Render callback for dynamic results block
function results_list_linker_block_render( $attributes, $content ) {
	global $wpdb;
	$view = 'race_links_view';
	$years = $wpdb->get_results( "SELECT DISTINCT year FROM $view ORDER BY year DESC" );
	if ( empty( $years ) ) {
		return '<div class="results-list-linker-block">No results found.</div>';
	}
	$results = $wpdb->get_results( "SELECT * FROM $view ORDER BY date DESC" );

	// Render button group
	$output = '<div class="results-list-linker-block">';
	$output .= '<div class="results-list-linker-block__year-button-group wp-block-buttons is-layout-flex wp-block-buttons-is-layout-flex">';
	foreach ( $years as $row ) {
		$year = $row->year;
		$output .= '<div class="wp-block-button is-style-default"><a href="#results-year-' . esc_attr( $year ) . '" class="wp-block-button__link has-neve-link-color-color has-nv-light-bg-background-color has-text-color has-background has-link-color has-border-color has-neve-link-color-border-color has-medium-font-size has-custom-font-size wp-element-button" style="border-width:1px;padding-top:0;padding-right:var(--wp--preset--spacing--20);padding-bottom:0;padding-left:var(--wp--preset--spacing--20)">' . esc_html( $year ) . '</a></div>';
	}
	$output .= '</div>';

	$current_year = null;
	$latest = true;
	foreach ( $results as $row ) {
		$year = date( 'Y', strtotime( $row->date ) );
		if ( $year !== $current_year ) {
			if ( $current_year !== null ) {
				$output .= '</ul>';
			}
			$output .= '<h2 id="results-year-' . esc_attr( $year ) . '" class="results-list-linker-block__year">' . esc_html( $year ) . '</h2><ul class="results-list-linker-block__list">';
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

		$link_text = date( 'jS M Y', strtotime( $row->date ) ) . ' - ' . esc_html( $row->miles ) . ' Mile ' . esc_html( $row->event_type ) . ' (' . esc_html( $row->course ) . ')';
		$output .= '<li>';
		if ( $latest ) {
			$output .= '<span class="latest-heading">LATEST:</span>';
			$latest = false;
		}
		$output .= '<a href="' . $link_url . '">' . esc_html( $link_text ) . '</a></li>';
	}
	$output .= '</ul></div>';
	return $output;
}
?>
