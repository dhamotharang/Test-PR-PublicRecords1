IMPORT Appriss, AutokeyB2, Autokey_batch,AutoStandardI, BatchServices, CRIM, Risk_Indicators, UT;

// 1. Define values for obtaining autokeys and payloads.
    ak_keyname := Appriss.ak_qa_keyname;		
		ak_typestr := Appriss.ak_typeStr;
		ak_dataset := dataset([],BatchServices.Layouts.JailBooking.rec_ds_ak);

 // 2. Configure the autokey search.	
    in_ak_config_data := MODULE(BatchServices.Interfaces.i_AK_Config)
		  export workHard        := TRUE; // for Autokey_batch.Fetch_Address_Batch to run at all.
	    export useAllLookups   := TRUE; // for Autokey_batch.Fetch_SSN_Batch to run SSN2 key. SSN key is empty.
	    export isTestHarness   := FALSE;
		  export skip_set        := Appriss.ak_skipSet;
	  END;
	
                                              
EXPORT JailBooking_BatchService_Records(DATASET(BatchServices.Layouts.JailBooking.layout_inJailBookingBatch) batch_in) := 
  MODULE	
  EXPORT normalized := BatchServices.layouts.JailBooking.out_normalized;
	 
	 SHARED ds_batch := project(batch_in, Autokey_batch.Layouts.rec_inBatchMaster);
	 //create another record with just name/DOD for those records with SSN and DOB, since autokeys drops dob matches if ssn matches.
	 Autokey_batch.Layouts.rec_inBatchMaster clearSSN(ds_batch L) := transform
	     self.ssn :=  '';
			 self := l;
	 END;
	 shared ds_batch_in_w_middle := ds_batch + project(ds_batch(ssn <> '' and dob <> ''), clearSSN(LEFT));
// 3. Get autokeys based on batch input.
	 Autokey_batch.Layouts.rec_inBatchMaster removeMiddle(ds_batch L) := transform
	     self.name_middle := ''; //clear middle names on all input rows for use in autokey and getDIDs
			 self := l;
	 END;

   shared ds_batch_in_no_middle := project(ds_batch_in_w_middle, removeMiddle(left));
	  //filter records out with just name components.
	 shared ds_batch_in := ds_batch_in_no_middle(ssn <> '' or DOB <> '' or prim_range <> '') ;
	 
   EXPORT ds_fids := Autokey_batch.get_fids(ds_batch_in, ak_keyname, in_ak_config_data);
																			
// 4. Get autokey payloads (the real DIDs/BDIDs, record ids, and other goodies).		
		AutokeyB2.mac_get_payload( UNGROUP(ds_fids), ak_keyname, ak_dataset, EXPORT outpl, did, zero, ak_typeStr )

// 5. Slim the autokey payload (outpl) to just what's needed for matching (acctno and fid). Then sort and dedup.
    slim_recs := PROJECT(outpl, TRANSFORM(BatchServices.Layouts.JailBooking.rec_acctnos_fids, SELF.isDeepDive := FALSE,
		                                                                                          SELF := LEFT));
		shared ds_ids_by_autokey := DEDUP(SORT(slim_recs, acctno, booking_sid), acctno, booking_sid);
    
		
// 6. Get Booking Ids via Header for more complete coverage.
                                                           
		export ds_acctnos_and_dids := BatchServices.Functions.fn_find_dids_and_append_to_acctno(ds_batch_in);
		// .. go look for booking ids via dids.
		ds_ids_via_header    := JOIN(ds_acctnos_and_dids, Appriss.key_did,
		                                       KEYED(LEFT.did = RIGHT.did),
		                                       TRANSFORM(BatchServices.Layouts.JailBooking.rec_acctnos_fids,
		                                                 SELF.acctno := LEFT.acctno;
		                                                 SELF.booking_sid    := RIGHT.booking_sid;
																										 SELF.isDeepDive := TRUE;
		                                                 SELF        := LEFT;),
		                                       INNER, keep(Constants.JailBooking.MAX_BOOKINGS));		
		
		ds_ak_plus_hdr := IF( in_ak_config_data.RunDeepDive, ds_ids_by_autokey + ds_ids_via_header, 
		                                                         ds_ids_by_autokey );
    																														 
    // look by FBI Number not supported by AutoKeys.		
		// first slim down to just acctno, fbi numbers
		BatchServices.Layouts.JailBooking.layout_fbi_acct slimIT(batch_in L) := TRANSFORM
		  SELF.acctno := L.acctno;
			SELF.fbi_nbr := L.fbi_number;
    end;												
		fbi_in := project(batch_in , slimIt(LEFT));
		fbi_recs_wAcct := BatchServices.JailBooking_Functions.getBookingsByFBINumber(fbi_in);																														 

    ds_ak_plus_hdr_fbi := ds_ak_plus_hdr + fbi_recs_wAcct;		
		// the below dataset gets used in BatchServices.JailBooking_BatchService to join final results and maintain acctno
		
		EXPORT ds_all_ids := DEDUP(SORT(ds_ak_plus_hdr_fbi, acctno, booking_sid, -isDeepDive),
                                                      	acctno, booking_sid);
		
		// *******************************************************************************																										
    // Below this point we don't need to keep acctno only booking_sid to join back to.																												
		// *******************************************************************************
// 7. Get booking data and Apply the penalty based on input
		/*Project input records to input layout needed for penalty functions*/	
		
		BatchServices.Layouts.JailBooking.rec_input_and_matchcodes xform_input(batch_in L, ds_all_ids R) :=
		TRANSFORM	
		  SELF.booking_sid := R.booking_sid;
			SELF.isDeepDive := R.isDeepDive;
			SELF.acctno := L.acctno;
			SELF._Last_name := L.name_last;
			SELF._First_name := L.name_first;
			SELF._Middle_Name :=  L.name_middle; 
			SELF._SSN := L.SSN;
			SELF._DOB := l.dob;
			SELF._FBI_Number := L.FBI_Number;
			SELF._Alien_Number := L.Alien_Number;	       //(pass thru)
			SELF._DL_Number := L.DL;        // (passthru)
			SELF._State_ID_Number := L.State_ID_Number;	 //(passthru)
			self := l;
			self := [];
		END;
		
		tmp_ds_input := JOIN(batch_in, ds_all_ids,
																LEFT.ACCTNO = RIGHT.ACCTNO,
																xform_input(LEFT,RIGHT), 
																INNER, keep(Constants.JailBooking.MAX_BOOKINGS));

	normalized applyPenalty(tmp_ds_input L, Appriss.Key_Booking R) := transform 
   // Set Match Reasons ---------------------------------------------------------
 		fl_exact_match := (UT.NBEQ(L._LAST_NAME,r.lname)    AND UT.NBEQ(L._FIRST_NAME,r.fname)) OR
                      (UT.NBEQ(L._LAST_NAME,r.ap_lname) AND UT.NBEQ(L._FIRST_NAME,r.ap_fname));
		fl_match := ((Risk_Indicators.FnameScore(L._FIRST_NAME, r.fname)    BETWEEN 80 AND 254) and (Risk_Indicators.LnameScore(L._LAST_NAME, r.lname)    BETWEEN  80 AND 254)) OR
                ((Risk_Indicators.FnameScore(L._FIRST_NAME, r.ap_fname) BETWEEN 80 AND 254) and (Risk_Indicators.LnameScore(L._LAST_NAME, r.ap_lname) BETWEEN 80 AND 254));
										 
    match_fl_dob := fl_exact_match and UT.NBEQ(L._DOB, r.date_of_birth[1..8]);										 
		match_fl_ssn := fl_match and (UT.NBEQ(l._SSN, r.ssn) or UT.NBEQ(l._SSN, r.ap_ssn));
		match_fbi := UT.NBEQ(l._FBI_NUMBER,r.fbi_nbr);
		match_linkid := l.isDeepDive;   

		//clear fbi number if request contains fbi number and it doesn't match.
		//clear fbi number if request doesn't contain fbi number and reply has one.
		self.FBI_NBR := if (match_fbi,r.fbi_nbr, '');  
		
		self.join_fl_name_dob := if (match_fl_dob, BatchServices.Constants.JailBooking.MATCH_FL_DOB, '');
		self.join_fl_name_ssn := if (match_fl_ssn, BatchServices.Constants.JailBooking.MATCH_FL_SSN, '');
	  self.join_linkid := if (match_linkid, BatchServices.Constants.JailBooking.MATCH_LINKID, '');
	  self.join_fbi_nbr := if (match_fbi, BatchServices.Constants.JailBooking.MATCH_FBI, '');
	
	// Penalty Calculations for future version---------------------------------
	//	pen_name	:= BatchServices.JailBooking_Functions.penalize_fullname(L,R);
	//	pen_ssn		:= BatchServices.JailBooking_Functions.penalize_ssn(L,R);
	//	pen_dob   := BatchServices.JailBooking_Functions.penalize_dob(L,R);
    // force penalty high if none of the 4 match criteria are found.		
		pen_match := if (match_fl_dob or match_fl_ssn or match_fbi or match_linkid, 0, 25);
		
		self.record_penalty := pen_match;
		self.acctno := l.acctno;
		SELF.isDeepDive := l.isDeepDive;
		self.load_date := []; //load date is no longer in key
		self.charges := [];   //charges aren't loaded until just prior to return results
		self.marks_scars_tattoos := R.marks_scars_tatoos;
		self := R;            // assign all key fields
	end;
		
		export ds_pre_penalty := join(tmp_ds_input, Appriss.Key_Booking,
													 LEFT.booking_sid = RIGHT.booking_sid,
		                       applyPenalty(LEFT,RIGHT),
													 INNER, keep(Constants.JailBooking.MAX_BOOKINGS));

// 8. Filter records that exceed PenaltThreshold
		export ds_pen := ds_pre_penalty((record_penalty <= in_ak_config_data.PenaltThreshold) or isDeepDive) ;
// 9. bookings with dl state apply restrictions by clearing DL info.
    unsigned1 DPPAPurpose := AutoStandardI.InterfaceTranslator.dppa_purpose.val(project(AutoStandardI.GlobalModule(),AutoStandardI.PermissionI_Tools.params));
 		normalized clearRestrictDL(ds_pen L) := TRANSFORM
		   clearDLInfo := ~ut.PermissionTools.dppa.state_ok(L.dlstate,DPPAPurpose);
			 self.dlstate := if (clearDLInfo, '', l.dlstate);
			 self.dlNumber := if (clearDLInfo, '', l.dlNumber);
			 self := l;
		END;
		EXPORT recs_restrict := project(ds_pen, clearRestrictDl(LEFT));

		normalized rollemup(recs_restrict L,recs_restrict R) := transform
		  self.join_fl_name_dob := if (L.join_fl_name_dob <> '', L.join_fl_name_dob, R.join_fl_name_dob);
		  self.join_fl_name_ssn := if (L.join_fl_name_ssn <> '', L.join_fl_name_ssn, R.join_fl_name_ssn);
	    self.join_linkid 			:= if (L.join_linkid <> '', L.join_linkid, R.join_linkid);
	    self.join_fbi_nbr 		:= if (L.join_fbi_nbr <> '', L.join_fbi_nbr, R.join_fbi_nbr);
			self := l;
		end;
    EXPORT results := rollup(sort(recs_restrict,acctno, booking_sid), 
		                              left.acctno=right.acctno AND left.booking_sid = right.booking_sid, 
																	rollemup(LEFT,RIGHT));
END;

