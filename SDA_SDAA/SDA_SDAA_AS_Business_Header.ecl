#OPTION('multiplePersistInstances',FALSE);
import Business_Header,Business_HeaderV2;

export  SDA_SDAA_As_Business_Header:= fSDA_As_Business_Header(Business_HeaderV2.Source_Files.sda.BusinessHeader+Business_HeaderV2.Source_Files.sdaa.BusinessHeader) 
	                                 : persist(business_header._dataset().thor_cluster_Persists + 'persist::SDA_sdaa_As_Business_Header');