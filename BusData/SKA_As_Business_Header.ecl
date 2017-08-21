#OPTION('multiplePersistInstances',FALSE);
import business_header,business_headerv2;

export SKA_As_Business_Header := fSKA_As_Business_Header(Business_HeaderV2.Source_Files.ska_verified.BusinessHeader, Business_HeaderV2.Source_Files.SKA_Nixie.BusinessHeader) 
	: persist(business_header._dataset().thor_cluster_Persists +  'persist::Busdata::SKA_As_Business_Header');
