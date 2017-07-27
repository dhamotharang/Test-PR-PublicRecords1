dkc(STRING file, string server, string destination) := IF(FileServices.FileExists(file),
		fileservices.dkc(file,server,destination), 
		OUTPUT('File "' + file + '" does not exist, so no dkc performed'));


k0 := dkc(Bus_Thor + 'key::moxie.bh.contacts.bdid.key', MOXIE_BH_DESPRAY_SERVER, MOXIE_BH_MOUNT + 'bus_cont/bus_cont.bdid.key');
k1 := dkc(Bus_Thor + 'key::moxie.bh.contacts.z5.prim_name.suffix.predir.postdir.prim_range.sec_range.key', MOXIE_BH_DESPRAY_SERVER, MOXIE_BH_MOUNT + 'bus_cont/bus_cont.z5.prim_name.suffix.predir.postdir.prim_range.sec_range.key');
k2 := dkc(Bus_Thor + 'key::moxie.bh.contacts.st.city.lfmname.key', MOXIE_BH_DESPRAY_SERVER, MOXIE_BH_MOUNT + 'bus_cont/bus_cont.st.city.lfmname.key');
k3 := dkc(Bus_Thor + 'key::moxie.bh.contacts.st.lfmname.key', MOXIE_BH_DESPRAY_SERVER, MOXIE_BH_MOUNT + 'bus_cont/bus_cont.st.lfmname.key');
k4 := dkc(Bus_Thor + 'key::moxie.bh.contacts.ssn.key', MOXIE_BH_DESPRAY_SERVER, MOXIE_BH_MOUNT + 'bus_cont/bus_cont.ssn.key');
k5 := dkc(Bus_Thor + 'key::moxie.bh.contacts.did.key', MOXIE_BH_DESPRAY_SERVER, MOXIE_BH_MOUNT + 'bus_cont/bus_cont.did.key');
k6 := dkc(Bus_Thor + 'key::moxie.bh.contacts.lfmname.key', MOXIE_BH_DESPRAY_SERVER, MOXIE_BH_MOUNT + 'bus_cont/bus_cont.lfmname.key');
k7 := dkc(Bus_Thor + 'key::moxie.bh.contacts.z5.prim_name.prim_range.key', MOXIE_BH_DESPRAY_SERVER, MOXIE_BH_MOUNT + 'bus_cont/bus_cont.z5.prim_name.prim_range.key');
k8 := dkc(Bus_Thor + 'key::moxie.bh.contacts.fpos.data.key', MOXIE_BH_DESPRAY_SERVER, MOXIE_BH_MOUNT + 'bus_cont/bus_cont.fpos.data.key');


export DKC_BH_Contacts_Keys := sequential(k0,k1,k2,k3,k4,k5,k6,k7,k8);