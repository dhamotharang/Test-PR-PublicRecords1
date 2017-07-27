IMPORT Business_Header, ut,Business_HeaderV2;

export As_Business_Contact := 
	fDiverCert_As_Business_Contact(Business_HeaderV2.Source_Files.Diversity_Certification.BusinessHeader)
	: persist(Business_Header._Dataset().thor_cluster_Persists + 'persist::Diversity_Certification.::DiverCert_As_Business_Contact');
