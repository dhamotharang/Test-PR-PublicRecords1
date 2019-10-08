import doxie, dx_Header, NID;

i := dx_Header.key_SSN();

doxie.layout_references xt(i r) := TRANSFORM
                                SELF := r;
                                 END;
pfe(string20 l, string20 r) := NID.mod_PFirstTools.SubLinPFR(l,r);
export Fetch_Header_SSN_Function (string9 ssn_value
																 ,string20 lname_value
																 ,string20 fname_value
																 ,unsigned1 score_threshold_value
																 )

:= 
FUNCTION
// These may be moved into the function parameters if needed
boolean fuzzy_ssn := false;
outrec := project(
map( ~fuzzy_ssn => i(keyed(s1=ssn_value[1]),keyed(s2=ssn_value[2]),keyed(s3=ssn_value[3]),keyed(s4=ssn_value[4]),keyed(s5=ssn_value[5]),keyed(s6=ssn_value[6]),keyed(s7=ssn_value[7]),keyed(s8=ssn_value[8]),keyed(s9=ssn_value[9])),
                   i(wild(s1),keyed(s2=ssn_value[2]),keyed(s3=ssn_value[3]),keyed(s4=ssn_value[4]),keyed(s5=ssn_value[5]),keyed(s6=ssn_value[6]),keyed(s7=ssn_value[7]),keyed(s8=ssn_value[8]),keyed(s9=ssn_value[9])) +
                   i(keyed(s1=ssn_value[1]),wild(s2),keyed(s3=ssn_value[3]),keyed(s4=ssn_value[4]),keyed(s5=ssn_value[5]),keyed(s6=ssn_value[6]),keyed(s7=ssn_value[7]),keyed(s8=ssn_value[8]),keyed(s9=ssn_value[9])) +
                   i(keyed(s1=ssn_value[1]),keyed(s2=ssn_value[2]),wild(s3),keyed(s4=ssn_value[4]),keyed(s5=ssn_value[5]),keyed(s6=ssn_value[6]),keyed(s7=ssn_value[7]),keyed(s8=ssn_value[8]),keyed(s9=ssn_value[9])) +
                   i(keyed(s1=ssn_value[1]),keyed(s2=ssn_value[2]),keyed(s3=ssn_value[3]),wild(s4),keyed(s5=ssn_value[5]),keyed(s6=ssn_value[6]),keyed(s7=ssn_value[7]),keyed(s8=ssn_value[8]),keyed(s9=ssn_value[9])) +
                   i(keyed(s1=ssn_value[1]),keyed(s2=ssn_value[2]),keyed(s3=ssn_value[3]),keyed(s4=ssn_value[4]),wild(s5),keyed(s6=ssn_value[6]),keyed(s7=ssn_value[7]),keyed(s8=ssn_value[8]),keyed(s9=ssn_value[9])) +
                   i(keyed(s1=ssn_value[1]),keyed(s2=ssn_value[2]),keyed(s3=ssn_value[3]),keyed(s4=ssn_value[4]),keyed(s5=ssn_value[5]),wild(s6),keyed(s7=ssn_value[7]),keyed(s8=ssn_value[8]),keyed(s9=ssn_value[9])) +
                   i(keyed(s1=ssn_value[1]),keyed(s2=ssn_value[2]),keyed(s3=ssn_value[3]),keyed(s4=ssn_value[4]),keyed(s5=ssn_value[5]),keyed(s6=ssn_value[6]),wild(s7),keyed(s8=ssn_value[8]),keyed(s9=ssn_value[9])) +
                   i(keyed(s1=ssn_value[1]),keyed(s2=ssn_value[2]),keyed(s3=ssn_value[3]),keyed(s4=ssn_value[4]),keyed(s5=ssn_value[5]),keyed(s6=ssn_value[6]),keyed(s7=ssn_value[7]),wild(s8),keyed(s9=ssn_value[9])) +
                   i(keyed(s1=ssn_value[1]),keyed(s2=ssn_value[2]),keyed(s3=ssn_value[3]),keyed(s4=ssn_value[4]),keyed(s5=ssn_value[5]),keyed(s6=ssn_value[6]),keyed(s7=ssn_value[7]),keyed(s8=ssn_value[8])) )
			    (score_threshold_value > 10 OR 
					((lname_value='' or dph_lname=metaphonelib.DMetaPhone1(lname_value)[1..6]) AND 
					 (LENGTH(TRIM(fname_value))<2 or pfe(pfname,fname_value)or fname_value='')))
, xt(LEFT));
return outrec;
END;
