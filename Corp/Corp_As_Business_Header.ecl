#OPTION('multiplePersistInstances',FALSE);
export Corp_As_Business_Header := fCorp_As_Business_Header(File_Corp_Base(Filters.As_Business.Corp_Base))  
	: persist(Thor_cluster + 'persist::Corp::Corp_As_Business_Header');