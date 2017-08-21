#OPTION('multiplePersistInstances',FALSE);
import business_header,business_headerv2;

export Bankruptv2_As_Business_Header := fBankruptv2_As_Business_Header(Business_HeaderV2.Source_Files.bankruptcy_search.BusinessHeader, Business_HeaderV2.Source_Files.bankruptcy_main.BusinessHeader) 
	: persist(business_header._dataset().thor_cluster_Persists + 'persist::Bankruptcyv2::Bankruptv2_As_Business_Header');