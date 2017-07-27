import DriversV2, doxie, Codes, Census_Data, Suppress, ut, AutoStandardI, InsuranceHeader_BestOfBest, 
       DriversV2_Services, STD;

// handy abbreviations
k_seq := DriversV2.Key_DL_Seq;
KeyCodes := Codes.KeyCodes;
empty_in_seqs := dataset([], layouts.seq);
empty_in_src := dataset([], layouts.src);

export dataset(DriversV2_Services.layouts.result_wide_tmp) fn_getDL_report(
  dataset(DriversV2_Services.layouts.seq) in_seqs=empty_in_seqs,
  dataset(DriversV2_Services.layouts.src) in_dl_src=empty_in_src,
	DriversV2_Services.GetDLParams.params gdlParams = DriversV2_Services.GetDLParams.getDefault(),
	BOOLEAN IsBatch = FALSE
) := function
	
	use_NonDMVSources := DriversV2_Services.input.incNonDMV and ~doxie.DataRestriction.CY;
	
	// join inputs to index to get raw data
	dl_raw_seq := join(
		in_seqs, k_seq,
	  keyed(left.dl_seq = right.dl_seq)
			and (use_NonDMVSources or (right.source_code not in DriversV2.Constants.nonDMVSources)),
		limit(0), keep (1) //M:1 join
	);

	dl_raw := IF(IsBatch, in_dl_src, dl_raw_seq + in_dl_src);

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
	DriversV2_Services.layouts.result_wide_tmp addValue(dl_raw L) := transform
	
		// NOTE: It would be really nice to use doxie.FN_Tra_Penalty() here,
		//       but that's tricky because we don't have a field for phone
		//       in the input data.  When we switch to the use of interfaces,
		//       we should ensure that a consolidated penalty computation
		//       routine allows us to effectively disable certain sections.
		tot_penalt :=
			penaltyAddr(
				L.predir, L.prim_range, L.prim_name, L.suffix, L.postdir, L.sec_range,
				L.v_city_name, L.st, L.zip5, , L.p_city_name) +
			penaltyDID( (string)L.did ) +
			penaltyDOB( (string)L.dob ) +
			penaltyName(L.fname, L.mname, L.lname) +
			penaltySSN(L.ssn) + 
			penaltyDLState(L.orig_state);
		
		self.penalt := if(input.randomize, 0, tot_penalt);
			
		self.nonDMVSource		:= if(L.source_code in DriversV2.Constants.nonDMVSources, 'Y', 'N');
		
		self.age_today			:= ut.Age(L.dob);
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
		
		self.history_name				:= KeyCodes('DRIVERS_LICENSE',	'HISTORY',					,							L.history, 				true);
		self.eye_color_name			:= KeyCodes('DRIVERS_LICENSE',	'EYE_COLOR',				L.orig_state,	L.eye_color,			true);
		self.hair_color_name		:= KeyCodes('DRIVERS_LICENSE',	'HAIR_COLOR',				L.orig_state,	L.hair_color,			true);
		self.attention_name			:= KeyCodes('DRIVERS_LICENSE',	'ATTENTION_FLAG',		L.orig_state,	L.attention_flag, true);
		
		self.license_type_name	:= KeyCodes('DRIVERS_LICENSE2',	'LICENSE_TYPE',			L.orig_state,	L.license_type,		true);
		self.license_class_name	:= KeyCodes('DRIVERS_LICENSE2',	'LICENSE_CLASS',		L.orig_state,	L.license_class,	true);
		self.status_name				:= KeyCodes('DRIVERS_LICENSE2',	'STATUS',						L.orig_state,	L.status,					true);
		self.cdl_status_name		:= KeyCodes('DRIVERS_LICENSE2',	'CDL_STATUS',				L.orig_state,	L.cdl_status,			true);
		
		string15 restrict_delim(unsigned1 idx) := stringlib.stringextract(L.restrictions_delimited, idx);
		self.restriction1 := KeyCodes('DRIVERS_LICENSE', 'RESTRICTIONS', L.orig_state, restrict_delim(1), true);
		self.restriction2 := KeyCodes('DRIVERS_LICENSE', 'RESTRICTIONS', L.orig_state, restrict_delim(2), true);
		self.restriction3 := KeyCodes('DRIVERS_LICENSE', 'RESTRICTIONS', L.orig_state, restrict_delim(3), true);
		self.restriction4 := KeyCodes('DRIVERS_LICENSE', 'RESTRICTIONS', L.orig_state, restrict_delim(4), true);
		self.restriction5 := KeyCodes('DRIVERS_LICENSE', 'RESTRICTIONS', L.orig_state, restrict_delim(5), true);
		
		string15 endorse_delim(unsigned1 idx) := L.lic_endorsement[idx];
		self.endorsement1 := KeyCodes('DRIVERS_LICENSE', 'LIC_ENDORSEMENT', L.orig_state, endorse_delim(1), true);
		self.endorsement2 := KeyCodes('DRIVERS_LICENSE', 'LIC_ENDORSEMENT', L.orig_state, endorse_delim(2), true);
		self.endorsement3 := KeyCodes('DRIVERS_LICENSE', 'LIC_ENDORSEMENT', L.orig_state, endorse_delim(3), true);
		self.endorsement4 := KeyCodes('DRIVERS_LICENSE', 'LIC_ENDORSEMENT', L.orig_state, endorse_delim(4), true);
		self.endorsement5 := KeyCodes('DRIVERS_LICENSE', 'LIC_ENDORSEMENT', L.orig_state, endorse_delim(5), true);
		
		// clobber 0's in height/weight
		self.height := if( (unsigned)L.height=0, '', L.height );
		self.weight := if( (unsigned)L.weight=0, '', L.weight );

    // inline DL-masking
		self.oos_previous_dl_number := if (input.dl_mask and L.oos_previous_dl_number != '', suppress.dl_mask (L.oos_previous_dl_number), L.oos_previous_dl_number);
		self.old_dl_number := if (input.dl_mask and L.old_dl_number != '', suppress.dl_mask (L.old_dl_number), L.old_dl_number);
		self := L;
	end;
	dl_val := project(dl_raw, addValue(left));
	
	// sort & dedup
	dmv := dl_val(source_code not in DriversV2.Constants.nonDMVSources);
	non_dmv := dl_val(source_code in DriversV2.Constants.nonDMVSources);
	dl_sd := dedup( sort( dmv, penalt, -lic_issue_date, -expiration_date, record ) ) &
					 sort(non_dmv, penalt, -dt_last_seen, record);
	
	//Get Insurance Header DL data if needed
	ins_dl_ok := AutoStandardI.DataPermissionI.val(gdlParams).use_InsuranceDLData;
	in_ins_dl := group(sort(dedup(sort(project(dl_sd, 
		transform(InsuranceHeader_BestOfBest.Layouts.InsuranceDL_Layout_Input,
			self.Seq 					:= counter; //not used in search_Insurance_DL_by_DL
			self.DID 					:= left.did; 	
			self.FirstName 		:= left.fname;
			self.LastName			:= left.lname;
			self.DateofBirth	:= (string)left.dob;
			self.DL_Number		:= left.dl_number;
			self.DL_St				:= left.orig_state;
			self.DL_Data_Used := false; //set in search_Insurance_DL_by_DL
		)),
		did, dl_number), did, dl_number), seq),seq);
	
	out_ins_dl	:= InsuranceHeader_BestOfBest.search_Insurance_DL_by_DL(in_ins_dl, DriversV2_Services.input.dppa_purpose, /*isFCRA := */false, gdlParams.datapermissionmask);
	dup_ins_dl 	:= dedup(sort(out_ins_dl, did, -dt_last_seen), did)(ut.DaysApart((string)dt_last_seen, (string) STD.Date.Today()) <= DriversV2_Services.Constants.INS_MAX_DAYS_SINCE_DT_LAST_SEEN);
	ins_dl_ds		:= project(dup_ins_dl, 
		transform(DriversV2_Services.layouts.result_wide_tmp,
			self.did						:= left.did,
			self.dl_number 			:= left.dl_nbr,
			self.orig_state			:= left.dl_state,
			self.dt_first_seen	:= left.dt_first_seen,
			self.dt_last_seen		:= left.dt_last_seen,
			self.source_code		:= left.src,
			self.title					:= left.title,
			self.fname					:= left.fname,
			self.mname					:= left.mname,
			self.lname					:= left.lname,
			self.name_suffix		:= left.sname,
			self.dob						:= left.dob,		
			self	:= []));
	
	w_ins_dl		:= dl_sd & if(ins_dl_ok and gdlParams.IncludeInsuranceDrivers, ins_dl_ds);
		
	// fill in the county_name
	Census_Data.MAC_Fips2County_Keyed(w_ins_dl, st, county, county_name, dl_county);
	
	// suppress/mask sensitive data
	ssn_mask_value	:= if (gdlParams.skipSSNMasking, '',DriversV2_Services.input.ssn_mask);
	dl_mask_value		:= if (gdlParams.skipDLMasking, false, DriversV2_Services.input.dl_mask);
	suppressinput		:= if(IsBatch, dl_sd, dl_county);
	
	Suppress.MAC_Suppress(suppressinput,pull_tmp,gdlParams.applicationType,Suppress.Constants.LinkTypes.DID,did);
	Suppress.MAC_Suppress(pull_tmp,dl_pulled,gdlParams.applicationType,Suppress.Constants.LinkTypes.SSN,ssn);
	
	dl_glb	:= dl_pulled(ut.PermissionTools.GLB.minorOK(age_today));
	dl_dppa := dl_glb(ut.PermissionTools.dppa.state_ok(orig_state,DriversV2_Services.input.dppa_purpose,,source_code));
	
	Suppress.MAC_Mask(dl_dppa, dl_masked, ssn, dl_number, true, true);

	return dl_masked;
	
end;