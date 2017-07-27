IMPORT ut, doxie, autokey, AutoKeyI;

EXPORT FetchName (String keyNameRoot, boolean workHard,boolean aNoFail = true) := FUNCTION

	integer4 cp1 := 0 : stored('companyId_1');
	integer4 cp2 := 0 : stored('companyId_2');
	integer4 cp3 := 0 : stored('companyId_3');
	integer4 cp4 := 0 : stored('companyId_4');
	integer4 cp5 := 0 : stored('companyId_5');
	integer4 cp6 := 0 : stored('companyId_6');
	integer4 cp7 := 0 : stored('companyId_7');
	integer4 cp8 := 0 : stored('companyId_8');
	integer4 cp9 := 0 : stored('companyId_9');
	integer4 cp10 := 0 : stored('companyId_10');

	cpDs := dataset([cp1, cp2, cp3, cp4, cp5, cp6, cp7, cp8, cp9, cp10], {integer4 id});
	cpValid := cpDs(id > 0);

  set of integer4 companyIdSet:= set(cpValid, id);
	
	doxie.MAC_Header_Field_Declare ();

	nameKey := AutoKey.key_name(keyNameRoot);

	AutoKey.layout_fetch xt(nameKey r) := TRANSFORM
				SELF := r;
	END;

	// enable 'starts with' matching on the input fname *and* safeguard against invalid subrange exception
	castFname := trim(ut.cast2keyfield(nameKey.fname,fname_value));

	allresults := 
		 project(
				 nameKey(did_value = '' and lname_value != '' AND state_value = '' AND 
				   city_value = '' AND zip_value = [] AND can_poscode_value = '' AND phone_value = '' AND 
					 length(trim(ssn_value)) <= 4,
				keyed(dph_lname=metaphonelib.DMetaPhone1(lname_value)[1..6]),
				keyed((lname in lname_set_value_20 OR (phonetics and workHard))),
				keyed(AutoKeyI.Functions.PrefFirstMatch(pfname,fname_value) OR (LENGTH(TRIM(fname_value))<2) and workHard),
				keyed(fname[1..length(castFname)]= castFname OR (nicknames AND LENGTH(TRIM(fname_value))>=2)), 
				keyed(mname_value='' or workHard or (string1)mname_value[1]=minit ),
				keyed(yob>=(unsigned2)find_year_low AND 
						yob<=IF((unsigned2)find_year_high != 0, (unsigned2)find_year_high, (unsigned2)0xFFFF)),
				keyed(ssn_value='' or (unsigned2)ssn_value=s4),
				wild(dob),
				find_month=0 or ((dob div 100) % 100) in [0, 1, find_month],
				find_day=0 or (dob % 100) in [0, 1, find_day],
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
                                                                                                
        // keyed(ut.bit_test(lookups, in_mod.lookup_value))
        keyed(lookups in companyIdSet) 				
								
					)
			, xt(LEFT));

			nofail := aNofail;
			
			AutoKey.mac_Limits(allResults, results);

			RETURN results;
END;