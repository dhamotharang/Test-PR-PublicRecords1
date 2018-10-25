
IMPORT BatchDatasets, WatercraftV2_Services;

EXPORT fn_getWatercraftRecs(DATASET(Layouts.batch_in) ds_batch_in, IParams.BatchParams in_mod) :=
	FUNCTION
		
		UCase := StringLib.StringToUpperCase;
		
		// 1. Fetch records from the Voters Batch service.		
		BatchDatasets.Layouts.layout_watercraft_raw
				ds_watercraft_recs_raw := BatchDatasets.fetch_Watercraft_recs(ds_batch_in);

		// 2. Apply business rules.
		ds_watercraft_current := 
				ds_watercraft_recs_raw(UCase(rec_type) = 'CURRENT');
		ds_watercraft_active := 
				ds_watercraft_current(UCase(registration_status_description) IN ['ACTIVE','CURRENT']);
	
		// 3. Join back to the batch_in to compare SSN and first name to remove  
		// false positives.
		isMatch(Layouts.batch_in rw_batch_in, DATASET(WatercraftV2_Services.Layouts.owner_report_rec) owners) :=
			FUNCTION
				// Convert row to dataset for joining.
				ds_batch_in_row := DATASET(rw_batch_in);
				
				ds_matching_owner_recs := 
					JOIN(
						ds_batch_in_row, owners,
						LEFT.did = (UNSIGNED6)RIGHT.did AND
						(
							(
								UCase(LEFT.name_last) = UCase(RIGHT.lname) AND
								UCase(LEFT.name_first[1..3]) = UCase(RIGHT.fname[1..3])
							) OR
							UCase(LEFT.name_first) = UCase(RIGHT.fname)
						), 
						TRANSFORM(LEFT),
						INNER, ALL,	KEEP(1)
					);
				
				// Return whether there were any matches at all.
				RETURN COUNT(ds_matching_owner_recs) > 0;
			END;
		
		Layouts.batch_in xfm(Layouts.batch_in le, BatchDatasets.Layouts.layout_watercraft_raw ri) :=
			TRANSFORM, SKIP( NOT isMatch(le,ri.owners) )
				SELF := le
			END;
			
		ds_watercraft_recs :=
			JOIN(
				ds_batch_in, ds_watercraft_active,
				LEFT.acctno = RIGHT.acctno,
				xfm(LEFT, RIGHT),
				INNER, KEEP(1)
			);

		IF( in_mod.ViewDebugs, 
			OUTPUT( ds_watercraft_recs_raw, NAMED('Watercraft_results') ) );

		RETURN ds_watercraft_recs;
	END;