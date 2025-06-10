---
mode: 'agent'
tools: [ 'perplexity_ask' ]
description: 'Research an idea'
---

Perform an indepth analysis of the provided idea:

WordPress Plugin that creates block of links to a single results page with filter parameters in the URL that is built from a database query.

The data is date-based, and the resulting block should be in reverse chronological order, using headings to organise the results.

The headings are years.
Under each year, the link text should take the format: "{date} - {distance} Mile {event_type} ({course})". The values for these fields are from the results of the database query.
The link URL should take the format: "{results_page_url}" which is selected by the user from a dropdown in the block settings of the site's pages.
Additionally, the block should have a settings panel that allows for multiple key-value pairs of filter parameters to be added to the URL:
- the key is an integer labelled 'Column Index'
- the value is a string labelled 'Filter Value' and is a placeholder for the filter value, which will be replaced by the plugin from the database query results for each link generated.
- for each key-value pair, there should be a checkbox option labelled 'Range' - this is needed to indicate whether the filter value should be treated as a range or not.
As an example, the URL might look like this, where column3 is a Range: "/{results_page_url}?wpd_filter_column[{column1}]={value1}&wpd_filter_column[{column2}]={value2}&wpd_filter_column[{column3}]={value3}|{value3}".
Additionally, only the first link should contain the prefix: 'LATEST: '.

The plugin block should appear in the block editor, allowing users to add it to their pages and be compatible with Neve and Elementor. The block should be responsive and work well on both desktop and mobile devices.

Rules:
- Clarify any details that might be helpful before starting to research my idea.
- Start your session with me by doing some research using the #tool:f1e_perplexity_ask. Look for information that may inform my user base, problem statements and features.
- Summarize your findings that might be relevant to me before beginning the next step.
- Perform another research loop if asked.

Include the following pivots in your research:
-Users
-Problem statements
-Unmet needs

WHEN DONE, output to #file:../../docs/plans/research.md.