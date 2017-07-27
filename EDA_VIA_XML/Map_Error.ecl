export Map_Error(UNSIGNED2 err_v) := FUNCTION

return MAP(err_v=0 => dataset([], EDA_VIA_XML.Layout_Error_Response),
					 err_v=2003 => dataset([{2003, 'Query Type Required', 'The request must specify a query type: "residential," "businessOrGovernment," or "powerSearch".'}], EDA_VIA_XML.Layout_Error_Response),
					 err_v=2004 => dataset([{2004, 'State Required', 'The request must contain a state abbreviation or the word "all" to perform a query.'}], EDA_VIA_XML.Layout_Error_Response),
					 err_v=2100 => dataset([{2100, 'Invalid Query Type', 'The request must specify a query type equal to: "residential," "businessOrGovernment," or "powerSearch".'}], EDA_VIA_XML.Layout_Error_Response),
					 err_v=2101 => dataset([{2101, 'Invalid First Initial', 'The first initial field must contain a "yes" or "no".'}], EDA_VIA_XML.Layout_Error_Response),
					 err_v=2102 => dataset([{2102, 'Invalid Suppressed Value', 'The suppressed field must contain a "yes" or "no".'}], EDA_VIA_XML.Layout_Error_Response),
					 err_v=2104 => dataset([{2104, 'Invalid Surround Miles', 'The surrounding area field must contain 0, 10, 25, 50, or 100.'}], EDA_VIA_XML.Layout_Error_Response),
					 err_v=2106 => dataset([{2106, 'Invalid Start Row', 'The request specified an invalid start row. Start row must be greater than or equal to 1 and the start row cannot be greater than the total matched result rows.'}], EDA_VIA_XML.Layout_Error_Response),
					 err_v=2107 => dataset([{2107, 'Malformed Rows Requested', 'The rows requested field must contain only numeric values.'}], EDA_VIA_XML.Layout_Error_Response),
					 err_v=2108 => dataset([{2108, 'Maximum Rows Request Exceeded', 'The maximum number of rows requested is 1000 per result set.'}], EDA_VIA_XML.Layout_Error_Response),
					 err_v=2109 => dataset([{2109, 'Invalid Business or Government Name Criteria', 'The Business or Government Name Criteria does not support wildcards.'}], EDA_VIA_XML.Layout_Error_Response),
					 err_v=2110 => dataset([{2110, 'Invalid First Name Criteria', 'The First Name Criteria does not support wildcards.'}], EDA_VIA_XML.Layout_Error_Response),
					 err_v=2111 => dataset([{2111, 'Invalid Last Name Criteria', 'The Last Name Criteria did not meet the required wildcard (*) formatting. 3 or more characters must precede the first wildcard and no more than one wildcard can be used consecutively.'}], EDA_VIA_XML.Layout_Error_Response),
					 err_v=2112 => dataset([{2112, 'Invalid State', 'The request specified an invalid state. The request must contain a state abbreviation or the word "all" to perform a query.'}], EDA_VIA_XML.Layout_Error_Response),
					 err_v=2118 => dataset([{2118, 'Invalid Use of Surround Miles', 'To utilize the surrounding miles search criteria, the city and state fields must be entered.'}], EDA_VIA_XML.Layout_Error_Response),
					 err_v=2119 => dataset([{2119, 'Invalid Street Address Criteria', 'The Street Address Criteria does not support wildcards.'}], EDA_VIA_XML.Layout_Error_Response),
					 err_v=2120 => dataset([{2120, 'Invalid City Name Criteria', 'The City Name Criteria does not support wildcards.'}], EDA_VIA_XML.Layout_Error_Response),
					 err_v=2121 => dataset([{2121, 'Invalid WildCard Criteria', 'To make an all-state search, no wildcards may be used in any field.'}], EDA_VIA_XML.Layout_Error_Response),
					 dataset([{err_v, '', ''}], EDA_VIA_XML.Layout_Error_Response));
END;