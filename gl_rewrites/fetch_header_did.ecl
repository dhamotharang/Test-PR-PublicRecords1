import doxie,ut;
export fetch_header_did(
	gl_rewrites.person_interfaces.i__fetch_header_did in_parms) :=
		function
			return
				join(
					doxie.map_DID(dataset([{(unsigned8)in_parms.did_value}], doxie.layout_references)),
					doxie.key_header,
					keyed(left.did = right.s_did),
					transform(doxie.layout_references,
						self := right),
					limit(ut.limits.DID_PER_PERSON,SKIP));
		end;
		