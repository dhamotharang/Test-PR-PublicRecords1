IMPORT AutoKeyI;

export Constants := MODULE

	export max_recs_on_join := 1000;
	export max_recs_on_did_join := 100;
	export max_recs_on_airmenNumber_join := 100;
	export codesv3_file_name := 'FAA_AIRMEN';
	export codesv3_field_name := 'CERTIFICATE_RATING';

	EXPORT MAX_AIRMEN := 5;
	EXPORT NO_RECORDS := AutoKeyI.errorcodes._codes.NO_RECORDS; // 10
	EXPORT INSUFFICIENT_INPUT := AutoKeyI.errorcodes._codes.INSUFFICIENT_INPUT; // 301

END;