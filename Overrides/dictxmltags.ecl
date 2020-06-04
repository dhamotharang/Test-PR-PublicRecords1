EXPORT dictXMLTags(string filetype = '') := module
	export rowtag := map(filetype = 'test' => 'test'
												,'row');
	export headtag := map(filetype = 'bankrupt_main' => 'bk_filings'
												,filetype = 'bankrupt_search' => 'bk_search'
												,filetype = 'liensv2_main' => 'lien_main'
												,filetype = 'liensv2_party' => 'lien_party'
												,'dataset');
end;