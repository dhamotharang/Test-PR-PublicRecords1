import doxie_build,doxie, data_services;

f := File_VehicleContacts;

i_rec :=
RECORD
	unsigned6 sdid := f.did;
	unsigned1 pick := CASE(f.rec_source, 'own_1' => 1,
								'own_2' => 2,
								'reg_1' => 3,
								'reg_2' => 4, 0);
	f.seq_no;
END;
t := TABLE(f, i_rec);
r := t(sdid != 0, pick != 0);
d := DEDUP(r, sdid, seq_no, ALL);

export Key_Vehicle_did := INDEX(d, 
                                {d.sdid}, 
                                {d.pick, d.seq_no}, 
                                data_services.data_location.prefix() + 'thor_data400::key::'+doxie_build.buildstate+'vehicle_did_'+doxie.Version_SuperKey);