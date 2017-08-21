#OPTION('multiplePersistInstances',FALSE);
IMPORT business_header, infousa, ut, address,Business_HeaderV2;

EXPORT DEADCO_As_Business_Linking
	:= fDEADCO_as_Business_Linking(InfoUSA.File_Deadco_Base_AID)
	: PERSIST(business_header._dataset().thor_cluster_Persists + 'persist::InfoUSA::DEADCO_as_Business_Linking');
