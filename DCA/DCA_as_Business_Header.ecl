IMPORT Business_Header,Business_HeaderV2;

EXPORT DCA_as_Business_Header := fDCA_as_Business_Header(Business_HeaderV2.Source_Files.DCA.BusinessHeader)
	: PERSIST(business_header._dataset().thor_cluster_Persists +  'persist::dca::DCA_as_Business_Header');