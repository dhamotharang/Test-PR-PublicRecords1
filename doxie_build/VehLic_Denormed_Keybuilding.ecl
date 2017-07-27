import Vehlic, doxie_files, census_data;

doxie_files.Layout_VehicleContacts getCountyName(doxie_build.File_VehicleContacts_KeyBuilding le, Census_data.File_Fips2County ri) :=
TRANSFORM
	SELF.county_name := ri.county_name;
	SELF := le;
END;
j1 := JOIN(doxie_build.File_VehicleContacts_Keybuilding, Census_data.File_Fips2County, 
				LEFT.county = RIGHT.county_fips AND LEFT.st = RIGHT.state_code, 
				getCountyName(LEFT, RIGHT), lookup, LEFT OUTER);

doxie_files.Layout_Vehicles changelayout(doxie_build.File_VehicleVehicles_KeyBuilding L) :=
TRANSFORM
	SELF := L;
END;
v := DISTRIBUTE(PROJECT(doxie_build.File_VehicleVehicles_KeyBuilding, changelayout(LEFT)), HASH(seq_no));
p := DISTRIBUTE(j1, HASH(seq_no));

den := denormalize(v, p, LEFT.seq_no = RIGHT.seq_no, tra_denormVehicles(LEFT, RIGHT), LOCAL);

export VehLic_Denormed_Keybuilding := den;