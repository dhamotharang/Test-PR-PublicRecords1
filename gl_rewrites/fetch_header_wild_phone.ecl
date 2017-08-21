import doxie,ut;
export fetch_header_wild_phone(
	gl_rewrites.person_interfaces.i__fetch_header_wild_phone in_parms) :=
		function
			i := doxie.Key_Header_Wild_Phone;

			return project(
				LIMIT (LIMIT (i(in_parms.phone_value<>'',
					keyed(p7=IF(length(trim(in_parms.phone_value))=10,in_parms.phone_value[4..10],(STRING7)in_parms.phone_value)),
					keyed ((length(trim(in_parms.phone_value)) <> 10) OR (p3=in_parms.phone_value[1..3])),
					in_parms.lname_wild_val = '' or stringlib.StringWildMatch(i.lname, in_parms.lname_wild_val, true),
					in_parms.fname_wild_val = '' or stringlib.StringWildMatch(i.fname, in_parms.fname_wild_val, true)),
			 ut.limits.PHONE_PER_PERSON, keyed, SKIP), 1000, SKIP),
			 doxie.layout_references);
		end;