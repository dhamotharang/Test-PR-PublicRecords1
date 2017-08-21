#OPTION('multiplePersistInstances',FALSE);
IMPORT ut, Business_Header,Business_HeaderV2;


export Edgar_As_Business_Contact := fEdgar_As_Business_Contact(Business_HeaderV2.Source_Files.edgar_contacts.BusinessHeader) 
	: PERSIST(business_header._dataset().thor_cluster_Persists + 'persist::Edgar::Edgar_As_Business_Contact');