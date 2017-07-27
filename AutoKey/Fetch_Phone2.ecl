// import ut,doxie;

// export Fetch_Phone2(STRING t,boolean nofail =true) :=
// FUNCTION

// doxie.mac_header_field_declare()

// i := key_phone2(t);

// AutoKey.layout_fetch xt(i r) := 
// TRANSFORM
	// SELF := r;
// END;

// pfe(string20 l, string20 r) := l[1..length(trim(datalib.preferredfirst(r)))]=(STRING20)datalib.preferredfirst(r);


// f := project(
        // i(phone_value<>'',
		// keyed(p7=IF(length(trim(phone_value))=10,phone_value[4..10],(STRING7)phone_value)),
		// keyed(p3=phone_value[1..3] OR length(trim(phone_value)) <> 10),
		// keyed(lname_value='' or dph_lname=(string6)metaphonelib.DMetaPhone1(lname_value)[1..6]),  
		// ut.bit_test(lookups, lookup_value)), xt(LEFT));

// AutoKey.mac_Limits(f,f_ret)	
									
// RETURN f_ret;
		
// END;