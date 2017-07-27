dkc(STRING file, string server, string destination) := IF(FileServices.FileExists(file),
		fileservices.dkc(file,server,destination), 
		OUTPUT('File "' + file + '" does not exist, so no dkc performed'));

k0 := dkc(Bus_Thor + 'key::moxie.bh.relatives.fpos.data.key', MOXIE_BH_DESPRAY_SERVER, MOXIE_BH_MOUNT + 'bus_relatives/bus_relatives.fpos.data.key');
k1 := dkc(Bus_Thor + 'key::moxie.bh.relatives.bdid1.name_address.corp_charter_number.fbn_filing.fein.phone.bankruptcy_filing.key', MOXIE_BH_DESPRAY_SERVER, MOXIE_BH_MOUNT + 'bus_relatives/bus_relatives.bdid1.name_address.corp_charter_number.fbn_filing.fein.phone.bankruptcy_filing.key');
k2 := dkc(Bus_Thor + 'key::moxie.bh.best.bdid.key', MOXIE_BH_DESPRAY_SERVER, MOXIE_BH_MOUNT + 'bus_hdr_best/bus_hdr_best.bdid.key');
k3 := dkc(Bus_Thor + 'key::moxie.bh.best.fpos.data.key', MOXIE_BH_DESPRAY_SERVER, MOXIE_BH_MOUNT + 'bus_hdr_best/bus_hdr_best.fpos.data.key');
k4 := dkc(Bus_Thor + 'key::moxie.bh.stat.bdid.key', MOXIE_BH_DESPRAY_SERVER, MOXIE_BH_MOUNT + 'bus_hdr_stat/bus_hdr_stat.bdid.key');
k5 := dkc(Bus_Thor + 'key::moxie.bh.stat.fpos.data.key', MOXIE_BH_DESPRAY_SERVER, MOXIE_BH_MOUNT + 'bus_hdr_stat/bus_hdr_stat.fpos.data.key');

export DKC_BH_MISC_Keys := sequential(k0,k1,k2,k3,k4,k5);