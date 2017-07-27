// for Canada: zip == postal code; st == province
import doxie, autokeyb2;
EXPORT layouts := MODULE
  // a variant of AutoKey.Layout_Address
  export address := RECORD
    string28 prim_name;
    string10 prim_range;
    string2 st; // province, indeed
    unsigned4 city_code;
    string6 zip;
    string8 sec_range;
    string6 dph_lname;
    string20 lname;
    string20 pfname;
    string20 fname;
    unsigned4 lookups;
    unsigned6 did;
  end;
	
	export addressb := RECORD
    string28 prim_name;
    string10 prim_range;
    string2 st; // province, indeed
    unsigned4 city_code;
    string6 zip;
    string8 sec_range;
		AutokeyB2.Layout_Cname;
		doxie.Layout_ref_bdid;
		unsigned4 lookups;
END;

  // slimmed down version of AutoKey.Layout_Zip 
  export zip := record
    string6 zip;
    string6 dph_lname;
    string20 lname;
    string20 pfname;
    string20 fname;
    string1 minit;
    unsigned6 did;
	  unsigned4 lookups;
  end;
	
	export zipb := record
    string6 zip;
		AutokeyB2.Layout_Cname;
		doxie.Layout_ref_bdid;
		unsigned4 lookups;
  end;
	
	export ZipPRLName := record
    string6 zip;
    string10 prim_Range;
    string20 lname;
    unsigned4 lookups;
    unsigned6 did;
	end;
END;
