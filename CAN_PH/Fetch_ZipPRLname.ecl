import ut,doxie, autokey, CanadianPhones;

export Fetch_ZipPRLName(STRING t, boolean workHard, boolean noFail = true) :=
FUNCTION

doxie.MAC_Header_Field_Declare();

// i := Key_ZipPRLName(t);
d := DATASET([], CanadianPhones.layouts.zipPRLname);

i:= 
	if(
		stringlib.stringfind (trim(t),'::qa::',1) > 0,
    INDEX(d, {d}, TRIM(t)+'ZipPRLname'), 
		INDEX(d, {d}, TRIM(t)+'ZipPRLname' + '_' + doxie.Version_SuperKey)
	);


AutoKey.layout_fetch xt(i r) := TRANSFORM
                                        SELF := r;
                                 END;


f_raw := i(can_poscode_value<>'' AND pname_value='' AND prange_Value <> '', 
			keyed(zip = can_poscode_value), 
			keyed(prim_Range = prange_Value), 
			keyed(lname[1..LENGTH(TRIM(lname_value))] = lname_value),
		  ut.bit_test(lookups, lookup_value));

f := project(f_raw, xt(LEFT));
		
AutoKey.mac_Limits(f,f_ret)	
									
RETURN f_ret;

END;