import Business_Header, VehLic, Property;

p := CreditFile.File_Indic_Plus;

// Initialize person file to enhanced person format
creditfile.layout_hole_person InitEnhancedPerson(p le) := transform
  self := le;
  end;

enhper_init := project(p, InitEnhancedPerson(left));
enhper_dist := distribute(enhper_init(did<>0), hash(did));

// Add Business Owner information
creditfile.layout_hole_person AddOwnerInfo(creditfile.layout_hole_person L, Business_Header.Layout_Business_Owner R) := transform
self.business_owner_flag := R.company_title_rank = 1;
self := L;
end;

busown_dist := distribute(Business_Header.FIle_Business_Owner(did<>0), hash(did));
busown_sort := sort(busown_dist, did, company_title_rank, local);
busown_dedup := dedup(busown_sort, did, local);

enhper_own := join(enhper_dist,
                   busown_dedup,
                   left.did = right.did,
                   AddOwnerInfo(left, right),
                   left outer,
                   local);

// Add Vehicle Information
creditfile.layout_hole_person AddVehicleInfo(creditfile.layout_hole_person L, VehLic.Layout_Vehicle_Equity R) := transform
self.vehicles_leased_value := if(ROUND(R.vehicles_leased_value / 1000) <= 255, ROUND(R.vehicles_leased_value / 1000), 255);
self.vehicles_owned_value := if(ROUND(R.vehicles_owned_value / 1000) <= 255, ROUND(R.vehicles_owned_value / 1000), 255);
self.rv_flag := R.rv_flag;
self.boat_flag := R.boat_flag;
self.merchant_vessel_flag := R.merchant_vessel_flag;
self.plane_flag := R.plane_flag;
self.pilot_flag := R.pilot_flag;
self := L;
end;

vehicle_equity_dist := distribute(VehLic.File_Vehicle_Equity, hash(did));

enhper_vehicle := join(enhper_own,
                       vehicle_equity_dist,
                       left.did = right.did,
                       AddVehicleInfo(left, right),
                       left outer,
                       local);

// Add Property Information
creditfile.layout_hole_person AddPropertyInfo(creditfile.layout_hole_person L, Property.Layout_Property_Equity R) := transform
self.property_initial_equity := if(ROUND(R.initial_equity / 10000) <= 255, ROUND(R.initial_equity / 10000), 255);
self.property_assessed_value := if(ROUND(R.assessed_value / 10000) <= 255, ROUND(R.assessed_value / 10000), 255);
self := L;
end;

property_equity_dist := distribute(Property.File_Property_Equity, hash(did));

enhper_property := join(enhper_vehicle,
                        property_equity_dist,
                        left.did = right.did,
                        AddPropertyInfo(left, right),
                        left outer,
                        local);

enhper_all := enhper_property + enhper_init(did=0);

enhper_all_dist := distribute(enhper_all, hash(per_id));

output(enhper_all_dist,,'BASE::Credit_Person_Enhanced', overwrite);