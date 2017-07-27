import VehicleV2, VehLic, Doxie, ut;

get_recs	:= VehicleV2.file_VehicleV2_Main;

//slim_party := table(get_recs(orig_vin != '' or vina_vin != ''), {orig_vin, vina_vin, Vehicle_Key, Iteration_Key, state_origin});

slim_rec := record
	string25 VIN;
	string30 Vehicle_Key;
	string15 Iteration_Key;
	string2  state_origin;
end;

slim_rec tnormalize(get_recs L, integer cnt) := transform
	self.VIN := choose(cnt, L.orig_vin, L.vina_vin);
	self := L;
end;

party_norm  := normalize(get_recs(orig_vin != '' or vina_vin != ''), 2, tnormalize(left, counter));

party_dedup := dedup(party_norm(vin <> ''), all);

export Key_vehicle_VIN_FCRA := index(party_dedup, {VIN, state_origin}, {Vehicle_Key,Iteration_Key},
	'~thor_data400::key::VehicleV2::fcra::VIN_'+ doxie.Version_SuperKey);
