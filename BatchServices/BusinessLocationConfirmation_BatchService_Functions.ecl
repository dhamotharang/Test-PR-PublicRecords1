IMPORT Address, AutoHeaderI, AutoStandardI, Business_Header, doxie, Gong, Gateway, ut;

  BLC_Layouts := BatchServices.BusinessLocationConfirmation_BatchService_Layouts;
  BLC_Constants := BatchServices.BusinessLocationConfirmation_BatchService_Constants;
	UCase := StringLib.StringToUpperCase;

EXPORT BusinessLocationConfirmation_BatchService_Functions := MODULE

	EXPORT fn_calc_fein_penalty(BLC_Layouts.Final_Plus L, Business_Header.Key_BH_Best R) := FUNCTION
				          
		tempModFein := MODULE(PROJECT(AutoStandardI.GlobalModule(), AutoStandardI.LIBIN.PenaltyI_FEIN.full, OPT))
			EXPORT fein := L.input_fein;
			EXPORT fein_field := INTFORMAT(R.fein, 9, 1);
		END;
		
		RETURN  AutoStandardI.LIBCALL_PenaltyI_FEIN.val(tempModFein);
						 						   
	END;

	EXPORT fn_calc_address_penalty(BLC_Layouts.Final_Plus L, BLC_Layouts.Address R, BOOLEAN compare_against_input) := FUNCTION
				          
		tempAddrMod := MODULE(PROJECT(AutoStandardI.GlobalModule(), AutoStandardI.LIBIN.PenaltyI_Addr.full, OPT))
			// The 'input' address:
			EXPORT predir         := IF(compare_against_input, L.input_predir, L.best_predir);
			EXPORT prim_name      := IF(compare_against_input, L.input_prim_name, L.best_prim_name);
			EXPORT prim_range     := IF(compare_against_input, L.input_prim_range, L.best_prim_range);
			EXPORT postdir        := IF(compare_against_input, L.input_postdir, L.best_postdir);
			EXPORT addr_suffix    := IF(compare_against_input, L.input_addr_suffix, L.best_addr_suffix);
			EXPORT sec_range      := IF(compare_against_input, L.input_sec_range, L.best_sec_range);
			EXPORT p_city_name    := IF(compare_against_input, L.input_p_city_name, L.best_city);
			EXPORT st             := IF(compare_against_input, L.input_st, L.best_state);
			EXPORT z5             := IF(compare_against_input, L.input_z5, L.best_zip);
						
			// The address in the matching record:							
			EXPORT allow_wildcard := FALSE;
			EXPORT city_field     := R.city;
			EXPORT city2_field    := '';
			EXPORT pname_field    := R.prim_name;
			EXPORT postdir_field  := R.postdir;
			EXPORT prange_field   := R.prim_range;
			EXPORT predir_field   := R.predir;
			EXPORT state_field    := R.state;
			EXPORT suffix_field   := R.addr_suffix;
			EXPORT zip_field      := R.zip;								
			EXPORT useGlobalScope := FALSE;
		END;				
									  
		RETURN AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempAddrMod);
						 						   
	END;

	EXPORT fn_is_business_active(STRING2 in_state, STRING in_status) := FUNCTION
	
    special_states := ['KS', 'MO'];

    active_status := ['ACTIVE', 'APPROV', 'CONSOL', 'CLEARE', 'CONVER', 'CURREN', 'EFFECT', 'EXISTS', 'EXISTI',
		                  'FOR PR', 'GOOD S', 'INCORP', 'IN EXI', 'IN GOO', 'IN USE', 'MERGED', 'MERGER', 'NEW CO',
											'NAME C', 'ORGANI', 'PRIOR', 'QUALIF', 'REDOME', 'RE-INS', 'REINST', 'RESTOR', 'REVIVE'];

    inactive_part1 := ['(OU', 'OUT', ' OU'];
    inactive_part2 := ['E RESER', 'ED - NO', 'ED -- N', 'ED INAC', 'NON-SUR', '- DELIN', 'ON-SURV', 'ESS PRE'];

		RETURN (in_state IN special_states
		        AND TRIM(in_status) IN ['CORPORATION IS ACTIVE AND IN GOOD STANDING',
						                        'STATUS PENDING EXAMINATION OF A/R',
																    'FICTITIOUS ACTIVE']
					 )
					 OR
					 (in_status[1..6] IN active_status
            AND in_status[8..10] NOT IN inactive_part1
            AND in_status[11..17] NOT IN inactive_part2
            AND TRIM(in_status) != 'CONVERTED OUT'
					 );
																	 
	END;

  fn_GetBdids(BLC_Layouts.BatchInput L) := FUNCTION
	
		tempdmod := MODULE(PROJECT(AutoStandardI.GlobalModule(), AutoHeaderI.LIBIN.FetchI_Hdr_Biz.full, OPT))
			EXPORT companyname        := L.company_name;
			EXPORT firstname          := L.owner_name_first;
			EXPORT middlename         := L.owner_name_middle;
			EXPORT lastname           := L.owner_name_last;
			EXPORT prim_name          := L.prim_name;
			EXPORT prim_range         := L.prim_range;
			EXPORT addr_suffix        := L.addr_suffix;
			EXPORT city               := L.p_city_name;
			EXPORT state              := L.st;
			EXPORT zip                := L.z5;				
			EXPORT fein               := L.fein;
			EXPORT useGlobalScope     := FALSE;
			EXPORT BOOLEAN forceLocal := TRUE;
			EXPORT BOOLEAN noFail     := TRUE;
		END;

		RETURN CHOOSEN(AutoHeaderI.LIBCALL_FetchI_Hdr_Biz.do(tempdmod), 100);
		
	END;
	
	// Obtain a set of bdids for each batch input record. ( 1 --> M bdids )
  EXPORT fn_find_bdids_and_append(DATASET(BLC_Layouts.BatchInput) input = DATASET([],BLC_Layouts.BatchInput)) := FUNCTION
		 
	  Rec_BatchInput_Plus_BDIDs := RECORD
		  BLC_Layouts.BatchInput;
		  DATASET(doxie.Layout_ref_bdid) bdids{MAXCOUNT(100)};
	  END;
				
	  Rec_BatchInput_Plus_BDIDs xfm_DeepDiveForBdids(BLC_Layouts.BatchInput L) := TRANSFORM				
		  SELF.bdids := fn_GetBdids(L);	
		  SELF       := L;
	  END;
			
	  Input_With_BDIDs := PROJECT(input, xfm_DeepDiveForBdids(LEFT));
			
	  BLC_Layouts.Final_Plus xfm_normalize_bdids(Rec_BatchInput_Plus_BDIDs L, doxie.Layout_ref_bdid R) := TRANSFORM
		  SELF.bdid := R.bdid;
		  SELF      := L;
	  END;

	  Normalized_BDIDs := NORMALIZE(Input_With_BDIDs, LEFT.bdids, xfm_normalize_bdids(LEFT, RIGHT));
	  DDPD_Normalized_BDIDs :=
		  DEDUP(
	      SORT(
				  Normalized_BDIDs,
					(INTEGER8)acctno, seq, bdid),
		    acctno, seq, bdid);
			
		RETURN(DDPD_Normalized_BDIDs);
		
	END;

	// This will look to see if any of the company names "match" the best company already found
	EXPORT fn_company_found(STRING120 master_company, DATASET(RECORDOF(Gong.Key_History_Phone)) phone_list) := FUNCTION
		BOOLEAN company_found :=
		  EXISTS(phone_list(ut.CompanySimilar(listed_name, master_company, TRUE) <= BLC_Constants.PENALT_THRESHOLD));
		
		RETURN company_found;
	END;

  EXPORT fn_get_gong_phone_info(DATASET(BLC_Layouts.Final_Plus) input, BOOLEAN is_realtime) := FUNCTION
	
	  BLC_Layouts.Final_Plus xfm_gong_info(BLC_Layouts.Final_Plus L, Gong.Key_History_Phone R) := TRANSFORM
			already_verified := L.business_phone_verified_at_address = 'Y';
			phone_verified := R.phone7 != '';
				
			// If we are using real time, values can exist for 2 of the fields below, otherwise they will be
			// blank.  So, we can get away with not caring how we get in and simply check for the specific value.
			SELF.phone_verified_real_time :=
			  IF(is_realtime,
				   IF(already_verified, L.phone_verified_real_time, 'N'),
					 'N');
			SELF.business_phone_verified_at_address :=
				CASE(
					L.business_phone_verified_at_address,
					   'Y' => 'Y',
						 IF(phone_verified, 'Y', 'N'));
			SELF.business_phone_verified_at_different_address :=
				CASE(
					L.business_phone_verified_at_different_address,
						 'N' => 'N',
						 IF(phone_verified, 'N', ''));
			SELF := L;
    END;
						
	  RETURN
			JOIN(input, Gong.Key_History_Phone,
		    KEYED(LEFT.best_phone[4..10] = RIGHT.p7
				      AND LEFT.best_phone[1..3] = RIGHT.p3)
				AND RIGHT.current_flag = TRUE
			  AND LEFT.bdid = RIGHT.bdid
				AND ((is_realtime AND LEFT.business_phone_verified_at_address = 'N')
				     OR NOT is_realtime),
		    xfm_gong_info(LEFT, RIGHT),
		    LEFT OUTER,
				KEEP(1));
				
  END;

  // This checks if the phone number and company name exist in the EDA(Gong) without comparing addresses,
	// for those records that weren't verified at the address to begin with.
  EXPORT fn_get_gong_phone_info_pt2(DATASET(BLC_Layouts.Final_Plus) input) := FUNCTION
	
    BLC_Layouts.Final_Plus gong_verify_at_different_address(BLC_Layouts.Final_Plus L,
		                                                        BLC_Layouts.Final_Plus R) := TRANSFORM
			leave_alone := L.business_phone_verified_at_address = 'Y'
					           OR L.business_phone_verified_at_different_address = 'Y';
					
		  SELF.phone_verified_real_time := IF(leave_alone, L.phone_verified_real_time, 'N');
			SELF.business_phone_verified_at_different_address :=
				IF(leave_alone,
					 L.business_phone_verified_at_different_address,
					 R.business_phone_verified_at_different_address);
			SELF := L;	
		END;

    BLC_Layouts.Final_Plus
	     find_verified_at_different_address(BLC_Layouts.Final_Plus L,
	                                        DATASET(RECORDOF(Gong.Key_History_Phone)) R) := TRANSFORM
		  SELF.business_phone_verified_at_different_address := IF(fn_company_found(L.best_company_name, R), 'Y', 'N');
	    SELF := L;
	  END;

	  denormalized_ds :=
		  DENORMALIZE(input, Gong.Key_History_Phone,
		    KEYED(LEFT.best_phone[4..10] = RIGHT.p7
				      AND LEFT.best_phone[1..3] = RIGHT.p3)
				AND RIGHT.current_flag = TRUE
			  AND LEFT.business_phone_verified_at_address != 'Y',
				GROUP,
			  find_verified_at_different_address(LEFT, ROWS(RIGHT)));
				
		RETURN
		  JOIN(input, denormalized_ds,
			  LEFT.acctno = RIGHT.acctno
			  AND LEFT.seq = RIGHT.seq
				AND LEFT.bdid = RIGHT.bdid,
				gong_verify_at_different_address(LEFT, RIGHT),
				LEFT OUTER);

  END;

  EXPORT fn_get_real_time_phone_info(DATASET(BLC_Layouts.Final_Plus) input) := FUNCTION
	
	  #STORED('MaxResults', BatchServices.Constants.RealTime.REALTIME_PHONE_LIMIT);	
    Input_Gateways := Gateway.Configuration.Get();
	
	  // Have to keep the transforms in this attribute... ECL didn't like functions pointing to transforms
    BLC_Layouts.Final_Plus add_real_time_phone_acctno(BLC_Layouts.Final_Plus L, UNSIGNED C) := TRANSFORM
	    SELF.real_time_phone_acctno := C;
		  SELF := L;
	  END;

    simple_string_rec := RECORD
      STRING the_value := '';		
		END;
		
	  BLC_Layouts.Address xfm_real_time_phone_address(simple_string_rec L) := TRANSFORM
	    SELF.prim_range := L.the_value[1..10];
		  SELF.predir := L.the_value[11..12];
		  SELF.prim_name := L.the_value[13..40];
		  SELF.addr_suffix := L.the_value[41..44];
		  SELF.postdir := L.the_value[45..46];
		  SELF.city := L.the_value[90..114];
		  SELF.state := L.the_value[115..116];
		  SELF.zip := L.the_value[117..121];									
	    SELF := [];
	  END;

	  BLC_Layouts.Final_Plus xfm_real_time_results(BLC_Layouts.Final_Plus L,
		                                             BatchServices.Layouts.RTPhones.rec_batch_RTPhones_out R,
																								 BOOLEAN first_time_through) := TRANSFORM
			real_time_phone_address_cleaned :=
			  Address.CleanAddress182(UCase(R.address), UCase(R.city) + ' ' + UCase(R.state) + ' ' + R.zip[1..5]);
      real_time_phone_address_rec := PROJECT(DATASET([real_time_phone_address_cleaned], simple_string_rec),
			                                       xfm_real_time_phone_address(LEFT));
      address_penalty := IF(R.phone = '', 1000, fn_calc_address_penalty(L, real_time_phone_address_rec[1], FALSE));
			company_name_penalty := ut.CompanySimilar(L.best_company_name[1..20], UCase(R.callerid_name), TRUE);
			phone_verified := address_penalty <= BLC_Constants.PENALT_THRESHOLD
			                  AND company_name_penalty <= BLC_Constants.PENALT_THRESHOLD;
			phone_verified_name_only := company_name_penalty <= BLC_Constants.PENALT_THRESHOLD;
			already_verified := L.business_phone_verified_at_address = 'Y';
			
			SELF.phone_verified_real_time :=
			  IF(first_time_through,
				   'Y',
					 IF(already_verified, L.phone_verified_real_time, IF(phone_verified_name_only, 'Y', 'N')));
			SELF.business_phone_verified_at_address :=
			  IF(first_time_through, IF(phone_verified, 'Y', 'N'), L.business_phone_verified_at_address);
			SELF.business_phone_verified_at_different_address :=
			  IF(first_time_through,
				   IF(phone_verified, 'N', ''),
					 IF(already_verified,
			        L.business_phone_verified_at_different_address,
							IF(phone_verified_name_only, 'Y', '')));
		  SELF := L;
	  END;

    Add_Acctno_Result := PROJECT(input, add_real_time_phone_acctno(LEFT, COUNTER));

    Real_Time_Phone_Input :=
	    PROJECT(Add_Acctno_Result,
		    TRANSFORM(BatchServices.Layouts.RTPhones.rec_batch_RTPhones_input,
			    SELF.acctno := (STRING12)LEFT.real_time_phone_acctno;
				  SELF.phoneno := LEFT.best_phone;
				  SELF := []));
							
    Input_Module := MODULE(BatchServices.RealTimePhones_Params.Params)
		   EXPORT STRING12 searchType := BatchServices.Constants.REALTIME.SEARCHTYPE.SEARCH_INPUT;
		   EXPORT BOOLEAN	 strictSSN := false; // Not sure this is needed
		   EXPORT STRING   UID := ''; // Not sure this is needed
	  END;
	
	  Global_Module := PROJECT(AutoStandardI.GlobalModule(), Input_Module, OPT);
	
	  Real_Time_Phone_Recs := BatchServices.RealTimePhones_BatchService_Records(Real_Time_Phone_Input, Input_Gateways, Global_Module);
		
	  Real_Time_Phone_Normalized :=
	    NORMALIZE(Real_Time_Phone_Recs,
		    LEFT.results,
			  TRANSFORM(BatchServices.Layouts.RTPhones.rec_batch_RTPhones_out,
			    SELF := RIGHT;));
					
		Real_Time_Phone_Filtered :=
		  DEDUP(Real_Time_Phone_Normalized(callerid_name != '' AND address != '' AND phone_listing_type != 'RS'),
			  acctno,
				RIGHT);
			
		Real_Time_Phone_At_Address_Result :=
		  JOIN(Add_Acctno_Result, Real_Time_Phone_Filtered,
			  LEFT.real_time_phone_acctno = (UNSIGNED)RIGHT.acctno,
			  xfm_real_time_results(LEFT, RIGHT, TRUE),
			  LEFT OUTER);
				
		Gong_Phone_At_Address_Result :=
		  fn_get_gong_phone_info(Real_Time_Phone_At_Address_Result, BLC_Constants.INCLUDE_REAL_TIME_PHONES);
		  
		RETURN
		  IF(BLC_Constants.INCLUDE_REAL_TIME_PHONES,
		     JOIN(Gong_Phone_At_Address_Result, Real_Time_Phone_Filtered,
			     LEFT.real_time_phone_acctno = (UNSIGNED)RIGHT.acctno,
			     xfm_real_time_results(LEFT, RIGHT, FALSE),
			     LEFT OUTER),
         Gong_Phone_At_Address_Result);
				
	END;
	
END;