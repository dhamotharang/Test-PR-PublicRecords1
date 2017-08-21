IMPORT business_header,business_headerv2, ut, OSHAIR;

EXPORT Cleaned_OSHAIR_Inspection_As_Business_Linking := 
	fCleaned_OSHAIR_Inspection_As_Business_Linking(OSHAIR.file_out_inspection_cleaned_both)
	  	: PERSIST(business_header._Dataset().thor_cluster_files + 'persist::OSHAIR::OSHAIR_Inspection_As_Business_Linking');

