#OPTION('multiplePersistInstances',FALSE);
import ut, business_header,Business_HeaderV2;

EXPORT ATF_As_Business_Contact := 
	fATF_as_Business_Contact(Business_HeaderV2.Source_Files.atf.BusinessHeader) 
		: PERSIST(business_header._dataset().thor_cluster_Persists + 'persist::atf::atf_As_Business_Contact');
