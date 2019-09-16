import dx_header, doxie, NID;

i := dx_header.key_phone();

doxie.layout_references xt(i r) := TRANSFORM
                                SELF := r;
                                 END;

pfe(string20 l, string20 r) := NID.mod_PFirstTools.SubLinPFR(l,r);




export Fetch_Header_Phone_Function(string10 phone_value
																	,string20 lname_value
																	,string20 fname_value
																	)
:= 
FUNCTION
		outrec := project(
        i(//phone_value<>'', // uncomment this when bugzilla 16202 gets deployed
		(p7=IF(length(trim(phone_value))=10,phone_value[4..10],(STRING7)phone_value)),
		(p3=phone_value[1..3] OR length(trim(phone_value)) <> 10),
		(lname_value='' or dph_lname=metaphonelib.DMetaPhone1(lname_value)[1..6]),
		(LENGTH(TRIM(fname_value))<2 or pfe(pfname,fname_value) or fname_value='')
		)  , xt(LEFT));
return outrec;
END;
