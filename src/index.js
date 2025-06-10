import './style.css';
import { registerBlockType } from '@wordpress/blocks';
import { __ } from '@wordpress/i18n';
import { useBlockProps, InspectorControls } from '@wordpress/block-editor';
import { PanelBody, TextControl, SelectControl } from '@wordpress/components';
import { useState } from '@wordpress/element';

registerBlockType('tynevags/results-block', {
    apiVersion: 2,
    title: __('Tynevags Results Block', 'tynevags-results-block'),
    icon: 'awards',
    category: 'widgets',
    attributes: {
        resultsPage: { type: 'string', default: '' },
        filters: {
            type: 'array',
            default: [],
            items: {
                type: 'object',
                properties: {
                    columnIndex: { type: 'integer' },
                    filterValue: { type: 'string' },
                    isRange: { type: 'boolean' },
                },
            },
        },
    },
    edit: (props) => {
        const { attributes, setAttributes } = props;
        const blockProps = useBlockProps();
        const [filterPairs, setFilterPairs] = useState(attributes.filters || []);

        // Placeholder: Replace with dynamic page list fetch if needed
        const pageOptions = [
            { label: 'Select a page', value: '' },
            { label: 'Results Page', value: '/results/' },
            { label: 'Events Page', value: '/events/' },
        ];

        const updateFilter = (index, field, value) => {
            const newFilters = [...filterPairs];
            newFilters[index][field] = value;
            setFilterPairs(newFilters);
            setAttributes({ filters: newFilters });
        };

        const addFilter = () => {
            const newFilters = [...filterPairs, { columnIndex: '', filterValue: '', isRange: false }];
            setFilterPairs(newFilters);
            setAttributes({ filters: newFilters });
        };

        const removeFilter = (index) => {
            const newFilters = filterPairs.filter((_, i) => i !== index);
            setFilterPairs(newFilters);
            setAttributes({ filters: newFilters });
        };

        return (
            <>
                <InspectorControls>
                    <PanelBody title={__('Block Settings', 'tynevags-results-block')} initialOpen={true}>
                        <SelectControl
                            label={__('Results Page', 'tynevags-results-block')}
                            value={attributes.resultsPage}
                            options={pageOptions}
                            onChange={(value) => setAttributes({ resultsPage: value })}
                        />
                        <PanelBody title={__('Filter Parameters', 'tynevags-results-block')} initialOpen={true}>
                            {filterPairs.map((filter, idx) => (
                                <div key={idx} style={{ borderBottom: '1px solid #eee', marginBottom: 8, paddingBottom: 8 }}>
                                    <TextControl
                                        label={__('Column Index', 'tynevags-results-block')}
                                        type="number"
                                        value={filter.columnIndex}
                                        onChange={(value) => updateFilter(idx, 'columnIndex', value)}
                                    />
                                    <TextControl
                                        label={__('Filter Value', 'tynevags-results-block')}
                                        value={filter.filterValue}
                                        onChange={(value) => updateFilter(idx, 'filterValue', value)}
                                    />
                                    <label style={{ display: 'block', marginTop: 4 }}>
                                        <input
                                            type="checkbox"
                                            checked={!!filter.isRange}
                                            onChange={(e) => updateFilter(idx, 'isRange', e.target.checked)}
                                        />{' '}
                                        {__('Range', 'tynevags-results-block')}
                                    </label>
                                    <button type="button" onClick={() => removeFilter(idx)} style={{ marginTop: 4 }}>
                                        {__('Remove', 'tynevags-results-block')}
                                    </button>
                                </div>
                            ))}
                            <button type="button" onClick={addFilter} style={{ marginTop: 8 }}>
                                {__('Add Filter', 'tynevags-results-block')}
                            </button>
                        </PanelBody>
                    </PanelBody>
                </InspectorControls>
                <div {...blockProps}>
                    <strong>{__('Results Block', 'tynevags-results-block')}</strong>
                    <p>{__('Results will be rendered dynamically on the frontend.', 'tynevags-results-block')}</p>
                </div>
            </>
        );
    },
    save: () => null, // Server-side rendering
});
