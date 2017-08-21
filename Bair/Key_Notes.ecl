import Data_Services;

EXPORT Key_Notes(string v='qa', boolean isDelta = false) := MODULE

	R := RECORD,maxlength(150037)
		string23 eid;
		UNSIGNED4 ReferId;
		unsigned1 note_type;
		unsigned1 seq;
		unsigned4 notelen;
		unsigned8 __filepos;
	 END;
	D :=dataset([], R);

	EXPORT IDX := INDEX(D,{eid, ReferId},{D},data_services.Data_location.Prefix('BAIR')+'thor_data400::key::bair::notes::' + if(isDelta, 'delta::', '') + v + '::eid'); 
	
	R := RECORD,maxlength(150037)
		string23 eid;
		UNSIGNED4 ReferId;
		unsigned1 note_type;
		unsigned1 seq;
		unsigned4 notelen;
		string notes;
	END;
	 
	EXPORT FILE := DATASET(data_services.Data_location.Prefix('BAIR')+'thor_data400::base::bair::notes::' + if(isDelta, 'delta::', '') + v, R, flat);
	
END;