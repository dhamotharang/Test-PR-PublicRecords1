import ut, doxie;

df_base := VehicleV2.Files.Base.Party;

df_dist	:= distribute(df_base, hash(vehicle_key,iteration_key,sequence_key));

l_blur := record
	string10 license_plate_blur;
	string10 license_plate;
end;

l_blur toNorm(df_dist L, unsigned C) := transform
	plate										:= trim(choose(C, L.Reg_True_License_Plate, L.Reg_License_Plate, L.Reg_Previous_License_Plate), all);
	self.license_plate			:= if(plate<>'', plate, skip);
	self.license_plate_blur	:= ''; // we'll get to this later
end;

ds_norm := normalize(df_dist(Reg_True_License_Plate<>'' or Reg_License_Plate<>'' or Reg_Previous_License_Plate<>''), 3, toNorm(left,counter));

ds_dedup := dedup(sort(ds_norm, license_plate),license_plate);

l_blur toBlur(ds_dedup L) := transform
	self.license_plate_blur	:= ut.blur(L.license_plate);
	self.license_plate			:= L.license_plate;
end;

ds_blur := project(ds_dedup, toBlur(left));

export Key_Vehicle_Lic_Plate_Blur := index(
	ds_blur, {license_plate_blur}, {ds_blur},
	'~thor_data400::key::VehicleV2::lic_plate_blur_'+ doxie.Version_SuperKey);