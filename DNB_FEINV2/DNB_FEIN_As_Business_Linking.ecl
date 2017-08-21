#OPTION('multiplePersistInstances',FALSE);
import business_header,Business_HeaderV2;
EXPORT DNB_FEIN_As_Business_Linking := DNB_FEINV2.fDNB_FEIN_As_Business_Linking(DNB_FEINV2.File_DNB_Fein_base_main_new)
   	: PERSIST(business_header.Bus_Thor() + 'persist::DNB_FEINV2::DNB_FEIN_As_Business_Header_Linking');
		
	

/* 
	EXPORT DNB_FEIN_As_Business_Linking := DNB_FEINV2.fDNB_FEIN_As_Business_Linking(Business_HeaderV2.Source_Files.dnb_feinv2.businessheader)
   	: persist(business_header._dataset().thor_cluster_Persists + 'persist::DNB_FEINV2::As_Business_Header_Linking');

*/