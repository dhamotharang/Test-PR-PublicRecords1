IMPORT AutoStandardI, address, doxie, ut, header, suppress, lib_stringlib, AutoheaderV2, lib_metaphone, lib_ziplib, _Validate;

isFCRAval := false;
todays_date := (unsigned8)Stringlib.getDateYYYYMMDD();

// discard all zero zips
hasAlpha(string6 s) := stringlib.StringFilterOut(s, '0123456789') <> ''; //iow, looks canadian 
string45 blanks45 := '';
string73 forceAsLname (string120 fullname) := blanks45 + (string20) fullname;

EXPORT translate := MODULE

  // at the moment this is called outside a library, in pre-processing input parameters
  export string9 GetCleanedSSN (string11 ssn_long_value, string32 app_type, boolean IsFCRA = false) := function
		cleaned_ssn := stringlib.StringFilterOut (ssn_long_value,'-');
		ssn_filtered_value := MAP (length(trim(cleaned_ssn)) < 9 => cleaned_ssn,
							 cleaned_ssn = '000000000' => '',
							 cleaned_ssn[1..5] = '00000' => cleaned_ssn[6..9],
							 cleaned_ssn[6..9] = '0000' => cleaned_ssn[1..5],
							 cleaned_ssn);

		// note: app-type must be already pre-processed by a caller
		Suppress.MAC_Suppress_Set (app_type, supp_set);

		supp_key := suppress.Key_New_Suppression() (
			keyed (product in supp_set),
			keyed (linking_type=Suppress.Constants.LinkTypes.SSN),
			keyed (Linking_ID=ssn_filtered_value));

		ssn_value_reg := IF (ssn_filtered_value != '' and count(CHOOSEN(supp_key, 1)) > 0, '', ssn_filtered_value);
		return if (IsFCRA, ssn_filtered_value, ssn_value_reg);
  end;

	EXPORT AutoheaderV2.layouts._ssn xform_cssn (AutoheaderV2.layouts.lib_search L) := transform
 		// ssn_value := GetCleanedSSN (L.ssn, L.ApplicationType, isFCRAval);
    ssn_value := L.ssn; // has been already been cleaned up and suppressed outside of a lib

		Self.ssn           := ssn_value;    //AutoStandardI.InterfaceTranslator.ssn_value.val
		Self.fuzzy_ssn     := L.ssntypos;    //AutoStandardI.InterfaceTranslator.fuzzy_ssn.val
		Self.partial_ssn   := L.UseSSNFallBack;    //AutoStandardI.InterfaceTranslator.ssnfallback_value.val
		Self.only_good_ssn := L.searchgoodssnonly;    //AutoStandardI.InterfaceTranslator.searchgoodssnonly_value.val
		//note: must be already pre-processed by a caller: to get rid of UsingKeepSSNs
		Self.keep_old_ssn  := L.KeepOldSsns;    //AutoStandardI.InterfaceTranslator.keep_old_ssns_val.val
				// derived, currently used for prunning only
    set of string9 only_input_ssn := [ssn_value];
		Self.ssn_set       := if (L.ssntypos, doxie.typossn (ssn_value), only_input_ssn);    //AutoStandardI.InterfaceTranslator.ssn_set.val
	end;
	
	EXPORT cssn (AutoheaderV2.layouts.lib_search L) := function  
		return row (xform_cssn (L));
  end;

	EXPORT AutoheaderV2.layouts._name xform_cname (AutoheaderV2.layouts.lib_search L, boolean is_saltFetch) := transform
		unparsed_fullname_value := L.unparsedfullname;
		// clean_fmlname_val := L.cleanfmlname; //? not used
		cleaned_name := map(
			// mx_lfmname_val.val(in_mod)<>'' => Address.CleanPersonLFM73(mx_lfmname_val.val(in_mod)),
			// new name cleaner was introduced and caused a regression - former version
			// parsed single word inputs as last names always; new version parses them as first names always.   
			// in order to mimic the behavior of the prior name cleaner when only a single word
			// is input as an unparsed full name, skip cleaning altogether and fabricate a result 
			// in the cleanPerson73 format with only last name populated (for both unknown and FML versions)
			ut.NoWords (unparsed_fullname_value) <= 1 => forceAsLname (unparsed_fullname_value),
      // name cleaner with fixed FML order
      // search_code & Constants.SearchCode.CLEAN_FML > 0 => address.CleanPersonFML73 (unparsed_fullname_value),
			address.CleanPerson73 (unparsed_fullname_value));

		valid_cleaned := unparsed_fullname_value <> '';// or 
										 // mx_nameasis_val.val(in_mod) <> '' or 
										 // mx_asisname_val.val(in_mod) <> '' or 
										 // mx_lfmname_val.val(in_mod) <> '';
										 
		pre_fname_val      := if (is_saltFetch,stringlib.StringFilterOut(L.firstname,'\''),L.firstname); 
		fname_val          := if (pre_fname_val = '' and valid_cleaned, cleaned_name[6..25], pre_fname_val);
		fname_value        := trim (stringlib.StringToUpperCase(fname_val),left);
		Self.fname         := fname_value;    //AutoStandardI.InterfaceTranslator.fname_value.val

		pre_mname_val    := if (is_saltFetch,stringlib.StringFilterOut(L.middlename,'\''),L.middlename); 
		mname_val        := if (pre_mname_val = '' and valid_cleaned, cleaned_name[26..45], pre_mname_val);
		mname_value      := trim (stringlib.StringToUpperCase(mname_val),left);
		Self.mname       := mname_value;    //AutoStandardI.InterfaceTranslator.mname_value.val

		pre_lname_val    := if (is_saltFetch,stringlib.StringFilterOut(L.lastname,'\''),L.lastname);
		lname_val        := map (//mx_lname_val.val(in_mod)<>'' => mx_lname_val.val(in_mod),
														 pre_lname_val = '' AND valid_cleaned => cleaned_name[46..65],
														 pre_lname_val);
		lname_value        := trim (stringlib.StringToUpperCase(lname_val),left);
		Self.lname         := lname_value;    //AutoStandardI.InterfaceTranslator.lname_value.val

		lname4_val       := L.lname4;
		Self.lname4      := stringlib.StringToUpperCase (lname4_val);    //AutoStandardI.InterfaceTranslator.lname4_value.val

		fname3_val       := L.fname3;
		Self.fname3      := stringlib.StringToUpperCase (fname3_val);    //AutoStandardI.InterfaceTranslator.fname3_value.val

		rel_fname_val1   := L.relativefirstname1;
		rel_fname_val2   := L.relativefirstname2;
		Self.fname_rel_1 := if (rel_fname_val1 <> '',
														stringlib.StringToUpperCase(rel_fname_val1),
														stringlib.StringToUpperCase(rel_fname_val2));    //AutoStandardI.InterfaceTranslator.rel_fname_value1.val

		Self.fname_rel_2 := if (rel_fname_val1<>'', stringlib.StringToUpperCase (rel_fname_val2), '');    // AutoStandardI.InterfaceTranslator.rel_fname_value2.val
		olname1_val      := L.otherlastname1;
		Self.lname_other := stringlib.StringToUpperCase (olname1_val);    //AutoStandardI.InterfaceTranslator.other_lname_value1.val

		Self.nicknames          := ~L.StrictMatch and L.allownicknames;    //AutoStandardI.InterfaceTranslator.nicknames.val
		Self.phonetic           := ~L.StrictMatch and L.phoneticmatch;    //AutoStandardI.InterfaceTranslator.phonetics.val
		Self.phonetic_distance  := L.phoneticdistancematch;    //AutoStandardI.InterfaceTranslator.usephoneticdistance.val
		self.distance_threshold := L.distancethreshold;    //AutoStandardI.InterfaceTranslator.distance_threshold.val
		Self.leading_name_match := L.BpsLeadingNameMatch;    //AutoStandardI.InterfaceTranslator.BpsLeadingNameMatch_value.val
		Self.allow_leading_name_match := L.AllowLeadingLname;    //AutoStandardI.InterfaceTranslator.AllowLeadingLname_value.val
		checknamevariants := L.checknamevariants;
		Self.check_name_variants := ~L.StrictMatch and checknamevariants;    //AutoStandardI.InterfaceTranslator.CheckNameVariants.val
		//... OR: Self.check_name_variants := AutoStandardI.InterfaceTranslator.namevariants.val(project(args, AutoStandardI.InterfaceTranslator.namevariants.params));

				// derived
		Self.fname_set := map (fname_value = ''  => [],    //AutoStandardI.InterfaceTranslator.fname_set_value.val
													 checknamevariants => ut.NameVariants (fname_value,10,isFCRAval,checknamevariants).fnames,
													 [fname_value]);

		cleaned_input_lname := stringlib.stringfilter(lname_value, _Validate.Strings.Alpha_Upper);
		Self.lname_set := map (lname_value = ''  => [],    //AutoStandardI.InterfaceTranslator.lname_set_value.val
													 checkNameVariants => ut.NameVariants(cleaned_input_lname,10,isFCRAval,checkNameVariants).lnames,
													 lname_value != cleaned_input_lname => [lname_value, cleaned_input_lname],
													 [lname_value]);

		lname_phn_value := metaphonelib.DMetaPhone1(lname_value)[1..6];
		ds_dist_value := header.key_phonetic_lname (keyed (dph_lname = lname_phn_value), StringLib.EditDistance (lname_value, lname) < L.distancethreshold);
		orig_set_value := SET (IF(L.phoneticdistancematch, CHOOSEN (ds_dist_value, 500)), lname);

		Self.lname_set_phonetic := orig_set_value + [lname_value];    //AutoStandardI.InterfaceTranslator.lnamephoneticset.val
	end;
	
	EXPORT cname (AutoheaderV2.layouts.lib_search L, boolean is_saltFetch = false) := function
	return row (xform_cname (L,is_saltFetch));
  end;
	
	EXPORT AutoheaderV2.layouts._address xform_caddress (AutoheaderV2.layouts.lib_search L,  boolean is_saltFetch) := transform

		// First, values which are common for different address components
		addr_value := L.addr;
		//TODO: probably, can be simplified.
		pos_space := Stringlib.StringFind (addr_value, ' ', 1);
		pos_comma := Stringlib.StringFind (addr_value, ',', 1);
		pos_colon := Stringlib.StringFind (addr_value, ':', 1);
		pos_astr  := Stringlib.StringFind (addr_value, '*', 1); 
		pos_q     := Stringlib.StringFind (addr_value, '?', 1);

		boolean addr_comma := pos_comma <> 0 and pos_comma < pos_space;
		boolean addr_colon := pos_colon <> 0 and pos_colon < pos_space;
		boolean addr_range := (addr_value != '') and (addr_comma or addr_colon);
		boolean addr_wild  := (addr_value != '') and
													((pos_astr <> 0 and pos_astr < pos_space) OR (pos_q <> 0 and pos_q < pos_space));

		boolean skipTheCleanAddr := L.isPRP and (length(trim(addr_value, all)) = length(trim(addr_value, left, right)));


		city_val := L.city;
		state_val := L.state;
		input_city_value := stringlib.StringToUpperCase (city_val);
		StateCityZip_val := L.statecityzip;
		boolean isValidCityStateClean := (city_val <> '' and state_val <> '') or statecityzip_val <> '';

		zip_val0 :=  if((integer)L.zip <> 0 or hasAlpha(L.zip), L.zip, '');
		zip_val :=  StringLib.StringToUpperCase(zip_val0);

		// cleaning address
		boolean allowclean := addr_value <> '' OR city_val <> '' OR StateCityZip_val <> '';
		string addr_line_first := IF (addr_range, 
																	if (addr_comma,
																			addr_value[StringLib.StringFind(addr_value, ',', 1)..],
																			addr_value[StringLib.StringFind(addr_value, ':', 1)..]),
																	addr_value);
		string fake_city := 'Nocityname NY';    //change: no Canada
		string addr_line_second := IF ((city_val <> '' AND state_val <> '') OR zip_val <> '',
																		TRIM(city_val) + ' ' + TRIM(state_val) + ' ' + TRIM(zip_val),
																		if(StateCityZip_val <> '', StateCityZip_val, fake_city));
		string addr1 := if (allowclean, addr_line_first, '');
		string addr2 := if (allowclean, addr_line_second, '');

		clean_address := address.GetCleanAddress (addr1, addr2, address.Components.Country.US, true).results;
		// clean_address := if (allowclean,
												 // address.GetCleanAddress (addr1, addr2, address.Components.Country.US, true).str_addr,
												 // address.CleanAddress182 (addr1, addr2),
												 // (string182) '');


		// store cleaned values:
		ca_prim_range := clean_address.prim_range;
		ca_prim_name := clean_address.prim_name;
		ca_sec_range := clean_address.sec_range;
		ca_city := clean_address.v_city;
		ca_state := clean_address.state;
		ca_zip := clean_address.zip;
		ca_error_msg := clean_address.error_msg;
		
		// ca_prim_range := clean_address[1..10];
		// ca_prim_name := clean_address[13..40];
		// ca_sec_range := clean_address[57..64];
		// ca_city := clean_address[90..114];
		// ca_state := clean_address[115..116];
		// ca_zip := clean_address[117..121];
		// ca_error_msg := clean_address[179..182];

		prange_temp := if (skipTheCleanAddr, '', trim (ca_prim_range));
		pname_val :=  if (skipTheCleanAddr, '', ca_prim_name);

		err_stat := if (allowclean, ca_error_msg, '');
											
		pname_to_use := if(L.primname <> '', StringLib.StringToUpperCase(L.primname),pname_val);             
		pname_value  := if(is_saltfetch, pname_to_use, doxie.StripOrdinal(pname_to_use)); // if SALT flag is true skip StripOrdinal call.
												
		city_value := if (isValidCityStateClean, ca_city, input_city_value);

		state_value := stringlib.StringToUpperCase(map(
				city_val='' and state_val='' and zip_val<>'' => ziplib.ZipToState2(zip_val),
				state_val<>''                                => state_val,
				isValidCityStateClean                        => ca_state,
				zip_val <> ''                                => ziplib.ZipToState2(zip_val),
				''));

		prange_wild_value := if(addr_wild, addr_value [1..pos_space-1],'');
		prange_beg_value := if (addr_range, (unsigned) addr_value [1.. if (addr_comma, pos_comma-1, pos_colon-1)], 0);
		prange_end_value := if (addr_range, (unsigned) addr_value [if (addr_comma, pos_comma+1, pos_colon+1).. pos_space-1], 0);

		county_value := stringlib.StringToUpperCase(L.county);
		
		// layouts._address doTranslate () := transform
		Self.prim_range     := map (    //AutoStandardI.InterfaceTranslator.prange_value.val
														L.primrange <> '' => L.primrange,
														skipTheCleanAddr => (STRING10) addr_value,
														addr_wild => if(prange_temp = '', '', (STRING10) prange_wild_value),
														addr_range => (STRING10)prange_beg_value, 
														prange_temp);

		Self.prim_name      := pname_value;    //AutoStandardI.InterfaceTranslator.pname_value.val

		Self.sec_range      := map(    //AutoStandardI.InterfaceTranslator.sec_range_value.val
														L.secrange <> '' => L.secrange,
														ca_sec_range);

		Self.state          :=  state_value;    //AutoStandardI.InterfaceTranslator.state_value.val
		
		zip_val_to_use      := if((integer)ca_zip <> 0 or hasAlpha(ca_zip), ca_zip, '');	
		Self.zip5           := if(is_saltFetch,
		                            zip_val_to_use,  //if SALT flag is true using cleaned zip
		                            zip_val);    //AutoStandardI.InterfaceTranslator.zip_val.val
		
		zipradius_value 	  := map(L.StrictMatch => 0,
														 L.zipradius != 0 => L.zipradius,
														 L.mileradius);
		Self.zip_radius     := zipradius_value;    //AutoStandardI.InterfaceTranslator.zipradius_value.val
		Self.county         := county_value;    //AutoStandardI.InterfaceTranslator.county_value.val
		Self.city           := city_value;    //AutoStandardI.InterfaceTranslator.city_value.val
		Self.city_other     := stringlib.StringToUpperCase (L.othercity1);    //AutoStandardI.InterfaceTranslator.other_city_value.val
		Self.state_prev_1   := stringlib.StringToUpperCase (L.otherstate1);    //AutoStandardI.InterfaceTranslator.prev_state_val1.val
		Self.state_prev_2   := stringlib.StringToUpperCase (L.otherstate2);    //AutoStandardI.InterfaceTranslator.prev_state_val2.val
		Self.date_firstseen := ut.IntDate_To_YYYYMM (L.datefirstseen,false);    //AutoStandardI.InterfaceTranslator.date_first_seen_value.val
		Self.date_lastseen  := ut.IntDate_To_YYYYMM (L.datelastseen,false);    //AutoStandardI.InterfaceTranslator.date_last_seen_value.val
		Self.allow_dateseen := L.allowdateseen;    //AutoStandardI.InterfaceTranslator.allow_date_seen_value.val
		Self.sec_range_fuzziness := case (L.FuzzySecRange,    //AutoStandardI.InterfaceTranslator.FuzzySecRange_value.val
																			1 => AutostandardI.Constants.SECRANGE.EXACT_OR_BLANK,
																			2 => AutostandardI.Constants.SECRANGE.INCLUDES_ATOM,
																			AutostandardI.Constants.SECRANGE.EXACT);

		// derived
		city_zip_value := ziplib.CityToZip5 (state_value, city_value);
		// TODO: this call assumes that address may or may not be cleaned properly.
		zip_value := ut.fn_GetZipSet (city_value, state_value, zip_val, county_value, 
																	city_zip_value, zipradius_value, ca_zip, err_stat[1]='E');
	
		Self.zip_set        := zip_value;    //AutoStandardI.InterfaceTranslator.zip_value.val

		city_zip_set := if (state_value <> '' and city_value <> '', ut.ZipsWithinCity(state_value, city_value), []);

		all_zip_ds :=  project (dataset (zip_value + city_zip_set, {unsigned3 zip}),
														transform ({string5 zip}, self.zip := intformat( left.zip,5,1)));

		all_zip_set := set (dedup (all_zip_ds, zip, all),zip);
		boolean call_range := all_zip_set != [] and (pname_value != '') and (prange_beg_value != 0 or prange_end_value != 0);

		neighbors_range := if (call_range, limit (limit (
						project (doxie.key_nbr_headers (
							 // keyed ((exists(zip_ds) or exists(city_zip_ds)) and zip IN city_zip_set,
							 keyed (zip IN all_zip_set),
							 keyed (prim_name[1..length(pname_value)] = pname_value), 
							 ((integer)prim_range >= prange_beg_value and (integer)prim_range <= prange_end_value)),
						{doxie.key_nbr_headers.prim_range}),
			ut.limits.FETCH_KEYED, skip, keyed), ut.limits.FETCH_UNKEYED, skip));

		ds_prange_set := dedup (sort (neighbors_range, prim_range), prim_range);


    Self.prim_range_set := if (call_range, set (ds_prange_set, prim_range),[pname_value]); //AutoStandardI.InterfaceTranslator.prim_range_set_value.val
		Self.prange_beg     := prange_beg_value;    //AutoStandardI.InterfaceTranslator.prange_beg_value.val
		Self.prange_end     := prange_end_value;    //AutoStandardI.InterfaceTranslator.prange_end_value.val
		Self.prange_wild    := prange_wild_value;    //AutoStandardI.InterfaceTranslator.prange_wild_value.val
		Self._range         := addr_range;    //AutoStandardI.InterfaceTranslator.addr_range.val
		Self._wild          := addr_wild;    //AutoStandardI.InterfaceTranslator.addr_wild.val
		// change: keep cleaner error as it is, not booleans
		Self.err            := err_stat;
	end;
	
  EXPORT caddress (AutoheaderV2.layouts.lib_search L, boolean is_saltFetch = false) := function
	return row (xform_caddress (L,is_saltFetch));
  end;
	
	EXPORT AutoheaderV2.layouts._phone xform_cphone (AutoheaderV2.layouts.lib_search L) := transform
		temp_val := stringlib.stringfilter (L.phone,'0123456789');
		phone_val := if ((integer) temp_val <> 0, L.phone, '');

		phone_nopunct := stringlib.stringfilter(phone_val,'0123456789');
		// bug 48829 -- need to treat any phone10 that is all zeroes as an invalid phone and discard the input
		valid_phone (string ph) := stringlib.StringFilterOut (ph, '0') != '';
		Self.phone10 := if (valid_phone (phone_nopunct), phone_nopunct, '');    //AutoStandardI.InterfaceTranslator.phone_value.val
	end;
	
	EXPORT cphone (AutoheaderV2.layouts.lib_search L) := function
	return row (xform_cphone (L));
  end;

	EXPORT AutoheaderV2.layouts._dob xform_cdob (AutoheaderV2.layouts.lib_search L) := transform

		dob     := doxie.DOBTools(L.dob).dob_val;    //AutoStandardI.InterfaceTranslator.dob_val.val
		agelow  := L.agelow;    //AutoStandardI.InterfaceTranslator.agelow_val.val
		agehigh := L.agehigh;    //AutoStandardI.InterfaceTranslator.agehigh_val.val
		self.dob       := dob; 
		Self.agelow    := agelow;
		Self.agehigh   := agehigh;
		Self.fuzzy_dob := L.allowFuzzyDOBMatch;    //AutoStandardI.InterfaceTranslator.allowFuzzyDOBMatch.val
				// derived
		Self.dob_low := map (dob != 0 => dob,
												 agehigh = 0 and agelow = 0 => 0,
												 agehigh = 0 => 19000101,
												 ((todays_date div 10000 - agehigh - 1) * 10000) + 101);
		Self.dob_high := map (dob != 0 => dob,
													agehigh = 0 and agelow = 0 => 0,
													agelow = 0 => todays_date,
													((todays_date div 10000 - agelow) * 10000) + 1231);
	end;
	
	EXPORT cdob (AutoheaderV2.layouts.lib_search L) := function  
	return row (xform_cdob (L));
  end;

END;
