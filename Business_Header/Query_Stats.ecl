import statistics;

export Query_Stats :=
module

	export Business_Contacts_DID(
	
	 dataset(Statistics.Layouts.standard_stat_out) pStatFiles = business_header.Files().stat.contacts.qa
	
	) := Statistics.Query_Stats
	(
		 pStatFiles																:= pStatFiles
		,pBuild_Name_Filter												:= ''
		,pVersion_Filter													:= 'latest'
		,pBuild_Subset_Filter											:= '^Business Contacts Base$'
		,pBuild_View_Filter												:= '^did$'
		,pBuild_Type_Filter												:= '^$'
	);

	export Business_Contacts_Sources(
	
	 dataset(Statistics.Layouts.standard_stat_out) pStatFiles = business_header.Files().stat.contacts.qa
	
	) := Statistics.Query_Stats
	(
		 pStatFiles																:= pStatFiles
		,pBuild_Name_Filter												:= ''
		,pVersion_Filter													:= 'latest'
		,pBuild_Subset_Filter											:= '^Business Contacts Base$'
		,pBuild_View_Filter												:= '^source$'
		,pBuild_Type_Filter												:= '^$'
	);

	export Business_Contacts_Source_by_DID(
	
	 dataset(Statistics.Layouts.standard_stat_out) pStatFiles = business_header.Files().stat.contacts.qa
	
	) := Statistics.Query_Stats
	(
		 pStatFiles																:= pStatFiles
		,pBuild_Name_Filter												:= ''
		,pVersion_Filter													:= 'latest'
		,pBuild_Subset_Filter											:= '^Business Contacts Base$'
		,pBuild_View_Filter												:= '^did$'
		,pBuild_Type_Filter												:= '^source$'
	);

	export Business_Header_Sources(
	
	 dataset(Statistics.Layouts.standard_stat_out) pStatFiles = business_header.Files().stat.search.qa
	
	) := Statistics.Query_Stats
	(
		 pStatFiles																:= pStatFiles
		,pBuild_Name_Filter												:= ''
		,pVersion_Filter													:= 'latest'
		,pBuild_Subset_Filter											:= '^Business Header Base$'
		,pBuild_View_Filter												:= '^source$'
		,pBuild_Type_Filter												:= '^$'
	);

end;