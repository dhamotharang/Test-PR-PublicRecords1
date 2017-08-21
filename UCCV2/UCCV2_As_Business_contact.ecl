#OPTION('multiplePersistInstances',FALSE);
IMPORT ut, Business_Header, uccd,business_headerv2;

EXPORT UCCV2_As_Business_contact:= fUCCV2_As_Business_Contact(Business_HeaderV2.Source_Files.ucc_party.BusinessHeader)
	                               : persist(business_header._dataset().thor_cluster_Persists + 'persist::UCCV2::UCCV2_As_Business_Contact');
	

