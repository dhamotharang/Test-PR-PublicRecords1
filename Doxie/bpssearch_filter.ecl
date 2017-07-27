import AutoStandardI, ut, NID;

EXPORT bpssearch_filter := MODULE

	shared in_mod := AutoStandardI.GlobalModule();
	shared ssn_value := AutoStandardI.InterfaceTranslator.ssn_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.ssn_value.params));
	shared addr_wild := AutoStandardI.InterfaceTranslator.addr_wild.val(project(in_mod,AutoStandardI.InterfaceTranslator.addr_wild.params));
	shared addr_range := AutoStandardI.InterfaceTranslator.addr_range.val(project(in_mod,AutoStandardI.InterfaceTranslator.addr_range.params));
	shared prange_value := AutoStandardI.InterfaceTranslator.prange_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.prange_value.params));
	shared prange_beg_value := AutoStandardI.InterfaceTranslator.prange_beg_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.prange_beg_value.params));
	shared prange_end_value := AutoStandardI.InterfaceTranslator.prange_end_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.prange_end_value.params));
	shared prange_wild_value := AutoStandardI.InterfaceTranslator.prange_wild_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.prange_wild_value.params));
	shared pname_value := AutoStandardI.InterfaceTranslator.pname_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.pname_value.params));
	shared addr_suffix_value := AutoStandardI.InterfaceTranslator.addr_suffix_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.addr_suffix_value.params));
	shared sec_range_value := AutoStandardI.InterfaceTranslator.sec_range_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.sec_range_value.params));
	shared city_value := AutoStandardI.InterfaceTranslator.city_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.city_value.params));
	shared state_value := AutoStandardI.InterfaceTranslator.state_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.state_value.params));
	shared zipradius_value := AutoStandardI.InterfaceTranslator.zipradius_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.zipradius_value.params));
	shared zip_val := AutoStandardI.InterfaceTranslator.zip_val.val(project(in_mod,AutoStandardI.InterfaceTranslator.zip_val.params));
	shared zip_value := AutoStandardI.InterfaceTranslator.zip_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.zip_value.params));
	shared fname_trailing := AutoStandardI.InterfaceTranslator.fname_trailing_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.fname_trailing_value.params));
	shared lname_trailing := AutoStandardI.InterfaceTranslator.lname_trailing_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.lname_trailing_value.params));
	shared nicknames := AutoStandardI.InterfaceTranslator.nicknames.val(project(in_mod,AutoStandardI.InterfaceTranslator.nicknames.params));
	shared phonetics := AutoStandardI.InterfaceTranslator.phonetics.val(project(in_mod,AutoStandardI.InterfaceTranslator.phonetics.params));
	shared lname_value := AutoStandardI.InterfaceTranslator.lname_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.lname_value.params));
	shared lname_set_value := AutoStandardI.InterfaceTranslator.lname_set_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.lname_set_value.params));
	shared cleaned_lname_value := AutoStandardI.InterfaceTranslator.cleaned_input_lname.val(project(in_mod,AutoStandardI.InterfaceTranslator.cleaned_input_lname.params));
	shared fname_value := AutoStandardI.InterfaceTranslator.fname_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.fname_value.params));
	shared fname_set_value := AutoStandardI.InterfaceTranslator.fname_set_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.fname_set_value.params));
	shared mname_value := AutoStandardI.InterfaceTranslator.mname_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.mname_value.params));
	shared dob_val := AutoStandardI.InterfaceTranslator.dob_val.val(project(in_mod,AutoStandardI.InterfaceTranslator.dob_val.params));
	shared agelow_val := AutoStandardI.InterfaceTranslator.agelow_val.val(project(in_mod,AutoStandardI.InterfaceTranslator.agelow_val.params));
	shared agehigh_val := AutoStandardI.InterfaceTranslator.agehigh_val.val(project(in_mod,AutoStandardI.InterfaceTranslator.agehigh_val.params));
	shared phone_value := AutoStandardI.InterfaceTranslator.phone_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.phone_value.params));
	
	shared unsigned8 todays_date := (unsigned8)Stringlib.getDateYYYYMMDD();
	shared unsigned8 temp_dob_range_low := if(agehigh_val = 0, 19000101,
											((todays_date div 10000 - agehigh_val - 1) * 10000) + ((todays_date % 10000) + 1));
	shared unsigned8 temp_dob_range_high := if(agelow_val = 0, todays_date,
											 ((todays_date div 10000 - agelow_val) * 10000) + (todays_date % 10000));

	shared dobMatch(unsigned4 dv, unsigned4 db) := FUNCTION
		in_year := dv div 10000;
		in_month := (dv div 100) % 100;

		year := db div 10000;
		month := (db div 100) % 100;		

		match := ut.NNEQ_Int((string)in_year, (string) year) and ut.NNEQ_Int((string)in_month, (string) month);
		return match;
	end;
  
	shared useSSnPartialFetch := AutoStandardI.InterfaceTranslator.ssnfallback_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.ssnfallback_value.params));
	shared	ssn_equiv(string ssn1, string ssn2) :=  (unsigned)ssn2<>0 and
			                     ((ssn1 = ssn2)
			                      OR
	                         (useSSnPartialFetch 
													 and
													 ((unsigned)ssn1 % 10000 = (unsigned)ssn2 % 10000 
													 OR 
													 (unsigned)ssn1 div 10000 = (unsigned)ssn2 div 10000
													 )) 
			                     OR
													 ((unsigned)ssn1 % 10000 = (unsigned)ssn2 % 10000 AND 
													 (((unsigned)ssn1 div 10000) = 0 OR ((unsigned)ssn2 div 10000) = 0))
													 OR
													 // need to handle a first5 SSN input value
													 (length(trim(ssn1)) = 5 AND (unsigned)ssn1 = (unsigned)ssn2 div 10000)
													 );

	shared PrefFirstMatch(string20 l, string20 r) :=
	  NID.mod_PFirstTools.SUBPFLeqPFR(l,r) or NID.mod_PFirstTools.SUBPFLeqR(l,r);
		
	shared zipsWithinCity(string2 st, string25 city) := FUNCTION
		tst := trim(st);
		tcity := trim(city);
		azip := ziplib.CityToZip5(tst,tcity);

		set_acircle := ziplib.ZipsWithinRadius(azip, 50);

		ds_acircle := dataset(set_acircle,{integer4 zip});

		acity := ds_acircle(stringlib.StringFind(ziplib.ZipToCities((string5)zip),tcity, 1)>0);
		return acity;
	END;
	
	shared tmp_rec := RECORD
		integer4 zip;
	END;
	
	shared tmp_rec checkCityName(tmp_rec l, string25 city) := TRANSFORM
		self.zip := if(stringlib.StringFind(ziplib.ZipToCities((string5)l.zip),trim(city), 1)>0, l.zip, skip);
	END;
	
	shared equiv_cities(string25 city1, string2 st1, string25 city2) := FUNCTION
			city1_zips := ZipsWithinCity(st1, city1);
			any_city_matches := project(city1_zips, checkCityName(LEFT, city2));
			return exists(any_city_matches);
	end;
	
	shared phoneMatch(string phone, string in_phone) := FUNCTION
		len_in := length(trim(in_phone));
		len_phone := length(trim(phone));
		len_diff := if (len_phone - len_in > 0, len_phone - len_in, 0);
		return phone[len_diff+1..] = in_phone;
	END;

						
	export rec_OK(string ssn_field, string lname_field, string fname_field, string mname_field, 
								string prim_range_field, string prim_name_field, string suffix_field,
								string sec_range_field, string city_name_field, string zip_field,
								string phone_field, string listed_phone_field,
								integer4 dob_field) := FUNCTION
		
		rec_ok := 
			((ssn_value = '' or ssn_equiv(ssn_value, ssn_field)) and
			(lname_value = '' or phonetics	or 
				(lname_trailing and 
				(lname_field[1..length(trim(lname_value))] = lname_value or 
				 lname_field[1..length(trim(cleaned_lname_value))] = cleaned_lname_value)) or
			 lname_field in lname_set_value) and
			(fname_value = '' or 
				(nicknames and (PrefFirstMatch(fname_field,fname_value))) or 
				(fname_trailing and fname_field[1..length(trim(fname_value))] = fname_value) or
			 fname_field in fname_set_value) and 
			(mname_value = '' or mname_field[1..length(trim(mname_value))] = mname_value) and
			((addr_wild and Stringlib.StringWildMatch(prim_range_field, prange_wild_value, true)) or
			(addr_range and ((integer)prim_range_field between (integer)prange_beg_value and (integer)prange_end_value)) or 
			(prange_value = '' or prim_range_field = prange_value)) and 
			(pname_value = '' or doxie.StripOrdinal(prim_name_field) = pname_value) and
			 ut.NNEQ(suffix_field, addr_suffix_value) and
			 ut.NNEQ(sec_range_field, sec_range_value)) and
			// disable city filter if zip_radius entered
			(city_value = '' or state_value = '' or city_name_field = '' or city_value = city_name_field or 
			 zipradius_value <> 0 or (equiv_cities(city_value, state_value, city_name_field))) and
			 // do a zip match if zip was in the input criteria; do a zipset match if zip radius present
			(ut.NNEQ(zip_val, zip_field) or (zipradius_value <> 0 and (integer4) zip_field in zip_value)) and
			(phone_value = '' or phoneMatch(phone_field,phone_value) or 
			phoneMatch(listed_phone_field,phone_value)) and
			(dob_val = 0 or dobMatch(dob_val, dob_field)) and
			((agelow_val = 0 and agehigh_val = 0) or dob_val <> 0 or 
				dob_field between temp_dob_range_low and temp_dob_range_high);
		
		return rec_ok;
	END;
END;