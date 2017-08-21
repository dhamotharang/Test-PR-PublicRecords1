#OPTION('multiplePersistInstances',FALSE);
IMPORT business_headerV2,business_header, ut;

EXPORT faa_aircraft_reg_as_business_linking
	:= fFAA_aircraft_reg_as_business_linking(file_aircraft_registration_out)
	: PERSIST(business_header._dataset().thor_cluster_Persists + 'persist::faa::faa_aircraft_reg_as_business_linking');