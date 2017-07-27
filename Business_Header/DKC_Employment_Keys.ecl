dkc(STRING file, string server, string destination) := IF(FileServices.FileExists(file),
		fileservices.dkc(file,server,destination), 
		OUTPUT('File "' + file + '" does not exist, so no dkc performed'));

k0 := dkc(Bus_Thor + 'key::moxie.people_at_work.fpos.data.key', MOXIE_BH_DESPRAY_SERVER, MOXIE_PAW_MOUNT + 'people_at_work.fpos.data.key');
k1 := dkc(Bus_Thor + 'key::moxie.people_at_work.lfmname.key', MOXIE_BH_DESPRAY_SERVER, MOXIE_PAW_MOUNT + 'people_at_work.lfmname.key');
k2 := dkc(Bus_Thor + 'key::moxie.people_at_work.did.key', MOXIE_BH_DESPRAY_SERVER, MOXIE_PAW_MOUNT + 'people_at_work.did.key');
k3 := dkc(Bus_Thor + 'key::moxie.people_at_work.nameasis.key', MOXIE_BH_DESPRAY_SERVER, MOXIE_PAW_MOUNT + 'people_at_work.nameasis.key');
k4 := dkc(Bus_Thor + 'key::moxie.people_at_work.st.lfmname.key', MOXIE_BH_DESPRAY_SERVER, MOXIE_PAW_MOUNT + 'people_at_work.st.lfmname.key');
k5 := dkc(Bus_Thor + 'key::moxie.people_at_work.z5.prim_name.prim_range.key', MOXIE_BH_DESPRAY_SERVER, MOXIE_PAW_MOUNT + 'people_at_work.z5.prim_name.prim_range.key');
k6 := dkc(Bus_Thor + 'key::moxie.people_at_work.bdid.key', MOXIE_BH_DESPRAY_SERVER, MOXIE_PAW_MOUNT + 'people_at_work.bdid.key');
k7 := dkc(Bus_Thor + 'key::moxie.people_at_work.did.bdid.key', MOXIE_BH_DESPRAY_SERVER, MOXIE_PAW_MOUNT + 'people_at_work.did.bdid.key');
//k8 := dkc(Bus_Thor + 'key::moxie.people_at_work.company.key', MOXIE_BH_DESPRAY_SERVER, MOXIE_PAW_MOUNT + 'people_at_work.company.key');
k9 := dkc(Bus_Thor + 'key::moxie.people_at_work.fein.key', MOXIE_BH_DESPRAY_SERVER, MOXIE_PAW_MOUNT + 'people_at_work.fein.key');
k10 := dkc(Bus_Thor + 'key::moxie.people_at_work.phoneno.key', MOXIE_BH_DESPRAY_SERVER, MOXIE_PAW_MOUNT + 'people_at_work.phoneno.key');
k11 := dkc(Bus_Thor + 'key::moxie.people_at_work.ssn.key', MOXIE_BH_DESPRAY_SERVER, MOXIE_PAW_MOUNT + 'people_at_work.ssn.key');
k12 := dkc(Bus_Thor + 'key::moxie.people_at_work.ssn.score.key', MOXIE_BH_DESPRAY_SERVER, MOXIE_PAW_MOUNT + 'people_at_work.ssn.score.key');
k13 := dkc(Bus_Thor + 'key::moxie.people_at_work.st.city.lfmname.key', MOXIE_BH_DESPRAY_SERVER, MOXIE_PAW_MOUNT + 'people_at_work.st.city.lfmname.key');
k14 := dkc(Bus_Thor + 'key::moxie.people_at_work.z5.prim_name.suffix.predir.postdir.prim_range.sec_range.key', MOXIE_BH_DESPRAY_SERVER, MOXIE_PAW_MOUNT + 'people_at_work.z5.prim_name.suffix.predir.postdir.prim_range.sec_range.key');
k15 := dkc(Bus_Thor + 'key::moxie.people_at_work.st.nameasis.key', MOXIE_BH_DESPRAY_SERVER, MOXIE_PAW_MOUNT + 'people_at_work.st.nameasis.key');
k16 := dkc(Bus_Thor + 'key::moxie.people_at_work.st.city.nameasis.key', MOXIE_BH_DESPRAY_SERVER, MOXIE_PAW_MOUNT + 'people_at_work.st.city.nameasis.key');
k17 := dkc(Bus_Thor + 'key::moxie.people_at_work.z5.nameasis.key', MOXIE_BH_DESPRAY_SERVER, MOXIE_PAW_MOUNT + 'people_at_work.z5.nameasis.key');
k18 := dkc(Bus_Thor + 'key::moxie.people_at_work.cn.key', MOXIE_BH_DESPRAY_SERVER, MOXIE_PAW_MOUNT + 'people_at_work.cn.key');
k19 := dkc(Bus_Thor + 'key::moxie.people_at_work.st.cn.key', MOXIE_BH_DESPRAY_SERVER, MOXIE_PAW_MOUNT + 'people_at_work.st.cn.key');
k20 := dkc(Bus_Thor + 'key::moxie.people_at_work.st.city.cn.key', MOXIE_BH_DESPRAY_SERVER, MOXIE_PAW_MOUNT + 'people_at_work.st.city.cn.key');
k21 := dkc(Bus_Thor + 'key::moxie.people_at_work.z5.cn.key', MOXIE_BH_DESPRAY_SERVER, MOXIE_PAW_MOUNT + 'people_at_work.z5.cn.key');

export DKC_Employment_Keys := 
	sequential(k0,k1,k2,k3,k4,k5,k6,k7,k9,k10,k11,k12,k13,k14,k15,k16,k17,k18,k19,k20,k21);