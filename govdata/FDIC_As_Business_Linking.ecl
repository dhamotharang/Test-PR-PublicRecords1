#OPTION('multiplePersistInstances',FALSE);
IMPORT business_headerV2, ut;

EXPORT FDIC_As_Business_Linking := fFDIC_As_Business_Linking(File_FDIC_Base_AID)
	: PERSIST(PersistNames.AsBusinessLinking.FDIC);