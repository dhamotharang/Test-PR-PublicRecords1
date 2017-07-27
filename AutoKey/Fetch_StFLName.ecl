import doxie,AutoKeyI;
export Fetch_StFLName(STRING t, boolean workHard,boolean nofail =true) :=
FUNCTION

doxie.MAC_Header_Field_Declare()

tempmod := module(AutoKeyI.FetchI_Indv_StName.old.params.full)
	export string autokey_keyname_root := t;
	export boolean workHard := ^.workHard;
	export boolean nofail := ^.nofail;
	export string fname_value := ^.fname_value;
	export boolean nicknames := ^.nicknames;
	export string mname_value := ^.mname_value;
	export string lname_value := ^.lname_value;
	export set of string lname_set_value := ^.lname_set_value;
	export boolean phonetics := ^.phonetics;
	export string city_value := ^.city_value;
	export string state_value := ^.state_value;
	export set of integer4 zip_value := ^.zip_value;
	export unsigned find_day := ^.find_day;
	export unsigned find_month := ^.find_month;
	export unsigned find_year_low := ^.find_year_low;
	export unsigned find_year_high := ^.find_year_high;
	export string9 ssn_value := ^.ssn_value;
	export string2 prev_state_val1 := ^.prev_state_val1;
	export string2 prev_state_val2 := ^.prev_state_val2;
	export string30 other_lname_value1 := ^.other_lname_value1;
	export string25 other_city_value := ^.other_city_value;
	export string30 rel_fname_value1 := ^.rel_fname_value1;
	export string rel_fname_value2 := ^.rel_fname_value2;
	export unsigned4 lookup_value := ^.lookup_value;
end;

RETURN AutoKeyI.FetchI_Indv_StName.old.do(tempmod);
END;
