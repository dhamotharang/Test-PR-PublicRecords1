#OPTION('multiplePersistInstances',FALSE);
IMPORT govdata;

EXPORT CA_Sales_Tax_As_Business_Linking := fCA_Sales_Tax_As_Business_Linking(govdata.File_CA_Sales_Tax_BDID)
	: PERSIST(PersistNames.AsBusinessLinking.CA_Sales_Tax);
