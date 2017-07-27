cleanup(STRING file) := IF(FileServices.FileExists(file),
	FileServices.DeleteLogicalFile(file), OUTPUT('File "' + file + '" does not exist.'));

k := cleanup('~thor_data400::key::moxie.corp_cont.bdid.key');
k1 := cleanup('~thor_data400::key::moxie.corp_cont.cn.key');
k2 := cleanup('~thor_data400::key::moxie.corp_cont.corp_key.key');
k3 := cleanup('~thor_data400::key::moxie.corp_cont.corpname.key');
k4 := cleanup('~thor_data400::key::moxie.corp_cont.did.key');
k5 := cleanup('~thor_data400::key::moxie.corp_cont.lfmname.key');
k6 := cleanup('~thor_data400::key::moxie.corp_cont.nameasis.key');
k7 := cleanup('~thor_data400::key::moxie.corp_cont.sos_charter_nbr.key');
k8 := cleanup('~thor_data400::key::moxie.corp_cont.st.city.cn.key');
k9 := cleanup('~thor_data400::key::moxie.corp_cont.st.city.corpname.key');
k10 := cleanup('~thor_data400::key::moxie.corp_cont.st.city.lfmname.key');
k11 := cleanup('~thor_data400::key::moxie.corp_cont.st.city.nameasis.key');
k12 := cleanup('~thor_data400::key::moxie.corp_cont.st.city.prim_name.prim_range.pre_dir.post_dir.suffix.key');
k13 := cleanup('~thor_data400::key::moxie.corp_cont.st.cn.key');
k14 := cleanup('~thor_data400::key::moxie.corp_cont.st.corpname.key');
k15 := cleanup('~thor_data400::key::moxie.corp_cont.st.lfmname.key');
k16 := cleanup('~thor_data400::key::moxie.corp_cont.st.nameasis.key');
k17 := cleanup('~thor_data400::key::moxie.corp_cont.st_orig.sos_charter_nbr.key');
k18 := cleanup('~thor_data400::key::moxie.corp_cont.z5.prim_name.prim_range.key');
k19 := cleanup('~thor_data400::key::moxie.corp_cont.z5.street_name.suffix.predir.postdir.prim_range.lfmname.key');
k20 := cleanup('~thor_data400::key::moxie.corp_cont.fpos.data.key');

export Remove_Corp_Cont_Keys := sequential(k,k1,k2,k3,k4,k5,k6,k7,k8,k9,k10,k11,k12,k13,k14,k15,k16,k17,k18,k19,k20);