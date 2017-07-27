IMPORT Business_Header,Business_HeaderV2;

EXPORT Gong_As_Business_Contact := fGong_As_Business_Contact(Business_HeaderV2.Source_Files.gong_current.BusinessHeader)
	: PERSIST(business_header._dataset().thor_cluster_Persists + 'persist::Gong::Gong_As_Business_Contact');