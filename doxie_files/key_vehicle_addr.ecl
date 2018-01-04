import doxie_build,doxie,AutoKey, data_services;

f := File_VehicleContacts;

i_rec :=
RECORD
	AutoKey.Layout_Address_bare;
	unsigned1 pick ;
	f.seq_no;
END;


i_rec xf_i_rec(f l) := transform
	p := CASE(l.rec_source, 	'own_1' => 1,
								'own_2' => 2,
								'reg_1' => 3,
								'reg_2' => 4, 0);

	self.pick := p;
	self.city_code := doxie.Make_CityCode(l.v_city_name); 
	self.zip := l.zip5;
	self := l;
end;

t := project(f, xf_i_rec(left));
r := t(prim_name <> '', zip <> '', pick != 0);
d := DEDUP(r, prim_name, prim_range, st, city_code, zip, sec_range, seq_no, ALL);

export Key_Vehicle_addr := INDEX(d, 
                                 {d.prim_name, d.prim_range, d.st, d.city_code, d.zip, d.sec_range}, 
                                 {d.pick, d.seq_no}, 
                                 data_services.data_location.prefix() + 'thor_data400::key::'+doxie_build.buildstate+'vehicle_addr_'+doxie.Version_SuperKey);