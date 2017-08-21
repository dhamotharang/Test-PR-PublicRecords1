import doxie,AutoKeyI;
export Fetch_Aid(STRING t, boolean workHard,boolean noFail = true, boolean L_UseNewPreferredFirst = false) :=
FUNCTION

doxie.MAC_Header_Field_Declare()

tempmod := module(AutoKeyI.FetchI_Indv_Aid.old.params.full)
	export string autokey_keyname_root := t;
	export boolean workHard := ^.workHard;
	export boolean nofail := ^.nofail;
	export boolean nicknames := ^.nicknames;
	export boolean phonetics := ^.phonetics;
	export string fname_value := ^.fname_value;
	export string lname_value := ^.lname_value;
	export set of string lname_set_value := ^.lname_set_value;
	export string prange_value := ^.prange_value;
	export string pname_value := ^.pname_value;
	export string sec_range_value := ^.sec_range_value;
	export boolean addr_loose := ^.addr_loose;
	export string city_value := ^.city_value;
	export set of unsigned city_codes_set := ^.city_codes_set;
	export string state_value := ^.state_value;
	export string5 zip_val := ^.zip_val;
	export set of integer4 zip_value := ^.zip_value;
	export string5 city_zip_value := ^.city_zip_value;
	export unsigned2 zipradius_value := ^.zipradius_value;
	export string2 prev_state_val1 := ^.prev_state_val1;
	export string2 prev_state_val2 := ^.prev_state_val2;
	export string30 other_lname_value1 := ^.other_lname_value1;
	export unsigned4 lookup_value := ^.lookup_value;
	export unsigned4 lookup_value2 := ^.lookup_value2;
	export boolean FuzzySecRange_value := ^.FuzzySecRange_value;
	export boolean do_primname_word_match := ^.do_primname_word_match;
	export boolean L_UseNewPreferredFirst := ^.L_UseNewPreferredFirst;
end;

RETURN AutoKeyI.FetchI_Indv_Aid.old.do(tempmod);
END;