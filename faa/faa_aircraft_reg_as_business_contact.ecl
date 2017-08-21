#OPTION('multiplePersistInstances',FALSE);
import business_header,Business_HeaderV2;

export faa_aircraft_reg_as_business_contact
	:= fFAA_aircraft_reg_as_business_contact(Business_HeaderV2.Source_Files.faa_aircraft.BusinessHeader)
	: persist(business_header._dataset().thor_cluster_Persists + 'persist::faa::faa_aircraft_reg_as_business_contact')
	;