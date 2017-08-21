
import address, lib_stringlib;

 

mac_clean_mod(pDataset,pNameField,outfile) := macro

 

#uniquename(zlayout_for_transform)

#uniquename(ztnew)

#uniquename(zFile_after_is_company)

#uniquename(is_company)

//#uniquename(company_name)

#uniquename(File_isCompany_isConj)

#uniquename(Layout_in_conj)

#uniquename(is_conjunctive)

#uniquename(ztnew1)

#uniquename(File_nonblank_names)

#uniquename(d_File_nonblank)

#uniquename(File_nonblank_dedup)

#uniquename(zFor_Name_Cleaning)

#uniquename(Layout_for_clean_names)

#uniquename(zclean_name_1)

#uniquename(ztnew2)

#uniquename(clean_individuals)

#uniquename(more_clean_individuals)

#uniquename(zLayout_new_for_more_clean)

#uniquename(ztnew3)

#uniquename(suffix)

#uniquename(suffix_replace)

#uniquename(clean_name_suffix)

#uniquename(znew_file)

#uniquename(file_for_fml)

#uniquename(zLayout_new_for_more_clean_fml)

#uniquename(zfmlclean_name_2)

#uniquename(zfmlfile)

#uniquename(ztfml)

#uniquename(clean_split_name2)

 

%zlayout_for_transform% := record

boolean %is_company%;

string100 clean_company_name;

recordof(pDataset);

end;

 

%zlayout_for_transform% %ztnew%(pDataset l) := Transform

self.%is_company% := regexfind('( & SON| & SONS|, N A| INC |,INC |,INC$| INC\\.|'+

  'INC$|1ST BANK|2ND BANK|ACADEMY | ACADEMY$|'+

  'ACCOUNTING|ACCOUNTS|ADMINISTRATION|AFFORDABLE|AIR CONDITIONING|'+

  'AIRLINES|ALIGNMENT|AMBULANCE|AMERICAN|AMUSEMENT| AND KNEE| AND SONS|'+

  ' ANIMAL |ANTIQUE|APARTMENT|APLC|APPLIANCE|ARCHETECT|ARCHITECT|AS AGENT|'+

  'ASSOC |ASSOCIATES|ASSOCIATION| ATTORNEYS|AUTOMOTIVE|AUTORAMA|'+

  'AVIATION|BALL BEARINGS|BANK OF|BANK ONE|BANK N\\.A\\.|BANK NA| BEEP OF |'+

  'BLUE CROSS|BLUE SHIELD|BOOKBINDER|BOOKKEEPING|BOTTLING|BOUTIQUE|'+

  'BROKERAGE| BROKERS|BUILDING|BUREAU |BUREAU$|BUSINESS| BUTANE |BUYERS |'+

  'CABLEVISION|CARBURETOR|CASUALTY| CENTER |^CENTER | CENTER$|'+

  ' CHAPTER |^CHAPTER | CHAPTER$|CHARITIES|CHASE BANK|CHASE MANHATTAN BANK|'+

  'CHEMICAL| CHIRO |CHIROPRACTIC|CHURCH OF | CHURCH$|CITIBANK|CITIGROUP|'+

  'CITIZENS BANK| CITY |^CITY |CLEANING| CLINIC| CLUB |CMNTY| CO | CO-OP |'+

  'COLLECT|COMMERCE|COMMUNICATION|COMMUNITY|COMPANY|COMPUTER| CONCRETE |'+

  'CONSTRUCTION|CONSULTANTS|CONSUMER |CONTRACTING| CONTROL | COOP |'+

  'COOPERATIVE| CORP | CORPORATE|CORPORATION| COUNCIL |COUNTRY CLUB|'+

  ' COUNTY |COUNTY OF |^CREDIT | CREDIT |CRESTAR BANK| D\\/B\\/A |DAY CARE| DBA |'+

  ' DELI |DEPARTMENT| DEPARTMT | DEPT |DETROIT| DEVELOPERS |'+

  'DEVELOPMENT| DIST |DISTRIBUTI|DISTRICT|DIVISION|DVLPMNTL|EASTERN|'+

  'ELECTRICAL|ELEVATOR|ENGINEERING|ENTERPRISE|EQUIPMENT|EQUITY|ESTATES|'+

  ' ESQS |EXCAVATING|EXPRESS| F S B| FSB|FABRICATORS| FARM |'+

  'FIDELITY BANK|FINANCE |FINANCIAL | FIRE |^FIRE | FIRE$| FIRM |'+

  ' FIRM$|^FIRST |FIRST BANK|FLEET BANK| FLYING | FLYING$|^FNB |'+

  ' FNB$|,FNB$|FOUNDATION|FREIGHT|FULFILLMENT|FULLFILLMENT|FUNERAL HOME|'+

  'FURNITURE| GAZETTE | GAZETTE$|GOVERNMENT| GROCERY | GROUP |^GROUP |'+

  ' GROUP$| GROWERS |GVRNMNT| GYM | GYM$| HEALTH | HEALTH$|HEALTHCARE|'+

  'HOME LIFE| HOSP | HOSP\\.| HOTEL|HOSPICE|HOSPITAL| HUNTING | HUNTING$|'+

  'IMPROVEMENT|INDUSTRIAL|INDUSTRIES| INN | INN$|INNOVATIVE| INS |'+

  'INSTITUTE| INSURANCE |INTEREST|INTERIORS|INVESTMENT|JPMORGAN | L L C|'+

  ' L L P| LANDFILL |LABORATORIES|^LANDFILL |'+

  ' LANDFILL$|LANDSCAPING|LAUNDROMAT|LAW FIRM|LAW OFFICES| LAWYERS | LEAGUE |'+

  'LEARNING| LEASE | LEASING |LIBRARY|LIMITED|LIQUOR|LLC|LLP|LOGGING|'+

  ' LP | LP$| LTD|MACHINE|MANAGEMENT|MANUFACTUR| MARKET | MARKET$|MARLBOROUGH COUNTRY|'+

  'MATSUSHITA|MATUSHITA| MEDICAL |^MEDICAL |MELLON BANK|MERCHANTS |METHODIST|'+

  'MGMT|MGT| MILLING |MINISTRIES|MISSIONARY|MNGMNT|MOBILE HOME|MOBILE PARK|'+

  ' MOTEL | MOTEL$|MOUNTAIN| MUNCIPAL |MUSEUM| NATION |NATIONAL|NATIONSBANK|'+

  'NATIONS BANK| NAT\'L |^NAT\'L | NATL |^NATL | NATL. |^NATL\\. |NATURAL GAS|'+

  'NCNB|NETWORK|NEUROLOGICAL|NEUROLOGY|NORTHERN|OF AMERICA|OFFICE|OPTHAMOLOG|OPHTHAMOLOG|'+

  'OPTICAL|ORGANISATION|ORGANIZATION| ORTHO | ORTHOPEDIC | P S C|PACKAGING|'+

  ' PARTNERS|^PARTNERS |PARTNERSHIP| PC$|,PC$|PEDIATRICS|PEER REVIEW|PENSION PLAN|'+

  'PERFORMING ARTS|PETROLEUM|PHARMACEUTICAL|PHARMACY|PHOTOGRAPHIC|PLANNED|'+

  ' PLASTIC | PLAZA|PLUMBING|PNC | POLICE |PRENTICE HALL|PRODUCTIONS|PROFESSIONAL|'+

  'PROPERTIES|PROPERTY| PROVINCE |PROVINCE OF | PSC|PUBLICATIONS| QUARTER |'+

  ' RADIO|RAILROAD| RAILWAY|REAL ESTATE|REALTORS|REALTY|REBUILDERS|REMODELING|'+

  'RENTAL |REPAIR|REPUBLIC |RESIDENTIAL|RESOURCES|RESTARAUNT|RESTAURANT|'+

  ' RETAIL|RETIREMENT|REVOLUTIONARY| SALES | SALES$|SAVINGS| SCHOOL |SEAFOOD|'+

  '^SECOND|SECOND BANK|SECURITIES|SECURITY| SERVICE |SERVICES|SHIPPING|'+

  'SOCIETY|SOLUTION|SOUTHERN|SPECIALIST|SPECIALTY|SPRCNTR| STATE |STATE BANK|'+

  'STATE OF | STORAGE |SUPERCENTER|SUPPLY|SURGERY|SYSTEMS|TECHNOLOG|TELECOM|'+

  'TELEPHON| THE |TIRE & RUBBER| TOWN |^TOWN | TRACTOR |TRADE NAME| TRANSFER |'+

  'TRANSMISSION| TRANSPORT |TRANSPORTATION|TRAVEL |TRUCKING| TRUST |TRUSTEES |'+

  ' U S A |UNITED |UNITED STATES| UNIV |^UNIV |UNIVERSAL|UNIVERSITY|^U OF |'+

  ' USA |VOCATIONAL|WACHOVIA BANK|WAREHOUSE| WARRANTY |WELLS FARGO|WESTERN|'+

  'WILDLIFE|WIRELESS| WORLD |^WORLD | WORLD$|^[1-9]|'+

  ', N\\. A\\.|, N\\.A\\.|,INC\\.|,N\\. A\\.|,N\\.A\\.|ASSOC\\.|'+

  'CO\\.|CONST\\.|CORP\\.| DEPT\\.| ESQS\\. | INS\\. |L\\.L\\.C\\.|L\\.L\\.P\\.|'+

  ' L\\.P\\.|L\\.T\\.D\\.| NATL\\. | SER\\. |'+

  ' TOWING | ELECTRIC | SVCS$| LOGISTICS| CAR | PRODUCE| GARDENS|'+

  'METALS| CONCESSIONS| NURSERY| LEMONADE| HARVESTING| CAMP| TRUST|LVNG TR|'+

  'UDT | GRAVEL| LIGHT| TR U/A| HOLDINGS| PAVING| DESIGNS | B/UTD | AUTHORITY|'+

  'JOINT REVOC| RANCH|REVOC TR|LANDSCAPE|/INC |REVOCABLE|ALTERNATER|AS TENANTS|AUTOMART|'+

  ' UTA | UTD |LIVING | WINDOWS| SHOP$| EXCAVATION |CATTLE |RTA DTD|, TTE,|REV TST UDT|^DEPT OF |'+

  'TRUTEE| REVOKABLE |RV PARK| VENTURES | LODGE |AS CO-$|TREE & LAWN| CART|- U T A | CGA$| MAINTENANCE |'+

  'TRAILER PARK|MARINERS COVE|MOBIE HOME PARK|SOUTHTRUST BANK| MOVING | FRAME & TRIM| PAINTING| FORESTRY|'+

  'PRATT & WHITNEY|GRAM & COUSE FARMS|SHEET METAL|TRUSTESS|REFRIGERATION|BROWN & BROWN|CEILING & COMMERCIAL|SAVING & LOAN|'+

  'MINING & MATERIALS|FABRICATION & ERECTION|SEWER & WATER|RENOVATIONS|HEATING & AIR|HEATING & COOLING|DOCKSIDE|TELCOM|SHADE & NOVELTY|'+

  'ROOFING & SHEET|COMMISSION|CONT&HAULING|AUTO SHOP|GREENERY|CONTRACTORS|AUCTIONS| MASONRY|AUTO AIR|'+

  'TILE & MABLE| INSTALLATION|ROOFING & SIDING|GLASS & MIRROR|HOLIDAY ON ICE|& ASSOICATES|FOOD & ICE|PATCHING & SEALING| TRANSPORATION|'+

  'AUTO PARTS|B & B RIGGING|SALVAGE AND WRECKER|A/C & REFRIG|FRAME AND AXLE|SWEEPERS & STRIPERS|J & M HEATING|SALVAGE AND WRECKER|'+

  'WELDING & FABRICATION|COOLING & HEATING|TILE AND PLASTERING|FRAME & CARRIAGE|CLEAN & GREEN|B & B TIMBER|ALUM & STEEL|'+

  'BEACH AND ISLAND|RADIATOR & AUTO|R & R SUCCESS|SAWMILL & LUMBER|CLEARING & GRADING| ELECTRONICS|AUTO BODY & FRAME|TEE\'S & CUES|TIRE AND AUTO|MALONE & HYDE|'+

  'SIGNS & LIFT|LUMBER & HARDWARE|H & H LANDCLEARING|C & L WELL DRILLING|M & W WELDING|'+

  'J & N AUCTIONEERS|O & O MOBILE DENTAL|DRAPERIES & BEDSPREADS| SHOP| TOYOTA| CEMENT| JOINT TST|CARE & HAVRESTING|DOZER & FILL|P & R SMITH| TR DTD|SHAW & SHAW FARMS|MAX\'S PAINT & BODY|TERRAZZO & CEMENT|JOINT TST| TTESS | JOINT |'+

  ' REV. TRST |JOINT REV|SAND & SEA VILLAGE|J & W TREE FARMS|REV LIV TR|TR UTD|TR U/T/D|JT TST|ENGINEERS & CONSTRUCTORS|H & H FARMS|PARK & MARINA|CRANE & RIGGING|PRODUCTS|CRANE & RIGGING|A & P STUMPING|C & C FARMS|VIRGIL & BROTHERS|'+

  'PAINT & BODY|SPA & POOL|REV TST|EDUCATION & RESCUE|REV TST|R/J/T/|DRILLING & IRRIGATION|TIRE & EXHAUST|RECYCLE & SURPLUS| TTEE|BOAT & ENGINE|EXCV & LAND|SWEEP & STRIPE|H & L FARMS| CO-|PUMP & SEPTIC|'+

  'C & D RECOVERY|TRUCK & PART\'S|TSTEE UAD|A & E GROVES|RECYCLE & SURPLUS|BEACH TRST|SEPTIC & DRAINAGE|TRUST CREATED|MIRROR & GLASS|B & B AIR COND|'+

  'JRT UD|CONS & HAULING|IMP & EXP|C & S ROOFING|SAFE & LOCK|E & H STRIPING|WOOD & TRASH|B & E PALLETS|FLOWERS & GIFTS|'+

  'JNT LVG TST DTD|C & E HARVESTERS|K & R|RESEARCH & EDUCATION|PIPING & UTILITIES|M & K 711/INC.|J & J HAULING|M & N FARMS|SOD & TREES|'+

  'C & E HARVESTERS|BOATING & LODGING|FRUIT & JUNK|ASSEMBLIES OF| TTE|TTEES UAD| TTEE|AS JNT TNTS|TTEESS|'+

  'BEYER & BROWN|WRECKER & SALVAGE|MINING & COAL|PARTS & CARS|TRST DTD|C & B TREE PLANTING|'+

  'REV LV TR|POULTRY |D & J FARMS|R & R INTERPRISES|WATER & SEWER| CARPENTRY|DOZER & PIPELINE|'+

  'TRUCK & TRAILER|PUMP & WELL|AUTO BODY|WILLIS & WILLIS FARMS|CABLE TV|TRAINS & HOBBIES|SALT ROAD DAIRY| RECYCLING|'+

  'LIV TRST|BUNDY & SUTTON MOTORS|GRILLE & TAVERN|R & B REVELS FARMS|LIV TRST|REV LIV TST|M & M MARINE|SEPTIC TANK|'+

  'CO-TRUS|D & L DEMOLITION|M & L TIMBER|WOOD & MICA|FRUITS & VEGETABLES|AUTO & TRUCK|BEHE & UMHOLTZ|'+

  ' LANDCLEARING|REV TT| CO-TR|THRIFT STORE| FISHERIES|K & W FARMS|J & B SALVAGE|TRUCK & DETAILING|GOLF & TENNIS|'+

  'TRUCK PARTS| TELEVISION|STEREO )',StringLib.StringToUpperCase(l.pNameField));

self.clean_company_name := if(self.%is_company%,l.pNameField,'');                                                                                                

self := l;

end;

 

%zFile_after_is_company% := Project(pDataset,%ztnew%(left));

 

%Layout_in_conj% := record

boolean %is_conjunctive%;

boolean %is_company%;

string100 clean_company_name;

recordof(pDataset);

end;

 

%Layout_in_conj% %ztnew1%(%zFile_after_is_company% l) := Transform

self.%is_conjunctive% := regexfind('( & | OR | C\\/O | AND | DBA | % )',StringLib.StringToUpperCase(l.pNameField));

self := l;

end;

 

%File_isCompany_isConj% := Project(%zFile_after_is_company%,%ztnew1%(left));

 

%zFor_Name_Cleaning% := %File_isCompany_isConj%(not %is_conjunctive%,not %is_company%);

 

%Layout_for_clean_names% := record

string73 %zclean_name_1%;

recordof(pDataset);

end;

 

%Layout_for_clean_names%  %ztnew2%(%zFor_Name_Cleaning% l) := Transform

self.%zclean_name_1% := Address.CleanPersonfml73(l.pNameField);

self := l;

end;

 

%clean_individuals% := Project(%zFor_Name_Cleaning%,%ztnew2%(left));

#uniquename(clean_file_1)

%clean_file_1% := %clean_individuals%(%zclean_name_1%[71..73]>='085');

 

%more_clean_individuals% := %clean_individuals%(%zclean_name_1%[71..73]<'080');

 

%zLayout_new_for_more_clean% := record

string2 %suffix%;

string20 %suffix_replace%;

string73 %clean_name_suffix%;  

recordof(pDataset);

end;

 

 

%zLayout_new_for_more_clean% %ztnew3%(%more_clean_individuals% l) := Transform                                                    

//self.%suffix% := l.pNameField[length(trim(l.pNameField))-1..length(trim(l.pNameField))];
self.%suffix% := l.pNameField[52..53];
self.%suffix_replace% := map(trim(self.%suffix%)=' 1'=>'FIRST',

                                                                                     trim(self.%suffix%)=' 2'=>'SECOND',

                                                                                     trim(self.%suffix%)=' 3'=>'THIRD',

                                                                                     trim(self.%suffix%)=' 4'=>'FOURTH',

                                                                                     trim(self.%suffix%)=' 5'=>'FIFTH',

                                                                                     trim(self.%suffix%)=' 6'=>'SIXTH',

                                                                                     trim(self.%suffix%)=' I'=>'FIRST',

                                                                                     trim(self.%suffix%)=' J'=>'JR.',

                                                                                     trim(self.%suffix%)=' S'=>'SR.',

                                                                                     trim(self.%suffix%)=' E'=>'ESQ.','');

self.%clean_name_suffix% := Address.CleanPersonlfm73(l.pNameField[1..StringLib.StringFind(l.pNameField,' ',1)]+

                          ' ' + self.%suffix_replace% + ' ' 

                                                                                      + l.pNameField[StringLib.StringFind(l.pNameField,' ',1)+1..if(self.%suffix_replace%='',length(trim(l.pNameField)),length(trim(l.pNameField))-1)]);            

                                                                                                                                                

self := l;

end;

 

%znew_file% := Project(%more_clean_individuals%,%ztnew3%(left));

 

#uniquename(clean_file_2)

%clean_file_2% := %znew_file%(%clean_name_suffix%[71..73]>='080');

 

%file_for_fml% := %znew_file%(%clean_name_suffix%[71..73]<'080');

 

%zLayout_new_for_more_clean_fml% := record

string73 %zfmlclean_name_2%;

recordof(pDataset);

end;

 

%zLayout_new_for_more_clean_fml% %ztfml%(%file_for_fml% l) := Transform

self.%zfmlclean_name_2% := 

                                                                                                                                                                        Address.CleanPersonfml73(

                                                                                                                                                            l.pNameField[StringLib.StringFind(l.pNameField,' ',1)+1..

                                                                                                                                                            if(l.%suffix_replace%='',length(trim(l.pNameField)),length(trim(l.pNameField))-1)])

                                                                                                                                                            + ' ' +l.pNameField[1..StringLib.StringFind(l.pNameField,' ',1)]+

                          ' ' + l.%suffix_replace% 

                                                                                                                                      ;         

self := l;                                                                                                                                                            

end;

 

%zfmlfile% := Project(%file_for_fml%,%ztfml%(left));

#uniquename(clean_file_3)

%clean_file_3% := %zfmlfile%(%zfmlclean_name_2%[71..73]>='080');

 

#uniquename(make_company_names)

#uniquename(layout_for_making_company_names)

#uniquename(ztnewforcompany)

#uniquename(adding_company_names)

#uniquename(file_for_adding_company_name)

 

%layout_for_making_company_names% := record

boolean %is_company%;

string100 clean_company_name;

recordof(pDataset);

end;

 

%file_for_adding_company_name% := %zfmlfile%(%zfmlclean_name_2%[71..73]<'080');

 

%layout_for_making_company_names% %ztnewforcompany%(%file_for_adding_company_name% l) := Transform

self.%is_company% := 1;

self.clean_company_name := l.pNameField;

self := l;

end;

 

%adding_company_names% := Project(%file_for_adding_company_name%,%ztnewforcompany%(left));

//------------------------------------------------------------------------------

#uniquename(File_for_conj_new)

#uniquename(Layout_in_conj_new)

#uniquename(tnew_conj)

#uniquename(clean_split_name3)

#uniquename(File_out_z)

 

%File_for_conj_new% := %File_isCompany_isConj%(%is_conjunctive%,not %is_company%);

 

%Layout_in_conj_new% := record

boolean %is_conjunctive%;

boolean %is_company%;

string100 clean_company_name;

string73 %clean_split_name2%;

string73 %clean_split_name3%;

recordof(pDataset);

end;

 

%Layout_in_conj_new% %tnew_conj%(%File_for_conj_new% l) := Transform

self.%clean_split_name3% := map(         StringLib.StringFind(l.pNameField, ' & ',1) != 0 =>Address.CleanPerson73(l.pNameField[1..StringLib.StringFind(l.pNameField, ' & ',1)-1]),

                                                                                                                                                                                                            StringLib.StringFind(StringLib.StringToUpperCase(l.pNameField), ' AND ',1) != 0 =>Address.CleanPerson73(l.pNameField[1..StringLib.StringFind(StringLib.StringToUpperCase(l.pNameField), ' AND ',1)-1]),

                                                                                                                                                                                    StringLib.StringFind(StringLib.StringToUpperCase(l.pNameField), ' OR ',1) != 0 =>Address.CleanPerson73(l.pNameField[1..StringLib.StringFind(StringLib.StringToUpperCase(l.pNameField), ' OR ',1)-1]),

                                                                                                                                                                                    StringLib.StringFind(StringLib.StringToUpperCase(l.pNameField), ' C/O ',1) != 0 =>Address.CleanPerson73(l.pNameField[1..StringLib.StringFind(StringLib.StringToUpperCase(l.pNameField), ' C/O ',1)-1]),

                                                                                                                                                                                    StringLib.StringFind(StringLib.StringToUpperCase(l.pNameField), ' DBA ',1) != 0 =>Address.CleanPerson73(l.pNameField[1..StringLib.StringFind(StringLib.StringToUpperCase(l.pNameField), ' DBA ',1)-1]),

                                                                                                                                                                            StringLib.StringFind(StringLib.StringToUpperCase(l.pNameField), ' % ',1) != 0 =>Address.CleanPerson73(l.pNameField[1..StringLib.StringFind(StringLib.StringToUpperCase(l.pNameField), ' % ',1)-1]),                                                                                                 

                                                                                                                                                                                                            Address.CleanPerson73(l.pNameField));                                                                                                                                                                                                                     

self.%clean_split_name2% := map(         StringLib.StringFind(l.pNameField,' & ',1) != 0

                                                                                    =>Address.CleanPerson73(l.pNameField[StringLib.StringFind(l.pNameField,' & ',1)..53]),

                                                                                                            StringLib.StringFind(StringLib.StringToUpperCase(l.pNameField),' AND ',1) != 0 

                                                                                    =>Address.CleanPerson73(l.pNameField[StringLib.StringFind(StringLib.StringToUpperCase(l.pNameField),' AND ',1)+5..53]),

                                                                                                            StringLib.StringFind(StringLib.StringToUpperCase(l.pNameField),' OR ',1) != 0 

                                                                                    =>Address.CleanPerson73(l.pNameField[StringLib.StringFind(StringLib.StringToUpperCase(l.pNameField),' OR ',1)+4..53]),

                                                            StringLib.StringFind(StringLib.StringToUpperCase(l.pNameField),' C/O ',1) != 0 

                                                                                    =>Address.CleanPerson73(l.pNameField[StringLib.StringFind(StringLib.StringToUpperCase(l.pNameField),' C/O ',1)+5..53]),

                                                                                                            StringLib.StringFind(StringLib.StringToUpperCase(l.pNameField),' DBA ',1) != 0 

                                                                                    =>Address.CleanPerson73(l.pNameField[StringLib.StringFind(StringLib.StringToUpperCase(l.pNameField),' DBA ',1)+5..53]),

                                                                                                            StringLib.StringFind(StringLib.StringToUpperCase(l.pNameField),' % ',1) != 0 

                                                                                    =>Address.CleanPerson73(l.pNameField[StringLib.StringFind(StringLib.StringToUpperCase(l.pNameField),' % ',1)+3..53]),                                                                                                        

                                                                                                            Address.CleanPerson73(l.pNameField));                     

                                    

//self.find := StringLib.StringFind(l.pNameField,'&',1);                                 

                                                                                                                                                                                                            

//Address.CleanPersonlfm73(l.pNameField);

self.clean_company_name := l.pNameField;                                                                                                            

self := l;

end;

 

%File_out_z% := project(%File_for_conj_new%,%tnew_conj%(left));

 

 

//output(%File_out_z%);

//---------------------------------------all transforms into one format--------------------------

 

#uniquename(layout_clean)

//#uniquename(cleaned_name)

#uniquename(tcommon1)

#uniquename(tcommon2)

#uniquename(tcommon3)

#uniquename(tcommon4)

#uniquename(tcommon5)

#uniquename(tcommon6)

#uniquename(use_clean_1)

#uniquename(use_clean_2)

#uniquename(use_clean_3)

#uniquename(use_clean_4)

#uniquename(use_clean_5)

#uniquename(use_clean_6)

//#uniquename(cleaned_name_2)

 

%layout_clean% := record

string100 clean_company_name;

string73 clean_cleaned_name;

string73 clean_cleaned_name_2;

recordof(pDataset);

end;

 

%layout_clean% %tcommon1%(%clean_file_1% l) := Transform

self.clean_company_name := '';

self.clean_cleaned_name := if(trim(l.%zclean_name_1%)!='000',l.%zclean_name_1%,'');

self.clean_cleaned_name_2 := '';

self := l;

end;

 

%use_clean_1% := Project(%clean_file_1%,%tcommon1%(left));

 

%layout_clean% %tcommon2%(%clean_file_2% l) := Transform

self.clean_company_name := '';

self.clean_cleaned_name := if(trim(l.%clean_name_suffix%)!='000',l.%clean_name_suffix%,'');

self.clean_cleaned_name_2 := '';

self := l;

end;

 

%use_clean_2% := Project(%clean_file_2%,%tcommon2%(left));

 

 

%layout_clean% %tcommon3%(%clean_file_3% l) := Transform

self.clean_company_name := '';

self.clean_cleaned_name := if(trim(l.%zfmlclean_name_2%)!='000',l.%zfmlclean_name_2%,'');

self.clean_cleaned_name_2 := '';

self := l;

end;

 

%use_clean_3% := Project(%clean_file_3%,%tcommon3%(left));

 

%layout_clean% %tcommon4%(%adding_company_names% l) := Transform

self.clean_company_name := l.pNameField;

self.clean_cleaned_name := '';

self.clean_cleaned_name_2 := '';

self := l;

end;

 

%use_clean_4% := Project(%adding_company_names%,%tcommon4%(left));

 

#uniquename(clean_file_4)

%clean_file_4% := %zFile_after_is_company%(%is_company%);

 

%layout_clean% %tcommon5%(%clean_file_4% l) := Transform

self.clean_company_name := l.pNameField;

self.clean_cleaned_name := '';

self.clean_cleaned_name_2 := '';

self := l;

end;

 

%use_clean_5% := Project(%clean_file_4%,%tcommon5%(left));

 

#uniquename(clean_file_5)

%clean_file_5% := %File_out_z%;

%layout_clean% %tcommon6%(%clean_file_5% l) := Transform

//self.clean_cleaned_name := if(l.%clean_split_name3%[71..73]<'080' or trim(l.%clean_split_name3%)='000','',l.%clean_split_name3%);

self.clean_cleaned_name_2 := map(trim(l.%clean_split_name2%)='000'=>'',

                             l.%clean_split_name2%[71..73]>='090'=>l.%clean_split_name2%,

                                                                                     l.%clean_split_name2%[71..73]<'090'=>Address.CleanPersonfml73(trim(l.%clean_split_name2%)[1..70]+' '+trim(l.%clean_split_name3%)[46..70]),

                                                                                    ''

                                                                                    );    

self.clean_cleaned_name   :=         map(trim(l.%clean_split_name3%)='000'=>'',

                             l.%clean_split_name3%[71..73]>='090'=>l.%clean_split_name3%,

                                                                                     l.%clean_split_name3%[71..73]<'090'=>Address.CleanPersonfml73(trim(l.%clean_split_name3%)[1..70]+' '+trim(l.%clean_split_name2%)[46..70]),

                                                                                    ''

                                                                                    );          

self.clean_company_name := map(trim(l.pNameField)='' =>'',

                           self.clean_cleaned_name_2[71..73] <'080' =>l.%clean_split_name2%[1..70],

                           self.clean_cleaned_name[71..73] <'080' =>l.%clean_split_name3%[1..70],

                                                                           (self.clean_cleaned_name_2[71..73] <'080'and self.clean_cleaned_name[71..73] <'080')=>l.pNameField,

                                                                           ''

                                                                          );

                                    

                                                

self := l;

end;

 

%use_clean_6% := Project(%clean_file_5%,%tcommon6%(left));

 

//--------------------------------------------------------------------------

#uniquename(clean_file_all)

%clean_file_all% := %use_clean_1% +  %use_clean_2% +  %use_clean_3%+ %use_clean_4% + %use_clean_5% + %use_clean_6%; 

//count(%clean_file_all%);

 

//------------------------------------------------------------

 

 

//output(%clean_file_all%(clean_cleaned_name_2!=''))

#uniquename(layout_clean_address)

//#uniquename(address_split)

#uniquename(tnewadd)

#uniquename(after_address_split)

%layout_clean_address% := record

string100 clean_company_name;

string100 clean_address_split;

string73 clean_cleaned_name;

string73 clean_cleaned_name_2;

recordof(pDataset);

end;

%layout_clean_address% %tnewadd%(%clean_file_all% l) := Transform

self.clean_company_name := map(

                        StringLib.StringFind(StringLib.StringToUpperCase(l.clean_company_name),' C/O ',1)!=0 => 

                                                                        l.clean_company_name[1..StringLib.StringFind(StringLib.StringToUpperCase(l.clean_company_name),' C/O ',1)-1],

                                                                        StringLib.StringFind(StringLib.StringToUpperCase(l.clean_company_name),' % ',1)!=0 => 

                                                                        l.clean_company_name[1..StringLib.StringFind(StringLib.StringToUpperCase(l.clean_company_name),' % ',1)-1],

                                                                        l.clean_company_name

                                                                        );

self.clean_address_split := map(

                        StringLib.StringFind(StringLib.StringToUpperCase(l.clean_company_name),' C/O ',1)!=0 => 

                                                                        l.clean_company_name[StringLib.StringFind(StringLib.StringToUpperCase(l.clean_company_name),' C/O ',1)+5..100],

                                                                        StringLib.StringFind(StringLib.StringToUpperCase(l.clean_company_name),' % ',1)!=0 => 

                                                                        l.clean_company_name[StringLib.StringFind(StringLib.StringToUpperCase(l.clean_company_name),' % ',1)+3..100],

                                                                        ''

                                                                        );

self :=l;

end;

 

%after_address_split%  := Project(%clean_file_all%,%tnewadd%(left));

outfile := %after_address_split% ;

outlayout := recordof(outfile);       //%layout_clean_address% ;

endmacro;


//##############################################################use like this######################33

mac_clean_mod(Fictitious_Business_Names.File_Out_AllFlat_Rollup,cct_fullname,outfile);
output(outfile,,'~thor_data400::out::macro_clean_contactnames',overwrite);
//persist('~thor_data400::persist::macro_clean_contactnames');
//count(outfile(trim(cct_fullname,left,right)!='');
//output(choosen(outfile(trim(cct_fullname,left,right)!=''),all);

 

 

//######################code###############################################################

