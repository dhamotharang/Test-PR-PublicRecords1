#OPTION('multiplePersistInstances',FALSE);
IMPORT business_headerV2;

EXPORT EBR_As_Business_Linking := EBR.fEBR_As_Business_Linking(EBR.File_0010_Header_Base_AID,EBR.File_5610_Demographic_Data_Base)
	: PERSIST(EBR.cluster.cluster_out + 'persist::' + EBR.dataset_name + '::EBR_as_Business_Linking');