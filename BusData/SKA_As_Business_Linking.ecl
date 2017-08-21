#OPTION('multiplePersistInstances',FALSE);
import business_header,business_headerv2,ut;

export SKA_As_Business_Linking := fSKA_As_Business_Linking(File_SKA_Verified_Base, File_SKA_Nixie_Base) 
	: persist(business_header._dataset().thor_cluster_Persists +  'persist::Busdata::SKA_As_Business_Linking');
