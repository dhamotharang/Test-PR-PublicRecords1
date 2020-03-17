EXPORT Common_Functions := MODULE;
	
	EXPORT VehicleTypeGroup(vehicle_type) := FUNCTIONMACRO
		VehTypeATV 			:= ['All Terrain-M','Dirt-M','Enduro-M','Mini Road/Trail-M','Moto Cross-M','Side BY Side-M'];
		VehTypeCamper 	:= ['Motorized Home-T','Van Camper-T'];
		VehTypeCar 			:= ['3 Door Coupe-P','Convertible-P','Coupe-P','Coupe 4 Door-P','Hatchback-P','Hatchback 2 Door-P','Hatchback 4 Door-P','Sedan 2 Door-P','Sedan 4 Door-P','Sedan 5 Door-P','Station Wagon-P'];
		VehTypeScooter 	:= ['Motor Scooter-M'];
		VehTypeRacing 	:= ['Racer-M','Road/Street-M'];
		VehTypeSUV 			:= ['2 Dr Wagon Sport Utility-T','4 Dr Wagon Sport Utility-T','Utility-T'];
		VehTypeTruck		:= ['3 Door EXT Cab PK-T','4 Door EXT Cab PK-T','Club Cab Pickup-T','Convertible-T','Crew Pickup-T','Pickup-T','Sport Pickup-T','Sport Utility Truck-T'];
		VehTypeVan			:= ['Extended Sport Van-T','Sport Van-T','VAN-T'];
		VehTypeWork			:= ['4 Dr EXT Cab/Chass-T','Bus-T','Cab And Chassis-T','Cargo Van-T','Club Chassis-T','Commercial Chassis 4-P','Conventional Cab-T','Crew Chassis-T',
												'Cutaway-T','Extended Cargo Van-T','FULL SIZE VAN-T','Hearse-P','Limousine-P','Limousine-T','Step Van-T','Tilt Cab-T','Tractor Truck-T'];
		VehType := MAP(
										vehicle_type IN VehTypeATV			=> 'ATV/Off Road Motorcycle/Side by Side',
										vehicle_type IN VehTypeCamper		=> 'Camper/Motorhome',
										vehicle_type IN VehTypeCar			=> 'Car',
										vehicle_type IN VehTypeScooter	=> 'Scooter',
										vehicle_type IN VehTypeRacing		=> 'Street/Racing Motorcycle',
										vehicle_type IN VehTypeSUV			=> 'SUV',
										vehicle_type IN VehTypeTruck		=> 'Truck',
										vehicle_type IN VehTypeVan			=> 'Van',
										vehicle_type IN VehTypeWork			=> 'Work Vehicle', 
																											 '');
		RETURN	VehType;
	ENDMACRO;
	
	EXPORT convertDateToQuarter(inDate) := FUNCTIONMACRO
		quarter := MAP(
									(INTEGER)inDate[5..6] <= 3  => inDate[1..4]+'0101',
									(INTEGER)inDate[5..6] <= 6  => inDate[1..4]+'0401',
									(INTEGER)inDate[5..6] <= 9  => inDate[1..4]+'0701',
									(INTEGER)inDate[5..6] <= 12 => inDate[1..4]+'1001',
									inDate[1..4]+'0101');
		RETURN	quarter;									
	ENDMACRO;
	
END;