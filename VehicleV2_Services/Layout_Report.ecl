IMPORT VehicleV2;

EXPORT Layout_Report := RECORD

  BOOLEAN is_current;

  UNSIGNED2 min_party_penalty;

  STRING15 DataSource := constant.local_val;
  
  BOOLEAN NonDMVSource;
  
  Layout_Report_Vehicle;
  
  Layout_Vehicle_Key.Sequence_Key;

  // Layout_Report_Plate plate;
  
  VehicleV2_Services.assorted_layouts.matched_party_rec matched_party;

  DATASET(VehicleV2_Services.assorted_layouts.Layout_registrant) registrants {MAXCOUNT(Constant.max_child_count)};

  DATASET(VehicleV2_Services.assorted_layouts.Layout_owner) owners {MAXCOUNT(Constant.max_child_count)};

  // Layout_Report_Title title;
  
  DATASET(VehicleV2_Services.assorted_layouts.Layout_lienholder) lienholders {MAXCOUNT(Constant.max_child_count)};

  DATASET(VehicleV2_Services.assorted_layouts.Layout_lessee) lessees {MAXCOUNT(Constant.max_child_count)};

  DATASET(VehicleV2_Services.assorted_layouts.layout_lessee_or_lessor) lessors {MAXCOUNT(Constant.max_child_count)};
  
END;
