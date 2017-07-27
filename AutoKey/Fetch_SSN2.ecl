// import ut,doxie;

// export Fetch_SSN2(STRING t, boolean workHard, boolean nofail = true) :=
// FUNCTION


// doxie.mac_header_field_declare()

// i := Key_SSN2(t);

// AutoKey.layout_fetch xt(i r) := 
// TRANSFORM
	// SELF.did := r.did;
// END;
// pfe(string20 l, string20 r) := l[1..length(trim(datalib.preferredfirst(r)))]=datalib.preferredfirst(r);

// boolean is_straight_match := ~workHard OR ~fuzzy_ssn OR isCRS;
// boolean is_limitable := is_straight_match;

// f_raw :=
	// map( is_straight_match => i(ssn_value<>'',keyed(s1=ssn_value[1]),keyed(s2=ssn_value[2]),keyed(s3=ssn_value[3]),keyed(s4=ssn_value[4]),keyed(s5=ssn_value[5]),keyed(s6=ssn_value[6]),keyed(s7=ssn_value[7]),keyed(s8=ssn_value[8]),keyed(s9=ssn_value[9])),
				    // i(ssn_value<>'',wild(s1),keyed(s2=ssn_value[2]),keyed(s3=ssn_value[3]),keyed(s4=ssn_value[4]),keyed(s5=ssn_value[5]),keyed(s6=ssn_value[6]),keyed(s7=ssn_value[7]),keyed(s8=ssn_value[8]),keyed(s9=ssn_value[9])) +
				    // i(ssn_value<>'',keyed(s1=ssn_value[1]),wild(s2),keyed(s3=ssn_value[3]),keyed(s4=ssn_value[4]),keyed(s5=ssn_value[5]),keyed(s6=ssn_value[6]),keyed(s7=ssn_value[7]),keyed(s8=ssn_value[8]),keyed(s9=ssn_value[9])) +
				    // i(ssn_value<>'',keyed(s1=ssn_value[1]),keyed(s2=ssn_value[2]),wild(s3),keyed(s4=ssn_value[4]),keyed(s5=ssn_value[5]),keyed(s6=ssn_value[6]),keyed(s7=ssn_value[7]),keyed(s8=ssn_value[8]),keyed(s9=ssn_value[9])) +
				    // i(ssn_value<>'',keyed(s1=ssn_value[1]),keyed(s2=ssn_value[2]),keyed(s3=ssn_value[3]),wild(s4),keyed(s5=ssn_value[5]),keyed(s6=ssn_value[6]),keyed(s7=ssn_value[7]),keyed(s8=ssn_value[8]),keyed(s9=ssn_value[9])) +
				    // i(ssn_value<>'',keyed(s1=ssn_value[1]),keyed(s2=ssn_value[2]),keyed(s3=ssn_value[3]),keyed(s4=ssn_value[4]),wild(s5),keyed(s6=ssn_value[6]),keyed(s7=ssn_value[7]),keyed(s8=ssn_value[8]),keyed(s9=ssn_value[9])) +
				    // i(ssn_value<>'',keyed(s1=ssn_value[1]),keyed(s2=ssn_value[2]),keyed(s3=ssn_value[3]),keyed(s4=ssn_value[4]),keyed(s5=ssn_value[5]),wild(s6),keyed(s7=ssn_value[7]),keyed(s8=ssn_value[8]),keyed(s9=ssn_value[9])) +
				    // i(ssn_value<>'',keyed(s1=ssn_value[1]),keyed(s2=ssn_value[2]),keyed(s3=ssn_value[3]),keyed(s4=ssn_value[4]),keyed(s5=ssn_value[5]),keyed(s6=ssn_value[6]),wild(s7),keyed(s8=ssn_value[8]),keyed(s9=ssn_value[9])) +
				    // i(ssn_value<>'',keyed(s1=ssn_value[1]),keyed(s2=ssn_value[2]),keyed(s3=ssn_value[3]),keyed(s4=ssn_value[4]),keyed(s5=ssn_value[5]),keyed(s6=ssn_value[6]),keyed(s7=ssn_value[7]),wild(s8),keyed(s9=ssn_value[9])) +
				    // i(ssn_value<>'',keyed(s1=ssn_value[1]),keyed(s2=ssn_value[2]),keyed(s3=ssn_value[3]),keyed(s4=ssn_value[4]),keyed(s5=ssn_value[5]),keyed(s6=ssn_value[6]),keyed(s7=ssn_value[7]),keyed(s8=ssn_value[8])) );
					
// f_filt := f_raw( ut.bit_test(lookups, lookup_value) );

// f := project(f_filt, xt(LEFT));					

// AutoKey.mac_Limits(f,f_ret)	

// RETURN f;//if(is_limitable,f_ret,f);

// END;