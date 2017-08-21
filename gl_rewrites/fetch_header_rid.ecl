import doxie,ut;
export Fetch_Header_rID(
	gl_rewrites.person_interfaces.i__fetch_header_rid in_parms) :=
		function
			return
				project(
					LIMIT(
						doxie.key_header_rid(rid = (unsigned8)in_parms.rid_value),
						ut.limits.RID_PER_PERSON,SKIP),
					doxie.layout_references);
		end;
		