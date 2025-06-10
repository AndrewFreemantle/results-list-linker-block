<?php
/*
Plugin Name: Tynevags Results Block
Description: Adds a block to display event results with advanced filtering, year grouping, and compatibility with Neve and Elementor.
Version: 0.1.0
Author: Your Name
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
		plugins_url( 'build/style.css', __FILE__ ),
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
	$view = $wpdb->prefix . 'race_links_view';
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
			$output .= '<h3>' . esc_html( $year ) . '</h3><ul>';
			$current_year = $year;
		}
		$link_text = date( 'j M', strtotime( $row->date ) ) . ' - ' . esc_html( $row->distance ) . ' Mile ' . esc_html( $row->event_type ) . ' (' . esc_html( $row->course ) . ')';
		$link_url = add_query_arg( array(
			'date' => date( 'Ymd', strtotime( $row->date ) ),
			'distance' => $row->distance,
			'event_type' => $row->event_type,
			'course' => $row->course,
		), get_permalink() );
		$output .= '<li>';
		if ( $latest ) {
			$output .= '<strong>LATEST: </strong>';
			$latest = false;
		}
		$output .= '<a href="' . esc_url( $link_url ) . '">' . esc_html( $link_text ) . '</a></li>';
	}
	$output .= '</ul></div>';
	return $output;
}
