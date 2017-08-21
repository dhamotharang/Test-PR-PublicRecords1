#OPTION('multiplePersistInstances',FALSE);
export AMS_As_Business_Header := fAMS_As_Business_Header(Files().Base.Main.BusinessHeader)
	: PERSIST(PersistNames.AsBusinessHeader);
