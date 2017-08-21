import UCCD;                                                                                                                                                         
                                                                                                                                                                                                                                                                  
/*dkc(STRING keyfile, string server, string destination) := IF(FileServices.FileExists(keyfile),
		fileservices.fileservices.dkc(keyfile,server,destination), 
		OUTPUT('File "' + keyfile + '" does not exist, so no dkc performed'));*/


k1 := fileservices.dkc(UCCD.cluster_thor + 'key::moxie.ucc2_collateral.fpos.data_' + uccd.version_development, UCCD.MOXIE_DKC_SERVER, UCCD.MOXIE_MOUNT + 'ucc2_collateral.fpos.data.key');
k2 := fileservices.dkc(UCCD.cluster_thor + 'key::moxie.ucc2_collateral.ucc_key.event_key_' + uccd.version_development, UCCD.MOXIE_DKC_SERVER, UCCD.MOXIE_MOUNT + 'ucc2_collateral.ucc_key.event_key.key');
k3 := fileservices.dkc(UCCD.cluster_thor + 'key::moxie.ucc2_debtor.bdid_' + uccd.version_development, UCCD.MOXIE_DKC_SERVER, UCCD.MOXIE_MOUNT + 'ucc2_debtor.bdid.key');
k4 := fileservices.dkc(UCCD.cluster_thor + 'key::moxie.ucc2_debtor.cn_' + uccd.version_development, UCCD.MOXIE_DKC_SERVER, UCCD.MOXIE_MOUNT + 'ucc2_debtor.cn.key');
k5 := fileservices.dkc(UCCD.cluster_thor + 'key::moxie.ucc2_debtor.did_' + uccd.version_development, UCCD.MOXIE_DKC_SERVER, UCCD.MOXIE_MOUNT + 'ucc2_debtor.did.key');
k6 := fileservices.dkc(UCCD.cluster_thor + 'key::moxie.ucc2_debtor.fpos.data_' + uccd.version_development, UCCD.MOXIE_DKC_SERVER, UCCD.MOXIE_MOUNT + 'ucc2_debtor.fpos.data.key');
k7 := fileservices.dkc(UCCD.cluster_thor + 'key::moxie.ucc2_debtor.lfmname_' + uccd.version_development, UCCD.MOXIE_DKC_SERVER, UCCD.MOXIE_MOUNT + 'ucc2_debtor.lfmname.key');
k8 := fileservices.dkc(UCCD.cluster_thor + 'key::moxie.ucc2_debtor.nameasis_' + uccd.version_development, UCCD.MOXIE_DKC_SERVER, UCCD.MOXIE_MOUNT + 'ucc2_debtor.nameasis.key');
k9 := fileservices.dkc(UCCD.cluster_thor + 'key::moxie.ucc2_debtor.orig_filing_num.file_state_' + uccd.version_development, UCCD.MOXIE_DKC_SERVER, UCCD.MOXIE_MOUNT + 'ucc2_debtor.orig_filing_num.file_state.key');
k10 := fileservices.dkc(UCCD.cluster_thor + 'key::moxie.ucc2_debtor.ssn_' + uccd.version_development, UCCD.MOXIE_DKC_SERVER, UCCD.MOXIE_MOUNT + 'ucc2_debtor.ssn.key');
k11 := fileservices.dkc(UCCD.cluster_thor + 'key::moxie.ucc2_debtor.st.city.cn_' + uccd.version_development, UCCD.MOXIE_DKC_SERVER, UCCD.MOXIE_MOUNT + 'ucc2_debtor.st.city.cn.key');
k12 := fileservices.dkc(UCCD.cluster_thor + 'key::moxie.ucc2_debtor.st.city.lfmname_' + uccd.version_development, UCCD.MOXIE_DKC_SERVER, UCCD.MOXIE_MOUNT + 'ucc2_debtor.st.city.lfmname.key');
k13 := fileservices.dkc(UCCD.cluster_thor + 'key::moxie.ucc2_debtor.st.city.nameasis_' + uccd.version_development, UCCD.MOXIE_DKC_SERVER, UCCD.MOXIE_MOUNT + 'ucc2_debtor.st.city.nameasis.key');
k14 := fileservices.dkc(UCCD.cluster_thor + 'key::moxie.ucc2_debtor.st.city.prim_name.prim_range.predir.postdir.suffix_' + uccd.version_development, UCCD.MOXIE_DKC_SERVER, UCCD.MOXIE_MOUNT + 'ucc2_debtor.st.city.prim_name.prim_range.predir.postdir.suffix.key');
k15 := fileservices.dkc(UCCD.cluster_thor + 'key::moxie.ucc2_debtor.st.cn_' + uccd.version_development, UCCD.MOXIE_DKC_SERVER, UCCD.MOXIE_MOUNT + 'ucc2_debtor.st.cn.key');
k16 := fileservices.dkc(UCCD.cluster_thor + 'key::moxie.ucc2_debtor.st.lfmname_' + uccd.version_development, UCCD.MOXIE_DKC_SERVER, UCCD.MOXIE_MOUNT + 'ucc2_debtor.st.lfmname.key');
k17 := fileservices.dkc(UCCD.cluster_thor + 'key::moxie.ucc2_debtor.st.nameasis_' + uccd.version_development, UCCD.MOXIE_DKC_SERVER, UCCD.MOXIE_MOUNT + 'ucc2_debtor.st.nameasis.key');
k18 := fileservices.dkc(UCCD.cluster_thor + 'key::moxie.ucc2_debtor.ucc_key.event_key_' + uccd.version_development, UCCD.MOXIE_DKC_SERVER, UCCD.MOXIE_MOUNT + 'ucc2_debtor.ucc_key.event_key.key');
k19 := fileservices.dkc(UCCD.cluster_thor + 'key::moxie.ucc2_debtor.z5.prim_name.prim_range.lname_' + uccd.version_development, UCCD.MOXIE_DKC_SERVER, UCCD.MOXIE_MOUNT + 'ucc2_debtor.z5.prim_name.prim_range.lname.key');
k20 := fileservices.dkc(UCCD.cluster_thor + 'key::moxie.ucc2_debtor.zip.cn_' + uccd.version_development, UCCD.MOXIE_DKC_SERVER, UCCD.MOXIE_MOUNT + 'ucc2_debtor.zip.cn.key');
k21 := fileservices.dkc(UCCD.cluster_thor + 'key::moxie.ucc2_debtor.zip.lfmname_' + uccd.version_development, UCCD.MOXIE_DKC_SERVER, UCCD.MOXIE_MOUNT + 'ucc2_debtor.zip.lfmname.key');
k22 := fileservices.dkc(UCCD.cluster_thor + 'key::moxie.ucc2_debtor.zip.nameasis_' + uccd.version_development, UCCD.MOXIE_DKC_SERVER, UCCD.MOXIE_MOUNT + 'ucc2_debtor.zip.nameasis.key');
k23 := fileservices.dkc(UCCD.cluster_thor + 'key::moxie.ucc2_debtor.zip.prim_name.suffix.predir.postdir.prim_range_' + uccd.version_development, UCCD.MOXIE_DKC_SERVER, UCCD.MOXIE_MOUNT + 'ucc2_debtor.zip.prim_name.suffix.predir.postdir.prim_range.key');
k24 := fileservices.dkc(UCCD.cluster_thor + 'key::moxie.ucc2_debtor.zip.street_name.suffix.predir.postdir.prim_range.company_' + uccd.version_development, UCCD.MOXIE_DKC_SERVER, UCCD.MOXIE_MOUNT + 'ucc2_debtor.zip.street_name.suffix.predir.postdir.prim_range.company.key');
k25 := fileservices.dkc(UCCD.cluster_thor + 'key::moxie.ucc2_debtor.zip.street_name.suffix.predir.postdir.prim_range.lfmname.sec_range_' + uccd.version_development,UCCD.MOXIE_DKC_SERVER, UCCD.MOXIE_MOUNT + 'ucc2_debtor.zip.street_name.suffix.predir.postdir.prim_range.lfmname.sec_range.key');
k26 := fileservices.dkc(UCCD.cluster_thor + 'key::moxie.ucc2_events.fpos.data_' + uccd.version_development, UCCD.MOXIE_DKC_SERVER, UCCD.MOXIE_MOUNT + 'ucc2_events.fpos.data.key');
k27 := fileservices.dkc(UCCD.cluster_thor + 'key::moxie.ucc2_events.ucc_key.event_key_' + uccd.version_development, UCCD.MOXIE_DKC_SERVER, UCCD.MOXIE_MOUNT + 'ucc2_events.ucc_key.event_key.key');
k28 := fileservices.dkc(UCCD.cluster_thor + 'key::moxie.ucc2_events.ucc_key.filing_date_' + uccd.version_development, UCCD.MOXIE_DKC_SERVER, UCCD.MOXIE_MOUNT + 'ucc2_events.ucc_key.filing_date.key');
k29 := fileservices.dkc(UCCD.cluster_thor + 'key::moxie.ucc2_secured.fpos.data_' + uccd.version_development, UCCD.MOXIE_DKC_SERVER, UCCD.MOXIE_MOUNT + 'ucc2_secured.fpos.data.key');
k30 := fileservices.dkc(UCCD.cluster_thor + 'key::moxie.ucc2_secured.ucc_key.event_key_' + uccd.version_development, UCCD.MOXIE_DKC_SERVER, UCCD.MOXIE_MOUNT + 'ucc2_secured.ucc_key.event_key.key');
k31 := fileservices.dkc(UCCD.cluster_thor + 'key::moxie.ucc2_summary.fpos.data_' + uccd.version_development, UCCD.MOXIE_DKC_SERVER, UCCD.MOXIE_MOUNT + 'ucc2_summary.fpos.data.key');
k32 := fileservices.dkc(UCCD.cluster_thor + 'key::moxie.ucc2_summary.ucc_key_' + uccd.version_development, UCCD.MOXIE_DKC_SERVER, UCCD.MOXIE_MOUNT + 'ucc2_summary.ucc_key.key');




export  DKC_keys := sequential(k1,k2,k3,k4,k5,k6,k7,k8,k9,k10,k11,k12,k13,k14,k15,k16,k17,k18,k19,k20,k21,k22,k23,k24,k25,k26,k27,k28,k29,k30,k31,k32);