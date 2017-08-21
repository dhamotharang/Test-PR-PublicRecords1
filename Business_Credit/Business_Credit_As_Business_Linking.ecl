#OPTION('multiplePersistInstances',FALSE);
IMPORT	Business_Credit,	business_header,	business_headerv2;
EXPORT	Business_Credit_As_Business_Linking	:=
	fBusiness_Credit_As_Business_Linking(Business_Credit.Files().LinkIDs(active))	:	PERSIST(PersistNames.AsBusLinking);
 