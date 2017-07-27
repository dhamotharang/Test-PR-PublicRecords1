IMPORT ut, doxie, autokey, AutoKeyI;

export FetchZip (String keyNameRoot, boolean workHard,boolean aNoFail = true) := function

	companyIdSet := Functions.getCompanyIdSet();

	doxie.MAC_Header_Field_Declare ();
	
	i := autokey.Key_Zip(keyNameRoot);

	AutoKey.layout_fetch xt(i r) := TRANSFORM
						SELF := r;
	END;

	// enable 'starts with' matching on the input fname *and* safeguard against invalid subrange exception
	castFname := trim(ut.cast2keyfield(i.fname,fname_value));

	f_raw := i(zip_value<>[] AND (pname_value='' OR addr_error_value OR SearchAroundAddress_value) AND 
			((workHard and not isCRS and comp_name_value = '') or (lname_value <> '')),//dont allow blank lname if this is really a company search
			keyed(zip IN zip_value),
			keyed(dph_lname=metaphonelib.DMetaPhone1(lname_value)[1..6] OR (lname_value='' and workHard)),
			keyed((lname in lname_set_value_20 OR ((phonetics OR lname_value='') and workHard))),
			keyed(AutoKeyI.Functions.PrefFirstMatch(pfname,fname_value) OR (LENGTH(TRIM(fname_value))<2) and workHard),
			keyed(fname[1..length(castFname)]=castFname OR nicknames), 
			wild(minit), // todo: get rid of
			keyed(yob>=(unsigned2)find_year_low AND 
			yob<=IF((unsigned2)find_year_high != 0, (unsigned2)find_year_high, (unsigned2)0xFFFF)),
			find_month=0	or ((dob div 100) % 100) in [0, 1, find_month],
			find_day=0		or (dob % 100) in [0, 1, find_day],												
			lookups in CompanyIdSet);

	f := project(f_raw, xt(LEFT));
			
	nofail := aNoFail;
					
	AutoKey.mac_Limits(f,f_ret)	;
													
	RETURN f_ret;
end;