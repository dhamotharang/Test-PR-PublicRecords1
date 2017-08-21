#OPTION('multiplePersistInstances',FALSE);
import business_headerV2,business_header;

export Edgar_As_Business_Header := fEdgar_As_Business_Header(Business_HeaderV2.Source_Files.edgar_company.BusinessHeader) 
	: persist(business_header._dataset().thor_cluster_Persists + 'persist::Edgar::Edgar_As_Business_Header');