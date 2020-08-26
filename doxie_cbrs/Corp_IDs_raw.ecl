
IMPORT corp2, doxie, business_header;

EXPORT Corp_IDs_raw(DATASET(doxie_cbrs.layout_references) bdids) := FUNCTION

doxie_cbrs.MAC_Selection_Declare()

ck_rec := RECORD
  STRING30 corp_key;
END;


doxie_cbrs.mac_getKeyByBDID(corp2.key_corp_bdid, bdid, ck_rec, Include_CompanyIDnumbers_val, bdids, cks)

kcbc := corp2.Key_Corp_Corpkey;

outrec := RECORD
  kcbc.corp_orig_sos_charter_nbr;
  kcbc.corp_state_origin;
END;
  
outrec keepr(kcbc r) := TRANSFORM
  SELF := r;
END;

RETURN JOIN(cks, kcbc,
       LEFT.corp_key = RIGHT.corp_key,
       keepr(RIGHT),LIMIT(10000,SKIP));
END;
