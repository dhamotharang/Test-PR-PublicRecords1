import business_headerV2,Business_Header;

EXPORT DNB_FEIN_As_Business_Header := fDNB_FEIN_As_Business_Header(Business_HeaderV2.Source_Files.dnb_fein.BusinessHeader) 
	: persist(business_header._dataset().thor_cluster_Persists + 'persist::DNB::DNB_FEIN_As_Business_Header');