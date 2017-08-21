import data_services;

EXPORT Key_Parsed_Phone_EID(string v = 'qa', boolean isDelta = false) := MODULE

	SHARED	R_V1 := RECORD
		STRING23 eid;
		STRING12 Phone;
	END;	

	SHARED	R_V2 := RECORD
		R_V1;
		Boolean	Iscurrent;
	END;
		
	SHARED	PREFIX := data_services.Data_location.Prefix('BAIR');
	
	SHARED	D_V1	:= DATASET([], R_V1);
	SHARED	D_V2	:= DATASET([], R_V2);

	EXPORT V1:= INDEX(D_V1,{eid},{D_V1}, PREFIX+'thor_data400::key::bair_composite::mo::' +if(isDelta,'delta::','') +v +'::eid',opt);
	EXPORT V2:= INDEX(D_V2,{eid},{D_V2}, PREFIX+'thor_data400::key::bair_composite::mo::v2::' +if(isDelta,'delta::','') +v +'::eid',opt);

END;  

