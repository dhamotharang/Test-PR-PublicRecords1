#OPTION('multiplePersistInstances',FALSE);

EXPORT IRS_Non_Profit_As_Business_Linking := fIRS_Non_Profit_As_Business_Linking(File_IRS_NonProfit_Base_AID)
	: PERSIST(PersistNames.AsBusinessLinking.IRS_Non_Profit);
