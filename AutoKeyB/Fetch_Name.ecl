import business_header,AutoKeyI;
export Fetch_Name(STRING t, boolean workHard,boolean nofail =true,boolean useAllLookups = false) := 
FUNCTION

business_header.doxie_MAC_Field_Declare()

tempmod := module(AutoKeyI.FetchI_Biz_Name.old.params.full)
	export string autokey_keyname_root := t;
	export boolean workHard := ^.workHard;
	export boolean nofail := ^.nofail;
	export boolean useAllLookups := ^.useAllLookups;
	export string comp_name_indic_value := ^.comp_name_indic_value;
	export string comp_name_sec_value := ^.comp_name_sec_value;
	export string city_value := ^.city_value;
	export string state_value := ^.state_value;
	export set of integer4 zip_value := ^.zip_value;
	export unsigned6 bdid_value := ^.bdid_value;
	export unsigned4 lookup_value := ^.lookup_value;
	export string6 can_poscode_value := ^.can_poscode_value;
end;

RETURN AutoKeyI.FetchI_Biz_Name.old.do(tempmod);
END;
