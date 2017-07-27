//WARNING: THIS KEY IS AN FCRA KEY...
import doxie;

f := File_VehicleContacts;

i_rec := RECORD
	unsigned6 sdid := f.did;
	unsigned1 pick := CASE (f.rec_source, 'own_1' => 1, 'own_2' => 2, 'reg_1' => 3, 'reg_2' => 4, 0);
	f.seq_no;
END;

t := TABLE (f, i_rec);
r := t(sdid != 0, pick != 0);
d := DEDUP(r, sdid, seq_no, ALL);

//Old name: '~thor_data400::key::'+doxie_build.buildstate+'vehicle_did_'+doxie.Version_SuperKey);
export key_vehicle_did_FCRA := INDEX (d, {d.sdid}, {d.pick, d.seq_no},
                                      '~thor_data400::key::vehicle::fcra::did_' + doxie.Version_SuperKey);
