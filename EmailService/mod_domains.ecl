export mod_domains := module

export state_level_tld := [

'.ak','.al','.ar','.az','.ca','.co','.ct','.dc','.de','.fl',
'.ga','.hi','.ia','.id','.il','.in','.ks','.ky','.la','.ma',
'.md','.me','.mi','.mn','.mo','.ms','.mt','.nc','.nd','.ne',
'.nh','.nj','.nm','.nv','.ny','.oh','.ok','.or','.pa','.ri',
'.sc','.sd','.tn','.tx','.ut','.va','.vi','.vt','.wa','.wi',
'.wv','.wy', '.us'
];

//all of what's below was pulled from
//http://www.norid.no/domenenavnbaser/domreg.html

export generic_tld := [
'.aero',  // Aviation 
'.asia',  // Asia 
'.biz',   // Business Organizations 
'.cat',   // Catalan language and culture 
'.com',   // Commercial 
'.coop',  // Co-Operative Organizations 
'.edu',   // Education 
'.gov',   // US Government 
'.info',  // Open TLD 
'.int',   // International Organizations 
'.jobs',  // Jobs 
'.mil',   // US Department of Defense 
'.mobi',  // Mobile devices 
'.museum',// Museums 
'.name',  // Personal 
'.net',   // Networks 
'.org',   // Organizations 
'.pro',   // Credentialed professionals and related entities 
'.tel',   // Publishing of contact data 
'.travel' // Travelling
];

export country_code_tld := [
'.ac',// Ascension Island 
'.ad',// Andorra 
'.ae',// United Arab Emirates 
'.af',// Afghanistan 
'.ag',// Antigua and Barbuda 
'.ai',// Anguilla 
'.al',// Albania 
'.am',// Armenia 
'.an',// Netherlands Antilles 
'.ao',// Angola 
'.aq',// Antarctica 
'.ar',// Argentina 
'.as',// American Samoa 
'.at',// Austria 
'.au',// Australia 
'.aw',// Aruba 
'.ax',// Åland Islands 
'.az',// Azerbaijan  
'.ba',// Bosnia and Herzegovina 
'.bb',// Barbados 
'.bd',// Bangladesh 
'.be',// Belgium 
'.bf',// Burkina Faso 
'.bg',// Bulgaria 
'.bh',// Bahrain 
'.bi',// Burundi 
'.bj',// Benin 
'.bm',// Bermuda 
'.bn',// Brunei Darussalam 
'.bo',// Bolivia 
'.br',// Brazil 
'.bs',// Bahamas 
'.bt',// Bhutan 
'.bv',// Bouvet Island 
'.bw',// Botswana 
'.by',// Belarus 
'.bz',// Belize  
'.ca',// Canada 
'.cc',// Cocos (Keeling) Islands 
'.cd',// Congo, Democratic republic of the (former Zaire) 
'.cf',// Central African Republic 
'.cg',// Congo, Republic of 
'.ch',// Switzerland 
'.ci',// Côte d'Ivoire 
'.ck',// Cook Islands 
'.cl',// Chile 
'.cm',// Cameroon 
'.cn',// China 
'.co',// Colombia 
'.cr',// Costa Rica 
'.cs',// Czechoslovakia (former – non-existing) 
'.cu',// Cuba 
'.cv',// Cape Verde 
'.cx',// Christmas Island 
'.cy',// Cyprus 
'.cz',// Czech Republic  
'.de',// Germany 
'.dj',// Djibouti 
'.dk',// Denmark 
'.dm',// Dominica 
'.do',// Dominican Republic 
'.dz',// Algeria  
'.ec',// Ecuador 
'.ee',// Estonia 
'.eg',// Egypt 
'.eh',// Western Sahara 
'.er',// Eritrea 
'.es',// Spain 
'.et',// Ethiopia 
'.eu',// European Union  
'.fi',// Finland 
'.fj',// Fiji 
'.fk',// Falkland Islands 
'.fm',// Micronesia 
'.fo',// Faroe Islands 
'.fr',// France  
'.ga',// Gabon 
'.gb',// United Kingdom 
'.gd',// Grenada 
'.ge',// Georgia 
'.gf',// French Guiana 
'.gg',// Guernsey 
'.gh',// Ghana 
'.gi',// Gibraltar 
'.gl',// Greenland 
'.gm',// Gambia 
'.gn',// Guinea 
'.gp',// Guadeloupe 
'.gq',// Equatorial Guinea 
'.gr',// Greece 
'.gs',// South Georgia and the South Sandwich Islands 
'.gt',// Guatemala 
'.gu',// Guam 
'.gw',// Guinea-Bissau 
'.gy',// Guyana  
'.hk',// Hong Kong 
'.hm',// Heard and McDonald Islands 
'.hn',// Honduras 
'.hr',// Croatia 
'.ht',// Haiti 
'.hu',// Hungary  
'.id',// Indonesia 
'.ie',// Ireland 
'.il',// Israel 
'.im',// Isle of Man 
'.in',// India 
'.io',// British Indian Ocean Territory 
'.iq',// Iraq 
'.ir',// Iran 
'.is',// Iceland 
'.it',// Italia  
'.je',// Jersey 
'.jm',// Jamaica 
'.jo',// Jordan 
'.jp',// Japan  
'.ke',// Kenya 
'.kg',// Kyrgyzstan 
'.kh',// Cambodia 
'.ki',// Kiribati 
'.km',// Comoros 
'.kn',// Saint Kitts and Nevis 
'.kp',// Korea, Democratic Peoples Republic of 
'.kr',// Korea, Republic of 
'.kw',// Kuwait 
'.ky',// Cayman Islands 
'.kz',// Kazakhstan  
'.la',// Lao People's Democratic Republic 
'.lb',// Lebanon 
'.lc',// Saint Lucia 
'.li',// Liechtenstein 
'.lk',// Sri Lanka 
'.lr',// Liberia 
'.ls',// Lesotho 
'.lt',// Lithuania 
'.lu',// Luxembourg 
'.lv',// Latvia 
'.ly',// Libyan Arab Jamahiriya  
'.ma',// Morocco 
'.mc',// Monaco 
'.md',// Moldova 
'.me',// Montenegro 
'.mg',// Madagascar 
'.mh',// Marshall Islands 
'.mk',// Macedonia 
'.ml',// Mali 
'.mm',// Myanmar 
'.mn',//Mongolia 
'.mo',// Macau 
'.mp',// Northern Mariana Islands 
'.mq',// Martinique 
'.mr',// Mauritania 
'.ms',// Montserrat 
'.mt',// Malta 
'.mu',// Mauritius 
'.mv',// Maldives 
'.mw',// Malawi 
'.mx',// Mexico 
'.my',// Malaysia 
'.mz',// Mozambique  
'.na',// Namibia 
'.nc',// New Caledonia 
'.ne',// Niger 
'.nf',// Norfolk Island 
'.ng',// Nigeria 
'.ni',// Nicaragua 
'.nl',// The Netherlands 
'.no',// Norway 
'.np',// Nepal 
'.nr',// Nauru 
'.nu',// Niue 
'.nz',// New Zealand  
'.om',// Oman  
'.pa',// Panama 
'.pe',// Peru 
'.pf',// French Polynesia 
'.pg',// Papua New Guinea 
'.ph',// Philippines 
'.pk',// Pakistan 
'.pl',// Poland 
'.pm',// St. Pierre and Miquelon 
'.pn',// Pitcairn 
'.pr',// Puerto Rico 
'.ps',// Palestine 
'.pt',// Portugal 
'.pw',// Palau 
'.py',// Paraguay  
'.qa',// Qatar  
'.re',// Reunion 
'.ro',// Romania 
'.rs',// Serbia 
'.ru',// Russia 
'.rw',// Rwanda  
'.sa',// Saudi Arabia 
'.sb',// Solomon Islands 
'.sc',// Seychelles 
'.sd',// Sudan 
'.se',// Sweden 
'.sg',// Singapore 
'.sh',// St. Helena 
'.si',// Slovenia 
'.sj',// Svalbard and Jan Mayen Islands 
'.sk',// Slovakia 
'.sl',// Sierra Leone 
'.sm',// San Marino 
'.sn',// Senegal 
'.so',// Somalia 
'.sr',// Surinam 
'.st',// Sao Tome and Principe 
'.su',// USSR (former) 
'.sv',// El Salvador 
'.sy',// Syrian Arab Republic 
'.sz',// Swaziland  
'.tc',// The Turks and Caicos Islands 
'.td',// Chad 
'.tf',// French Southern Territories 
'.tg',// Togo 
'.th',// Thailand 
'.tj',// Tajikistan 
'.tk',// Tokelau 
'.tl',// Timor-Leste 
'.tm',// Turkmenistan 
'.tn',// Tunisia 
'.to',// Tonga 
'.tp',// East Timor 
'.tr',// Turkey 
'.tt',// Trinidad and Tobago 
'.tv',// Tuvalu 
'.tw',// Taiwan 
'.tz',// Tanzania  
'.ua',// Ukraine 
'.ug',// Uganda 
'.uk',// United Kingdom 
'.um',// United States Minor Outlying Islands 
'.us',// United States 
'.uy',// Uruguay 
'.uz',// Uzbekistan  
'.va',// Holy See (Vatican City State) 
'.vc',// Saint Vincent and the Grenadines 
'.ve',// Venezuela 
'.vg',// Virgin Islands British 
'.vi',// Virgin Islands U.S 
'.vn',// Vietnam 
'.vu',// Vanuatu  
'.wf',// Wallis and Futuna Islands 
'.ws',// Samoa  
'.ye',// Yemen 
'.yt',// Mayotte 
'.yu',// Yugoslavia  
'.za',// South Africa 
'.zm',// Zambia 
'.zr',// Zaire (non-existent, see Congo) 
'.zw' // Zimbabwe 
];

//http://www.zemskov.net/free-email-domains.html
export free_domain_root := [
'111mail',
'123iran',
'1-usa',
'2die4',
'37',
'420email',
'4degreez',
'4-music-today',
'5',
'5005',
'8',
'a',
'abha',
'accountant',
'actingbiz',
'address',
'adexec',
'africamail',
'agadir',
'ahsa',
'aim',
'ajman',
'ajman',
'ajman',
'albaha',
'alex4all',
'alexandria',
'algerie',
'allergist',
'allhiphop',
'alriyadh',
'alumnidirector',
'altavista',
'amman',
'anatomicrock',
'angelfire',
'animeone',
'anjungcafe',
'aqaba',
'arar',
'archaeologist',
'arcticmail',
'artlover',
'asia',
'asiancutes',
'aswan',
'a-teens',
'ausi',
'australiamail',
'autoindia',
'autopm',
'baalbeck',
'bahraini',
'banha',
'barriolife',
'b-boy',
'beautifulboy',
'berlin',
'bgay',
'bicycledata',
'bicycling',
'bigheavyworld',
'bigmailbox',
'bikerheaven',
'bikerider',
'bikermail',
'billssite',
'bizerte',
'bk',
'blackandchristian',
'blackcity',
'blackplanet',
'blackvault',
'blida',
'bmx',
'bmxtrix',
'boarderzone',
'boatnerd',
'bolbox',
'bongmail',
'bowl',
'buraydah',
'butch-femme',
'byke',
'calle22',
'cameroon',
'cannabismail',
'catlover',
'catlovers',
'certifiedbitches',
'championboxing',
'chatway',
'cheerful',
'chemist',
'chillymail',
'classprod',
'classycouples',
'clerk',
'cliffhanger',
'columnist',
'comic',
'company',
'congiu',
'consultant',
'coolmail',
'coolshit',
'corpusmail',
'counsellor',
'cutey',
'cyberunlimited',
'cycledata',
'darkfear',
'darkforces',
'deliveryman',
'dhahran',
'dhofar',
'dino',
'diplomats',
'dirtythird',
'djibouti',
'doctor',
'doglover',
'dominican',
'dopefiends',
'dr',
'draac',
'drakmail',
'dr-dre',
'dreamstop',
'dublin',
'earthling',
'earthling',
'eclub',
'egypt',
'e-mail',
'email',
'e-mail',
'emailfast',
'emails',
'e-mails',
'eminemfans ',
'envirocitizen',
'eritrea',
'eritrea',
'escapeartist',
'europe',
'excite',
'execs',
'ezsweeps',
'falasteen',
'famous',
'farts',
'feelingnaughty',
'financier',
'firemyst',
'fit',
'freeonline',
'fromru',
'front',
'fudge',
'fujairah',
'fujairah',
'fujairah',
'funkytimes',
'gabes',
'gafsa',
'gala',
'gamerssolution',
'gardener',
'gateway',
'gawab',
'gazabo',
'geologist',
'giza',
'glittergrrrls',
'gmail',
'goatrance',
'goddess',
'gohip',
'goldenmail',
'goldmail',
'gospelcity',
'gothicgirl',
'gotomy',
'grapemail',
'graphic-designer',
'greatautos',
'guinea',
'guinea',
'guy',
'hacker',
'hairdresser',
'haitisurf',
'hamra',
'happyhippo',
'hasakah',
'hateinthebox',
'hebron',
'hip hopmail',
'home',//added
'homs',
'hotbox',
'hotmail',
'hotmail',
'hot-shot',
'houseofhorrors',
'hugkiss',
'hullnumber',
'human',
'ibra',
'idunno4recipes',
'ihatenetscape',
'iname',
'inbox',
'inorbit',
'insurer',
'intimatefire',
'iphon',
'irbid',
'irow',
'ismailia',
'iwon',
'jadida',
'jadida',
'japan',
'jazzemail',
'jerash',
'jizan',
'jouf',
'journalist',
'juanitabynum',
'kairouan',
'kanoodle',
'karak',
'khaimah',
'khartoum',
'khobar',
'kickboxing',
'kidrock',
'kinkyemail',
'kool-things',
'krovatka',
'kuwaiti',
'kyrgyzstan',
'land',
'latakia',
'latchess',
'latinabarbie',
'latinogreeks',
'lawyer',
'lebanese',
'leesville',
'legislator',
'list',
'lobbyist',
'london',
'loveable',
'loveemail',
'loveis',
'lovers-mail',
'lowrider',
'lubnan',
'lubnan',
'lucky7lotto',
'lv-inter',
'lycos',
'mad',
'madeniggaz',
'madinah',
'madrid',
'maghreb',
'mail',
'mail',
'mail15',
'mail333',
'mailbomb',
'mailcity',//added
'manama',
'mansoura',
'marillion',
'marrakesh',
'mascara',
'mchsi',
'megarave',
'meknes',
'mesra',
'mindless',
'minister',
'mofa',
'moscowmail',
'motley',
'munich',
'muscat',
'muscat',
'music',
'musician',
'musician',
'musicsites',
'myself',
'nabeul',
'nabeul',
'nablus',
'nador',
'najaf',
'narod',
'netbroadcaster',
'netfingers',
'net-surf',
'nettaxi',
'newmail',
'ni cedriveway',
'nightmail',
'nm',
'nocharge',
'nycmail',
'omani',
'omdurman',
'operationivy',
'optician',
'optonline',
'oran',
'oued',
'oued',
'oujda',
'oujda',
'paidoffers',
'pakistani',
'palmyra',
'palmyra',
'pcbee',
'pediatrician',
'persian',
'petrofind',
'phunkybitches',
'pikaguam',
'pinkcity',
'pisem',
'pitbullmail',
'planetsmeg',
'playful',
'pochta',
'pochtamt',
'poetic',
'pookmail',
'poop',
'poormail',
'pop3',
'popstar',
'portsaid',
'post',
'potsmokersnet',
'presidency',
'priest',
'primetap',
'programmer',
'project420',
'prolife',
'publicist',
'puertoricowow',
'puppetweb',
'qassem',
'quds',
'rabat',
'rafah',
'ramallah',
'rambler',
'rapstar',
'rapworld',
'rastamall',
'ratedx',
'ravermail',
'rbcmail',
'realtyagent',
'registerednurses',
'relapsecult',
'remixer',
'repairman',
'representative',
'rescueteam',
'rockeros',
'romance106fm',
'rome',
'sa veourplanet',
'safat',
'safat',
'safat',
'safat',
'saintly',
'salalah',
'salmiya',
'samerica',
'sanaa',
'sanfranmail',
'scientist',
'seductive',
'seeb',
'sexriga',
'sfax',
'sharm',
'sinai',
'singalongcenter',
'singapore',
'siria',
'sketchyfriends',
'slayerized',
'smartstocks',
'smtp',
'sociologist',
'sok',
'soon',
'soulja-beatz',
'sousse',
'spam',
'specialoperations',
'speedymail',
'spells',
'streetracing',
'subspacemail',
'sudanese',
'suez',
'sugarray',
'superbikeclub',
'superintendents',
'supermail',
'surfguiden',
'sweetwishes',
'tabouk',
'tajikistan',
'tangiers',
'tanta',
'tattoodesign',
'tayef',
'teamster',
'techie',
'technologist',
'teenchatnow',
'tetouan',
'the5thquarter',
'theblackmarket',
'timor',
'tivejo',
'tokyo',
'tombstone',
'troamail',
'tunisian',
'tunisian',
'tut',
'tx',
'u2tours',
'ua',
'uaix',
'umpire',
'urdun',
'usa',
'vipmail',
'vitalogy',
'whatisthis',
'whoever',
'winning',
'witty',
'wrestlezone',
'writeme',
'writeme',
'yahoo',
'yanbo',
'yandex',
'yemeni',
'yemeni',
'yogaelements',
'yours',
'yunus',
'zabor',
'zagazig',
'zambia',
'zarqa',
'zerogravityclub'
];

export isp_domains := [
'earthlink',
'mindspring',
'msn',
'comcast',
'aol',
'att',
'netzero',
'verizon',
'juno',
'netscape',
'peoplepc',
'charter',
'cox',
'cox-internet',
'adelphia',
'cox',
'prodigy',
'bellatlantic',
'insightbb',
'qwest',
'ameritech',
'roadrunner',
'compuserve',
'cs', //compuserve
'swbell',
'shaw',
'worldnet',
'gte',//takes you to a verizon isp page
'wmconnect',//netscape & aol references
'btinternet',//UK isp
'ntlworld',//virgin media isp
'centurytel',
'covad',
'bellsouth',
'sbcglobal',
'webtv',
'pacbell',
'erols',
'cableone',
'concentric'
];

export corporate_domains := [
'dell',
'ibm',
'ameritrade',
'statefarm',
'allstate',
'compaq',
'wachovia',
'hp',
'wellsfargo',
'mcleodusa',
'budweiser',
'boeing',
'coldwellbanker',
'nationwide',
'fedex',
'remax',
'bankofamerica'
];
end;
