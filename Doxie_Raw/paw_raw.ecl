
import AutoStandardI, doxie_raw, Doxie, business_header, ut, paw, BIPv2, Suppress;

export paw_raw(
	dataset(doxie.layout_references) dids,
	unsigned3 dateVal = 0,
	unsigned1 dppa_purpose = 0,
	unsigned1 glb_purpose = 0
	
) := FUNCTION
 global_mod := AutoStandardI.GlobalModule();
 mod_access := module(doxie.compliance.GetGlobalDataAccessModuleTranslated (global_mod))
                   EXPORT unsigned1 glb := glb_purpose;
                   EXPORT unsigned1 dppa := dppa_purpose;
                   EXPORT unsigned3 date_threshold := dateVal; // a.k.a. dateVal
               end;

outrec := RECORD
	Business_Header.Layout_Employment_Out;
	BIPV2.IDlayouts.l_header_ids;
END;

outrec_plus := RECORD(outrec)
	unsigned4 global_sid;
  unsigned8 record_sid;
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
outrec_plus keepr(cids l, kc r) := transform
	self.did := intformat(r.did, 12, 1);
	self.bdid := intformat(r.bdid, 12, 1);
	self.company_phone := if((unsigned)r.company_phone = 0, '', r.company_phone);
	self := r;
end;


//***** PERMISSIONS
mac_permissions() := macro
  (Right.DPPA_State = '' or mod_access.isValidDppaState(Right.DPPA_State, , RIGHT.source)) AND
  (Right.glb='N' or mod_access.isValidGlb())

endmacro;

//***** PICK UP AND RETURN THE RECORDS
fetched_out_pre := 
	join(
		cids,
		kc,
		keyed(left.contact_id = right.contact_id) and
		mac_permissions(),
		keepr(left, right),
		limit(ut.limits.default, skip) //TODO: seems like keep(1), limit(0);
	);
fetched_out :=  project(suppress.mac_suppressSource(fetched_out_pre,mod_access),outrec);

return sort(fetched_out, whole record);

END;

