import AutoStandardI;
import address, doxie, ut, corp2_services, vehiclev2_services, business_header_ss, business_header,
       header, suppress, STD;

export InterfaceTranslator := module
	// provided only for backward compatibility
	export StrictMatch_value := module
		export params := interface
			export boolean OnlyExactMatches := false;
			export boolean StrictMatch := false;
		end;
		// set strict match if either OnlyExactMatches or StrictMatch set (OnlyExactMatches to be retired) 
		export boolean val(params in_mod) := in_mod.OnlyExactMatches or in_mod.StrictMatch;
	end;
	export FuzzySecRange_value := module
    export params := interface
      export integer FuzzySecRange;
    end;
    export integer val(params in_mod) := case (in_mod.FuzzySecRange, 
                                               1 => AutoStandardI.Constants.SECRANGE.EXACT_OR_BLANK,
                                               2 => AutoStandardI.Constants.SECRANGE.INCLUDES_ATOM,
                                               AutoStandardI.Constants.SECRANGE.EXACT);
	end;
	
	// Display Matched Party for Search Service
	export DisplayMatchedParty_value := module
		export params := interface
			export boolean DisplayMatchedParty := false;
		end;
		export boolean val(params in_mod) := in_mod.DisplayMatchedParty;
	end;	

	shared mx_nameasis_val := module
		export params := interface
			export string120 nameasis;
		end;
		export string120 val(params in_mod) := in_mod.nameasis;
	end;
	shared mx_asisname_val := module
		export params := interface
			export string120 asisname;
		end;
		export string120 val(params in_mod) := in_mod.asisname;
	end;
	
	export party_type := module
		export params := interface
			export string1 partytype;
		end;
		export string1 val(params in_mod) := in_mod.partytype;
	end;
  // in compound queries we need a party type designated for bankruptcy in particular;
  // later the same may be needed for UCC, property, etc.
	export party_type_bk := module
		export params := interface
			export string1 partytype_bk;
		end;
		export string1 val(params in_mod) := in_mod.partytype_bk;
	end;
	export AllowLeadingLname_value := module
		export params := interface
			export boolean AllowLeadingLname;
		end;
		export boolean val(params in_mod) := in_mod.AllowLeadingLname;
	end;
	// used for bpssearch to allow for leading name match using all 3 name parts
	export BpsLeadingNameMatch_value := module
		export params := interface
			export boolean BpsLeadingNameMatch;
		end;
		export boolean val(params in_mod) := in_mod.BpsLeadingNameMatch;
	end;	
	export nodeepdive := module
		export params := interface(StrictMatch_value.params)
			export boolean nodeepdive;
		end;
		export boolean val(params in_mod) := StrictMatch_value.val(in_mod) OR	in_mod.nodeepdive;
	end;
//TODO: move to another macro
	export bankruptcyversion := module
		export params := interface
			export unsigned1 bankruptcyversion;
		end;
		export unsigned1 val(params in_mod) := in_mod.bankruptcyversion;
	end;
	export uccversion := module
		export params := interface
			export unsigned1 uccversion;
		end;
		export unsigned1 val(params in_mod) := in_mod.uccversion;
	end;
	export judgmentlienversion := module
		export params := interface
			export unsigned1 judgmentlienversion;
		end;
		export unsigned1 val(params in_mod) := in_mod.judgmentlienversion;
	end;
	export vehicleversion := module
		export params := interface
			export unsigned1 vehicleversion;
		end;
		export unsigned1 val(params in_mod) := in_mod.vehicleversion;
	end;
	export voterversion := module
		export params := interface
			export unsigned1 voterversion;
		end;
		export unsigned1 val(params in_mod) := in_mod.voterversion;
	end;
	export dlversion := module
		export params := interface
			export unsigned1 dlversion;
		end;
		export unsigned1 val(params in_mod) := in_mod.dlversion;
	end;
	export deaversion := module
		export params := interface
			export unsigned1 deaversion;
		end;
		export unsigned1 val(params in_mod) := in_mod.deaversion;
	end;
	export propertyversion := module
		export params := interface
			export unsigned1 propertyversion;
		end;
		export unsigned1 val(params in_mod) := in_mod.propertyversion;
	end;
	export CriminalRecordVersion := module
		export params := interface
			export unsigned1 CriminalRecordVersion;
		end;
		export unsigned1 val(params in_mod) := in_mod.CriminalRecordVersion;
	end;
	export unparsed_fullname_value := module
		export params := interface
			export string120 unparsedfullname;
		end;
		export string120 val(params in_mod) := in_mod.unparsedfullname;
	end;
	export cleaned_name := module
		export params := interface(unparsed_fullname_value.params)
			export string50 lfmname;
			export boolean cleanfmlname;
		end;
		string45 blanks45 := '';
		shared string73 forceAsLname(string120 fullname) := blanks45 + (string20) fullname;
		export string73 val(params in_mod) := map(
			in_mod.lfmname <>'' => Address.CleanPersonLFM73(in_mod.lfmname),
			// new name cleaner was introduced and caused a regression - former version
			// parsed single word inputs as last names always; new version parses them as first names
			// always.   
			// in order to mimic the behavior of the prior name cleaner when only a single word
			// is input as an unparsed full name, skip cleaning altogether and fabricate a result 
			// in the cleanPerson73 format with only last name populated (for both unknown and FML versions)
      STD.Str.CountWords (unparsed_fullname_value.val(in_mod), ' ')<= 1 => forceAsLname(unparsed_fullname_value.val(in_mod)),
			// ut.NoWords(unparsed_fullname_value.val(in_mod)) <= 1 => forceAsLname(unparsed_fullname_value.val(in_mod)),
			in_mod.cleanfmlname => address.CleanPersonFML73(unparsed_fullname_value.val(in_mod)),
			address.CleanPerson73(unparsed_fullname_value.val(in_mod)));
	end;
	shared valid_cleaned := module
		export params := interface(unparsed_fullname_value.params,mx_nameasis_val.params,mx_asisname_val.params)
			export string50 lfmname;
		end;
		export boolean val(params in_mod) := unparsed_fullname_value.val(in_mod) <> '' or mx_nameasis_val.val(in_mod) <> '' or mx_asisname_val.val(in_mod) <> '' or in_mod.lfmname <> '';
	end;
	export did_value := module
		export params := interface
			export string14 did;
		end;
		// M2R issue with customers sending in DIDs that were in invalid format (alphanumeric strings);
		// downstream, the DID gets cast to an unsigned6 and it loses the remainder of the string afetr the first
		// alpha character, which is not what was intended
		//
		// this will enforce the the input DID is a numeric string only; otherwise it will be discarded
		export string14 val(params in_mod) := IF(STD.Str.FilterOut(in_mod.did, '0123456789') = '', in_mod.did, '');
	end;
	export rid_value := module
		export params := interface
			export string14 rid;
		end;
		export string14 val(params in_mod) := in_mod.rid;
	end;
	export fname_val := module
		export params := interface(valid_cleaned.params,cleaned_name.params)
			export string30 firstname;
		end;
		export string30 val(params in_mod) := if(in_mod.firstname = '' and valid_cleaned.val(in_mod),cleaned_name.val(in_mod)[6..25],in_mod.firstname);
	end;
	export rel_fname_val1 := module
		export params := interface
			export string30 relativefirstname1;
		end;
		export string30 val(params in_mod) := in_mod.relativefirstname1;
	end;
	export rel_fname_val2 := module
		export params := interface
			export string30 relativefirstname2;
		end;
		export string30 val(params in_mod) := in_mod.relativefirstname2;
	end;
	export lname_val := module
		export params := interface(valid_cleaned.params,cleaned_name.params)
			export string50 lname;
			export string30 lastname;
		end;
		export string30 val(params in_mod) := map(
			in_mod.lname<>'' => in_mod.lname,
			in_mod.lastname='' AND valid_cleaned.val(in_mod) => cleaned_name.val(in_mod)[46..65],
			in_mod.lastname);
	end;
	export olname1_val := module
		export params := interface
			export string30 otherlastname1;
		end;
		export string30 val(params in_mod) := in_mod.otherlastname1;
	end;
	export lname4_val := module
		export params := interface
			export string4 lname4;
		end;
		export string4 val(params in_mod) := in_mod.lname4;
	end;
	export fname3_val := module
		export params := interface
			export string3 fname3;
		end;
		export string3 val(params in_mod) := in_mod.fname3;
	end;
	export mname_val := module
		export params := interface(valid_cleaned.params,cleaned_name.params)
			export string30 middlename;
		end;
		export string30 val(params in_mod) := if(in_mod.middlename = '' and valid_cleaned.val(in_mod),cleaned_name.val(in_mod)[26..45],in_mod.middlename);
	end;
	export company_name := module
		export params := interface
			export string120 companyname;
		end;
		export string120 val(params in_mod) := STD.Str.ToUpperCase(in_mod.companyname);
	end;
	export state_val := module
		export params := interface
			export string2 state;
		end;
		export string2 val(params in_mod) := in_mod.state;
	end;
	export prev_state_val1l := module
		export params := interface
			export string2 otherstate1;
		end;
		export string2 val(params in_mod) := in_mod.otherstate1;
	end;
	export prev_state_val2l := module
		export params := interface
			export string2 otherstate2;
		end;
		export string2 val(params in_mod) := in_mod.otherstate2;
	end;
	export city_val := module
		export params := interface
			export string25 city;
		end;
		export string25 val(params in_mod) := in_mod.city;
	end;
	export other_city_val := module
		export params := interface
			export string25 othercity1;
		end;
		export string25 val(params in_mod) := in_mod.othercity1;
	end;
	export did_type_mask_val := module
		export params := interface
			export string8 DidTypeMask;
		end;
	export string8 val(params in_mod) := in_mod.DidTypeMask;
	end;
	export zip_val0 := module
		export params := interface
			export string6 zip;
		end;
		// discard all zero zips
		hasAlpha(string6 s) := STD.Str.FilterOut(s, '0123456789') <> ''; //iow, looks canadian 
		export string6 val(params in_mod) := if((integer)in_mod.zip <> 0 or hasAlpha(in_mod.zip), in_mod.zip, '');
	end;
	export PostalCode := module
		export params := interface
			export string6 PostalCode := '';
		end;
		export string6 val(params in_mod) := in_mod.PostalCode;
	end;
	export zipradius_value := module
		export params := interface(StrictMatch_value.params)
			export unsigned2 zipradius;
			export unsigned2 mileradius;
		end;
		export unsigned2 val(params in_mod) := 
			map(
				StrictMatch_value.val(in_mod) => 0,
				in_mod.zipradius != 0 => in_mod.zipradius,
				in_mod.mileradius);
	end;
	export statecityzip_val := module
		export params := interface
			export string50 statecityzip;
		end;
		export string50 val(params in_mod) := in_mod.statecityzip;
	end;
	export currentresidentsonly := module
		export params := interface
			export boolean currentresidentsonly;
		end;
		export boolean val(params in_mod) := in_mod.currentresidentsonly;
	end;
	export phone_val := module
		export params := interface
			export string15 phone;
		end;
		export string15 val(params in_mod) := function
			temp_val := STD.Str.Filter(in_mod.phone,'0123456789');
			return if((integer)temp_val <> 0, in_mod.phone, '');
		end;
	end;
	export fuzzy_ssn := module
		export params := interface
			export boolean ssntypos;
		end;
		export boolean val(params in_mod) := in_mod.ssntypos;
	end;
	export whole_house := module
		export params := interface
			export boolean household;
		end;
		export boolean val(params in_mod) := in_mod.household;
	end;
	export all_dids := module
		export params := interface
			export boolean includealldidrecords;
		end;
		export boolean val(params in_mod) := in_mod.includealldidrecords;
	end;
	export did_only := module
		export params := interface
			export boolean didonly;
		end;
		export boolean val(params in_mod) := in_mod.didonly;
	end;
	export phonetics := module
		export params := interface(StrictMatch_value.params)
			export boolean phoneticmatch;
		end;
		export boolean val(params in_mod) := ~StrictMatch_value.val(in_mod) AND in_mod.phoneticmatch;
	end;
	export nicknames := module
		export params := interface(StrictMatch_value.params)
			export boolean allownicknames;
		end;
		export boolean val(params in_mod) := ~StrictMatch_value.val(in_mod) AND in_mod.allownicknames;
	end;
	export namevariants := module
		export params := interface(StrictMatch_value.params)
			export boolean checknamevariants;
		end;
		export boolean val(params in_mod) := ~StrictMatch_value.val(in_mod) AND in_mod.checknamevariants;
	end;	
	export raw_records := module
		export params := interface
			export boolean raw;
		end;
		export boolean val(params in_mod) := in_mod.raw;
	end;
	export agelow_val := module
		export params := interface
			export unsigned1 agelow;
		end;
		export unsigned1 val(params in_mod) := in_mod.agelow;
	end;
	export agehigh_val := module
		export params := interface
			export unsigned1 agehigh;
		end;
		export unsigned1 val(params in_mod) := in_mod.agehigh;
	end;
	export dob_val := module
		export params := interface
			export unsigned8 dob;
		end;
		// provides consistent handling of input DOBs that are less than 8 digits
		export unsigned8 val(params in_mod) :=  doxie.DOBTools(in_mod.dob).dob_val;
	end;
	export dod_value := module
		export params := interface
			export unsigned8 dod;
		end;
		export unsigned8 val(params in_mod) := in_mod.dod;
	end;
	export AllowFuzzyDOBMatch := module
		export params := interface
			export boolean allowFuzzyDOBMatch;
		end;
		export boolean val(params in_mod) := in_mod.allowFuzzyDOBMatch;
	end;	
	export maxresults_val := module
		export params := interface
			export unsigned8 maxresults;
		end;
		export unsigned8 val(params in_mod) := in_mod.maxresults;
	end;
	export maxresultsthistime_val := module
		export params := interface
			export unsigned8 maxresultsthistime;
		end;
		export unsigned8 val(params in_mod) := in_mod.maxresultsthistime;
	end;
	export skiprecords_val := module
		export params := interface
			export unsigned8 skiprecords;
		end;
		export unsigned8 val(params in_mod) := in_mod.skiprecords;
	end;
	export do_not_fill_blanks := module //only in Doxie.header_records_byDID
		export params := interface
			export boolean donotfillblanks;
		end;
		export boolean val(params in_mod) := in_mod.donotfillblanks;
	end;
	export adl_service_ip := module
		export params := interface
			export string100 seisintadlservice;
		end;
		export string100 val(params in_mod) := in_mod.seisintadlservice;
	end;
	export is_a_neighbor := module
		export params := interface
			export boolean isaneighbor;
		end;
		export boolean val(params in_mod) := in_mod.isaneighbor;
	end;
	export neighbor_service := module
		export params := interface
			export set of string256 neighborservice;
		end;
		export set of string256 val(params in_mod) := in_mod.neighborservice;
	end;
	export report_records := module
		export params := interface
			export boolean report;
		end;
		export boolean val(params in_mod) := in_mod.report;
	end;
	export exclude_lessors := module //TODO: only in vehicles
		export params := interface
			export boolean excludelessors;
		end;
		export boolean val(params in_mod) := in_mod.excludelessors;
	end;
	export score_threshold_value := module
		export params := interface(StrictMatch_value.params)
			export unsigned1 scorethreshold;
		end;
		export unsigned1 val(params in_mod) := 
			if(
				StrictMatch_value.val(in_mod),
				1, // for some reason, header_records (at least) uses < rather than <=
				in_mod.scorethreshold
			);
	end;
	export penalt_threshold_value := module
		export params := interface(StrictMatch_value.params)
			export unsigned2 penalty_threshold;
		end;
		export unsigned1 val(params in_mod) := 
			if(
				StrictMatch_value.val(in_mod),
				0, // here we use <=
				in_mod.penalty_threshold
			);
	end;
	export ssn_mask_val := module
		export params := interface
			export string6 ssnmask;
		end;
		export string6 val(params in_mod) := in_mod.ssnmask;
	end;
	export dl_mask_val := module
		export params := interface
			export unsigned1 dlmask;
		end;
		export unsigned1 val(params in_mod) := in_mod.dlmask;
	end;
	export dob_mask_val := module //TODO: most likely, not used (i.e. can be replaced with dob_mask_value)
		export params := interface
			export string6 dobmask;
		end;
		export string6 val(params in_mod) := in_mod.dobmask;
	end;
	export industry_class_val := module
		export params := interface
			export string5 industryclass := '';
		end;
		export string5 val(params in_mod) := in_mod.industryclass;
	end;
	export probation_override_value := module
		export params := interface
			export boolean probationoverride;
		end;
		export boolean val(params in_mod) := in_mod.probationoverride;
	end;
	export ln_branded_value := module
		export params := interface
			export boolean lnbranded;
		end;
		export boolean val(params in_mod) := in_mod.lnbranded;
	end;
	export non_exclusion_value := module
		export params := interface(ln_branded_value.params,StrictMatch_value.params)
			export boolean nonexclusion;
		end;
		// disable non-exclusion behavior when StrictMatch is enabled
		export boolean val(params in_mod) := ~StrictMatch_value.val(in_mod) AND
																						 (in_mod.nonexclusion or ln_branded_value.val(in_mod));
	end;
	export searchgoodssnonly_value := module
		export params := interface
			export boolean SearchGoodSSNOnly;
		end;
		export boolean val(params in_mod) := in_mod.searchgoodssnonly;
	end;
	export searchignoresaddressonly_value := module
		export params := interface
			export boolean SearchIgnoresAddressOnly;
		end;
		export boolean val(params in_mod) := in_mod.SearchIgnoresAddressOnly;
	end;
	export race_value := module
		export params := interface
			export string1 race;
		end;
		export string1 val(params in_mod) := in_mod.race;
	end;
	export gender_value := module
		export params := interface
			export string1 gender;
		end;
		export string1 val(params in_mod) := in_mod.gender;
	end;
	export gdate := module
		export params := interface
			export string8 recordbydate;
		end;
		export string8 val(params in_mod) := in_mod.recordbydate;
	end;
	export use_onlybestdid := module
		export params := interface
			export boolean useonlybestdid;
		end;
		export boolean val(params in_mod) := in_mod.useonlybestdid;
	end;
	export is_profilesearch := module
		export params := interface
			export boolean isprofilesearch;
		end;
		export boolean val(params in_mod) := in_mod.isprofilesearch;
	end;
	export dial_recordmatch_value := module
		export params := interface
			export unsigned dialrecordmatch;
		end;
		export unsigned val(params in_mod) := in_mod.dialrecordmatch;
	end;
	export dial_contactprecision_value := module
		export params := interface
			export unsigned dialcontactprecision;
		end;
		export unsigned val(params in_mod) := in_mod.dialcontactprecision;
	end;
	export dial_bouncedistance_value := module //only in Doxie/rollup_presentation
		export params := interface
			export unsigned dialbouncedistance;
		end;
		export unsigned val(params in_mod) := in_mod.dialbouncedistance;
	end;
	export includezerodids_value := module
		export params := interface
			export boolean includezerodidrefs;
		end;
		export boolean val(params in_mod) := in_mod.includezerodidrefs;
	end;
	export tmsid_value := module
		export params := interface
			export string50 ucc_key;
			export string50 tmsid;
		end;
		export string val(params in_mod) := STD.Str.ToUpperCase( if( in_mod.ucc_key<>'',in_mod.ucc_key,in_mod.tmsid));
	end;
	export rmsid_value := module
		export params := interface
			export string50 event_key;
			export string101 rmsid;
		end;
		export string val(params in_mod) := STD.Str.ToUpperCase( if( in_mod.event_key<>'',in_mod.event_key,in_mod.rmsid));
	end;
	export liencasenumber_value := module
		export params := interface
			export string50 liencasenumber;
		end;
		export string50 val(params in_mod) := STD.Str.ToUpperCase(in_mod.liencasenumber);
	end;
	export irsserialnumber_value := module
		export params := interface
			export string25 irsserialnumber;
		end;
		export string25 val(params in_Mod) := in_mod.irsserialnumber;
	end;
	export casenumber_value := module
		export params := interface
			export string25 casenumber;
		end;
		export string25 val(params in_mod) := in_mod.casenumber;
	end;
	export filingjurisdiction_val := module //TODO: only in prof_LicenseV2_Services/ProfLicSearch; move to "value"
		export params := interface
			export string20 filingjurisdiction;
		end;
		export string20 val(params in_mod) := STD.Str.ToUpperCase(in_mod.filingjurisdiction);
	end;
	export filingdatebegin_value := module
		export params := interface
			export string20 filingdatebegin;
		end;
		export string20 val(params in_mod) := in_mod.filingdatebegin;
	end;
	export filingdateend_value := module
		export params := interface
			export string20 filingdateend;
		end;
		export string20 val(params in_mod) := in_mod.filingdateend;
	end;
	export duns_value := module
		export params := interface
			export string20 dunsnumber;
		end;
		export string20 val(params in_mod) := in_mod.dunsnumber;
	end;
	export statedeathid_value := module
		export params := interface
			export string16 statedeathid;
		end;
		export string16 val(params in_mod) := in_mod.statedeathid;
	end;
	export filingnumber_value := module
		export params := interface
			export string50 filingnumber;
			export string50 orig_filing_num;
		end;
		export string val(params in_mod) := STD.Str.ToUpperCase(if(in_mod.orig_filing_num<>'',in_mod.orig_filing_num,in_mod.filingnumber));
	end;
	export filingjurisdiction_value := module
		export params := interface(filingjurisdiction_val.params)
			export string50 file_state;
		end;
		export string val(params in_mod) := STD.Str.ToUpperCase(if(in_mod.file_state<>'',in_mod.file_state,FilingJurisdiction_val.val(in_mod)));
	end;
	export name_suffix_val := module
		export params := interface
			export string4 NameSuffix;
		end;
		export string4 val(params in_mod) := in_mod.NameSuffix;
	end;
	export addr_value := module
		export params := interface
			export string200 addr;
		end;
		export string200 val(params in_mod) := in_mod.addr;
	end;
	export zip_val := module
		export params := interface(zip_val0.params,PostalCode.params)
			export string5 z5;
		end;
		export string6 val(params in_mod) := 
			STD.Str.ToUpperCase(
				map(
					in_mod.z5 <> '' => in_mod.z5, 
					zip_val0.val(in_mod) <> ''  => zip_val0.val(in_mod),
					PostalCode.val(in_mod)
				)
			);
	end;
	export isAdvanced := module
		export params := interface(rel_fname_val1.params,rel_fname_val2.params,olname1_val.params,prev_State_val1l.params,prev_state_val2l.params,other_city_val.params)
		end;
		export boolean val(params in_mod) := rel_fname_val1.val(in_mod)<>'' OR rel_fname_val2.val(in_mod)<>'' OR olname1_val.val(in_mod)<>'' OR
							prev_state_val1l.val(in_mod)<>'' OR prev_state_val2l.val(in_mod)<>'' OR other_city_val.val(in_mod)<>'';
	end;
	export application_type_val := module
		export params := interface(AutoStandardI.DataPermissionI.params,industry_class_val.params)
			export string32 ApplicationType := Suppress.Constants.ApplicationTypes.DEFAULT;
		end;
			// note that suppression depends not only on input application type,
			// but also on DPM, which may set LE-permissions, and which must have higher priority
		export string32 val(params in_mod) := 
						map (AutoStandardI.DataPermissionI.val(project(in_mod,AutoStandardI.DataPermissionI.params,opt)).use_LE => Suppress.Constants.ApplicationTypes.LE,
								 in_mod.industryclass = 'CNSMR' => Suppress.Constants.ApplicationTypes.Consumer,
								 in_mod.ApplicationType  <> '' => in_mod.ApplicationType,
								 Suppress.Constants.ApplicationTypes.DEFAULT
								);
	end;
	cleanSSN(string ssn) := FUNCTION
		cleaned_ssn:=STD.Str.FilterOut(ssn,'-');
		return MAP(length(trim(cleaned_ssn)) < 9 => cleaned_ssn,
							 cleaned_ssn = '000000000' => '',
							 cleaned_ssn[1..5] = '00000' => cleaned_ssn[6..9],
							 cleaned_ssn[6..9] = '0000' => cleaned_ssn[1..5],
							 cleaned_ssn);
	END;
	export ssn_filtered_value := module //only in Doxie/header_records_byDID
		export params := interface
			export string11 ssn;
		end;
		// need to eliminate leading 5 and trailing 4 zeroes from the input SSN in order for the appropriate 
		// fetching and penalty handling to occur
		// if less than 9 chars, use as-is; if all zero, discard it
		export string val(params in_mod) := cleanSSN(in_mod.ssn);
	end;
	export ssn_value := module
		export params := interface(ssn_filtered_value.params,application_type_val.params)
			export boolean isFCRAval;
		end;
		export string9 val(params in_mod) := FUNCTION
      ssn_filt := ssn_filtered_value.val(in_mod);
			app_type := application_type_val.val (in_mod);
			Suppress.MAC_Suppress_Set(app_type,supp_set);
			supp_key := suppress.Key_New_Suppression() (
				keyed (product in supp_set),
				keyed (linking_type=Suppress.Constants.LinkTypes.SSN),
				keyed (Linking_ID=ssn_filt));

      ssn_cleaned := IF (ssn_filt !='' and count(CHOOSEN(supp_key, 1)) > 0, '', ssn_filt);
      
      RETURN IF (in_mod.isFCRAval, ssn_filt, ssn_cleaned);
    END;   
	end;
	export phone_value := module
		export params := phone_val.params;
		shared string10 phone_nopunct(params in_mod) := STD.Str.Filter(phone_val.val(in_mod),'0123456789');
		// bug 48829 -- need to treat any phone10 that is all zeroes as an invalid phone and discard the input
		shared valid_phone(string ph) := STD.Str.FilterOut(ph, '0') != '';
		export string10 val(params in_mod) := if(valid_phone(phone_nopunct(in_mod)),phone_nopunct(in_mod),'');
	end;
	export dateval := module
		export params := gdate.params;
		export unsigned3 val(params in_mod) := (unsigned3)(gdate.val(in_mod)[1..6]);
	end;
	export ssn_set := module
		export params := ssn_value.params;
		export set of string9 val(params in_mod) := doxie.typossn(ssn_value.val(in_mod));
	end;
	export ssn_mask_value := module
		export params := ssn_mask_val.params;
		export string val(params in_mod) := STD.Str.ToUpperCase(ssn_mask_val.val(in_mod));
	end;
	export dl_mask_value := module
		export params := dl_mask_val.params;
		export boolean val(params in_mod) := dl_mask_val.val(in_mod) = 1;
	end;
	export dob_mask_value := module
		export params := dob_mask_val.params;
		export unsigned1 val(params in_mod) := suppress.date_mask_math.MaskIndicator (dob_mask_val.val(in_mod));
	end;
	export industry_class_value := module
		export params := industry_class_val.params;
		export string val(params in_mod) := STD.Str.ToUpperCase(industry_class_val.val(in_mod));
	end;
	// no longer using doNotFillBlanks for determining no_scrub
	// no_scrub is now equivalent to raw_records 
	export no_scrub := module
		export params := interface(raw_records.params)
		end;
		export boolean val(params in_mod) := raw_records.val(in_mod);
	end;
	export glb_purpose := module
		export params := PermissionI_Tools.params;
		export unsigned1 val(params in_mod) := PermissionI_Tools.val(in_mod).glb.stored_value;
	end;
	export dppa_purpose := module
		export params := PermissionI_Tools.params;
		export unsigned1 val(params in_mod) := PermissionI_Tools.val(in_mod).dppa.stored_value;
	end;
	export glb_ok := module
		export params := interface(PermissionI_Tools.params,glb_purpose.params)
		end;
		export boolean val(params in_mod) := PermissionI_Tools.val(in_mod).glb.ok(glb_purpose.val(in_mod));
	end;
	export dppa_ok := module
		export params := interface(PermissionI_Tools.params,dppa_purpose.params)
		end;
		export boolean val(params in_mod) := PermissionI_Tools.val(in_mod).dppa.ok(dppa_purpose.val(in_mod));
	end;
	export loose_name := module
		export params := interface(nicknames.params,phonetics.params)
		end;
		export boolean val(params in_mod) := nicknames.val(in_mod) or phonetics.val(in_mod);
	end;
	export find_year_low := module
		export params := interface(dob_val.params,agehigh_val.params)
		end;
		export unsigned val(params in_mod) := doxie.DOBTools(dob_val.val(in_mod)).find_year_low(agehigh_val.val(in_mod));   
	end;
	export find_year_high := module
		export params := interface(dob_val.params,agelow_val.params)
		end;
		export unsigned val(params in_mod) := doxie.DOBTools(dob_val.val(in_mod)).find_year_high(agelow_val.val(in_mod));   
	end;
	export find_month := module
		export params := dob_val.params;
		export unsigned val(params in_mod) := doxie.DOBTools(dob_val.val(in_mod)).find_month;   
	end;
	export find_day := module
		export params := dob_val.params;
		export unsigned val(params in_mod) := doxie.DOBTools(dob_val.val(in_mod)).find_day;   
	end;
	export dl_value := module
		export params := interface
			export string50 dl_number;
			export string50 driverslicense;
		end;
		export string val(params in_mod) := STD.Str.ToUpperCase(if(in_mod.dl_number<>'',in_mod.dl_number,in_mod.driverslicense));
	end;
	export vin_value := module
		export params := interface
			export string30 vin;
		end;
		export string val(params in_mod) := STD.Str.ToUpperCase(in_mod.vin);
	end;
	export tag_value := module
		export params := interface
			export string20 tag;
		end;
		export string val(params in_mod) := STD.Str.ToUpperCase(trim(in_mod.tag,left,right));
	end;
	export fname_value := module
		export params := fname_val.params;
		export string val(params in_mod) := trim(STD.Str.ToUpperCase(fname_val.val(in_mod)),left);
	end;
	export CheckNameVariants := module
		export params := interface
			export boolean checkNameVariants;
		end;
		export boolean val(params in_mod) := in_mod.checkNameVariants;
	end;	
	export fname_set_value := module
		export params := interface(fname_value.params,checkNameVariants.params)
			export boolean isFCRAval;
		end;
		export set of string val(params in_mod) := map(fname_value.val(in_mod) = '' => [],
			checkNameVariants.val(in_mod) => ut.NameVariants(fname_value.val(in_mod),10,in_mod.isFCRAval,checkNameVariants.val(in_mod)).fnames,
			[fname_value.val(in_mod)]);
	end;
	export fname3_value := module
		export params := fname3_val.params;
		export string val(params in_mod) := STD.Str.ToUpperCase(fname3_val.val(in_mod));
	end;
	export lname4_value := module
		export params := lname4_val.params;
		export string val(params in_mod) := STD.Str.ToUpperCase(lname4_val.val(in_mod));
	end;
	export rel_fname_value1 := module
		export params := interface(rel_fname_val1.params,rel_fname_val2.params)
		end;
		export string val(params in_mod) := IF(rel_fname_val1.val(in_mod)<>'',STD.Str.ToUpperCase(rel_fname_val1.val(in_mod)),STD.Str.ToUpperCase(rel_fname_val2.val(in_mod)));
	end;
	export rel_fname_value2 := module
		export params := interface(rel_fname_val1.params,rel_fname_val2.params)
		end;
		export string val(params in_mod) := IF(rel_fname_val1.val(in_mod)<>'',STD.Str.ToUpperCase(rel_fname_val2.val(in_mod)),'');
	end;
	export lname_value := module
		export params := lname_val.params;
	  export string val(params in_mod) := trim(STD.Str.ToUpperCase(lname_val.val(in_mod)),left);
	end;

  string26 alphabet := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
	export cleaned_input_lname := module
		export params := lname_value.params;
		export string val(params in_mod) := STD.Str.Filter (lname_value.val(in_mod), alphabet);
	end;
	export lname_set_value := module
		export params := interface(lname_value.params,cleaned_input_lname.params,checkNameVariants.params)
			export boolean isFCRAval;
		end;
		
		export set of string val(params in_mod) :=  map(lname_value.val(in_mod) = '' => [],
			checkNameVariants.val(in_mod) => ut.NameVariants(cleaned_input_lname.val(in_mod),10,in_mod.isFCRAval,checkNameVariants.val(in_mod)).lnames,
			lname_value.val(in_mod) != cleaned_input_lname.val(in_mod) => [lname_value.val(in_mod), cleaned_input_lname.val(in_mod)],
			[lname_value.val(in_mod)]);
	end;
	export lname_set_value_20 := module
		export params := lname_set_value.params;
		export set of string20 val(params in_mod) := set(dataset(lname_set_value.val(in_mod),{string20 lname}),lname);
	end;
	export usePhoneticDistance := module
		export params := interface
			export boolean phoneticdistancematch;
		end;
		export boolean val(params in_mod) := in_mod.phoneticdistancematch;
	end;
	export lnamephoneticset := module  //TODO: define interface explicitly
		export params := interface(lname_value.params,usephoneticdistance.params)
			export unsigned1 distancethreshold;
		end;
		export set of string val(params in_mod) := FUNCTION
      ph_lname := metaphonelib.DMetaPhone1 (lname_value.val(in_mod))[1..6];
      ds_dist := header.key_phonetic_lname (
                   keyed (dph_lname = ph_lname),
                   STD.Str.EditDistance (lname_value.val(in_mod), lname) < in_mod.distancethreshold);
      orig_set := SET (IF(UsePhoneticDistance.val(in_mod), CHOOSEN (ds_dist, 500)), lname);
      RETURN orig_set + [lname_value.val(in_mod)];
    END;
	end;
	export other_lname_value1 := module
		export params := olname1_val.params;
		export string val(params in_mod) := STD.Str.ToUpperCase(olname1_val.val(in_mod));
	end;
	export mname_value := module
		export params := mname_val.params;
		export string val(params in_mod) := trim(STD.Str.ToUpperCase(mname_val.val(in_mod)),left);
	end;
	export lname_trailing_value := module
		export params := interface(lname_value.params,fname_value.params,mname_value.params)
		end;
		export boolean val(params in_mod) := lname_value.val(in_mod) <> '' and fname_value.val(in_mod) = '' and mname_value.val(in_mod) = '';
	end;
	export fname_trailing_value := module
		export params := interface(lname_value.params,fname_value.params,mname_value.params)
		end;
		export boolean val(params in_mod) := lname_value.val(in_mod) <> '' and fname_value.val(in_mod) <> '' and mname_value.val(in_mod) = '';
	end;
	export prev_state_val1 := module
		export params := prev_state_val1l.params;
		export string val(params in_mod) := STD.Str.ToUpperCase(prev_state_val1l.val(in_mod));
	end;
	export prev_state_val2 := module
		export params := prev_state_val2l.params;
		export string val(params in_mod) := STD.Str.ToUpperCase(prev_state_val2l.val(in_mod));
	end;
	export county_value := module
		export params := interface
			export string30 county;
		end;
		export string val(params in_mod) := STD.Str.ToUpperCase(in_mod.county);
	end;
	export other_city_value := module
		export params := other_city_val.params;
		export string val(params in_mod) := STD.Str.ToUpperCase(other_city_val.val(in_mod));
	end;
	export comp_name_value := module
		export params := interface(mx_nameasis_val.params,mx_asisname_val.params,company_name.params)
			export string120 cn;
			export string120 company;
			export string350 corpname;
		end;
		export string val(params in_mod) := STD.Str.ToUpperCase( map(
			mx_nameasis_val.val(in_mod)<>''	=> mx_nameasis_val.val(in_mod),
			mx_asisname_val.val(in_mod)<>''	=> mx_asisname_val.val(in_mod),
			in_mod.cn       <> '' => in_mod.cn,
			in_mod.company  <> '' => in_mod.company,
			in_mod.corpname <> '' => in_mod.corpname,
			company_name.val(in_mod)));
	end;
	export comp_name_indic_value := module
		export params := comp_name_value.params;
		export string val(params in_mod) := if(comp_name_value.val(in_mod) = '','',trim(datalib.companyclean(comp_name_value.val(in_mod))[1..40]));
	end;
	export comp_name_sec_value := module
		export params := comp_name_value.params;
		export string val(params in_mod) := if(comp_name_value.val(in_mod) = '','',trim(datalib.companyclean(comp_name_value.val(in_mod))[41..80]));
	end;
	export date_first_seen_value := module
		export params := interface
			export unsigned datefirstseen;
		end;
		export unsigned val(params in_mod) := ut.IntDate_To_YYYYMM(in_mod.datefirstseen,false);
	end;
	export date_last_seen_value := module
		export params := interface
			export unsigned datelastseen;
		end;
		export unsigned val(params in_mod) := ut.IntDate_To_YYYYMM(in_mod.datelastseen,false);
	end;
	export allow_date_seen_value := module
		export params := interface
			export boolean allowdateseen;
		end;
		export boolean val(params in_mod) := in_mod.allowdateseen;
	end;
	export lname_wild := module
		export params := lname_value.params;
		export boolean val(params in_mod) := STD.Str.Find(lname_value.val(in_mod), '*', 1) <> 0 or 
              STD.Str.Find(lname_value.val(in_mod), '?', 1) <> 0;
	end;
	export lname_wild_val := module
		export params := lname_value.params;
		export string30 val(params in_mod) := lname_value.val(in_mod);
	end;
	export fname_wild := module
		export params := fname_value.params;
		export boolean val(params in_mod) := STD.Str.Find(fname_value.val(in_mod), '*', 1) <> 0 or 
              STD.Str.Find(fname_value.val(in_mod), '?', 1) <> 0;
	end;
	export fname_wild_val := module
		export params := fname_value.params;
		export string30 val(params in_mod) := fname_value.val(in_mod);
	end;
	export addr_wild := module
		export params := addr_value.params;
		export boolean val(params in_mod) :=
			STD.Str.Find(addr_value.val(in_mod), '*', 1) <> 0 and 
			STD.Str.Find(addr_value.val(in_mod), '*', 1) < STD.Str.Find(addr_value.val(in_mod), ' ', 1) or 
			STD.Str.Find(addr_value.val(in_mod), '?', 1) <> 0 and 
			STD.Str.Find(addr_value.val(in_mod), '?', 1) < STD.Str.Find(addr_value.val(in_mod), ' ', 1);
	end;
	shared addr_comma := module
		export params := addr_value.params;
		export boolean val(params in_mod) :=
			STD.Str.Find(addr_value.val(in_mod), ',', 1) <> 0 AND 
			STD.Str.Find(addr_value.val(in_mod), ',', 1) < STD.Str.Find(addr_value.val(in_mod), ' ', 1);
	end;
	shared addr_colon := module
		export params := addr_value.params;
		export boolean val(params in_mod) :=
			STD.Str.Find(addr_value.val(in_mod), ':', 1) <> 0 AND 
			STD.Str.Find(addr_value.val(in_mod), ':', 1) < STD.Str.Find(addr_value.val(in_mod), ' ', 1);
	end;
	export addr_range := module
		export params := interface(addr_comma.params,addr_colon.params)
		end;
		export boolean val(params in_mod) := addr_comma.val(in_mod) or addr_colon.val(in_mod);
	end;
	export addr_loose := module
		export params := interface(addr_wild.params,addr_range.params)
		end;
		export boolean val(params in_mod) := addr_wild.val(in_mod) or addr_range.val(in_mod);
	end;
	export prange_wild_value := module
		export params := interface(addr_wild.params,addr_value.params)
		end;
		export string val(params in_mod) := if(addr_wild.val(in_mod),addr_value.val(in_mod)[1..STD.Str.Find(addr_value.val(in_mod), ' ', 1)-1],'');
	end;
	export prange_beg_value := module
		export params := interface(addr_range.params,addr_comma.params,addr_value.params)
		end;
		export unsigned val(params in_mod) := (unsigned)if(addr_range.val(in_mod),addr_value.val(in_mod)[1..
			if(addr_comma.val(in_mod),STD.Str.Find(addr_value.val(in_mod),',',1)-1,
				STD.Str.Find(addr_value.val(in_mod), ':', 1)-1)],
			'');
	end;
	export prange_end_value := module
		export params := interface(addr_range.params,addr_comma.params,addr_value.params)
		end;
		export unsigned val(params in_mod) := (unsigned)IF(addr_range.val(in_mod), addr_value.val(in_mod)[
			IF(addr_comma.val(in_mod),STD.Str.Find(addr_value.val(in_mod), ',', 1)+1,
				STD.Str.Find(addr_value.val(in_mod), ':', 1)+1)..
			STD.Str.Find(addr_value.val(in_mod), ' ', 1)-1], '');
	end;
	
	// added prange_end_value to addr_line_first when
	// addr_range exists so that Addr line can be cleaned appropriately
	export addr_line_first := module
		export params := interface(addr_range.params,addr_value.params)
		end;
		export string val(params in_mod) := IF (addr_range.val(in_mod), 
		if(addr_comma.val(in_mod),
		addr_value.val(in_mod)[STD.Str.Find(addr_value.val(in_mod), ',', 1)..]
		,addr_value.val(in_mod)[STD.Str.Find(addr_value.val(in_mod), ':', 1)..])
		, addr_value.val(in_mod));
	end;	
	export addr_origin_country := module
		export params := interface
			export unsigned1 addr_origin_country := 0;
		end;
		export unsigned1 val(params in_mod) := in_mod.addr_origin_country;
	end;
	export addr_line_second := module
		export params := interface(city_val.params,state_val.params,zip_val.params,statecityzip_val.params,addr_origin_country.params)
		end;
		shared string fake_city(params in_mod) := MAP (addr_origin_country.val(in_mod) = address.Components.Country.CA => 'Nocityname BC','Nocityname NY');		
		export string val(params in_mod) := 
			IF (
				(city_val.val(in_mod) <> '' AND state_val.val(in_mod)<>'') OR zip_val.val(in_mod) <> '',
				TRIM(city_val.val(in_mod)) + ' ' + TRIM(state_val.val(in_mod)) + ' ' + TRIM(zip_val.val(in_mod)),
				if(
					StateCityZip_val.val(in_mod) <> '', 
					StateCityZip_val.val(in_mod), 
					fake_city(in_mod)
				)
			);
	end;
	export clean_address := module
		export params := interface(addr_value.params,city_val.params,statecityzip_val.params,addr_line_first.params,addr_line_second.params)
			export boolean useGlobalScope := true;
		end;
		shared allowclean(params in_mod) := addr_value.val(in_mod) <> '' OR city_val.val(in_mod) <> '' OR StateCityZip_val.val(in_mod) <> '';
		shared addr1(params in_mod) := if(allowclean(in_mod), addr_line_first.val(in_mod), '');
		shared addr2(params in_mod) := if(allowclean(in_mod), addr_line_second.val(in_mod), '');
		shared ca(params in_mod) := address.GetCleanAddress(addr1(in_mod), addr2(in_mod), addr_origin_country.val(in_mod), useGlobal := in_mod.useGlobalScope);
		export val(params in_mod) := ca(in_mod).str_addr;
		export val_mod(params in_mod) := ca(in_mod).results;
										 
	end;
	shared isValidCityStateClean := module
		export params := interface(city_val.params,state_val.params,statecityzip_val.params)
		end;
		export boolean val(params in_mod) := (city_val.val(in_mod) <> '' and state_val.val(in_mod) <> '') or statecityzip_val.val(in_mod) <> '';
	end;
	export state_value := module
		export params := interface(city_val.params,state_val.params,zip_val.params,isvalidcitystateclean.params,clean_address.params)
			export string2 st;
			export string2 st_orig;
		end;
		shared isCanadian(params in_mod) := addr_origin_country.val(in_mod) = address.Components.Country.CA;//ziplib.ZipToState2 does not work for canada, so i have to divert to the clean address
		export string val(params in_mod) := STD.Str.ToUpperCase(map(
			city_val.val(in_mod)='' and state_val.val(in_mod)='' and in_mod.st='' and zip_val.val(in_mod)<>'' and not isCanadian(in_mod) 
																														=> ziplib.ZipToState2(zip_val.val(in_mod)),
			in_mod.st<>''												  		=> in_mod.st, 
			in_mod.st_orig <> ''                  		=> in_mod.st_orig,
			state_val.val(in_mod)<>''												  		=> state_val.val(in_mod),
			isValidCityStateClean.val(in_mod)											=> clean_address.val_mod(in_mod).state,
			zip_val.val(in_mod) <> '' and not isCanadian(in_mod) 	=> ziplib.ZipToState2(zip_val.val(in_mod)),
			''));
	end;
	export input_city_value := module //TODO: in Canadian phones and penalty lib only
		export params := city_val.params;
		export string val(params in_mod) := STD.Str.ToUpperCase(city_val.val(in_mod));
	end;
	export city_value := module
		export params := interface(input_city_value.params,isValidcityStateClean.params,clean_address.params)
		end;
		export string val(params in_mod) := if(isValidCityStateClean.val(in_mod), clean_address.val_mod(in_mod).v_city, input_city_value.val(in_mod));
	end;
	export city_zip_value := module
		export params := interface(state_value.params,city_value.params)
		end;
		export string5 val(params in_mod) := ziplib.CityToZip5(state_value.val(in_mod), city_value.val(in_mod));
	end;	
	export city_zip_set_value := module
		export params := interface(state_value.params,city_value.params)
		end;
		export set of integer4 val(params in_mod) := if(state_value.val(in_mod) <> '' and city_value.val(in_mod) <> '', ut.ZipsWithinCity(state_value.val(in_mod), city_value.val(in_mod)),[]);
	end;
	export city_zip_value_ds := module
		export params := interface(city_zip_set_value.params)
		end;
		export dataset({string5 zip}) val(params in_mod) := project(dataset(city_zip_set_value.val(in_mod),{unsigned3 zip}),transform({string5 zip},self.zip := intformat( left.zip,5,1)));
	end;
	export zip_value_cleaned := module
		export params := interface(zip_val.params,addr_value.params,city_value.params,state_value.params,clean_address.params)
		end;
		export string val(params in_mod) := if(
			addr_value.val(in_mod) <> '' and city_value.val(in_mod) <> '' and state_value.val(in_mod) <> '',
			clean_address.val_mod(in_mod).zip,
			zip_val.val(in_mod));
	end;
	export err_stat := module
		export params := interface(clean_address.params)
		end;
		export string val(params in_mod) := clean_address.val_mod(in_mod).error_msg;
	end;
	export do_primname_word_match := module
		export params := err_stat.params;
		export boolean val(params in_mod) := err_stat.val(in_mod)[1..4] IN AutoStandardI.Constants.suffix_error_set;
	end;
	export addr_error_value := module
		export params := err_stat.params;
		export boolean val(params in_mod) := err_stat.val(in_mod)[1..2]='E3' OR err_stat.val(in_mod)[1..4] IN ['E500','E502'];
	end;
	export any_addr_error_value := module
		export params := err_stat.params;
		export boolean val(params in_mod) := err_stat.val(in_mod)[1]='E';
	end;	
	export zip_value := module
		export params := interface(city_zip_value.params,city_value.params,state_value.params,zip_val.params,county_value.params,zipradius_value.params,clean_address.params,any_addr_error_value.params)
		end;
		export set of integer4 val(params in_mod) := ut.fn_GetZipSet(city_value.val(in_mod),state_value.val(in_mod),zip_val.val(in_mod),county_value.val(in_mod),city_zip_value.val(in_mod),zipradius_value.val(in_mod),clean_address.val_mod(in_mod).zip, any_addr_error_value.val(in_mod));
	end;
	export can_poscode_value := module
		export params := zip_value_cleaned.params;
		export string6 val(params in_mod) := STD.Str.ToUpperCase(if(zip_value_cleaned.val(in_mod)<>'',zip_value_cleaned.val(in_mod),zip_val.val(in_mod)));
	end;
	export zip_value_ds := module
		export params := zip_value.params;
		export dataset({string5 zip}) val(params in_mod) := project(dataset(zip_value.val(in_mod),{unsigned3 zip}),transform({string5 zip},self.zip := intformat( left.zip,5,1)));
	end;
	export city_codes_set := module
		export params := interface(city_value.params,zip_val.params)
		end;
		export set of unsigned val(params in_mod) := if(city_value.val(in_mod)<>'',doxie.Make_CityCodes(city_value.val(in_mod)).rox,[])  
		                                            + ut.ZipToCities(zip_val.val(in_mod)).set_codes; 
	end;
	shared skipTheCleanAddr := module
		export params := interface
			export boolean isPRP;
			export string200 addr;
		end;
		export boolean val(params in_mod) := in_mod.isPRP and 
                                         // input address line-1 is one word
                                         (length(trim(in_mod.addr, all)) = length(trim(in_mod.addr, left, right)));
	end;
	export predir_value := module
		export params := interface(clean_address.params)
			export string2 predir;
		end;
		export string val(params in_mod) := if(in_mod.predir <> '',
																					 STD.Str.ToUpperCase(in_mod.predir),
																					 clean_address.val_mod(in_mod).predir);
	end;
	shared prange_temp := module
		export params := interface(clean_address.params)
		end;
		export string val(params in_mod) := trim(clean_address.val_mod(in_mod).prim_range);
	end;
	export prange_value := module
		export params := interface(addr_wild.params,prange_temp.params,prange_wild_value.params,addr_range.params,prange_beg_value.params,skipTheCleanAddr.params)
			export string10 prim_range;
			export string10 primrange;
		end;
		export string val(params in_mod) := MAP(in_mod.prim_range <> '' => in_mod.prim_range,
				in_mod.primrange <> '' => in_mod.primrange,
				skipTheCleanAddr.val(in_mod) => (STRING10) in_mod.addr,
				addr_wild.val(in_mod) => if(prange_temp.val(in_mod)='','',(STRING10)prange_wild_value.val(in_mod)),
				addr_range.val(in_mod) => (STRING10)prange_beg_value.val(in_mod), prange_temp.val(in_mod));
	end;
	export pname_val := module
		export params := interface(clean_address.params,skipTheCleanAddr.params)
		end;
		export string val(params in_mod) := if(skipTheCleanAddr.val(in_mod),'',clean_address.val_mod(in_mod).prim_name);
	end;
	export pname_wild := module
		export params := interface(pname_val.params)
		end;
		export boolean val(params in_mod) := STD.Str.Find(pname_val.val(in_mod), '*', 1) <> 0 or
              STD.Str.Find(pname_val.val(in_mod), '?', 1) <> 0;
	end;
	export pname_wild_val := module
		export params := interface(pname_val.params)
		end;
		export string val(params in_mod) := doxie.StripWildOrdinal(pname_val.val(in_mod));
	end;
	export is_inv_wildcard := module //derived; TODO: hide, probably isn't used.
		export params := interface(lname_value.params,fname_value.params,pname_val.params)
		end;
		export boolean val(params in_mod) := (STD.Str.Find(lname_value.val(in_mod), '*', 1) in [1,2,3]) or 
                           (STD.Str.Find(lname_value.val(in_mod), '?', 1) in [1,2,3]) or   
		                 (STD.Str.Find(fname_value.val(in_mod), '*', 1) in [1,2,3]) or 
                           (STD.Str.Find(fname_value.val(in_mod), '?', 1) in [1,2,3]) or   
					  (STD.Str.Find(pname_val.val(in_mod), '*', 1) in [1,2,3]) or    
					  (STD.Str.Find(pname_val.val(in_mod), '?', 1) in [1,2,3]);
	end;
	export is_wildcard_search := module
		export params := interface(lname_wild.params,fname_wild.params,addr_wild.params,pname_wild.params)
		end;
		export boolean val(params in_mod) := lname_wild.val(in_mod) or fname_wild.val(in_mod) or addr_wild.val(in_mod) or pname_wild.val(in_mod);
	end;
	export pname_value := module
		export params := interface(pname_val.params)
			export string50 street_name;
			export string28 prim_name;
			export string30 primname;
		end;
		export string val(params in_mod) := doxie.StripOrdinal( map(
			in_mod.prim_name <>''	=> STD.Str.ToUpperCase(in_mod.prim_name),
			in_mod.primname <>'' => STD.Str.ToUpperCase(in_mod.primname),
			in_mod.street_name<>''	=> STD.Str.ToUpperCase(in_mod.street_name),
			pname_val.val(in_mod)));
	end;
	export fein_val := module
		export params := interface
			export string11 fein;
		end;
		export string11 val(params in_mod) := in_mod.fein;
	end;
	export fein_value := module
		export params := fein_val.params;
		export unsigned4 val(params in_mod) := (unsigned4)(STD.Str.Filterout(fein_val.val(in_mod),'-'));
	end;
	export lookup_val := module //Only in properties: LN_PropertyV2_Services.input
		export params := interface(comp_name_value.params,pname_value.params,state_value.params,city_value.params,zip_value.params,exclude_lessors.params,fein_value.params)
			export string10 lookuptype;
			export boolean moxievehicles;
			export boolean simplifiedcontactreturn;
		end;
		export string10 val(params in_mod) := map(in_mod.simplifiedcontactreturn and (comp_name_value.val(in_mod)<>'' or fein_value.val(in_mod)<>0) => corp2_services.lookup_bit.Corp,
													in_mod.simplifiedcontactreturn  and pname_value.val(in_mod)<>'' and state_value.val(in_mod)<>'' and
													not (city_value.val(in_mod)='' AND zip_value.val(in_mod)=[])=> corp2_services.lookup_bit.Accurint,
													in_mod.simplifiedcontactreturn =>  corp2_services.lookup_bit.Not_Ra,
													Exclude_Lessors.val(in_mod) => Vehiclev2_services.Lookup_bit.no_lessors,
													in_mod.moxievehicles => Vehiclev2_services.Lookup_bit.no_minors,
												  in_mod.lookuptype);
	end;
	export lookup_value := module
		export params := interface(party_type.params,lookup_val.params)
		end;
		export unsigned4 val(params in_mod) := doxie.lookup_bit(STD.Str.ToUpperCase( if(party_type.val(in_mod)<>'', 'PARTY_'+party_type.val(in_mod), lookup_val.val(in_mod))));
	end;
	export lookup_value2 := module
		export params := interface(lname_value.params,fname_value.params)
			export boolean setrepaddr;
			export unsigned1 setrepaddrbit;
		end;
		export unsigned4 val(params in_mod) := if(lname_value.val(in_mod)='' and length(trim(fname_value.val(in_mod))) < 2 and in_mod.setrepaddr,in_mod.setrepaddrbit,doxie.lookup_bit(''));
	end;
	export addr_suffix_value := module
		export params := interface(clean_address.params)
			export string4 suffix;
		end;
		export string val(params in_mod) := if(in_mod.suffix <> '',
																				STD.Str.ToUpperCase(in_mod.suffix),
																				clean_address.val_mod(in_mod).suffix);
	end;
	export postdir_value := module
		export params := interface(clean_address.params)
			export string2 postdir;
		end;
		export string val(params in_mod) := if(in_mod.postdir <> '',
																					 STD.Str.ToUpperCase(in_mod.postdir),
																					 clean_address.val_mod(in_mod).postdir);
	end;
	export sec_range_value := module
		export params := interface(clean_address.params)
			export string8 sec_range;
			export string10 secrange;
		end;
		export string val(params in_mod) := map(
			in_mod.sec_range <> '' => in_mod.sec_range,
			in_mod.secrange  <> '' => in_mod.secrange,
			clean_address.val_mod(in_mod).sec_range);
	end;
	export location_value := module
		export params := interface(clean_address.params)
			export real latitude;
			export real longitude;
		end;
		export val(params in_mod) := module
			shared addr				:= clean_address.val_mod(in_mod);
			shared hasLLInput	:= (in_mod.latitude<>0.0) or (in_mod.longitude<>0.0);
			export real			latitude	:= if(hasLLInput, in_mod.latitude,	(real)addr.latitude);
			export real			longitude	:= if(hasLLInput, in_mod.longitude,	(real)addr.longitude);
			export string1	geo_match	:= if(hasLLInput, '',								addr.geo_match);
		end;
	end;
  // Note: business_header_ss: Fn_MakeCNameWordsMetaphone().inrec == {layout_MakeCNameWords + string6 zip}
	shared cnvf_forwords := module
		export params := interface(comp_name_value.params,state_value.params)
		end;
		export val(params in_mod) := FUNCTION 
      ds_cnames :=  IF (comp_name_value.val(in_mod) <> '',
                        DATASET ([transform (business_header_ss.layout_MakeCNameWords,
                                             self.company_name := comp_name_value.val(in_mod),
                                             self.state := state_value.val(in_mod),
                                             self := [])]));
      RETURN ds_cnames;
    end;
	end;
	export company_name_val_filt := module
		export params := cnvf_forwords.params;
		export string120 val(params in_mod) := business_header_ss.Fn_MakeCNameWords(cnvf_forwords.val(in_mod))(length(trim(word)) > 1, seq = 1)[1].word;
	end;
	export company_name_val_filt2 := module
		export params := interface(comp_name_value.params,company_name_val_filt.params)
		end;
		export string120 val(params in_mod) := business_header_ss.Fn_SubstituteForAndString(comp_name_value.val(in_mod),company_name_val_filt.val(in_mod));
	end;
	export reduced_data_value := module
		export params := interface
			export boolean reduceddata;
		end;
		export boolean val(params in_mod) := in_mod.reduceddata;
	end;
	export company_name_val := module
		export params := company_name.params;
		export string120 val(params in_mod) := company_name.val(in_mod);
	end;
	export bdid_val := module
		export params := interface
			export string bdid;
		end;
		export string val(params in_mod) := in_mod.bdid;
	end;	
	export exact_only := module //TODO: only in Business_Header.BH_SearchService
		export params := interface(StrictMatch_value.params)
			export boolean exactonly;
		end;
		export boolean val(params in_mod) := StrictMatch_value.val(in_mod) OR	in_mod.exactonly;
	end;
	shared mile_radius := module
		export params := interface(StrictMatch_value.params)
			export unsigned2 mileradius;
			export unsigned2 zipradius;
		end;
		export unsigned2 val(params in_mod) := 
			map(
				StrictMatch_value.val(in_mod) => 0,
				in_mod.mileradius != 0 => in_mod.mileradius,
				in_mod.zipradius);
	end;
	export use_Levels_val := module
		export params := interface
			export boolean useLevels;
		end;
		export boolean val(params in_mod) := in_mod.useLevels;
	end;
	export multiBDID := module
		export params := bdid_val.params;
		export boolean val(params in_mod) := bdid_val.val(in_mod)[1] = '{';
	end;
	export use_Supergroup := module
		export params := interface(multiBDID.params)
			export boolean useSupergroup;
		end;
		export boolean val(params in_mod) := (not multiBDID.val(in_mod)) and in_mod.useSupergroup;
	end;
	export use_supergrouppropertyaddress_val := module
		export params := interface(use_supergroup.params)
			export boolean usesupergrouppropertyaddress;
		end;
		export boolean val(params in_mod) := use_supergroup.val(in_mod) and in_mod.usesupergrouppropertyaddress;
	end;
	export bdid_value := module
		export params := bdid_val.params;
		export unsigned6 val(params in_mod) := (unsigned6)bdid_val.val(in_mod);
	end;
	export ultid_value := module
		export params := interface;
			export unsigned6 ultid;
		end;
		export unsigned6 val(params in_mod) := in_mod.ultid;
	end;
	export orgid_value := module
		export params := interface;
			export unsigned6 orgid;
		end;
		export unsigned6 val(params in_mod) := in_mod.orgid;
	end;
	export seleid_value := module
		export params := interface;
			export unsigned6 seleid;
		end;
		export unsigned6 val(params in_mod) := in_mod.seleid;
	end;
	export proxid_value := module
		export params := interface;
			export unsigned6 proxid;
		end;
		export unsigned6 val(params in_mod) := in_mod.proxid;
	end;
	export powid_value := module
		export params := interface;
			export unsigned6 powid;
		end;
		export unsigned6 val(params in_mod) := in_mod.powid;
	end;
	export empid_value := module
		export params := interface;
			export unsigned6 empid;
		end;
		export unsigned6 val(params in_mod) := in_mod.empid;
	end;
	export dotid_value := module
		export params := interface
			export unsigned6 dotid;
		end;
		export unsigned6 val(params in_mod) := in_mod.dotid;
	end;
	export company_name_value := module
		export params := comp_name_value.params;
		export string120 val(params in_mod) := comp_name_value.val(in_mod);
	end;
	export enforce_limits := module //TODO: Business_Header.doxie_MAC_Field_Declare, move to mac_select?
		export params := interface
			export boolean disregardlimits;
		end;
		export boolean val(params in_mod) := not in_mod.disregardlimits;
	end;
	export max_ceiling := module //TODO: Business_Header.doxie_MAC_Field_Declare, move to mac_select?
		export params := enforce_limits.params;
		export unsigned val(params in_mod) := if(enforce_limits.val(in_mod),200,100000);
	end;
	export supergroup_ds := module
		export params := interface(bdid_value.params,use_levels_val.params)
		end;
		export val(params in_mod) := business_header.getSupergroup(bdid_value.val(in_mod),use_levels_val.val(in_mod));
	end;
	export isPeopleWise := module
		export params := interface
			export boolean isPeopleWise := false;
		end;
		export boolean val(params in_mod) := in_mod.isPeoplewise;
	end;

	export bdid_dataset := module
		export params := interface(multiBDID.params,use_Supergroup.params,use_Levels_val.params,bdid_value.params,isPeopleWise.params)
			export string bdl;
		end;

    EXPORT DATASET ({unsigned6 bdid}) val(params in_mod) := FUNCTION
      bdl_value := (unsigned6)in_mod.bdl;
      pattern bdidlistval := pattern('[0-9]*');
      pattern bdidpatt := ('{' or ',') bdidlistval before (',' or '}');

      _bdid := bdid_val.val(in_mod); // a string

      temp_bdl := LIMIT (Business_Header.Key_BDL2_BDID (KEYED (bdid = bdl_value)), 1, SKIP);
      tempbdids := MAP (
                        bdl_value != 0  => JOIN (temp_bdl, Business_Header.Key_BDL2_BDL,
                                                 KEYED (left.bdl = right.bdl),
                                                 TRANSFORM ({unsigned6 bdid}, self.bdid := right.bdid),
                                                 //there're a few BDLs with more than 10K matches
                                                 LIMIT (10000)), 
                        multiBDID.val(in_mod)      => PROJECT (PARSE (DATASET([{_bdid}],{string bdidlist}),
                                                                      bdidlist, bdidpatt, {unsigned6 bdid := (unsigned6)matchtext(bdidlistval)},scan),
                                                              {unsigned6 bdid}),
                        use_Supergroup.val(in_mod) => PROJECT (business_header.getSupergroup ((unsigned6)_bdid,use_Levels_val.val(in_mod)),{unsigned6 bdid}),
                        // default
                        DATASET([(unsigned6)_bdid],{unsigned6 bdid}));
      // interface doesn't have application type (as it should), try to "fake' it:
      _app := IF (in_mod.isPeoplewise, Suppress.Constants.ApplicationTypes.PeopleWise, '');
      suppress.MAC_suppress (tempbdids, bdid_res, _app, 'BDID', bdid);
      RETURN bdid_res;
    END;
  end;

	export mile_radius_value := module
		export params := interface(mile_radius.params,zip_val.params,state_value.params,city_value.params)
		end;
		export unsigned2 val(params in_mod) := map(
			zip_val.val(in_mod) = '' and (state_value.val(in_mod) = '' OR city_value.val(in_mod) = '')=> 0,
		  mile_radius.val(in_mod) < 50 => mile_radius.val(in_mod), 
			50);
	end;
  
	export bh_zip_value := module
		export params := interface(zip_value_cleaned.params,mile_radius_value.params,state_value.params,city_value.params,city_zip_value.params)
		end;
		export set of integer4 val(params in_mod) := 
			if(zip_value_cleaned.val(in_mod) <> '' and mile_radius_value.val(in_mod) = 0, [(integer)zip_value_cleaned.val(in_mod)],
				 if(zip_value_cleaned.val(in_mod) <> '', ziplib.ZipsWithinRadius(zip_value_cleaned.val(in_mod), mile_radius_value.val(in_mod)), 
						if(state_value.val(in_mod) <> '' AND city_value.val(in_mod) <> '',
							 if(mile_radius_value.val(in_mod) > 0, ziplib.ZipsWithinRadius(city_zip_value.val(in_mod), mile_radius_value.val(in_mod)),
									ut.ZipsWithinCity(state_value.val(in_mod),city_value.val(in_mod))),
							 [0])));
	end;
	export ds_zip0 := module
		export params := bh_zip_value.params;
		export dataset({integer4 zip}) val(params in_mod) := dataset(bh_zip_value.val(in_mod),{integer4 zip});
	end;
	export ds_zip := module
		export params := ds_zip0.params;
		export dataset({integer4 zip}) val(params in_mod) := if(exists(ds_zip0.val(in_mod)),ds_zip0.val(in_mod),dataset([{0}],{integer4 zip}));
	end;
	export is_compsearch := module
		export params := interface(company_name_value.params,phone_value.params,fein_value.params)
		end;
		export boolean val(params in_mod) := company_name_value.val(in_mod) <> '' or phone_value.val(in_mod) <> '' or fein_value.val(in_mod) > 0;
	end;
	export is_contsearch := module
		export params := lname_value.params;
		export boolean val(params in_mod) := lname_value.val(in_mod) <> '';
	end;
	export is_compaddrsearch := module
		export params := interface(pname_value.params,zip_val.params,city_value.params,state_value.params)
		end;
		export boolean val(params in_mod) := pname_value.val(in_mod) <> '' and (zip_val.val(in_mod) <> '' or (city_value.val(in_mod) <> '' and state_value.val(in_mod) <> ''));
	end;
	export keep_old_ssns_val := module
		export params := interface
			export boolean UsingKeepSSNs;
			export boolean KeepOldSsns;
		end;
		export boolean val(params in_mod) := ~in_mod.UsingKeepSSNs or in_mod.KeepOldSsns;
	end;
	export precs := module
		export params := interface(company_name_value.params,prange_value.params,predir_value.params,pname_value.params,addr_suffix_value.params,postdir_value.params,sec_range_value.params,city_value.params,state_value.params,ds_zip.params,phone_value.params,fein_val.params,ssn_value.params)
		end;
		export dataset(business_header_ss.Layout_BDID_InBatch) val(params in_mod) := project(ds_zip.val(in_mod),transform(
			business_header_ss.Layout_BDID_InBatch,
				SELF.seq := 0;
				SELF.company_name := company_name_value.val(in_mod);
				SELF.prim_range := prange_value.val(in_mod);
				SELF.predir := predir_value.val(in_mod);
				SELF.prim_name := pname_value.val(in_mod);
				SELF.addr_suffix := addr_suffix_value.val(in_mod);
				SELF.postdir := postdir_value.val(in_mod);
				SELF.sec_range := sec_range_value.val(in_mod);
				SELF.p_city_name := city_value.val(in_mod);
				SELF.st := state_value.val(in_mod);
				SELF.z5 := (qstring5)left.zip;
				SELF.phone10 := phone_value.val(in_mod);
				SELF.fein := fein_val.val(in_mod);
				SELF.ssn := ssn_value.val(in_mod)));
	end;

	// QUESTIONABLE
	export isCRS := module
		export params := interface
			export boolean isCRS;
		end;
		export boolean val(params in_mod) := in_mod.isCRS;
	end;
	export allow_wildcard_Val := module //TODO: check if needed in AutoHeaderI.LIBIN
		export params := interface
			export boolean allowwildcard;
		end;
		export boolean val(params in_mod) := in_mod.allowwildcard;
	end;
 	shared cnvf_forwords_new := module //TODO: fold
 		export params := interface(comp_name_value.params,state_value.params)
 		end;
 		export val(params in_mod) := IF (comp_name_value.val(in_mod) <> '',
                                     DATASET ([TRANSFORM(Business_Header_SS.Fn_MakeCNameWordsMetaphone().inrec,
                                                         self.company_name := comp_name_value.val(in_mod),
                                                         self.state := state_value.val(in_mod),
                                                         self := [])]));
 	end;
 	export cnvf_words_new := module
 		export params := cnvf_forwords_new.params;
 		export val(params in_mod) := Business_Header_SS.Fn_MakeCNameWordsMetaphone().records(cnvf_forwords_new.val(in_mod))(length(trim(word)) > 1);
 	end;
	export company_name_metaphone := module
		export params := cnvf_words_new.params;
		export string120 val(params in_mod) := cnvf_words_new.val(in_mod)(seq = 1)[1].metaphone;
	end;
	export ssnfallback_value := module
		export params := interface
			export boolean UseSSNFallback;
		end;
		export boolean val(params in_mod) := in_mod.UseSSNFallBack;
	end;
	export SearchAroundAddress_value := module
		export params := interface(zipradius_value.params)
			export boolean SearchAroundAddress;
		end;
		export boolean val(params in_mod) := in_mod.SearchAroundAddress and zipradius_value.val(in_mod) > 0;
	end;	

	// get prim range interval based on neighbors records;
	export prim_range_set_value := module
		export params := interface(zip_value_ds.params, city_zip_value_ds.params, pname_value.params, prange_beg_value.params, prange_end_value.params)
			export boolean isFCRAval;
		end;
		shared set of string5 city_zip_set(params in_mod) := set(dedup(zip_value_ds.val(in_mod)+city_zip_value_ds.val(in_mod), zip, all),zip);

		shared neighbors_range(params in_mod) := 
			limit(limit(
				project(doxie.key_nbr_headers(keyed((exists(zip_value_ds.val(in_mod)) or exists(city_zip_value_ds.val(in_mod))) 
																				and zip IN city_zip_set(in_mod)), 
																			keyed(pname_value.val(in_mod) <> '' and prim_name[1..length(pname_value.val(in_mod))] = pname_value.val(in_mod)), 
																			((prange_beg_value.val(in_mod) <> 0 or prange_end_value.val(in_mod) <> 0) and (integer)prim_range >= prange_beg_value.val(in_mod) and (integer)prim_range <= prange_end_value.val(in_mod))),
								{doxie.key_nbr_headers.prim_range}),
			ut.limits.FETCH_KEYED, skip, keyed),ut.limits.FETCH_UNKEYED, skip);
		// NB: neighbors' index cannot be used on FCRA side, so address range search is effectivly disabled on FCRA side.
		export set of string10 val(params in_mod) := 
			if (in_mod.isFCRAval,
					[],
					set(dedup(sort(neighbors_range (in_mod), prim_range),prim_range),prim_range));
	end;
	export allow_uber_keys_value := module //only: DriversV2_Services
		export params := interface
			export boolean AllowUberKeys;
		end;
		export boolean val(params in_mod) := in_mod.AllowUberKeys;
	end;
	export SIC_value := module //only: in business header
		export params := interface
			export string SIC; //needs to be string because 1 to 4 digits can be input
		end;
		export string val(params in_mod) := in_mod.SIC;
	end;
	export demo_customer_name_value := module 
		export params := interface
			export string20 DemoCustomerName;
		end;
		export string20 val(params in_mod) :=  STD.Str.ToUpperCase(in_mod.DemoCustomerName);
	end;
end;
