export Layout_Hole_Person := record
   unsigned4 per_id;
   integer4 dob;
   unsigned8 did := 0;
   unsigned4 zip;
   string2 state;
   boolean business_owner_flag := false;
   boolean rv_flag := false;
   boolean boat_flag := false;
   boolean merchant_vessel_flag := false;
   boolean plane_flag := false;
   boolean pilot_flag := false;
   unsigned1 vehicles_leased_value := 0;    // 1000 increment
   unsigned1 vehicles_owned_value := 0;     // 1000 increment
   unsigned1 property_initial_equity := 0;  // 10000 increment
   unsigned1 property_assessed_value := 0;  // 10000 increment
  end;