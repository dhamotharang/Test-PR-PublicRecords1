IMPORT STD;
EXPORT Polk_Code_Translations := MODULE
  EXPORT STRING Plate_Type_Description(STRING Plate_type_Code):=
      MAP(Plate_type_Code = '0' => 'Unassigned'
        , Plate_type_Code = '1' => 'Regular passenger'
        , Plate_type_Code = '2' => 'Regular truck'
        , Plate_type_Code = '3' => 'Regular'
        , Plate_type_Code = '4' => 'Official'
        , Plate_type_Code = '5' => 'Exempt'
        , Plate_type_Code = '6' => 'Dealer'
        , Plate_type_Code = '7' => 'Vanity'
        , Plate_type_Code = '8' => 'Ham radio'
        , Plate_type_Code = '9' => 'Antique'
        , Plate_type_Code = 'A' => 'Handicap'
        , Plate_type_Code = 'B' => 'Disabled Veteran'
        , Plate_type_Code = 'C' => 'Prisoner of War'
        , Plate_type_Code = 'D' => 'Farm'
        , Plate_type_Code = 'E' => 'Pro-rate'
        , Plate_type_Code = 'F' => 'Commercial'
        , Plate_type_Code = 'G' => 'Recreational / Off road'
        , Plate_type_Code = 'H' => 'Special Interest Group'
        , Plate_type_Code = 'J' => 'Temporary'
        , Plate_type_Code = 'Z' => 'Unknown'
        ,''
        );
EXPORT STRING Lessee_Lessor_Description(STRING Lessee_Lessor_Code) :=
      MAP(Lessee_Lessor_Code = '0' => 'Name unassigned / address unassigned'
         ,Lessee_Lessor_Code = '1' => 'Lessee name / address unassigned'
         ,Lessee_Lessor_Code = '2' => 'Lessor name / address unassigned'
         ,Lessee_Lessor_Code = '3' => 'Name unassigned / lessee address'
         ,Lessee_Lessor_Code = '4' => 'Lessee name / lessee address'
         ,Lessee_Lessor_Code = '5' => 'Lessor name / lessee address'
         ,Lessee_Lessor_Code = '6' => 'Name unassigned / lessor address'
         ,Lessee_Lessor_Code = '7' => 'Lessee name / lessor address'
         ,Lessee_Lessor_Code = '8' => 'Lessor name / lessor address'
        ,''
        );

EXPORT STRING RealTimePermissibleUse (STRING RealTimePermissibleUse):=

    MAP(TRIM(STD.STR.ToUpperCase(RealTimePermissibleUse)) = 'GOVERNMENT' => '1A',
        TRIM(STD.STR.ToUpperCase(RealTimePermissibleUse)) = 'LAWENFORCEMENT' => '1L',
        TRIM(STD.STR.ToUpperCase(RealTimePermissibleUse)) = 'PARKING' => '1P',
        TRIM(STD.STR.ToUpperCase(RealTimePermissibleUse)) = 'VERIFYFRAUDORDEBT' => '2',
        TRIM(STD.STR.ToUpperCase(RealTimePermissibleUse)) = 'LITIGATION' => '3',
        TRIM(STD.STR.ToUpperCase(RealTimePermissibleUse)) = 'INSURANCECLAIMS' => '4C',
        TRIM(STD.STR.ToUpperCase(RealTimePermissibleUse)) = 'INSURANCEUNDERWRITING' => '4U',
        TRIM(STD.STR.ToUpperCase(RealTimePermissibleUse)) = 'TOWEDANDIMPOUNDED' => '5',
        TRIM(STD.STR.ToUpperCase(RealTimePermissibleUse)) = 'PRIVATETOLL' => '6',
        '');
  
EXPORT STRING ErrorCodes(STRING c) :=
  CASE(c, 'PU' => 'Invalid Permissible Usage',
          'SC' => 'Invalid Sub_customer_id',
          '01' => 'Missing apartment number',
          '02' => 'Incorrect apartment number',
          '1207' => 'Vehicle Check: Access to the operation requested is not allowed under the GLB and/or DPPA guidelines for your intended use.',
          '1208' => 'Vehicle Check: Access to the operation requested is not allowed under the GLB and/or DPPA guidelines for your intended use for that state.',
          '1209' => 'Vehicle Check: Please specify a state code.',
          '1210' => 'Vehicle Check GW: Both company and name cannot be specified at the same time!',
          '1211' => 'Vehicle Check GW only supports up to 25 vehicles',
          '301' => 'Insufficient input',
          '310' => 'Incomplete/Invalid Address',
          '320' => 'Could not uniquely identify individual',
          '500' => 'No Permissible Use',
          '510' => 'Missing Gateway Information',
          '520' => 'RESTRICTED',
          'Soap connection error'/*,
          'Database Error'*/);
EXPORT STRING Veh_Type_Description(STRING code) :=
       MAP(code='M' => 'MOTORCYCLE',
        code='P' => 'PASSENGER CAR/LIGHT TRUCK',
        code='L' => 'LIGHT TRUCK',
        code='T' => 'HEAVY TRUCK',
        code='X' => 'TRAILER',
        'UNKNOWN');

EXPORT STRING Body_Style_Description(STRING Body_Style_Code) :=
      MAP(Body_Style_Code = '2D' => 'Sedan 2 Dr.',
          Body_Style_Code = '2F' => 'Formal Hardtop 2 Dr.',
          Body_Style_Code = '2H ' => 'Hatchback 2 Dr.',
          Body_Style_Code = '2L' => 'Liftback 3 Dr.',
          Body_Style_Code = '2P' => 'Pillard Hardtop 2 Dr.',
          Body_Style_Code = '2T' => 'Hardtop 2 Dr.',
          Body_Style_Code = '2W' => '2 Dr. Wagon / Sport Utility',
          Body_Style_Code = '3B' => '3 Dr. Extended Cab / Chassis',
          Body_Style_Code = '3C' => '3 Dr. Extended Cab Pickup',
          Body_Style_Code = '3D' => 'Runabout 3 Dr.',
          Body_Style_Code = '3P' => 'Coupe 3 Dr.',
          Body_Style_Code = '4B' => '4 Dr. Extended Cab / Chassis',
          Body_Style_Code = '4C' => '4 Dr. Extended Cab Pickup ',
          Body_Style_Code = '4D' => 'Sedan 4 Dr.',
          Body_Style_Code = '4H' => 'Hatchback 4 Dr.',
          Body_Style_Code = '4L' => 'Liftback 5 Dr.',
          Body_Style_Code = '4P' => 'Pillard Hardtop 4 Dr.',
          Body_Style_Code = '4T' => 'Hardtop 4 Dr.',
          Body_Style_Code = '4W' => '4 Dr. Wagon / Sport Utility',
          Body_Style_Code = '5D' => 'Sedan 5 Dr.',
          Body_Style_Code = '8V' => '8 Passenger Sport Van',
          Body_Style_Code = 'AC' => 'Auto Carrier',
          Body_Style_Code = 'AM' => 'Ambulance',
          Body_Style_Code = 'AR' => 'Armored Truck',
          Body_Style_Code = 'AT' => 'All Terrain',
          Body_Style_Code = 'BU' => 'Bus',
          Body_Style_Code = 'C4' => 'Coupe 4 Dr.',
          Body_Style_Code = 'CB' => 'Chassis and Cab',
          Body_Style_Code = 'CC' => 'Conventional Cab',
          Body_Style_Code = 'CG' => 'Cargo Van',
          Body_Style_Code = 'CH' => 'Crew Chassis',
          Body_Style_Code = 'CL' => 'Club Chassis',
          Body_Style_Code = 'CM' => 'Concrete or Transit Mixer',
          Body_Style_Code = 'CP' => 'Coupe',
          Body_Style_Code = 'CR' => 'Crane',
          Body_Style_Code = 'CS' => 'Super Cab / Chassis Pickup',
          Body_Style_Code = 'CU' => 'Custom Pickup',
          Body_Style_Code = 'CV' => 'Convertible (Jeep Commando, Suzuki Samurai, Dodge Dakota)',
          Body_Style_Code = 'CW' => 'Crew Pickup',
          Body_Style_Code = 'CY' => 'Cargo Cutaway',
          Body_Style_Code = 'DP' => 'Dump',
          Body_Style_Code = 'DS' => 'Tractor Truck (diesel)',
          Body_Style_Code = 'EC' => 'Extended Cargo Van',
          Body_Style_Code = 'EN' => 'Enduro',
          Body_Style_Code = 'ES' => 'Extended Sport Van',
          Body_Style_Code = 'EV' => 'Ext Van',
          Body_Style_Code = 'EW' => 'Extended Window Van',
          Body_Style_Code = 'FB' => 'Flat-bed or Platform',
          Body_Style_Code = 'FC' => 'Forward Control',
          Body_Style_Code = 'FT' => 'Fire Truck',
          Body_Style_Code = 'GG' => 'Garbage or Refuse',
          Body_Style_Code = 'GL' => 'Gliders',
          Body_Style_Code = 'GN' => 'Grain',
          Body_Style_Code = 'HB' => 'Hatchback',
          Body_Style_Code = 'HO' => 'Hopper',
          Body_Style_Code = 'HR' => 'Hearse',
          Body_Style_Code = 'HT' => 'Hardtop',
          Body_Style_Code = 'IC' => 'Incomplete Chassis',
          Body_Style_Code = 'IE' => 'Incomplete Ext Van',
          Body_Style_Code = 'IN' => 'Incomplete Passenger',
          Body_Style_Code = 'LB' => 'Liftback',
          Body_Style_Code = 'LG' => 'Logger',
          Body_Style_Code = 'LL' => 'Suburban & Carry All',
          Body_Style_Code = 'LM' => 'Limousine',
          Body_Style_Code = 'MH' => 'Motorized Home',
          Body_Style_Code = 'MK' => 'Mini Bike',
          Body_Style_Code = 'MM' => 'Mini Moto Cross',
          Body_Style_Code = 'MP' => 'Multi-purpose',
          Body_Style_Code = 'MR' => 'Mini Road/Trail',
          Body_Style_Code = 'MS' => 'Motor Scooter',
          Body_Style_Code = 'MV' => 'Maxi Van',
          Body_Style_Code = 'MW' => 'Maxi Wagon',
          Body_Style_Code = 'MX' => 'Moto Cross',
          Body_Style_Code = 'MY' => 'Motorized Cutaway',
          Body_Style_Code = 'NB' => 'Notchback',
          Body_Style_Code = 'P2' => '2 Passenger Low speed',
          Body_Style_Code = 'P4' => '2 Passenger Low speed',
          Body_Style_Code = 'PC' => 'Club Cab PickUp',
          Body_Style_Code = 'PD' => 'Parcel Delivery',
          Body_Style_Code = 'PK' => 'Pickup',
          Body_Style_Code = 'PM' => 'Pickup with Camper mounted on bed',
          Body_Style_Code = 'PN' => 'Panel',
          Body_Style_Code = 'PS' => 'Super Cab Pickup',
          Body_Style_Code = 'RC' => 'Racer',
          Body_Style_Code = 'RD' => 'Roadster (Jeep, Jeep Commando)',
          Body_Style_Code = 'RS' => 'Road/Street',
          Body_Style_Code = 'RT' => 'Road/Trail',
          Body_Style_Code = 'S1' => 'One Seat',
          Body_Style_Code = 'S2' => 'Two Seat',
          Body_Style_Code = 'SB' => 'Sport Hatchback',
          Body_Style_Code = 'SC' => 'Sport Coupe',
          Body_Style_Code = 'SD' => 'Sedan',
          Body_Style_Code = 'SN' => 'Step Van',
          Body_Style_Code = 'SP' => 'Sport Pickup',
          Body_Style_Code = 'ST' => 'Stake or Rack',
          Body_Style_Code = 'SV' => 'Sports Van',
          Body_Style_Code = 'SW' => 'Station Wagon (Jeep Wagoneer, Dodge Sportsman A100, Toyota Landcruiser)',
          Body_Style_Code = 'T' => 'Dirt',
          Body_Style_Code = 'TB' => 'Tilt Cab',
          Body_Style_Code = 'TL' => 'Tilt Tandem',
          Body_Style_Code = 'TM' => 'Tandem',
          Body_Style_Code = 'TN' => 'Tank',
          Body_Style_Code = 'TR' => 'Tractor Truck (Gasoline)',
          Body_Style_Code = 'UT' => 'Utility (Blazer, Jimmy, Scout, etc.)',
          Body_Style_Code = 'VC' => 'Van Camper',
          Body_Style_Code = 'VD' => 'Display Van',
          Body_Style_Code = 'VN' => 'Van',
          Body_Style_Code = 'VT' => 'Vanette (including Metro and Handy Van)',
          Body_Style_Code = 'VW' => 'Window Van',
          Body_Style_Code = 'WK' => 'Tow Truck Wrecker',
          Body_Style_Code = 'WW' => 'Wide Wheel Wagon',
          Body_Style_Code = 'XT' => 'Travelall',
          Body_Style_Code = 'YY' => 'Cutaway',
          ''
          );
  EXPORT STRING fuel_desc (STRING fuel):=MAP(
          fuel = 'B' => 'Electric and gasoline hybrid engine',
          fuel = 'C' => 'Gasoline engine that can be converted to a gaseous powered engine (natural gas, propane, etc.)',
          fuel = 'D' => 'Diesel',
          fuel = 'E' => 'Electric',
          fuel = 'F' => 'Flexible fuel',
          fuel = 'G' => 'Gas',
          fuel = 'H' => 'Ethanol fuel only',
          fuel = 'M' => 'Methanol gas only',
          fuel = 'N' => 'Compressed natural gas',
          fuel = 'P' => 'Propane',
          fuel = 'R' => 'Hydrogen Fuel Cell',
          fuel = 'U' => 'Unknown',
          fuel = 'Y' => 'Electric and Diesel Hybrid',
          '');

EXPORT STRING make_Description(STRING makecode) :=
      MAP(makecode = 'ACUR' => 'Acura',
          makecode = 'ALFA' => 'Alfa Romeo',
          makecode = 'AMER' => 'American Motors',
          makecode = 'AMGE' => 'AM General',
          makecode = 'AMGN' => 'AM General Corp.',
          makecode = 'ASTO' => 'Aston Martin',
          makecode = 'ASUN' => 'Asuna',
          makecode = 'AUDI' => 'Audi',
          makecode = 'AUTC' => 'Autocar LLC',
          makecode = 'AUTO' => 'Autocar',
          makecode = 'AVTI' => 'Avanti',
          makecode = 'AZU' => 'Azure Dynamics',
          makecode = 'BENT' => 'Bentley',
          makecode = 'BMW' => 'BMW',
          makecode = 'BUGA' => 'Bugatti',
          makecode = 'BUIC' => 'Buick',
          makecode = 'CADI' => 'Cadillac',
          makecode = 'CAT' => 'Catepillar',
          makecode = 'CHEV' => 'Chevrolet',
          makecode = 'CHRY' => 'Chrysler',
          makecode = 'CPIU' => 'CPI Motor Company',
          makecode = 'DAEW' => 'Daewoo',
          makecode = 'DAIH' => 'Daihatsu',
          makecode = 'DATS' => 'Datsun',
          makecode = 'DIAR' => 'Diamond Reo',
          makecode = 'DODG' => 'Dodge',
          makecode = 'EAGL' => 'Eagle',
          makecode = 'EGIL' => 'Eagle',
          makecode = 'FERR' => 'Ferrari',
          makecode = 'FIAT' => 'Fiat',
          makecode = 'FORD' => 'Ford',
          makecode = 'FRHT' => 'Freightliner',
          makecode = 'FSKR' => 'Fisker Automotive',
          makecode = 'FWD' => 'FWD Corporation',
          makecode = 'GEM' => 'Gem Trailers, Inc.',
          makecode = 'GEO' => 'Geo',
          makecode = 'GM' => 'GM',
          makecode = 'GMC' => 'GMC',
          makecode = 'HD' => 'Harley Davidson',
          makecode = 'HINO' => 'Hino',
          makecode = 'HOND' => 'Honda',
          makecode = 'HUMM' => 'Hummer',
          makecode = 'HYOS' => 'Hyosung',
          makecode = 'HYUN' => 'Hyundai',
          makecode = 'INFI' => 'Infiniti',
          makecode = 'INTL' => 'International',
          makecode = 'ISU' => 'Isuzu',
          makecode = 'IVCM' => 'Iveco-Magirus',
          makecode = 'IVEC' => 'Iveco',
          makecode = 'JAGU' => 'Jaguar',
          makecode = 'JAYC' => 'Jayco',
          makecode = 'JEEP' => 'Jeep',
          makecode = 'JEP' => 'Jeep',
          makecode = 'KAW' => 'Kawasaki',
          makecode = 'KAWK' => 'Kawasaki',
          makecode = 'KIA' => 'Kia',
          makecode = 'KW' => 'Kenworth',
          makecode = 'LADA' => 'Lada',
          makecode = 'LAMO' => 'Lamborghini',
          makecode = 'LAND' => 'Land Rover',
          makecode = 'LEXS' => 'Lexus',
          makecode = 'LEXU' => 'Lexus',
          makecode = 'LINC' => 'Lincoln',
          makecode = 'LNCI' => 'Lancia',
          makecode = 'LNDR' => 'Land Rover',
          makecode = 'LOTU' => 'Lotus',
          makecode = 'MACK' => 'Mack',
          makecode = 'MASE' => 'Maserati',
          makecode = 'MAYB' => 'Maybach',
          makecode = 'MAZD' => 'Mazda',
          makecode = 'MCLA' => 'McLaren Automotive',
          makecode = 'MERC' => 'Mercury',
          makecode = 'MERK' => 'Merkur',
          makecode = 'MERZ' => 'Mercedes Benz',
          makecode = 'MIFU' => 'Mitsubishi Fuso Truck of America',
          makecode = 'MIN' => 'Mini',
          makecode = 'MINC' => 'Mini Cooper',
          makecode = 'MINI' => 'Mini Cooper',
          makecode = 'MITS' => 'Mitsubishi',
          makecode = 'MNNI' => 'Mini',
          makecode = 'NDMC' => 'Nissan Diesel Motor Corp.',
          makecode = 'NISS' => 'Nissan',
          makecode = 'OLDS' => 'Oldsmobile',
          makecode = 'OSHK' => 'Oshkosh',
          makecode = 'PASS' => 'Passport',
          makecode = 'PEUG' => 'Peugeot',
          makecode = 'PLYM' => 'Plymouth',
          makecode = 'POLA' => 'Polar',
          makecode = 'POLS' => 'Polaris',
          makecode = 'PONI' => 'PONI',
          makecode = 'PONT' => 'Pontiac',
          makecode = 'PORS' => 'Porsche',
          makecode = 'PTRB' => 'Peterbilt',
          makecode = 'RAM' => 'RAM',
          makecode = 'RANG' => 'Range Rover',
          makecode = 'RENA' => 'Renault',
          makecode = 'ROL' => 'Rolls-Royce',
          makecode = 'ROV' => 'Range Rover',
          makecode = 'SAA' => 'Saab',
          makecode = 'SATU' => 'Saturn',
          makecode = 'SMRT' => 'Smart',
          makecode = 'SPNR' => 'Sprinter',
          makecode = 'STER' => 'Sterling',
          makecode = 'STLG' => 'Sterling',
          makecode = 'STRG' => 'Sterling',
          makecode = 'STRN' => 'Saturn',
          makecode = 'SUBA' => 'Subaru',
          makecode = 'SUZI' => 'Suzuki',
          makecode = 'SUZU' => 'Suzuki',
          makecode = 'TERR' => 'Terra Tiger',
          makecode = 'TESL' => 'Tesla',
          makecode = 'TITA' => 'Titan',
          makecode = 'TOYT' => 'Toyota',
          makecode = 'TRIU' => 'Triumph Car',
          makecode = 'TRUM' => 'Triumph Motorcycle',
          makecode = 'TVR' => 'TVR',
          makecode = 'UD' => 'Nissan Diesel Motor Corp.',
          makecode = 'VCTY' => 'Victory Motorcycles',
          makecode = 'VESP' => 'Vespa',
          makecode = 'VOLK' => 'Volkswagen',
          makecode = 'VOLV' => 'Volvo',
          makecode = 'WHGM' => 'White-GMC',
          makecode = 'WHIT' => 'White',
          makecode = 'WINN' => 'Winnebago',
          makecode = 'WSTR' => 'Western Star',
          makecode = 'YAM' => 'Yamaha',
          makecode = 'YAMA' => 'Yamaha',
          makecode = 'YUGO' => 'Yugo',
          makecode = 'ZONG' => 'Zongshen',
          '');
END;
