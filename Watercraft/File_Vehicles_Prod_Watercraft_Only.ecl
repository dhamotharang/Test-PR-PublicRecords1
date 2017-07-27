import VehLic;

export File_Vehicles_Prod_Watercraft_Only
 := VehLic.File_Base_Vehicles_Prod(orig_state in ['MO','FL'] and vehicle_type='VS')
 : persist('persist::watercraft_from_vehicles')
 ;