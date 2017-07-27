import doxie,AutoKeyI;
export Fetch_Phone(STRING t,boolean nofail =true,boolean useAllLookups = false) :=
FUNCTION

doxie.MAC_Header_Field_Declare()

tempmod := module(AutoKeyI.FetchI_Indv_Phone.old.params.full)
	export string autokey_keyname_root := t;
	export boolean nofail := ^.nofail;
	export boolean useAllLookups := ^.useAllLookups;
	export string lname_value := ^.lname_value;
	export string10 phone_value := ^.phone_value;
	export unsigned4 lookup_value := ^.lookup_value;
end;

RETURN AutoKeyI.FetchI_Indv_Phone.old.do(tempmod);
END;
