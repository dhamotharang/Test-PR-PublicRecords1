#OPTION('multiplePersistInstances',FALSE);
import business_header,business_headerv2;

export ATF_As_Business_Header := ATF.fATF_as_Business_Header(Business_HeaderV2.Source_Files.atf.BusinessHeader) 
	: persist(business_header._dataset().thor_cluster_Persists + 'persist::atf::ATF_As_Business_Header');