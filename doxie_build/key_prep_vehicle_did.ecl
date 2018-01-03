import data_services;

f := doxie_build.File_VehicleContacts_KeyBuilding;

i_rec :=
RECORD
	unsigned6 sdid := f.did;
	unsigned1 pick := CASE(f.rec_source, 'own_1' => 1,
								'own_2' => 2,
								'reg_1' => 3,
								'reg_2' => 4,
								'zz!!z' => 99, // workaround
								 0);
	f.seq_no;
END;
t := TABLE(f, i_rec);
r := t(sdid != 0, pick != 0);
d := DEDUP(r, sdid, seq_no, ALL);

export key_prep_vehicle_did :=  INDEX(d, 
                                      {d.sdid}, 
                                      {d.pick, d.seq_no}, 
                                      data_services.data_location.prefix() + 'thor_data400::key::'+doxie_build.buildstate+'vehicle_did'+thorlib.wuid());