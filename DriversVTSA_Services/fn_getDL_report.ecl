import doxie, Codes, Census_Data, Suppress, ut, AutoStandardI,DriversVTSA;

// handy abbreviations
k_seq := DriversVTSA.Key_DL_Seq;
KeyCodes := Codes.KeyCodes;


export dataset(layouts.result_wide_tmp) fn_getDL_report(
  dataset(layouts.seq) in_seqs,
	GetDLParams.params gdlParams = GetDLParams.getDefault()
) := function
	
	use_NonDMVSources := input.incNonDMV and ~doxie.DataRestriction.CY;
	
	// join inputs to index to get raw data
	dl_raw := join(
		in_seqs, k_seq,
	  keyed(left.dl_seq = right.dl_seq)
			and (use_NonDMVSources or (right.source_code not in DriversVTSA.Constants.nonDMVSources)),
		limit(1000)
	);

	penaltyAddr(STRING predirFld, STRING prangeFld, STRING pnameFld, STRING suffixFld,
							STRING postdirFld, STRING secRangeFld, STRING cityFld, STRING stateFld,
							STRING zipFld, BOOLEAN allowWld = FALSE, STRING city2Fld = '') := FUNCTION
		tm := MODULE(PROJECT(gdlParams, AutoStandardI.LIBIN.PenaltyI_Addr.full, OPT))
			EXPORT allow_wildcard := allowWld;
			EXPORT city_field := cityFld;
			EXPORT city2_field := city2Fld;
			EXPORT pname_field := pnameFld;
			EXPORT postdir_field := postdirFld;
			EXPORT prange_field := prangeFld;
			EXPORT predir_field := predirFld;
			EXPORT state_field := stateFld;
			EXPORT suffix_field := suffixFld;
			EXPORT zip_field := zipFld;
			EXPORT sec_range_field := secRangeFld;
		END;

		RETURN AutoStandardI.LIBCALL_PenaltyI_Addr.val(tm);
	END;

	penaltyDID(STRING didFld) := FUNCTION
		tm := MODULE(PROJECT(gdlParams, AutoStandardI.LIBIN.PenaltyI_DID.full, OPT))
			EXPORT did_field := didFld;
		END;

		RETURN AutoStandardI.LIBCALL_PenaltyI_DID.val(tm);
	END;

	penaltyDOB(STRING dobFld) := FUNCTION
		tm := MODULE(PROJECT(gdlParams, AutoStandardI.LIBIN.PenaltyI_DOB.full, OPT))
			EXPORT dob_field := dobFld;
		END;

		RETURN AutoStandardI.LIBCALL_PenaltyI_DOB.val(tm);
	END;

	penaltyName(STRING fnameFld, STRING mnameFld, STRING lnameFld, BOOLEAN allowWld = FALSE) := FUNCTION
		tm := MODULE(PROJECT(gdlParams, AutoStandardI.LIBIN.PenaltyI_Indv_Name.full, OPT))
			EXPORT fname_field := fnameFld;
			EXPORT mname_field := mnameFld;
			EXPORT lname_field := lnameFld;
			EXPORT allow_wildcard := allowWld;
		END;

		RETURN AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(tm);
	END;

	penaltySSN(STRING ssnFld) := FUNCTION
		tm := MODULE(PROJECT(gdlParams, AutoStandardI.LIBIN.PenaltyI_SSN.full, OPT))
			EXPORT ssn_field := ssnFld;
		END;

		RETURN AutoStandardI.LIBCALL_PenaltyI_SSN.val(tm);
	END;

	penaltyDLState(STRING2 dlState) := FUNCTION
		RETURN MAP(dlState = '' => 0,
							 gdlParams.dlState = '' => 0,
							 dlState = gdlParams.dlState => 0,
							 10);
	END;

	// add computed fields
	layouts.result_wide_tmp addValue(dl_raw L) := transform
	
		// NOTE: It would be really nice to use doxie.FN_Tra_Penalty() here,
		//       but that's tricky because we don't have a field for phone
		//       in the input data.  When we switch to the use of interfaces,
		//       we should ensure that a consolidated penalty computation
		//       routine allows us to effectively disable certain sections.
		self.penalt :=
			penaltyAddr(
				L.predir, L.prim_range, L.prim_name, L.suffix, L.postdir, L.sec_range,
				L.v_city_name, L.st, L.zip5, , L.p_city_name) +
			penaltyDID( (string)L.did ) +
			penaltyDOB( (string)L.dob ) +
			penaltyName(L.fname, L.mname, L.lname) +
			penaltySSN(L.ssn) + 
			penaltyDLState(L.orig_state);
			
		self.nonDMVSource		:= if(L.source_code in DriversVTSA.Constants.nonDMVSources, 'Y', 'N');
		
		self.age_today			:= ut.GetAgeI(L.dob);
		self.dead_age				:= if((unsigned4)L.dod=0,0,((unsigned4)L.dod-L.dob) div 10000);
		self.county_name 		:= ''; // we'll fill this in later
		
		self.race_name			:= map(
																L.race = 'W' => 'WHITE',
																L.race = 'B' => 'BLACK',
																L.race = 'H' => 'HISPANIC',
																L.race = 'A' => 'ASIAN',
																L.race = 'I' => 'NATIVE AMERICAN',
																L.race = 'O' => 'OTHER',
																L.race
															);
		
		self.sex_name						:= KeyCodes('GENERAL',					'GENDER',						,							L.sex_flag, 			true);
		self.orig_state_name		:= KeyCodes('GENERAL',					'STATE_LONG',				,							L.orig_state, 		true);
		
		self.history_name				:= DriversVTSA.Lookups.lookup_history(L.history);//KeyCodes('DRIVERS_LICENSE',	'HISTORY',					,							L.history, 				true);
		self.eye_color_name			:= DriversVTSA.Lookups.lookup_Eye_Color(L.eye_color);
		self.hair_color_name		:= DriversVTSA.Lookups.lookup_Hair_Color(L.hair_color);
		self.attention_name			:= '';//KeyCodes('DRIVERS_LICENSE',	'ATTENTION_FLAG',		L.orig_state,	L.attention_flag, true);
		
		self.license_type_name	:= '';//KeyCodes('DRIVERS_LICENSE2',	'LICENSE_TYPE',			L.orig_state,	L.license_type,		true);
		self.license_type		:= ''; //blanking out since we do not have the lookup for tsa
		self.license_class_name	:= DriversVTSA.Lookups.lookup_License_Class(l.license_class);
		self.status_name				:= '';//KeyCodes('DRIVERS_LICENSE2',	'STATUS',						L.orig_state,	L.status,					true);
		self.cdl_status_name		:= '';//KeyCodes('DRIVERS_LICENSE2',	'CDL_STATUS',				L.orig_state,	L.cdl_status,			true);
		
		string15 restrict_delim(unsigned1 idx) := stringlib.stringextract(L.restrictions_delimited, idx);
		self.restriction1 := '';//KeyCodes('DRIVERS_LICENSE', 'RESTRICTIONS', L.orig_state, restrict_delim(1), true);
		self.restriction2 := '';//KeyCodes('DRIVERS_LICENSE', 'RESTRICTIONS', L.orig_state, restrict_delim(2), true);
		self.restriction3 := '';//KeyCodes('DRIVERS_LICENSE', 'RESTRICTIONS', L.orig_state, restrict_delim(3), true);
		self.restriction4 := '';//KeyCodes('DRIVERS_LICENSE', 'RESTRICTIONS', L.orig_state, restrict_delim(4), true);
		self.restriction5 := '';//KeyCodes('DRIVERS_LICENSE', 'RESTRICTIONS', L.orig_state, restrict_delim(5), true);
		
		string15 endorse_delim(unsigned1 idx) := L.lic_endorsement[idx];
		self.endorsement1 := '';//KeyCodes('DRIVERS_LICENSE', 'LIC_ENDORSEMENT', L.orig_state, endorse_delim(1), true);
		self.endorsement2 := '';//KeyCodes('DRIVERS_LICENSE', 'LIC_ENDORSEMENT', L.orig_state, endorse_delim(2), true);
		self.endorsement3 := '';//KeyCodes('DRIVERS_LICENSE', 'LIC_ENDORSEMENT', L.orig_state, endorse_delim(3), true);
		self.endorsement4 := '';//KeyCodes('DRIVERS_LICENSE', 'LIC_ENDORSEMENT', L.orig_state, endorse_delim(4), true);
		self.endorsement5 := '';//KeyCodes('DRIVERS_LICENSE', 'LIC_ENDORSEMENT', L.orig_state, endorse_delim(5), true);
		
		// clobber 0's in height/weight
		self.height := if( (unsigned)L.height=0, '', L.height );
		self.weight := if( (unsigned)L.weight=0, '', L.weight );
		
		self := L;
	end;
	dl_val := project(dl_raw, addValue(left));
	
	// sort & dedup
	dl_sd := dedup( sort( dl_val, penalt, -lic_issue_date, -expiration_date, record ) );
	
	// fill in the county_name
	Census_Data.MAC_Fips2County_Keyed(dl_sd, st, county, county_name, dl_county);
	
	// suppress/mask sensitive data
	ssn_mask_value	:= input.ssn_mask;
	dl_mask_value		:= input.dl_mask;
	dppa_purpose		:= input.dppa_purpose;
	
  Suppress.MAC_Suppress(dl_county,pull_tmp,input.applicationType,Suppress.Constants.LinkTypes.DID,DID);
  Suppress.MAC_Suppress(pull_tmp,dl_pulled,input.applicationType,Suppress.Constants.LinkTypes.SSN,ssn);
	
	dl_glb	:= dl_pulled(ut.PermissionTools.GLB.minorOK(age_today));
	dl_dppa := dl_glb(ut.PermissionTools.dppa.state_ok(orig_state,dppa_purpose,,source_code));
	
	Suppress.MAC_Mask(dl_dppa, dl_masked, ssn, dl_number, true, true);
	
	return dl_masked;
	
end;