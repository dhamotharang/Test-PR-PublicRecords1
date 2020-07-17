#OPTION('multiplePersistInstances',FALSE);

EXPORT FDIC_As_Business_Linking := fFDIC_As_Business_Linking(File_FDIC_Base_AID)
	: PERSIST(PersistNames.AsBusinessLinking.FDIC);
