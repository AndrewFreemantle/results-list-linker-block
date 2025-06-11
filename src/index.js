import './style.css';
import { registerBlockType } from '@wordpress/blocks';
import { __ } from '@wordpress/i18n';
import { useBlockProps, InspectorControls } from '@wordpress/block-editor';
import { PanelBody, TextControl, SelectControl } from '@wordpress/components';
import { useState } from '@wordpress/element';
import { useSelect } from '@wordpress/data';
import { store as coreStore } from '@wordpress/core-data';

registerBlockType('results-list-linker/results-block', {
    apiVersion: 2,
    title: __('Results List Linker Block', 'results-list-linker-block'),
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
                    isEscaped: { type: 'boolean', default: true },
                },
            },
        },
    },
    edit: (props) => {
        const { attributes, setAttributes } = props;
        const blockProps = useBlockProps();
        const [filterPairs, setFilterPairs] = useState(attributes.filters || []);

        // Fetch pages from WordPress
        const pages = useSelect(
            (select) => select(coreStore).getEntityRecords('postType', 'page', { per_page: 100 }),
            []
        );
        const isLoadingPages = pages === undefined;
        const pageOptions = isLoadingPages
            ? [{ label: 'Loading...', value: '' }]
            : [
                { label: 'Select a page', value: '' },
                ...pages.map((page) => ({ label: page.title.rendered || page.slug, value: page.id }))
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
                    <PanelBody title={__('Block Settings', 'results-list-linker-block')} initialOpen={true}>
                        <SelectControl
                            label={__('Results Page', 'results-list-linker-block')}
                            value={attributes.resultsPage}
                            options={pageOptions}
                            onChange={(value) => setAttributes({ resultsPage: value })}
                        />
                    </PanelBody>
                    <PanelBody title={__('Filter Parameters', 'results-list-linker-block')} initialOpen={true}>
                        {filterPairs.map((filter, idx) => (
                            <div key={idx} style={{ borderBottom: '1px solid #eee', marginBottom: 8, paddingBottom: 8 }}>
                                <TextControl
                                    label={__('Column Index', 'results-list-linker-block')}
                                    type="number"
                                    value={filter.columnIndex}
                                    onChange={(value) => updateFilter(idx, 'columnIndex', value)}
                                />
                                <TextControl
                                    label={__('Filter Value', 'results-list-linker-block')}
                                    value={filter.filterValue}
                                    onChange={(value) => updateFilter(idx, 'filterValue', value)}
                                />
                                <label style={{ display: 'block', marginTop: 4 }}>
                                    <input
                                        type="checkbox"
                                        checked={!!filter.isRange}
                                        onChange={(e) => updateFilter(idx, 'isRange', e.target.checked)}
                                    />{' '}
                                    {__('Range', 'results-list-linker-block')}
                                </label>
                                <label style={{ display: 'block', marginTop: 4 }}>
                                    <input
                                        type="checkbox"
                                        checked={!!filter.isEscaped}
                                        onChange={(e) => updateFilter(idx, 'isEscaped', e.target.checked)}
                                    />{' '}
                                    {__('Escaped', 'results-list-linker-block')}
                                </label>
                                <button type="button" onClick={() => removeFilter(idx)} style={{ marginTop: 4 }}>
                                    {__('Remove', 'results-list-linker-block')}
                                </button>
                            </div>
                        ))}
                        <button type="button" onClick={addFilter} style={{ marginTop: 8 }}>
                            {__('Add Filter', 'results-list-linker-block')}
                        </button>
                    </PanelBody>
                </InspectorControls>
                <div {...blockProps}>
                    <strong>{__('Results Block', 'results-list-linker-block')}</strong>
                    <p>{__('Results will be rendered dynamically on the frontend.', 'results-list-linker-block')}</p>
                </div>
            </>
        );
    },
    save: () => null, // Server-side rendering
});
