
import AutokeyB2, ut;

export JoinConditions := module

// SEE ALSO: doxie.Mac_Header_Indexing for other join conditions **************************

	// ---[ FIRST NAME ]---
	
	export FNAME_NAIVE() := macro
		RIGHT.fname = LEFT.fname_value
	endmacro;
	
	export FNAME( keyfield_type ) := macro
		RIGHT.fname[1..length( TRIM((keyfield_type)LEFT.fname_value))] = TRIM((keyfield_type)LEFT.fname_value)
	endmacro;
	
	export FNAME_PREFERRED() := macro
		AutokeyI.Functions.PrefFirstMatch(RIGHT.pfname,LEFT.fname_value) 
	endmacro;
	
	export FNAME_PREFERRED_OR_WORKHARD() := macro
		JoinConditions.FNAME_PREFERRED() OR (LENGTH(TRIM(LEFT.fname_value)) < 2 and in_mod.workHard)
	endmacro;

	export ENOUGH_FNAME() := macro
		LENGTH(TRIM(LEFT.fname_value)) >= 2
	endmacro;

	// ---[ MIDDLE NAME ]---
	
	export MINIT() := macro
		(STRING1)LEFT.mname_value[1] = RIGHT.minit
	endmacro;

	// ---[ LAST NAME ]---	
	
	export LNAME() := macro
		RIGHT.lname[1..LENGTH(TRIM(LEFT.lname_value))] = LEFT.lname_value
	endmacro;
	
	export LNAME_METAPHONE() := macro
		RIGHT.dph_lname = metaphonelib.DMetaPhone1(LEFT.lname_value)[1..6]
	endmacro;
	
	export LNAME_IN_SET() := macro
		RIGHT.lname in LEFT.lname_set_value
	endmacro;
	
	export LNAME_IN_SET_20() := macro
		RIGHT.lname in LEFT.lname_set_value_20
	endmacro;
	
	// ---[ COMPANY NAME ]---
	
	export CNAME_INDIC() := macro
		RIGHT.cname_indic = LEFT.comp_name_indic_value
	endmacro;

	export CNAME_SEC() := macro
		RIGHT.cname_sec = LEFT.comp_name_sec_value
	endmacro;
	
	export CNAME_INDIC_MATCH() := macro
		AutokeyB2.is_CNameIndicMatch(RIGHT.cname_indic, LEFT.comp_name_indic_value)
	endmacro;	
	
	export CS100S_CURRENT() := macro
		ut.CS100S.current(RIGHT.cname_indic, RIGHT.cname_sec, LEFT.comp_name_indic_value, LEFT.comp_name_sec_value)
	endmacro;
	
	export COMPANY_NAME_VAL_FILT( keyfield_type ) := macro
		(keyfield_type)LEFT.company_name_val_filt_no_the = RIGHT.word[ 1..AutoKeyI.Functions.LENGTH_OF( (keyfield_type)LEFT.company_name_val_filt_no_the ) ]
	endmacro;
	
	export COMPANY_NAME_VAL_FILT2( keyfield_type ) := macro
		(keyfield_type)LEFT.company_name_val_filt2 = RIGHT.word[ 1..AutoKeyI.Functions.LENGTH_OF( (keyfield_type)LEFT.company_name_val_filt2 ) ]
	endmacro;

	export FUZZY_SEARCH_VAL( keyfield_type ) := macro
		(keyfield_type)LEFT.fuzzy_search_val = RIGHT.word[ 1..AutoKeyI.Functions.LENGTH_OF( (keyfield_type)LEFT.fuzzy_search_val ) ]
	endmacro;

	export FUZZY_SEARCH_VAL2( keyfield_type ) := macro
		(keyfield_type)LEFT.fuzzy_search_val2 = RIGHT.word[ 1..AutoKeyI.Functions.LENGTH_OF( (keyfield_type)LEFT.fuzzy_search_val2 ) ]
	endmacro;
	
	// ---[ DATE-OF-BIRTH, YEAR-OF-BIRTH ]---

	export DOB() := macro
		(LEFT.find_month=0	or ((RIGHT.dob div 100) % 100) in [0, 1, LEFT.find_month]) 
		AND
		(LEFT.find_day=0		or (RIGHT.dob % 100) in [0, 1, LEFT.find_day])
	endmacro;
	
	export YOB() := macro
		RIGHT.yob >= (UNSIGNED2)LEFT.find_year_low AND 
					RIGHT.yob <= IF((UNSIGNED2)LEFT.find_year_high != 0, (UNSIGNED2)LEFT.find_year_high, (UNSIGNED2)0xFFFF)
	endmacro;
	
	export YOB_FROM_DOB() := macro
		(RIGHT.dob div 10000) >= (UNSIGNED2)LEFT.find_year_low AND 
					(RIGHT.dob div 10000) <= IF((UNSIGNED2)LEFT.find_year_high != 0, (UNSIGNED2)LEFT.find_year_high, (UNSIGNED2)0xFFFF)
	endmacro;
	
	// ---[  SSN  ]---
	
	export SSN_STRICT_KEYED() := macro
		keyed(RIGHT.s1=LEFT.ssn_value[1]) AND 
		keyed(RIGHT.s2=LEFT.ssn_value[2]) AND 
		keyed(RIGHT.s3=LEFT.ssn_value[3]) AND 
		keyed(RIGHT.s4=LEFT.ssn_value[4]) AND 
		keyed(RIGHT.s5=LEFT.ssn_value[5]) AND 
		keyed(RIGHT.s6=LEFT.ssn_value[6]) AND 
		keyed(RIGHT.s7=LEFT.ssn_value[7]) AND 
		keyed(RIGHT.s8=LEFT.ssn_value[8]) AND 
		keyed(RIGHT.s9=LEFT.ssn_value[9])
	endmacro;

	export SSN_FUZZY_KEYED() := macro
		(wild(RIGHT.s1)                    AND keyed(RIGHT.s2=LEFT.ssn_value[2]) AND keyed(RIGHT.s3=LEFT.ssn_value[3]) AND keyed(RIGHT.s4=LEFT.ssn_value[4]) AND keyed(RIGHT.s5=LEFT.ssn_value[5]) AND keyed(RIGHT.s6=LEFT.ssn_value[6]) AND keyed(RIGHT.s7=LEFT.ssn_value[7]) AND keyed(RIGHT.s8=LEFT.ssn_value[8]) AND keyed(RIGHT.s9=LEFT.ssn_value[9])) OR
		(keyed(RIGHT.s1=LEFT.ssn_value[1]) AND wild(RIGHT.s2)                    AND keyed(RIGHT.s3=LEFT.ssn_value[3]) AND keyed(RIGHT.s4=LEFT.ssn_value[4]) AND keyed(RIGHT.s5=LEFT.ssn_value[5]) AND keyed(RIGHT.s6=LEFT.ssn_value[6]) AND keyed(RIGHT.s7=LEFT.ssn_value[7]) AND keyed(RIGHT.s8=LEFT.ssn_value[8]) AND keyed(RIGHT.s9=LEFT.ssn_value[9])) OR
		(keyed(RIGHT.s1=LEFT.ssn_value[1]) AND keyed(RIGHT.s2=LEFT.ssn_value[2]) AND wild(RIGHT.s3)                    AND keyed(RIGHT.s4=LEFT.ssn_value[4]) AND keyed(RIGHT.s5=LEFT.ssn_value[5]) AND keyed(RIGHT.s6=LEFT.ssn_value[6]) AND keyed(RIGHT.s7=LEFT.ssn_value[7]) AND keyed(RIGHT.s8=LEFT.ssn_value[8]) AND keyed(RIGHT.s9=LEFT.ssn_value[9])) OR
		(keyed(RIGHT.s1=LEFT.ssn_value[1]) AND keyed(RIGHT.s2=LEFT.ssn_value[2]) AND keyed(RIGHT.s3=LEFT.ssn_value[3]) AND wild(RIGHT.s4)                    AND keyed(RIGHT.s5=LEFT.ssn_value[5]) AND keyed(RIGHT.s6=LEFT.ssn_value[6]) AND keyed(RIGHT.s7=LEFT.ssn_value[7]) AND keyed(RIGHT.s8=LEFT.ssn_value[8]) AND keyed(RIGHT.s9=LEFT.ssn_value[9])) OR
		(keyed(RIGHT.s1=LEFT.ssn_value[1]) AND keyed(RIGHT.s2=LEFT.ssn_value[2]) AND keyed(RIGHT.s3=LEFT.ssn_value[3]) AND keyed(RIGHT.s4=LEFT.ssn_value[4]) AND wild(RIGHT.s5)                    AND keyed(RIGHT.s6=LEFT.ssn_value[6]) AND keyed(RIGHT.s7=LEFT.ssn_value[7]) AND keyed(RIGHT.s8=LEFT.ssn_value[8]) AND keyed(RIGHT.s9=LEFT.ssn_value[9])) OR
		(keyed(RIGHT.s1=LEFT.ssn_value[1]) AND keyed(RIGHT.s2=LEFT.ssn_value[2]) AND keyed(RIGHT.s3=LEFT.ssn_value[3]) AND keyed(RIGHT.s4=LEFT.ssn_value[4]) AND keyed(RIGHT.s5=LEFT.ssn_value[5]) AND wild(RIGHT.s6)                    AND keyed(RIGHT.s7=LEFT.ssn_value[7]) AND keyed(RIGHT.s8=LEFT.ssn_value[8]) AND keyed(RIGHT.s9=LEFT.ssn_value[9])) OR
		(keyed(RIGHT.s1=LEFT.ssn_value[1]) AND keyed(RIGHT.s2=LEFT.ssn_value[2]) AND keyed(RIGHT.s3=LEFT.ssn_value[3]) AND keyed(RIGHT.s4=LEFT.ssn_value[4]) AND keyed(RIGHT.s5=LEFT.ssn_value[5]) AND keyed(RIGHT.s6=LEFT.ssn_value[6]) AND wild(RIGHT.s7)                    AND keyed(RIGHT.s8=LEFT.ssn_value[8]) AND keyed(RIGHT.s9=LEFT.ssn_value[9])) OR
		(keyed(RIGHT.s1=LEFT.ssn_value[1]) AND keyed(RIGHT.s2=LEFT.ssn_value[2]) AND keyed(RIGHT.s3=LEFT.ssn_value[3]) AND keyed(RIGHT.s4=LEFT.ssn_value[4]) AND keyed(RIGHT.s5=LEFT.ssn_value[5]) AND keyed(RIGHT.s6=LEFT.ssn_value[6]) AND keyed(RIGHT.s7=LEFT.ssn_value[7]) AND wild(RIGHT.s8)                    AND keyed(RIGHT.s9=LEFT.ssn_value[9])) OR
		(keyed(RIGHT.s1=LEFT.ssn_value[1]) AND keyed(RIGHT.s2=LEFT.ssn_value[2]) AND keyed(RIGHT.s3=LEFT.ssn_value[3]) AND keyed(RIGHT.s4=LEFT.ssn_value[4]) AND keyed(RIGHT.s5=LEFT.ssn_value[5]) AND keyed(RIGHT.s6=LEFT.ssn_value[6]) AND keyed(RIGHT.s7=LEFT.ssn_value[7]) AND keyed(RIGHT.s8=LEFT.ssn_value[8]))
	endmacro;
	
	export SSN4() := macro
		RIGHT.s4 = (UNSIGNED2)LEFT.ssn_value
	endmacro;
	
	// ---[  FEIN  ]---

	export FEIN_PARTS_KEYED() := macro
		keyed(right.f1 = intformat(left.fein_value,9,1)[1]) and
		keyed(right.f2 = intformat(left.fein_value,9,1)[2]) and
		keyed(right.f3 = intformat(left.fein_value,9,1)[3]) and
		keyed(right.f4 = intformat(left.fein_value,9,1)[4]) and
		keyed(right.f5 = intformat(left.fein_value,9,1)[5]) and
		keyed(right.f6 = intformat(left.fein_value,9,1)[6]) and
		keyed(right.f7 = intformat(left.fein_value,9,1)[7]) and
		keyed(right.f8 = intformat(left.fein_value,9,1)[8]) and
		keyed(right.f9 = intformat(left.fein_value,9,1)[9])
	endmacro;
	
	// ---[ ADDRESS DATA ]---
	
	export PRIM_RANGE() := macro
		RIGHT.prim_range = LEFT.prange_value
	endmacro;

	export PRIM_NAME() := macro
		RIGHT.prim_name = LEFT.pname_value
	endmacro;

	export SRANGE() := macro
		RIGHT.sec_range = LEFT.sec_range_value
	endmacro;
	
	export CITY_CODE() := macro
		RIGHT.city_code  in doxie.Make_CityCodes(LEFT.city_value).rox
	endmacro;

	export CITY_CODE_SET() := macro
		RIGHT.city_code IN LEFT.city_codes_set
	endmacro;
	
	export STATE() := macro
		(RIGHT.st = LEFT.state_value)
	endmacro;

	export STATE_() := macro
		(RIGHT.state = LEFT.state_value)
	endmacro;
	
	export ZIP() := macro
		(RIGHT.zip IN LEFT.zip_value)
	endmacro;
	
	// ---[ PHONE DATA ]---
	
	export P7() := macro
		(right.p7 = if(length(trim(left.phone_value)) = 10,left.phone_value[4..10],(string7)left.phone_value))
	endmacro;
	
	export P3() := macro
		(length(trim(left.phone_value)) != 10 or right.p3 = left.phone_value[1..3])
	endmacro;
	
	// ---[ OTHER VALUES AND BIT-TESTING ]---
	
	export OTHER_VALUES_ST_LNAME() := macro
			(LEFT.prev_state_val1='' or ut.bit_test(RIGHT.states,ut.St2Code(LEFT.prev_state_val1))) AND
			(LEFT.prev_state_val2='' or ut.bit_test(RIGHT.states,ut.St2Code(LEFT.prev_state_val2))) AND
			(LEFT.other_lname_value1[1]='' or ut.bit_test(RIGHT.lname1,ut.Chr2Code(LEFT.other_lname_value1[1]))) AND
			(LEFT.other_lname_value1[2]='' or ut.bit_test(RIGHT.lname2,ut.Chr2Code(LEFT.other_lname_value1[2]))) AND
			(LEFT.other_lname_value1[3]='' or ut.bit_test(RIGHT.lname3,ut.Chr2Code(LEFT.other_lname_value1[3]))) 
	endmacro;
	
	export OTHER_VALUES() := macro
			JoinConditions.OTHER_VALUES_ST_LNAME() AND
			(LEFT.other_city_value[1]='' or ut.bit_test(RIGHT.city1,ut.Chr2Code(LEFT.other_city_value[1]))) AND
			(LEFT.other_city_value[2]='' or ut.bit_test(RIGHT.city2,ut.Chr2Code(LEFT.other_city_value[2]))) AND
			(LEFT.other_city_value[3]='' or ut.bit_test(RIGHT.city3,ut.Chr2Code(LEFT.other_city_value[3]))) AND
			(LEFT.rel_fname_value1[1]='' or ut.bit_test(RIGHT.rel_fname1,ut.Chr2Code(LEFT.rel_fname_value1[1]))) AND
			(LEFT.rel_fname_value1[2]='' or ut.bit_test(RIGHT.rel_fname2,ut.Chr2Code(LEFT.rel_fname_value1[2]))) AND
			(LEFT.rel_fname_value1[3]='' or ut.bit_test(RIGHT.rel_fname3,ut.Chr2Code(LEFT.rel_fname_value1[3]))) AND
			(LEFT.rel_fname_value2[1]='' or ut.bit_test(RIGHT.rel_fname1,ut.Chr2Code(LEFT.rel_fname_value2[1]))) AND
			(LEFT.rel_fname_value2[2]='' or ut.bit_test(RIGHT.rel_fname2,ut.Chr2Code(LEFT.rel_fname_value2[2]))) AND
			(LEFT.rel_fname_value2[3]='' or ut.bit_test(RIGHT.rel_fname3,ut.Chr2Code(LEFT.rel_fname_value2[3])))
	endmacro;
	
	export BIT_TEST() := macro
		ut.bit_test(RIGHT.lookups, LEFT.lookup_value)
	endmacro;

	export BIT_TEST2() := macro
		ut.bit_test(RIGHT.lookups, LEFT.lookup_value2)
	endmacro;
	
end;
