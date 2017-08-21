k := fileservices.dkc(MOXIE_KEY_THOR + 'key::moxie.corp_supp.corp_key.key', MOXIE_DESPRAY_SERVER, MOXIE_CORP_MOUNT + 'corp2_supp.corp_key.key');
k1 := fileservices.dkc(MOXIE_KEY_THOR + 'key::moxie.corp_supp.st_orig.sos_charter_nbr.key', MOXIE_DESPRAY_SERVER, MOXIE_CORP_MOUNT + 'corp2_supp.st_orig.sos_charter_nbr.key');
k2 := fileservices.dkc(MOXIE_KEY_THOR + 'key::moxie.corp_supp.bdid.key', MOXIE_DESPRAY_SERVER, MOXIE_CORP_MOUNT + 'corp2_supp.bdid.key');
k3 := fileservices.dkc(MOXIE_KEY_THOR + 'key::moxie.corp_supp.corp_key.supp_type_desc.supp_filing_date.key', MOXIE_DESPRAY_SERVER, MOXIE_CORP_MOUNT + 'corp2_supp.corp_key.supp_type_desc.supp_filing_date.key');
k4 := fileservices.dkc(MOXIE_KEY_THOR + 'key::moxie.corp_supp.sos_charter_nbr.key', MOXIE_DESPRAY_SERVER, MOXIE_CORP_MOUNT + 'corp2_supp.sos_charter_nbr.key');
export DKC_Corp_Supp_Keys := sequential(k,k1,k2,k3,k4);