import VehicleV2;

export Layout_Report := RECORD

	boolean is_current;

	unsigned2 min_party_penalty;

	string15 DataSource := constant.local_val;
	
	boolean NonDMVSource;
	
	Layout_Report_Vehicle;
	
	Layout_Vehicle_Key.Sequence_Key;

	// Layout_Report_Plate plate;
	
	VehicleV2_Services.assorted_layouts.matched_party_rec matched_party;

	dataset(VehicleV2_Services.assorted_layouts.Layout_registrant) registrants {maxcount(Constant.max_child_count)};

	dataset(VehicleV2_Services.assorted_layouts.Layout_owner) owners {maxcount(Constant.max_child_count)};

	// Layout_Report_Title title;
	
	dataset(VehicleV2_Services.assorted_layouts.Layout_lienholder) lienholders {maxcount(Constant.max_child_count)};

	dataset(VehicleV2_Services.assorted_layouts.Layout_lessee) lessees {maxcount(Constant.max_child_count)};

	dataset(VehicleV2_Services.assorted_layouts.layout_lessee_or_lessor) lessors {maxcount(Constant.max_child_count)};
	
END;