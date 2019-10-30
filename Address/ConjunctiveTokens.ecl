﻿export SET OF STRING ConjunctiveTokens := 
[
// conjunctives
// e.g. 'BAIT & TACKLE' and 'LOCK AND KEY'
'I & II',
'KITCHEN & BATH',
'KITCHENS & BATHS',
'KITCHENS & BATH',
'KITCHENS & COUNTER',
'KITCHEN & COUNTER',
'KITCHENS & COUNTERS',
'KITCHEN & COUNTERS',
'BATH & KITCHEN',
'BATHS & KITCHENS',
'BATH & BODY',
'KITCHEN & BAR',
'CUP & SAUCER',
'WASHER & DRYER',
'WASHERS & DRYERS',
'HIGH & DRY',
'PICTURE & SOUND',
'SIGHT & SOUND',
'LIGHT & SOUND',
'HEALTH & WELFARE',
'HEARTH & KETTLE',
'SPAY & NEUTER',
'GRAIN & SEED',
'HOSE & FITTING',
'DRYER & SEED',
'ROOTS & FRUITS',
'FAITH & REASON',
'ARMY & NAVY',
'SOLDIERS & SAILORS',
'AIR & NAVAL',
'HEAVEN & HELL',
'INFANT & TODDLER',
'INFANTS & TODDLERS',
'WILL & TRUST',
'TITLE & TRUST',
'LOAN & TRUST',
'BANK & TRUST',
'BK & TRUST',
'BANK & TRU',
'BANK & TR',
'BK & TR',
'BORN & RAISED',
'TOY & HOBBY',
'LIFE & CASUALTY',
'EYE & EAR',
'HEADS & TAILS',
'FLOUR & GRAIN',
'BOOT & SADDLERY',
'RAIN & SHINE',
'FLAG & BANNER',
'FLAG & BANNERS',
'FLAGS & BANNERS',
'SIGNS & BANNERS',
'LETTERS & SIGNS',
'FLOTSAM & JETSAM',                                                        
'BRIDGE & CROWN',                                                        
'STONE & STATUARY',                                                        
'RIP & TEAR',                                                        
'BOXERS & BRIEFS',
'SHIRTS & SKIRTS',
'CASH & CARRY',
'SHIP & SHORE',
'CHURCH & SCHOOL',
'FINGER & FACES',
'DEALS & STEALS',
'CHECK & LOAN',
'GUN & PAWN',
'GUN & RIFLE',
'ROD & GUN',
'ROD & REEL',
'MOM & POP',
'HOPE & CHARITY',
'JEWELRY & PAWN',
'PAWN & LOAN',
'PAWN & GOLD',
'DIAMOND & GOLD',
'SAV & LOAN',
'SAVING & LOAN',
'SAVINGS & LOAN',
'SAV & LN',
'SVGS & LN',
'SV & LN',
'FS & LA',
'S & LA',
'THRIFT & LOAN',
'TR & SAV',
'TR & SV',
'NORTHERN & SOUTHERN',
'WESTERN & SOUTHERN',
'SEX & LOVE',
'JR & SR',                                                                                       
'RUN & SHOOT',
'ROOM & BOARD',
'GROOM & BOARD',
'BOARD & CARE',
'POWER & SOUND',
'WINE & CHEESE',
'HAND & FOOT',
'HANDPRINTS & FOOTSTEPS',                                                                                                                            
'FACE & BODY',
'BEER & SODA',
'BEER & ICE',
'WELL & PUMP',
'WELLS & PUMPS',
'PUMP & CORROSION',
'SOCKS & UNDERWEAR',
'TRACK & FIELD',
'MARBLE & GRANITE',
'CUT & SHOOT',
'DANCE & PILATES',
'BUFFET & GRILL',
'CURE & CARE',
'TAPAS & WINE',
'RIBS & ALE',
'FLOWERS & ROSES',
'GREENHOUSE & FLOWER',
'BLIND & SHUTTER',
'BLINDS & SHUTTERS',
'SHADES & BLINDS',
'TREE & TIMBER',
'TREE & LAWN',
'TREE & DEBRIS',
'TREE & GARDEN',
'TREES & PLANTS',
'TREES & LAND',
'CATTLE & TIMBER',
'KITCHEN & TAP',
'STUFF & SUCH',
'WOOD & GLASS',
'WOOD & FORGE',
'WOOD & STONE',
'PIANO & VOICE',
'SCREEN & GUTTER',
'DRILLING & PILE',
'DRILLING & TAPPING',
'GEARS & SHAFTS',
'IRONWORK & WELDING',
'PATCH & SEALCOAT',
'CAMERA & WATCH',
'EMBLEMS & CAPS',
'STORAGE & LOCKERS',
'FENCES & DECKS',
'COIN & SLOT',
'COINS & SLOT',
'COIN & SLOTS',
'COINS & SLOTS',
'BOAT & TACKLE',
'TRUCKING & RIGGING',
'CAR & TRUCK',
'CAR & TRK',
'PAWN & LOAN',
'ORAL & MAX',
'WIND & SOLAR',
'WASH & DRY',
'MACHINE & TOOL',
'TOOL & TACKLE',
'TOOL & LOCK',
'ART & PICTURE',
'WOODS & WATER',
'SOIL & WATER',
'LAND & WATER',
'LAND & SEA',
'LAND & TIMBER',
'LAND & DEV',
'LAND & FARM',
'LAND & GRAZING',
'GROVES & LANDS',
'DEV & CONS',
'DEV & CONSTRUC',
'DEV & BUILDI',
'MINING & DEV',
'TREE & SHRUB',
'GAS & DIESEL',
'BUY & SELL',
'HEART & SOUL',
'HAVE & SNACK',
'CHIPS & SALSA',
'CANDY & TOBACCO',
'CANDY & NUTS',
'CANDY & NUT',
'HIT & RUN',
'CAKES & PIES',
'GOLD & GUN',
'GOLD & GEMS',
'NEWS & TOBACCO',
'ART & SOUL',
'ART & CULTURE',
'ARTS & CULTURE',
'ART & SCIENCE',
'ARTS & SCIENCE',
'AIR & GAS',
'AIR & FURNACE',
'HAIR & BEAUTY',
'HAIR & BODY',
'HAIR & SPA',
'HAIR & NAIL',
'HAIR & NAILS',
'NAILS & TAN',
'NAIL & TAN',
'NAIL & TOE',
'NAIL & WAX',
'WASH & WAX',
'TIPS & TOES',
'HAIR & TAN',
'CUT & CURL',
'CUT & TRIM',
'CUT & TAN',
'OIL & GAS',
'BLACK & GOLD',
'BLACK & BLUE',
'BLACK & RED',
'BLACK & TAN',
'BLACK & WHITE',
'BLACK & YELLOW',
'BLACK & BROWN',
'BLACK & GREEN',
'BLACK & ORANGE',
'BLACK & RED',
'BLUE & GOLD',

'BLUE & GREEN',
'BLUE & ORANGE',
'BLUE & RED',
'BLUE & TAN',
'BLUE & WHITE',
'BLUE & YELLOW',

'BROWN & GREEN',
'BROWN & RED',
'BROWN & WHITE',

'GREEN & GOLD',
'GREEN & RED',
'GREEN & WHITE',
'GREEN & YELLOW',
'RED & PURPLE',
'RED & TAN',
'RED & WHITE',
'PURPLE & GOLD',
'HAMMER & NAIL',
'LEADS & LISTS',
'DELI & ESPRESSO',
'PIZZA & DELI',
'MEATS & DELI',
'PIZZA & WINGS',
'PIZZA & SUBS',
'PIZZA & HOAGIE',
'PIZZA & HOAGIES',
'CHICKEN & RIBS',
'SAUNA & STEAM',
'PIANOS & ORGANS',
'PIANO & ORGAN',
'PACKING & CRATING',
'EAT & RUN',
'VOICE & FAX',
'BIG & LITTLE',
'COFFEE & ESPRESSO',
'COFFEE & TEA',
'COFFEES & TEAS',
'COFFEE & CANDY',
'COFFEE & DELI',
'CINNAMON & SPICE',
'DOCK & DREDGE',
'PIER & LANDING',
'HAM & BACON',
'CAN & BOTTLE',
'BAR & GRIL',
'BAR & GRILL',
'BAR & GRILLE',
'BAR & LOUNGE',
'BAR & TAVERN',
'BAR & TAVERNS',
'BEER & WINE',                                                                                       
'WINE & SPIRIT',                                                                                       
'WINE & SPIRITS',                                                                                       
'WINES & SPIRITS',                                                                                       
'WINE & WHISKEY',                                                                                       
'LOG & LUMBER',
'PG & HG',
'PLAY & LEARN',
'PARTS & SERVICE',
'LIONS & TIGERS',
'LOST & FOUND',
'FLORAL & GIFT',                                                                                       
'FLORAL & WREATH',                                                                                       
'FLORAL & DECOR',                                                                                       
'GOLF & CC',                                                                                       
'GOLF & TENNIS',                                                                                       
'GOLF & PUTT',                                                                                       
'POOL & TENNIS',                                                                                       
'BATH & TENNIS',                                                                                       
'BEACH & TENNIS',                                                                                       
'SWIMMING & TENNIS',                                                                                       
'SWIMMING & DIVING',                                                                                       
'SWIM & TENNIS',                                                                                       
'SWIM & RACQUET',                                                                                       
'FUN & GAMES',
'BALL & CUE',                                                                                       
'GUN & AMMO',                                                                                       
'GUNS & AMMO',                                                                                       
'PISTOL & RIFLE',                                                                                       
'STEAK & ALE',                                                                                       
'CHECK & GO',
'SHARE & CARE',                                                                                       
'FISH & CHICKEN',                                                                                       
'NOSE & THROAT',                                                                                       
'TREE & STUMP',                                                                                       
'TEA & COFFEE',                                                                                       
'FUEL & FEED',
'FEED & GRAIN',
'FEED & GRAINS',
'FEEDS & GRAINS',
'FEED & SEED',
'FEED & HARDWARE',
'FARM & FEED',
'FARM & FLEET',
'FISH & CHIPS',
'FISH & CHIP',
'FISH & MARINE',
'REEF & MARINE',
'FIRE & MARINE',
'FIRE & SAFE',
'FIRE & SAFETY',
'CANVAS & MARINE',
'HARDWARE & MARINE',
'LUMBER & HARDWARE',
'LUMBER & TRUSS',
'CARE & REHAB',
'NURSE & REHAB',
'PAIN & REHAB',
'SALT & PEPPER',
'SALT & SEA',
'SALT & LIGHT',
'VAN & STORAGE',
'STOVE & FIRE',
'FLEET & MARINE',
'HAM & DELI',
'STEAK & GRILL',
'FOREST & FARM',
'FOREST & FARMS',
'FOREST & STONE',
'FOREST & GARDEN',
'FOREST & FIELD',
'FOREST & LAWN',
'FOREST & TREE',
'FOREST & PAPER',
'FOREST & FLOWERS',
'FOREST & PARKS',
'FORESTS & PARKS',
'FARM & GARDEN',
'FARM & GARDENS',
'LAWN & GARDEN',
'LAWN & YARD',
'GARDEN & FLOWERS',
'FRUIT & PRODUCE',
'FRUIT & PRODU',
'FRUIT & VEGETABLES',
'FRUIT & NUTS',
'FRUITS & NUTS',
'TIRE & SERVICE',
'LAW & ORDER',
'STICKS & STONES',
'SAFE & VAULT',
'LOCK & SAFE',
'LOCK & KEY',
'LOCK & KEYS',
'LOCK & DOOR',
'LOCKS & GATES',
'KEY & LOCK',
'KEY & DOOR',
'SAFE & LOCK',
'LOCK & GUN',
'STORE & LOCK',
'STOR & LOK',
'TACK & FEED',
'SALT & FEED',
'GRAVEL & DIRT',
'SAND & GRAVEL',
'SAND & STONE',
'SUN & SAND',
'SUN & SNOW',
'FARMERS & MERCHANTS',                                                                                       
'CABLE & WIRING',
'CABLE & PREWIRE',
'CABLE & WIRE',
'CABLE & WIRELESS',
'POOL & SPA',
'POOLS & SPA',
'POOL & GARDEN',
'HOME & GARDEN',                                                                                       
'HOME & GARDENS',                                                                                       
'HOME & LAND',                                                                                       
'HOME & OFFICE',                                                                                       
'HOME & SCHOOL',                                                                                       
'HOUSE & OFFICE',                                                                                       
'FLOWERS & PLANTS',
'FLOWER & PLANT',
'PUMP & TANK',
'MACHINE & PUMP',
'DRILL & PUMP',
'DRILLING & WELL',
'DRILLING & PRODUCING',
'TOOL & DIE',
'TOOL & NAIL',
'FOOT & KNEE',
'FOOT & ANKLE',
'SKIN & VEIN',
'TIRE & RUBBER',
'GLASS & GLAZING',
'GLASS & MIRROR',
'GLASS & MIRRORS',
'SCREEN & MIRROR',
'SCREEN & MIRRORS',
'SCREEN & GLASS',
'DECKING & PORCHES',
'REST & RECREATION',
'LAMP & SHADE',
//'R & R',
'BURGERS & SHAKES',
'BURGER & SHAKE',
'MAN & WOMAN',
'MEN & WOMAN',
'MEN & WOMEN',
'MEN & WOMEN',
'MAN & BOYS',
'MEN & BOYS',
'ARTS & CRAFTS',
'ART & CRAFTS',
'ART & CRAFT',
'ARTS & CRAFT',
'ART & FRAME',
'ART & FRAMES',
'ART & QULITING',
'ART & PLANT',
'FRAME & GALLERY',
'CRAFTS & DECOR',
'TAG & TITLE',
'TAG & LABEL',
'LUBE & WASH',
'PARK & WASH',
'DELI & MARKET',
'REST & DELI',
'BEVERAGE & DELI',
'BAIT & TACKLE',
'TACKLE & MARINE',
'HEAD & NECK',
'BACK & NECK',
'BACKS & NECK',
'STOP & SCRATCH',
'BED & BATH',                                                                                       
'BEDDING & BATH',                                                                                       
//'B & B',                                                                                       
'BED & BREAKFAST',                                                                                       
'BED & BRE',
'BED & BISCUIT',                                                                                       
'TOWEL & LINEN',
'FARM & TURF',
'CRANE & RIGGING',
'MOWER & SAW',
'MACHINE & TOOLS',
'SNOW & MOW',
'SPRING & STAMP',
'SPRING & STAMPING',
'SPRING & WHEEL',
'SPRING & AXLE',
'SPRING & BRAKE',
'SPRING & BUMPER',
'BRAKE & WHEEL',
'BRAKE & CLUTCH',
'GREASE & GO',
'LUBE & TUNE',
'OIL & LUBE',
'PUMP & LUBE',
'TIRE & AUTOMTY',
'TIRE & AUTOMOTIVE',
'TIRE & LUBE',
'TIRE & OIL',
'TIRE & BRAKE',
'TIRE & BRAKES',
'TIRE & BRAK',
'TIRE & WHEEL',
'TIRE & WHEELS',
'WHEEL & AXEL',
'MUFFLER & BRAKE',
'MUFFLER & BRAKES',
'CAR & LIMO',
'CAR & LIMOS',
'LIMO & COACH',
'TOWN & CAR',
'TRAILER & BODY',
'TRAILER & CAMPER',
'PARK & TRAILS',
'SPRING & WIRE',
'SOD & TURF',                                                                                       
'FIELD & STREAM',                                                                                       
'FISH & STREAM',                                                                                       
'RICE & BEANS',
'RAGS & RAGS',
'SONG & WIND',
'SALES & RENTAL',
'SALES & PARTS',
'SALES & SERVICE',
'SALES & SERVI',
'SALES & SV',
'SALES & LEASE',
'SALES & USE',
'SYSTEMS & SERVICE',
'HOUSE & WINDOWS',
'HOUSE & WIND',
'WINDOWS & DOORS',
'DOOR & GATE',
'DOOR & GLASS',
'LOG & ANTLER',
'COUNTERS & CASE',
'GUYS & GALS',
'PARK & RIDE',
'PARK & MOTEL',
'PARK & EAT',
'PARK & GRILL',
'PARK & CAMP',
'BAR & BREW',
'MUSIC & ART',
'FIFE & DRUM',
'DRUM & BUGLE',
'PIPE & DRUM',
'PIPES & DRUMS',
'PIPE & TUBE',
'MAIL & MORE',
'BOUNCE & PLAY',
'WING & PRAYER',
'GUY & GIRL',
'GUY & DAUGHTER',
'FATHER & SON',
'FATHER & SONS',
'FATHER & DAUGHTER',
'FATHER & DAUGHTERS',
'PERE & FILS',
'BROTHER & SISTER',
'BROTHERS & SISTERS',
'CUT & STYLE',
'DECKS & FENCE',
'FENCE & DECK',
'STAIRS & RAILS',
'NEWS & VIEWS',
'SEALCOAT & STRIPING',
'SEAL & PACKING',
'HEAT & AC',
'HEATING & AC',
'HEATING & COOLING',
'HEATING & COOLIN',
'HEATING & COO',
'HEAT & COOL',
'HEAT & AIR',
'HEATING & AIR',
'PIPING & HEATING',
'HTG & COOLING',
'HEAT & COOLING',
'PLUMBING & HEATING',
'POWER & LIGHT',
'LIFE & LIGHT',
'GAS & LIGHT',
'GAS & ELECTRIC',
'GAS & ELEC',
'CARPET & FLOORING',
'CARPET & FLOORINGS',
'CARPET & WOOD',
'TILE & FLOOR',
'TILE & CARPET',
'TILE & MARBLE',
'TILE & STONE',
'STONE & TILE',
'BRICK & TILE',
'TUB & TILE',
'CUTTING & CORING',
'CUTTING & STAMPING',
'GRANITE & MARBLE',
'GRANIT & MARBLE',
'MARBLE & STONE',
'BRICK & STONE',
'BRICK & BLOCK',
'IRON & STEEL',
'ROCK & DIRT',
'ROCK & GRAVEL',
'ROCK & SAND',
'ROCK & ROLL',
'DUCT & PIPE',
'NUT & BOLT',
'NUTS & BOLTS',
'BOLT & SCREW',
'TOWN & COUNTRY',
'COUNTRY & WESTERN',
'CITY & COUNTY',
'CITIES & TOWNS',
'CITIES & SCHOOLS',
'PARKS & LAND',
'AGED & INFIRM',
'GRADING & CLEARING',
'WRECKING & SALVAGE',
'DIVE & DOCK',
'DIVE & SALVAGE',
'WATER & SEWER',
'SEWER & WATER',
'WATER & FIRE',
'FIRE & ICE',
'FIRE & SPICE',
'SEWER & DRAIN',
'ROAD & BRIDGE',
'CUT & HAUL',
'DRAINS & PIPING',
'SEAL & STRIPING',
'SEALING & STRIPING',
'STRIPING & SEALING',
'COIN & STAMP',
'STAMPS & COINS',
'HOTEL & CASINO',
'HOT & COLD',
'CRUSHING & SALVAGE',
'TOPS & CANVAS',
'SWEET & INNOCENT',
'KING & QUEEN',
'KINGS & QUEENS',
'WEIGHTS & MEASURES',
'PROBATION & PAROLE',
'SALES & USE',
'BIG & TALL',
'FARM & RANCH',
'LOAVES & FISHES',
'FLOWER & GIFT',
'FLOWERS & GIFTS',
'FLOWERS & GIFT',
'FLOWERS & CRAFTS',
'CARD & GIFT',
'HEARTH & HOME',
'FARM & HOME',
'GIFT & LUGGAGE',
'WATCH & CLOCK',
'CAR & DRIVER',
'STOCK & BARREL',
'STOP & GO',
'STOP & SHOP',
'SAVE & SHOP',
'SHOP & GO',
'SHOP & BAG',
'BODY & GLASS',
'FRAME & AXLE',
'LATH & PLASTER',
'MUSIC & MEDIA',
'MUSIC & DANCE',
'ROD & TACKLE',
'BLOCK & TACKLE',
'BLOCK & TILE',
'WATER & ICE',
'LIGHT & WATER',
'SEW & VAC',
'CUT & DROPS',
'NAILS & SPA',
'NAIL & SPA',
'NAIL & SALON',
'SALON & SPA',
'SALON & SP',
'TAN & SPA',
'SUN & SPA',
'TAN & STYLE',
'FLORA & FAUNA',
'BEEF & ALE',
'STEAK & ALE',
'PACK & SHIP',
'PAK & SHIP',
'SAC & PAC',
'FASHION & ART',
'PET & GARDEN',
'LEATHER & LUGGAGE',
'HEART & HAND',
'RISE & SHINE',
'DAY & NIGHT',
'DAY & NITE',
'BEAD & CRYSTAL',
'CHINA & CRYSTAL',
'MARINA & BOAT',
'MARINA & LODGE',
'SMOG & DIESEL',
'AT & T',                                                                                       
'CRABTREE & EVELYN',                                                                                       
'COWBOYS & ANGELS',                                                                                       
'BOYS & GIRLS',                                                                                       
'THAI & CHINESE',
'GRACE & MERCY',
'LINCOLN & MERCURY',
'SPORTS & MARINA',
'TRIM & TONE',
'VAN & CAMPER',
'LIMO & SEDAN',
'LIMO & SEDANS',
'GOLD & SILVER',
'SILVER & STONE',
'FINGERS & TOES',
'MOM & DAD',
'MA & PA',
'MA & PAS',
'ME & MY',
'HIS & HER',
'HIS & HERS',
'NANA & PAPA',
'SAVE & LOT',
'DOG & CAT',
'CATS & DOGS',
'WASH & FOLD',
'SURF & TURF',
'BRIC & BRAC',
'IN & OUT',
'NOW & THEN',
'NOW & LATER',
'FUN & SUN',
'TAN & TONE',
'SALE & LEASE',
'CAKE & CANDY',
'FEATHERS & FINS',
'HIDE & FUR',
'FIN & FUR',
'FINS & FUR',
'YOU & ME',
'LOVE & FAITH',
'GRILL & BUFFET',
'GRILL & DELI',
'GROC & DELI',
'BAGEL & DELI',
'PARK & SELL',
'PARKS & REC',
'PARKS & RECREATION',
'PARK & REC',
'PARK & RECREATION',
'SPORTS & REC',
'SPORTS & RECREATION',
'LOVE & CARE',
'WEIGHT & SEE',
'ARCADE & BILLIARD',
'ARCADE & BILLIARDS',
'SPRING & BODY',
'FIVE & TEN',
'FIVE & DIME',
'ROOF & TREE',
'GAY & LESBIAN',
'PRINCE & PRINCESS',
'FAITH & PRAYER',
'MOUNTAIN & VALLEY',
'MOUNTAIN & SEA',
'MOUNTAIN & MARINE',
'PIPE & TOBACCO',
'PIZZA & PASTA',
'STEEL & FORM',
'SPORTS & COURTS',
'GRAIN & CATTLE',
'CATTLE & HOG',
'CHICKEN & TROUT',
'CANDY & CORN',
'PAVE & SEAL',
'PEEK & BOO',
'FEED & LIVESTOCK',
'FISH & GAME',
'FITTING & VALVE',
'SLATE & STONE',
'DIVERS & SALVAGE',
'SPORT & DIVE',
'SKI & SPORT',
'SPEED & SPORT',
'ALPHA & OMEGA',
'DOCKS & DECKS',
'BOAT & BAIT',
'RAMPS & RAILS',
'SOUND & LIGHTING',
'COAL & COKE',
'COAL & OIL',
'TRADE & BARTER',
'PLAY & TRADE',
'PAWN & TRADE',
'SELL & TRADE',
'TAX & TRADE',
'GAS & GO',
'PIC & GO',
'PHYS & SUR',
'PHYS & SURG',
'GAS & MART',
// SAVE
'BUY & SAVE',
'STOP & SAVE',
'SELL & SAVE',
'GAS & SAVE',
'PICK & SAVE',
'PACK & SAVE',
'PAC & SAVE',
'TALK & SAVE',
'BAG & SAVE',
'DINE & SAVE',
'LOCK & SAVE',
'PUMP & SAVE',
'CLIP & SAVE',
'CUT & SAVE',
'CHECK & SAVE',
'CLICK & SAVE',
'RENT & SAVE',
'MOVE & SAVE',
'MOV & STOR',
'FURNACE & DUCT',
'CASH & SAVE',
'SEE & SAVE',
'HOP & SAVE',
'PULL & SAVE',
'DINE & DANCE',
'DINING & DANCING',
'PUDDING & PIE',
'PUDDING & PIES',
'BADGES & TAGS',
'COINS & BULLION',
'STARS & BARS',
'STARS & STRIPES',
'RIG & CRATE',
'LAND & CATTLE',
'PINCH & PENNY',
'BRAIN & SPINE',
'PAIN & SPINE',
'FAIR & RODEO',
'HAY & FEED',
'PET & FEED',
'WEED & SEED',
'COAL & WOOD',
'COAL & COKE',
'GRANITE & STONE',
'TUG & BARGE',
'WOOD & TREE',
'TENT & TARP',
'DENTAL & DENTURES',
'BURGER & TACO',
'BURGERS & TACOS',
'PIZZA & TACO',
'BURRITO & TACO',
'BURRITOS & TACO',
'DELI & TACO',
'FISH & TACO',
'BAIT & TACO',
'WINES & TACO',
'TAMALE & TACO',
'ALPHA & OMEGA',
'PEACE & JUSTICE',
'MATH & SCIENCE',
'HOPE & LOVE',
'TRUTH & LIFE',
'TRUTH & DARE',
'MAYOR & COUNCIL',
'TELEPHONE & TELEGRAPH',
'TEL & TEL',
'FAST & EASY',
'STATE & LOCAL',
'PULP & PAPER',
'THIS & THAT',
'COAL & MINING',
'OREGON & PACIFIC',
'KAUFMAN & BROAD',
'DELOITTE & TOUCHE',
'HARDING & CARBONE',
'ORANGE & ROCKLAND',
'ATLANTIC & PACIFIC',
'STANDARD & POOR',
'PROCTOR & GAMBLE'
];                                                   
