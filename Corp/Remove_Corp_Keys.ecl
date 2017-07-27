cleanup(STRING file) := IF(FileServices.FileExists(file),
	FileServices.DeleteLogicalFile(file), OUTPUT('File "' + file + '" does not exist.'));

k := cleanup('~thor_data400::key::moxie.corp.bdid.key');
k1 := cleanup('~thor_data400::key::moxie.corp.cn.key');
k2 := cleanup('~thor_data400::key::moxie.corp.corp_key.key');
k3 := cleanup('~thor_data400::key::moxie.corp.corpname.key');
k4 := cleanup('~thor_data400::key::moxie.corp.fein.key');
k5 := cleanup('~thor_data400::key::moxie.corp.nameasis.key');
k6 := cleanup('~thor_data400::key::moxie.corp.sos_charter_nbr.key');
k7 := cleanup('~thor_data400::key::moxie.corp.st.city.cn.key');
k8 := cleanup('~thor_data400::key::moxie.corp.st.city.corpname.key');
k9 := cleanup('~thor_data400::key::moxie.corp.st.city.nameasis.key');
k10 := cleanup('~thor_data400::key::moxie.corp.st.city.prim_name.prim_range.pre_dir.post_dir.suffix.key');
k11 := cleanup('~thor_data400::key::moxie.corp.st.cn.key');
k12 := cleanup('~thor_data400::key::moxie.corp.st.corpname.key');
k13 := cleanup('~thor_data400::key::moxie.corp.st.nameasis.key');
k14 := cleanup('~thor_data400::key::moxie.corp.st_orig.sos_charter_nbr.key');
k15 := cleanup('~thor_data400::key::moxie.corp.z5.prim_name.prim_range.key');
k16 := cleanup('~thor_data400::key::moxie.corp.zip.street_name.prim_range.key');
k17 := cleanup('~thor_data400::key::moxie.corp.zip.street_name.suffix.predir.postdir.prim_range.company.key');
k18 := cleanup('~thor_data400::key::moxie.corp.fpos.data.key');
export Remove_Corp_Keys := sequential(k,k1,k2,k3,k4,k5,k6,k7,k8,k9,k10,k11,k12,k13,k14,k15,k16,k17,k18);