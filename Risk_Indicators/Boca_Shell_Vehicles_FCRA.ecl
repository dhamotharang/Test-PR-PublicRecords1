IMPORT drivers, doxie_files, fcra, VehicleV2;

EXPORT Boca_Shell_Vehicles_FCRA (GROUPED DATASET(Layout_Boca_Shell_ids) ids,
						                     unsigned1 dppa, boolean dppa_ok) :=
FUNCTION

unsigned2 MAX_OVERRIDE_VEHICLES := 100;
unsigned2 MAX_VEHICLES := 100;

vehrec := RECORD
	Layout_Boca_Shell_ids;
	Layout_Vehicles.Vehicle_Set;
	unsigned1 relative_owned_count := 0;
END;

vehrecplus := RECORD
	vehrec;
	DATASET(Layout_Vehicles.Vehicle_Information) vehicles;
	DATASET(Layout_Vehicles.Vehicle_Information) corrections;
END;

Layout_Vehicles.Vehicle_Information correct_veh(FCRA.Key_Override_Vehicles_FFID ri) := TRANSFORM
	SELF.year_make := (INTEGER)ri.Best_Model_Year;
	SELF.make := ri.Best_Make_Code;
	SELF.model := ri.Best_Model_Code;
	SELF.title := (INTEGER)ri.LIEN_COUNTxBG10=0;
	SELF.vin := ri.orig_vin;
END;

vehrecplus get_vehicles(ids L, VehicleV2.Key_BocaShell_Vehicles_FCRA R) := transform
	self := L;
	
	vehicle1 := R.vehicle1;
	vehicle2 := r.vehicle2;
	vehicle3 := r.vehicle3;
	self.vehicles := PROJECT(vehicle1 & vehicle2 & vehicle3, Layout_Vehicles.Vehicle_Information);
	
	// Pull corrected Vehicle Records for this particular person
  //deduping by VIN, if required, can be made here.
	self.corrections := PROJECT (CHOOSEN (FCRA.Key_Override_Vehicles_FFID (keyed(flag_file_id IN L.veh_correct_ffid)), MAX_OVERRIDE_VEHICLES), correct_Veh(LEFT));

	self := R;
end;

// nofold to keep the project below away from the join; so that the index read only happens once
outf := nofold (JOIN (ids(~isrelat), VehicleV2.Key_BocaShell_Vehicles_FCRA,
                      keyed(left.did = right.did),
                      get_vehicles(LEFT,RIGHT),
                      LIMIT (MAX_VEHICLES, SKIP)));

vehrecplus correct(vehrecplus le) := TRANSFORM
	// Find those with vin not in the override file
	// NB: If the vin is in veh_corrections but not in the vehicles override key, then it implies a delete
	good_vehicles := le.vehicles(vin != '' AND vin NOT IN le.veh_correct_vin);

  // add new vehicles and verify existing vehicles:
  // vehicles_verified := JOIN (le.corrections, le.vehicles, LEFT.vin=RIGHT.vin, LEFT OUTER, LOOKUP);
  // self.vehicles := vehicles_verified & good_vehicles;
  //assume corrections are properly deduped
  self.vehicles := le.corrections & good_vehicles;
  
	SELF := le;
END;

// nofold to keep the project below away from this project; so that the JOIN logic only happens once
outf_corrected := nofold(PROJECT(outf, correct(LEFT)));

vehrec split(vehrecplus le) := TRANSFORM
	self.vehicle1 := le.vehicles[1];
	self.vehicle2 := le.vehicles[2];
	self.vehicle3 := le.vehicles[3];
	SELF := le;
END;

outf_split := PROJECT(outf_corrected, split(LEFT));

return ungroup(outf_split);

END;