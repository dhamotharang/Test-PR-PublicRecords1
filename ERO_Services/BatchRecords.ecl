import Address,AutokeyB2,AutoStandardI, Autokey_batch, BatchServices, BatchShare,  doxie, header, iesp,Standard, ut,VehicleV2_Services;

export BatchRecords(/*ERO_Services.IParam.batchParams configData,*/ 
										dataset(ERO_Services.Layouts.IntermediateData) ds_batch_in,
										UNSIGNED1 did_limit=ERO_Services.Constants.Limits.DID_LIMIT,
										BOOLEAN GetSSNBest=true) := function
   gm := AutoStandardI.GlobalModule(); //TODO: now only for IncludeMinors
	 mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated (gm);

	 searchMod:= MODULE(PROJECT(gm, ERO_Services.IParam.searchParams,opt))	end;	
	   // Set an adjusted did_limit to 1 just in case it gets accidently input as 0
   did_limit_adjusted := if(did_limit=0,1,did_limit);
	//take each input request and generate additional records for name variations.
	ds_batch_in_akas := ERO_Services.Functions.add_input_names(ds_batch_in);
	//since making akas create multiple rows per acctno, save orig acctno and make a new unigue acctno value
	ERO_Services.Layouts.IntermediateData saveAcctno(ds_batch_in_akas l, integer c) := transform
     self.saved_acctno := l.acctno;	   
		 self.acctno := (string)c;
	   self := l;
	end;
	//so this dataset below has a new acctno and the saved original acctno for joining back after penalty.
	ds_batch_in_aka := project(ds_batch_in_akas, saveAcctno(left, counter));
	
	//Performance:
	//When I graphed this service the below project took 2 times as long as the next process
	//it was converted to: project(xfm_DeepDiveForDids(left));
	ds_batch_in_common_aka 	:= project(ds_batch_in_aka, Autokey_batch.Layouts.rec_inBatchMaster);
	boolean IncludeNoMatch := true;
	
	//function call to gather DIDs based on input criteria
	//uses LIBCALL_FetchI_Hdr_Indv  (same as DEEP DIVE search for DIDs).
	ds_ids_by_deepdive := BatchServices.Functions.fn_find_dids_and_append_to_acctno(ds_batch_in_common_aka);

	// Have any acctnos resolved to more than the parmed in did limit? 
	// If so, remove them; too ambiguous.
	tbl_count_acctnos := TABLE( ds_ids_by_deepdive, {acctno, cnt := COUNT(GROUP)}, acctno );
	ds_acctnos_and_dids_unique := JOIN(ds_ids_by_deepdive, tbl_count_acctnos,
																			 LEFT.acctno = RIGHT.acctno AND RIGHT.cnt <= did_limit_adjusted,
																			 TRANSFORM(LEFT), INNER);
  //list of acctno did combinations.
	ds_acctNdids := dedup(sort(ds_acctnos_and_dids_unique(did <> 0), acctno, did), acctno, did);
	  
	//join back to original input criteria
	// note input DID is overwritten by DID found from append DID operation above
	ERO_Services.Layouts.IntermediateData  fillInput(ds_acctNdids l, ds_batch_in_aka r) := transform
		  self := l;  //assigns acctno and DID
		  self := r;  //assigns all input criteria
	end;
	ds_acctNdidsNinput := join(ds_acctNdids,ds_batch_in_aka,left.acctno = right.acctno,fillInput(left,right),left outer, limit(ERO_Services.Constants.Limits.MAX_JOIN_LIMIT));
    
	// filter out DIDs in input that need suppression
	ds_acctNdidsNinputFilterDids := ds_acctNdidsNinput(did not in [(integer)lexid_suppression_1,(integer)lexid_suppression_2]);
   
	//get set of unique DID values 
	ds_target_dids := project(dedup(sort(ds_acctNdidsNinputFilterDids,did),did), transform(doxie.layout_references_hh, self.did := left.did));
	  
	//==============================================================================================
	// Get all the appropriate header records for the dids.
	//==============================================================================================
	//Bug 
	ds_hdr_recs_for_dids := doxie.header_records_byDID(dids := ds_target_dids, include_dailies := false, allow_wildcard := false, ReturnLimit := 75000);

	// **************************************************************************************
	//   Perform penalization on matching records (5 step process)
	//   1. Load header records, 2. load input records, 3 penalize header, 
	//   4. additional penalty applied for DL and PLATE, 5. use relative name for tie breaker only if in input.
	// **************************************************************************************
  ERO_Services.Layouts.Subject_out_temp  fillSubjects(ds_acctNdidsNinputFilterDids l, ds_hdr_recs_for_dids r) := transform
		self.acctno := l.acctno;
		self.did := l.did;
		self.input_gender := l.gender;
		self.input_fbi_num := l.fbi_num;
		self.input_ssn := l.ssn;
		self.input_dob := iesp.ECL2ESP.todate((integer)l.dob);
		self.input_name.name_last := l.name_last;
		self.input_name.name_first := l.name_first;
		self.input_name.name_middle := l.name_middle;
		self.input_addr.prim_range := l.prim_range;
		self.input_addr.predir := l.predir;
		self.input_addr.prim_name := l.prim_name;
		self.input_addr.addr_suffix := l.addr_suffix;
		self.input_addr.postdir :=  l.postdir;
		self.input_addr.unit_desig := l.unit_desig;
		self.input_addr.sec_range := l.sec_range;
		self.input_addr.p_city_name := l.p_city_name;
		self.input_addr.st :=  l.st;
		self.input_addr.z5 := l.z5;
		self.input_addr.zip4 := l.zip4;
		self.input_addr.county_name := l.county_name;
		self.input_raw_City  := l.input_raw_city ;
    self.input_raw_St := l.input_raw_st ;
    self.input_raw_zip := l.input_raw_zip;

		self.dedupprim_range1 := l.dedupprim_range1;
		self.dedupprim_name1 := l.dedupprim_name1;
		self.dedupzip1 := l.dedupzip1;
		self.dedupprim_range2 := l.dedupprim_range2;
		self.dedupprim_name2 := l.dedupprim_name2;
		self.dedupzip2 := l.dedupzip2;
		self.subject_Penalty := '';
		self.subject_Source_Count := '';
		self.subject_Last_Name := r.lname ;
		self.subject_First_Name := r.fname;
		self.subject_Middle_Name := r.mname;
	// Fix bad suffixes (UNK, UN1, UN2, etc.) on some header file recs
		SELF.subject_suffix := if(R.name_suffix[1..1]='U','',R.name_suffix),
		self.subject_SSN := r.ssn;
		self.subject_DOB := ERO_Services.Functions.fixDate(r.dob);// subject dob mm/dd/yyyy
		self.header_addr.prim_range :=    r.prim_range;
		self.header_addr.predir := r.predir;
		self.header_addr.prim_name := r.prim_name;
		self.header_addr.addr_suffix := r.suffix;
		self.header_addr.postdir :=  r.postdir;
		self.header_addr.unit_desig := r.unit_desig;
		self.header_addr.sec_range := r.sec_range;
		self.header_addr.p_city_name := r.city_name;
		self.header_addr.st :=  r.st;
		self.header_addr.z5 := r.zip;
		self.header_addr.zip4 := r.zip4;
		self.header_addr.county_name := r.county;
		self.subject_AKAS_LIST :='';  //filled later		
		self.subject_SN_DOB_MATCH :=''; //filled later
		self.subject_ADDR1_MATCH:='';//filled later
		self.subject_ADDR2_MATCH:='';//filled later
		self.subject_Gender:='';	//filled later
		
  end;
		
	//1. load header records: 
  subject_recs := JOIN(ds_acctNdidsNinputFilterDids, ds_hdr_recs_for_dids,
		                            LEFT.did = RIGHT.s_did,	fillSubjects(left,right),	LIMIT(ERO_Services.Constants.Limits.MAX_JOIN_LIMIT));
	ERO_Services.Layouts.layout_batch_in_for_penalties xfm_prepend_underscore(ds_batch_in_aka l) := TRANSFORM
		self._acctno      := l.acctno;
		self._name_first  := l.name_first;
		self._name_middle := l.name_middle;
		self._name_last   := l.name_last;
		self._name_suffix := l.name_suffix;
		self._prim_range  := l.prim_range;
		self._predir      := l.predir;
		self._prim_name   := l.prim_name;
		self._addr_suffix := l.addr_suffix;
		self._postdir     := l.postdir;
		self._unit_desig  := l.unit_desig;
		self._sec_range   := l.sec_range;
		self._p_city_name := l.p_city_name;
		self._st          := l.st;
		self._z5          := l.z5;
		self._zip4        := l.zip4;
		self._ssn         := l.ssn;
		self._dob         := l.dob;
		self._homephone   := '';
		self._workphone   := '';
		self.Relative_Last_Name := l.Relative_Last_Name;
    self.Relative_First_Name := l.Relative_First_Name;
		self.DL_Number := l.DL_Number;
    self.DL_State := l.DL_State;
    self.VEH_Plate := l.VEH_Plate;
    self.VEH_State := l.VEH_State;
		self.acctno := l.acctno;
		self.did := l.did;
		self.subject_sn_dob_match := '';
		self.subject_penalty := 0;
	END;
  //2. load input records
	ds_batch_in_pen := project(ds_batch_in_aka, xfm_prepend_underscore(left));
	
	ERO_Services.Layouts.layout_extra_penalty  fillPenalty(ds_batch_in_pen l, subject_recs r) := transform
	  self.acctno := l.acctno;
		self.did := r.did;
		self.input_addr := r.input_addr;
		self.subject_Penalty := ERO_Services.Functions.penalize_records(l, r, searchMod);
		self.subject_SN_DOB_MATCH := '';
		self.Relative_Last_Name := l.Relative_Last_Name;
    self.Relative_First_Name := l.Relative_First_Name;
		self.DL_Number:= l.DL_Number;
    self.DL_State := l.DL_State;
    self.VEH_Plate := l.VEH_Plate;
    self.VEH_State := l.VEH_State;
	end;			
	//3. penalize records.
	ds_ERO_header_penalty := join(ds_batch_in_pen, subject_recs, left._acctno = right.acctno, fillPenalty(left,right), INNER, limit(ERO_Services.Constants.Limits.MAX_JOIN_LIMIT));

  // Slim down header dids found based on initial penalty.
	// For each acctno get a list of each dids (lowest penalty calulated) to this point, NO acctno,DID combinations are thrown out yet.
  ds_ERO_head_penalty := dedup(sort(ds_ERO_header_penalty, acctno, did,subject_penalty), acctno, did);
	
	ERO_Services.Layouts.layout_extra_penalty  setDLPlatePen(ds_ERO_head_penalty l) := transform
		 dl_penalty := if (trim(l.dl_number + l.dl_state, all) <> '', ERO_Services.fn_penalize_dl(l), 0);
		 plate_penalty := if (trim(l.VEH_Plate + l.VEH_State, all) <> '', ERO_Services.fn_penalize_plate(l), 0);
		 self.subject_Penalty := l.subject_Penalty + dl_penalty + plate_penalty;
	   self := l;
	end;
	//4. additional penalty applied for DL and PLATE
	ds_ERO_all_penalty := project(ds_ERO_head_penalty, setDLPlatePen(left));

  ds_ERO_all_pen_sorted := sort(ds_ERO_all_penalty, acctno, subject_penalty);
  //5. There is a lot of work here to only get relatives if necessary when a tie exist between the lowest 2 did penalties for each acctno
  // Check for 2 things: 
	// 1. More than 1 did for the same acctno with the same lowest penalty value.
	// 2. The input criteria for the acctno from step 1 would have had to have relative last and/or first name.
	layout_acctno_tie := record
    BatchShare.Layouts.ShareAcct;
		string1 needsTieBreaker := '';
		UNSIGNED subject_Penalty;
	end;	 
	ERO_Services.Layouts.layout_extra_penalty setTieBreakerNeeded(ds_ERO_all_penalty l,ds_ERO_all_penalty r) := transform
	  self.subject_Penalty := l.subject_penalty;  //assign the first penalty value you get for each acctno
    self.needsTieBreaker := if(l.needsTieBreaker <>'', l.needsTieBreaker, 
		                                                  if((trim(l.Relative_Last_Name + l.Relative_first_Name, all) <> '') and
		                                                     (l.subject_Penalty = r.subject_Penalty),'Y','N'));
    self :=l;																
	end;
	//this should only set tiebreaker by looking at first 2 dids penalties but all dids with this penalty will 
	//get a relative match applied.
	ds_ERO_all_acctn_tie_roll := rollup(ds_ERO_all_pen_sorted, left.acctno = right.acctno,setTieBreakerNeeded(left,right));
	//trim down fields to just acctno and needsTieBreaker                   
	ds_ERO_all_acctn_tie := project( ds_ERO_all_acctn_tie_roll, layout_acctno_tie);
	//create dataset of acctno where tiebreaker is needed.
	ds_ERO_tie_needed := ds_ERO_all_acctn_tie(needsTieBreaker='Y');
	// process only those from the right record set that need the rel_match set for tie breaker
	relNeedMatch := join(ds_ERO_all_penalty, ds_ERO_tie_needed, left.acctno = right.acctno and left.subject_penalty = right.subject_penalty,
	                     transform(ERO_Services.Layouts.layout_extra_penalty, self := left),right outer, limit(ERO_Services.Constants.Limits.MAX_JOIN_LIMIT));
	
	ERO_Services.Layouts.layout_extra_penalty  setRelMatch(ds_ERO_all_penalty l) := transform
    self.rel_match := ERO_Services.fn_relativeMatch(l, mod_access.glb, mod_access.dppa);
	 self := l;
	end;
	
	relMatch := project(relNeedMatch, setRelMatch(left));
	// process only those not in the right record set that need the rel_match set for tie breaker
	noRelMatch := join(ds_ERO_all_penalty, ds_ERO_tie_needed, left.acctno = right.acctno, 
	                   transform(ERO_Services.Layouts.layout_extra_penalty, self := left) ,left only);
  // combine those 2 sets from above for final set
  ds_ERO_rel := relMatch + noRelMatch;

	// Restore original acctno before sorting and deduping to pick the best subject per original acctno
	// NOTE: The same acctno will be in orig_subjects multiple times if there was name variations created.
	orig_subjects  := join(ds_ERO_rel, ds_batch_in_aka,  left.acctno = right.acctno, 
													transform(ERO_Services.Layouts.layout_extra_penalty, 
													self.acctno := right.saved_acctno, self := left), left outer, limit(ERO_Services.Constants.Limits.MAX_JOIN_LIMIT));
	
	//pick best subjects based on lowest penalty with Ties being broken by relative name match
	acctno_best_dids := dedup(sort(orig_subjects, acctno, subject_penalty, -rel_match),acctno);   
		
	//==============================================================================================
  //	   O N L Y      B E S T     S U B J E C T S      F R O M    H E R E    O N
	//==============================================================================================
	all_dids := project(acctno_best_dids, transform(doxie.layout_references, self := left));
	best_dids := dedup(sort(all_dids,did),did);
	//get best information from best file
	ds_best :=  doxie.best_records(
	               di            := best_dids
                ,IsFCRA        := false
                ,doSuppress    := false // postpone masking until the very end
                ,doTimeZone    := false // do not append time zone
			          ,checkRNA      := false
								,include_minors:= gm.IncludeMinors
								,getSSNBest    := GetSSNBest,
								modAccess      := mod_access
							);
  
	ERO_Services.Layouts.Subject_out_temp  fillBestInfo(acctno_best_dids l, ds_best r) := transform
    self.acctno := l.acctno;
		self.did := l.did;
		self.input_ssn := '';
		self.input_gender := '';
		self.input_fbi_num := '';
		self.input_dob.year := 0;
		self.input_dob.month := 0;
		self.input_dob.day := 0;
		self.input_name.name_last := '';
		self.input_name.name_first := '';
		self.input_name.name_middle := '';
		self.subject_penalty := (string)L.subject_penalty;
		self.subject_Source_Count := (string)r.total_records;
		self.subject_Last_Name := r.lname ;
		self.subject_First_Name := r.fname;
		self.subject_Middle_Name := r.mname;
		self.subject_Suffix := r.name_suffix;
		self.subject_SSN := r.ssn;
		self.subject_DOB := ero_services.functions.fixdate(r.dob); //YYYYMMDD t0 subject dob mm/dd/yyyy
		self.subject_addr1_match := '';
		self.subject_addr2_match := '';
		self.subject_akas_list := '';
		//assign derived gender from best files title field
		self.subject_gender := map(stringlib.stringtouppercase(r.title) = 'MR' => 'M',
		                           stringlib.stringtouppercase(r.title) = 'MS' => 'F',
															 '');
		self.dedupprim_range1 := '';
		self.dedupprim_name1 := '';
		self.dedupzip1 := '';
		self.dedupprim_range2 := '';
		self.dedupprim_name2 := '';
		self.dedupzip2 := '';
		self.input_raw_City  := '' ;
    self.input_raw_St := '' ;
    self.input_raw_zip := '';
		self := l;
  end;
	//fill best information found and other acctno info
	acctno_best_info := join(acctno_best_dids, ds_best, left.did = right.did, fillBestInfo(LEFT, RIGHT), LEFT OUTER, limit(ERO_Services.Constants.Limits.MAX_JOIN_LIMIT));	
	//fill best file for each original input row.
	ERO_Services.Layouts.Subject_out_temp  restoreInput(ds_batch_in l, acctno_best_info r) := transform
    self.acctno := l.acctno;
		self.did := r.did;
		self.input_ssn := l.ssn;
		self.input_dob := iesp.ECL2ESP.todate((integer)l.dob);
		self.input_gender := l.gender;
		self.input_fbi_num := l.fbi_num;
		self.input_name.name_last := l.name_last;
		self.input_name.name_first := l.name_first;
		self.input_name.name_middle := l.name_middle;
	  self.input_addr.prim_range := l.prim_range;
		self.input_addr.predir := l.predir;
		self.input_addr.prim_name := l.prim_name;
		self.input_addr.addr_suffix := l.addr_suffix;
		self.input_addr.postdir :=  l.postdir;
		self.input_addr.unit_desig := l.unit_desig;
		self.input_addr.sec_range := l.sec_range;
		self.input_addr.p_city_name := l.p_city_name;
		self.input_addr.st :=  l.st;
		self.input_addr.z5 := l.z5;
		self.input_addr.zip4 := l.zip4;
		self.input_addr.county_name := l.county_name;
		self.input_raw_City  := l.input_raw_city ;
    self.input_raw_St := l.input_raw_st ;
    self.input_raw_zip := l.input_raw_zip;
		self.dedupprim_range1 := l.dedupprim_range1;
		self.dedupprim_name1 := l.dedupprim_name1;
		self.dedupzip1 := l.dedupzip1;
		self.dedupprim_range2 := l.dedupprim_range2;
		self.dedupprim_name2 := l.dedupprim_name2;
		self.dedupzip2 := l.dedupzip2;
		self.subject_SN_DOB_MATCH := if (r.acctno <> '',ERO_Services.Functions.sn_dob_match_records(l, r),'');
		self := r;
  end;
	// now fill in each original input request with the best subject found, but only if the gender matches or blank.
	orig_best_subjects  := join(ds_batch_in, acctno_best_info(ut.NNEQ(input_gender,subject_gender)), left.acctno = right.acctno, restoreInput(LEFT, RIGHT), LEFT OUTER, limit(ERO_Services.Constants.Limits.MAX_JOIN_LIMIT));	 
  // create list of all header records for the best subjects ONLY in order to generate AKA name list
  ERO_Services.Layouts.layout_for_akas fillAllAkas(orig_best_subjects l , ds_hdr_recs_for_dids r) := transform
	 self.subject_name := trim(l.subject_Last_Name +',' + l.subject_First_Name +',' +l.subject_Middle_Name, all);
	 self := r;
	end;
	best_header := join(orig_best_subjects, ds_hdr_recs_for_dids, left.did = right.did, fillAllAkas(left,right),LEFT OUTER, limit(ERO_Services.Constants.Limits.MAX_JOIN_LIMIT));
  //fill in aka names
	subjects_akas := ERO_Services.Functions.get_aka_names(best_header);
	ERO_Services.Layouts.Subject_out_temp fillAkas(orig_best_subjects l,subjects_akas r) := transform
	  self.subject_AKAS_LIST := r.akaList;
	  self :=l;
	end;
	subject_recs_best := join(orig_best_subjects, subjects_akas, left.did = right.did, fillAkas(left, right), LEFT OUTER, limit(ERO_Services.Constants.Limits.MAX_JOIN_LIMIT));
	
	//create another set of the subjects info to pass to the sub searches for DL, VEH, ACCIDENTS, CRIM, DEATH...
  Layouts.LookupId  fillLookupSubjects(subject_recs_best l) := transform
	  self.acctno := l.acctno;
		self.did := l.did;
		self.subject_dob := l.subject_dob;
		self.subject_ssn := l.subject_ssn;
		self.input_ssn := l.input_ssn;
		self.input_dob := l.input_dob;
		self.input_gender := l.input_gender;
		self.input_FBI_Num := l.input_FBI_Num;
		self.input_name := l.input_name;
		self.input_addr := l.input_addr;
		self.input_raw_City  := l.input_raw_city ;
    self.input_raw_St := l.input_raw_st ;
    self.input_raw_zip := l.input_raw_zip;
  	self.best_name.name_first    := l.subject_first_name;
		self.best_name.name_middle   := l.subject_middle_name;
		self.best_name.name_last     := l.subject_last_name;
		self.best_name.name_suffix   := l.subject_suffix;
	  self.dedupprim_range1 := l.dedupprim_range1;
		self.dedupprim_name1 := l.dedupprim_name1;
		self.dedupzip1 := l.dedupzip1;
		self.dedupprim_range2 := l.dedupprim_range2;
		self.dedupprim_name2 := l.dedupprim_name2;
		self.dedupzip2 := l.dedupzip2;
		self := [];  //input fields are missing at this point do we need these values for additional info.
	end;
	subject_ids := project(subject_recs_best , fillLookupSubjects(left));

	//addresses 
	subject_w_addrs := ERO_Services.fn_add2Addrs(subject_ids, mod_access);//dataset(Layouts.LookupId)
	//address meta data
	subject_w_meta := ERO_Services.fn_addAddrMeta(subject_w_addrs);//dataset(Layouts.LookupId)
	//address phone info
	subject_w_phone := ERO_Services.fn_addPhone(subject_w_meta);
	// now that we have the best subject name and 2 addresses we can get other data(DL, Accidents, Crims, Veh, Death)	
	additional_recs := ERO_Services.raw.getERODocuments(subject_w_phone);//dataset(Layouts.LookupId)
	// join subjects with additional data and fill in Subject Gender from DL and/or CRIM
	
	ERO_Services.Layouts.BatchOut fillAdditional(subject_recs_best l, additional_recs r) := transform
	    //use the best files gender based on title, if thats blank use DL gender.
	    gender2compare := if (l.subject_gender <> '', functions.fn_get_gender_desc(l.subject_gender),functions.fn_get_gender_desc(r.DL_Gender));  
			self.subject_gender := if (ut.NNEQ(l.input_gender[1],gender2compare[1]), gender2compare, constants.subjectMatch.genderDifferent);      //if both aren't blank and different, remove below
			self.subject_ADDR1_MATCH := r.subject_ADDR1_MATCH;
		  self.subject_ADDR2_MATCH := r.subject_ADDR2_MATCH;
	    self := l;
	    self := r;
	end;
  
  ds_ERO := join(subject_recs_best, additional_recs, left.acctno = right.acctno,fillAdditional(left,right), left outer, limit(ERO_Services.Constants.Limits.MAX_JOIN_LIMIT));	
	// clear all output gathered where input gender doesn't match the subject gender that we found to be best match.
	ds_ERO_cleared := project(ds_ERO(subject_gender[1] = constants.subjectMatch.genderDifferent), transform(ERO_Services.Layouts.BatchOut, self.acctno := left.acctno, self := []));
	ds_ERO_recs := ds_ERO(subject_gender[1] <> constants.subjectMatch.genderDifferent) + ds_ERO_cleared;
	//output(ds_batch_in,named('ds_batch_in'));
	//output(orig_best_subjects,named('orig_best_subjects')); 
	//output(ds_ERO,named('ds_ERO'));
	//output(ds_ERO_recs,named('afterfinalgenderfilter'));
	
	// **************************************************************************************
   // output(ds_batch_in, named('ds_batch_in'));	
   // output(ds_batch_in_aka, named('ds_batch_in_aka'));		
   // output(ds_acctNdidsNinput, named('ds_acctNdidsNinput'));		
   // output(ds_batch_in_common_aka , named('ds_batch_in_common_aka'));	
   // output(ds_hdr_recs_for_dids , named('ds_hdr_recs_for_dids'));	
	 // output(subject_recs, named('subject_recs'));		
  // output(ds_acctNdidsNinputFilterDids, named('ds_acctNdidsNinputFilterDids'));	
	
	 // output(ds_batch_in_pen , named('ds_batch_in_pen'));	
	 // output(subject_recs , named('subject_recs'));		
	 // output(ds_ERO_header_penalty, named('ds_ERO_header_penalty'));											
	 // output(ds_ERO_head_penalty, named('ds_ERO_head_penalty'));		
	  // output(configData.dppapurpose, named('configDatadppapurpose'));		
	  
		//output(orig_subjects, named('subjectsBeforePickingBest'));		
	 
	// output(ds_ERO_low_penalty, named('ds_ERO_low_penalty'));											
	// output(ds_ERO_all_penalty, named('ds_ERO_all_penalty'));											
	 // output(acctno_best_dids, named('acctno_best_dids'));											
	 // output(best_dids, named('best_dids'));											
	 // output(ds_best, named('ds_best'));											
   // output(acctno_best_info, named('acctno_best_info'));													
    // output(ds_batch_in , named('ds_batch_in'));	
    // output(orig_best_subjects , named('orig_best_subjects'));	
	 // output(subject_recs_best, named('subject_recs_best'));
	 // output(subject_ids, named('subject_ids'));	
	 // output(subject_w_phone, named('subject_w_phone'));	
	 //output(subject_w_addrs, named('subject_w_addrs'));	
	// output(subject_w_meta, named('subject_w_meta'));	
	// output(additional_recs, named('additional_recs'));	
		
	//relative tie breaker test output
	 // output(ds_ERO_all_penalty, named('ds_ERO_all_penalty'));	
	 // output(ds_ERO_all_pen_sorted, named('ds_ERO_all_pen_sorted'));	
	 // output(ds_ERO_all_acctn_tie_roll, named('ds_ERO_all_acctn_tie_roll'));	
	 // output(ds_ERO_all_acctn_tie, named('ds_ERO_all_acctn_tie'));	
   // output(ds_ERO_tie_needed, named('ds_ERO_tie_needed'));	 													
   // output(relNeedMatch , named('relNeedMatch'));	 													
    // output(RelMatch, named('RelMatch'));	 													
    // output(noRelMatch, named('noRelMatch'));	 													

	return ds_ERO_recs;
end;