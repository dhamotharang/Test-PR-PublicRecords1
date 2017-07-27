
IMPORT Autokey_batch, BatchServices;

EXPORT fn_getAKARecs(dataset(Layouts.batch_working) ds_batch_in,
                     IParams.BatchParams in_mod ) := 
	FUNCTION
		
		// Fulfills _documentation, Req. 4.1.14
		
		UNSIGNED DIDLIMIT_VALUE := 3;

		// --------------------[ LOCAL LAYOUTS, FUNCTIONS ]--------------------

		layout_aka := RECORD
			STRING30  acctno      := '';
			STRING30  first_name  := '';
			STRING20  middle_name := '';
			STRING35  last_name   := '';
		END;
		
		fn_format_aka_name(layout_aka aka) := 
			FUNCTION
				aka_name := IF( aka.first_name != '', TRIM(aka.first_name), '' ) + 
				            IF( aka.middle_name != '', ' ' + TRIM(aka.middle_name)[1] + '.', '' ) + 
							      IF( aka.last_name != '', ' ' + TRIM(aka.last_name), '' );
							 
				RETURN aka_name;
			END;
		
		// --------------------[ END LOCAL LAYOUTS, FUNCTIONS ]--------------------
		
		// 1. Transform input to rec_inBatchMaster and get records.
		data_in := PROJECT( ds_batch_in, Transforms.xfm_to_batchIn(LEFT) );
		
		ds_aka_recs_pre := BatchServices.AKA_BatchService_Records(data_in, DIDLIMIT_VALUE);
		
		// 2. Normalize the entities from each result record. Although each batch output 
		// record holds up to 20 persons, we will eventually need only up to 5. So, take 
		// 10 now and dedup them; and from these obtain the first 5.
		layout_aka xfm_norm(BatchServices.layout_AKA_Batch_out le, INTEGER c) :=
			TRANSFORM 
				SELF.acctno      := le.acctno;
				SELF.first_name  := CHOOSE(c, le.akas_first_name_1, le.akas_first_name_2, le.akas_first_name_3, le.akas_first_name_4, le.akas_first_name_5, le.akas_first_name_6, le.akas_first_name_7, le.akas_first_name_8, le.akas_first_name_9, le.akas_first_name_10);
				SELF.middle_name := CHOOSE(c, le.akas_middle_name_1, le.akas_middle_name_2, le.akas_middle_name_3, le.akas_middle_name_4, le.akas_middle_name_5, le.akas_middle_name_6, le.akas_middle_name_7, le.akas_middle_name_8, le.akas_middle_name_9, le.akas_middle_name_10)[1];
				SELF.last_name   := CHOOSE(c, le.akas_last_name_1, le.akas_last_name_2, le.akas_last_name_3, le.akas_last_name_4, le.akas_last_name_5, le.akas_last_name_6, le.akas_last_name_7, le.akas_last_name_8, le.akas_last_name_9, le.akas_last_name_10);
			END;
		
		ds_aka_recs := NORMALIZE(ds_aka_recs_pre, 10, xfm_norm(LEFT,COUNTER));	
		
		// 3. Filter off any invalid entities/persons.
		ds_aka_recs_valid := 
				ds_aka_recs( first_name != '' OR middle_name != '' OR last_name != '' );
		
		// 4. Dedup and Group by DID for group denormalizing.
		ds_aka_recs_grpd :=
				GROUP( SORT( DEDUP( SORT( ds_aka_recs_valid, acctno, RECORD ), acctno, RECORD ), acctno ), acctno );
		
		// 5. Denormalize to get up to the first five AKAs. Then return.
		Layouts.batch_working 
				xfm_denorm(Layouts.batch_working le, DATASET(layout_aka) allRows) :=
					TRANSFORM
						SELF.aka_1 := fn_format_aka_name( allRows[1] ),
						SELF.aka_2 := fn_format_aka_name( allRows[2] ),
						SELF.aka_3 := fn_format_aka_name( allRows[3] ),
						SELF := le			
					END;
		
		ds_aka_results := 
			DENORMALIZE(
				ds_batch_in, ds_aka_recs_grpd,
				LEFT.acctno = RIGHT.acctno AND 
				(
					LEFT.name_last != LEFT.best_lname OR
					LEFT.name_first != LEFT.best_fname
				),
				GROUP,
				xfm_denorm(LEFT,ROWS(RIGHT))
			);
		
		IF( in_mod.ViewDebugs, 
				OUTPUT( ds_aka_recs_pre, NAMED('ds_aka_intm_recs') ) );		
			
		RETURN ds_aka_results;
		
	END;