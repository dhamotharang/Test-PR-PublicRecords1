export FLCRASH2_VEHICLE :=
MODULE
       export VARSTRING DAMAGE_TYPE(string code) := MAP(
               code='1'=>'Disabling',  
			code='2'=>'Functional',  
			code='3'=>'No Damage',  
			'');

	  export VARSTRING DIRECTION_TRAVEL(string code) := MAP(
               code='N'=>'North',  
			code='S'=>'South',  
			code='E'=>'East',  
			code='W'=>'West',  
			code='U'=>'Unspecified',  
			'');

	  export VARSTRING HAZARD_MATERIAL_TRANSPORT(string code) := MAP(
               code='1'=>'Hazardous Material Being Transported',  
			code='2'=>'No Hazardous Material Being Transported',  
			'');


	  export VARSTRING HOW_REMOVED_CODE(string code) := MAP(
               code='1'=>'Tow Rotation List',  
			code='2'=>'Tow Owner\'s Request',  
			code='3'=>'Driver',  
			code='4'=>'',  
			'');

	  export VARSTRING MOVING_VIOLATION(string code) := MAP(
               code='1'=>'Vehicle charged with Moving Violation',  
			code='2'=>'Vehicle not charged with Moving Violation',  
			'');

	  export VARSTRING PLACARDED(string code) := MAP(
               code='1'=>'Yes',  
			code='2'=>'No',  
			'');

	  export VARSTRING POINT_OF_IMPACT(string code) := MAP(
               code='01'=>'Front Center',  
			code='02'=>'Front Right Corner',  
			code='03'=>'Right Side of Hood',  
			code='04'=>'Right Front Passenger Side',  
			code='05'=>'Right Rear Passenger Side',  
			code='06'=>'Right Side of Trunk',  
			code='07'=>'Rear Right Corner',  
			code='08'=>'Rear Center',  
			code='09'=>'Rear Left Corner',  
			code='10'=>'Left Side of Trunk',  
			code='11'=>'Left Rear Passenger Side',  
			code='12'=>'Driver Side',  
			code='13'=>'Left Front of Hood',  
			code='14'=>'Front Left Corner',  
			code='15'=>'Top of Hood',  
			code='16'=>'Top of Car',  
			code='17'=>'Top of Trunk',  
			code='18'=>'Undercarriage',  
			code='19'=>'Overturned',  
			code='20'=>'Windshield',  
			code='21'=>'Fire',  
			code='22'=>'Trailer',  
			code='88'=>'Unknown',  
			'');


	  export VARSTRING VEHICLE_DRIVER_ACTION(string code) := MAP(
               code='1'=>'Phantom',  
			code='2'=>'Hit & Run',  
			code='3'=>'Not Applicable',  
			'');

	  export VARSTRING VEHICLE_FAULT_CODE(string code) := MAP(
               code='1'=>'Vehicle At-Fault',  
			code='2'=>'Vehicle Not-At-Fault',  
			'');

	  export VARSTRING VEHICLE_FR_CODE(string code) := MAP(
               code='1'=>'Not FR',  
			code='2'=>'FRII',  
			code='3'=>'FRIII',  
			'');

	  export VARSTRING VEHICLE_FUNCTION(string code) := MAP(
               code='01'=>'None',  
			code='02'=>'Farm',  
			code='03'=>'Police Pursuit',  
			code='04'=>'Recreational',  
			code='05'=>'Emergency Operation',  
			code='06'=>'Construction / Maintenance',  
			code='77'=>'',  
			code='88'=>'Unknown',  
			'');


	  export VARSTRING VEHICLE_INSUR_CODE(string code) := MAP(
               code='1'=>'Vehicle Insured',  
			code='2'=>'Vehicle Un-Insured',  
			'');

	  export VARSTRING VEHICLE_MOVEMENT(string code) := MAP(
               code='01'=>'Straight Ahead',  
			code='02'=>'Slowing / Stopped / Stalled',  
			code='03'=>'Making Left Turn',  
			code='04'=>'Backing',  
			code='05'=>'Making Right Turn',  
			code='06'=>'Changing Lanes',  
			code='07'=>'Entering / Leaving Parking Space',  
			code='08'=>'Properly Parked',  
			code='09'=>'Improperly Parked',  
			code='10'=>'Making U-Turn',  
			code='11'=>'Passing',  
			code='12'=>'Driverless or Runaway Vehicle',  
			code='77'=>'',  
			code='88'=>'Unknown',  
			'');

	  export VARSTRING VEHICLE_OWNER_DRIVER_CODE(string code) := MAP(
               code='0'=>'',  
			code='1'=>'Owner is Driver',  
			'');

	  export VARSTRING VEHICLE_OWNER_RACE(string code) := MAP(
               code='1'=>'White',  
			code='2'=>'Black',  
			code='3'=>'Hispanic',  
			code='4'=>'',  
			'');


	  export VARSTRING VEHICLE_OWNER_SEX(string code) := MAP(
               code='1'=>'Male',  
			code='2'=>'Female',  
			'');

	  export VARSTRING VEHICLE_ROADWAY_LOC(string code) := MAP(
               code='01'=>'On Road',  
			code='02'=>'Not on Road',  
			code='03'=>'Shoulder',  
			code='04'=>'Median',  
			code='05'=>'Turn Lane / Safety Zone',  
			'');

       export VARSTRING VEHICLE_TYPE(string code) := MAP(
               code='00'=>'',  
			code='01'=>'Automobile',  
			code='02'=>'Passenger Van',  
			code='03'=>'Pickup/Light Truck (2 rear tires)',  
			code='04'=>'Medium Truck (4 rear tires)',  
			code='05'=>'Heavy Truck (2 or more rear axles)',  
			code='06'=>'Truck Tractor (Cab)',  
			code='07'=>'Motor Home (RV)',  
			code='08'=>'Bus',  
			code='09'=>'Bicycle',  
			code='10'=>'Motorcycle',  
			code='11'=>'Moped',  
			code='12'=>'All Terrain Vehicle',  
			code='13'=>'Train',  
			code='77'=>'',  
			'');

       export VARSTRING VEHICLE_USE(string code) := MAP(
               code='01'=>'Private Transportation',  
			code='02'=>'Commercial Passengers',  
			code='03'=>'Commercial Cargo',  
			code='04'=>'Public Transportation',  
			code='05'=>'Public School Bus',  
			code='06'=>'Private School Bus',  
			code='07'=>'Ambulance',  
			code='08'=>'Law Enforcement',  
			code='09'=>'Fire / Rescue',  
			code='10'=>'Military',  
			code='11'=>'Other Government',  
			code='77'=>'',  
			'');

	  export VARSTRING VEHS_FIRST_DEFECT(string code) := MAP(
               code='00'=>'',  
			code='01'=>'No Defects',  
			code='02'=>'Defective Brakes',  
			code='03'=>'Worn / Smooth Tires',  
			code='04'=>'Defective / Improper Lights',  
			code='05'=>'Puncture / Blowout',  
			code='06'=>'Steering Mechanism',  
			code='07'=>'Windshield Wipers',  
			code='08'=>'Equipment / Vehicle Defect',  
			code='77'=>'',  
			code='88'=>'',  
			'');

       export VARSTRING VEHS_SECOND_DEFECT(string code) := MAP(
               code='00'=>'',  
			code='01'=>'No Defects',  
			code='02'=>'Defective Brakes',  
			code='03'=>'Worn / Smooth Tires',  
			code='04'=>'Defective / Improper Lights',  
			code='05'=>'Puncture / Blowout',  
			code='06'=>'Steering Mechanism',  
			code='07'=>'Windshield Wipers',  
			code='08'=>'Equipment / Vehicle Defect',  
			code='77'=>'',  
			code='88'=>'',  
			'');

	EXPORT VARSTRING MAKE_DESCRIPTION(STRING code) :=
		MAP(code = 'ACUR' => 'Acura',
				code = 'AMRT' => 'Aston Martin',
				code = 'AUDI' => 'Audi',
				code = 'BLUB' OR
				code = 'BLUE' => 'Blue Bird',
				code = 'BMW'  => 'BMW',
				code = 'BUEL' => 'Buell',
				code = 'BUIC' => 'Buick',
				code = 'CADI' => 'Cadillac',
				code = 'CHEV' => 'Chevrolet',
				code = 'CHRY' => 'Chrysler',
				code = 'DAEW' => 'Daewoo',
				code = 'DAIM' => 'Daimler',
				code = 'DATS' => 'Datsun',
				code = 'DODG' => 'Dodge',
				code = 'EAGL' => 'Eagle Bus',
				code = 'FERR' => 'Ferrari',
				code = 'FIRD' OR
				code = 'FORD' => 'Ford',
				code = 'FHRT' OR
				code = 'FL'   OR
				code = 'FRA'  OR
				code = 'FREI' OR
				code = 'FRHT' OR
				code = 'FRIE' OR
				code = 'FRLN' OR
				code = 'FRTL' OR
				code = 'FTRL' => 'Freightliner',
				code = 'GEO'  => 'Geo',
				code = 'GMC'  => 'GMC',
				code = 'GRUM'  => 'Grumman',
				code = 'HARL' OR
				code = 'HD'   OR
				code = 'HRLY' => 'Harley Davidson',
				code = 'HOND' => 'Honda',
				code = 'HUMB' => 'Hummer',
				code = 'HYND' OR
				code = 'HYUK' OR
				code = 'HYUN' => 'Hyundai',
				code = 'INFI' OR
				code = 'INFN' => 'Infiniti',
				code = 'INT'  OR
				code = 'INTE' OR
				code = 'INTL' OR
				code = 'INTR' => 'International',
				code = 'ISU'  OR
				code = 'ISUZ' => 'Isuzu',
				code = 'JAG'  OR
				code = 'JAGU' => 'Jaguar',
				code = 'JDDP' OR
				code = 'JEP'  OR
				code = 'JEEP' OR
				code = 'JEPP' => 'Jeep',
				code = 'KAW'  OR
				code = 'KAWA' => 'Kawasaki',
				code = 'KENN' OR
				code = 'KENW' OR
				code = 'KW'   => 'Kenworth',
				code = 'KIA'  => 'Kia',
				code = 'LAND' OR
				code = 'LNDR' => 'Land Rover',
				code = 'LEX'  OR
				code = 'LEXS' OR
				code = 'LEXU' => 'Lexus',
				code = 'LICN' OR
				code = 'LINC' => 'Lincoln',
				code = 'MACK' OR
				code = 'MCK'  => 'Mack',
				code = 'MAZD' => 'Mazda',
				code = 'MEEZ' OR
				code = 'MERZ' => 'Mercedes Benz',
				code = 'MER'  OR
				code = 'MERC' OR
				code = 'MERQ' => 'Mercury',
				code = 'MITS' => 'Mitsubishi',
				code = 'NAVI' => 'Navistar',
				code = 'NISS' OR
				code = 'NISN' => 'Nissan',
				code = 'OLDS' => 'Oldsmobile',
				code = 'OSHK' => 'Oshkosh',
				code = 'PETE' OR
				code = 'PB'   OR
				code = 'PBTI' OR
				code = 'PTRB' => 'Peterbilt',
				code = 'PLY'  OR
				code = 'PLYM' => 'Plymouth',
				code = 'PONT' => 'Pontiac',
				code = 'ROLS' => 'Rolls Royce',
				code = 'SAAB' => 'Saab',
				code = 'SATN' OR
				code = 'SATU' OR
				code = 'STRN' => 'Saturn',
				code = 'SPAR' => 'Spartan',
				code = 'STER' OR
				code = 'STLG' => 'Sterling',
				code = 'SUBA' OR
				code = 'SUBR' => 'Subaru', 
				code = 'SUZ'  OR
				code = 'SUZI' => 'Suzuki',
				code = 'THMS' => 'Thomas Freightliner',
				code = 'THO'  OR
				code = 'THOM' => 'Thomas',
				code = 'TORO' => 'Toro',
				code = 'TOY'  OR
				code = 'TOYO' OR
				code = 'TOYT' => 'Toyota',
				code = 'TRI'  => 'Triumph',
				code = 'UD'   => 'UD Trucks',
				code = 'VOLK' OR
				code = 'VW'   => 'Volkswagen',
				code = 'VOLV' => 'Volvo',
				code = 'WGMC' OR
				code = 'WHGM' OR
				code = 'WHIT' => 'White GMC',
				code = 'WINN' => 'Winnebago',
				code = 'WS'   OR
				code = 'WSTR' => 'Western Star',
				code = 'YAMA' => 'Yamaha',
				code);

	export checkChanges :=
	FUNCTION
		
	codes.Layout_Codes_V3 trans(codes.File_Codes_V3_in le) :=
		TRANSFORM
			translation := 
				MAP(le.field_name = 'DAMAGE_TYPE'	=>	DAMAGE_TYPE(le.code),
				    le.field_name = 'DIRECTION_TRAVEL'	=>	DIRECTION_TRAVEL(le.code),
				    le.field_name = 'HAZARD_MATERIAL_TRANSPORT'	=>	HAZARD_MATERIAL_TRANSPORT(le.code),
				    le.field_name = 'HOW_REMOVED_CODE'	=>	HOW_REMOVED_CODE(le.code),
				    le.field_name = 'MOVING_VIOLATION'	=>	MOVING_VIOLATION(le.code),
				    le.field_name = 'PLACARDED'	=>	PLACARDED(le.code),
				    le.field_name = 'POINT_OF_IMPACT'	=>	POINT_OF_IMPACT(le.code),
				    le.field_name = 'VEHICLE_DRIVER_ACTION'	=>	VEHICLE_DRIVER_ACTION(le.code),
				    le.field_name = 'VEHICLE_FAULT_CODE'	=>	VEHICLE_FAULT_CODE(le.code),
				    le.field_name = 'VEHICLE_FR_CODE'	=>	VEHICLE_FR_CODE(le.code),
				    le.field_name = 'VEHICLE_FUNCTION'	=>	VEHICLE_FUNCTION(le.code),
				    le.field_name = 'VEHICLE_INSUR_CODE'	=>	VEHICLE_INSUR_CODE(le.code),
				    le.field_name = 'VEHICLE_MOVEMENT'	=>	VEHICLE_MOVEMENT(le.code),
				    le.field_name = 'VEHICLE_OWNER_DRIVER_CODE'	=>	VEHICLE_OWNER_DRIVER_CODE(le.code),
				    le.field_name = 'VEHICLE_OWNER_RACE'	=>	VEHICLE_OWNER_RACE(le.code),
				    le.field_name = 'VEHICLE_OWNER_SEX'	=>	VEHICLE_OWNER_SEX(le.code),
				    le.field_name = 'VEHICLE_ROADWAY_LOC'	=>	VEHICLE_ROADWAY_LOC(le.code),
				    le.field_name = 'VEHICLE_TYPE'	=>	VEHICLE_TYPE(le.code),
				    le.field_name = 'VEHICLE_USE'	=>	VEHICLE_USE(le.code),
				    le.field_name = 'VEHS_FIRST_DEFECT'	=>	VEHS_FIRST_DEFECT(le.code),
				    le.field_name = 'VEHS_SECOND_DEFECT'	=>	VEHS_SECOND_DEFECT(le.code),
            le.field_name = 'MAKE_DESCRIPTION'	=>	MAKE_DESCRIPTION(le.code),
                        '');
				  
			SELF.code := IF(le.long_desc=translation,SKIP,le.code);
			SELF := le;
		END;
	
	p := PROJECT(codes.File_Codes_V3_in(file_name='FLCRASH2_VEHICLE'),trans(LEFT));
	RETURN p;
		
	END;

END;