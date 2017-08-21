#OPTION('multiplePersistInstances',FALSE);
import Business_Header,Business_HeaderV2;

export  ACF_As_Business_Header:= fACF_As_Business_Header(Business_HeaderV2.Source_Files.acf.BusinessHeader) 
	: persist(business_header._dataset().thor_cluster_Persists + 'persist::ACF::acf_As_Business_Header');