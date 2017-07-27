#workunit('Name','deSpray company name token patterns and vanity names');
varstring token_patterns_filename := 'thumphrey::temp::company_name_token_patterns::XML';
FileServices.DeSpray(
    token_patterns_filename
		,'10.140.128.250'
    ,'/data/thumphrey/thumphrey/company_name_token_patterns_xml'
    ,-1,,,true);


varstring vanity_filename := 'thumphrey::temp::vanity_company_names::XML';
FileServices.DeSpray(
    vanity_filename
		,'10.140.128.250'
    ,'/data/thumphrey/thumphrey/vanity_company_names_xml'
    ,-1,,,true);
