import doxie,AutoKeyI;
export Fetch_ZipPRLName(STRING t, boolean workHard, boolean noFail = true) :=
FUNCTION

doxie.MAC_Header_Field_Declare()

tempmod := module(AutoKeyI.FetchI_Indv_ZipPRLname.old.params.full)
	export string autokey_keyname_root := t;
	export boolean nofail := ^.nofail;
	export string lname_value := ^.lname_value;
	export string fname_value := ^.fname_value;
	export string prange_value := ^.prange_value;
	export string pname_value := ^.pname_value;
	export set of integer4 zip_value := ^.zip_value;
	export unsigned4 lookup_value := ^.lookup_value;
end;

RETURN AutoKeyI.FetchI_Indv_ZipPRLName.old.do(tempmod);
END;
