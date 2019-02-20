import AddrBest, Advo, USAA, DriversV2, doxie, AutoStandardI, Suppress, ut, Autokey_batch, BatchServices, 
       DriversV2_Services, DeathV2_Services;

EXPORT functions := MODULE
  //***************************************************************************
	SHARED AddrBest.Layout_BestAddr.batch_out_final
	                fn_markAddrAsMilitary(dataset(AddrBest.Layout_BestAddr.Batch_out_matchcodes) in_ds) := FUNCTION
		 // add in boolean value (prevCurrMilitary_address) to the DS coming in
				
		 in_ds_grouped := group(sort(project(in_ds, 
				                   transform(AddrBest.Layout_BestAddr.batch_out_final,
				                     self.PrevCurrMilitary_address  := '',
														 self.ssn_loose_match := '',
														 self := left)),acctno), acctno);
				
			// setup the iterate function addresses coming in are sorted by date last seen
			// and now grouped by acctno so loop through list and mark within each group 
			// the one most recent rec with a C and ones after it with a P
			// if the addresses are within the military zip set and city names as defined below.
			AddrBest.Layout_BestAddr.batch_out_final
				  loopThroughRecs(AddrBest.Layout_BestAddr.batch_out_final Le, 
						AddrBest.Layout_BestAddr.batch_out_final R) := TRANSFORM

             trim_city := trim(R.p_city_name, left, right);																	 
						 reg_expr := '(^|\\s)(APO|FPO|AFB)(\\s|$)';
             APO_FPO_AFB := REGEXFIND(reg_expr, trim_city);						             
												 				  
				      isMilitaryAddress := R.z5 IN USAA.zipcodes_proximity_milbase AND APO_FPO_AFB;					                                      
				      self.PrevCurrMilitary_address := if (isMilitaryAddress, if( R.acctno = Le.acctno, 'P', 'C'),'');							                                        
							                                        
				      self := R;
       END;																									  				
			 iterated_ds := iterate(in_ds_grouped, loopThroughRecs(left, right)); 					 
	   RETURN ungroup(iterated_ds);
	END;
	//***************************************************************************
	EXPORT  fn_getDIDfromDL(DATASET(AddrBest.Layout_BestAddr.Batch_in_both) ds_in) := FUNCTION
	//now use batch drivers license service for any input row with a dl value.
    dls_only := project(ds_in(dl <> ''), Autokey_batch.Layouts.rec_inBatchMaster);
	  cfgs := MODULE(DriversV2_Services.GetDLParams.batch_params)
		  EXPORT useAllLookups := TRUE;
		  EXPORT skip_set := DriversV2.Constants.autokey_skipSet;
			EXPORT boolean return_current_only	:= FALSE : STORED('Return_Current_Only');
			EXPORT UNSIGNED8 MaxResultsPerAcct := 2000;
	  END;
	  dl_recs := DriversV2_Services.Batch_Service_Records(dls_only, cfgs);
		//these are in acctno, penalty order so get the first one per acctno
    OutRecs := dedup(dl_recs, acctno);
	  RETURN OutRecs;
	END;
	//***************************************************************************
	EXPORT addrBest.Layout_BestAddr.batch_Out_both_wp_did fn_addDL(DATASET(addrBest.Layout_BestAddr.batch_Out_both_wp_did) ds_in) := FUNCTION
    key_dls := DriversV2.Key_DL_DID;	
    gm := AutoStandardI.GlobalModule();
  	boolean dl_mask_value := AutoStandardI.InterfaceTranslator.dl_mask_val.val(project(gm,AutoStandardI.InterfaceTranslator.dl_mask_val.params));	
	  dppa_purpose		:= AutoStandardI.InterfaceTranslator.DPPA_Purpose.val(project(gm,AutoStandardI.InterfaceTranslator.DPPA_Purpose.params));	
		dls_found_layout := record
      unsigned6	did;
	    qstring24 dl_number;
      string2   orig_state;
	    unsigned4 lic_issue_date;
	    unsigned4 expiration_date;
	    unsigned4 dt_vendor_last_reported;
			unsigned1 age_today;
			string2 	source_code;
    end; 
    dls_found_layout  loadDlsFound(ds_in l, key_dls r) := transform
			checkRNA := (l.subj_phone_type_new in AddrBest.Constants.RNAset or l.did <> l.p_did);
				//true is not the subject		/  false is the subject  
      self.did := if (ut.dppa_ok(dppa_purpose,checkRNA),l.did,skip);
      self.dl_number := r.dl_number;
      self.orig_State := r.orig_state;
      self.lic_issue_date :=  r.lic_issue_date;
      self.expiration_date := r.expiration_date; 
      self.dt_vendor_last_reported := r.dt_vendor_last_reported;
			self.age_today := ut.age((unsigned)r.dob);
		  self.source_code := r.source_code;
    end;		
		//find all DLS per DID in order to use the most current (which is different than a license status = current)
		dls_found := join(ds_in, key_dls, left.did = right.did, loadDlsFound(left,right), left outer);

		// suppress/mask sensitive data********************

	   dl_glb	:= dls_found(ut.PermissionTools.GLB.minorOK(age_today));
	   dl_dppa := dl_glb(ut.PermissionTools.dppa.state_ok(orig_state,dppa_purpose,,source_code)); //called for RNA

	   Suppress.MAC_Mask(dl_dppa, dls_found_masked, '', dl_number, false, true);
		//end of suppress/mask*******************************
		
		//sort and dedup to create a group of records that contain a unique DID and the most current DL for that DID.
		dls_found_deduped := dedup(sort(dls_found_masked, did,  - expiration_date, -lic_issue_date -dt_vendor_last_reported),did);
		//now join with this set of most current DLs if they ask to include_dls
		ds_in  loadDls(ds_in l, dls_found_deduped  r) := transform
			self.dl_number := r.dl_number;
			self.orig_State := r.orig_state;
			self.lic_issue_date := r.lic_issue_date;
			self.expiration_date := r.expiration_date;
			self := l;
		end;
    OutRecs := join(ds_in, dls_found_deduped, left.did = right.did, loadDls(left,right), LEFT OUTER, LIMIT(0), KEEP(1));
	  RETURN OutRecs;
	END;
	//***************************************************************************
	EXPORT addrBest.Layout_BestAddr.batch_Out_both_wp_did fn_addDeceased(DATASET(addrBest.Layout_BestAddr.batch_Out_both_wp_did) ds_in) := FUNCTION
		
		deathparams := DeathV2_Services.IParam.GetDeathRestrictions(AutoStandardI.GlobalModule());
		
    key_dead := doxie.key_death_masterV2_ssa_DID ;
		ds_in  loadDead(ds_in l, key_dead r) := transform
			self.dod := r.dod8;
			self.deceased := if ( r.l_did != 0 ,'Y','N');
			self := l;
		end;
    OutRecs := join(ds_in, key_dead, keyed(left.did=right.l_did)
											and	not DeathV2_Services.functions.Restricted(right.src, right.glb_flag, 
											deathparams.isValidGlb(left.subj_phone_type_new in AddrBest.Constants.RNAset or left.did <> left.p_did),	//true is not the subject, false is the subject 
											deathparams),
											loadDead(left, right), LEFT OUTER, LIMIT(0), KEEP(1));
    RETURN OutRecs;
  END;
	
	/* ----------------  function for adding additional optional flags  -----------------  */
	
	EXPORT AddrBest.Layout_BestAddr.batch_out_final fn_add_optional_data(dataset(AddrBest.Layout_BestAddr.Batch_out_matchcodes) in_ds,
																																			 AddrBest.IParams.SearchParams in_mod) := FUNCTION
		 
		// add in military address information here
		// this function assumes that incoming dataset is sorted by more recent date first
		out_add1 := if(in_mod.Include_Military_Address, fn_markAddrAsMilitary(in_ds), 
									 project(in_ds, transform(AddrBest.Layout_BestAddr.batch_out_final,
																						self.PrevCurrMilitary_address  := '',
																						self.ssn_loose_match := '',
																						self := left)));

		// Must be exact match on all parts -- including sec range being blank.
		records_from_key_zip := join(out_add1, Advo.Key_Addr1,
			keyed(left.z5 = right.zip) and
			keyed(left.prim_range = right.prim_range) and
			keyed(left.prim_name = right.prim_name) and
			keyed(left.suffix = right.addr_suffix) and
			keyed(left.predir = right.predir) and
			keyed(left.postdir = right.postdir) and
			keyed(left.sec_range = right.sec_range),
			transform(AddrBest.Layout_BestAddr.batch_out_final, 
				self.county_name 	:= if(in_mod.ReturnCountyName and left.dup_flag='',right.county_name,''),
				self.Latitude 		:= if(in_mod.ReturnLatLong,right.geo_lat,''), 
				self.Longitude 		:= if(in_mod.ReturnLatLong,right.geo_long,''), 
				self := left),
			left outer,
			keep(1));

			adv_join := in_mod.ReturnCountyName or in_mod.ReturnLatLong;
			out_add2 := IF(adv_join, records_from_key_zip, out_add1);
					
			glb_mod := AutoStandardI.GlobalModule();
			ds_in := project(records_from_key_zip,transform(BatchServices.Layouts.RTPhones.rec_batch_RTPhones_input, self.acctno:=left.acctno;
																					self.orig_acctno:=left.acctno;
																					self.prim_range  := left.prim_range;
																					self.prim_name := left.prim_name;
																					self.p_city_name := left.p_city_name;
																					self.st  := left.st;
																					self.zip5 := left.z5;
																					self:=[];));
      // temporarily limiting max results to avoid possible roxie error when pulling phone records for addresses with secondary range.
			// but we might be dropping valid record, in case it is not within top 20 phone recs.
			// may have to revisit SearchInHouse to allow for secondary range address to buble up correctly, based on input address.
			gmod := MODULE(PROJECT(glb_mod, BatchServices.RealTimePhones_Params.Params, OPT)) 
				export unsigned8 maxResults := 20; // limited to 100 by RTPhones.rec_batch_RTPhones_input layout
			end;											
			addrOnlyPH := BatchServices.SearchInhouse(gmod,ds_in);
			out_add3 := join(out_add2,addrOnlyPH,
												left.acctno = right.acctno and  
												left.prim_range  = right.prim_range and
												left.prim_name = right.prim_name and
												left.p_city_name = right.p_city_name and
												left.st  = right.st and
												left.z5 = right.zip5,
												transform(AddrBest.Layout_BestAddr.batch_out_final, 
													addr_phones := right.results((left.sec_range='' or sec_range = left.sec_range) and 
																												(dt_last_seen='' or ut.Age((integer)dt_last_seen * 100) < 5));
													self.phone_address	:= addr_phones[1].phone;
													self := left;),
												left outer,
												keep(1));			

			out_recs := IF(in_mod.ReturnAddrPhone, out_add3, out_add2);

			RETURN out_recs;

	END;		

	/* ------- ------- ------- function to get the last 4 digits of the SSN ------- ------- ------- */

	// the input SSN should already be "cleaned" of non-digits into a fixed length Q string.
	STRING fn_getSSN4(QString9 ssn) := FUNCTION
		STRING ssnTrimmed := trim(ssn);
		sLen := length(ssnTrimmed);
		sp1 := if(sLen > 3, sLen - 3, 1); // calculate first position to have the last 4 digits
		RETURN ssnTrimmed[sp1..sLen];
	END;

	/* ------- ------- ------- function to set the SSN_Loose_Match field ------- ------- ------- */

	EXPORT AddrBest.Layout_BestAddr.batch_out_final fn_setSSNlooseMatch(dataset(AddrBest.Layout_BestAddr.Batch_in) f_in,
																																			dataset(AddrBest.Layout_BestAddr.batch_out_final) final_recs) := FUNCTION
		// keyed join with Doxie Key Header to find out whether SSN4/Lname has a match with a DID
		f_in_matched := join(f_in, doxie.Key_Header_SSN4, fn_getSSN4(left.ssn) = right.ssn4 and left.name_last = right.lname,
																	KEYED, LEFT OUTER, KEEP(1), LIMIT(0));
		out_recs := join(f_in_matched, final_recs, left.acctno = right.acctno,
														transform(AddrBest.Layout_BestAddr.batch_out_final,
																		// Get acctno and ssn_loose_match from the Left, because when there is NO Search Match,
																		// there will be NO data on the Right, but we still need to return the acctno and
																		// ssn_loose_match. Get all else from the Right, because when there IS a Search Match,
																		// it must override what was on the Left.
																		self.acctno := left.acctno;
																		// When there is no SSN4/Lname match, the Doxie Key Header Lname is empty
																		self.ssn_loose_match := if(left.lname <> '', 'Y', 'N');
																		// When there is no match on the right, grab the input field on the left, for these two fields.
																		self.name_last := if(right.did <> 0, right.name_last, left.name_last);
																		self.ssn := if(right.did <> 0, right.ssn, left.ssn);
																		// Fill out the remaining fields from the either Matched or Empty right
																		self := right;
														),
											LEFT OUTER);
		RETURN out_recs;
	END;
END;