export GetVehicleTypeMO(string2 pVehicleAbbreviation, string3 pVesselAbbreviation)
  := case(pVehicleAbbreviation,
		  'A' => 'All Terrain Vehicle',
		  'B' => 'Bus',
		  'C' => 'Motor Tricycle',
		  'D' => 'Trailer',
		  'M' => 'Motorcycle',
		  'P' => 'Passenger',
		  'R' => 'Recreational Vehicle',
		  'T' => 'Truck',
		  'VS' => GetVesselTypeMO(pVesselAbbreviation), //Vessel
		  ''
		 );