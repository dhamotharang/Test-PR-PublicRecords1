
import doxie_raw, Doxie, business_header, drivers, ut, paw, BIPv2;

export paw_raw(
	dataset(doxie.layout_references) dids,
	unsigned3 dateVal = 0,
	unsigned1 dppa_purpose = 0,
	unsigned1 glb_purpose = 0
	
) := FUNCTION

outrec := RECORD
	Business_Header.Layout_Employment_Out;
	BIPV2.IDlayouts.l_header_ids;
END;

//***** KEYS
kd := paw.Key_Did;
kc := paw.Key_contactID;
cidrec := {kc.contact_id};

//***** GET THE CONTACT IDS
cids := 
	join(
		dids(Did > 0),
		kd,
		keyed(left.did = right.did),
		transform(cidrec,	self.contact_id := right.contact_id),
		limit(ut.limits.default, skip)
	);


//***** TRANSFORM
outrec keepr(cids l, kc r) := transform
	self.did := intformat(r.did, 12, 1);
	self.bdid := intformat(r.bdid, 12, 1);
	self.company_phone := if((unsigned)r.company_phone = 0, '', r.company_phone);
	self := r;
end;


//***** PERMISSIONS
mac_permissions() := macro
	(Right.DPPA_State = '' or Drivers.state_dppa_ok(Right.DPPA_State, dppa_purpose,,RIGHT.source)) and
	(Right.glb='N' or ut.glb_ok(glb_purpose))
endmacro;

//***** PICK UP AND RETURN THE RECORDS
fetched_out := 
	join(
		cids,
		kc,
		keyed(left.contact_id = right.contact_id) and
		mac_permissions(),
		keepr(left, right),
		limit(ut.limits.default, skip) //TODO: seems like keep(1), limit(0);
	);

return sort(fetched_out, whole record);

END;

