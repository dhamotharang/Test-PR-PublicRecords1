#OPTION('multiplePersistInstances',FALSE);
import ut, Business_Header,Business_HeaderV2; 

export Calbus_As_Business_Header := 
	fCalbus_As_Business_Header(Business_HeaderV2.Source_Files.Calbus.BusinessHeader)
	: persist(Business_Header._Dataset().thor_cluster_Persists + 'persist::Calbus::Calbus_As_Business_Header');
