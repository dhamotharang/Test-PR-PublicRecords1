IMPORT IdentityManagement_Services, AutoHeaderV2, iesp, AutoStandardI, doxie, dx_header, ut, Suppress;

export Functions := module
	export streetAddress1Value(string prim_name, string prim_range, string predir, string addr_suffix, string postdir) :=
										if (prim_name = '', '',
																trim(prim_range,left,right) + ' ' + trim(predir,left,right) + ' ' +
																trim(prim_name,left,right) + ' ' + trim(addr_suffix) + ' ' + 
																trim(postdir,left,right));
							 
	export streetAddress2Value(string city, string st, string zip) := 					
							if (city = '', '', city + ' ' + trim(st,left,right) + ' ' + trim(zip,left,right));
																			
	export stateCityZipValue(string city, string st, string zip) :=
							 if (city = '' OR zip = '', '', trim(st) + ' ' + city + ' ' + trim(zip));
							 
	EXPORT debatable_names(InData, OutLayout, FieldName) := FUNCTIONMACRO

		//Skip records which have debatable/controversial names
		OutLayout skip_recs(InData L) := FUNCTION
		do_skip :=  REGEXFIND('\\b' + IdentityManagement_Services.Constants.DebatableNames + '\\b',L.FieldName,NOCASE);
			OutLayout txm := TRANSFORM, SKIP(do_skip)
				SELF := L;
			END;
		RETURN txm;
		END;

		OutData := PROJECT(InData,skip_recs(LEFT));
		RETURN OutData;
	ENDMACRO;

/*** Search Functions ***/

// Clean dl as its not supported by new library as of date today
	EXPORT layouts._dl xform_cdl (layouts.in_layout L) := TRANSFORM
		dl_value := TRIM(stringlib.stringtouppercase(IF(L.dl_num<>'', L.dl_num, '')));
		dl_state_value := TRIM(stringlib.stringtouppercase(IF(L.dl_st<>'', L.dl_st, '')));
		SELF.dl_num := dl_value;    		//AutoStandardI.InterfaceTranslator.dl_number.val
		SELF.dl_st  := dl_state_value;  //AutoStandardI.InterfaceTranslator.dl_state.val
	END;
	
// Modifed from AutoHeaderV2.LIBCALL_conversions to add Driver License
	EXPORT CleanInput (DATASET(layouts.in_layout) ds_in, boolean is_saltFetch = false) := FUNCTION
		ssn_cleaned 		:= AutoHeaderV2.translate.GetCleanedSSN (ds_in[1].ssn, ds_in[1].ApplicationType); //translate does not support cleaning so only SSN cleaned here.
		ds_in_except_dl	:= PROJECT(ds_in, TRANSFORM(AutoHeaderV2.layouts.lib_search, SELF.ssn := ssn_cleaned, SELF := LEFT));
    first_row := ds_in_except_dl[1];
		first_row_dl := ds_in[1];
    layouts.layout_cleaner clean () := TRANSFORM
      SELF.seq 	:= first_row.seq;
      // AutoStandardI.InterfaceTranslator.did_value.val
      SELF.did			:= (UNSIGNED6) IF(stringlib.stringfilterout(first_row.did, '0123456789')= '', first_row.did, '');
      SELF.rid			:= (UNSIGNED6) first_row.rid;    //AutoStandardI.InterfaceTranslator.rid_value.val
      SELF.tname		:= AutoHeaderV2.translate.cname (first_row,is_saltFetch); // Name
      SELF.taddress := AutoHeaderV2.translate.caddress (first_row,is_saltFetch);// Address
      SELF.tssn 		:= AutoHeaderV2.translate.cssn (first_row); // SSN
      SELF.tphone 	:= AutoHeaderV2.translate.cphone (first_row); //Phone
      SELF.tdob			:= AutoHeaderV2.translate.cdob (first_row); // DOB
			SELF.tdl			:= ROW(xform_cdl(first_row_dl)); //Driver License
      // OPTIONS
      SELF.options.score_threshold := if (first_row.StrictMatch, // AutoStandardI.InterfaceTranslator.score_threshold_value.val
				                                  1, // for some reason, header_records (at least) uses < rather than <=
				                                  first_row.scorethreshold);
      SELF.options.strict_match 	:= first_row.StrictMatch;
      SELF.options.isCRS 					:= first_row.isCRS;
      SELF.options.only_best_did 	:= first_row.useonlybestdid;
      SELF.options.household 			:= first_row.household;
      SELF.options.ln_branded 		:= first_row.lnbranded;
      SELF.options.nonexclusion 	:= first_row.nonexclusion;
      SELF.options.include_minors := first_row.include_minors;
      SELF.options._lookup				:= first_row._lookup;
			SELF.options.SearchIgnoresAddressOnly := first_row.searchignoresaddressonly;
			// Self.options.glb := first_row.glb;
    END;
   RETURN DATASET([clean()]);
	END;

	EXPORT SetSearchBy(DATASET(iesp.identitymanagementsearch.t_IdentityManagementSearchRequest) request) := FUNCTION
		IdentityManagement_Services.layouts.in_layout xfrmlibV2(RECORDOF(request) L):= TRANSFORM
//DID
			SELF.did 								:= L.SearchBy.UniqueId;
//SSN - Missing: SSN Mask
			SELF.ssn 								:= L.SearchBy.SSN;
			SELF.ssntypos						:= L.Options.AllowSSNTypos;
//NAME - Missing: suffix
			SELF.unparsedfullname		:= L.SearchBy.Name.Full;
			SELF.firstname 					:= L.SearchBy.Name.First;
			SELF.lastname 					:= L.SearchBy.Name.Last;
			SELF.middlename 				:= L.SearchBy.Name.Middle;
			SELF.phoneticmatch 			:= L.Options.UsePhonetics;	
			SELF.allownicknames 		:= L.Options.UseNicknames;	
//Addr	- Missing: pre, post dirion, unit designation, StreetSuffix
			SELF.addr 							:= L.SearchBy.Address.StreetAddress1;
			SELF.primrange 					:= L.SearchBy.Address.StreetNumber;
			SELF.primname 					:= L.SearchBy.Address.StreetName;
			SELF.secrange 					:= L.SearchBy.Address.UnitNumber;
			SELF.city 							:= L.SearchBy.Address.City;
			SELF.state 							:= L.SearchBy.Address.State;
			SELF.zip 								:= L.SearchBy.Address.Zip5;
			SELF.county 						:= L.SearchBy.Address.County;
			SELF.statecityzip 			:= L.SearchBy.Address.statecityzip;
//Phone	
			SELF.Phone 							:= L.SearchBy.Phone10;
//DOB
      integer2 Year	:= L.SearchBy.DOB.Year; 
      integer2 Month	:= L.SearchBy.DOB.Month; 
      integer2 Day	:= L.SearchBy.DOB.Day;
			SELF.DOB 								:= (UNSIGNED8)Year*10000 + Month*100 + Day;
//Driver License
			SELF.dl_num							:= L.SearchBy.DLNumber;
			SELF.dl_st							:= L.SearchBy.DLState;
//ScoreThreshold
			SELF.ScoreThreshold 		:= L.Options.ScoreThreshold;
//FuzzySecRange- RR159861:Workaround when sec range provided in input (7323 Aviation Blvd  MS 1105)
			integer FuzzySecRange := AutoStandardI.Constants.SECRANGE.EXACT :STORED('FuzzySecRange');
			SELF.FuzzySecRange			:= FuzzySecRange;
		END;
	in_mod := PROJECT(request,xfrmlibV2(LEFT));
	RETURN in_mod;
	END;


// *************** To get SSN_INFO **************************//
// Added during bug 165034 //
export add_ssn_issue(dataset(doxie.layout_presentation) inrecs) := FUNCTION

	ext_rec := record (doxie.layout_presentation)
		boolean legacy_ssn := false; // for potentially randomized SSNs defines if SSN-DID pair was seen before
  end;
	
	// check if SSN was seen before randomization:
	ssn_w_legacy_info := join (inrecs, dx_header.key_legacy_ssn(),
														 keyed (Left.ssn = Right.ssn) AND
														 ((unsigned6) Left.did = Right.did),
														 transform (ext_rec, Self.legacy_ssn := Right.ssn != '', Self := Left),
														 LEFT OUTER, KEEP (1), limit (0)); //at most 1 : 1 relation
														 
	layouts.headerRecordEx getSSNInfo(ext_rec L,doxie.Key_SSN_Map R) := transform
             dcNeeded := Suppress.dateCorrect.do(l.ssn).needed;
						 // new ssn-issue data have '20990101' for the current date intervals
             r_end := IF (R.end_date='20990101', 0, (unsigned4) R.end_date);
						 
						 m_validation := ut.GetSSNValidation (L.ssn);
             boolean is_valid := m_validation.is_valid;
             boolean is_legacy := m_validation.is_valid AND R.ssn5 = '' AND L.legacy_ssn;
             self.ssn_issue_early_fulldate := Suppress.dateCorrect.sdate_u4(L.ssn, (unsigned4) R.start_date);
             self.ssn_issue_last_fulldate := Suppress.dateCorrect.edate_u4(L.ssn, r_end);
						 self.ssn_issue_state := Suppress.dateCorrect.state(L.ssn, R.state);
						 valid := (is_valid and not is_legacy and ((integer)L.ssn not in doxie.bad_ssn_list));
             self.ssn_valid_issue := valid;
             self := L;
             end;

	result := join (ssn_w_legacy_info, doxie.Key_SSN_Map,
                   keyed (left.ssn[1..5] = Right.ssn5) AND
                   keyed (left.ssn[6..9] between Right.start_serial AND Right.end_serial),
                   getSSNInfo (Left, Right),
                   LEFT OUTER, KEEP (1), limit (0)); //1 : 1 relation
                                
	RETURN result;
END; // END OF add_ssn_issue

													
END;
