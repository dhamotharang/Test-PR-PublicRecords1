
import corp2, doxie, business_header;

export Corp_IDs_raw_v2(dataset(doxie_cbrs.layout_references) bdids) := FUNCTION

doxie_cbrs.MAC_Selection_Declare()

ck_rec := record
	corp2.key_Corp_bdid.corp_key;
end;

doxie_cbrs.mac_getKeyByBDID(
	corp2.key_Corp_bdid,
	bdid,
	ck_rec,
	Include_CompanyIDnumbersV2_val,
	bdids,
	cks)

kcbc := corp2.key_corp_corpkey;

outrec := record
	kcbc.corp_orig_sos_charter_nbr;
	kcbc.corp_state_origin;
end;
	
outrec keepr(kcbc r) := transform
	self := r;
end;

return 	join(
		cks,
		kcbc,
		left.corp_key = right.corp_key,
		keepr(right),limit(10000,skip));
END;