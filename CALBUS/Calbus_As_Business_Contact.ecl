#OPTION('multiplePersistInstances',FALSE);
IMPORT Business_Header, ut,Business_HeaderV2;

export Calbus_As_Business_Contact := 
	fCalbus_As_Business_Contact(Business_HeaderV2.Source_Files.Calbus.BusinessHeader)
	: persist(Business_Header._Dataset().thor_cluster_Persists + 'persist::Calbus::Calbus_As_Business_Contact');
