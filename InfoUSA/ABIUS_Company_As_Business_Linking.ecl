#OPTION('multiplePersistInstances',FALSE);
IMPORT Business_Header, ut, Business_HeaderV2;

EXPORT ABIUS_Company_As_Business_Linking 
	:= fABIUS_Company_As_Business_Linking(File_ABIUS_Company_Base_AID)
	:  PERSIST(business_header._dataset().thor_cluster_Persists + 
	           'persist::InfoUSA::ABIUS_Company_As_Business_Linking');

