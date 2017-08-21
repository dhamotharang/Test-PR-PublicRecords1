#OPTION('multiplePersistInstances',FALSE);
IMPORT LN_PropertyV2, Business_Header;

EXPORT LN_Propertyv2_as_Business_Linking := fLN_Propertyv2_as_Business_Linking(
       File_Search_DID
	    ,Files.base.DeedMortgage	
	    ,Files.base.Assessment
	    ,File_addl_fares_deed
      ,File_addl_Fares_tax)
     : PERSIST(business_header._dataset().thor_cluster_Persists + 'persist::LN_Propertyv2::LN_Propertyv2_as_Business_Linking');

