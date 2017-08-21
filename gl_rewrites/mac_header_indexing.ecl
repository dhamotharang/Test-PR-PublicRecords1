Export Mac_Header_Indexing := MODULE

	export gen_filt(inkey) :=MACRO
			(in_parms.prev_state_val1='' or ut.bit_test(inkey.states,ut.St2Code(in_parms.prev_state_val1))) AND
		  (in_parms.prev_state_val2='' or ut.bit_test(inkey.states,ut.St2Code(in_parms.prev_state_val2))) AND
		  (in_parms.other_lname_value1[1]='' or ut.bit_test(inkey.lname1,ut.Chr2Code(in_parms.other_lname_value1[1]))) AND
		  (in_parms.other_lname_value1[2]='' or ut.bit_test(inkey.lname2,ut.Chr2Code(in_parms.other_lname_value1[2]))) AND
		  (in_parms.other_lname_value1[3]='' or ut.bit_test(inkey.lname3,ut.Chr2Code(in_parms.other_lname_value1[3]))) AND
		  (in_parms.other_city_value[1]='' or ut.bit_test(inkey.city1,ut.Chr2Code(in_parms.other_city_value[1]))) AND
		  (in_parms.other_city_value[2]='' or ut.bit_test(inkey.city2,ut.Chr2Code(in_parms.other_city_value[2]))) AND
		  (in_parms.other_city_value[3]='' or ut.bit_test(inkey.city3,ut.Chr2Code(in_parms.other_city_value[3]))) AND
		  (in_parms.rel_fname_value1[1]='' or ut.bit_test(inkey.rel_fname1,ut.Chr2Code(in_parms.rel_fname_value1[1]))) AND
		  (in_parms.rel_fname_value1[2]='' or ut.bit_test(inkey.rel_fname2,ut.Chr2Code(in_parms.rel_fname_value1[2]))) AND
		  (in_parms.rel_fname_value1[3]='' or ut.bit_test(inkey.rel_fname3,ut.Chr2Code(in_parms.rel_fname_value1[3]))) AND
		  (in_parms.rel_fname_value2[1]='' or ut.bit_test(inkey.rel_fname1,ut.Chr2Code(in_parms.rel_fname_value2[1]))) AND
		  (in_parms.rel_fname_value2[2]='' or ut.bit_test(inkey.rel_fname2,ut.Chr2Code(in_parms.rel_fname_value2[2]))) AND
		  (in_parms.rel_fname_value2[3]='' or ut.bit_test(inkey.rel_fname3,ut.Chr2Code(in_parms.rel_fname_value2[3])))
	ENDMACRO;

	Export gen_withdobfilt(inkey,gen_fil,findmonth = TRUE) :=MACRO
		gen_fil := (((in_parms.find_month=0 or (inkey.dob div 100) % 100=in_parms.find_month) AND
		    // if record in the key has a DOB with a 00 or 01 day, don't cause a mismatch 
				(in_parms.find_day=0 or inkey.dob % 100 in [0, 1] or inkey.dob % 100=in_parms.find_day)) OR findmonth=FALSE) AND
        mac_header_Indexing.gen_filt(inkey) AND
				(in_parms.find_year_low=0 or inkey.dob div 10000>=in_parms.find_year_low) AND
				(in_parms.find_year_high=0 or inkey.dob div 10000<=in_parms.find_year_high) AND
				(in_parms.lookup_value=0 OR ut.bit_test(inkey.lookups, in_parms.lookup_value));
	ENDMACRO;


	Export gen_nodobfilt(inkey,gen_fil) :=MACRO

		gen_fil := mac_header_Indexing.gen_filt(inkey) AND (in_parms.lookup_value=0 OR ut.bit_test(inkey.lookups, in_parms.lookup_value));

	ENDMACRO;



	Export pref(inkey,pref_fil):=Macro
		#uniqueName(pfe)

		%pfe%(string20 l, string20 r) := l[1..length(trim(datalib.preferredfirst(r)))]=datalib.preferredfirst(r);

		pref_fil := %pfe%(inkey.pfname,in_parms.fname_value);

	ENDMACRO;
	
	Export phon(inkey,phon_fil) :=MACRO
	
	phon_fil := inkey.dph_lname=(string6)metaphonelib.DMetaPhone1(in_parms.lname_value);
	
	ENDMACRO;
	

	Export lname_fname(inkey,lname_fil,fname_fil) :=MACRO
	
	lname_fil := inkey.lname=in_parms.lname_value;
	fname_fil := inkey.fname[1..length(trim(in_parms.fname_value))]=in_parms.fname_value;// OR nicknames;
	
	ENDMACRO;

	
	Export mname_yob_ssn4(inkey,mname_fil,yob_fil,ssn4_fil) :=MACRO
	
	mname_fil := in_parms.mname_value='' or (string1)in_parms.mname_value[1]=inkey.minit;
	yob_fil := inkey.yob>=(unsigned2)in_parms.find_year_low AND 
						 inkey.yob<=IF((unsigned2)in_parms.find_year_high != 0, (unsigned2)in_parms.find_year_high, (unsigned2)0xFFFF);
	ssn4_fil := (unsigned2)in_parms.ssn_value=inkey.s4;
	ENDMACRO;

	
	Export state(inkey,state_fil) :=MACRO
	state_fil :=inkey.st=in_parms.state_value OR in_parms.state_value='';	
	ENDMACRO;

	
	Export Zip(inkey,zip_fil):=MACRO
	zip_fil :=inkey.zip IN in_parms.zip_value;	
	ENDMACRO;

	
	EXPORT pname(inkey,pname_fil):=MACRO
	pname_fil :=inkey.prim_name=in_parms.pname_value;	
	ENDMACRO;
	
	EXPORT Zip1(inkey,zip1_fil):=MACRO
	zip1_fil := ((integer4)in_parms.zip_val<>0 AND inkey.zip = (integer4)in_parms.zip_val) OR 
						((integer4)in_parms.city_zip_value<>0 AND inkey.zip = (integer4)in_parms.city_zip_value);	
	
	ENDMACRO;
	
END;
