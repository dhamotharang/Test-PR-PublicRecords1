#OPTION('multiplePersistInstances',FALSE);
import business_header,business_headerv2,ut;

export OneKey_As_Business_Linking := fOneKey_As_Business_Linking(OneKey.Files().Base.qa) 
	: persist(business_header._dataset().thor_cluster_Persists +  'persist::OneKey::OneKey_As_Business_Linking');
