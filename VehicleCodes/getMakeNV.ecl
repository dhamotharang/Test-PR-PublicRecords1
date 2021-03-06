export getMakeNV(string pMakeCode) 
 := case(pMakeCode,
	'*ODGE'	=> 'Dodge',
	'ACUR'	=> 'Acura',
	'ACURA'	=> 'Acura',
	'AERO'	=> 'Aero',
	'AIRST'	=> 'Airstream',
	'ALFA'	=> 'Alfa Romeo',
	'ALFRO'	=> 'Alfa Romeo',
	'AMC'	=> 'AMC',
	'AMER'	=> 'American',
	'AMERI'	=> 'American',
	'AMGEN'	=> 'AmGen',
	'APACH'	=> 'Apache',
	'ARCTI'	=> 'Arctic Cat',
	'ARIST'	=> 'Aristocrat',
	'ASPEN'	=> 'Aspen',
	'ATLAN'	=> 'Atlantis',
	'AUDI'	=> 'Audi',
	'AUSTN'	=> 'Austin',
	'AUTO'	=> 'Auto',
	'AUTOC'	=> 'Autocar',
	'AZTEC'	=> 'Aztec',
	'BEST'	=> 'Best',
	'BLAIR'	=> 'Blair',
	'BLUEB'	=> 'Bluebird',
	'BMW'	=> 'BMW',
	'BRONC'	=> 'Bronco',
	'BROWN'	=> 'Brown',
	'BSA'	=> 'BSA',
	'BUDD'	=> 'Buddy',
	'BUELL'	=> 'Buell',
	'BUIC'	=> 'Buick',
	'BUICK'	=> 'Buick',
	'CAD'	=> 'Cadillac',
	'CADI'	=> 'Cadillac',
	'CADIL'	=> 'Cadillac',
	'CANAM'	=> 'Can Am',
	'CAPRI'	=> 'Capri',
	'CENTU'	=> 'Century',
	'CHAM'	=> 'Champion',
	'CHAMP'	=> 'Champion',
	'CHEV'	=> 'Chevrolet',
	'CHEVR'	=> 'Chevrolet',
	'CHEVY'	=> 'Chevrolet',
	'CHRY'	=> 'Chrysler',
	'CHRYS'	=> 'Chrysler',
	'CIRCJ'	=> 'Circle J',
	'CIRCL'	=> 'Circle J',
	'COACH'	=> 'Coachmobile',
	'COACM'	=> 'Coachman',
	'COBR'	=> 'Cobra',
	'COBRA'	=> 'Cobra',
	'COLEM'	=> 'Coleman',
	'COLT'	=> 'Colt',
	'COMET'	=> 'Comet',
	'CONCO'	=> 'Concord',
	'CONTI'	=> 'Continental',
	'COURI'	=> 'Courier',
	'CRANE'	=> 'Crane',
	'CUSH'	=> 'Cushman',
	'CUSHM'	=> 'Cushman',
	'CUSTO'	=> 'Custom',
	'DAEWO'	=> 'Daewoo',
	'DATS'	=> 'Datsun',
	'DATSN'	=> 'Datsun',
	'DATSU'	=> 'Datsun',
	'DCT'	=> 'Dct',
	'DELOR'	=> 'Delorean',
	'DELTA'	=> 'Delta',
	'DESOT'	=> 'Desoto',
	'DETRO'	=> 'Detroit',
	'DIAMO'	=> 'Diamond',
	'DODG'	=> 'Dodge',
	'DODGE'	=> 'Dodge',
	'DOLPH'	=> 'Dolphin',
	'DORSY'	=> 'Dorsy',
	'DUCA'	=> 'Ducati',
	'DUCAT'	=> 'Ducati',
	'DUTCH'	=> 'Dutch',
	'EAGL'	=> 'Eagle',
	'EAGLE'	=> 'Eagle',
	'EAST'	=> 'East',
	'EDSEL'	=> 'Edsel',
	'ELDOR'	=> 'Eldorado',
	'ELITE'	=> 'Elite',
	'ESCOR'	=> 'Escort',
	'ESCRT'	=> 'Escort',
	'EXCAL'	=> 'Excalibur',
	'EXCEL'	=> 'Excel',
	'EZLD'	=> 'Easy Load',
	'EZLOA'	=> 'Easy Loader',
	'FALCN'	=> 'Falcon',
	'FEATH'	=> 'Featherlite',
	'FIAT'	=> 'Fiat',
	'FLEET'	=> 'Fleetwood',
	'FOR'	=> 'Ford',
	'FORD'	=> 'Ford',
	'FREIG'	=> 'Freighliner',
	'FRELI'	=> 'Freighliner',
	'FRHT'	=> 'Freighliner',
	'FRTLN'	=> 'Freightliner',
	'FRUE'	=> 'Fruehauf',
	'FRUEH'	=> 'Fruehauf',
	'frueh'	=> 'Fruehauf',
	'FTWD'	=> 'Fleetwood',
	'FWD'	=> 'FWD',
	'GEO'	=> 'Geo',
	'GINDY'	=> 'Gindy',
	'GMC'	=> 'GMC',
	'GREAT'	=> 'Great Dane',
	'GREML'	=> 'Gremlin',
	'H&H'	=> 'H&H',
	'HALE'	=> 'Hale',
	'HARLE'	=> 'Harley Davidson',
	'HAULM'	=> 'Haulmobile',
	'HD'	=> 'Harley Davidson',
	'HEIL'	=> 'Heil',
	'HH'	=> 'HH',
	'HINO'	=> 'Hino',
	'HMADE'	=> 'Homemade',
	'HMDE'	=> 'Homemade',
	'HOBBS'	=> 'Hobbs',
	'HOL'	=> 'R Hol R',
	'HOLID'	=> 'Holiday',
	'HOLR'	=> 'Monitor',
	'HOLT'	=> 'Holt',
	'HOMD'	=> 'Homemade',
	'HOMEM'	=> 'Homemade',
	'HOMET'	=> 'Homemade',
	'HON'	=> 'Honda',
	'HOND'	=> 'Honda',
	'HONDA'	=> 'Honda',
	'HONEY'	=> 'Honey',
	'HORNE'	=> 'Hornet',
	'HOWAR'	=> 'Howard',
	'HUDSN'	=> 'Hudson',
	'HURST'	=> 'Hurst',
	'HYUN'	=> 'Hyundai',
	'HYUND'	=> 'Hyundai',
	'HYUNI'	=> 'Hyundai',
	'IDEAL'	=> 'Ideal',
	'IHC'	=> 'International Harvester',
	'IMPER'	=> 'Imperial',
	'INFIN'	=> 'Infiniti',
	'INT'	=> 'International',
	'INTER'	=> 'International',
	'INTL'	=> 'International',
	'INTNA'	=> 'International',
	'INTNL'	=> 'International',
	'INTST'	=> 'Intst',
	'ISU'	=> 'Isuzu',
	'ISUZU'	=> 'Isuzu',
	'ITASC'	=> 'Itasca',
	'IVECO'	=> 'Iveco',
	'JAGUA'	=> 'Jaguar',
	'JAGUR'	=> 'Jaguar',
	'JAMAR'	=> 'Jamar',
	'JAVEL'	=> 'Javelin',
	'JAYCO'	=> 'Jayco',
	'JEEP'	=> 'Jeep',
	'JEP'	=> 'Jeep',
	'JET'	=> 'Jet',
	'JETCO'	=> 'Jetco',
	'KAISE'	=> 'Kaiser',
	'KAISR'	=> 'Kaiser',
	'KAWA'	=> 'Kawasaki',
	'KAWAK'	=> 'Kawasaki',
	'KAWAS'	=> 'Kawasaki',
	'KAWK'	=> 'Kawasaki',
	'KAYOT'	=> 'Kayot',
	'KENT'	=> 'Kentron',
	'KENW'	=> 'Kenworth',
	'KENWO'	=> 'Kenworth',
	'KIA'	=> 'Kia',
	'KIEFR'	=> 'Keifer',
	'KIRKW'	=> 'Kirkwood',
	'KIT'	=> 'Kit',
	'KTM'	=> 'KTM',
	'KW'	=> 'Kawasaki',
	'LAND'	=> 'Landcraft / Land Rover',
	'LANRO'	=> 'Land Rover',
	'LARK'	=> 'Lark',
	'LASAL'	=> 'Lasalle',
	'LAYTO'	=> 'Layton',
	'LEISU'	=> 'Leisure',
	'LEXUS'	=> 'Lexus',
	'LIBER'	=> 'Liberty',
	'LIBTY'	=> 'Liberty',
	'LINC'	=> 'Lincoln',
	'LINCN'	=> 'Lincoln',
	'LINCO'	=> 'Lincoln',
	'LINDY'	=> 'Lindy',
	'LOADK'	=> 'Load King',
	'LODAL'	=> 'Lodal',
	'LOTUS'	=> 'Lotus',
	'LUFKN'	=> 'Lufkin',
	'MACK'	=> 'Mack',
	'MATAD'	=> 'Matador',
	'MAZD'	=> 'Mazda',
	'MAZDA'	=> 'Mazda',
	'MCI'	=> 'MCI',
	'MEDAL'	=> 'Medallion',
	'MER'	=> 'Mercury',
	'MERBE'	=> 'Mercedes',
	'MERC'	=> 'Mercury',
	'MERCB'	=> 'Mercury',
	'MERCE'	=> 'Mercedes',
	'MERCU'	=> 'Mercury',
	'MERZ'	=> 'Mercedes',
	'METRO'	=> 'Metropolitan',
	'MG'	=> 'MG',
	'MIDAS'	=> 'Midas',
	'MILLR'	=> 'Miller',
	'MITS'	=> 'Mitsubishi',
	'MITSU'	=> 'Mitsubishi',
	'MONCO'	=> 'Monco',
	'MONON'	=> 'Monon',
	'MUVAL'	=> 'Muvall',
	'NASH'	=> 'Nash',
	'NISS'	=> 'Nissan',
	'NISSA'	=> 'Nissan',
	'NOMAD'	=> 'Nomad',
	'NORT'	=> 'Norton',
	'NUWA'	=> 'Nu-Wa Industries',
	'OLDS'	=> 'Oldsmobile',
	'OLDSM'	=> 'Oldsmobile',
	'OPEL'	=> 'Opel',
	'OSHK'	=> 'Oshkosh',
	'OWENS'	=> 'Owens',
	'PACAM'	=> 'Pacam',
	'pacam'	=> 'Pacam',
	'PACE'	=> 'Pace',
	'PACEA'	=> 'Pace American',
	'PACER'	=> 'Pacer',
	'PACK'	=> 'Pack',
	'PATHF'	=> 'Pathfinder',
	'PBLT'	=> 'Peterbilt',
	'PEERL'	=> 'Peerless',
	'PETER'	=> 'Peterbilt',
	'PEUGE'	=> 'Peugeot',
	'PIERC'	=> 'Pierce Lowboy Trailer',
	'PINE'	=> 'Pines Trailer Mfg.',
	'PJTR'	=> 'PJ Trailer Manufacturing',
	'PLY'	=> 'Plymouth',
	'PLYM'	=> 'Plymouth',
	'PLYMO'	=> 'Plymouth',
	'POLA'	=> 'Polaris',
	'POLAR'	=> 'Polaris',
	'POLS'	=> 'Polaris',
	'PONT'	=> 'Pontiac',
	'PONTI'	=> 'Pontiac',
	'PORSC'	=> 'Porsche',
	'PREMI'	=> 'Premiere',
	'PROWL'	=> 'Prowler',
	'PTRB'	=> 'Peterbilt',
	'RAINB'	=> 'Rainbow',
	'RAMB'	=> 'Rambler',
	'RAMBL'	=> 'Rambler',
	'RANCH'	=> 'Ranch',
	'RAVEN'	=> 'Ravens Metal Products',
	'REBEL'	=> 'Rebellious Drag Trailer',
	'RECON'	=> 'Reco Goliath Tent / Reconstructed',
	'RENAU'	=> 'Renault',
	'RENLT'	=> 'Renault',
	'REO'	=> 'Reo',
	'RNALT'	=> 'Renault',
	'ROADR'	=> 'Roadrunner',
	'ROLLS'	=> 'Rolls International',
	'ROYAL'	=> 'Royal',
	'SAAB'	=> 'Saab',
	'SALEM'	=> 'Salem',
	'SATR'	=> 'Saturn',
	'SATUR'	=> 'Saturn',
	'SCAMP'	=> 'Scamp',
	'SCHUL'	=> 'Schuller',
	'SERRO'	=> 'Serro Scotty',
	'SHAST'	=> 'Shasta',
	'SHEL'	=> 'Shelby Industries, Inc.',
	'SHELB'	=> 'Shelby Industries',
	'SIERA'	=> 'Sierra',
	'SIERR'	=> 'Sierra',
	'SKAMP'	=> 'Skamper Corp',
	'SKYL'	=> 'Skylin Buddy Motor Home',
	'SKYLI'	=> 'Skyliner',
	'SPART'	=> 'Spartan',
	'SPORT'	=> 'Sport',
	'SPRIT'	=> 'Springer (S.&S. Homes, Inc.)',
	'SS'	=> 'SS',
	'STAR'	=> 'Starcraft',
	'STARC'	=> 'Starcraft',
	'STARL'	=> 'Starliner',
	'STERL'	=> 'Sterling',
	'STRCR'	=> 'Street Rod Cabriolet',
	'STRIC'	=> 'Strick Corporation',
	'STRIK'	=> 'Strick Corporation',
	'STUDE'	=> 'Studebaker',
	'SUBA'	=> 'Subaru',
	'SUBAR'	=> 'Subaru',
	'SUNB'	=> 'Sunbeam',
	'SUNDO'	=> 'Sundowner',
	'SUPER'	=> 'Superliner',
	'SUZI'	=> 'Suzuki',
	'SUZUK'	=> 'Suzuki',
	'SWING'	=> 'Swinger',
	'TAHOE'	=> 'Tahoe',
	'TENN'	=> 'Tennessee Trailer',
	'TERRY'	=> 'Terry',
	'TETON'	=> 'Teton',
	'TIGER'	=> 'Tiger',
	'TIMPT'	=> 'Timpte',
	'TIOGA'	=> 'Tioga',
	'TITAN'	=> 'Titan',
	'TMC'	=> 'TMC',
	'TOP'	=> 'Top 3 Trailers',
	'TOP3'	=> 'Top 3 Trailers',
	'TOYOT'	=> 'Toyota',
	'TOYT'	=> 'Toyota',
	'TRAIL'	=> 'Trailstar',
	'TRANS'	=> 'Transportation Systems',
	'TRAVA'	=> 'TravelAll',
	'TRAVE'	=> 'TravelAll',
	'TRIM'	=> 'Trailmobile',
	'TRIU'	=> 'Triumph',
	'TRIUM'	=> 'Triumph',
	'TRLM'	=> 'Trailmobile',
	'TRUCO'	=> 'Truco Eaton Metal',
	'TURTL'	=> 'Turtle Top',
	'UHAUL'	=> 'U-Haul Company',
	'ULTRA'	=> 'Ultra',
	'UNITE'	=> 'United Trailer',
	'URAL'	=> 'Ural',
	'UTIL'	=> 'Utility',
	'UTILI'	=> 'Utility',
	'UTILT'	=> 'Utility Trailer',
	'VEGA'	=> 'Vega',
	'VESPA'	=> 'Vespa',
	'VICTY'	=> 'Victory Industrial',
	'VIKIN'	=> 'Viking',
	'VOLK'	=> 'Volkswagen',
	'VOLKS'	=> 'Volkswagen',
	'VOLV'	=> 'Volvo',
	'VOLVO'	=> 'Volvo',
	'VW'	=> 'Volkswagen',
	'WABAS'	=> 'Wabash National',
	'WALKE'	=> 'Walker Stainless Equipment Co.',
	'WARD'	=> 'Ward Industries',
	'WELLS'	=> 'Wells Cargo',
	'WESTE'	=> 'Western Star',
	'WHGMC'	=> 'White/GMC',
	'WHITE'	=> 'White GMC',
	'WILDE'	=> 'Wilderness',
	'WILLY'	=> 'Willys',
	'WILSN'	=> 'Wilson Trailer Company',
	'WILSO'	=> 'Wilson',
	'WILYS'	=> 'Willys',
	'WINDS'	=> 'Windstar',
	'WINN'	=> 'Winnebago',
	'WINNE'	=> 'Winnebago',
	'WW'	=> 'WW Two Axle Horse Trailer',
	'WWTRA'	=> 'Worldwide Trailer',
	'WWTRL'	=> 'W-W Trailers',
	'YACHT'	=> 'Yacht',
	'YAMA'	=> 'Yamaha',
	'YAMAH'	=> 'Yamaha',
	'YELST'	=> 'Yellowstone, Inc.',
	'YUGO'	=> 'Yugo',
	getMakeMO(pMakeCode));