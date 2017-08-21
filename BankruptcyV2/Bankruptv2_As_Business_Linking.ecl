#OPTION('multiplePersistInstances',FALSE);
IMPORT business_header,business_headerv2;

EXPORT Bankruptv2_As_Business_Linking := fBankruptv2_As_Business_Linking(file_bankruptcy_search_v3_supp_bip, file_bankruptcy_main) 
	: PERSIST(business_header._dataset().thor_cluster_Persists + 'persist::Bankruptcyv2::Bankruptv2_As_Business_Linking');