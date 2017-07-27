import ut, Business_Header,Business_HeaderV2; 

export As_Business_Header := 
	fDiverCert_As_Business_Header(Business_HeaderV2.Source_Files.Diversity_Certification.BusinessHeader)
	: persist(Business_Header._Dataset().thor_cluster_Persists + 'persist::Diversity_Certification.::DiverCert_As_Business_Header');
