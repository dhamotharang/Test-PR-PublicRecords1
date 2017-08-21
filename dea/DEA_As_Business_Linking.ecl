#OPTION('multiplePersistInstances',FALSE);
IMPORT business_header,dea;

EXPORT DEA_As_Business_Linking
	:= DEA.fDEA_As_Business_Linking(DEA.File_DEAv2) 
	   : PERSIST(business_header._dataset().thor_cluster_Persists + 'persist::DEA::DEA_As_Business_Linking');