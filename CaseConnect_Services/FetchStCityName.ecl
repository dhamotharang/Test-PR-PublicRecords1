IMPORT ut, doxie, autokey, AutoKeyI;

export FetchStCityName (String keyNameRoot, boolean workHard,boolean aNoFail = true) := function

	companyIdSet := Functions.getCompanyIdSet();

	doxie.MAC_Header_Field_Declare ();

	i := autokey.Key_CityStName(keyNameRoot);

	AutoKey.layout_fetch xt(i r) := TRANSFORM
															SELF := r;
																 END;
	smok(string2 st) := st='' or ut.bit_test(i.states,ut.St2Code(st));
			
	// enable 'starts with' matching on the input fname *and* safeguard against invalid subrange exception
	castFname := trim(ut.cast2keyfield(i.fname,fname_value));

	f :=  project(
					i(city_value != '' AND (pname_value='' OR addr_error_value) AND 
						((workHard and not isCRS and comp_name_value = '') or (lname_value <> '')), //dont allow blank lname if this is really a company search
			keyed(city_code in doxie.Make_CityCodes(city_value).rox),
			keyed(st=state_value OR (state_value='' and workHard)),   
			keyed(dph_lname=(string6)metaphonelib.DMetaPhone1(lname_value) OR (lname_value='' and workHard)),
			keyed(lname in lname_set_value OR ((phonetics OR lname_value='') and workHard)),
			keyed(AutoKeyI.Functions.PrefFirstMatch(pfname,fname_value) OR (LENGTH(TRIM(fname_value))<2 and workHard)),
			keyed(fname[1..length(castFname)]=castFname OR nicknames),           
			(dob div 10000) >=(unsigned2)find_year_low AND 
				(dob div 10000) <=IF((unsigned2)find_year_high != 0, (unsigned2)find_year_high, (unsigned2)0xFFFF),
			find_month=0 or ((dob div 100) % 100) in [0, 1, find_month],
			find_day=0 or (dob % 100) in [0, 1, find_day],
			lookups in CompanyIdSet)
								, xt(LEFT));
					
	nofail := aNofail;
			
	AutoKey.mac_Limits(f,f_ret);
												
	RETURN f_ret;
end;