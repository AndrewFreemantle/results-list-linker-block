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
	// Placeholder: fetch and display results dynamically
	return '<div class="tynevags-results-block">Results will appear here. (Dynamic output coming soon.)</div>';
}
