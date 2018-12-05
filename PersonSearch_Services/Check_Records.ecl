import iesp, doxie, AutoStandardI ,AutoHeaderI,DriversV2_Services,PersonSearch_Services, MDR, Standard,Suppress,ut,NID;

out_rec := iesp.checkpersonsearch.t_CheckPersonSearchRecord;

export Check_Records(DATASET(iesp.checkpersonsearch.t_CheckPersonSearchRequest) ds_in) := module
	 //=======================================================
   //  PersonSearch_Services.Functions.add_ssn_issue()
	 //	 use this to add ssn issue dates and valid indicators.
	 //=======================================================
	 
	 first_row := ds_in[1] : INDEPENDENT;
   //set options
   #stored('CheckNameVariants', true);     //force the use of nameVariants for last name
   #constant('BpsLeadingNameMatch', true);		
  
	 // not sure we need these alsoFound variables
   boolean return_waf := true : STORED('ReturnAlsoFound');
	 boolean negate_true_defaults := false : STORED('ECL_NegateTrueDefaults'); // internal ECL use only
   boolean include_wealsofound := return_waf AND ~negate_true_defaults;
   
   iesp.ECL2ESP.SetInputBaseRequest (first_row);
   iesp.ECL2ESP.Marshall.Mac_Set (first_row.options);

   //set main search criteria:
	 search_by := global (first_row.SearchBy);
	 search_options := global (first_row.Options);

   // this will set SSN, DID, Name and Address
   report_by := ROW (search_by, transform (iesp.bpsreport.t_BpsReportBy, self.name.last := left.LastName; Self := Left; Self := []));
   clean_inputs := true;
	 iesp.ECL2ESP.SetInputReportBy (report_by, clean_inputs);
   gm := AutoStandardI.GlobalModule();
	 
	 flipLastFirst := search_options.FlipLastFirst;
   DL2use := StringLib.StringToUpperCase(search_by.DriverLicense.LicenseNumber);
	 DLState2use := StringLib.StringToUpperCase(search_by.DriverLicense.IssueState);
	
	 SSN2use := AutoStandardI.InterfaceTranslator.ssn_value.val(project(gm, AutoStandardI.InterfaceTranslator.ssn_value.params));  
 	 lname_val := AutoStandardI.InterfaceTranslator.lname_value.val(project(gm,AutoStandardI.InterfaceTranslator.lname_value.params));
	 lname_set_val := AutoStandardI.InterfaceTranslator.lname_set_value.val(project(gm,AutoStandardI.InterfaceTranslator.lname_set_value.params));
	 cleaned_lname_val := AutoStandardI.InterfaceTranslator.cleaned_input_lname.val(project(gm,AutoStandardI.InterfaceTranslator.cleaned_input_lname.params));

 	 mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated (gm);
   glb_ok := mod_access.isValidGLB();  
	 dob_mask_value := mod_access.dob_mask; 

	 lname_val_length := length(trim(lname_val));
	 short_lname_val := if (lname_val_length < Constants.MIN_LNAME, true, false);
	 short_cleaned_lname_val := if (length(trim(cleaned_lname_val)) < Constants.MIN_LNAME, true, false);
	 PhoneticMatch(string20 l, string20 r) := metaphonelib.DMetaPhone1(l)[1..6] = metaphonelib.DMetaPhone1(r)[1..6];
   PrefFirstMatch(string20 l, string20 r) :=
				NID.mod_PFirstTools.SUBPFLeqPFR(l,r) or NID.mod_PFirstTools.SUBPFLeqR(l,r);

	 hyph_names := ut.stringSplit(lname_val, '-');
	 has_hyph := stringlib.stringfind(lname_val, '-', 1) > 0;	
	 lname_set_use := IF(has_hyph, lname_set_val + hyph_names, lname_set_val);


//check request to see if minimum input criteria is met.
   no_ssn := length(trim(SSN2use)) <> 9;
	 no_dl := length(trim(DLState2use)) <> 2 or trim(DL2use) = '';
	 no_lname := trim(lname_val) = '';
	 
	 unsigned ErrorCode := 301; //'Insufficient input'
	 string ErrorMessage := doxie.errorCodes(ErrorCode);
	 if ((no_ssn and no_dl) or no_lname,  fail(ErrorCode,ErrorMessage));

// FIND DIDS 
 // BY SSN
	  
    headMod := module(project(gm,AutoheaderI.LIBIN.FetchI_Hdr_Indv.full ,opt))
		  export lastname := '';
		  export lname := '';
		end;
		ssn_dids := AutoHeaderI.LIBCALL_FetchI_Hdr_Indv.do(headMod);
 // BY DL state,DL number.
    snumRecs := dataset([{DL2use,DLState2use}] , DriversV2_Services.layouts.snum) ;
    dl_dids := DriversV2_Services.DLRaw.get_did_from_snum(snumRecs);

//  load them into dids2use, remove dups and check for blank did values
 	 tmp_rec := record
	   unsigned6 did;
		 integer foundbySSN := 0;
		 integer SSNNameMatch := 0;
		 integer foundbyDL := 0;
		 integer DLNameMatch := 0;
		 integer tieBreaker := 0;
		 integer dobScore := 0;
	 end;
	 dids_by_dl_dups  := project(dl_dids, TRANSFORM(tmp_rec, SELF.foundbyDL := 1, SELF := LEFT));
   dids_by_ssn_dups := project(ssn_dids, TRANSFORM(tmp_rec, SELF.foundbySSN := 1, SELF := LEFT));
  
	 dids_both_types := sort(dids_by_ssn_dups + dids_by_dl_dups, did);
	 tmp_rec loadFoundFlags(tmp_rec L, tmp_rec R) := transform
	   self.did := L.did;
		 self.foundbySSN := if (L.foundbySSN = 0, R.foundbySSN, L.foundbySSN);
		 self.foundbyDL := if (L.foundbyDL =0 , R.foundbyDL, L.foundbyDL);
	 end;
    
	 dids2use := rollup(dids_both_types, LoadFoundFlags(LEFT, RIGHT), did);
   
	 //how many different unique dids where found
   did_count := count(dids2use);

   allDIDRecs := true;
	 gongbydidonly := true;
	 //get all header records using all DIDs found by SSN and/or DL,DLState
	 // this will handle GLB and DPPA filtering
	 allRecs := doxie.header_records_byDID(project(dids2use,doxie.layout_references_hh), false, false,,false,allDIDRecs,true,not AllDIDRecs,gongByDIDOnly);
	 
	 // PersonSearch_Services.Layouts.headerRecordBK trans(doxie.Layout_presentation le) := TRANSFORM
	 PersonSearch_Services.Layouts.HFS_wide trans(doxie.Layout_presentation le) := TRANSFORM
	  SELF.did := IF(le.did=0,'',INTFORMAT(le.did,12,1));
	// current phone source doc retrieveal requires a DID, so blank out any RIDs for empty DIDs
	  SELF.rid := MAP(le.src='PH'	=>	IF(SELF.did<> '',SELF.did+'PH'+(STRING)le.phone, ''), 
					le.src in MDR.sourceTools.set_Daily_Utility_sources	=>	SELF.did+'UT'+(STRING)le.rid, 
					le.src='QH'	=>	SELF.did+'QH'+(STRING)le.rid,
									(STRING)le.rid);
// note that although daily utilities are split into good and bad, method for 'rid' above is the same for both.
	  SELF.src := MAP (le.src = MDR.sourceTools.src_Daily_Utilities  =>'UT',
	                 le.src = MDR.sourceTools.src_Daily_ZUtilities =>'ZT',
	                 le.src);
	  SELF.first_seen := le.dt_first_seen;
	  SELF.last_seen := MAP( ~glb_ok=>le.dt_nonglb_last_seen,
                   le.dt_last_seen<>0 => le.dt_last_seen, 0);
	  SELF.name_suffix := IF( le.name_suffix[1]='U','',le.name_suffix );
	  SELF.age := ut.GetAgeI(le.dob);
	  SELF.prim_name := IF(mdr.SourceTools.SourceIsDeath(le.src),'',le.prim_name);
	  SELF.phone :=  IF((INTEGER)le.phone=0,'',le.phone);
	  SELF := le;
	  self := [];
  END;
	
	recsNoSSNInfo := project(allRecs, trans(left));
	
	//add ssn issue information, needs input format=HFS_wide and returns data in format=headerRecord
	tempRecs := Functions.add_ssn_issue(recsNoSSNInfo);
	//change format from headerRecord to headerRecordBK to prepare for xformSearchRecs() function.
	recs2format := project(tempRecs, transform(Layouts.headerRecordExt, self := left, self := []));
	noMatchRecs := PersonSearch_Services.Functions.xformSearchRecs(recs2format, false, false);
	
	combined_rec  := record
	  out_rec;
		tmp_rec and not did;
	end;
	combined_rec setNameMatch(noMatchRecs L, dids2use R) := transform
	     name_last_length := length(trim(l.name.last));
			 length75 := MIN(lname_val_length, name_last_length) / MAX(lname_val_length, name_last_length) >= .75;

	     short_name_last := name_last_length < Constants.MIN_LNAME;
		   nameMatched :=      (PhoneticMatch(l.name.last,lname_val)
												       or
														((~short_lname_val and l.name.last[1..length(trim(lname_val))] = lname_val) or 
												     (~short_cleaned_lname_val and l.name.last[1..length(trim(cleaned_lname_val))] = cleaned_lname_val) )
												       or
													   l.name.last in lname_set_use 
												       or
													   (~short_lname_val and ~short_name_last and 
														 ((length75 and stringlib.editDistance(l.name.last, lname_val) <= 2) or
													   (stringlib.stringFind(trim(l.name.last), trim(lname_val),1) > 0) or
													   (stringlib.stringfind(trim(lname_val), trim(l.name.last),1) > 0)))
												       or 
														 (flipLastFirst and (PrefFirstMatch(l.name.first,lname_val) or l.name.first in lname_set_use))
												    ); 
	   	self.nameMatched := nameMatched;														 
      self.SSNNameMatch := if (nameMatched and R.foundbySSN = 1, 1, 0);
			self.DLNameMatch := if (nameMatched and R.foundbyDL = 1, 1, 0);
			self.foundbySSN := R.foundbySSN;
			self.foundbyDL := R.foundbyDL;
      self.DOB2.year := '';
			self.DOB2.month := '';
			self.DOB2.day := '';														 
			self.NameMatchedPlus := 0;
	    self := L;
	 end;
	matchedRecs := join(noMatchRecs, dids2use, (integer)LEFT.UniqueId = RIGHT.DID, setNameMatch(LEFT, RIGHT));
  
	//***************************************************	
	// here is where we need to set dids2use counters
	//***************************************************
	combined_rec loadNameMatchFlags(combined_rec L, combined_rec R) := transform
	   self.foundbySSN := if (L.foundbySSN = 0, R.foundbySSN, L.foundbySSN);
		 self.foundbyDL := if (L.foundbyDL =0 , R.foundbyDL, L.foundbyDL);
		 self := l;
	 end;
   sortedMatched := sort(matchedRecs, UniqueID);
	 rolledAgain := rollup(sortedMatched, LoadNameMatchFlags(LEFT, RIGHT), UniqueId);
   
   cnts_rec := record
	   integer totalfoundbySSN := sum(group,rolledAgain.foundbySSN) ;
	   integer totalfoundbyDL := sum(group,rolledAgain.foundbyDL) ;
	 end;
    
	//find out how many different dids were found by each method (SSN and DL).
  cnts_table := table(rolledAgain, cnts_rec );
  
  filteredRecs := IF(exists(matchedRecs(nameMatched)), matchedRecs(nameMatched), matchedRecs);
	//sort the lastest to the top for each DID value
	//need to determine method for which is lastest *******************************************************
	
  filteredRecs_nodup := dedup(sort(filteredRecs,UniqueId, -DateLastSeen),UniqueId);
	
	  // INCLUDE BEST FILE address and dob/dod for each DID found:
  bestrecs := doxie.best_records(project(filteredRecs_nodup,transform(doxie.layout_references, self.did := (unsigned6)left.UniqueId)),
	                               includeDOD:=true, modAccess := mod_access);
	best_by_did := dedup(bestrecs, did);  //reduce this set to 1 record per DID,  should already have best row on top.

	combined_rec includeBest(filteredRecs_nodup L, best_by_did R) := transform
	   t_dob := iesp.ECL2ESP.toDate((unsigned4)R.dob);	//convert integer to t_date
     self.dob := iesp.ECL2ESP.toDate((unsigned4)R.dob);	
		 self.dob2 := iesp.ECL2ESP.toMaskableDatestring8(iesp.ECL2ESP.DateToString(t_dob));//convert t_date to t_MaskableDate
     self.age := R.age; //unsigned1  
     self.dod := iesp.ECL2ESP.toDatestring8((string8)R.dod);  //Qstring    need to convert t_date
		 address := iesp.ECL2ESP.setAddress(R.prim_name, R.prim_range, R.predir, R.postdir, R.suffix, R.unit_desig, R.sec_range, 
		                                    R.city_name, R.st, R.zip, R.zip4, '');
		 self.addressEx := project(address, transform(iesp.share.t_addressEx, self.HighRiskIndicators := []; self := left));
		 self.PhoneInfo2.Phone10 := R.phone ;//BEST PHONE
		 //self.PhoneInfo2.ListingPhone10//WHAT ABOUT this field, leave as is?
		 self := L;
  end; 	
	
	bestResults := join(filteredRecs_nodup, best_by_did, (integer)LEFT.UniqueId = RIGHT.DID, 
	                    includeBest(LEFT,RIGHT),
	                    KEEP(1), LIMIT(0));
	//mask SSN
   Suppress.MAC_Mask(bestResults, recsMaskedSSN, SSNInfo.ssn, null, true, false, false, false, '', mod_access.ssn_mask);												
	
	//mask DOB
  combined_rec  maskDOB(combined_rec L) := TRANSFORM
    Self.DOB := iesp.ECL2ESP.ApplyDateMask (L.DOB, dob_mask_value);
    Self.DOB2 := iesp.ECL2ESP.ApplyDateStringMask (L.DOB2, dob_mask_value);
	  SELF.AGE := if (dob_mask_value != suppress.Constants.datemask.NONE, 0, L.AGE);
	  SELF := L;
	END;
	maskedrecs := project(recsMaskedSSN, maskDOB(LEFT));
	
	combined_rec  loadit(maskedRecs l, cnts_table r) := transform
         matchScore := functions.nameScore(did_count, R.totalfoundbyDL, R.totalfoundbySSN, L.foundbyDL, L.foundbySSN, 
				                                   L.nameMatched);  
         self.nameMatchedPlus := matchScore;
				 self.tieBreaker := map(matchScore IN [9,10,12,19,20,22,23,24,26,29,30,32] and L.foundbySSN = 1 => 1,
                                matchScore IN [11,21,25,31] and L.foundbyDL = 1 => 1,
															  0);
         self.dobScore := map (l.dob.year > 0 and l.dob.month > 0 and l.dob.day > 0 => 0,
                               (integer)l.dob2.year > 0 and (integer)l.dob2.month > 0 and (integer)l.dob2.day >0 => 0,
				                       l.dob.year > 0 and l.dob.month > 0 => 1,
				                       (integer)l.dob2.year > 0 and (integer)l.dob2.month > 0 => 1,
				                       l.dob.year > 0 => 2,
				                       (integer)l.dob2.year > 0 => 2,
				                       3);
         self := l;	
				 self := r;
	end;	 
	 
	outrecs := join(maskedRecs, cnts_table, TRUE, loadit(left,right), ALL);
	sortedRecs := SORT(outrecs,  -nameMatched, if (did_count = 1, 0, 1), nameMatchedPlus, -tieBreaker, if(SSNInfo.ssn = SSN2use,0,1),dobScore, _penalty);			
	
	//dedupRecs := dedup(sortedRecs, if (nameMatched, 0, 1), if (did_count = 1, 0, 1), nameMatchedPlus);

  bestRec := choosen(sortedRecs,1); 
  // output(did_count,named('did_count'));
  // output(cnts_table,named('cnts_table'));
  // output(dids2use,named('dids2use'));
  // output(outrecs,named('outrecs'));
  // output(sortedRecs,named('sortedRecs'));
  // output(bestRec,named('bestRec'));
	
  export results := project(bestRec, out_rec);   
end;//module
  