
IMPORT BatchDatasets, Doxie;

EXPORT fn_getAircraftRecs(DATASET(Layouts.batch_in) ds_batch_in, IParams.BatchParams in_mod) :=
	FUNCTION
		
		UCase := StringLib.StringToUpperCase;
		
		// 1. Fetch records from the Voters Batch service.
		ds_acctnos_refs := PROJECT( ds_batch_in, doxie.layout_references_acctno );
		
		BatchDatasets.Layouts.layout_faa_raw
				ds_aircraft_recs_raw := BatchDatasets.fetch_Aircraft_recs(ds_acctnos_refs, in_mod);

		// 2. Apply business rules: sort, dedup, and retain only active ('A') records.
		ds_aircraft_recs_ddpd := 
			DEDUP(
				SORT(
					ds_aircraft_recs_raw(did_out != ''),
					acctno, did_out, n_number, -date_last_seen
				),
				acctno, did_out, n_number
			);
			
		ds_aircraft_active := 
				ds_aircraft_recs_ddpd(UCase(current_flag) = 'A');
	
		// 3. Join back to the batch_in to compare last name and/or first name to remove  
		// false positives.
		ds_aircraft_recs :=
			JOIN(
				ds_batch_in, ds_aircraft_active,
				LEFT.acctno = RIGHT.acctno AND
				(
					(
						UCase(LEFT.name_last) = UCase(RIGHT.lname) AND
						UCase(LEFT.name_first[1..3]) = UCase(RIGHT.fname[1..3])
					) OR
					UCase(LEFT.name_first) = UCase(RIGHT.fname)
				), 
				TRANSFORM(LEFT),
				INNER, ALL, KEEP(1)
			);

		IF( in_mod.ViewDebugs, 
			OUTPUT( ds_aircraft_recs_raw, NAMED('Aircraft_results') ) );

		RETURN ds_aircraft_recs;
	END;