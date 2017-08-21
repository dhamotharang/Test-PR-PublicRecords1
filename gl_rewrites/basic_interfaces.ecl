import Address,business_header,business_header_ss,doxie,ut;
export basic_interfaces :=
	module
		export i__iscomp :=
			interface
				export boolean iscomp := false;
			end;
		export i__isFCRA :=
			interface
				export boolean isfcra := false;
			end;
		export i__fuzzy_ssn :=
			interface(
				gl_rewrites.parameter_interfaces.p__SSNTypos)
				export boolean fuzzy_ssn := parm_SSNTypos;
			end;
		export i__phone_val :=
			interface(
				gl_rewrites.parameter_interfaces.p__phone)
				export string15 phone_val := parm_phone;
			end;
		export i__phone_value :=
			interface(
				i__phone_val)
				export string10 phone_value := Stringlib.StringFilterOut(phone_val,'()-');
			end;
		export i__fein_val :=
			interface(
				gl_rewrites.parameter_interfaces.p__fein)
				export string9 fein_val := parm_fein;
			end;
		export i__fein_value :=
			interface(
				i__fein_val)
				export unsigned4 fein_value := (unsigned4)fein_val;
			end;
		export i__dob_val :=
			interface(
				gl_rewrites.parameter_interfaces.p__DOB)
				export unsigned8 dob_val := parm_DOB;
			end;
		export i__agehigh_val :=
			interface(
				gl_rewrites.parameter_interfaces.p__AgeHigh)
				export unsigned1 agehigh_val := parm_AgeHigh;
			end;
		export i__agelow_val :=
			interface(
				gl_rewrites.parameter_interfaces.p__AgeLow)
				export unsigned1 agelow_val := parm_AgeLow;
			end;
		export i__current_year :=
			interface
				export unsigned2 current_year := (unsigned2)stringlib.getdateyyyymmdd()[1..4];
			end;
		export i__find_year_low :=
			interface(
				i__dob_val,
				i__agehigh_val,
				i__current_year)
				export find_year_low := map(
					dob_val div 10000 <> 0 => dob_val div 10000,
					agehigh_val <> 0 => current_year - agehigh_val - 1,
					0); 
			end;
		export i__find_year_high :=
			interface(
				i__dob_val,
				i__agelow_val,
				i__current_year)
				export find_year_high := map(
					dob_val div 10000 <> 0 => dob_val div 10000,
					agelow_val <> 0 => current_year - agelow_val + 1,
					0);
			end;
		export i__find_month :=
			interface(
				i__dob_val)
				export find_month := (DOB_val div 100) % 100;
			end;
		export i__find_day :=
			interface(
				i__dob_val)
				export find_day := DOB_val % 100;
			end;
		export i__prev_state_val1l :=
			interface(
				gl_rewrites.parameter_interfaces.p__OtherState1)
				export string2 prev_state_val1l := parm_OtherState1;
			end;
		export i__prev_state_val2l :=
			interface(
				gl_rewrites.parameter_interfaces.p__OtherState2)
				export string2 prev_state_val2l := parm_OtherState2;
			end;
		export i__prev_state_val1 :=
			interface(
				i__prev_state_val1l)
				export prev_state_val1 := stringlib.stringtouppercase(prev_state_val1l);
			end;
		export i__prev_state_val2 :=
			interface(
				i__prev_state_val2l)
				export prev_state_val2 := stringlib.stringtouppercase(prev_state_val2l);
			end;
		export i__rel_fname_val1 :=
			interface(
				gl_rewrites.parameter_interfaces.p__RelativeFirstName1)
				export string30 rel_fname_val1 := parm_RelativeFirstName1;
			end;
		export i__rel_fname_val2 :=
			interface(
				gl_rewrites.parameter_interfaces.p__RelativeFirstName2)
				export string30 rel_fname_val2 := parm_RelativeFirstName2;
			end;
		export i__rel_fname_value1 :=
			interface(
				i__rel_fname_val1,
				i__rel_fname_val2)
				export rel_fname_value1 := if(
					rel_fname_val1 <> '',
					stringlib.stringtouppercase(rel_fname_val1),
					stringlib.stringtouppercase(rel_fname_val2));
			end;
		export i__rel_fname_value2 :=
			interface(
				i__rel_fname_val1,
				i__rel_fname_val2)
				export rel_fname_value2 := if(
					rel_fname_val1 <> '',
					stringlib.stringtouppercase(rel_fname_val2),
					'');
			end;
		export i__mx_lname_val :=
			interface(
				gl_rewrites.parameter_interfaces.p__lname)
				export string50 mx_lname_val := parm_lname;
			end;
		export i__pre_lname_val :=
			interface(
				gl_rewrites.parameter_interfaces.p__LastName)
				export string30 pre_lname_val := parm_LastName;
			end;
		export i__unparsed_fullname_value :=
			interface(
				gl_rewrites.parameter_interfaces.p__UnParsedFullName)
				export string120 unparsed_fullname_value := parm_UnParsedFullName;
			end;
		export i__mx_nameasis_val :=
			interface(
				gl_rewrites.parameter_interfaces.p__nameasis)
				export string120 mx_nameasis_val := parm_nameasis;
			end;
		export i__mx_asisname_val :=
			interface(
				gl_rewrites.parameter_interfaces.p__asisname)
				export string120 mx_asisname_val := parm_asisname;
			end;
		export i__mx_lfmname_val :=
			interface(
				gl_rewrites.parameter_interfaces.p__lfmname)
				export string50 mx_lfmname_val := parm_lfmname;
			end;
		export i__valid_cleaned :=
			interface(
				i__unparsed_fullname_value,
				i__mx_nameasis_val,
				i__mx_asisname_val,
				i__mx_lfmname_val)
				export boolean valid_cleaned :=
					unparsed_fullname_value <> '' or
					mx_nameasis_val <> '' or
					mx_asisname_val <> '' or
					mx_lfmname_val <> '';
			end;
		export i__cleaned_name :=
			interface(
				i__mx_lfmname_val,
				i__unparsed_fullname_value)
				export cleaned_name := map(
					mx_lfmname_val <> '' => Address.CleanPersonLFM73(mx_lfmname_val),
					address.CleanPerson73(unparsed_fullname_value));
			end;
		export i__lname_val :=
			interface(
				i__mx_lname_val,
				i__pre_lname_val,
				i__valid_cleaned,
				i__cleaned_name)
				export string30 lname_val := map(
					mx_lname_val <> '' => mx_lname_val,
					pre_lname_val = '' and valid_cleaned => cleaned_name[46..65],
					pre_lname_val);
			end;
		export i__lname_value :=
			interface(
				i__lname_val)
				export lname_value := stringlib.stringtouppercase(lname_val);
			end;
		export i__phonetics :=
			interface(
				gl_rewrites.parameter_interfaces.p__PhoneticMatch)
				export boolean phonetics := parm_PhoneticMatch;
			end;
		export i__nicknames :=
			interface(
				gl_rewrites.parameter_interfaces.p__AllowNicknames)
				export boolean nicknames := parm_AllowNicknames;
			end;
		export i__pre_fname_val :=
			interface(
				gl_rewrites.parameter_interfaces.p__FirstName)
				export string30 pre_fname_val := parm_FirstName;
			end;
		export i__fname_val :=
			interface(
				i__pre_fname_val,
				i__valid_cleaned,
				i__cleaned_name)
				export string30 fname_val := if(
					pre_fname_val = '' and valid_cleaned,
					cleaned_name[6..25],
					pre_fname_val);
			end;
		export i__fname_value :=
			interface(
				i__fname_val)
				export fname_value := stringlib.stringtouppercase(fname_val);
			end;
		export i__pre_mname_val :=
			interface(
				gl_rewrites.parameter_interfaces.p__MiddleName)
				export string30 pre_mname_val := parm_MiddleName;
			end;
		export i__mname_val :=
			interface(
				i__pre_mname_val,
				i__valid_cleaned,
				i__cleaned_name)
				export string30 mname_val := if(
					pre_mname_val = '' and valid_cleaned,
					cleaned_name[26..45],
					pre_mname_val);
			end;
		export i__mname_value :=
			interface(
				i__mname_val)
				export mname_value := stringlib.stringtouppercase(mname_val);
			end;
		export i__olname1_val :=
			interface(
				gl_rewrites.parameter_interfaces.p__OtherLastName1)
				export string30 olname1_val := parm_OtherLastName1;
			end;
		export i__other_lname_value1 :=
			interface(
				i__olname1_val)
				export other_lname_value1 := stringlib.stringtouppercase(olname1_val);
			end;
		export i__mx_cn_val :=
			interface(
				gl_rewrites.parameter_interfaces.p__cn)
				export string120 mx_cn_val := parm_cn;
			end;
		export i__mx_company_val :=
			interface(
				gl_rewrites.parameter_interfaces.p__company)
				export string120 mx_company_val := parm_company;
			end;
		export i__mx_corpname_val :=
			interface(
				gl_rewrites.parameter_interfaces.p__corpname)
				export string350 mx_corpname_val := parm_corpname;
			end;
		export i__company_name :=
			interface(
				gl_rewrites.parameter_interfaces.p__CompanyName)
				export string120 company_name := parm_CompanyName;
			end;
		export i__comp_name_value :=
			interface(
				i__mx_nameasis_val,
				i__mx_asisname_val,
				i__mx_cn_val,
				i__mx_company_val,
				i__mx_corpname_val,
				i__company_name)
				export comp_name_value := stringlib.stringtouppercase(map(
					mx_nameasis_val <> '' => mx_nameasis_val,
					mx_asisname_val <> '' => mx_asisname_val,
					mx_cn_val <> '' => mx_cn_val,
					mx_company_val <> '' => mx_company_val,
					mx_corpname_val <> '' => mx_corpname_val,
					company_name));
			end;
		export i__comp_name_indic_value :=
			interface(
				i__comp_name_value)
				export comp_name_indic_value := if(
					comp_name_value = '',
					'',
					trim(datalib.companyclean(comp_name_value)[1..40]));
			end;
		export i__comp_name_sec_value :=
			interface(
				i__comp_name_value)
				export comp_name_sec_value := if(
					comp_name_value = '',
					'',
					trim(datalib.companyclean(comp_name_value)[41..80]));
			end;
		export i__mx_predir_val :=
			interface(
				gl_rewrites.parameter_interfaces.p__predir)
				export string2 mx_predir_val := parm_predir;
			end;
		export i__pre_addr_value :=
			interface(
				gl_rewrites.parameter_interfaces.p__Addr)
				export string200 pre_addr_value := parm_Addr;
			end;
		export i__addr_value :=
			interface(
				i__pre_addr_value)
				export string200 addr_value := pre_addr_value;
			end;
		export i__city_val :=
			interface(
				gl_rewrites.parameter_interfaces.p__City)
				export string25 city_val := parm_City;
			end;
		export i__state_val :=
			interface(
				gl_rewrites.parameter_interfaces.p__State)
				export string2 state_val := parm_State;
			end;
		export i__statecityzip_val :=
			interface(
				gl_rewrites.parameter_interfaces.p__StateCityZip)
				export string50 statecityzip_val := parm_StateCityZip;
			end;
		export i__addr_comma :=
			interface(
				i__addr_value)
				export addr_comma :=
					Stringlib.StringFind(addr_value, ',', 1) <> 0 AND
					Stringlib.StringFind(addr_value, ',', 1) < Stringlib.StringFind(addr_value, ' ', 1);
			end;
		export i__addr_colon :=
			interface(
				i__addr_value)
				export addr_colon :=
					Stringlib.StringFind(addr_value, ':', 1) <> 0 AND
					Stringlib.StringFind(addr_value, ':', 1) < Stringlib.StringFind(addr_value, ' ', 1);
			end;
		export i__addr_range :=
			interface(
				i__addr_comma,
				i__addr_colon)
				export addr_range := addr_comma OR addr_colon;
			end;
		export i__mx_z5_val :=
			interface(
				gl_rewrites.parameter_interfaces.p__z5)
				export string5 mx_z5_val := parm_z5;
			end;
		export i__zip_val0 :=
			interface(
				gl_rewrites.parameter_interfaces.p__zip)
				export string5 zip_val0 := parm_zip;
			end;
		export i__zip_val :=
			interface(
				i__mx_z5_val,
				i__zip_val0)
				export zip_val := if(mx_z5_val <> '', mx_z5_val, zip_val0);
			end;
		export i__clean_address :=
			interface(
				i__addr_value,
				i__city_val,
				i__statecityzip_val,
				i__addr_range,
				i__state_val,
				i__zip_val)
				export clean_address := if(
					addr_value <> '' or city_val <> '' or StateCityZip_val <> '',
					doxie.cleanaddress182(
						if(
							addr_range,
							addr_value[StringLib.StringFind(addr_value, ' ', 1)..],
							addr_value),
						if(
							(city_val <> '' and state_val <> '') or zip_val <> '',
							trim(city_val) + ' ' + trim(state_val) + ' ' + trim(zip_val),
							if(
								StateCityZip_val <> '',
								StateCityZip_val,
								'New York NY'))),
					'');
			end;
		export i__predir_value :=
			interface(
				i__mx_predir_val,
				i__clean_address)
				export predir_value := if(
					mx_predir_val <> '',
					mx_predir_val,
					clean_address[11..12]);
			end;
		export i__isvalidcitystateclean :=
			interface(
				i__city_val,
				i__state_val,
				i__statecityzip_val)
				export boolean isValidCityStateClean :=
					(city_val <> '' and state_val <> '') or StateCityZip_val <> '';
			end;
		export i__city_value :=
			interface(
				i__isvalidcitystateclean,
				i__clean_address,
				i__city_val)
				export city_value := if(
					isValidCityStateClean,
					clean_address[90..114],
					stringlib.stringtouppercase(city_val));
			end;
		export i__prange_beg_value :=
			interface(
				i__addr_range,
				i__addr_value,
				i__addr_comma)
				export prange_beg_value := (unsigned)if(
					addr_range,
					addr_value[1..if(
						addr_comma,
						Stringlib.StringFind(addr_value, ',', 1)-1,
						Stringlib.StringFind(addr_value, ':', 1)-1)],
					'');
			end;
		export i__prange_end_value :=
			interface(
				i__addr_range,
				i__addr_value,
				i__addr_comma)
				export prange_end_value := (unsigned)if(
					addr_range,
					addr_value[if(
						addr_comma,
						Stringlib.StringFind(addr_value, ',', 1)+1,
						Stringlib.StringFind(addr_value, ':', 1)+1)..Stringlib.StringFind(addr_value, ' ', 1)-1],
					'');
			end;
		export i__pname_val :=
			interface(
				i__clean_address)
				export pname_val := clean_address[13..40];
			end;
		export i__pname_wild :=
			interface(
				i__pname_val)
				export boolean pname_wild :=
					Stringlib.StringFind(pname_val, '*', 1) <> 0 or
					Stringlib.StringFind(pname_val, '?', 1) <> 0;
			end;
		export i__pname_wild_val :=
			interface(
				i__pname_val)
				export pname_wild_val := doxie.StripWildOrdinal(pname_val);
			end;
		export i__addr_wild :=
			interface(
				i__addr_value)
				export boolean addr_wild :=
					Stringlib.StringFind(addr_value, '*', 1) <> 0 AND
					Stringlib.StringFind(addr_value, '*', 1) < Stringlib.StringFind(addr_value, ' ', 1) or
					Stringlib.StringFind(addr_value, '?', 1) <> 0 AND
					Stringlib.StringFind(addr_value, '?', 1) < Stringlib.StringFind(addr_value, ' ', 1);
			end;
		export i__prange_wild_value :=
			interface(
				i__addr_wild,
				i__addr_value)
				export prange_wild_value := if(
					addr_wild,
					addr_value[1..Stringlib.StringFind(addr_value, ' ', 1)-1],
					'');
			end;
		export i__mx_prim_name_val :=
			interface(
				gl_rewrites.parameter_interfaces.p__prim_name)
				export string28 mx_prim_name_val := parm_prim_name;
			end;
		export i__mx_streetname_val :=
			interface(
				gl_rewrites.parameter_interfaces.p__street_name)
				export string50 mx_streetname_val := parm_street_name;
			end;
		export i__pname_value :=
			interface(
				i__mx_prim_name_val,
				i__mx_streetname_val,
				i__pname_val)
				export pname_value := doxie.StripOrdinal(map(
					mx_prim_name_val <> '' => StringLib.StringToUpperCase(mx_prim_name_val),
					mx_streetName_val <> '' => StringLib.StringToUpperCase(mx_streetName_val),
					pname_val));
			end;
		export i__mx_prim_range_val :=
			interface(
				gl_rewrites.parameter_interfaces.p__prim_range)
				export string10 mx_prim_range_val := parm_prim_range;
			end;
		export i__prange_value :=
			interface(
				i__mx_prim_range_val,
				i__addr_wild,
				i__clean_address,
				i__prange_wild_value,
				i__addr_range,
				i__prange_beg_value)
				export prange_value := map(
					mx_prim_range_val <> '' => mx_prim_range_val,
					addr_wild => if(clean_address[1..10]='','',(STRING10)prange_wild_value),
					addr_range => (STRING10)prange_beg_value,
					clean_address[1..10]);
			end;
		export i__addr_loose :=
			interface(
				i__addr_range,
				i__addr_wild)
				export addr_loose := addr_wild OR addr_range;
			end;
		export i__mx_st_val :=
			interface(
				gl_rewrites.parameter_interfaces.p__st)
				export string2 mx_st_val := parm_st;
			end;
		export i__mx_st_orig_val :=
			interface(
				gl_rewrites.parameter_interfaces.p__st_orig)
				export string2 mx_st_orig_val := parm_st_orig;
			end;
		export i__state_value :=
			interface(
				i__city_val,
				i__state_val,
				i__mx_st_val,
				i__zip_val,
				i__mx_st_orig_val,
				i__isvalidcitystateclean,
				i__clean_address)
				export state_value := stringlib.stringtouppercase(map(
					city_val = '' and state_val = '' and mx_st_val = '' and zip_val <> '' => ziplib.ZipToState2(zip_val),
					mx_st_val <> '' => mx_st_val,
					mx_st_orig_val <> '' => mx_st_orig_val,
					state_val <> '' => state_val,
					isValidCityStateClean => clean_address[115..116],
					''));
			end;
		export i__score_threshold_value :=
			interface(
				gl_rewrites.parameter_interfaces.p__ScoreThreshold)
				export unsigned1 score_threshold_value := parm_ScoreThreshold;
			end;
		export i__did_value :=
			interface(
				gl_rewrites.parameter_interfaces.p__did)
				export string14 did_value := parm_did;
			end;
		export i__lookup_val :=
			interface(
				gl_rewrites.parameter_interfaces.p__LookupType)
				export string10 lookup_val := parm_LookupType;
			end;
		export i__party_type :=
			interface(
				gl_rewrites.parameter_interfaces.p__PartyType)
				export string1 party_type := parm_PartyType;
			end;
		export i__lookup_value :=
			interface(
				i__party_type,
				i__lookup_val)
				export unsigned4 lookup_value :=
					doxie.lookup_bit(
						StringLib.StringToUpperCase(
							if(
								party_type <> '',
								'PARTY_' + party_type,
								lookup_val)));
			end;
		export i__cnvf_onerow :=
			interface
				export cnvf_onerow := dataset([{0}], {unsigned a});
			end;
		export i__cnvf_forwords :=
			interface(
				i__cnvf_onerow,
				i__comp_name_value,
				i__state_value)
				export cnvf_forwords :=
					project(
						cnvf_onerow(
							comp_name_value <> ''),
						transform(
							business_header_ss.layout_MakeCNameWords,
							self.company_name := comp_name_value,
							self.state := state_value,
							self := []));
			end;
		export i__cnvf_words :=
			interface(
				i__cnvf_forwords)
				export cnvf_words :=
					Business_Header_SS.Fn_MakeCNameWords(cnvf_forwords)(length(trim(word)) > 1);
			end;
		export i__company_name_val_filt :=
			interface(
				i__cnvf_words)
				export string120 company_name_val_filt := cnvf_words(seq = 1)[1].word;
			end;
		export i__company_name_val_filt2 :=
			interface(
				i__comp_name_value,
				i__company_name_val_filt)
				export string120 company_name_val_filt2 :=
					Business_Header_SS.Fn_SubstituteForAndString(
						comp_name_value,
						company_name_val_filt);
			end;
		export i__bdid_value :=
			interface(
				gl_rewrites.parameter_interfaces.p__BDID)
				export unsigned6 bdid_value := (unsigned6)parm_BDID;
			end;
		export i__mx_suffix_val :=
			interface(
				gl_rewrites.parameter_interfaces.p__suffix)
				export string4 mx_suffix_val := parm_suffix;
			end;
		export i__mx_postdir_val :=
			interface(
				gl_rewrites.parameter_interfaces.p__postdir)
				export string2 mx_postdir_val := parm_postdir;
			end;
		export i__mx_sec_range_val :=
			interface(
				gl_rewrites.parameter_interfaces.p__sec_range)
				export string8 mx_sec_range_val := parm_sec_range;
			end;
		export i__addr_suffix_value :=
			interface(
				i__mx_suffix_val,
				i__clean_address)
				export addr_suffix_value := if(
					mx_suffix_val <> '',
					mx_suffix_val,
					clean_address[41..44]);
			end;
		export i__postdir_value :=
			interface(
				i__mx_postdir_val,
				i__clean_address)
				export postdir_value := if(
					mx_postdir_val <> '',
					mx_postdir_val,
					clean_address[45..46]);
			end;
		export i__sec_range_value :=
			interface(
				i__mx_sec_range_val,
				i__clean_address)
				export sec_range_value := if(
					mx_sec_range_val <> '',
					mx_sec_range_val,
					clean_address[57..64]);
			end;
		export i__addr_error_value :=
			interface(
				i__clean_address)
				export addr_error_value :=
					clean_address[179..180] = 'E3' OR
					clean_address[179..182] IN ['E500','E502'];
			end;
		export i__zipradius_value :=
			interface(
				gl_rewrites.parameter_interfaces.p__ZipRadius)
				export unsigned2 zipradius_value := parm_ZipRadius;
			end;
		export i__city_zip_value :=
			interface(
				i__state_value,
				i__city_value)
				export city_zip_value := ziplib.CityToZip5(state_value, city_value);
			end;
		export i__zip_value :=
			interface(
				i__zip_val,
				i__zipradius_value,
				i__state_value,
				i__city_value,
				i__city_zip_value)
				export zip_value := if(
					zip_val <> '',
					if(
						ziplib.ZipsWithinRadius(zip_val,zipradius_value) = [],
						[(integer4)zip_val],
						ziplib.ZipsWithinRadius(zip_val,zipradius_value)),
					if(
						state_value <> '' and city_value <> '' and zipradius_value > 0,
						ziplib.ZipsWithinRadius(city_zip_value,zipradius_value),
						[]));
			end;
		export i__input_city_value :=
			interface(
				i__city_val)
				export input_city_value := stringlib.stringtouppercase(city_val);
			end;
		export i__other_city_val :=
			interface(
				gl_rewrites.parameter_interfaces.p__OtherCity1)
				export string25 other_city_val := parm_OtherCity1;
			end;
		export i__other_city_value :=
			interface(
				i__other_city_val)
				export other_city_value := stringlib.stringtouppercase(other_city_val);
			end;
		export i__nodeepdive :=
			interface(
				gl_rewrites.parameter_interfaces.p__NoDeepDive)
				export boolean nodeepdive := parm_NoDeepDive;
			end;
		export i__mile_radius :=
			interface(
				gl_rewrites.parameter_interfaces.p__MileRadius)
				export unsigned2 mile_radius := parm_MileRadius;
			end;
		export i__mile_radius_value :=
			interface(
				i__zip_val,
				i__state_value,
				i__city_value,
				i__mile_radius)
				export unsigned2 mile_radius_value := map(
					zip_val = '' and (state_value = '' OR city_value = '') => 0,
					mile_radius < 50 => mile_radius,
					50);
			end;
		export i__zip_value_cleaned :=
			interface(
				i__zip_val,
				i__addr_value,
				i__city_value,
				i__state_value)
				export zip_value_cleaned := if(
					zip_val = ''  and addr_value <> '' and city_value <> '' and state_value <> '',
					clean_address[117..121],
					zip_val);
			end;
		export i__bh_zip_value :=
			interface(
				i__zip_value_cleaned,
				i__mile_radius_value,
				i__state_value,
				i__city_value,
				i__city_zip_value)
				export set of integer4 bh_zip_value :=
					if(zip_value_cleaned <> '' and mile_radius_value = 0,
						[(integer)zip_value_cleaned],
						if(zip_value_cleaned <> '',
							ziplib.ZipsWithinRadius(zip_value_cleaned, mile_radius_value),
							if(state_value <> '' AND city_value <> '',
								if(mile_radius_value > 0,
									ziplib.ZipsWithinRadius(city_zip_value, mile_radius_value),
									ut.ZipsWithinCity(state_value,city_value)),
								[0])));
			end;
		export i__ds_zip0 :=
			interface(
				i__bh_zip_value)
				export ds_zip0 := dataset(bh_zip_value, {integer4 zip});
			end;
		export i__ds_zip :=
			interface(
				i__ds_zip0)
				export ds_zip :=
					if(exists(ds_zip0),
						ds_zip0,
						dataset([{0}],{integer4 zip}));
			end;
		export i__boolmakedataset :=
			interface
				export boolean boolmakedataset := true;
			end;
		export i__company_name_value :=
			interface(
				i__comp_name_value)
				export string120 company_name_value := comp_name_value;
			end;
		export i__precs :=
			interface(
				i__boolmakedataset,
				i__ds_zip,
				i__company_name_value,
				i__prange_value,
				i__predir_value,
				i__pname_value,
				i__addr_suffix_value,
				i__postdir_value,
				i__sec_range_value,
				i__city_value,
				i__state_value,
				i__phone_value,
				i__fein_val)
				export precs := if(
					boolmakedataset,
					project(ds_zip,
						transform(
							Business_Header_SS.Layout_BDID_InBatch,
							self.seq := 0,
							self.company_name := company_name_value,
							self.prim_range := prange_value,
							self.predir := predir_value,
							self.prim_name := pname_value,
							self.addr_suffix := addr_suffix_value,
							self.postdir := postdir_value,
							self.sec_range := sec_range_value,
							self.p_city_name := city_value,
							self.st := state_value,
							self.z5 := (qstring5)left.zip,
							self.phone10 := phone_value,
							self.fein := fein_val)));
			end;
		export i__bdid_val :=
			interface(
				gl_rewrites.parameter_interfaces.p__BDID)
				export string bdid_val := parm_BDID;
			end;
		export i__use_Supergroup :=
			interface(
				gl_rewrites.parameter_interfaces.p__useSupergroup,
				i__bdid_val)
				shared boolean multiBDID := (bdid_val[1] = '{');
				export boolean use_Supergroup := (not multiBDID) and parm_useSupergroup;
			end;
		export i__use_levels_val :=
			interface(
				gl_rewrites.parameter_interfaces.p__useLevels)
				export use_levels_val := parm_useLevels;
			end;
		export i__bdid_dataset :=
			interface(
				i__use_Supergroup,
				i__bdid_value,
				i__use_levels_val,
				i__bdid_val)
				shared boolean multiBDID := (bdid_val[1] = '{');
				shared supergroup_ds := business_header.getSupergroup(bdid_value,use_levels_val);
				shared pattern bdidlistval := pattern('[0-9]*');
				shared pattern bdidpatt := ('{' or ',') bdidlistval before (',' or '}');
				shared rec := {unsigned6 bdid := (unsigned6)matchtext(bdidlistval)};
				shared rec slimit(supergroup_ds l) := transform
					self := l;
				end;
				export bdid_dataset :=
					if(multiBDID,
						parse(dataset([{bdid_val}],{string bdidlist}),bdidlist,bdidpatt,rec,scan),
						if(use_Supergroup,
							project(supergroup_ds,slimit(left)),
							dataset([bdid_value],rec)));
						end;
		export i__exact_only :=
			interface(
				gl_rewrites.parameter_interfaces.p__ExactOnly)
				export boolean exact_only := parm_ExactOnly;
			end;
		export i__company_name_val :=
			interface(
				i__company_name)
				export string120 company_name_val := company_name;
			end;
		export i__adl_service_ip :=
			interface(
				gl_rewrites.parameter_interfaces.p__SeisintAdlService)
				export string100 adl_service_ip := parm_SeisintAdlService;
			end;
		export i__lname_wild :=
			interface(
				i__lname_value)
				export boolean lname_wild :=
					Stringlib.StringFind(lname_value, '*', 1) <> 0 or
					Stringlib.StringFind(lname_value, '?', 1) <> 0;
			end;
		export i__lname_wild_val :=
			interface(
				i__lname_value)
				export lname_wild_val := lname_value;
			end;
		export i__lname4_val :=
			interface(
				gl_rewrites.parameter_interfaces.p__Lname4)
				export string4 lname4_val := parm_Lname4;
			end;
		export i__lname4_value :=
			interface(
				i__lname4_val)
				export lname4_value := stringlib.stringtouppercase(lname4_val);
			end;
		export i__lnameIn :=
			interface(
				i__lname_value,
				i__lname4_value)
				export lnameIn := if(lname_value != '',lname_value,lname4_value);
			end;
		export i__lnameIn_clean :=
			interface(
				i__lnameIn)
				export lnameIn_clean := ut.AlphasOnly(lnameIn);
			end;
		export i__fname_wild :=
			interface(
				i__fname_value)
				export boolean fname_wild :=
					Stringlib.StringFind(fname_value, '*', 1) <> 0 or
					Stringlib.StringFind(fname_value, '?', 1) <> 0;
			end;
		export i__fname_wild_val :=
			interface(
				i__fname_value)
				export fname_wild_val := fname_value;
			end;
		export i__fname3_val :=
			interface(
				gl_rewrites.parameter_interfaces.p__Fname3)
				export string3 fname3_val := parm_Fname3;
			end;
		export i__fname3_value :=
			interface(
				i__fname3_val)
				export fname3_value := stringlib.stringtouppercase(fname3_val);
			end;
		export i__fnameIn :=
			interface(
				i__fname_value,
				i__fname3_value)
				export fnameIn := if(fname_value != '' ,fname_value,fname3_value);
			end;
		export i__fnameIn_clean :=
			interface(
				i__fnameIn)
				export fnameIn_clean := ut.AlphasOnly(fnameIn);
			end;
		export i__ln_branded_value :=
			interface(
				gl_rewrites.parameter_interfaces.p__LnBranded)
				export boolean ln_branded_value := parm_LnBranded;
			end;
		export i__non_exclusion_val :=
			interface(
				gl_rewrites.parameter_interfaces.p__NonExclusion)
				export boolean non_exclusion_val := parm_NonExclusion;
			end;
		export i__non_exclusion_value :=
			interface(
				i__non_exclusion_val,
				i__ln_branded_value)
				export boolean non_exclusion_value := non_exclusion_val or ln_branded_value;
			end;
		export i__ssn_long_value :=
			interface(
				gl_rewrites.parameter_interfaces.p__ssn)
				export string11 ssn_long_value := parm_ssn;
			end;
		export i__ssn_filtered_value :=
			interface(
				i__ssn_long_value)
				export ssn_filtered_value := Stringlib.StringFilterOut(ssn_long_value,'-');
			end;
		export i__ssn_value_reg :=
			interface(
				i__ssn_filtered_value)
				export string9 ssn_value_reg := IF(
					count(CHOOSEN(doxie.Key_PullSSN(ssn_filtered_value<>'' AND doxie.Key_PullSSN.ssn=ssn_filtered_value), 1)) > 0,
					'',
					ssn_filtered_value);
			end;
		export i__ssn_value :=
			interface(
				i__isfcra,
				i__ssn_filtered_value,
				i__ssn_value_reg)
				export string9 ssn_value := IF(IsFCRA,ssn_filtered_value,ssn_value_reg);
			end;
		export i__county_val :=
			interface(
				gl_rewrites.parameter_interfaces.p__County)
				export string30 county_val := parm_County;
			end;
		export i__county_value :=
			interface(
				i__county_val)
				export county_value := stringlib.stringtouppercase(county_val);
			end;
		export i__rid_value :=
			interface(
				gl_rewrites.parameter_interfaces.p__rid)
				export string14 rid_value := parm_rid;
			end;
		export i__isCRS :=
			interface(
				gl_rewrites.parameter_interfaces.p__isCrs)
				export boolean isCRS := parm_isCrs;
			end;
		export i__SearchGoodSSNOnly_value :=
			interface(
				gl_rewrites.parameter_interfaces.p__SearchGoodSSNOnly)
				export boolean SearchGoodSSNOnly_value := parm_SearchGoodSSNOnly;
			end;
		export i__SearchIgnoresAddressOnly_value :=
			interface(
				gl_rewrites.parameter_interfaces.p__SearchIgnoresAddressOnly)
				export boolean SearchIgnoresAddressOnly_value := parm_SearchIgnoresAddressOnly;
			end;
		export i__Penalt_Threshold :=
			interface(
				gl_rewrites.parameter_interfaces.p__PenaltThreshold)
				export unsigned2 penalt_threshold := parm_PenaltThreshold;
			end;
		export i__any_addr_error_value :=
			interface(
				i__clean_address)
				export any_addr_error_value := clean_address[179..179]='E';
			end;
		export i__date_first_seen_value :=
			interface(
				gl_rewrites.parameter_interfaces.p__DateFirstSeen)
				export unsigned3 date_first_seen_value := parm_DateFirstSeen;
			end;
		export i__date_last_seen_value :=
			interface(
				gl_rewrites.parameter_interfaces.p__DateLastSeen)
				export unsigned3 date_last_seen_value := parm_DateLastSeen;
			end;
		export i__allow_date_seen_value :=
			interface(
				gl_rewrites.parameter_interfaces.p__AllowDateSeen)
				export boolean allow_date_seen_value := parm_AllowDateSeen;
			end;
		export i__is_wildcard_search :=
			interface(
				i__fname_wild,
				i__lname_wild,
				i__addr_wild,
				i__pname_wild)
				export boolean is_wildcard_search := fname_wild or lname_wild or addr_wild or pname_wild;
			end;
		export i__allow_wildcard_val :=
			interface(
				gl_rewrites.parameter_interfaces.p__AllowWildcard)
				export boolean allow_wildcard_val := parm_AllowWildcard;
			end;
		export i__is_inv_wildcard :=
			interface(
				i__lname_value,
				i__fname_value,
				i__pname_val)
				export boolean is_inv_wildcard :=
					(Stringlib.StringFind(lname_value, '*', 1) in [1,2,3]) or 
					(Stringlib.StringFind(lname_value, '?', 1) in [1,2,3]) or   
					(Stringlib.StringFind(fname_value, '*', 1) in [1,2,3]) or 
					(Stringlib.StringFind(fname_value, '?', 1) in [1,2,3]) or   
					(Stringlib.StringFind(pname_val, '*', 1) in [1,2,3]) or    
					(Stringlib.StringFind(pname_val, '?', 1) in [1,2,3]);
			end;
		export i__use_onlybestdid :=
			interface(
				gl_rewrites.parameter_interfaces.p__UseOnlyBestDID)
				export boolean use_onlybestdid := parm_UseOnlyBestDID;
			end;
		export i__ssn_set :=
			interface(
				i__ssn_value)
				export ssn_set := doxie.typossn(ssn_value);
			end;
		export i__keep_old_ssns_val :=
			interface(
				gl_rewrites.parameter_interfaces.p__KeepOldSsns,
				gl_rewrites.parameter_interfaces.p__UsingKeepSSNs)
				export keep_old_ssns_val := ~parm_UsingKeepSSNs or parm_KeepOldSsns;
			end;
		export i__whole_house :=
			interface(
				gl_rewrites.parameter_interfaces.p__Household)
				export boolean whole_house := parm_Household;
			end;
		export i__dppa_purpose :=
			interface(
				gl_rewrites.parameter_interfaces.p__AllowAll,
				gl_rewrites.parameter_interfaces.p__AllowDPPA,
				gl_rewrites.parameter_interfaces.p__DPPAPurpose)
				export unsigned1 dppa_purpose := if(parm_AllowDPPA or parm_AllowAll,255,parm_DPPAPurpose);
			end;
		export i__glb_purpose :=
			interface(
				gl_rewrites.parameter_interfaces.p__AllowAll,
				gl_rewrites.parameter_interfaces.p__AllowGLB,
				gl_rewrites.parameter_interfaces.p__GLBPurpose)
				export unsigned1 glb_purpose := if(parm_AllowGLB or parm_AllowAll,255,parm_GLBPurpose);
			end;
		export i__maxresults_val :=
			interface(
				gl_rewrites.parameter_interfaces.p__MaxResults)
				export unsigned8 maxresults_val := parm_MaxResults;
			end;
		export i__skiprecords_val :=
			interface(
				gl_rewrites.parameter_interfaces.p__SkipRecords)
				export unsigned8 skiprecords_val := parm_SkipRecords;
			end;
		export i__maxresultsthistime_val :=
			interface(
				gl_rewrites.parameter_interfaces.p__MaxResultsThisTime)
				export unsigned8 maxresultsthistime_val := parm_MaxResultsThisTime;
			end;
	end;
	