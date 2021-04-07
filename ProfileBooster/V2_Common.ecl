IMPORT Risk_Indicators, UT;

EXPORT V2_Common := MODULE
	
//this works with dates in YYYYMMDD format
EXPORT integer monthsApart_YYYYMMDD(string8 d1, string8 d2, boolean roundUpPartial = false) := FUNCTION
	early := MIN(d1, d2);
	late := MAX(d1, d2);
  yrs := ((integer)late[1..4] - (integer)early[1..4]) * 12;
	months := (integer)late[5..6] - (integer)early[5..6];
  // round up partial month if requested
	partial := if(roundUpPartial and (integer) late[7..8] >= (integer) early[7..8], 1, 0);
	
	RETURN yrs + months + partial;
END;

EXPORT string8 convertDateTo8(string d1) := FUNCTION
  IMPORT STD ;
  dateLength := LENGTH(TRIM(d1));
  Result := MAP(dateLength = 4 => d1 + '0101',
                dateLength = 6 => d1 + '01',
				dateLength = 8 => d1,
				                  '0');
  RETURN Result;
END;


EXPORT STRING6 getProfLicActiveNewTitleType(string occupation, integer category) := FUNCTION
//   IMPORT STD ;
	ProfLicActiveNewTitleType := 
		MAP(
			occupation='PHYSICIANS AND SURGEONS' and category=5 => '001',
			occupation='NURSE PRACTITIONERS, AND NURSE MIDWIVES' and category=5 => '002',
			occupation='MEDICAL SCIENTISTS, AND LIFE SCIENTISTS, ALL OTHER' and category=5 => '003',
			occupation='DENTISTS' and category=5 => '004',
			occupation='AUDIOLOGISTS' and category=5 => '005',
			occupation='OPTOMETRISTS' and category=5 => '006',
			occupation='PHYSICAL SCIENTISTS, ALL OTHER' and category=5 => '007',
			occupation='PODIATRISTS' and category=5 => '008',
			occupation='PSYCHOLOGISTS' and category=5 => '009',
			occupation='SPEECH-LANGUAGE PATHOLOGISTS' and category=5 => '010',
			occupation='VETERINARIANS' and category=5 => '011',
			occupation='ADMINISTRATIVE SERVICES MANAGERS' and category=4 => '012',
			occupation='AEROSPACE ENGINEERS' and category=4 => '013',
			occupation='AIR TRAFFIC CONTROLLERS AND AIRFIELD OPERATIONS SPECIALISTS' and category=4 => '014',
			occupation='AIRCRAFT PILOTS AND FLIGHT ENGINEERS' and category=4 => '015',
			occupation='ARCHITECTS, EXCEPT NAVAL' and category=4 => '016',
			occupation='BIOMEDICAL AND AGRICULTURAL ENGINEERS' and category=4 => '017',
			occupation='CHEMICAL ENGINEERS' and category=4 => '018',
			occupation='CHIEF EXECUTIVES AND LEGISLATORS' and category=4 => '019',
			occupation='CIVIL ENGINEERS' and category=4 => '020',
			occupation='COMPUTER AND INFORMATION RESEARCH SCIENTISTS' and category=4 => '021',
			occupation='ELECTRICAL AND ELECTRONICS ENGINEERS' and category=4 => '022',
			occupation='ELEVATOR INSTALLERS AND REPAIRERS' and category=4 => '023',
			occupation='ENVIRONMENTAL ENGINEERS' and category=4 => '024',
			occupation='ENVIRONMENTAL SCIENTISTS AND GEOSCIENTISTS' and category=4 => '025',
			occupation='FIRST-LINE SUPERVISORS OF FIRE FIGHTING AND PREVENTION WORKERS' and category=4 => '026',
			occupation='GENERAL AND OPERATIONS MANAGERS' and category=4 => '027',
			occupation='INDUSTRIAL ENGINEERS, INCLUDING HEALTH AND SAFETY' and category=4 => '028',
			occupation='LAWYERS, AND JUDGES, MAGISTRATES, AND OTHER JUDICIAL WORKERS' and category=4 => '029',
			occupation='MARINE ENGINEERS AND NAVAL ARCHITECTS' and category=4 => '030',
			occupation='MATERIALS ENGINEERS' and category=4 => '031',
			occupation='MECHANICAL ENGINEERS' and category=4 => '032',
			occupation='MEDICAL AND HEALTH SERVICES MANAGERS' and category=4 => '033',
			occupation='MISCELLANEOUS ENGINEERS, INCLUDING NUCLEAR ENGINEERS' and category=4 => '034',
			occupation='MISCELLANEOUS MANAGERS, INCLUDING FUNERAL SERVICE MANAGERS AND POSTMASTERS AND MAIL SUPERINTENDENTS' and category=4 => '035',
			occupation='NURSE ANESTHETISTS' and category=4 => '036',
			occupation='OCCUPATIONAL THERAPISTS' and category=4 => '037',
			occupation='PETROLEUM, MINING AND GEOLOGICAL ENGINEERS, INCLUDING MINING SAFETY ENGINEERS' and category=4 => '038',
			occupation='PHARMACISTS' and category=4 => '039',
			occupation='PHYSICAL THERAPISTS' and category=4 => '040',
			occupation='PHYSICIAN ASSISTANTS' and category=4 => '041',
			occupation='POSTSECONDARY TEACHERS' and category=4 => '042',
			occupation='RADIATION THERAPISTS' and category=4 => '043',
			occupation='SECURITIES, COMMODITIES, AND FINANCIAL SERVICES SALES AGENTS' and category=4 => '044',
			occupation='TRAINING AND DEVELOPMENT MANAGERS' and category=4 => '045',
			occupation='ACCOUNTANTS AND AUDITORS' and category=3 => '046',
			occupation='AGENTS AND BUSINESS MANAGERS OF ARTISTS, PERFORMERS, AND ATHLETES' and category=3 => '047',
			occupation='AGRICULTURAL AND FOOD SCIENTISTS' and category=3 => '048',
			occupation='BOILERMAKERS' and category=3 => '049',
			occupation='BROADCAST AND SOUND ENGINEERING TECHNICIANS AND RADIO OPERATORS, AND MEDIA AND COMMUNICATION EQUIPME' and category=3 => '050',
			occupation='BROKERAGE CLERKS' and category=3 => '051',
			occupation='CHIROPRACTORS' and category=3 => '052',
			occupation='CLAIMS ADJUSTERS, APPRAISERS, EXAMINERS, AND INVESTIGATORS' and category=3 => '053',
			occupation='CLINICAL LABORATORY TECHNOLOGISTS AND TECHNICIANS' and category=3 => '054',
			occupation='CONSERVATION SCIENTISTS AND FORESTERS' and category=3 => '055',
			occupation='CREDIT COUNSELORS AND LOAN OFFICERS' and category=3 => '056',
			occupation='DENTAL HYGIENISTS' and category=3 => '057',
			occupation='DESIGNERS' and category=3 => '058',
			occupation='DIAGNOSTIC RELATED TECHNOLOGISTS AND TECHNICIANS' and category=3 => '059',
			occupation='DIETITIANS AND NUTRITIONISTS' and category=3 => '060',
			occupation='FIRST-LINE SUPERVISORS OF CONSTRUCTION TRADES AND EXTRACTION WORKERS' and category=3 => '061',
			occupation='FUNDRAISERS' and category=3 => '062',
			occupation='HUMAN RESOURCES WORKERS' and category=3 => '063',
			occupation='INSURANCE UNDERWRITERS' and category=3 => '064',
			occupation='JUDICIAL LAW CLERKS' and category=3 => '065',
			occupation='LIBRARIANS' and category=3 => '066',
			occupation='MEETING, CONVENTION, AND EVENT PLANNERS' and category=3 => '067',
			occupation='MISCELLANEOUS COMMUNITY AND SOCIAL SERVICE SPECIALISTS, INCLUDING HEALTH EDUCATORS AND COMMUNITY HEA' and category=3 => '068',
			occupation='MISCELLANEOUS LIFE, PHYSICAL, AND SOCIAL SCIENCE TECHNICIANS, INCLUDING SOCIAL SCIENCE RESEARCH ASSI' and category=3 => '069',
			occupation='MORTICIANS, UNDERTAKERS, AND FUNERAL DIRECTORS' and category=3 => '070',
			occupation='OCCUPATIONAL THERAPY ASSISTANTS AND AIDES' and category=3 => '071',
			occupation='OTHER EDUCATION, TRAINING, AND LIBRARY WORKERS' and category=3 => '072',
			occupation='OTHER HEALTHCARE PRACTITIONERS AND TECHNICAL OCCUPATIONS' and category=3 => '073',
			occupation='OTHER TEACHERS AND INSTRUCTORS' and category=3 => '074',
			occupation='OTHER THERAPISTS, INCLUDING EXERCISE PHYSIOLOGISTS' and category=3 => '075',
			occupation='PRIVATE DETECTIVES AND INVESTIGATORS' and category=3 => '076',
			occupation='PROBATION OFFICERS AND CORRECTIONAL TREATMENT SPECIALISTS' and category=3 => '077',
			occupation='PROPERTY, REAL ESTATE, AND COMMUNITY ASSOCIATION MANAGERS' and category=3 => '078',
			occupation='REGISTERED NURSES' and category=3 => '079',
			occupation='RESPIRATORY THERAPISTS' and category=3 => '080',
			occupation='SALES AND RELATED WORKERS, ALL OTHER' and category=3 => '081',
			occupation='SALES REPRESENTATIVES, SERVICES, ALL OTHER' and category=3 => '082',
			occupation='SALES REPRESENTATIVES, WHOLESALE AND MANUFACTURING' and category=3 => '083',
			occupation='SURVEYORS, CARTOGRAPHERS, AND PHOTOGRAMMETRISTS' and category=3 => '084',
			occupation='TAX EXAMINERS AND COLLECTORS, AND REVENUE AGENTS' and category=3 => '085',
			occupation='TRAINING AND DEVELOPMENT SPECIALISTS' and category=3 => '086',
			occupation='WATER AND WASTEWATER TREATMENT PLANT AND SYSTEM OPERATORS' and category=3 => '087',
			occupation='ANIMAL CONTROL WORKERS' and category=2 => '088',
			occupation='ANNOUNCERS' and category=2 => '089',
			occupation='APPRAISERS AND ASSESSORS OF REAL ESTATE' and category=2 => '090',
			occupation='ATHLETES, COACHES, UMPIRES, AND RELATED WORKERS' and category=2 => '091',
			occupation='AUTOMOTIVE SERVICE TECHNICIANS AND MECHANICS' and category=2 => '092',
			occupation='BILL AND ACCOUNT COLLECTORS' and category=2 => '093',
			occupation='CLEANING, WASHING, AND METAL PICKLING EQUIPMENT OPERATORS AND TENDERS' and category=2 => '094',
			occupation='CONSTRUCTION AND BUILDING INSPECTORS' and category=2 => '095',
			occupation='CONSTRUCTION MANAGERS' and category=2 => '096',
			occupation='COUNSELORS' and category=2 => '097',
			occupation='CREDIT AUTHORIZERS, CHECKERS, AND CLERKS' and category=2 => '098',
			occupation='CUSTOMER SERVICE REPRESENTATIVES' and category=2 => '099',
			occupation='DERRICK, ROTARY DRILL, AND SERVICE UNIT OPERATORS, AND ROUSTABOUTS, OIL, GAS, AND MINING' and category=2 => '100',
			occupation='DIRECTORS, RELIGIOUS ACTIVITIES AND EDUCATION' and category=2 => '101',
			occupation='ELECTRIC MOTOR, POWER TOOL, AND RELATED REPAIRERS' and category=2 => '102',
			occupation='ELECTRICIANS' and category=2 => '103',
			occupation='EMBALMERS AND FUNERAL ATTENDANTS' and category=2 => '104',
			occupation='EMERGENCY MEDICAL TECHNICIANS AND PARAMEDICS' and category=2 => '105',
			occupation='EXTRUDING AND DRAWING MACHINE SETTERS, OPERATORS, AND TENDERS, METAL AND PLASTIC' and category=2 => '106',
			occupation='FINANCIAL CLERKS, ALL OTHER' and category=2 => '107',
			occupation='FIRST-LINE SUPERVISORS OF CONSTRUCTION TRADES AND EXTRACTION WORKERS' and category=2 => '108',
			occupation='FOOD SERVICE MANAGERS' and category=2 => '109',
			occupation='HAZARDOUS MATERIALS REMOVAL WORKERS' and category=2 => '110',
			occupation='HEATING, AIR CONDITIONING, AND REFRIGERATION MECHANICS AND INSTALLERS' and category=2 => '111',
			occupation='HOME APPLIANCE REPAIRERS' and category=2 => '112',
			occupation='INSPECTORS, TESTERS, SORTERS, SAMPLERS, AND WEIGHERS' and category=2 => '113',
			occupation='INSURANCE SALES AGENTS' and category=2 => '114',
			occupation='LICENSED PRACTICAL AND LICENSED VOCATIONAL NURSES' and category=2 => '115',
			occupation='LIFEGUARDS AND OTHER RECREATIONAL, AND ALL OTHER PROTECTIVE SERVICE WORKERS' and category=2 => '116',
			occupation='LOCKSMITHS AND SAFE REPAIRERS' and category=2 => '117',
			occupation='MEDICAL, DENTAL, AND OPHTHALMIC LABORATORY TECHNICIANS' and category=2 => '118',
			occupation='MILITARY, RANK NOT SPECIFIED' and category=2 => '119',
			occupation='MISCELLANEOUS CONSTRUCTION WORKERS, INCLUDING SOLAR PHOTOVOLTAIC INSTALLERS, AND SEPTIC TANK SERVICE' and category=2 => '120',
			occupation='MISCELLANEOUS HEALTH TECHNOLOGISTS AND TECHNICIANS' and category=2 => '121',
			occupation='MISCELLANEOUS LAW ENFORCEMENT WORKERS' and category=2 => '122',
			occupation='MISCELLANEOUS LIFE, PHYSICAL, AND SOCIAL SCIENCE TECHNICIANS, INCLUDING SOCIAL SCIENCE RESEARCH ASSI' and category=2 => '123',
			occupation='MISCELLANEOUS MATERIAL MOVING WORKERS, INCLUDING MINE SHUTTLE CAR OPERATORS, AND TANK CAR, TRUCK, AN' and category=2 => '124',
			occupation='MISCELLANEOUS MEDIA AND COMMUNICATION WORKERS' and category=2 => '125',
			occupation='MISCELLANEOUS OFFICE AND ADMINISTRATIVE SUPPORT WORKERS, INCLUDING DESKTOP PUBLISHERS' and category=2 => '126',
			occupation='MISCELLANEOUS TRANSPORTATION WORKERS, INCLUDING BRIDGE AND LOCK TENDERS AND TRAFFIC TECHNICIANS' and category=2 => '127',
			occupation='OPTICIANS, DISPENSING' and category=2 => '128',
			occupation='OTHER INSTALLATION, MAINTENANCE, AND REPAIR WORKERS, INCLUDING WIND TURBINE SURVICE TECHNICIANS, AND' and category=2 => '129',
			occupation='PEST CONTROL WORKERS' and category=2 => '130',
			occupation='PHARMACY AIDES' and category=2 => '131',
			occupation='PIPELAYERS, PLUMBERS, PIPEFITTERS, AND STEAMFITTERS' and category=2 => '132',
			occupation='POLICE OFFICERS' and category=2 => '133',
			occupation='RECREATIONAL THERAPISTS' and category=2 => '134',
			occupation='SECRETARIES AND ADMINISTRATIVE ASSISTANTS' and category=2 => '135',
			occupation='SECURITY AND FIRE ALARM SYSTEMS INSTALLERS' and category=2 => '136',
			occupation='SHEET METAL WORKERS' and category=2 => '137',
			occupation='SOCIAL WORKERS' and category=2 => '138',
			occupation='STATIONARY ENGINEERS AND BOILER OPERATORS' and category=2 => '139',
			occupation='SUBWAY, STREETCAR, AND OTHER RAIL TRANSPORTATION WORKERS' and category=2 => '140',
			occupation='WATER AND WASTEWATER TREATMENT PLANT AND SYSTEM OPERATORS' and category=2 => '141',
			occupation='WEIGHERS, MEASURERS, CHECKERS, AND SAMPLERS, RECORDKEEPING' and category=2 => '142',
			occupation='WHOLESALE AND RETAIL BUYERS, EXCEPT FARM PRODUCTS' and category=2 => '143',
			occupation='WORD PROCESSORS AND TYPISTS' and category=2 => '144',
			occupation='AMBULANCE DRIVERS AND ATTENDANTS, EXCEPT EMERGENCY MEDICAL TECHNICIANS' and category=1 => '145',
			occupation='ANIMAL TRAINERS' and category=1 => '146',
			occupation='AUTOMOTIVE AND WATERCRAFT SERVICE ATTENDANTS' and category=1 => '147',
			occupation='AUTOMOTIVE GLASS INSTALLERS AND REPAIRERS' and category=1 => '148',
			occupation='CHILDCARE WORKERS' and category=1 => '149',
			occupation='COMBINED FOOD PREPARATION AND SERVING WORKERS, INCLUDING FAST FOOD' and category=1 => '150',
			occupation='CONSTRUCTION LABORERS' and category=1 => '151',
			occupation='COUNTER ATTENDANTS, CAFETERIA, FOOD CONCESSION, AND COFFEE SHOP' and category=1 => '152',
			occupation='DENTAL ASSISTANTS' and category=1 => '153',
			occupation='ENTERTAINERS AND PERFORMERS, SPORTS AND RELATED WORKERS, ALL OTHER' and category=1 => '154',
			occupation='FISHING AND HUNTING WORKERS' and category=1 => '155',
			occupation='FOOD PROCESSING WORKERS, ALL OTHER' and category=1 => '156',
			occupation='FOOD SERVERS, NONRESTAURANT' and category=1 => '157',
			occupation='HAIRDRESSERS, HAIRSTYLISTS, AND COSMETOLOGISTS' and category=1 => '158',
			occupation='HEALTH DIAGNOSING AND TREATING PRACTITIONERS, ALL OTHER' and category=1 => '159',
			occupation='HEALTH PRACTITIONER SUPPORT TECHNOLOGISTS AND TECHNICIANS' and category=1 => '160',
			occupation='HEALTHCARE SUPPORT WORKERS, ALL OTHER, INCLUDING MEDICAL EQUIPMENT PREPARERS' and category=1 => '161',
			occupation='HOTEL, MOTEL, AND RESORT DESK CLERKS' and category=1 => '162',
			occupation='LABORERS AND FREIGHT, STOCK, AND MATERIAL MOVERS, HAND' and category=1 => '163',
			occupation='LIFEGUARDS AND OTHER RECREATIONAL, AND ALL OTHER PROTECTIVE SERVICE WORKERS' and category=1 => '164',
			occupation='MASSAGE THERAPISTS' and category=1 => '165',
			occupation='MEDICAL ASSISTANTS' and category=1 => '166',
			occupation='MISCELLANEOUS FOOD PREPARATION AND SERVING RELATED WORKERS, INCLUDING DINING ROOM AND CAFETERIA ATTE' and category=1 => '167',
			occupation='MISCELLANEOUS PERSONAL APPEARANCE WORKERS' and category=1 => '168',
			occupation='MODELS, DEMONSTRATORS, AND PRODUCT PROMOTERS' and category=1 => '169',
			occupation='NURSING, PSYCHIATRIC, AND HOME HEALTH AIDES' and category=1 => '170',
			occupation='PACKERS AND PACKAGERS, HAND' and category=1 => '171',
			occupation='PHARMACY AIDES' and category=1 => '172',
			occupation='REAL ESTATE BROKERS AND SALES AGENTS' and category=1 => '173',
			occupation='RECREATION AND FITNESS WORKERS' and category=1 => '174',
			occupation='REFUSE AND RECYCLABLE MATERIAL COLLECTORS' and category=1 => '175',
			occupation='ROOFERS' and category=1 => '176',
			occupation='SECURITY GUARDS AND GAMING SURVEILLANCE OFFICERS' and category=1 => '177',
			occupation='SHIPPING, RECEIVING, AND TRAFFIC CLERKS' and category=1 => '178',
			occupation='TOUR AND TRAVEL GUIDES' and category=1 => '179',
			occupation='VETERINARY ASSISTANTS AND LABORATORY ANIMAL CARETAKERS' and category=1 => '180',
			occupation='*CONTROLLED SUBSTANCE' and category=0 => '-99997',
			occupation='*FIREARM/BATON' and category=0 => '-99997',
			occupation='' and category=0 => '-99997',
			//CATCH ALL
			'-99997'
		);
  RETURN ProfLicActiveNewTitleType;
END;

	
END;