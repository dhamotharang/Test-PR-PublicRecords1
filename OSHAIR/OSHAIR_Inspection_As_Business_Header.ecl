import business_header,business_headerv2;

export OSHAIR_Inspection_As_Business_Header := 
	OSHAIR.fCleaned_OSHAIR_Inspection_As_Business_Header(business_headerv2.Source_Files.oshair.BusinessHeader)
	: persist(business_header._Dataset().thor_cluster_files + 'persist::OSHAIR::OSHAIR_Inspection_As_Business_Header');