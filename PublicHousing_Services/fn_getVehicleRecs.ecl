IMPORT BatchDatasets;

EXPORT fn_getVehicleRecs(DATASET(Layouts.batch_in) ds_batch_in, DATASET(Layouts.rec_best_addr) ds_best_addr_recs, IParams.BatchParams in_mod) := 
	FUNCTION
		
		#STORED('Operation','0'); // 0 = By Name and Address; 1 = By VIN; 2 = By License Plate And State
		
		UCase := StringLib.StringToUpperCase;
		mvr_yr_threshold := (UNSIGNED)in_mod.MVRYearThreshold;
		
		// Get MVR records.
		Layouts.layout_RT_mvr_raw
				ds_mvr_recs_raw_unfiltered := Raw.fetch_RealTimeMVR2_recs(ds_batch_in, ds_best_addr_recs, in_mod);
		
		ds_mvr_recs_raw_valid_vins := ds_mvr_recs_raw_unfiltered( TRIM(vin) NOT IN ['','RESTRICTED'] );
		
		ds_mvr_recs_raw_current_only := ds_mvr_recs_raw_valid_vins(is_current);
		
		ds_mvr_recs_raw := 
				ds_mvr_recs_raw_current_only( (UNSIGNED)model_year >= mvr_yr_threshold );

		// 1. Normalize all MVR records out of batch output and into a much slimmer layout:
		layout_mvr_temp := RECORD
			STRING20 acctno;
			UNSIGNED seq;
			STRING20 reg_firstname;
			STRING20 reg_lastname;
			STRING25 vin;
			STRING36 mvr_make;
			STRING36 mvr_model;
			STRING4  mvr_year;
			STRING8  mvr_reg_date;
			STRING70 lienholder;
		END;

		if_no_registrant(Layouts.layout_RT_mvr_raw le, INTEGER c) :=
			FUNCTION
				no_registrant :=
					( c = 1 AND TRIM(le.reg_1_lname) = '' ) OR
					( c = 2 AND TRIM(le.reg_2_lname) = '' ) OR
					( c = 3 AND TRIM(le.reg_3_lname) = '' );
				RETURN no_registrant;
			END;
		
		layout_mvr_temp xfm_norm_mvrs(Layouts.layout_RT_mvr_raw le, INTEGER c) := 
			TRANSFORM, SKIP( if_no_registrant(le,c) )
				SELF.acctno        := le.acctno[1..(LENGTH(TRIM(le.acctno))-2)];
				SELF.seq           := (UNSIGNED)(le.acctno[LENGTH(TRIM(le.acctno))]);
				SELF.reg_firstname := CHOOSE( c, le.reg_1_fname, le.reg_2_fname, le.reg_3_fname );
				SELF.reg_lastname  := CHOOSE( c, le.reg_1_lname, le.reg_2_lname, le.reg_3_lname );
				SELF.vin           := le.vin;
				SELF.mvr_make      := le.make_desc;
				SELF.mvr_model     := le.model_desc;
				SELF.mvr_year      := le.model_year;
				SELF.mvr_reg_date  := le.reg_latest_effective_date;
				SELF.lienholder    := CHOOSE( c, le.lh_1_orig_name, le.lh_2_orig_name, le.lh_3_orig_name );		
			END;
		
		ds_mvr_recs_normed :=
				NORMALIZE( ds_mvr_recs_raw, 3, xfm_norm_mvrs(LEFT,COUNTER) ); // 3 mvr records per row in ds_mvr_recs_raw

		ds_mvr_recs_deduped :=
			DEDUP( 
				SORT( 
					ds_mvr_recs_normed, 
					acctno, reg_lastname, reg_firstname, vin, -(UNSIGNED)(TRIM(lienholder) != '')
				), 
				acctno, reg_lastname, reg_firstname, vin 
			);

		ds_mvr_recs_filtered :=
			JOIN(
				ds_batch_in, ds_mvr_recs_deduped, 
				LEFT.acctno = RIGHT.acctno AND
				(
					(
						UCase(LEFT.name_last) = UCase(RIGHT.reg_lastname) AND
						UCase(LEFT.name_first[1..3]) = UCase(RIGHT.reg_firstname[1..3])
					) OR
					UCase(LEFT.name_first) = UCase(RIGHT.reg_firstname)
				), 
				TRANSFORM(RIGHT),
				INNER, ALL
			);			

		ds_mvr_recs_grpd := 
				GROUP( SORT( ds_mvr_recs_filtered, acctno, seq, -(UNSIGNED)mvr_reg_date ), acctno );

		// Start to build the output...:
		ds_mvrv2_results_seed := 
			PROJECT( 
				ds_batch_in, 
				TRANSFORM( Layouts.rec_vehicle,
					SELF.acctno := LEFT.acctno,
					SELF := []
				)			
			);
		
		Layouts.rec_vehicle xfm_add_mvr_recs(Layouts.rec_vehicle le, DATASET(layout_mvr_temp) allRows) :=
			TRANSFORM
				SELF.acctno          := le.acctno,
				SELF.reg_1_firstname := allRows[1].reg_firstname;
				SELF.reg_1_lastname  := allRows[1].reg_lastname;
				SELF.mvr_make_1      := allRows[1].mvr_make;
				SELF.mvr_model_1     := allRows[1].mvr_model;
				SELF.mvr_year_1      := allRows[1].mvr_year;
				SELF.mvr_reg_date_1  := allRows[1].mvr_reg_date;
				SELF.lienholder_1    := allRows[1].lienholder;
				SELF.reg_2_firstname := allRows[2].reg_firstname;
				SELF.reg_2_lastname  := allRows[2].reg_lastname;
				SELF.mvr_make_2      := allRows[2].mvr_make;
				SELF.mvr_model_2     := allRows[2].mvr_model;
				SELF.mvr_year_2      := allRows[2].mvr_year;
				SELF.mvr_reg_date_2  := allRows[2].mvr_reg_date;
				SELF.lienholder_2    := allRows[2].lienholder;
				SELF.reg_3_firstname := allRows[3].reg_firstname;
				SELF.reg_3_lastname  := allRows[3].reg_lastname;
				SELF.mvr_make_3      := allRows[3].mvr_make;
				SELF.mvr_model_3     := allRows[3].mvr_model;
				SELF.mvr_year_3      := allRows[3].mvr_year;
				SELF.mvr_reg_date_3  := allRows[3].mvr_reg_date;
				SELF.lienholder_3    := allRows[3].lienholder;
			END;
		
		ds_mvr_recs :=
			DENORMALIZE(
				ds_mvrv2_results_seed, ds_mvr_recs_grpd,
				LEFT.acctno = RIGHT.acctno,
				GROUP,
				xfm_add_mvr_recs(LEFT, ROWS(RIGHT))
			)( TRIM(reg_1_firstname) != '' );

		IF( in_mod.ViewDebugs, 
			OUTPUT( ds_mvr_recs_raw, NAMED('MVR_results') ) );

		RETURN ds_mvr_recs;
	END;
