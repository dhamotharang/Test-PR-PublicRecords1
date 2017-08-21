#OPTION('multiplePersistInstances',FALSE);
IMPORT Business_Header,Business_HeaderV2, ut, IRS5500;

EXPORT IRS5500_As_Business_Linking 
	:= fIRS5500_As_Business_Linking(IRS5500.File_IRS5500_Base_AID)
	: PERSIST(business_header._dataset().thor_cluster_Persists + 'persist::IRS5500::IRS5500_As_Business_Linking');

