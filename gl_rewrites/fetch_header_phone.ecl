import doxie,ut;
export fetch_header_phone(
	gl_rewrites.person_interfaces.i__fetch_header_phone in_parms) :=
		function
			i := doxie.Key_Header_Phone ;
			pfe(string20 l, string20 r) := l[1..length(trim(datalib.preferredfirst(r)))]=(STRING20)datalib.preferredfirst(r);
			return project(
				LIMIT (LIMIT (i(in_parms.phone_value<>'',
					keyed (p7=IF(length(trim(in_parms.phone_value))=10,in_parms.phone_value[4..10],(STRING7)in_parms.phone_value)),
					keyed ((length(trim(in_parms.phone_value)) <> 10) OR p3=in_parms.phone_value[1..3]),
					keyed ((in_parms.lname_value='') OR dph_lname=(string6)metaphonelib.DMetaPhone1(in_parms.lname_value)[1..6]),
					keyed ((LENGTH(TRIM(in_parms.fname_value))<2) OR pfe(pfname,in_parms.fname_value))),
				ut.limits.PHONE_PER_PERSON, keyed, SKIP), 100, SKIP),
				doxie.layout_references);
		end;
