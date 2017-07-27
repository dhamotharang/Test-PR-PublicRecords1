
// ----------[ Luxury or New Motor Vehicle Value and Ownership ]----------

// The function isLuxuryVehicle( ) evaluates whether a particular vehicle is considered
// "luxury". The rules for determining such are indicated in the comments below, prior to
// each set. See the block comment below for the composite listing of Tier3 makes and models.

// Any model of the following makes; only return current year minus 9 years to current year plus 1 year
SET OF STRING luxuryVehicles_makes_tier1 := 
	[
		'ASTON MARTIN','BENTLEY','BUGATTI','FERRARI','FISKER','LAMBORGHINI','MASERATI',
		'MAYBACH','MCLAREN','MOSLER','ROLLS ROYCE','SALEEN','SPYKER','TESLA'
	]; // Never heard of Spyker? Go see them at http://www.spykercars.com/ . Wow.

// Any model of the following makes; only return current year minus 5 years to current year plus 1 year
SET OF STRING luxuryVehicles_makes_tier2 := 
	[
		'ALFA ROMEO','ACURA','AUDI','BMW','CADILLAC','HUMMER','INFINITI','JAGUAR','LAND ROVER',
		'LEXUS','LINCOLN','LOTUS','MERCEDES BENZ','MORGAN','PORSCHE','SAAB','VOLVO'
	];

// Only return exact Make and model if the year current year minus 2 to current year plus 1
SET OF STRING luxuryVehicles_makes_tier3 := 
	[
		'BUICK','CHEVROLET','CHRYSLER','DODGE','FORD','GMC','HONDA','HYUNDAI','JEEP',
		'MAZDA','MINI','MINI COOPER','MITSUBISHI','NISSAN','SUBARU','TOYOTA','VOLKSWAGEN'
	];

SET OF STRING luxuryVehicles_models_tier3 := 
	[
		'ACCORD','ARMADA','ASPEN','AVALANCHE','COOPER WORKS','CORVETTE','CX GRAND TOURING',
		'CROSSTOUR','ENCLAVE','EQUUS','EXPEDITION','GENESIS','GRAND CHEROKEE','GT-R','LANCER',
		'LAND CRUISER','LIMITED','ODYSSEY','OVERLOAD','PILOT','RIDGELINE','ROADSTER','SEQUOIA',
		'SUBURBAN','TAHOE','TOUAREG','TRIBECA','TUNDRA','VIPER','VOLT','WORKS','YUKON'
	];

UCase := StringLib.StringToUpperCase;

EXPORT isLuxuryVehicle(STRING vehMake = '', STRING vehModel = '', STRING vehYear = '', STRING currYear = '') :=
	FUNCTION
		INTEGER3 vehicleAge := (INTEGER3)currYear - (INTEGER3)vehYear;
		
		inTier1Makes  := UCase(vehMake) IN luxuryVehicles_makes_tier1 AND vehicleAge BETWEEN -1 AND 9;
		inTier2Makes  := UCase(vehMake) IN luxuryVehicles_makes_tier2 AND vehicleAge BETWEEN -1 AND 5;
		inTier3Makes  := UCase(vehMake) IN luxuryVehicles_makes_tier3 AND vehicleAge BETWEEN -1 AND 2;
		inTier3Models := UCase(vehModel) IN luxuryVehicles_models_tier3;
		
		RETURN inTier1Makes OR inTier2Makes OR (inTier3Makes AND inTier3Models);
	END;

/*
		// Composite listing of Tier3 makes and models:
		Buick Enclave
		Chevrolet Avalanche
		Chevrolet Corvette
		Chevrolet Suburban
		Chevrolet Tahoe
		Chevrolet Volt
		Chrysler Aspen
		Dodge Viper
		Ford Expedition
		GMC Yukon
		Honda Crosstour
		Honda Odyssey
		Honda Pilot
		Honda Accord
		Honda Ridgeline
		Hyundai Equus
		Hyundai Genesis
		Jeep Grand Cherokee
		Jeep Limited
		Jeep Overload
		Mazda CX Grand Touring
		Mini Cooper Works
		Mini Roadster
		Mitsubishi Lancer
		Nissan Armada
		Nissan GT-R
		Subaru Tribeca
		Toyota Land Cruiser
		Toyota Sequoia
		Toyota Tundra
		Volkswagen Touareg
*/

