import UCCD;                                                                                                                                                         
                                                                                                                                                                                                                                                                  
/*dkc(STRING keyfile, string server, string destination) := IF(FileServices.FileExists(keyfile),
		fileservices.fileservices.dkc(keyfile,server,destination), 
		OUTPUT('File "' + keyfile + '" does not exist, so no dkc performed'));*/


k0 := fileservices.dkc(UCCD.cluster_thor + 'key::moxie_ucc_collateral2.fpos.data_20050715', UCCD.MOXIE_DKC_SERVER, UCCD.MOXIE_MOUNT + 'moxie_ucc_collateral2.fpos.data_20050715');
k1 := fileservices.dkc(UCCD.cluster_thor + 'key::moxie_ucc_collateral2.ucc_key.event_key_20050715', UCCD.MOXIE_DKC_SERVER, UCCD.MOXIE_MOUNT + 'moxie_ucc_collateral2.ucc_key.event_key_20050715');
k2 := fileservices.dkc(UCCD.cluster_thor + 'key::moxie_ucc_debtor2.bdid_20050715', UCCD.MOXIE_DKC_SERVER, UCCD.MOXIE_MOUNT + 'moxie_ucc_debtor2.bdid_20050715');
k3 := fileservices.dkc(UCCD.cluster_thor + 'key::moxie_ucc_debtor2.cn_20050715', UCCD.MOXIE_DKC_SERVER, UCCD.MOXIE_MOUNT + 'moxie_ucc_debtor2.cn_20050715');
k4 := fileservices.dkc(UCCD.cluster_thor + 'key::moxie_ucc_debtor2.did_20050715', UCCD.MOXIE_DKC_SERVER, UCCD.MOXIE_MOUNT + 'moxie_ucc_debtor2.did_20050715');
k5 := fileservices.dkc(UCCD.cluster_thor + 'key::moxie_ucc_debtor2.fpos.data_20050715', UCCD.MOXIE_DKC_SERVER, UCCD.MOXIE_MOUNT + 'moxie_ucc_debtor2.fpos.data_20050715');
k6 := fileservices.dkc(UCCD.cluster_thor + 'key::moxie_ucc_debtor2.lfmname_20050715', UCCD.MOXIE_DKC_SERVER, UCCD.MOXIE_MOUNT + 'moxie_ucc_debtor2.lfmname_20050715');
k7 := fileservices.dkc(UCCD.cluster_thor + 'key::moxie_ucc_debtor2.nameasis_20050715', UCCD.MOXIE_DKC_SERVER, UCCD.MOXIE_MOUNT + 'moxie_ucc_debtor2.nameasis_20050715');
k8 := fileservices.dkc(UCCD.cluster_thor + 'key::moxie_ucc_debtor2.orig_filing_num.file_state_20050715', UCCD.MOXIE_DKC_SERVER, UCCD.MOXIE_MOUNT + 'moxie_ucc_debtor2.orig_filing_num.file_state_20050715');
k9 := fileservices.dkc(UCCD.cluster_thor + 'key::moxie_ucc_debtor2.ssn_20050715', UCCD.MOXIE_DKC_SERVER, UCCD.MOXIE_MOUNT + 'moxie_ucc_debtor2.ssn_20050715');
k10 := fileservices.dkc(UCCD.cluster_thor + 'key::moxie_ucc_debtor2.st.city.cn_20050715', UCCD.MOXIE_DKC_SERVER, UCCD.MOXIE_MOUNT + 'moxie_ucc_debtor2.st.city.cn_20050715');
k11 := fileservices.dkc(UCCD.cluster_thor + 'key::moxie_ucc_debtor2.st.city.lfmname_20050715', UCCD.MOXIE_DKC_SERVER, UCCD.MOXIE_MOUNT + 'moxie_ucc_debtor2.st.city.lfmname_20050715');
k12 := fileservices.dkc(UCCD.cluster_thor + 'key::moxie_ucc_debtor2.st.city.nameasis_20050715', UCCD.MOXIE_DKC_SERVER, UCCD.MOXIE_MOUNT + 'moxie_ucc_debtor2.st.city.nameasis_20050715');
k13 := fileservices.dkc(UCCD.cluster_thor + 'key::moxie_ucc_debtor2.st.city.prim_name.prim_range.predir.postdir.suffix_20050715', UCCD.MOXIE_DKC_SERVER, UCCD.MOXIE_MOUNT + 'moxie_ucc_debtor2.st.city.prim_name.prim_range.predir.postdir.suffix_20050715');
k14 := fileservices.dkc(UCCD.cluster_thor + 'key::moxie_ucc_debtor2.st.cn_20050715', UCCD.MOXIE_DKC_SERVER, UCCD.MOXIE_MOUNT + 'moxie_ucc_debtor2.st.cn_20050715');
k15 := fileservices.dkc(UCCD.cluster_thor + 'key::moxie_ucc_debtor2.st.lfmname_20050715', UCCD.MOXIE_DKC_SERVER, UCCD.MOXIE_MOUNT + 'moxie_ucc_debtor2.st.lfmname_20050715');
k16 := fileservices.dkc(UCCD.cluster_thor + 'key::moxie_ucc_debtor2.st.nameasis_20050715', UCCD.MOXIE_DKC_SERVER, UCCD.MOXIE_MOUNT + 'moxie_ucc_debtor2.st.nameasis_20050715');
k17 := fileservices.dkc(UCCD.cluster_thor + 'key::moxie_ucc_debtor2.ucc_key.event_key_20050715', UCCD.MOXIE_DKC_SERVER, UCCD.MOXIE_MOUNT + 'moxie_ucc_debtor2.ucc_key.event_key_20050715');
k18 := fileservices.dkc(UCCD.cluster_thor + 'key::moxie_ucc_debtor2.z5.prim_name.prim_range.lname_20050715', UCCD.MOXIE_DKC_SERVER, UCCD.MOXIE_MOUNT + 'moxie_ucc_debtor2.z5.prim_name.prim_range.lname_20050715');
k19 := fileservices.dkc(UCCD.cluster_thor + 'key::moxie_ucc_debtor2.zip.cn_20050715', UCCD.MOXIE_DKC_SERVER, UCCD.MOXIE_MOUNT + 'moxie_ucc_debtor2.zip.cn_20050715');
k20 := fileservices.dkc(UCCD.cluster_thor + 'key::moxie_ucc_debtor2.zip.lfmname_20050715', UCCD.MOXIE_DKC_SERVER, UCCD.MOXIE_MOUNT + 'moxie_ucc_debtor2.zip.lfmname_20050715');
k21 := fileservices.dkc(UCCD.cluster_thor + 'key::moxie_ucc_debtor2.zip.nameasis_20050715', UCCD.MOXIE_DKC_SERVER, UCCD.MOXIE_MOUNT + 'moxie_ucc_debtor2.zip.nameasis_20050715');
k22 := fileservices.dkc(UCCD.cluster_thor + 'key::moxie_ucc_debtor2.zip.prim_name.suffix.predir.postdir.prim_range_20050715', UCCD.MOXIE_DKC_SERVER, UCCD.MOXIE_MOUNT + 'moxie_ucc_debtor2.zip.prim_name.suffix.predir.postdir.prim_range_20050715');
k23 := fileservices.dkc(UCCD.cluster_thor + 'key::moxie_ucc_debtor2.zip.street_name.suffix.predir.postdir.prim_range.company_20050715', UCCD.MOXIE_DKC_SERVER, UCCD.MOXIE_MOUNT + 'moxie_ucc_debtor2.zip.street_name.suffix.predir.postdir.prim_range.company_20050715');
k24 := fileservices.dkc(UCCD.cluster_thor + 'key::moxie_ucc_events2.fpos.data_20050715', UCCD.MOXIE_DKC_SERVER, UCCD.MOXIE_MOUNT + 'moxie_ucc_events2.fpos.data_20050715');
k25 := fileservices.dkc(UCCD.cluster_thor + 'key::moxie_ucc_events2.ucc_key.event_key_20050715', UCCD.MOXIE_DKC_SERVER, UCCD.MOXIE_MOUNT + 'moxie_ucc_events2.ucc_key.event_key_20050715');
k26 := fileservices.dkc(UCCD.cluster_thor + 'key::moxie_ucc_events2.ucc_key.filing_date_20050715', UCCD.MOXIE_DKC_SERVER, UCCD.MOXIE_MOUNT + 'moxie_ucc_events2.ucc_key.filing_date_20050715');
k27 := fileservices.dkc(UCCD.cluster_thor + 'key::moxie_ucc_secured2.fpos.data_20050715', UCCD.MOXIE_DKC_SERVER, UCCD.MOXIE_MOUNT + 'moxie_ucc_secured2.fpos.data_20050715');
k28 := fileservices.dkc(UCCD.cluster_thor + 'key::moxie_ucc_secured2.ucc_key.event_key_20050715', UCCD.MOXIE_DKC_SERVER, UCCD.MOXIE_MOUNT + 'moxie_ucc_secured2.ucc_key.event_key_20050715');
k29 := fileservices.dkc(UCCD.cluster_thor + 'key::moxie_ucc_summary2.fpos.data_20050715', UCCD.MOXIE_DKC_SERVER, UCCD.MOXIE_MOUNT + 'moxie_ucc_summary2.fpos.data_20050715');
k30 := fileservices.dkc(UCCD.cluster_thor + 'key::moxie_ucc_summary2.ucc_key_20050715', UCCD.MOXIE_DKC_SERVER, UCCD.MOXIE_MOUNT + 'moxie_ucc_summary2.ucc_key_20050715');




export  DKC_keys := sequential(k1,k2,k3,k4,k5,k6,k7,k8,k9,k10,k11,k12,k13,k14,k15,k16,k17,k18,k19,k20,k21,k22,k23,k24,k25,k26,k27,k28,k29,k30);