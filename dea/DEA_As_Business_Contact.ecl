#OPTION('multiplePersistInstances',FALSE);
import business_header,dea,Business_HeaderV2;

export DEA_As_Business_Contact
	:= DEA.fDEA_As_Business_Contact(Business_HeaderV2.Source_Files.dea.BusinessHeader)
	: persist(business_header._dataset().thor_cluster_Persists + 'persist::DEA::DEA_As_Business_Contact')
	;