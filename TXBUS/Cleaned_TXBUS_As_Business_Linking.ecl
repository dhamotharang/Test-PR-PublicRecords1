#OPTION('multiplePersistInstances',FALSE);
IMPORT Business_Header,Business_HeaderV2;

EXPORT Cleaned_TXBUS_As_Business_Linking
	:= fCleaned_TXBUS_As_Business_Linking(File_Txbus_Base)
  	: PERSIST(business_header._dataset().thor_cluster_Persists + 'persist::TXBUS::Cleaned_TXBUS_As_Business_Linking');