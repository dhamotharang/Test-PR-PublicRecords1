#OPTION('multiplePersistInstances',FALSE);
import business_header, infousa, ut, address,Business_HeaderV2;

EXPORT DEADCO_as_Business_Header
	:= fDEADCO_as_Business_Header(Business_HeaderV2.Source_Files.infousa_deadco.BusinessHeader)
	: PERSIST(business_header._dataset().thor_cluster_Persists + 'persist::InfoUSA::DEADCO_as_Business_Header')
	;
