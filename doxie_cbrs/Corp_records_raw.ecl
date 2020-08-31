
IMPORT corp, doxie, business_header;
doxie_cbrs.MAC_Selection_Declare()

ck_rec := RECORD
  STRING30 corp_key;
END;


doxie_cbrs.mac_getKeyByBDID(corp.key_Corp_base_bdid, bdid, ck_rec, Include_CompanyIDnumbers_val, doxie_cbrs.ds_subject_BDIDs, cks)

kcbc := corp.key_corp_base_corpkey;

outrec := RECORDOF(kcbc);
outrec keepr(kcbc r) := TRANSFORM
  SELF := r;
END;

EXPORT Corp_records_raw :=
  JOIN(cks, kcbc,
    LEFT.corp_key = RIGHT.corp_key,
    keepr(RIGHT));
