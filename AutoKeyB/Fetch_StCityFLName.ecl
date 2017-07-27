import doxie,AutoKeyI;
export Fetch_StCityFLName(STRING t, boolean workHard,boolean nofail=true,boolean useAllLookups = false,set of string1 get_skip_set = []) :=
FUNCTION

doxie.MAC_Header_Field_Declare()

tempmod := module(AutoKeyI.FetchI_Biz_StCityName.old.params.full)
	export string autokey_keyname_root := t;
	export boolean workHard := ^.workHard;
	export boolean nofail := ^.nofail;
	export boolean useAllLookups := ^.useAllLookups;
	export set of string1 get_skip_set := ^.get_skip_set;
	export string comp_name_value := ^.comp_name_value;
	export string comp_name_indic_value := ^.comp_name_indic_value;
	export string comp_name_sec_value := ^.comp_name_sec_value;
	export string pname_value := ^.pname_value;
	export boolean addr_error_value := ^.addr_error_value;
	export string city_value := ^.city_value;
	export string state_value := ^.state_value;
	export unsigned4 lookup_value := ^.lookup_value;
end;

RETURN AutoKeyI.FetchI_Biz_StCityName.old.do(tempmod);
END;
