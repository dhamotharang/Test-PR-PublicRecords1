k  := fileservices.dkc('~thor_data400::key::moxie.corp.bdid.key', '10.150.13.201', '/corp_data2_14/corp2.bdid.key');
k1 := fileservices.dkc('~thor_data400::key::moxie.corp.cn.key', '10.150.13.201', '/corp_data2_14/corp2.cn.key');
k2 := fileservices.dkc('~thor_data400::key::moxie.corp.corp_key.key', '10.150.13.201', '/corp_data2_14/corp2.corp_key.key');
k3 := fileservices.dkc('~thor_data400::key::moxie.corp.corpname.key', '10.150.13.201', '/corp_data2_14/corp2.corpname.key');
k4 := fileservices.dkc('~thor_data400::key::moxie.corp.fein.key', '10.150.13.201', '/corp_data2_14/corp2.fein.key');
k5 := fileservices.dkc('~thor_data400::key::moxie.corp.nameasis.key', '10.150.13.201', '/corp_data2_14/corp2.nameasis.key');
k6 := fileservices.dkc('~thor_data400::key::moxie.corp.sos_charter_nbr.key', '10.150.13.201', '/corp_data2_14/corp2.sos_charter_nbr.key');
k7 := fileservices.dkc('~thor_data400::key::moxie.corp.st.city.cn.key', '10.150.13.201', '/corp_data2_14/corp2.st.city.cn.key');
k8 := fileservices.dkc('~thor_data400::key::moxie.corp.st.city.corpname.key', '10.150.13.201', '/corp_data2_14/corp2.st.city.corpname.key');
k9 := fileservices.dkc('~thor_data400::key::moxie.corp.st.city.nameasis.key', '10.150.13.201', '/corp_data2_14/corp2.st.city.nameasis.key');
k10 := fileservices.dkc('~thor_data400::key::moxie.corp.st.city.prim_name.prim_range.pre_dir.post_dir.suffix.key', '10.150.13.201', '/corp_data2_14/corp2.st.city.prim_name.prim_range.pre_dir.post_dir.suffix.key');
k11 := fileservices.dkc('~thor_data400::key::moxie.corp.st.cn.key', '10.150.13.201', '/corp_data2_14/corp2.st.cn.key');
k12 := fileservices.dkc('~thor_data400::key::moxie.corp.st.corpname.key', '10.150.13.201', '/corp_data2_14/corp2.st.corpname.key');
k13 := fileservices.dkc('~thor_data400::key::moxie.corp.st.nameasis.key', '10.150.13.201', '/corp_data2_14/corp2.st.nameasis.key');
k14 := fileservices.dkc('~thor_data400::key::moxie.corp.st_orig.sos_charter_nbr.key', '10.150.13.201', '/corp_data2_14/corp2.st_orig.sos_charter_nbr.key');
k15 := fileservices.dkc('~thor_data400::key::moxie.corp.z5.prim_name.prim_range.key', '10.150.13.201', '/corp_data2_14/corp2.z5.prim_name.prim_range.key');
k16 := fileservices.dkc('~thor_data400::key::moxie.corp.zip.street_name.prim_range.key', '10.150.13.201', '/corp_data2_14/corp2.zip.street_name.prim_range.key');
k17 := fileservices.dkc('~thor_data400::key::moxie.corp.zip.street_name.suffix.predir.postdir.prim_range.company.key', '10.150.13.201', '/corp_data2_14/corp2.zip.street_name.suffix.predir.postdir.prim_range.company.key');
k18 := fileservices.dkc('~thor_data400::key::moxie.corp.fpos.data.key', '10.150.13.201', '/corp_data2_14/corp2.fpos.data.key');

export DKC_Corp_keys := sequential(k,k1,k2,k3,k4,k5,k6,k7,k8,k9,k10,k11,k12,k13,k14,k15,k16,k17,k18);
