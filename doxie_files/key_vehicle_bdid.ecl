import doxie_build, doxie;

f := doxie_build.File_VehicleContacts_KeyBuilding;

i_rec :=
RECORD
	unsigned6 sbdid := f.bdid;
	unsigned1 pick := CASE(f.rec_source, 'own_1' => 1,
								'own_2' => 2,
								'reg_1' => 3,
								'reg_2' => 4,
								'zz!!z' => 99, // workaround
								 0);
	f.seq_no;
END;
t := TABLE(f, i_rec);
r := t(sbdid != 0, pick != 0);
d := DEDUP(r, sbdid, seq_no, ALL);

export key_vehicle_bdid :=  INDEX(d, {d.sbdid}, {d.pick, d.seq_no}, '~thor_data400::key::'+doxie_build.buildstate+'vehicle_bdid_'+doxie.Version_SuperKey);