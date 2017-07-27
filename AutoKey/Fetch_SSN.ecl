import doxie,AutoKeyI;
export Fetch_SSN(STRING t, boolean workHard, boolean nofail = true,boolean useAllLookups = false) :=
FUNCTION

doxie.MAC_Header_Field_Declare()

tempmod := module(AutoKeyI.FetchI_Indv_SSN.old.params.full)
	export string autokey_keyname_root := t;
	export boolean workHard := ^.workHard;
	export boolean nofail := ^.nofail;
	export boolean useAllLookups := ^.useAllLookups;
	export boolean isCRS := ^.isCRS;
	export string9 ssn_value := ^.ssn_value;
	export boolean fuzzy_ssn := ^.fuzzy_ssn;
	export unsigned4 lookup_value := ^.lookup_value;
end;

RETURN AutoKeyI.FetchI_Indv_SSN.old.do(tempmod);
END;
