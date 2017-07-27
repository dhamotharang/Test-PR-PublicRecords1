IMPORT ut, doxie, autokey, AutoKeyI;

export FetchStName (String keyNameRoot, boolean workHard,boolean aNoFail = true) := FUNCTION

	companyIdSet := Functions.getCompanyIdSet();
			
	doxie.MAC_Header_Field_Declare ();

	nameKey := AutoKey.Key_StName(keyNameRoot);
				
	AutoKey.layout_fetch xt(nameKey r) := TRANSFORM
								SELF := r;
	END;

	smok(string mst) := mst='' or ut.bit_test(nameKey.states,ut.St2Code(mst));

	// enable 'starts with' matching on the input fname *and* safeguard against invalid subrange exception
	castFname := trim(ut.cast2keyfield(nameKey.fname,fname_value));

	f := project(
					nameKey(lname_value != '' AND state_value <> '' AND city_value='' AND zip_value=[] AND
					  length(trim(ssn_value)) <= 4,
					keyed(dph_lname=metaphonelib.DMetaPhone1(lname_value)[1..6]),
					keyed((lname in lname_set_value OR (phonetics and workHard))),
					keyed(AutoKeyI.Functions.PrefFirstMatch(pfname,fname_value) OR (LENGTH(TRIM(fname_value))<2 and workHard)),
					keyed(fname[1..length(castFname)]= castFname OR (nicknames AND LENGTH(TRIM(fname_value))>=2)),
					keyed((st=state_value)),					
					keyed(mname_value='' or workHard or (string1)mname_value[1]=minit ),
					keyed(yob>=(unsigned2)find_year_low AND 
								yob<=IF((unsigned2)find_year_high != 0, (unsigned2)find_year_high, (unsigned2)0xFFFF)),
					keyed(ssn_value='' or (unsigned2)ssn_value=s4),
					wild(dob),
					find_month=0 or ((dob div 100) % 100) in [0, 1, find_month],
					find_day=0 or (dob % 100) in [0, 1, find_day],
					wild(zip),
					wild(states),
					wild(lname1),
					wild(lname2),
					wild(lname3),
					wild(city1),
					wild(city2),
					wild(city3),
					wild(rel_fname1),
					wild(rel_fname2),
					wild(rel_fname3), 
        keyed(lookups in companyIdSet))
					, xt(LEFT));
					
	nofail :=  aNofail;
			
	AutoKey.mac_Limits(f,f_ret);
												
	RETURN f_ret;	
end;
