import ut, NID;

Export MAC_indexing := MODULE

	export gen_filt(inkey) :=MACRO
			(temp_prev_state_val1='' or ut.bit_test(inkey.states,ut.St2Code(temp_prev_state_val1))) AND
		  (temp_prev_state_val2='' or ut.bit_test(inkey.states,ut.St2Code(temp_prev_state_val2))) AND
		  (temp_other_lname_value1[1]='' or ut.bit_test(inkey.lname1,ut.Chr2Code(temp_other_lname_value1[1]))) AND
		  (temp_other_lname_value1[2]='' or ut.bit_test(inkey.lname2,ut.Chr2Code(temp_other_lname_value1[2]))) AND
		  (temp_other_lname_value1[3]='' or ut.bit_test(inkey.lname3,ut.Chr2Code(temp_other_lname_value1[3]))) AND
		  (temp_other_city_value[1]='' or ut.bit_test(inkey.city1,ut.Chr2Code(temp_other_city_value[1]))) AND
		  (temp_other_city_value[2]='' or ut.bit_test(inkey.city2,ut.Chr2Code(temp_other_city_value[2]))) AND
		  (temp_other_city_value[3]='' or ut.bit_test(inkey.city3,ut.Chr2Code(temp_other_city_value[3]))) AND
		  (temp_rel_fname_value1[1]='' or ut.bit_test(inkey.rel_fname1,ut.Chr2Code(temp_rel_fname_value1[1]))) AND
		  (temp_rel_fname_value1[2]='' or ut.bit_test(inkey.rel_fname2,ut.Chr2Code(temp_rel_fname_value1[2]))) AND
		  (temp_rel_fname_value1[3]='' or ut.bit_test(inkey.rel_fname3,ut.Chr2Code(temp_rel_fname_value1[3]))) AND
		  (temp_rel_fname_value2[1]='' or ut.bit_test(inkey.rel_fname1,ut.Chr2Code(temp_rel_fname_value2[1]))) AND
		  (temp_rel_fname_value2[2]='' or ut.bit_test(inkey.rel_fname2,ut.Chr2Code(temp_rel_fname_value2[2]))) AND
		  (temp_rel_fname_value2[3]='' or ut.bit_test(inkey.rel_fname3,ut.Chr2Code(temp_rel_fname_value2[3])))
	ENDMACRO;

	Export gen_withdobfilt(inkey,gen_fil,findmonth = TRUE) :=MACRO
		gen_fil := (((temp_find_month=0 or (inkey.dob div 100) % 100=temp_find_month) AND
		    // if record in the key has a DOB with a 00 or 01 day, don't cause a mismatch 
				(temp_find_day=0 or inkey.dob % 100 in [0, 1] or inkey.dob % 100=temp_find_day)) OR findmonth=FALSE) AND
        AutoHeaderV2.MAC_indexing.gen_filt(inkey) AND
				(temp_find_year_low=0 or inkey.dob div 10000>=temp_find_year_low) AND
				(temp_find_year_high=0 or inkey.dob div 10000<=temp_find_year_high);
	ENDMACRO;


	Export gen_nodobfilt(inkey,gen_fil) :=MACRO
    import AutoheaderV2;
		gen_fil := AutoheaderV2.mac_indexing.gen_filt(inkey);

	ENDMACRO;

	Export dob(inkey, dob_fil, findmonth = TRUE) :=MACRO
				dob_fil := (((temp_find_month=0 or (inkey.dob div 100) % 100=temp_find_month) AND
		    // if record in the key has a DOB with a 00 or 01 day, don't cause a mismatch 
				(temp_find_day=0 or inkey.dob % 100 in [0, 1] or inkey.dob % 100=temp_find_day)) OR findmonth=FALSE) AND
				(temp_find_year_low=0 or inkey.dob div 10000>=temp_find_year_low) AND
				(temp_find_year_high=0 or inkey.dob div 10000<=temp_find_year_high);
	ENDMACRO;

	Export pref(inkey,pref_fil):=Macro
		#uniqueName(pfe)

		%pfe%(string20 l, string20 r) := NID.mod_PFirstTools.SubLinPFR(l,r);

		pref_fil := %pfe%(inkey.pfname,temp_fname_value);

	ENDMACRO;
	
	Export phon(inkey,phon_fil) :=MACRO
		import lib_metaphone;
	
	phon_fil := inkey.dph_lname=(string6)metaphonelib.DMetaPhone1(temp_lname_value);
	
	ENDMACRO;
	
  // if UsePhoneticDistance=true, filters out records, which are too different from the input string: 
  // LNamePhoneticSet -- set of names having same phonetization, but weeded by (configurable) distance threshold
  Export phon_dist (inkey, phon_fil) := MACRO
		import lib_metaphone;
    phon_fil := ((inkey.dph_lname=(string6)metaphonelib.DMetaPhone1(temp_lname_value)) AND
                 (~temp_UsePhoneticDistance OR (inkey.lname IN temp_LNamePhoneticSet)));
  ENDMACRO;

	Export lname_fname(inkey,lname_fil,fname_fil) :=MACRO
	  // enable 'starts with' matching on the input lname *and* safeguard against invalid subrange exception
#uniquename(castLname)
    %castLname% := trim(ut.cast2keyfield(inkey.lname,temp_lname_value));
    lname_fil := inkey.lname IN temp_lname_set_value or (temp_BpsLeadingNameMatch_value and temp_lname_trailing_value and 
								 inkey.lname[1..length(%castLname%)] = %castLname%);

		// enable 'starts with' matching on the input fname *and* safeguard against invalid subrange exception
		// need to disable 'starts with' matching if BpsLeadingNameMatch and not trailing_fname (bpssearch)
#uniquename(castFname)
    %castFname% := trim(ut.cast2keyfield(inkey.fname,temp_fname_value));
     fname_fil := temp_fname_set_value = [] or inkey.fname IN temp_fname_set_value or 
		 ((not temp_BpsLeadingNameMatch_value or temp_fname_trailing_value) and inkey.fname[1..length(%castFname%)] = %castFname%);
	ENDMACRO;

	
	Export mname_yob_ssn4(inkey,mname_fil,yob_fil,ssn4_fil) :=MACRO
	
	mname_fil := temp_mname_value='' or (string1)temp_mname_value[1]=inkey.minit;
	yob_fil := inkey.yob>=(unsigned2)temp_find_year_low AND 
						 inkey.yob<=IF((unsigned2)temp_find_year_high != 0, (unsigned2)temp_find_year_high, (unsigned2)0xFFFF);
	ssn4_fil := (unsigned2)temp_ssn_value=inkey.s4;
	ENDMACRO;

	
	Export state(inkey,state_fil) :=MACRO
	state_fil :=inkey.st=temp_state_value OR temp_state_value='';	
	ENDMACRO;

	
	Export Zip(inkey,zip_fil):=MACRO
	zip_fil :=inkey.zip IN temp_zip_value;	
	ENDMACRO;

	
	EXPORT pname(inkey,pname_fil):=MACRO
	pname_fil :=inkey.prim_name=temp_pname_value;	
	ENDMACRO;
	
	EXPORT Zip1(inkey,zip1_fil):=MACRO
	zip1_fil := ((integer4)temp_zip_val<>0 AND inkey.zip = (integer4)temp_zip_val) OR 
						((integer4)temp_city_zip_value<>0 AND inkey.zip = (integer4)temp_city_zip_value);	
	
	ENDMACRO;
	
	EXPORT Piz(inkey,piz_fil):=MACRO
		piz_fil :=inkey.piz IN piz_value;	
	ENDMACRO;
	
END;
