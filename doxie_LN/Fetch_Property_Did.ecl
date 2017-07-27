import Doxie, ln_propertyv2;

export Fetch_Property_DID (dataset(Doxie.layout_references) dids, boolean IsFCRA = false) :=
FUNCTION

i :=  ln_propertyv2.key_property_did(isFCRA);
rec := record
	string12  ln_fares_id;
	string2   source_code;
	unsigned6	did;
	unsigned6	bdid;
end;

rec xt(i l) := TRANSFORM
	self.did := L.s_did;
	self.bdid := 0;
	SELF := l;
END;

out := join(dids,i,
            keyed (left.did=right.s_did) and
            (~IsFCRA or right.source_code[1] <> 'C'),
            xt(right), KEEP(200));

RETURN dedup(sort(out, did, ln_fares_id, source_code), did,  ln_fares_id, source_code);

END;
