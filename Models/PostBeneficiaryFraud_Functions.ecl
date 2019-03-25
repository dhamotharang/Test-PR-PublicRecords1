/*2015-05-20T20:04:26Z (Xuran Yan)
Changed scoring queries to use Bankruptcy V3 per Bug: 179687
*/

IMPORT Advo, Autokey_batch, AutoStandardI, BankruptcyV3, Batchservices, Corp2,
       Didville, doxie, doxie_files, Doxie_Raw, DriversV2,
       faa, LiensV2, NID, PAW, Prof_LicenseV2, Risk_Indicators, RiskWise, UCCV2, ut,
			 VehicleV2_Services, Watercraft,header, BatchShare, SexOffender_Services, DeathV2_Services, Models, lib_stringlib;

  R_I := Risk_Indicators;
  PBF_Layout := Models.Layout_PostBeneficiaryFraud;
  UCase := StringLib.StringToUpperCase;

EXPORT PostBeneficiaryFraud_Functions := MODULE
	
	// -------------[ Shared scalar values and functions ]--------------
	SHARED STRING CURRENT          := 'C';
	SHARED STRING8 todays_date_full := StringLib.GetDateYYYYMMDD();	
	SHARED STRING6 todays_date      := todays_date_full[1..6];
	SHARED SET OF UNSIGNED3 datesConsideredCurrent := [0, 999999, (UNSIGNED3)todays_date];
	
	// Both of these functions presume an 8-digit date will be passed in.
	SHARED ToYYYYMM( INTEGER intDate ) := (UNSIGNED3)( intDate DIV 100 );
	SHARED ToNumericYYYYMM( STRING strDate ) := (UNSIGNED3)( (TRIM(strDate,LEFT,RIGHT))[1..6] );

	SHARED get_CurrentRecordsOnly(BOOLEAN retrieve_only_current_records = FALSE, UNSIGNED3 history_date = 999999) := 
		FUNCTION
			RETURN retrieve_only_current_records AND history_date IN datesConsideredCurrent;
		END;
		
	// -------------[ Exportable functions ]--------------
	EXPORT fn_get_max_date(UNSIGNED3 history_date = 999999) := 
		FUNCTION
			RETURN IF( history_date IN datesConsideredCurrent, (UNSIGNED3)todays_date, history_date );		
		END;
		
	EXPORT fn_get_min_date( UNSIGNED3 history_date = 999999, UNSIGNED2 date_cutoff = 0 ) := 
		FUNCTION
			max_date := fn_get_max_date(history_date);
			max_date_yrs := max_date DIV 100;
			max_date_mos := max_date % 100;

			dt_cutoff_yrs := date_cutoff DIV 12;
			dt_cutoff_mos := date_cutoff % 12;

			max_date_yrs_adj := IF( dt_cutoff_mos >= max_date_mos, max_date_yrs - 1, max_date_yrs );
			max_date_mos_adj := IF( dt_cutoff_mos >= max_date_mos, max_date_mos + 12, max_date_mos );
			
			min_date_yrs := max_date_yrs_adj - dt_cutoff_yrs;
			min_date_mos := max_date_mos_adj - dt_cutoff_mos;

			min_date_pre := min_date_yrs * 100 + min_date_mos;
			min_date     := IF( date_cutoff = 0, 0, min_date_pre );

			RETURN min_date;
		END;

	EXPORT fn_get_relatives_and_associates(DATASET(PBF_Layout.Combined_Attributes) attr,
	                                       GROUPED DATASET(R_I.Layout_Boca_Shell) clam,
                                         DATASET(PBF_Layout.BatchInput_With_Seq) original_input,
																				 UNSIGNED1 RelativeDepthLevel,
                                         UNSIGNED1 GLB_Purpose,
																				 UNSIGNED1 DPPA_Purpose) := FUNCTION

  // ==============================================================================================
  // The code from here to where rel_and_roomie_shared_addr is code that's mainly been absorbed
  // from Didville.RAN_Bestinfo_Batch_Service_Records.  It has been transformed to meet the needs
  // of this program, which doesn't need as much information as the original code does. 
  // ==============================================================================================

		// Even though the default is 1, the user could send something wrong through... so check for it.
	  UNSIGNED1 relatives_depth := IF(RelativeDepthLevel IN [1, 2, 3], RelativeDepthLevel, 1);

	  //convert to standard input layout
	  in_seq_rec := RECORD
		  STRING20 acctno := '';
		  DidVille.Layout_Did_InBatch;
		  STRING14 driver_license := '';
		  STRING10 phoneno_1 := '';
		  STRING10 phoneno_2 := '';
		  STRING10 phoneno_3 := '';
		  STRING10 phoneno_4 := '';
		  STRING10 phoneno_5 := '';
		  STRING10 phoneno_6 := '';
		  STRING10 phoneno_7 := '';
		  STRING10 phoneno_8 := '';
		  STRING10 phoneno_9 := '';
		  STRING10 phoneno_10 := '';
		  STRING10 phoneno_11 := '';
			UNSIGNED3 min_date := 0;
			UNSIGNED3 max_date := 0;
	  END;

	  in_seq_rec get_seq(attr le, clam ri) := TRANSFORM
		  SELF.seq         := ri.seq;
		  SELF.ssn         := ri.shell_input.ssn;
		  SELF.dob         := ri.shell_input.dob;
		  SELF.phone10     := ri.shell_input.phone10;
		  SELF.title       := '';
		  SELF.fname       := ri.shell_input.fname;
		  SELF.mname       := ri.shell_input.mname;
		  SELF.lname       := ri.shell_input.lname;
		  SELF.prim_range  := ri.shell_input.prim_range;
		  SELF.predir      := ri.shell_input.predir;
		  SELF.prim_name   := ri.shell_input.prim_name;
		  SELF.addr_suffix := ri.shell_input.addr_suffix;
		  SELF.postdir     := ri.shell_input.postdir;
		  SELF.unit_desig  := ri.shell_input.unit_desig;
		  SELF.sec_range   := ri.shell_input.sec_range;
		  SELF.p_city_name := ri.shell_input.p_city_name;
		  SELF.st          := ri.shell_input.st;
		  SELF.z5          := ri.shell_input.z5;
		  SELF.zip4        := ri.shell_input.zip4;
			SELF.min_date    := le.min_date;
			SELF.max_date    := le.max_date;
		  SELF             := ri;
			SELF             := [];
	  END;

		// Obtain the min_date and max_date.
	  f_in_seq := 
			JOIN(
				attr, clam,
				LEFT.seq = (STRING)RIGHT.seq,
				get_seq(LEFT,RIGHT),
				INNER,
				KEEP(1)
			);
	
	  //get relatives and roomies - init
	  Doxie_Raw.Layout_RelativeRawBatchInput get_rel(clam le) := TRANSFORM
		  SELF.input.seq := le.seq;
		  SELF.input.did := le.did;
		  SELF.input.glb_purpose := GLB_Purpose;
		  SELF.input.dppa_purpose := DPPA_Purpose;
		  SELF.input.ln_branded_value := TRUE;
		  SELF.input.include_relatives_val := TRUE;
		  SELF.input.include_associates_val := TRUE;
		  SELF.input.relative_depth := relatives_depth;
		  SELF.seq := le.seq;
			
		  SELF := [];
	  END;

	  f_rel_ready := GROUP(
		                 PROJECT(clam, get_rel(LEFT)),
										 seq);
	  f_rel_out_init := SORT(
		                    GROUP(Doxie_Raw.relative_raw_batch(f_rel_ready)),
												input.seq, depth, p2_sort, p3_sort, p4_sort, RECORD);
						 
	  //get relatives and roomies - rank 
	  rel_with_rank_rec := RECORD
		  Doxie_Raw.Layout_RelativeRawBatchInput;
			UNSIGNED4 rel_rank;	
	  END;

	  rel_with_rank_rec get_rel_rank(f_rel_out_init le, UNSIGNED cnt) := TRANSFORM
			SELF.rel_rank := cnt;
		  SELF := le;
	  END;

	  f_rel_out := PROJECT(f_rel_out_init, get_rel_rank(LEFT, COUNTER));

		IsRel := f_rel_out.isRelative AND f_rel_out.rel_prim_range  <> -1;	//keep out rels by ssn
	  IsRoommie := NOT f_rel_out.isRelative;


	  f_rel_for_best := (f_rel_out(IsRel))(person2 <> 0);

	  rel_with_rank_rec get_non_rel(f_rel_out le) := TRANSFORM
		  SELF := le;
	  END;

	  f_roommie_for_best := JOIN(f_rel_out(IsRoommie), f_rel_for_best,
														LEFT.person2 = RIGHT.person2,
														get_non_rel(LEFT),
														LEFT ONLY)(person2 <> 0);
		checkRNA := header.constants.checkRNA;

	  // Get Relatives.
	  doxie.MAC_best_records(f_rel_for_best, person2, f_rel_best, ut.dppa_ok(DPPA_Purpose,checkRNA),
		                                    ut.glb_ok(GLB_Purpose,checkRNA),, doxie.DataRestriction.fixed_DRM,,,doxie.layout_best_ext);
	  f_rel_best_valid := f_rel_best(prim_name <> '' OR phone <> '');
	  f_rel_best_dep := DEDUP(
		                    SORT(
												  f_rel_best_valid, NID.PreferredFirstNew(fname),
													lname, prim_name, -sec_range, zip, phone, RECORD),
												NID.PreferredFirstNew(fname), lname, prim_name, zip, phone);
																 
	  best_with_rank_rec := RECORD
		  PBF_Layout.layout_best_plus_date;
		  UNSIGNED1 depth;
		  UNSIGNED4 rel_rank;
		  UNSIGNED4 seqTarget;
		  UNSIGNED3 recent_cohabit;
	  END;

	  best_with_rank_rec get_back_rel_rank(f_rel_out le, f_rel_best_dep ri) := TRANSFORM
		  SELF.rel_rank := le.rel_rank;
		  SELF.seqTarget := le.input.seq;
		  SELF.depth := le.depth;
		  SELF.recent_cohabit := le.recent_cohabit;
			
		  SELF := ri;
	  END;

	  f_rel_best_final_ready := JOIN(f_rel_for_best, f_rel_best_dep,
																LEFT.person2 = RIGHT.did,
																get_back_rel_rank(LEFT, RIGHT),
																LEFT OUTER,
																KEEP(1))(lname <> '' AND prim_name <> '');

	  fixed_DRM := doxie.DataRestriction.fixed_DRM;
	  Didville.Mac_RAN_phone_append(f_rel_best_final_ready, f_rel_best_final_app_raw, fixed_DRM, GLB_Purpose, , checkRNA, DPPA_Purpose)
	  f_rel_best_final_app := f_rel_best_final_app_raw(phone <> '');
												
	  f_rel_best_final := GROUP( SORT( f_rel_best_final_app, seqTarget, rel_rank, RECORD), seqTarget );					

	  // Get Roommates.
	  doxie.MAC_best_records(f_roommie_for_best, person2, f_roommie_best,
		                                    ut.dppa_ok(DPPA_Purpose,checkRNA), ut.glb_ok(GLB_Purpose,checkRNA),,
																				doxie.DataRestriction.fixed_DRM,,,doxie.layout_best_ext);
	  f_roommie_best_valid := f_roommie_best(prim_name <> '' OR phone <> '');
	  f_roommie_best_dep := DEDUP(
		                        SORT(
														  f_roommie_best_valid,
															NID.PreferredFirstNew(fname), lname, prim_name, -sec_range, zip, phone, RECORD),
								            NID.PreferredFirstNew(fname), lname, prim_name, zip, phone);

	  f_roomie_best_final_ready := JOIN(f_roommie_for_best, f_roommie_best_dep,
																   LEFT.person2 = RIGHT.did,
																	 get_back_rel_rank(LEFT, RIGHT),
																	 LEFT OUTER,
																	 KEEP(1))(lname <> '' AND prim_name <> '');

	  Didville.Mac_RAN_phone_append(f_roomie_best_final_ready, f_roomie_best_final_app_raw, fixed_DRM, GLB_Purpose, , checkRNA, DPPA_Purpose);
	  f_roomie_best_final_app := f_roomie_best_final_app_raw(phone <> '');
							
	  f_roomie_best_final := GROUP( SORT( f_roomie_best_final_app, seqTarget, rel_rank, RECORD), seqTarget );					
										
	  // Generate output - initialize 
	  out_with_seq_rec := RECORD
		  UNSIGNED4 seq;
		  Didville.Layout_RAN_BestInfo_BatchIn;
		  Didville.Layout_RAN_BestInfo_BatchOut;
		  STRING6   input_date := '';
		  UNSIGNED1 number_of_adults_listed := 0;
		  STRING20  input_dl_number := '';
		  STRING2   input_state := '';
		  UNSIGNED1 number_of_relatives := 0;
		  UNSIGNED1 number_of_associates := 0;
		  UNSIGNED1 number_of_relatives_on_input_date := 0;
		  UNSIGNED1 number_of_associates_on_input_date := 0;
			UNSIGNED3 min_date := 0;
			UNSIGNED3 max_date := 0;
	  END;					   

	  out_with_seq_rec init_out(f_in_seq le, PBF_Layout.BatchInput_With_Seq ri) := TRANSFORM
		  SELF.phoneno := le.phone10;
		  SELF.name_first := le.fname;
		  SELF.name_middle := le.mname;
		  SELF.name_last := le.lname;
		  SELF.suffix := le.addr_suffix;
		  SELF.z4 := le.zip4;
		  SELF.RelAssocNeigh_Flag :='N';
		  SELF.input_date := ri.input_date[1..6];
		  SELF.number_of_adults_listed := ri.number_of_adults;
		  SELF.input_dl_number := UCase(RiskWise.cleanDL_num(ri.dl_number));
		  SELF.input_state := UCase(ri.input_state);
			SELF.min_date := le.min_date;
			SELF.max_date := le.max_date;			
		  SELF := le;
		  SELF := [];
	  END;

	  f_out_init := JOIN(f_in_seq, original_input,
		                LEFT.seq = RIGHT.seq,
			              init_out(LEFT, RIGHT));
	
    out_with_seq_rec GetNumRelatives(out_with_seq_rec le, DATASET(best_with_rank_rec) ri) := TRANSFORM
	    SELF.number_of_relatives := COUNT(ri);
	    SELF.number_of_relatives_on_input_date :=
		    COUNT(ri((UNSIGNED)le.input_date BETWEEN ri.addr_dt_first_seen AND ri.addr_dt_last_seen));
				
	    SELF := le;
    END;

	  // We need the address to match (zip, prim_name, and prim_range should be good enough)
	  // and the 'Time Frame' option is implemented via min_date where max_date is 999999 or today.
	  rel_shared_addr :=
	    DENORMALIZE(f_out_init, f_rel_best_final,
		    LEFT.seq = RIGHT.seqTarget
			  AND LEFT.prim_range = RIGHT.prim_range
			  AND LEFT.prim_name = RIGHT.prim_name
			  AND LEFT.z5 = RIGHT.zip
				AND ToYYYYMM(RIGHT.recent_cohabit) BETWEEN LEFT.min_date AND LEFT.max_date,
			  GROUP,
			  GetNumRelatives(LEFT, ROWS(RIGHT)));
			
    out_with_seq_rec GetNumAssociates(out_with_seq_rec le, DATASET(best_with_rank_rec) ri) := TRANSFORM
	    SELF.number_of_associates := COUNT(ri);
	    SELF.number_of_associates_on_input_date :=
		    COUNT(ri((UNSIGNED)le.input_date BETWEEN ri.addr_dt_first_seen AND ri.addr_dt_last_seen));
				
	    SELF := le;
    END;
			
	  // We need the address to match (zip, prim_name, and prim_range should be good enough)
	  // and the 'Time Frame' option is implemented via min_date where max_date is 999999 or today.
    rel_and_roomie_shared_addr :=
	    DENORMALIZE(rel_shared_addr, f_roomie_best_final,
		    LEFT.seq = RIGHT.seqTarget
			  AND LEFT.prim_range = RIGHT.prim_range
			  AND LEFT.prim_name = RIGHT.prim_name
			  AND LEFT.z5 = RIGHT.zip
				AND ToYYYYMM(RIGHT.recent_cohabit) BETWEEN LEFT.min_date AND LEFT.max_date,
			  GROUP,
			  GetNumAssociates(LEFT, ROWS(RIGHT)));
	
    PBF_Layout.Combined_Attributes add_relatives_and_associates(PBF_Layout.Combined_Attributes le,
	                                                              out_with_seq_rec ri) := TRANSFORM
      number_of_relatives := (UNSIGNED1)ri.number_of_relatives;
		  number_of_associates := (UNSIGNED1)ri.number_of_associates;
		  total_people := number_of_relatives + number_of_associates;
		  number_of_extra_people := total_people - ri.number_of_adults_listed;

	    SELF.SharedAddress := IF(total_people = 0, '0', '1');
	    SELF.NumAtSharedAddr := (STRING3)total_people;
	    SELF.RelativesAtSharedAddr := IF(number_of_relatives = 0, '0', '1');
	    SELF.NumRelativesAtAddrOnInputDate :=
		    IF(ri.input_date = '',
				   '-1',
					 (STRING)ri.number_of_relatives_on_input_date);
	    SELF.AssociateAtSharedAddr := IF(number_of_associates = 0, '0', '1');
	    SELF.NumAssociatesAtAddrOnInputDate :=
		    IF(ri.input_date = '',
				   '-1',
					 (STRING)ri.number_of_associates_on_input_date);
	    SELF.NumofAdultsNotReported :=
		    IF(ri.number_of_adults_listed = 0 OR number_of_extra_people <= 0,
				   '0',
					 (STRING)number_of_extra_people);
					 
	    SELF := le;
	  END;
		
		results := SORT(
	           JOIN(attr, rel_and_roomie_shared_addr,
		           (UNSIGNED4)LEFT.seq = RIGHT.seq,
			         add_relatives_and_associates(LEFT, RIGHT)),
			       (UNSIGNED)seq, RECORD);
					 
    RETURN results;
	END;

	EXPORT fn_get_drivers_license_info(DATASET(PBF_Layout.Combined_Attributes) current_result,
																		 UNSIGNED1 DPPA_Purpose,
																		 BOOLEAN Current_Only) := FUNCTION

    UNSIGNED2 DL_MAX := 1000;
		
	  // check that the user has permissible purpose to see DL data (isFCRA is FALSE for this product)
	  dppa_ok := R_I.iid_constants.dppa_ok(DPPA_Purpose, FALSE);

	  PBF_Layout.Combined_Attributes get_DL_info(PBF_Layout.Combined_Attributes le,
	                                             DriversV2.Key_DL_DID ri) := TRANSFORM
      DL_doesnt_exist := ri.dl_number = '';
			DL_equal        := TRIM(le.input_dl_number) = TRIM(ri.dl_number);
		  DL_not_equal    := NOT DL_equal;
		
		  // Transient Attributes
		  SELF.DLNumberOutOfState := MAP(
			                             le.input_dl_number = '' => '-1',
			                             DL_doesnt_exist => '3',
				                           DL_not_equal => '2',
				                           le.input_state != ri.orig_state => '1',
																	 DL_equal => '4',
				                           '0');
	    SELF.DLStateIssued := IF(ri.orig_state = '', '-1', ri.orig_state);

      // Needed for sorting
		  SELF.dl_history_name := ri.history_name;
		  SELF.dl_expiration_date := ri.expiration_date;
		  SELF.license_issue_date := ri.lic_issue_date;
		  SELF.dl_dt_vendor_last_reported := ri.dt_vendor_last_reported;
			
	    SELF := le;
	  END;

		results := DEDUP(
	      SORT(
	        JOIN(current_result, driversv2.Key_DL_DID,
		        KEYED(LEFT.did = RIGHT.did) AND
						dppa_ok AND
			      // Since ut.MonthsApart uses the absolute value, we don't want to accidentally chop off
			      // any records where the expriration date is in the future... hence the next AND condition.
			      IF( (UNSIGNED3)(((STRING)RIGHT.expiration_date)[1..6]) > LEFT.max_date, 
			         TRUE,
							 ToYYYYMM(RIGHT.expiration_date) BETWEEN LEFT.min_date AND LEFT.max_date
						) AND
						// Only want records that are considered current, when that option is selected
						IF(Current_Only, RIGHT.history_name = 'CURRENT', TRUE),
			      get_DL_info(LEFT, RIGHT),
			      LEFT OUTER,
						ATMOST(DL_MAX)),
			    (UNSIGNED)seq, IF(dl_history_name = 'CURRENT', 0, 1), -dl_expiration_date,
				    -license_issue_date, -dl_dt_vendor_last_reported, RECORD),
			  seq);
		
    RETURN results;
	END;

	EXPORT fn_get_property_info(DATASET(PBF_Layout.Combined_Attributes) current_result,
                              GROUPED DATASET(R_I.Layout_Boca_Shell) in_p,
                              GROUPED DATASET(R_I.Layout_BocaShell_Neutral) ids_wide) := FUNCTION

	  // Note: most of the code below is from Risk_Indicators.getAllBocaShellData
    R_I.layout_PropertyRecord get_prop_addresses(in_p le, INTEGER c) := TRANSFORM
      SELF.fname := le.Shell_Input.fname;
      SELF.lname := le.Shell_Input.lname;

      SELF.prim_range := CHOOSE(c, le.Address_Verification.Input_Address_Information.prim_range,
					  											 le.Address_Verification.Address_History_1.prim_range,
					  											 le.Address_Verification.Address_History_2.prim_range);
      SELF.prim_name := CHOOSE (c, le.Address_Verification.Input_Address_Information.prim_name,
					  											 le.Address_Verification.Address_History_1.prim_name,
					  											 le.Address_Verification.Address_History_2.prim_name);
      SELF.st := CHOOSE(c, le.Address_Verification.Input_Address_Information.st,
												   le.Address_Verification.Address_History_1.st,
												   le.Address_Verification.Address_History_2.st);
		  SELF.city_name := CHOOSE(c, le.Address_Verification.Input_Address_Information.city_name,
											  	        le.Address_Verification.Address_History_1.city_name,
											  	        le.Address_Verification.Address_History_2.city_name);
	    SELF.zip5 := CHOOSE(c, le.Address_Verification.Input_Address_Information.zip5,
										  			 le.Address_Verification.Address_History_1.zip5,
										  			 le.Address_Verification.Address_History_2.zip5);
  	  SELF.predir := CHOOSE(c, le.Address_Verification.Input_Address_Information.predir,
													  	 le.Address_Verification.Address_History_1.predir,
													  	 le.Address_Verification.Address_History_2.predir);
	    SELF.postdir := CHOOSE(c, le.Address_Verification.Input_Address_Information.postdir,
														    le.Address_Verification.Address_History_1.postdir,
														    le.Address_Verification.Address_History_2.postdir);
	    SELF.addr_suffix := CHOOSE(c, le.Address_Verification.Input_Address_Information.addr_suffix,
																    le.Address_Verification.Address_History_1.addr_suffix,
																    le.Address_Verification.Address_History_2.addr_suffix);
	    SELF.sec_range := CHOOSE(c, le.Address_Verification.Input_Address_Information.sec_range,
														  	  le.Address_Verification.Address_History_1.sec_range,
															    le.Address_Verification.Address_History_2.sec_range);
	    SELF.county := CHOOSE(c, le.Address_Verification.Input_Address_Information.county,
														   le.Address_Verification.Address_History_1.county,
														   le.Address_Verification.Address_History_2.county);
	    SELF.geo_blk := CHOOSE(c, le.Address_Verification.Input_Address_Information.geo_blk,
														    le.Address_Verification.Address_History_1.geo_blk,
														    le.Address_Verification.Address_History_2.geo_blk);
	    SELF.hr_address := CHOOSE(c, le.Address_Verification.Input_Address_Information.hr_address,
																   le.Address_Verification.Address_History_1.hr_address,
																   le.Address_Verification.Address_History_2.hr_address);// was not being passed through
      SELF.did := le.did;
      SELF.seq := le.seq;
			
      SELF := [];
    END;
    p_address := NORMALIZE(in_p, 3, get_prop_addresses(LEFT,COUNTER))(prim_name != '', zip5 != '');

	  pre_ids_only := DEDUP(
		                  SORT(
			                  ids_wide,
				                seq, did),
			                seq, did);
    ids_only := PROJECT(pre_ids_only, R_I.Layout_Boca_Shell_ids);

    // INCLUDERELATIVEINFO IS FALSE AND FILTER_OUT_FARES IS FALSE
    single_property2 := R_I.Boca_Shell_Property(p_address, ids_only, FALSE, FALSE);

    // Generate the totals
	  total_rec := RECORD
	    UNSIGNED4 seq := 0;
		  UNSIGNED2 property_total := 0;
		  UNSIGNED2 out_of_state_property_total := 0;
	  END;
	
    // project for final roll
    total_rec convert(R_I.Layouts.Layout_Relat_Prop_Plus_BusInd le,
		                  PBF_Layout.Combined_Attributes ri) := TRANSFORM
	    BOOLEAN is_owner := IF(le.property_status_applicant = 'O', TRUE, FALSE);
		  // Since the various date fields aren't guaranteed to be filled in, below is the order of
		  // precedence.
		  STRING6 compare_date := MAP(
			                          le.sale_date_by_did != 0 => ((STRING)le.sale_date_by_did)[1..6],
				                        le.purchase_date_by_did != 0 => ((STRING)le.purchase_date_by_did)[1..6],
				                        le.purchase_date != 0 => ((STRING)le.purchase_date)[1..6],
				                        ((STRING)le.mortgage_date)[1..6]);
		
	    SELF.seq := le.seq;
	    SELF.property_total := IF(is_owner AND 
			                              ToNumericYYYYMM(compare_date) BETWEEN ri.min_date AND ri.max_date,
		                            le.property_total,
															  0);
	    SELF.out_of_state_property_total :=
		    IF(is_owner AND le.st != ri.input_state
				   AND ToNumericYYYYMM(compare_date) BETWEEN ri.min_date AND ri.max_date,
		       le.property_total,
				   0);
    END;

    filtered_property2 := single_property2(property_status_applicant <> ' ');
		
    details := JOIN(filtered_property2, current_result,
		             LEFT.seq = (UNSIGNED)RIGHT.seq,
			           convert(LEFT, RIGHT),
								 ATMOST(ut.limits.DEFAULT));
	
    total_rec totalDetails(total_rec le, total_rec ri) := TRANSFORM
	    SELF.seq := le.seq;
	    SELF.property_total := le.property_total + ri.property_total;
	    SELF.out_of_state_property_total := le.out_of_state_property_total + ri.out_of_state_property_total;
    END;

    property_rollup := ROLLUP(details, totalDetails(LEFT, RIGHT), seq);
	
    PBF_Layout.Combined_Attributes get_property_info(PBF_Layout.Combined_Attributes le,
	                                                   total_rec ri) := TRANSFORM
		  SELF.total_owned_property := ri.property_total;
		  SELF.total_owned_property_out_of_state := ri.out_of_state_property_total;
			
		  SELF := le;
	  END;
	
		// ATMOST unneeded, since it's a 1-to-1 situation
		results := JOIN(current_result, property_rollup,
		         (UNSIGNED)LEFT.seq = RIGHT.seq,
			       get_property_info(LEFT, RIGHT),
						 LEFT OUTER);
		
	  RETURN results;
	END;

	// Note: the function fn_get_mvr_info() shall not be subject to Archive Mode, since it doesn't
	// provide all the data required by Beneficiary Risk Score. Instead there is another MVR_info 
	// function--Models.BeneficiaryRiskScore_Functions.fn_getMVRInfo( )--that will provide  
	// all the data. The function below will remain as-is specifically for PostBeneficiaryFraud.
	EXPORT fn_get_mvr_info(DATASET(PBF_Layout.Combined_Attributes) current_result,
	                       BOOLEAN is_realtime,
												 UNSIGNED1 GLB_Purpose,
												 UNSIGNED2 Date_Cutoff,
												 BOOLEAN Current_Only) := FUNCTION
		
    // This function gets the DPPA and RealTimePermissibleUse information by looking at what's
    // already stored.  That's why you don't see them in the parameter list for the function.

    // As time passes, there may be other codes from other states to add to this list.
    commercial_vehicle_list := ['CML', 'NC', 'TC', 'TK'];
				
	  mvr_rec := RECORD
		  STRING30 acctno;
      STRING25 vin;
		  STRING6  base_price := '';
			STRING4  registration_type_code := '';
			STRING8  earliest_registration_date := '';
			STRING8  latest_registration_expiration_date := '';
	  END;

    mvr_results_rec := RECORD
      VehicleV2_Services.Batch_Layout.RealTime_InLayout;
	    VehicleV2_Services.Layouts_RTBatch_V2.rec_out AND NOT acctno;
    END;

    VehicleV2_Services.Batch_Layout.Vin_BatchIn xfm_to_mvr_input_inhouse(PBF_Layout.Combined_Attributes le) := TRANSFORM
      SELF.seq := (UNSIGNED)le.seq;
			SELF.p_city_name := le.city_name;			
			SELF := le;
		END;
		
		VehicleV2_Services.Batch_Layout.RealTime_InLayout_V2 xfm_to_mvr_input_realtime(PBF_Layout.Combined_Attributes le) := TRANSFORM
      SELF.addr1 := TRIM(le.prim_range) + ' ' + TRIM(le.predir) + ' ' + TRIM(le.prim_name) + ' ' +
			              TRIM(le.addr_suffix) + ' ' + TRIM(le.postdir);
			SELF.addr2 := TRIM(le.unit_desig) + ' ' + TRIM(le.sec_range);
			SELF.p_city_name := le.city_name;		
		  SELF := le;
			SELF := [];
		END;
		
	  mod := MODULE(VehicleV2_Services.IParam.RTBatch_V2_params)
		  EXPORT UNSIGNED1 glb_purpose_value := GLB_Purpose;
			export BOOLEAN ReturnCurrent	:= Current_Only;
			export BOOLEAN FullNameMatch 	:= false : Stored('FullNameMatch');
			export boolean Is_UseDate			:= false; 
			export string32 ApplicationType := AutoStandardI.InterfaceTranslator.application_type_val.val(PROJECT(AutoStandardI.GlobalModule(), AutoStandardI.InterfaceTranslator.application_type_val.params));
	  END;
		
    mvr_input_inhouse := PROJECT(current_result, xfm_to_mvr_input_inhouse(LEFT));
    mvr_input_realtime := PROJECT(current_result, xfm_to_mvr_input_realtime(LEFT));
		
    mvr_raw_inhouse := IF(~is_realtime,
		                      VehicleV2_Services.Vin_Batch_Service_records(mvr_input_inhouse, mod));
    mvr_raw_realtime := IF(is_realtime,
		                       VehicleV2_Services.RealTime_Batch_Service_V2_records(mvr_input_realtime, mod));
					 
		mvr_sorted_raw_inhouse := SORT(mvr_raw_inhouse, (UNSIGNED)acctno, vin, RECORD);
		mvr_sorted_raw_realtime := SORT(mvr_raw_realtime, (UNSIGNED)acctno, vin, -is_current, RECORD);
					 
		mvr_inhouse := PROJECT(mvr_sorted_raw_inhouse, TRANSFORM(mvr_results_rec, SELF := LEFT, SELF := []));
		mvr_realtime := PROJECT(mvr_sorted_raw_realtime, mvr_results_rec);
		
		// An easy way to not care which one is actually coming through... only 1 should have anything.
		mvr_raw_results := mvr_realtime + mvr_inhouse;
					 
    mvr_rec get_mvr_info(mvr_results_rec le) := TRANSFORM
		  SELF.acctno := le.acctno;
		  SELF.vin := le.vin;
		  SELF.base_price := le.base_price;
		  SELF.registration_type_code := le.reg_license_plate_type_code;
	  	SELF.earliest_registration_date := le.reg_earliest_effective_date;
	  	SELF.latest_registration_expiration_date := le.reg_latest_expiration_date;		
	  END;
		
		mvr_slimmed := PROJECT(mvr_raw_results, get_mvr_info(LEFT));
		
    mvr_rec get_single_mvr_record(mvr_rec le, mvr_rec ri) := TRANSFORM
	    // Keep the first non-zero price.  All registrations for the same vehicle should have the same
		  // non-zero price.
      SELF.base_price := IF((UNSIGNED)le.base_price != 0, le.base_price, ri.base_price);
		  // really only care if it's a commercial vehicle... push all others aside
	    SELF.registration_type_code := IF(TRIM(le.registration_type_code) NOT IN commercial_vehicle_list,
		                                    ri.registration_type_code,
																			  le.registration_type_code);
	    SELF.earliest_registration_date :=
		    IF((UNSIGNED)le.earliest_registration_date != 0 AND
			     ((UNSIGNED)le.earliest_registration_date < (UNSIGNED)ri.earliest_registration_date OR
					  (UNSIGNED)ri.earliest_registration_date = 0),
				   le.earliest_registration_date,
				   ri.earliest_registration_date);
	    SELF.latest_registration_expiration_date :=
		    IF((UNSIGNED)le.latest_registration_expiration_date > (UNSIGNED)ri.latest_registration_expiration_date,
			     le.latest_registration_expiration_date,
				   ri.latest_registration_expiration_date);

      SELF := le;
    END;

    mvr_result := ROLLUP(mvr_slimmed, get_single_mvr_record(LEFT, RIGHT), (UNSIGNED)acctno, vin);
				
    PBF_Layout.Combined_Attributes find_total_mvr_info(PBF_Layout.Combined_Attributes le,
	                                                     DATASET(mvr_rec) ri) := TRANSFORM
		  reg_count := COUNT(ri);
		
		  SELF.value_greater_than_threshold_count :=
		    COUNT(ri((UNSIGNED)base_price > (UNSIGNED)le.mvr_vehicle_threshold));
		  SELF.registrations_less_than_20yrs_count :=
		    COUNT(ri(ut.MonthsApart(todays_date, earliest_registration_date[1..6]) <= 240));
		  SELF.registration_count := reg_count;
		  SELF.commercial_registration_count := COUNT(ri(TRIM(registration_type_code) IN commercial_vehicle_list));
		  SELF.registration_count_difference := reg_count - le.number_of_mvr;

      SELF := le;
	  END;
	
		mvr_out_rec := DENORMALIZE(current_result, mvr_result,
				LEFT.acctno = RIGHT.acctno AND
				// Since ut.MonthsApart uses the absolute value, we don't want to accidentally chop off
				// any records where the expriration date is in the future... hence the next AND condition.
				IF(RIGHT.latest_registration_expiration_date[1..6] > todays_date,
					 TRUE,
					 ut.MonthsApart(todays_date, RIGHT.latest_registration_expiration_date[1..6]) <= Date_Cutoff),
				GROUP,
				find_total_mvr_info(LEFT, ROWS(RIGHT)));
			
	RETURN mvr_out_rec;
  END;

	EXPORT fn_get_watercraft_info(DATASET(PBF_Layout.Combined_Attributes) current_result,
																BOOLEAN Current_Only) := FUNCTION

		watercraft_rec := RECORD
			UNSIGNED4 seq := 0;
			UNSIGNED6 did := 0;
			STRING30  watercraft_key := '';
			STRING2   state_origin := '';
			STRING6   watercraft_date := '';
			STRING6   expiration_date := '';
		END;
		
		watercraft_rec convert_watercraft(PBF_Layout.Combined_Attributes le,
																			RECORDOF(Watercraft.key_watercraft_did()) ri) := TRANSFORM
			SELF.seq := (UNSIGNED)le.seq;
			SELF.did := le.did;
			SELF.watercraft_key := ri.watercraft_key;
			SELF.state_origin := ri.state_origin;
		END;
		
		watercraft_by_did :=
			JOIN(current_result, Watercraft.key_watercraft_did(),
				KEYED(LEFT.did = RIGHT.l_did),
				convert_watercraft(LEFT, RIGHT),
				ATMOST(ut.limits.WATERCRAFT_PER_DID));
				
		watercraft_rec convert_watercraft_date(watercraft_rec le,
																					 RECORDOF(Watercraft.key_watercraft_wid()) ri) := TRANSFORM
			// The expiration date can be null, so use the registration as a backup.
			// We're adding the 0s because the expiration dates only have the year portion and we're
			//   adding it to the registration_date, just in case.
			SELF.watercraft_date := IF(ri.registration_expiration_date != '',
																 (UNSIGNED)ri.registration_expiration_date + '00',
																 (UNSIGNED)ri.registration_date + '00');
			SELF.expiration_date := ri.registration_expiration_date;
																 
			SELF := le;
		END;
		
		watercraft_total_rec :=
			DEDUP(
				SORT(
					JOIN(watercraft_by_did, watercraft.key_watercraft_wid(),
						KEYED(LEFT.state_origin = RIGHT.state_origin AND
									LEFT.watercraft_key = RIGHT.watercraft_key),
						convert_watercraft_date(LEFT, RIGHT),
						ATMOST(ut.limits.WATERCRAFT_PER_HULL)),
					(UNSIGNED)seq, did, watercraft_key, -watercraft_date, RECORD),
				seq, did, watercraft_key);
							
		PBF_Layout.Combined_Attributes find_total_watercraft(PBF_Layout.Combined_Attributes le,
																												 DATASET(watercraft_rec) ri) := TRANSFORM
			SELF.watercraft_count := COUNT(ri);
			
			SELF := le;
		END;
	
		results := DENORMALIZE(current_result, watercraft_total_rec,
		  (UNSIGNED)LEFT.seq = RIGHT.seq AND
			// Since ut.MonthsApart uses the absolute value, we don't want to accidentally chop off
			// any records where the expriration date is in the future... hence the next AND condition.
			IF( (UNSIGNED3)(RIGHT.watercraft_date[1..6]) > LEFT.max_date, 
			   TRUE,
				 ToNumericYYYYMM(RIGHT.watercraft_date) BETWEEN LEFT.min_date AND LEFT.max_date) AND
			// Only want records that are considered current, when that option is selected.
			IF(Current_Only, RIGHT.expiration_date = '' OR RIGHT.watercraft_date > todays_date, TRUE), 
		  GROUP,
			find_total_watercraft(LEFT, ROWS(RIGHT)));
					
		RETURN results;
	END;

	EXPORT fn_get_aircraft_info(DATASET(PBF_Layout.Combined_Attributes) current_result,
															BOOLEAN Current_Only) := FUNCTION

    // NOTE: The ATMOST in the joins are mirroring what was coded for getting the aircraft count
		//       in RiskIndicators.Boca_Shell_Aircraft.
		
    aircraft_rec := RECORD
      UNSIGNED4 seq := 0;
		  UNSIGNED6 did := 0;
	    UNSIGNED6 aircraft_id := 0;
	    STRING8   n_number := '';
			STRING6   last_action_date := '';
			STRING1   current_flag := '';
    END;

		key_did := faa.key_aircraft_did ();		
		aircraft_rec get_aircraft_id(PBF_Layout.Combined_Attributes le,
	                               key_did ri) := TRANSFORM
			SELF.seq := (UNSIGNED)le.seq;
		  SELF.did := le.did;
			SELF.aircraft_id := ri.aircraft_id;
			SELF.n_number := ri.n_number;
		END;

    aircraft_by_did := JOIN(current_result, key_did,
									       KEYED(LEFT.did = RIGHT.did),
												 get_aircraft_id(LEFT, RIGHT),
												 ATMOST(KEYED(LEFT.did = RIGHT.did), RiskWise.max_atmost));

		key_id := faa.key_aircraft_id ();
		aircraft_rec get_aircraft_date(aircraft_rec le,
	                                 key_id ri) := TRANSFORM
			SELF.last_action_date := ri.last_action_date[1..6];
			SELF.current_flag := ri.current_flag;

			SELF := le;
		END;
											
    aircraft_total_rec := DEDUP(
		                        SORT(
		                          JOIN(aircraft_by_did, key_id,
											          KEYED(LEFT.aircraft_id = RIGHT.aircraft_id),
												        get_aircraft_date(LEFT, RIGHT),
																ATMOST(RiskWise.max_atmost)),
														  (UNSIGNED)seq, did, n_number, -last_action_date, RECORD),
														seq, did, n_number);

	  PBF_Layout.Combined_Attributes find_total_aircraft(PBF_Layout.Combined_Attributes le,
	                                                     DATASET(aircraft_rec) ri) := TRANSFORM
	    SELF.aircraft_count := COUNT(ri);
			
	    SELF := le;
	  END;
		
		results := DENORMALIZE(current_result, aircraft_total_rec,
		         (UNSIGNED)LEFT.seq = RIGHT.seq AND
						 ToNumericYYYYMM(RIGHT.last_action_date) BETWEEN LEFT.min_date AND LEFT.max_date AND 
			       // Only want records that are considered current, when that option is selected.
						 IF(Current_Only, RIGHT.current_flag = 'A', TRUE),
		         GROUP,
			       find_total_aircraft(LEFT, ROWS(RIGHT)));
		
	  RETURN results;
  END;

	EXPORT fn_get_prof_license_info(DATASET(PBF_Layout.Combined_Attributes) current_result,
																	BOOLEAN Current_Only) := FUNCTION

    // NOTE: The ATMOST in the join is mirroring what was coded for getting the professional
		//       license count in RiskIndicators.Boca_Shell_Proflic.  We also mimic the logic that the
		//       license type shown is the first one encountered, even if there are more than 1 type
		//       per person.
		// DIFFERENCE: The Boca Shell would only count licenses with expiration dates greater than
		//             today's date... this function does not follow that logic.
		
    prof_license_rec := RECORD
      UNSIGNED4 seq := 0;
		  UNSIGNED6 did := 0;
	    STRING50  prolic_key := '';
	    STRING6   date_most_recent := '';
			STRING60  license_type := '';
    END;
		
		prof_license_rec get_license_key(PBF_Layout.Combined_Attributes le,
	                                   RECORDOF(Prof_LicenseV2.Key_Proflic_Did()) ri) := TRANSFORM
			SELF.seq := (UNSIGNED)le.seq;
		  SELF.did := le.did;
			SELF.prolic_key := ri.prolic_key;
			SELF.date_most_recent := ri.date_last_seen[1..6];
			SELF.license_type := ri.license_type;
		END;

    license_rec := DEDUP(
		                 SORT(
		                   JOIN(current_result, Prof_LicenseV2.Key_Proflic_Did(),
									       KEYED(LEFT.did = RIGHT.did) AND
									       RIGHT.prolic_key != '' AND
			                   IF( (UNSIGNED3)(RIGHT.expiration_date[1..6]) > Left.max_date,
			                      TRUE,
														ToNumericYYYYMM(RIGHT.expiration_date) BETWEEN LEFT.min_date AND LEFT.max_date) AND
			                   // Only want records that are considered current, when that option is selected.
			                   IF(Current_Only,
												    RIGHT.expiration_date = '' OR RIGHT.expiration_date > todays_date_full,
														TRUE),
										     get_license_key(LEFT, RIGHT),
										     ATMOST(LEFT.did = RIGHT.did, RiskWise.max_atmost)),
											 (UNSIGNED)seq, did, prolic_key, -date_most_recent),
										 seq, did, prolic_key);
																						
	  PBF_Layout.Combined_Attributes find_total_licenses(PBF_Layout.Combined_Attributes le,
	                                                     prof_license_rec ri,
																											 INTEGER C) := TRANSFORM
	    SELF.prof_license_count := C;
			SELF.license_type := IF(le.license_type != '', le.license_type, ri.license_type);
			
	    SELF := le;
	  END;

		results := DENORMALIZE(current_result, license_rec,
		         (UNSIGNED)LEFT.seq = RIGHT.seq,
			       find_total_licenses(LEFT, RIGHT, COUNTER));
		
	  RETURN results;
  END;

	EXPORT fn_get_business_affiliation_info(DATASET(PBF_Layout.Combined_Attributes) current_result) := FUNCTION

    UNSIGNED1 BUSINESS_AFFILIATION_MAX := 100;
		
    business_rec := RECORD
      UNSIGNED4 seq := 0;
		  UNSIGNED6 did := 0;
			STRING30  corp_key := '';
      STRING15  name_first := '';
			STRING20  name_last := '';
			UNSIGNED3 date_first_seen := 0;
			UNSIGNED3 date_last_seen  := 0;
			UNSIGNED3 max_date        := 0;
    END;
		
		business_rec get_corpkey(PBF_Layout.Combined_Attributes le, 
	                           Corp2.Key_cont_did ri) := TRANSFORM
			SELF.seq := (UNSIGNED)le.seq;
		  SELF := ri;
			SELF := le;
		END;

    corpkey_by_did := JOIN(current_result, Corp2.Key_cont_did,
									      KEYED(LEFT.did = RIGHT.did),
											  get_corpkey(LEFT, RIGHT),
												LIMIT(BUSINESS_AFFILIATION_MAX, SKIP));
											
		business_rec get_owner_officer_dates(business_rec le,
	                                      Corp2.Key_Cont_Corpkey ri) := TRANSFORM
			SELF.date_first_seen := ToYYYYMM(ri.dt_first_seen);
			SELF.date_last_seen := ToYYYYMM(ri.dt_last_seen);
			SELF := le;
		END;
		
		// Due to the nature of the Contact Corpkey file, EVERY record in there is considered an Officer
		// or an Owner (mainly Officer).  No description or title detection necessary. NOTE that the
		// boolean expression "(UNSIGNED3)todays_date != LEFT.max_date" is equivalent to "Is Archive Mode".
    owner_officer_rec := JOIN(corpkey_by_did, Corp2.Key_Cont_Corpkey,
											     KEYED(LEFT.corp_key = RIGHT.corp_key) AND
												   (RIGHT.record_type = CURRENT OR (UNSIGNED3)todays_date != LEFT.max_date),  
												   get_owner_officer_dates(LEFT, RIGHT),
													 LIMIT(BUSINESS_AFFILIATION_MAX, SKIP));

		business_rec get_agent_date(business_rec le, Corp2.Key_Corp_Corpkey ri) := TRANSFORM
			SELF.date_first_seen := ToYYYYMM(ri.dt_first_seen);
			SELF.date_last_seen := ToYYYYMM(ri.dt_last_seen);
			SELF := le;
		END;

		// NOTE again that the boolean expression "(UNSIGNED3)todays_date != LEFT.max_date" is equivalent 
		// to "Is Archive Mode".
    agent_rec := JOIN(corpkey_by_did, Corp2.Key_Corp_Corpkey,
									 KEYED(LEFT.corp_key = RIGHT.corp_key) AND
									 (RIGHT.record_type = CURRENT OR (UNSIGNED3)todays_date != LEFT.max_date) AND 
									 ((LEFT.name_first = RIGHT.corp_ra_fname1 AND
									   LEFT.name_last = RIGHT.corp_ra_lname1) OR
										(LEFT.name_first = RIGHT.corp_ra_fname2 AND
										 LEFT.name_last = RIGHT.corp_ra_lname2)),
									 get_agent_date(LEFT, RIGHT),
									 LIMIT(BUSINESS_AFFILIATION_MAX, SKIP));

    affiliation_rec := owner_officer_rec + agent_rec;
		
		// Rollup to obtain widest date ranges for each corp_key regardless of affiliation.
		affiliation_recs_sorted := SORT(affiliation_rec, seq, did, corp_key);
		
		affiliation_recs_rolled :=
			ROLLUP(
				affiliation_recs_sorted,
				TRANSFORM( business_rec,
					SELF.date_first_seen := IF( RIGHT.date_first_seen <= LEFT.date_first_seen, RIGHT.date_first_seen, LEFT.date_first_seen ),
					SELF.date_last_seen := IF( RIGHT.date_last_seen >= LEFT.date_last_seen, RIGHT.date_last_seen, LEFT.date_last_seen ),
					SELF := RIGHT
				),
				seq, did, corp_key
			);
		
	  PBF_Layout.Combined_Attributes find_total(PBF_Layout.Combined_Attributes le, DATASET(business_rec) ri) := TRANSFORM
	    SELF.affiliation_count := COUNT(ri);
	    SELF := le;
	  END;

		results := DENORMALIZE(current_result, affiliation_rec,
		         (UNSIGNED)LEFT.seq = RIGHT.seq AND
						 RIGHT.date_first_seen <= LEFT.max_date AND
						 RIGHT.date_last_seen >= LEFT.min_date,
		         GROUP,
			       find_total(LEFT, ROWS(RIGHT)));

    RETURN results;
  END;
	
	EXPORT fn_get_paw_info(DATASET(PBF_Layout.Combined_Attributes) current_result,
												 BOOLEAN Current_Only) := FUNCTION
		
    paw_rec := RECORD
      UNSIGNED4 seq := 0;
		  UNSIGNED6 did := 0;
			UNSIGNED6 contact_id := 0;
	    STRING6   date_last_seen := '';
			STRING8   full_date_last_seen := '';
			STRING8   date_first_seen := '';
			STRING1   record_type := '';
    END;
		
		paw_rec get_contact_id(PBF_Layout.Combined_Attributes le, PAW.Key_Did ri) := TRANSFORM
			SELF.seq := (UNSIGNED)le.seq;
		  SELF.did := le.did;
			SELF.contact_id := ri.contact_id;
		END;

    paw_did_rec := JOIN(current_result, PAW.Key_Did,
	                   KEYED(LEFT.did = RIGHT.did),
							       get_contact_id(LEFT, RIGHT),
							       ATMOST(20000)); //  is modeled after a function in PAW_Raw
										
		paw_rec get_paw_date(paw_rec le, PAW.Key_contactID ri) := TRANSFORM
			SELF.date_last_seen := ri.dt_last_seen;
			SELF.full_date_last_seen := ri.dt_last_seen;
			SELF.date_first_seen := ri.dt_first_seen;
			SELF.record_type := ri.record_type;
			
			SELF := le;
		END;

    paw_contact_id_rec :=
		  DEDUP(
		    SORT(
		      JOIN(paw_did_rec, PAW.Key_contactID,
						KEYED(LEFT.contact_id = RIGHT.contact_id) AND
				    // Don't want to automatically count a record that has no date last seen
						RIGHT.dt_last_seen != '',
						get_paw_date(LEFT, RIGHT),
						ATMOST(ut.limits.PAW_PER_CONTACTID)), // is modeled after a function in PAW_Raw, < 26 recs per id in index
					(UNSIGNED)seq, did, contact_id, -date_last_seen, RECORD),
				seq, did, contact_id);
																						
	  PBF_Layout.Combined_Attributes get_paw_count_on_input_date(PBF_Layout.Combined_Attributes le,
	                                                             DATASET(paw_rec) ri) := TRANSFORM
	    SELF.paw_count := COUNT(ri);
		  SELF           := le;
	  END;

		results := DENORMALIZE(current_result, paw_contact_id_rec,
		    (UNSIGNED)LEFT.seq = RIGHT.seq AND
				// Don't want a false positive if the user forgets to give us an input date.  Since
        // date first seen can = 0, an empty input date could return true with the between
				// logic... so don't allow a null input date.
				LEFT.input_date != '' AND
				(UNSIGNED)LEFT.input_date
				  BETWEEN (UNSIGNED)RIGHT.date_first_seen AND (UNSIGNED)RIGHT.full_date_last_seen AND
			  // Only want records that are considered current, when that option is selected.
				IF(Current_Only, RIGHT.record_type = CURRENT, TRUE),
				GROUP,
			  get_paw_count_on_input_date(LEFT, ROWS(RIGHT)));
		
    RETURN results;
  END;

	EXPORT fn_get_bankruptcy_info(DATASET(PBF_Layout.Combined_Attributes) current_result,
																BOOLEAN Current_Only) := FUNCTION

    // NOTE: The key file for DIDs currently only exists in V2 for production.  This is something
		//       to keep an eye on... if the V3 key file for DIDs comes into existance, it'll need to
		//       replace the V2 version in the code below.
		
    bankruptcy_rec := RECORD
      UNSIGNED4 seq := 0;
		  UNSIGNED6 did := 0;
	    STRING50  TMSID := '';
	    STRING5   court_code;
	    STRING7   case_number;
			STRING6   date_filed := '';
    END;
		
		bankruptcy_rec get_bankruptcy_id(PBF_Layout.Combined_Attributes le,
	                                   RECORDOF(BankruptcyV3.key_bankruptcyV3_did()) ri) := TRANSFORM
			SELF.seq := (UNSIGNED)le.seq;
		  SELF.did := le.did;
			SELF.TMSID := ri.TMSID;
			SELF.case_number := ri.case_number;
			SELF.court_code := ri.court_code;
		END;

    bankruptcy_by_did := JOIN(current_result, BankruptcyV3.key_bankruptcyV3_did(),
									         KEYED(LEFT.did = RIGHT.did),
												   get_bankruptcy_id(LEFT, RIGHT),
													 ATMOST(ut.limits.BANKRUPT_PER_DID));
											
		bankruptcy_rec get_bankruptcy_date(bankruptcy_rec le,
	                                     RECORDOF(BankruptcyV3.key_bankruptcyv3_search_full_bip()) ri) := TRANSFORM
			SELF.date_filed := ri.date_filed[1..6];
			SELF            := le;
		END;
											
    bankruptcy_total_rec := DEDUP(
		                          SORT(
		                            JOIN(bankruptcy_by_did, BankruptcyV3.key_bankruptcyv3_search_full_bip(),
											            KEYED(LEFT.TMSID = RIGHT.TMSID) AND
																	LEFT.case_number = RIGHT.case_number AND
																	LEFT.court_code = RIGHT.court_code AND
																	TRIM(RIGHT.name_type) = 'D' AND // only want Debtors
																	// "current" is anything except dismissal, discharge, or closed
																	IF(Current_Only, RIGHT.dCode NOT IN ['15', '20', '99'], TRUE),
												          get_bankruptcy_date(LEFT, RIGHT),
																	ATMOST(ut.limits.BANKRUPT_MAX)),
														    (UNSIGNED)seq, did, court_code, case_number, -date_filed, RECORD),
														  seq, did, court_code, case_number);
															
	  PBF_Layout.Combined_Attributes find_total_bankruptcy(PBF_Layout.Combined_Attributes le,
	                                                       DATASET(bankruptcy_rec) ri) := TRANSFORM
	    SELF.bankruptcy_count := COUNT(ri);
	    SELF                  := le;
	  END;
	
		results := DENORMALIZE(current_result, bankruptcy_total_rec,
		         (UNSIGNED)LEFT.seq = RIGHT.seq
						 AND ToNumericYYYYMM(RIGHT.date_filed) BETWEEN LEFT.min_date AND LEFT.max_date,
		         GROUP,
			       find_total_bankruptcy(LEFT, ROWS(RIGHT)));
						 
	  RETURN results;
  END;

	EXPORT fn_get_liens_info(DATASET(PBF_Layout.Combined_Attributes) current_result) := FUNCTION

    liens_rec := RECORD
      UNSIGNED4 seq := 0;
		  UNSIGNED6 did := 0;
	    STRING50  TMSID := '';
	    STRING50  RMSID := '';
			STRING6   filing_date := '';
    END;
		
		liens_rec get_liens_id(PBF_Layout.Combined_Attributes le,
	                         LiensV2.key_liens_DID ri) := TRANSFORM
			SELF.seq := (UNSIGNED)le.seq;
		  SELF.did := le.did;
			SELF.TMSID := ri.TMSID;
			SELF.RMSID := ri.RMSID;
		END;

    liens_by_did := JOIN(current_result, LiensV2.key_liens_DID,
									    KEYED(LEFT.did = RIGHT.did),
											get_liens_id(LEFT, RIGHT),
											ATMOST(ut.limits.DEFAULT));
											
    liens_party_rec := DEDUP(
		                     SORT(
		                       JOIN(liens_by_did, LiensV2.key_liens_party_ID,
											       KEYED(LEFT.tmsid = RIGHT.tmsid AND
														       LEFT.rmsid = RIGHT.rmsid) AND
														 RIGHT.name_type = 'D' AND // only want the debtors
														 RIGHT.date_last_seen = '', // only want the recent liens
												     TRANSFORM(liens_rec, SELF := LEFT),
														 ATMOST(ut.limits.DEFAULT)),
													 seq, did, tmsid, rmsid, RECORD),
												 seq, did, tmsid, rmsid);

		liens_rec get_liens_date(liens_rec le, LiensV2.key_liens_main_ID ri) := TRANSFORM
			SELF.filing_date := ri.orig_filing_date;
			SELF             := le;
		END;

    liens_total_rec := JOIN(liens_party_rec, LiensV2.key_liens_main_ID,
		                     KEYED(LEFT.tmsid = RIGHT.tmsid AND
												       LEFT.rmsid = RIGHT.rmsid) AND
												 TRIM(UCase(RIGHT.filing_type_desc)) IN Risk_Indicators.iid_constants.setCivilJudgment,
												 get_liens_date(LEFT, RIGHT),
												 ATMOST(ut.limits.DEFAULT));
												 
	  PBF_Layout.Combined_Attributes find_total_liens(PBF_Layout.Combined_Attributes le,
	                                                  DATASET(liens_rec) ri) := TRANSFORM
	    SELF.liens_count := COUNT(ri);
	    SELF             := le;
	  END;
	
		results := DENORMALIZE(current_result, liens_total_rec,
		         (UNSIGNED)LEFT.seq = RIGHT.seq
						 AND ToNumericYYYYMM(RIGHT.filing_date) BETWEEN LEFT.min_date AND LEFT.max_date,
		         GROUP,
			       find_total_liens(LEFT, ROWS(RIGHT)));
		
	  RETURN results;
  END;

	EXPORT fn_get_incarceration_info(DATASET(PBF_Layout.Combined_Attributes) current_result) := FUNCTION
	
		// Local things...:
		isntFCRA            := FALSE;
		DEPT_OF_CORRECTIONS := '1';

		layout_offenderKey 	 := RECORDOF(doxie_files.Key_Offenders(isntFCRA));
		layout_offensesKey 	 := RECORDOF(doxie_files.Key_Offenses(isntFCRA));
		layout_punishmentKey := RECORDOF(doxie_files.Key_Punishment(isntFCRA));

		layout_incarc_out := RECORD
			UNSIGNED4 seq;
			UNSIGNED6 did;
			BOOLEAN   incarc_Offenders; // use in non-historical mode only
			BOOLEAN   incarc_Offenses;
			BOOLEAN   incarc_Punishments;
			STRING60  incarc_Offender_key;
		END;

		layout_incarc_temp := RECORD
			layout_incarc_out;
			UNSIGNED3 min_date;
			UNSIGNED3 max_date;
		END;
		
		// ----------[ 1. Join to Offender key. ]----------

		// Join target DIDs to offender key and set incarceration flag if "currently incarcerated"  
		// flag is on - pick up offender keys also.
		layout_incarc_temp get_offenderKeys(PBF_Layout.Combined_Attributes l, layout_offenderKey r) := transform
			self.incarc_Offenders 		:= l.max_date = (UNSIGNED3)todays_date and r.curr_incar_flag = 'Y'; 	// set if running in current mode
			self.incarc_Offender_key 	:= r.Offender_key; 
			self.seq                  := (UNSIGNED)l.seq;
			self.min_date             := l.min_date;
			self.max_date             := l.max_date;
			self											:= l;
			self                      := [];
		end;	

		offenderKeys := 
			join(
				current_result, doxie_files.Key_Offenders(isntFCRA), 
				keyed(left.did = right.sdid),
				get_offenderKeys(left, right),
				left outer, atmost(riskwise.max_atmost * 5)
			);

		sortedOffenderKeys := sort(offenderKeys, seq, incarc_Offender_key, -incarc_Offenders);  
		
		// Rollup by sequence and offender key to set the incarceration flag for each offender record
		layout_incarc_temp rollOffenderKeys(layout_incarc_temp l, layout_incarc_temp r) := transform
			self.incarc_Offenders 	:= if(r.incarc_Offenders, r.incarc_Offenders, l.incarc_Offenders);
			self										:= l;
		end;
		
		rolledOffenderKeys := rollup( sortedOffenderKeys, rollOffenderKeys(left,right), seq, incarc_Offender_key );

		// ----------[ 2. Join to Punishment key. ]----------

		// Join the offender keys to punishments and set incarceration flag if the max_date 
		// (i.e. the archive date) falls anywhere during the time of incarceration.
		layout_incarc_temp get_punishments(layout_incarc_temp l, layout_punishmentKey r) := transform
			incarc_begin_date	:= if(r.latest_adm_dt[1..6] <> '', r.latest_adm_dt[1..6], ''); 
			incarc_end_date   := map(
                             r.act_rel_dt <> '' => r.act_rel_dt[1..6],	
                             r.ctl_rel_dt <> '' => r.ctl_rel_dt[1..6],	//release dates if populated
                             r.sch_rel_dt <> '' => r.sch_rel_dt[1..6],
                             /* default...... */   ''
                           );
			self.incarc_Punishments := 
					incarc_begin_date <> '' and incarc_end_date <> '' and 
					l.max_date BETWEEN (UNSIGNED3)incarc_begin_date AND (UNSIGNED3)incarc_end_date;
			self := l;
			self := [];
		end;	
			
		punishments := 
			join(
				rolledOffenderKeys, doxie_files.Key_Punishment(isntFCRA), 
				keyed(left.incarc_Offender_key = right.ok),
				get_punishments(left, right),
				left outer, atmost(riskwise.max_atmost)
			);

		sortedPunishments := sort(punishments, seq, incarc_Offender_key, -incarc_Punishments);  
		
		// Rollup by sequence to set the incarceration flag if any of the person's offender records show 
		// that he/she is currently incarcerated
		layout_incarc_temp rollPunishments(layout_incarc_temp l, layout_incarc_temp r) := transform
			self.incarc_Punishments := if(r.incarc_Punishments, r.incarc_Punishments, l.incarc_Punishments);
			self.incarc_Offenders 	:= if(r.incarc_Offenders, r.incarc_Offenders, l.incarc_Offenders);
			self										:= l;
			self                    := [];
		end;
		
		rolledPunishments := rollup(sortedPunishments, rollPunishments(left,right), seq, incarc_Offender_key);

		// ----------[ 3. Join to Offenses key. ]----------

		// Join the offender keys to offenses and set incarceration flag if the max_date 
		// (i.e. the archive date) falls anywhere during the time of incarceration.
		layout_incarc_temp get_offenses(layout_incarc_temp l, layout_offensesKey r) := transform
			// Parse incarceration or sentencing information out ofstc_desc fields
			posBeg := stringlib.stringfind(r.stc_desc_2, 'Date:', 1);  // format is 'Sent Start Date: yyyymmdd Sent End Date: yyyymmdd'
			posEnd := stringlib.stringfind(r.stc_desc_2, 'Date:', 2);
			
			beg_dt	:= if(posBeg <> 0, r.stc_desc_2[posBeg+6..posBeg+11], '');  // position at start date and grab yyyymm
			end_dt	:= if(posEnd <> 0, r.stc_desc_2[posEnd+6..posEnd+11], '');  // position at end date and grab yyyymm

			beg_dt_isNumeric := Risk_Indicators.IsAllNumeric(beg_dt);
			end_dt_isNumeric := Risk_Indicators.IsAllNumeric(end_dt);

			incarc_begin_date := if(beg_dt_isNumeric, beg_dt, '');  
			incarc_end_date := if(end_dt_isNumeric, end_dt, if(trim(r.stc_lgth_desc) = 'LIFE', '999999', ''));  // if life sentence, set end date to max

			self.incarc_Offenses := 
					incarc_begin_date <> '' and incarc_end_date <> '' and 
					l.max_date BETWEEN (UNSIGNED3)incarc_begin_date AND (UNSIGNED3)incarc_end_date;
			self := l;
			self := [];
		end;	

		offenses := join(rolledPunishments, doxie_files.Key_Offenses(isntFCRA), 
										keyed(left.incarc_Offender_key = right.ok),
										get_offenses(left, right),
										left outer, atmost(riskwise.max_atmost * 5));

		sortedOffenses := sort(offenses, seq, -incarc_Offenses);  
		
		// Rollup by sequence to set the incarceration flag if any of the person's offender records show 
		// that he/she is currently incarcerated
		layout_incarc_temp rollOffenses(layout_incarc_temp l, layout_incarc_temp r) := transform
			self.incarc_Offenses    := if(r.incarc_Offenses, r.incarc_Offenses, l.incarc_Offenses);
			self.incarc_Punishments := if(r.incarc_Punishments, r.incarc_Punishments, l.incarc_Punishments);
			self.incarc_Offenders 	:= if(r.incarc_Offenders, r.incarc_Offenders, l.incarc_Offenders);
			self										:= l;
			self                    := [];
		end;
		
		incarceration_recs := rollup(sortedOffenses, rollOffenses(left,right), seq);

		// The batch service will only bring back a record if the person is in jail
		PBF_Layout.Combined_Attributes add_incarceration_info(PBF_Layout.Combined_Attributes le, layout_incarc_temp ri) := 
			TRANSFORM
				SELF.is_in_jail := TRUE IN [ ri.incarc_Offenses, ri.incarc_Punishments, ri.incarc_Offenders ];
				SELF            := le;
				SELF := [];
			END;
		
		// ATMOST unneeded, since it's a 1-to-1 situation
		results := JOIN(current_result, incarceration_recs,
		         (UNSIGNED)LEFT.seq = RIGHT.seq,
						 add_incarceration_info(LEFT, RIGHT),
						 LEFT OUTER);
		
    RETURN results;
  END;
	
	EXPORT fn_get_sofr_info(DATASET(PBF_Layout.Combined_Attributes) current_result) := FUNCTION

    Input_Layout := SexOffender_Services.Layouts.batch_in;
		Output_Layout := SexOffender_Services.Layouts.rec_offender_plus_acctno;
		
	  Input_Layout xfm_to_batch_input(PBF_Layout.Combined_Attributes le) := TRANSFORM
	    SELF.acctno := le.seq;
			SELF.did := le.did;
			SELF.ssn := le.ssn;
	    SELF.name_first := le.name_first;
	    SELF.name_last := le.name_last;
	    SELF.prim_range := le.prim_range;
	    SELF.predir := le.predir;
	    SELF.prim_name := le.prim_name;
	    SELF.addr_suffix := le.addr_suffix;
	    SELF.postdir := le.postdir;
	    SELF.p_city_name := le.city_name;
	    SELF.st := le.st;
	    SELF.z5 := le.z5;

	    SELF := [];
	  END;

    SOFR_batch_in := PROJECT(current_result, xfm_to_batch_input(LEFT));
		
		SOFR_batch_params		:= MODULE(PROJECT(BatchShare.IParam.getBatchParamsV2(), SexOffender_Services.IParam.batch_params, opt)) END;
		SOFR_module_return 	:= SexOffender_Services.batch_records(SOFR_batch_params, SOFR_batch_in);
		
		offenders := SOFR_module_return.offenders;		

		PBF_Layout.Combined_Attributes add_sofr_info(PBF_Layout.Combined_Attributes le,
		                                             DATASET(Output_Layout) ri) := TRANSFORM
			SELF.acctno   := le.acctno;
			SELF.seq      := le.seq;
		  SELF.has_sofr := COUNT(ri) > 0;
			SELF          := le;
			SELF          := [];
		END;
		
		results := DENORMALIZE(current_result, offenders,
		         LEFT.seq = RIGHT.acctno AND
						 ToNumericYYYYMM(RIGHT.dt_first_reported) <= LEFT.max_date, // No min_date; once a sex offender, always a sex offender
		         GROUP,
			       add_sofr_info(LEFT, ROWS(RIGHT)));

	  RETURN results;
  END;

	EXPORT fn_get_UCC_info(DATASET(PBF_Layout.Combined_Attributes) current_result,
												 BOOLEAN Current_Only) := FUNCTION
												 
/* This list is current as of 06/24/11 (we're ignoring case... many types have a lower and upper case version)

   "Active Types"                            "Inactive Types"
   --------------                            ----------------
   INITIAL FILING                            TERMINATION
   CONTINUATION                              UCC3 TERMINATION
   AMENDMENT                                 UCC3 CONTINUATION
   UCC STANDARD                              RELEASE
   ASSIGNMENT                                T/L INSTR
   Continuation                              ASSIGNMENT TO A SECURED PARTY
   PARTIAL RELEASE                           MISC AMENDMENT
   UCC3 AMENDMENT                            DEBTOR AMENDMENT (FORMAT 01)
   Amendment, Master Amendment               REL INSTR
   Assignment, Full Master Assignment        UCC3 RELEASE
   UCC3 ASSIGNMENT                           INSTR
   AMENDMENT TO A SECURED PARTY              SUBORDINATION
                                             SEE INSTR
                                             TRAILER
                                             UCC3 ERRONEOUS TERMINATION
                                             FILING OFFICER STATEMENT
                                             TV ETC
                                             INV ETC
                                             UCC3 FILING OFFICER STATEMENT
                                             Correction
                                             INV
                                             TRAILER ETC
                                             T/L IRS-SEE INSTR-
                                             PIANO
                                             TRACTOR ETC
*/

    active_list := ['INITIAL FILING', 'CONTINUATION', 'AMENDMENT', 'UCC STANDARD', 'ASSIGNMENT',
		                'PARTIAL RELEASE', 'UCC3 AMENDMENT', 'AMENDMENT, MASTER AMENDMENT',
										'ASSIGNMENT, FULL MASTER ASSIGNMENT', 'UCC3 ASSIGNMENT',
										'AMENDMENT TO A SECURED PARTY'];

    UCC_rec := RECORD
      UNSIGNED4 seq := 0;
		  UNSIGNED6 did := 0;
	    STRING31  tmsid := '';
	    STRING23  rmsid := '';
			STRING6   filing_date := '';
    END;
		
		key_ucc_did := UCCV2.Key_Did_w_Type ();
		UCC_rec get_UCC_id(PBF_Layout.Combined_Attributes le,
	                     key_ucc_did ri) := TRANSFORM
			SELF.seq := (UNSIGNED)le.seq;
		  SELF.did := le.did;
			SELF.tmsid := ri.tmsid;
		END;

    UCC_by_did := JOIN(current_result, key_ucc_did,
									  KEYED(LEFT.did = RIGHT.did) AND
										RIGHT.party_type = 'D', // we want Debtors only
									  get_UCC_id(LEFT, RIGHT),
										ATMOST(ut.limits.DEFAULT));

		key_ucc_rmsid := UCCV2.Key_Rmsid_Main ();
		
		UCC_rec get_UCC_date(UCC_rec le, key_ucc_rmsid ri) := TRANSFORM
			SELF.filing_date := ri.filing_date[1..6];
			SELF.rmsid       := ri.rmsid;
			SELF             := le;
		END;
											
    UCC_total_rec_nologic := SORT(
		                           JOIN(UCC_by_did, key_ucc_rmsid,
											           KEYED(LEFT.tmsid = RIGHT.tmsid) AND
												         TRIM(UCase(RIGHT.filing_type)) IN active_list,
																 ATMOST(ut.limits.DEFAULT)),
											         (UNSIGNED)seq, did, tmsid, RECORD);

    UCC_total_rec := SORT(
		                   JOIN(UCC_by_did, key_ucc_rmsid,
											   KEYED(LEFT.tmsid = RIGHT.tmsid) AND
												 TRIM(UCase(RIGHT.filing_type)) IN active_list AND
			                   // Only want records that are considered current, when that option is selected.
												 // It's the combination of being in the active list and not being expired that
												 //   we can call the record "current".
												 IF(Current_Only,
												    RIGHT.expiration_date = '' OR RIGHT.expiration_date > todays_date_full,
														TRUE),
											   get_UCC_date(LEFT, RIGHT),
												 ATMOST(ut.limits.DEFAULT)),
											 (UNSIGNED)seq, did, tmsid, RECORD);

	  PBF_Layout.Combined_Attributes find_total_UCC(PBF_Layout.Combined_Attributes le,
	                                                DATASET(UCC_rec) ri) := TRANSFORM
			// The dataset has already been sorted, so no need to worry about the order.
			UCC_rec_deduped := DEDUP(ri, seq, did, tmsid);
													 
	    SELF.UCC_count := COUNT(UCC_rec_deduped);
	    SELF           := le;
	  END;
	
		results := DENORMALIZE(current_result, UCC_total_rec,
		         (UNSIGNED)LEFT.seq = RIGHT.seq AND
						 ToNumericYYYYMM(RIGHT.filing_date) BETWEEN LEFT.min_date AND LEFT.max_date,
		         GROUP,
			       find_total_UCC(LEFT, ROWS(RIGHT)));
		
	  RETURN results;
  END;

	EXPORT fn_get_high_risk_info(DATASET(PBF_Layout.Combined_Attributes) current_result) := FUNCTION

    UNSIGNED1 maxHriPer_value := 10; // Needed for the macro: doxie.mac_AddHRIAddress
		
		PBF_Layout.Combined_Attributes get_high_risk_info(PBF_Layout.Combined_Attributes le,
	                                                    Advo.Key_Addr1 ri) := TRANSFORM
		  SELF.address_vacant := CASE(ri.address_vacancy_indicator,
				                       'Y' => '1',
		                           'N' => '0',
					                     '-1');
			SELF.address_business :=
			  MAP(
				  le.caaddress = '' => '-1',
					ri.address_vacancy_indicator = '' => '-1', // no indicator, no ADVO record
					// The indicator of 'B' means 100% business and 'D' means primarily business with some
					// residential aspect to it.
					ri.residential_or_business_ind IN ['B', 'D'] AND ri.address_type = '0' => '1',
					'0');

			SELF := le;
		END;

    high_risk_advo_rec := JOIN(current_result, Advo.Key_Addr1,
	                          KEYED(LEFT.ca_prim_range != '' AND
														      LEFT.cazip = RIGHT.zip AND
						                      LEFT.ca_prim_range = RIGHT.prim_range AND
						                      LEFT.ca_prim_name = RIGHT.prim_name AND
		                              LEFT.ca_addr_suffix = RIGHT.addr_suffix AND
			                            LEFT.ca_predir = RIGHT.predir AND
			                            LEFT.ca_postdir = RIGHT.postdir AND
		                              LEFT.ca_sec_range = RIGHT.sec_range),
											      get_high_risk_info(LEFT, RIGHT),
											      LEFT OUTER,
														ATMOST(ut.limits.DEFAULT));
											
    // This transform code comes from Risk_Indicators.Boca_Shell_FCRA_Neutral_Function (getDwell)
		PBF_Layout.Combined_Attributes get_high_risk_address_type(PBF_Layout.Combined_Attributes le) := TRANSFORM
	    a1_val := Risk_Indicators.MOD_AddressClean.street_address('', le.ca_prim_range, le.ca_predir,
																				                        le.ca_prim_name, le.ca_addr_suffix,
																				                        le.ca_postdir, le.ca_unit_desig,
																				                        le.ca_sec_range);
	
	    clean_a2 := Risk_Indicators.MOD_AddressClean.clean_addr(a1_val, le.cacity, le.castate,
																				                      le.cazip);
	
	    // NOTE: Make sure to periodically check to see if any codes are added to this list from
			//       the code inside Risk_Indicators.Boca_Shell_FCRA_Neutral_Function.
	    invalidSet := ['E101', 'E212', 'E213', 'E214', 'E216', 'E302', 'E412', 'E413', 'E420',
			               'E421', 'E423', 'E500', 'E501', 'E502', 'E503', 'E600'];	// added E600 6/6/2005 per Jim C.
	
	    SELF.ca_address_type := IF(clean_a2[139] = 'S' AND clean_a2[179..182] IN invalidSet,
			                           '',
																 clean_a2[139]);
																 
			SELF := le;
		END;

    address_type_rec := PROJECT(high_risk_advo_rec, get_high_risk_address_type(LEFT));
		
		PBF_Layout.Combined_Attributes get_zipclass(PBF_Layout.Combined_Attributes le,
	                                              RiskWise.Key_CityStZip ri) := TRANSFORM
		  SELF.ca_zipclass := ri.zipclass;

			SELF := le;
		END;

    // A given zip code will all have the same zipclass, so we only need one record
		zipclass_rec := DEDUP(
		                  JOIN(address_type_rec, RiskWise.Key_CityStZip,
		                    KEYED(LEFT.cazip = RIGHT.zip5) AND
											  LEFT.cazip != '',
                        get_zipclass(LEFT, RIGHT),
											  LEFT OUTER,
											  ATMOST(RiskWise.max_atmost)),
											seq);

    HRI_address_rec := RECORD
      UNSIGNED4 seq := 0;
	    STRING10  prim_range := '';
	    STRING2   predir := '';	
	    STRING28  prim_name := '';	
	    STRING4   suffix := '';	
	    STRING2   postdir := '';	
	    STRING8   sec_range := '';
	    STRING5   zip := '';
			DATASET(Risk_Indicators.Layout_Desc) HRI_Address {MAXCOUNT(ut.limits.HRI_MAX)};
    END;

    HRI_address_rec xfm_to_HRI_type(PBF_Layout.Combined_Attributes le) := TRANSFORM
		  SELF.seq := (UNSIGNED)le.seq;
		  SELF.prim_range := le.ca_prim_range;
			SELF.predir := le.ca_predir;
			SELF.prim_name := le.ca_prim_name;
			SELF.suffix := le.ca_addr_suffix;
			SELF.postdir := le.ca_postdir;
			SELF.sec_range := le.ca_sec_range;
			SELF.zip := le.cazip;
		  SELF.HRI_Address := [];
		END;
		
		address_rec := PROJECT(zipclass_rec, xfm_to_HRI_type(LEFT));
		
		// Using the macro vs. just hitting just the key file in order to get the natural disaster
		// zip codes picked up.
		doxie.mac_AddHRIAddress(address_rec, HRI_output_rec);
	
		PBF_Layout.Combined_Attributes get_high_risk_address(PBF_Layout.Combined_Attributes le,
	                                                       HRI_address_rec ri) := TRANSFORM
      STRING1 POST_OFFICE_ONLY_ZIP := '1';																												 
      STRING1 UNIQUE_CORPORATE_ONLY_ZIP := '2';																												 
      STRING1 MILITARY_ZIP_OR_MULTIUNIT := '3';																												 
      STRING1 EMPTY_ADDRESS := '5';																												 
      STRING1 NOT_HIGH_RISK := '0';																												 
      STRING1 HIGH_RISK := '4';																												 
										
			// Following the Boca Shell logic that everything is NOT considered a high risk, unless it
			// gets to the end (where there is an HRI_Address in existance... ie. there's a SIC Code).
	    high_risk_address_flag :=
			  MAP(le.ca_zipclass = 'P' => POST_OFFICE_ONLY_ZIP,
						le.ca_zipclass = 'U' => UNIQUE_CORPORATE_ONLY_ZIP,
						le.ca_zipclass = 'M' OR le.ca_address_type = 'M' => MILITARY_ZIP_OR_MULTIUNIT,
						le.ca_prim_name = '' OR le.cazip = '' => EMPTY_ADDRESS,
						COUNT(ri.HRI_Address) = 0 => NOT_HIGH_RISK,
						HIGH_RISK);
																		
		  SELF.address_high_risk := IF(le.caaddress = '',
			                             '-1',
																	 IF(high_risk_address_flag = HIGH_RISK, '1', '0'));
			SELF.address_hr_codes := IF(le.caaddress = '' OR high_risk_address_flag != HIGH_RISK,
			                            DATASET([], Risk_Indicators.Layout_Desc),
																	ri.HRI_Address);

			SELF := le;
		END;

    // This can be an inner join because both datasets have the same number of records (which is all
		// of them).  The HRI_output_rec will also contain a child dataset that we use to get the reasons
		// and descriptions of the high risk info.
		// ATMOST unneeded, since it's a 1-to-1 situation
    high_risk_result := JOIN(zipclass_rec, HRI_output_rec,
		                      (UNSIGNED)LEFT.seq = RIGHT.seq,
						              get_high_risk_address(LEFT, RIGHT));
													
    PBF_Layout.Combined_Attributes flatten_high_risk_reason_codes(PBF_Layout.Combined_Attributes le) := TRANSFORM
      HR_ReasonCodes_Raw := SORT(le.address_hr_codes, -hri);
			reasons_count := COUNT(HR_ReasonCodes_Raw);
			
			SELF.CurrentBestAddrHRRC1 := IF(reasons_count >= 1, HR_ReasonCodes_Raw[1].hri, '');
			SELF.CurrentBestAddrHRDesc1 := IF(reasons_count >= 1, HR_ReasonCodes_Raw[1].desc, '');
			SELF.CurrentBestAddrHRRC2 := IF(reasons_count >= 2, HR_ReasonCodes_Raw[2].hri, '');
			SELF.CurrentBestAddrHRDesc2 := IF(reasons_count >= 2, HR_ReasonCodes_Raw[2].desc, '');
			SELF.CurrentBestAddrHRRC3 := IF(reasons_count >= 3, HR_ReasonCodes_Raw[3].hri, '');
			SELF.CurrentBestAddrHRDesc3 := IF(reasons_count >= 3, HR_ReasonCodes_Raw[3].desc, '');

      SELF := le;
		END;

		RETURN PROJECT(high_risk_result, flatten_high_risk_reason_codes(LEFT));

  END;

	EXPORT fn_get_deceased_info(DATASET(PBF_Layout.Combined_Attributes) current_result) := FUNCTION

    // GLBPurpose is picked up later through the stored attribute... no need to pass as parameter.
		
		DeathV2_Services.Layouts.BatchIn xfm_to_batch_input(PBF_Layout.Combined_Attributes le) := TRANSFORM
	    //SELF.seq := (UNSIGNED)le.seq; -- not needed.
	    SELF.acctno := le.acctno;	
	    SELF.name_first := le.name_first;
	    SELF.name_middle := le.name_middle;
	    SELF.name_last := le.name_last;
	    SELF.prim_range := le.prim_range;
	    SELF.predir := le.predir;
	    SELF.prim_name := le.prim_name;
	    SELF.addr_suffix := le.addr_suffix;
	    SELF.postdir := le.postdir;
	    SELF.unit_desig := le.unit_desig;
	    SELF.sec_range := le.sec_range;
	    SELF.p_city_name := le.city_name;
	    SELF.st := le.st;
	    SELF.z5 := le.z5;
			SELF.ssn := le.ssn;

	    SELF := [];
    END;

		new_batch_in := PROJECT(current_result, xfm_to_batch_input(LEFT));
		
		// In order, the codes mean: SSN only, SSN & Address only, Name & Address only, SSN & Name only,
		// and SSN & Name & Address.
		deceased_codes := ['S', 'SAZC', 'ANZC', 'SN', 'ANSZC'];

		// Have to translate the information into something the Death batch service can recognize.
		deathInMod := MODULE(DeathV2_Services.IParam.getBatchParams())
			EXPORT BOOLEAN  IncludeBlankDOD 		:= TRUE;
			EXPORT BOOLEAN  ExtraMatchCodes 		:= TRUE;
			EXPORT BOOLEAN  AddSupplemental 		:= TRUE;
		END;			
		
		// Note that while a person might have multiple death records, they'll have the same matchcode.
		dec_recs := DeathV2_Services.BatchRecords(new_batch_in, deathInMod);
		dec_recs_filtered := dec_recs(matchcode IN deceased_codes);		
				
		DecSortLayout := record
			BatchServices.layout_Death_Batch_out;
			integer SortOrder := 0;
		end;
		
		dec_recs_w_rc := PROJECT(dec_recs_filtered, TRANSFORM(DecSortLayout,
					SELF.SortOrder := MAP(LEFT.matchcode IN ['SN','ANSZC'] => 1,
					LEFT.matchcode IN ['ANZC'] => 2,
					LEFT.matchcode IN ['S','SAZC'] => 3,
					4), 
				SELF := LEFT));
	  //Sort by acctno and the matchcode level and then grab just one record
		deceased_recs := DEDUP(
				SORT(dec_recs_w_rc, acctno, SortOrder, RECORD),
				acctno);	

    PBF_Layout.Combined_Attributes get_death_info(PBF_Layout.Combined_Attributes le,
		                                              DecSortLayout ri) := TRANSFORM
      SELF.matchcode := ri.matchcode;
		  SELF := le;
		END;	

		// ATMOST unneeded, since it's a 1-to-1 situation
    RETURN JOIN(current_result, deceased_recs,
		         LEFT.acctno = RIGHT.acctno,
						 get_death_info(LEFT, RIGHT),
						 LEFT OUTER);

	END;

	EXPORT fn_get_duplicate_did_info(DATASET(PBF_Layout.Combined_Attributes) current_result) := FUNCTION

    PBF_Layout.Combined_Attributes get_did_count(PBF_Layout.Combined_Attributes le,
		                                             DATASET(PBF_Layout.Combined_Attributes) ri) := TRANSFORM
      SELF.repeat_did_count := COUNT(ri);

		  SELF := le;
		END;

    RETURN DENORMALIZE(current_result, current_result,
		         LEFT.did = RIGHT.did,
			       GROUP,
						 get_did_count(LEFT, ROWS(RIGHT)));
														
	END;

	EXPORT fn_get_reason_codes(DATASET(PBF_Layout.Final_Plus) input) := FUNCTION

    PBF_Layout.Final_Plus add_reason_codes(PBF_Layout.Final_Plus le) := TRANSFORM
      ReasonCodes_Raw := SORT(Models.PostBeneficiaryFraud_ReasonCodes(le), -hri);
			reasons_count := COUNT(ReasonCodes_Raw);
			
			SELF.ReasonCode1 := IF(reasons_count >= 1, ReasonCodes_Raw[1].hri, '');
			SELF.RCDescription1 := IF(reasons_count >= 1, ReasonCodes_Raw[1].desc, '');
			SELF.ReasonCode2 := IF(reasons_count >= 2, ReasonCodes_Raw[2].hri, '');
			SELF.RCDescription2 := IF(reasons_count >= 2, ReasonCodes_Raw[2].desc, '');
			SELF.ReasonCode3 := IF(reasons_count >= 3, ReasonCodes_Raw[3].hri, '');
			SELF.RCDescription3 := IF(reasons_count >= 3, ReasonCodes_Raw[3].desc, '');
			SELF.ReasonCode4 := IF(reasons_count >= 4, ReasonCodes_Raw[4].hri, '');
			SELF.RCDescription4 := IF(reasons_count >= 4, ReasonCodes_Raw[4].desc, '');
			SELF.ReasonCode5 := IF(reasons_count >= 5, ReasonCodes_Raw[5].hri, '');
			SELF.RCDescription5 := IF(reasons_count >= 5, ReasonCodes_Raw[5].desc, '');
			SELF.ReasonCode6 := IF(reasons_count >= 6, ReasonCodes_Raw[6].hri, '');
			SELF.RCDescription6 := IF(reasons_count >= 6, ReasonCodes_Raw[6].desc, '');
			SELF.ReasonCode7 := IF(reasons_count >= 7, ReasonCodes_Raw[7].hri, '');
			SELF.RCDescription7 := IF(reasons_count >= 7, ReasonCodes_Raw[7].desc, '');
			SELF.ReasonCode8 := IF(reasons_count >= 8, ReasonCodes_Raw[8].hri, '');
			SELF.RCDescription8 := IF(reasons_count >= 8, ReasonCodes_Raw[8].desc, '');
			SELF.ReasonCode9 := IF(reasons_count >= 9, ReasonCodes_Raw[9].hri, '');
			SELF.RCDescription9 := IF(reasons_count >= 9, ReasonCodes_Raw[9].desc, '');
			SELF.ReasonCode10 := IF(reasons_count >= 10, ReasonCodes_Raw[10].hri, '');
			SELF.RCDescription10 := IF(reasons_count >= 10, ReasonCodes_Raw[10].desc, '');

      SELF := le;
		END;

    code_result := PROJECT(input, add_reason_codes(LEFT));

    RETURN code_result;
		
  END;

END;
