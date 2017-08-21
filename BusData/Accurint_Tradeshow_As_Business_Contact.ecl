#OPTION('multiplePersistInstances',FALSE);
import Business_Header,Business_HeaderV2;
export Accurint_Tradeshow_As_Business_Contact := fAccurint_Tradeshow_As_Business_Contact() 
	: persist(business_header._dataset().thor_cluster_Persists + 'persist::Busdata::Accurint_Tradeshow_As_Business_Contact') ;