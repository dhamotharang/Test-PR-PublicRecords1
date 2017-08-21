IMPORT Business_Header,Business_HeaderV2;

EXPORT DNB_As_Business_Header := fDNB_As_Business_Header(Business_HeaderV2.Source_Files.dnb_companies.BusinessHeader)
	: PERSIST(business_header._dataset().thor_cluster_Persists + 'persist::DNB::DNB_As_Business_Header');