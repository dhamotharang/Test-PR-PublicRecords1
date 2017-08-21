
EXPORT BuildBodyStylePicker(string filedate) := function 

import ut, Vehlic, VehicleV2, vehicle_wildcard,lib_fileservices, _control;

dVina := vehiclev2.File_VINA_For_Distrix(vina_body_style <>''); 

	rbodystyle_layout	:=
	record
		string body_style;
		string body_style_description;
		string category :=''
	end;
	
dpicker := dataset('~thor_data400::out::vehicle_valid_body_code',rbodystyle_layout, csv(separator('|')));

	rMakeStats_layout	:=
	record
		string body_style;
		string body_style_description;
		string category :='';
		unsigned4	cntbodystyle	:=	0;
	end;

	dCombinedCntModel	:=	project(dVina, transform({rMakeStats_layout}, self.body_style_description := StringLib.StringToUppercase(left.body_style_description), self.body_style:= left.vina_body_style))
                        + project(dpicker, transform({rMakeStats_layout}, self.body_style_description := StringLib.StringToUppercase(left.body_style_description), self:= left));
	
	rMakeStats_layout	tCountModels(dCombinedCntModel le, dCombinedCntModel ri)	:=
	transform
		self.cntbodystyle	:=	le.cntbodystyle + 1;
		self					:=	le;
	end;

	dCombinedMakeStats	:=	rollup(	dCombinedCntModel,
																	left.body_style				      =	right.body_style	and
																	left.body_style_description	=	right.body_style_description,
																	tCountModels(left, right)
																);

	dCombinedMakeStats_sort		:=	sort(dCombinedMakeStats, body_style, -cntbodystyle);
	dCombinedMakeStats_dedup	:=	dedup(dCombinedMakeStats_sort, body_style);
	
 BodyConst    :=  dataset([{'2D',	'Sedan 2 Dr.',	'PASSENGER VEHICLES'},
{'2F',	'Formal Hardtop 2 Dr.',	'PASSENGER VEHICLES'},
{'2H',	'Hatchback 2 Dr.',	'PASSENGER VEHICLES'},
{'2L',	'Liftback 3 Dr.',	'PASSENGER VEHICLES'},
{'2P',	'Pillard Hardtop 2 Dr.',	'PASSENGER VEHICLES'},
{'2T',	'Hardtop 2 Dr.',	'PASSENGER VEHICLES'},
{'2W',	'Wagon 2 Dr.',	'PASSENGER VEHICLES'},
{'3D',	'Runabout 3 Dr.',	'PASSENGER VEHICLES'},
{'3P',	'Coupe 3 Dr.',	'PASSENGER VEHICLES'},
{'4D',	'Sedan 4 Dr.',	'PASSENGER VEHICLES'},
{'4H',	'Hatchback 4 Dr.',	'PASSENGER VEHICLES'},
{'4L',	'Liftback 5 Dr.',	'PASSENGER VEHICLES'},
{'4P',	'Pillard Hardtop 4 Dr.',	'PASSENGER VEHICLES'},
{'4T',	'Hardtop 4 Dr.',	'PASSENGER VEHICLES'},
{'4W',	'Wagon 4 Dr.',	'PASSENGER VEHICLES'},
{'5D',	'Sedan 5 Dr.',	'PASSENGER VEHICLES'},
{'AM',	'Ambulance',	'PASSENGER VEHICLES'},
{'C4',	'Coupe 4 Dr.',	'PASSENGER VEHICLES'},
{'CB',	'Cab & Chassis (Luv)',	'PASSENGER VEHICLES'},
{'CP',	'Coupe',	'PASSENGER VEHICLES'},
{'CV',	'Convertible',	'PASSENGER VEHICLES'},
{'HB',	'Hatchback', 	'PASSENGER VEHICLES'},
{'HR',	'Hearse',	'PASSENGER VEHICLES'},
{'HT',	'Hardtop',	'PASSENGER VEHICLES'},
{'IN',	'Incomplete Passenger',	'PASSENGER VEHICLES'},
{'LB',	'Liftback',	'PASSENGER VEHICLES'},
{'LM',	'Limousine',	'PASSENGER VEHICLES'},
{'NB',	'Notchback',	'PASSENGER VEHICLES'},
{'P2',	'2 Passenger Low Speed',	'PASSENGER VEHICLES'},
{'P4',	'4 Passenger Low Speed',	'PASSENGER VEHICLES'},
{'PK',	'Pickup', 	'PASSENGER VEHICLES'},
{'PN',	'Panel',	'PASSENGER VEHICLES'},
{'RD',	'Roadster',	'PASSENGER VEHICLES'},
{'SB',	'Sport Hatchback',	'PASSENGER VEHICLES'},
{'SC',	'Sport Coupe',	'PASSENGER VEHICLES'},
{'SD',	'Sedan', 	'PASSENGER VEHICLES'},
{'SV',	'Sport Van',	'PASSENGER VEHICLES'},
{'SW',	'Station Wagon',	'PASSENGER VEHICLES'},
{'UT',	'Utility', 	'PASSENGER VEHICLES'},
{'WW',	'Wide Wheel Wagon',	'PASSENGER VEHICLES'},
{'AC',	'Auto Carrier',	'TRUCKS'},
{'AR',	'Armored Truck',	'TRUCKS'},
{'BU',	'Bus',	'TRUCKS'},
{'CB',	'Chassis and Cab',	'TRUCKS'},
{'CC',	'Conventional Cab',	'TRUCKS'},
{'CG',	'Cargo Van',	'TRUCKS'},
{'CH',	'Crew Chassis',	'TRUCKS'},
{'CL',	'Club Chassis',	'TRUCKS'},
{'CM',	'Concrete or Transit Mixer',	'TRUCKS'},
{'CR',	'Crane',	'TRUCKS'},
{'CS',	'Super Cab / Chassis Pickup',	'TRUCKS'},
{'CU',	'Custom Pickup',	'TRUCKS'},
{'CV',	'Convertible (Jeep Commando, Suzuki Samurai, Dodge Dakota)',	'TRUCKS'},
{'CW',	'Crew Pickup',	'TRUCKS'},
{'CY',	'Cargo Cutaway',	'TRUCKS'},
{'DP',	'Dump',	'TRUCKS'},
{'DS',	'Tractor Truck (diesel)',	'TRUCKS'},
{'EC',	'Extended Cargo Van',	'TRUCKS'},
{'ES',	'Extended Sport Van',	'TRUCKS'},
{'EV',	'Ext Van',	'TRUCKS'},
{'EW',	'Extended Window Van',	'TRUCKS'},
{'FB',	'Flat-bed or Platform',	'TRUCKS'},
{'FC',	'Forward Control',	'TRUCKS'},
{'FT',	'Fire Truck',	'TRUCKS'},
{'GG',	'Garbage or Refuse',	'TRUCKS'},
{'GL',	'Gliders',	'TRUCKS'},
{'GN',	'Grain',	'TRUCKS'},
{'HO',	'Hopper',	'TRUCKS'},
{'IC',	'Incomplete Chassis',	'TRUCKS'},
{'IE',	'Incomplete Ext Van',	'TRUCKS'},
{'LG',	'Logger',	'TRUCKS'},
{'LL',	'Suburban & Carry All',	'TRUCKS'},
{'LM',	'Limousine',	'TRUCKS'},
{'MH',	'Motorized Home',	'TRUCKS'},
{'MP',	'Multi-purpose',	'TRUCKS'},
{'MV',	'Maxi Van',	'TRUCKS'},
{'MW',	'Maxi Wagon',	'TRUCKS'},
{'MY',	'Motorized Cutaway',	'TRUCKS'},
{'PC',	'Club Cab Pickup',	'TRUCKS'},
{'PD',	'Parcel Delivery',	'TRUCKS'},
{'PK',	'Pickup',	'TRUCKS'},
{'PM',	'Pickup with Camper mounted on bed',	'TRUCKS'},
{'PN',	'Panel',	'TRUCKS'},
{'PS',	'Super Cab Pickup',	'TRUCKS'},
{'RD',	'Roadster(Jeep, Jeep Commando)',	'TRUCKS'},
{'SN',	'Step Van',	'TRUCKS'},
{'SP',	'Sport Pickup',	'TRUCKS'},
{'ST',	'Stake or Rack',	'TRUCKS'},
{'SV',	'Sports Van',	'TRUCKS'},
{'SW',	'Station Wagon (Jeep Wagoneer, Dodge Sportsman A100, Toyota Land Cruiser',	'TRUCKS'},
{'S1',	'One Seat',	'TRUCKS'},
{'S2',	'Two Seat',	'TRUCKS'},
{'TB',	'Tilt Cab',	'TRUCKS'},
{'TL',	'Tilt Tandem',	'TRUCKS'},
{'TM',	'Tandem',	'TRUCKS'},
{'TN',	'Tank',	'TRUCKS'},
{'TR',	'Tractor Truck (Gasoline)',	'TRUCKS'},
{'UT',	'Utility (Blazer, Jimmy, Scout, etc.)',	'TRUCKS'},
{'VC',	'Van Camper',	'TRUCKS'},
{'VD',	'Display Van',	'TRUCKS'},
{'VN',	'Van',	'TRUCKS'},
{'VT',	'Vanette (including Metro and Handy Van)',	'TRUCKS'},
{'VW',	'Window Van',	'TRUCKS'},
{'WK',	'Tow Truck Wrecker',	'TRUCKS'},
{'WW',	'Wide Wheel Wagon',	'TRUCKS'},
{'XT',	'Travelall',	'TRUCKS'},
{'YY',	'Cutaway',	'TRUCKS'},
{'2W',	'2 Dr. Wagon / Sport Utility',	'TRUCKS'},
{'3B',	'3 Door Extended Cab / Chassis',	'TRUCKS'},
{'3C',	'3 Door Extended Cab Pickup',	'TRUCKS'},
{'4B',	'4 Door Extended Cab / Chassis',	'TRUCKS'},
{'4C',	'4 Door Extended Cab Pickup',	'TRUCKS'},
{'4W',	'4 Dr. Wagon / Sport Utility',	'TRUCKS'},
{'8V',	'8 Passenger Sport Van',	'TRUCKS'},
{'AT',	'All Terrain',	'MOTORCYCLES'},
{'EN',	'Enduro',	'MOTORCYCLES'},
{'MK',	'Mini Bike',	'MOTORCYCLES'},
{'MM',	'Mini Moto Cross',	'MOTORCYCLES'},
{'MP',	'Moped',	'MOTORCYCLES'},
{'MR',	'Mini Road/Trail',	'MOTORCYCLES'},
{'MS',	'Motor Scooter',	'MOTORCYCLES'},
{'MX',	'Moto Cross',	'MOTORCYCLES'},
{'MY',	'Mini Cycle',	'MOTORCYCLES'},
{'RC',	'Racer',	'MOTORCYCLES'},
{'RS',	'Road/Street',	'MOTORCYCLES'},
{'RT',	'Road/Trail',	'MOTORCYCLES'},
{'T', 	'Dirt',	'MOTORCYCLES'},
{'TL',	'Trail/Dirt',	'MOTORCYCLES'},
{'TR',	'Trials',	'MOTORCYCLES'}], { string body_style,string body_code_description,string category}); 

  jCategory:= join (dCombinedMakeStats_dedup ,BodyConst, 
             left.body_style = right.body_style
						 , transform({rbodystyle_layout}, self.category := right.category,self.body_style :=left.body_style,self :=left), left outer); 

	//only for initial run
	/*jConstMissing:= join (dCombinedMakeStats_dedup ,BodyConst, 
             left.body_style = right.body_style
						 , transform({rbodystyle_layout}, self.body_style := right.body_style, self.body_style_description := StringLib.StringToUppercase(right.body_code_description),self.category := right.category,self :=[]), right only ); 
	
	*/
  total := dedup(sort(jCategory(body_style_description <> 'BODY_STYLE_DESCRIPTION'),body_style,body_style_description, category),record) ;
	
	vehiclev2.MAC_SF_BuildProcess(total,
																'~thor_data400::out::vehicle_valid_body_code',
																dPickerCSVFile,2,true);
	
		//despray file

	desprayPickerFile	:=	lib_fileservices.fileservices.Despray('~thor_data400::out::vehicle_valid_body_code',
																															_control.IPAddress.bctlpedata11,
																															'/data/data_999/vehreg_body_code/vehicle_valid_body_code_'+filedate+'.csv',
																															,,,TRUE);
																															
	//verify nothing drop from the original file 

	dPicker tVerifyOriginal(dPicker le, total ri)	:=
	transform
		self := le;
	end;

	dPickerOnly	:=	join(	dPicker(category <>'category'),
												total,
												left.body_style = right.body_style and
												left.body_style_description = right.body_style_description and
												left.category = right.category,
												tVerifyOriginal(left, right),
												left only
											);

	dPickerDroppedRecs	:=	if(	count(dPickerOnly) = 0,
															output('Nothing dropped from original body code file'),
															output('Check body style code again')
														);
														
	return  sequential( dPickerCSVFile, desprayPickerFile,dPickerDroppedRecs); 
		
end; 
