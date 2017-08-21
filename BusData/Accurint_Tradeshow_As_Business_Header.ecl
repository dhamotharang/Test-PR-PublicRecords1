#OPTION('multiplePersistInstances',FALSE);
import business_header;
export Accurint_Tradeshow_As_Business_Header := fAccurint_Tradeshow_As_Business_Header()
	 : PERSIST(business_header._dataset().thor_cluster_persists + 'persist::Busdata::Accurint_Tradeshow_As_Business_Header');