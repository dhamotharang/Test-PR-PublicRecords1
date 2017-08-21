#OPTION('multiplePersistInstances',FALSE);
IMPORT Business_Header, ut,Business_HeaderV2;

export ABIUS_Executive_As_Business_Contact
	:= fABIUS_Executive_As_Business_Contact(Business_HeaderV2.Source_Files.abius.BusinessHeader)
	: PERSIST(business_header._dataset().thor_cluster_Persists + 'persist::InfoUSA::ABIUS_Executive_As_Business_Contact')
	;