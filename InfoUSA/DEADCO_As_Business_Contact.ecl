#OPTION('multiplePersistInstances',FALSE);
import business_header, infousa, ut,Business_HeaderV2;

export DEADCO_as_Business_Contact
	:= fDEADCO_as_Business_Contact(Business_HeaderV2.Source_Files.infousa_deadco.BusinessHeader)
	: PERSIST(business_header._dataset().thor_cluster_Persists + 'persist::InfoUSA::DEADCO_as_Business_Contact')
	;