
import corp, doxie, business_header;
doxie_cbrs.MAC_Selection_Declare()

ck_rec := record
	string30  corp_key;
end;


doxie_cbrs.mac_getKeyByBDID(corp.key_Corp_base_bdid, bdid, ck_rec, Include_CompanyIDnumbers_val, doxie_cbrs.ds_subject_BDIDs, cks)

kcbc := corp.key_corp_base_corpkey;

outrec := recordof(kcbc);
outrec keepr(kcbc r) := transform
	self := r;
end;

export Corp_records_raw := 
	join(cks, kcbc,
		   left.corp_key = right.corp_key,
			 keepr(right));
