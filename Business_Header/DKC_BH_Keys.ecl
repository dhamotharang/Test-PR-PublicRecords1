dkc(STRING file, string server, string destination) := IF(FileServices.FileExists(file),
		fileservices.dkc(file,server,destination), 
		OUTPUT('File "' + file + '" does not exist, so no dkc performed'));

k0 := dkc(Bus_Thor + 'key::moxie.bh.phoneno.key', MOXIE_BH_DESPRAY_SERVER, MOXIE_BH_MOUNT + 'bus_hdr/bus_hdr.phoneno.key');
k1 := dkc(Bus_Thor + 'key::moxie.bh.fein.key', MOXIE_BH_DESPRAY_SERVER, MOXIE_BH_MOUNT + 'bus_hdr/bus_hdr.fein.key');
k2 := dkc(Bus_Thor + 'key::moxie.bh.bdid.key', MOXIE_BH_DESPRAY_SERVER, MOXIE_BH_MOUNT + 'bus_hdr/bus_hdr.bdid.key');
k3 := dkc(Bus_Thor + 'key::moxie.bh.z5.prim_name.prim_range.key', MOXIE_BH_DESPRAY_SERVER, MOXIE_BH_MOUNT + 'bus_hdr/bus_hdr.z5.prim_name.prim_range.key');
k4 := dkc(Bus_Thor + 'key::moxie.bh.zip.street_name.suffix.predir.postdir.prim_range.company.sec_range.key', MOXIE_BH_DESPRAY_SERVER, MOXIE_BH_MOUNT + 'bus_hdr/bus_hdr.zip.street_name.suffix.predir.postdir.prim_range.company.sec_range.key');
k5 := dkc(Bus_Thor + 'key::moxie.bh.cn.key', MOXIE_BH_DESPRAY_SERVER, MOXIE_BH_MOUNT + 'bus_hdr/bus_hdr.cn.key');
k6 := dkc(Bus_Thor + 'key::moxie.bh.st.cn.key', MOXIE_BH_DESPRAY_SERVER, MOXIE_BH_MOUNT + 'bus_hdr/bus_hdr.st.cn.key');
k7 := dkc(Bus_Thor + 'key::moxie.bh.st.city.cn.key', MOXIE_BH_DESPRAY_SERVER, MOXIE_BH_MOUNT + 'bus_hdr/bus_hdr.st.city.cn.key');
k8 := dkc(Bus_Thor + 'key::moxie.bh.z5.cn.key', MOXIE_BH_DESPRAY_SERVER, MOXIE_BH_MOUNT + 'bus_hdr/bus_hdr.z5.cn.key');
k9 := dkc(Bus_Thor + 'key::moxie.bh.lat25.long25.cn.key', MOXIE_BH_DESPRAY_SERVER, MOXIE_BH_MOUNT + 'bus_hdr/bus_hdr.lat25.long25.cn.key');
k10 := dkc(Bus_Thor + 'key::moxie.bh.nameasis.key', MOXIE_BH_DESPRAY_SERVER, MOXIE_BH_MOUNT + 'bus_hdr/bus_hdr.nameasis.key');
k11 := dkc(Bus_Thor + 'key::moxie.bh.st.nameasis.key', MOXIE_BH_DESPRAY_SERVER, MOXIE_BH_MOUNT + 'bus_hdr/bus_hdr.st.nameasis.key');
k12 := dkc(Bus_Thor + 'key::moxie.bh.st.city.nameasis.key', MOXIE_BH_DESPRAY_SERVER, MOXIE_BH_MOUNT + 'bus_hdr/bus_hdr.st.city.nameasis.key');
k13 := dkc(Bus_Thor + 'key::moxie.bh.z5.nameasis.key', MOXIE_BH_DESPRAY_SERVER, MOXIE_BH_MOUNT + 'bus_hdr/bus_hdr.z5.nameasis.key');
k14 := dkc(Bus_Thor + 'key::moxie.bh.pcn.nameasis.key', MOXIE_BH_DESPRAY_SERVER, MOXIE_BH_MOUNT + 'bus_hdr/bus_hdr.pcn.nameasis.key');
k15 := dkc(Bus_Thor + 'key::moxie.bh.st.pcn.nameasis.key', MOXIE_BH_DESPRAY_SERVER, MOXIE_BH_MOUNT + 'bus_hdr/bus_hdr.st.pcn.nameasis.key');
k16 := dkc(Bus_Thor + 'key::moxie.bh.st.city.pcn.nameasis.key', MOXIE_BH_DESPRAY_SERVER, MOXIE_BH_MOUNT + 'bus_hdr/bus_hdr.st.city.pcn.nameasis.key');
k17 := dkc(Bus_Thor + 'key::moxie.bh.z5.pcn.nameasis.key', MOXIE_BH_DESPRAY_SERVER, MOXIE_BH_MOUNT + 'bus_hdr/bus_hdr.z5.pcn.nameasis.key');
k18 := dkc(Bus_Thor + 'key::moxie.bh.dph_cname.prim_range.dph_street.name_company.prim_range.predir.street.sec_range.pcity.st.z5.phone10.key', MOXIE_BH_DESPRAY_SERVER, MOXIE_BH_MOUNT + 'bus_hdr/bus_hdr.dph_cname.prim_range.dph_street.name_company.prim_range.predir.street.sec_range.pcity.st.z5.phone10.key');
k19 := dkc(Bus_Thor + 'key::moxie.bh.dph_cname.z5.name_company.prim_range.predir.street.sec_range.pcity.st.z5.phone10.key', MOXIE_BH_DESPRAY_SERVER, MOXIE_BH_MOUNT + 'bus_hdr/bus_hdr.dph_cname.z5.name_company.prim_range.predir.street.sec_range.pcity.st.z5.phone10.key');
k20 := dkc(Bus_Thor + 'key::moxie.bh.dph_cname.z3.name_company.prim_range.predir.street.sec_range.pcity.st.z5.phone10.key', MOXIE_BH_DESPRAY_SERVER, MOXIE_BH_MOUNT + 'bus_hdr/bus_hdr.dph_cname.z3.name_company.prim_range.predir.street.sec_range.pcity.st.z5.phone10.key');
k21 := dkc(Bus_Thor + 'key::moxie.bh.st.dph_cname.name_company.prim_range.predir.street.sec_range.pcity.st.z5.phone10.key', MOXIE_BH_DESPRAY_SERVER, MOXIE_BH_MOUNT + 'bus_hdr/bus_hdr.st.dph_cname.name_company.prim_range.predir.street.sec_range.pcity.st.z5.phone10.key');
k22 := dkc(Bus_Thor + 'key::moxie.bh.exchange.name_company.prim_range.predir.street.sec_range.pcity.st.z5.phone10.key', MOXIE_BH_DESPRAY_SERVER, MOXIE_BH_MOUNT + 'bus_hdr/bus_hdr.exchange.name_company.prim_range.predir.street.sec_range.pcity.st.z5.phone10.key');
k23 := dkc(Bus_Thor + 'key::moxie.bh.prim_range.st.dph_city.name_company.prim_range.predir.street.sec_range.pcity.st.z5.phone10.key', MOXIE_BH_DESPRAY_SERVER, MOXIE_BH_MOUNT + 'bus_hdr/bus_hdr.prim_range.st.dph_city.name_company.prim_range.predir.street.sec_range.pcity.st.z5.phone10.key');
k24 := dkc(Bus_Thor + 'key::moxie.bh.prim_range.z5.name_company.prim_range.predir.street.sec_range.pcity.st.z5.phone10.key', MOXIE_BH_DESPRAY_SERVER, MOXIE_BH_MOUNT + 'bus_hdr/bus_hdr.prim_range.z5.name_company.prim_range.predir.street.sec_range.pcity.st.z5.phone10.key');
k25 := dkc(Bus_Thor + 'key::moxie.bh.fpos.data.key', MOXIE_BH_DESPRAY_SERVER, MOXIE_BH_MOUNT + 'bus_hdr/bus_hdr.fpos.data.key');

export DKC_BH_Keys := sequential(k0,k1,k2,k3,k4,k5,k6,k7,k8,k9,k10,k11,k12,k13,k14,k15,k16,k17,k18,k19,k20,k21,k22,k23,k24,k25);
