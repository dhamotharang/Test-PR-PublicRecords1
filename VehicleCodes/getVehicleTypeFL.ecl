export getVehicleTypeFL(string2 abrv, string2 vessel_abrv) := case(abrv,
 'AM' => 'Amphibian',
 'AU' => 'Auto',
 'BS' => 'Bus',
 'MC' => 'Motorcycle',
 'MH' => 'Mobile Home',
 'PK' => 'Pickup',
 'TO' => 'Tools',
 'TR' => 'Truck',
 'TT' => 'Travel Trailer',
 'VS' => getVesselTypeFL(vessel_abrv), //'VESSEL',
 'VT' => 'Vehicle Trailer'
,'');