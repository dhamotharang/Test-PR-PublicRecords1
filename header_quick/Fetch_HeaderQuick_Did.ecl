IMPORT ut,doxie;

i := header_quick.key_DID;

doxie.layout_references_hh xt(i r) := TRANSFORM
                                        SELF := r;
                                 END;

export Fetch_HeaderQuick_DID(unsigned8 rdid) := 
	join(doxie.map_DID(dataset([{rdid}], doxie.layout_references)),
			 i,
			 keyed(left.did = right.did),
			 xt(right), LIMIT (ut.limits.DID_PER_PERSON, SKIP));