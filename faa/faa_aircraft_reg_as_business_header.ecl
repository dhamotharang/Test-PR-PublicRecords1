#OPTION('multiplePersistInstances',FALSE);
import business_headerV2,business_header, ut;

export faa_aircraft_reg_as_business_header
	:= fFAA_aircraft_reg_as_business_header(Business_HeaderV2.Source_Files.faa_aircraft.BusinessHeader)
	: persist(business_header._dataset().thor_cluster_Persists + 'persist::faa::faa_aircraft_reg_as_business_header');