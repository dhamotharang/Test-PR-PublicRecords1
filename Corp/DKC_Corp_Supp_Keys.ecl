k := fileservices.dkc('~thor_data400::key::moxie.corp_supp.corp_key.key', '10.150.13.201', '/corp_data2_14/corp2_supp.corp_key.key');
k1 := fileservices.dkc('~thor_data400::key::moxie.corp_supp.st_orig.sos_charter_nbr.key', '10.150.13.201', '/corp_data2_14/corp2_supp.st_orig.sos_charter_nbr.key');
k2 := fileservices.dkc('~thor_data400::key::moxie.corp_supp.bdid.key', '10.150.13.201', '/corp_data2_14/corp2_supp.bdid.key');
k3 := fileservices.dkc('~thor_data400::key::moxie.corp_supp.corp_key.supp_type_desc.supp_filing_date.key', '10.150.13.201', '/corp_data2_14/corp2_supp.corp_key.supp_type_desc.supp_filing_date.key');
k4 := fileservices.dkc('~thor_data400::key::moxie.corp_supp.sos_charter_nbr.key', '10.150.13.201', '/corp_data2_14/corp2_supp.sos_charter_nbr.key');
export DKC_Corp_Supp_Keys := sequential(k,k1,k2,k3,k4);