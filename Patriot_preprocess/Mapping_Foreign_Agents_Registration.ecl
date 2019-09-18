
#OPTION('multiplePersistInstances',false);

afp := DATASET('~thor::in::globalwatchlists::foreign_agents_registration::fp', 
                              Layout_Foreign_Agents_Registration.layout_active_foreign_principals, 
														   CSV(separator(','),quote('"'),heading(1)));	
//output(choosen(afp,all), named('afp'));


ar := DATASET('~thor::in::globalwatchlists::foreign_agents_registration::re', 
                              Layout_Foreign_Agents_Registration.layout_active_registrants, 
														   CSV(separator(','),quote('"'),heading(1)));	
//output(choosen(ar,all), named('ar'));

asfr := DATASET('~thor::in::globalwatchlists::foreign_agents_registration::sre', 
                              Layout_Foreign_Agents_Registration.layout_active_short_form_registrants, 
														   CSV(separator(','),quote('"'),heading(1)));	
//output(choosen(asfr,all), named('asfr'));

//****************** process afp and ar
join_afp_and_ar := join(afp,ar,left.Registration_Num = right.Registration_Num);
                           
Layout_Foreign_Agents_Registration.layout_parse_address tr_parse_address(join_afp_and_ar l) := TRANSFORM

  add_tilda_address := regexreplace('(<br>)',trim(l.Address,left,right),'~');
	
  Address1 := map(regexfind('(.*)(~)(.*)(~)(.*)',add_tilda_address) => regexreplace('(.*)(~)(.*)(~)(.*)',add_tilda_address,'$1'),
	                regexfind('(.*)(~)(.*)',add_tilda_address) => regexreplace('(.*)(~)(.*)',add_tilda_address,'$1'),add_tilda_address);	               
	
  Address2 := map(regexfind('(.*)(~)(.*)(~)(.*)',add_tilda_address) => regexreplace('(.*)(~)(.*)(~)(.*)',add_tilda_address,'$3'),
	                regexfind('(.*)(~)(.*)',add_tilda_address) => regexreplace('(.*)(~)(.*)',add_tilda_address,'$3'),'');
	              
  Address3 := map(regexfind('(.*)(~)(.*)(~)(.*)',add_tilda_address) => regexreplace('(.*)(~)(.*)(~)(.*)',add_tilda_address,'$5'),'');

	self.Country := l.Country_Location_Represented;
  self.Registrant_ID := l.Registration_Num;
  self.Registrant := l.Registrant;
  self.Registrant_Terminated := '';
  self.Address_Line_1 := Address1;
  self.Address_Line_2 := Address2;
  self.Address_Line_3 := Address3;
  self.Foreign_Principal := l.Foreign_Principal;
  self.Foreign_Principal_Terminated := ''; //add_tilda_address;
  self.Nature_of_Service := '';//l.address;
  self.Activities := '';
  self.Finances := '';
end;
		
parse_address_afp_ar := PROJECT(join_afp_and_ar,tr_parse_address(left));
//output(parse_address_afp_ar, named('parse_address_afp_ar'));

//****************** process asfr
Layout_Foreign_Agents_Registration.layout_parse_name_address tr_parse_name_address(asfr l) := TRANSFORM

  // add_tilda_address := regexreplace('(<br>)',trim(l.Address,left,right),'~');
	
  // Address1 := map(regexfind('(.*)(~)(.*)(~)(.*)',add_tilda_address) => regexreplace('(.*)(~)(.*)(~)(.*)',add_tilda_address,'$1'),
	                // regexfind('(.*)(~)(.*)',add_tilda_address) => regexreplace('(.*)(~)(.*)',add_tilda_address,'$1'),add_tilda_address);	               
	
  // Address2 := map(regexfind('(.*)(~)(.*)(~)(.*)',add_tilda_address) => regexreplace('(.*)(~)(.*)(~)(.*)',add_tilda_address,'$3'),
	                // regexfind('(.*)(~)(.*)',add_tilda_address) => regexreplace('(.*)(~)(.*)',add_tilda_address,'$3'),'');
	              
  // Address3 := map(regexfind('(.*)(~)(.*)(~)(.*)',add_tilda_address) => regexreplace('(.*)(~)(.*)(~)(.*)',add_tilda_address,'$5'),'');

  Short_Form_Name_tilda := StringLib.StringFindReplace(
                             StringLib.StringFindReplace(l.Short_Form_Name,'(','~'),')','~');

  // Short_Form_Name_parsed := map(regexfind('(.*)(,)(.*)(~)(.*)(~)(.*)',Short_Form_Name_tilda) => regexreplace('(.*)(,)(.*)(~)(.*)(~)(.*)',Short_Form_Name_tilda,'$1$2 $5'),
	                              // regexfind('(.*)(~)(.*)(~)(,)(.*)',Short_Form_Name_tilda) => regexreplace('(.*)(~)(.*)(~)(,)(.*)',Short_Form_Name_tilda,'$3$5$6'),Short_Form_Name_tilda);
  
	 Short_Form_Name_parsed_aka := map(regexfind('(.*)(,)(.*)(~)(.*)(~)(.*)',Short_Form_Name_tilda) => regexreplace('(.*)(,)(.*)(~)(.*)(~)(.*)',Short_Form_Name_tilda,'$1$2 $5'),
	                                   regexfind('(.*)(~)(.*)(~)(,)(.*)',Short_Form_Name_tilda) => regexreplace('(.*)(~)(.*)(~)(,)(.*)',Short_Form_Name_tilda,'$3$5$6'),'');
   
	 Short_Form_Name_parsed_primary := map(regexfind('(.*)(,)(.*)(~)(.*)(~)(.*)',Short_Form_Name_tilda) => regexreplace('(.*)(,)(.*)(~)(.*)(~)(.*)',Short_Form_Name_tilda,'$1$2$3'),
	                                       regexfind('(.*)(~)(.*)(~)(,)(.*)',Short_Form_Name_tilda) => regexreplace('(.*)(~)(.*)(~)(,)(.*)',Short_Form_Name_tilda,'$1$5$6'),Short_Form_Name_tilda);
  
	// Name_Type := map(regexfind('(.*)(,)(.*)(~)(.*)(~)(.*)',Short_Form_Name_tilda) => 'AKA',
	                // regexfind('(.*)(~)(.*)(~)(,)(.*)',Short_Form_Name_tilda) => 'AKA','Primary');	
	
  self.short_Form_Name_primary := Short_Form_Name_parsed_primary;
	self.short_Form_Name_aka := Short_Form_Name_parsed_aka;
 // self.Name_Type := Name_Type;
 // self.short_Form_Date;
 // self.short_Form_Termination_Date;
  self.Registrant := l.Registrant;
  self.Registration_Num  := l.Registration_Num;
 // self.Registration_Date;
 // self.Address_Line_1 := Address1;
 // self.Address_Line_2 := Address2;
 // self.Address_Line_3 := Address3;
 // self.State;	
//	self.Short_Form_Terminated := 'N';
//	self.rec_numb := c;
//out.rec_numb :: !is_blank(in.Registration_Num) ? next_in_sequence() : '';
  self := [];
	end;	
	
parse_name_address_asfr := PROJECT(asfr,tr_parse_name_address(left));
//output(parse_name_address_asfr, named('parse_name_address_asfr'));

//****************** normalize asfr
Layout_Foreign_Agents_Registration.layout_parse_name_address 
                  tr_normalize_names(parse_name_address_asfr l, integer c) := TRANSFORM 
     
	self.Short_Form_Name := choose(c,l.short_Form_Name_primary,l.short_Form_Name_aka);
  self.Name_Type := choose(c,'Primary','AKA');
  self.Registrant := l.Registrant;
  self.Registration_Num := l.Registration_Num;
	self := [];;
end;																			

NormNames := normalize(parse_name_address_asfr,2,tr_normalize_names(left,counter));

//************** ar_afp to common layout
Patriot_preprocess.layout_patriot_common tr_patriot_common_ar_afp(parse_address_afp_ar l) := TRANSFORM
 
  concat_address:= l.Address_Line_1 + ' ' + l.Address_Line_2 + ' ' + l.Address_Line_3;
  clean_concat_address := trim(StringLib.StringFindReplace(concat_address,'&nbsp;',''),left,right);
	
  addr_1 := clean_concat_address[1..50];
  addr_2 := clean_concat_address[51..100];
  addr_3 := clean_concat_address[101..150];
  addr_4 := clean_concat_address[151..200];
  addr_5 := clean_concat_address[201..250];

	remarks1 := 'Country Represented: ' + l.Country;
	remarks2 := 'Foreign_Principal: ' + l.Foreign_Principal[1..56];
	remarks3 :=  l.Foreign_Principal[57..];

  self.pty_key := 'FARA' + l.Registrant_ID;
  self.source := 'Foreign Agents Registration Act';
  self.orig_pty_name := l.Registrant;
  self.country := l.Country;
  self.addr_1 := addr_1;
  self.addr_2 := addr_2;
  self.addr_3 := addr_3;
	self.addr_4 := addr_4;
	self.addr_5 := addr_5;	
  self.remarks_1 := remarks1; 												
  self.remarks_2 := remarks2;	
  self.remarks_3 := remarks3;
	
	// entity_string1 :=  '&|ELECTRICAL|NETWORK|SHIPPING|TELECOM|COMMUNICATION|CORPORATE|GRAPHIC |ACCOUNTS|REVOLUTIONARY| GROUP |ORGANIZATION|ORGANISATION|AMBULANCE|INDUSTRIE|AMERICAN|NORTHERN|SOUTHERN|ADMINISTRATION|ALIGNMENT|AMUSEMENT|ANTIQUE|APARTMENTS|APLC|ARCHITECT|ARCHETECT|AIR CONDITIONING|APPLIANCE|ASSOCIATES|ASSOCIATION|AS AGENT|AUTOMOTIVE|AUTHORITY|AVIATION|AIRLINES|BOARD|BOOKKEEPING|BOOKBINDER|BROKERAGE| BROKERS |BUILDING|BUSINESS|BOUTIQUE|CENTER|CENTRE|CHARTER|CHEMICAL|CHICAGO|COMPUTER|CORPORATION|CORP.|CARBURETOR|CHIROPRACTIC|CLEANING|COMPANIES|COMPANY|CONSTRUCTION|CONST.|CONSULTANTS|COOPERATIVE|CABLEVISION|COMMUNITY|COMMISSION|CMNTY|COMMUNICATIONS|COUNTRY CLUB| COUNTY | CREDIT | DEPT|DEPARTMENT|DEVELOPMENT|DETROIT|DVLPMNTL|DISTRICT|DISTRIBUTION|';
  // entity_string2 := 'DIVISION|ELEVATOR|ENTERPRISE|ENGINEERING|ESTATES|EQUIPMENT|EQUITY|EXCAVATING|EXPRESS|FABRICATORS|FINANCIAL |FINANCE |FLORIDA|FOGARTY KLEIN MONROE|FREIGHTLINER|FREIGHT |FULLFILLMENT|FULFILLMENT|FUNERAL HOME|FURNITURE|GOVERNMENT|GVRNMNT| GROWERS |DEVELOPMENT|DVLPMNTL|FREIGHT|HEALTHCARE|HOSPICE| HOSPITAL|INDUSTRIAL|INDUSTRIES|INFORMATION|INNOVATIVE|INSTITUTE|INTERNATIONAL|INTERIORS|INVESTMENTS|IRELAND|JAMAICA|JETRO|JONES DAY|LANDSCAPING|LAW FIRM| LEASING | LEASE |LIBERATION|LIMITED|LOS ANGELES|MACHINE|MANAGEMENT|MATUSHITA|MATSUSHITA|MISSIONARY|MINISTRIES|MNGMNT|MOBILE PARK|MOBILE HOME|MOUNTAIN|MULTIPLE|NATIONAL|NEW YORK|NEW ZEALAND|OPTICAL|PACKAGING|PARTNERSHIP|PARTY|PEDIATRICS|PEER REVIEW|PHARMACY|PHARMACEUTICAL|PENSION PLAN|PRODUCTIONS|';
  // entity_string3:= 'PROFESSIONAL|PROMOTION|PROPERTIES|PUBLIC|RAILROAD|REALTY|REBUILDERS|REPAIR|REPRESENT|RESTARAUNT|RESTAURANT|SAN FRANCISCO|SAVINGS|SECURITIES|SEAFOOD|SERVICES|SOLUTION|SPECIALTY| SQUARE |SYSTEMS|STATE BANK|SPECIALIST|SPRCNTR|SCHOOL|SOCIAL|STRATEG|SUPERCENTER|SUPPLY|SURGERY|TELEPHONE|TOURIST|TOURISM|TRADING|TRAVEL |TRADE NAME|TRUCKING| TRANSPORT |TECHNOLOGY|TRANSPORTATION|TRANSMISSION| STORAGE | TRANSFER | TRANSPORT |VALLEY |VISIT|WAREHOUSE|WELLS FARGO|WORLDWIDE|WORLD | AGENCY| MARKET | SALES | RADIO| COUNCIL | PARTNERS| PLAZA| CLINIC| CENTER | REPAIR | SERVICE |GROUP| TRUST | INC | INC.|,INC |,INC. | LLC| L L C| L.L.C.| LTD| LLP| L L P| L.L.P.| LP| L.P.| PLLC|P.L.L.C.|BANK N.A.|BANK NA|, N.A.|, N. A.|, N A|,N.A.|,N. A.| PSC| P S C| F S B|CITY OF|';
  // entity_string4 := 'COUNTY OF|STATE OF |PROVINCE OF |LIQUOR | CORP |OFICIAL| OFFICE | OFFICE|OFFICE | DELI | MOTEL | INN | USA | U S A | AND SONS| & SONS|SISTEMAS |CONSULTING |GROUP |DIGIDATA |UNIVERSAL |TECHNOLOGIES|EQUIPOS | THE |';
  // entity_string5 := 'Manufacture|Investment|Organization|National Tourist Office|Institute|Telekom|Destination|Tourist Board|Distribution|Corporation|Trade Center|Inc.|Industry|Trade|Tourism|Authority|Invest|Northern Ireland|';                                                                                                                                                                                                                                                                                                                                       
  // entity_string6 := 'Government|Travel|Office|Economic Development Board|Tourist|Office|Government|Enterprise|Ltd.|Republic of Northern Cyprus|Council|Liberation Front|North America|Communications|Global|Policy|Initiatives|Innovation|Movement|FCB|Movement|Syrian';                                                                                                                                                                                                                                                                                                      
 	// concat_entity := entity_string1 + entity_string2 + entity_string3 + entity_string4 + entity_string5 + entity_string6; 
  
	// self.entity_flag := map(regexfind(concat_entity,l.Registrant,nocase) = true => 'Y','');	

	self.entity_flag :=
	      map(
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'&',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'ELECTRICAL',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'NETWORK',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'SHIPPING',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'TELECOM',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'COMMUNICATION',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'CORPORATE',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'GRAPHIC',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'ACCOUNTS',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'REVOLUTIONARY',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),' GROUP',1) > 0 => 'Y', 
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'ORGANIZATION',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'ORGANISATION',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'AMBULANCE',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'INDUSTRIE',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'AMERICAN',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'NORTHERN',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'SOUTHERN',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'ADMINISTRATION',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'ALIGNMENT',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'AMUSEMENT',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'ANTIQUE',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'APARTMENTS',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'APLC',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'ARCHITECT',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'ARCHETECT',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'AIR CONDITIONING',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'APPLIANCE',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'ASSOCIATES',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'ASSOCIATION',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'AS AGENT',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'AUTOMOTIVE',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'AUTHORITY',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'AVIATION',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'AIRLINES',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'BOARD',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'BOOKKEEPING',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'BOOKBINDER',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'BROKERAGE',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),' BROKERS',1) > 0 => 'Y', 
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'BUILDING',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'BUSINESS',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'BOUTIQUE',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'CENTER',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'CENTRE',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'CHARTER',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'CHEMICAL',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'CHICAGO',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'COMPUTER',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'CORPORATION',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'CORP.',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'CARBURETOR',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'CHIROPRACTIC',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'CLEANING',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'COMPANIES',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'COMPANY',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'CONSTRUCTION',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'CONST.',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'CONSULTANTS',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'COOPERATIVE',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'CABLEVISION',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'COMMUNITY',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'COMMISSION',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'CMNTY',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'COMMUNICATIONS',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'COUNTRY CLUB',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),' COUNTY',1) > 0 => 'Y', 
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),' CREDIT',1) > 0 => 'Y', 
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),' DEPT',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'DEPARTMENT',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'DEVELOPMENT',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'DETROIT',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'DVLPMNTL',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'DISTRICT',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'DISTRIBUTION',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'DIVISION',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'ELEVATOR',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'ENTERPRISE',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'ENGINEERING',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'ESTATES',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'EQUIPMENT',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'EQUITY',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'EXCAVATING',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'EXPRESS',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'FABRICATORS',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'FINANCIAL',1) > 0 => 'Y', 
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'FINANCE',1) > 0 => 'Y', 
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'FLORIDA',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'FOGARTY KLEIN MONROE',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'FREIGHTLINER',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'FREIGHT',1) > 0 => 'Y', 
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'FULLFILLMENT',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'FULFILLMENT',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'FUNERAL HOME',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'FURNITURE',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'GOVERNMENT',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'GVRNMNT',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),' GROWERS',1) > 0 => 'Y', 
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'DEVELOPMENT',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'DVLPMNTL',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'FREIGHT',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'HEALTHCARE',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'HOSPICE',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),' HOSPITAL',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'INDUSTRIAL',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'INDUSTRIES',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'INFORMATION',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'INNOVATIVE',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'INSTITUTE',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'INTERNATIONAL',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'INTERIORS',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'INVESTMENTS',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'IRELAND',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'JAMAICA',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'JETRO',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'JONES DAY',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'LANDSCAPING',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'LAW FIRM',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),' LEASING',1) > 0 => 'Y', 
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),' LEASE',1) > 0 => 'Y', 
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'LIBERATION',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'LIMITED',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'LOS ANGELES',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'MACHINE',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'MANAGEMENT',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'MATUSHITA',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'MATSUSHITA',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'MISSIONARY',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'MINISTRIES',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'MNGMNT',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'MOBILE PARK',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'MOBILE HOME',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'MOUNTAIN',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'MULTIPLE',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'NATIONAL',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'NEW YORK',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'NEW ZEALAND',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'OPTICAL',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'PACKAGING',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'PARTNERSHIP',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'PARTY',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'PEDIATRICS',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'PEER REVIEW',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'PHARMACY',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'PHARMACEUTICAL',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'PENSION PLAN',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'PRODUCTIONS',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'PROFESSIONAL',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'PROMOTION',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'PROPERTIES',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'PUBLIC',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'RAILROAD',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'REALTY',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'REBUILDERS',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'REPAIR',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'REPRESENT',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'RESTARAUNT',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'RESTAURANT',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'SAN FRANCISCO',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'SAVINGS',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'SECURITIES',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'SEAFOOD',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'SERVICES',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'SOLUTION',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'SPECIALTY',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'SYSTEMS',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'STATE BANK',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'SPECIALIST',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'SPRCNTR',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'SCHOOL',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'SOCIAL',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'STRATEG',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'SUPERCENTER',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'SUPPLY',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'SURGERY',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'TELEPHONE',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'TOURIST',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'TOURISM',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'TRADING',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'TRAVEL',1) > 0 => 'Y', 
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'TRADE NAME',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'TRUCKING',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'TRANSPORT',1) > 0 => 'Y', 
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'TECHNOLOGY',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'TRANSPORTATION',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'TRANSMISSION',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),' STORAGE',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),' TRANSFER',1) > 0 => 'Y', 
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),' TRANSPORT',1) > 0 => 'Y', 
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'VALLEY',1) > 0 => 'Y', 
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'VISIT',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'WAREHOUSE',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'WELLS FARGO',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'WORLDWIDE',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'WORLD',1) > 0 => 'Y', 
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),' AGENCY',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),' MARKET',1) > 0 => 'Y', 
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),' SALES',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),' RADIO',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),' COUNCIL',1) > 0 => 'Y', 
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),' PARTNERS',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),' PLAZA',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),' CLINIC',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),' CENTER',1) > 0 => 'Y', 
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),' REPAIR',1) > 0 => 'Y', 
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),' SERVICE',1) > 0 => 'Y', 
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'GROUP',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),' TRUST',1) > 0 => 'Y', 
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),' INC',1) > 0 => 'Y', 
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),' INC.',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),',INC',1) > 0 => 'Y', 
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),',INC.',1) > 0 => 'Y', 
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),' LLC',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),' L L C',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),' L.L.C.',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),' LTD',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),' LLP',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),' L L P',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),' L.L.P.',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),' LP',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),' L.P.',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),' PLLC',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'P.L.L.C.',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'BANK N.A.',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'BANK NA',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),', N.A.',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),', N. A.',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),', N A',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),',N.A.',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),',N. A.',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),' PSC',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),' P S C',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),' F S B',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'CITY OF',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'COUNTY OF',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'STATE OF',1) > 0 => 'Y', 
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'PROVINCE OF',1) > 0 => 'Y', 
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'LIQUOR',1) > 0 => 'Y', 
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),' CORP',1) > 0 => 'Y', 
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'OFICIAL',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),' OFFICE',1) > 0 => 'Y', 
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),' OFFICE',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'OFFICE',1) > 0 => 'Y', 
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),' DELI',1) > 0 => 'Y', 
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),' MOTEL',1) > 0 => 'Y', 
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),' INN',1) > 0 => 'Y', 
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),' USA',1) > 0 => 'Y', 
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),' U S A',1) > 0 => 'Y', 
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),' AND SONS',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),' & SONS',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'SISTEMAS',1) > 0 => 'Y', 
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'CONSULTING',1) > 0 => 'Y', 
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'GROUP',1) > 0 => 'Y', 
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'DIGIDATA',1) > 0 => 'Y', 
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'UNIVERSAL',1) > 0 => 'Y', 
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'TECHNOLOGIES',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'EQUIPOS',1) > 0 => 'Y', 
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),' THE ',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'MANUFACTURE',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'INVESTMENT',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'ORGANIZATION',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'NATIONAL TOURIST OFFICE',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'INSTITUTE',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'TELEKOM',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'DESTINATION',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'TOURIST BOARD',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'DISTRIBUTION',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'CORPORATION',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'TRADE CENTER',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'INC.',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'INDUSTRY',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'TRADE',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'TOURISM',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'AUTHORITY',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'INVEST',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'NORTHERN IRELAND',1) > 0 => 'Y',                                                                                                                                                                                                                                                                                                                                    
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'GOVERNMENT',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'TRAVEL',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'OFFICE',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'ECONOMIC DEVELOPMENT BOARD',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'TOURIST',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'OFFICE',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'GOVERNMENT',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'ENTERPRISE',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'LTD',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'REPUBLIC OF NORTHERN CYPRUS',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'COUNCIL',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'LIBERATION FRONT',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'NORTH AMERICA',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'COMMUNICATIONS',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'GLOBAL',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'POLICY',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'INITIATIVES',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'INNOVATION',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'MOVEMENT',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'FCB',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'MOVEMENT',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'SYRIAN',1) > 0 => 'Y',				
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'NINEVEH PLAIN DEFENSE FUND',1) > 0 => 'Y',                                                                                                                                                                                                                                                                                                                                    
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'BRAND SOUTH AFRICA',1) > 0 => 'Y',                                                                                                                                                                                                                                                                                                                                            
				StringLib.StringFind(StringLib.StringToUpperCase(l.Registrant),'FRONT FOR INDEPENDENCE OF OROMIA (FIO)',1) > 0 => 'Y',                                                                                                                                                                                                                                                                                                                        

				'');  

	
 	self := [];
	end;

patriot_common_ar_afp := PROJECT(parse_address_afp_ar,tr_patriot_common_ar_afp(left));
//output(patriot_common_ar_afp, named('patriot_common_ar_afp'));

//************** asfr to common layout
filter_out_blank_names := NormNames(Short_Form_Name <> '');

Patriot_preprocess.layout_patriot_common 
                   tr_patriot_common_asfr(filter_out_blank_names l) := TRANSFORM
  
	remarks1 := 'Registrant: ' + l.Registrant[1..63];
	remarks2 :=  l.Registrant[54..];
	
  self.pty_key := 'FARA' + l.Registration_Num;
  self.source := 'Foreign Agents Registration Act';
  self.orig_pty_name := l.Short_Form_Name;
	self.name_type := l.Name_Type;
  self.remarks_1 := remarks1; 												
  self.remarks_2 := remarks2;	
	
  // entity_string1 :=  '&|ELECTRICAL|NETWORK|SHIPPING|TELECOM|COMMUNICATION|CORPORATE|GRAPHIC |ACCOUNTS|REVOLUTIONARY| GROUP |ORGANIZATION|ORGANISATION|AMBULANCE|INDUSTRIE|AMERICAN|NORTHERN|SOUTHERN|ADMINISTRATION|ALIGNMENT|AMUSEMENT|ANTIQUE|APARTMENTS|APLC|ARCHITECT|ARCHETECT|AIR CONDITIONING|APPLIANCE|ASSOCIATES|ASSOCIATION|AS AGENT|AUTOMOTIVE|AUTHORITY|AVIATION|AIRLINES|BOARD|BOOKKEEPING|BOOKBINDER|BROKERAGE| BROKERS |BUILDING|BUSINESS|BOUTIQUE|CENTER|CENTRE|CHARTER|CHEMICAL|CHICAGO|COMPUTER|CORPORATION|CORP.|CARBURETOR|CHIROPRACTIC|CLEANING|COMPANIES|COMPANY|CONSTRUCTION|CONST.|CONSULTANTS|COOPERATIVE|CABLEVISION|COMMUNITY|COMMISSION|CMNTY|COMMUNICATIONS|COUNTRY CLUB| COUNTY | CREDIT | DEPT|DEPARTMENT|DEVELOPMENT|DETROIT|DVLPMNTL|DISTRICT|DISTRIBUTION|';
  // entity_string2 := 'DIVISION|ELEVATOR|ENTERPRISE|ENGINEERING|ESTATES|EQUIPMENT|EQUITY|EXCAVATING|EXPRESS|FABRICATORS|FINANCIAL |FINANCE |FLORIDA|FOGARTY KLEIN MONROE|FREIGHTLINER|FREIGHT |FULLFILLMENT|FULFILLMENT|FUNERAL HOME|FURNITURE|GOVERNMENT|GVRNMNT| GROWERS |DEVELOPMENT|DVLPMNTL|FREIGHT|HEALTHCARE|HOSPICE| HOSPITAL|INDUSTRIAL|INDUSTRIES|INFORMATION|INNOVATIVE|INSTITUTE|INTERNATIONAL|INTERIORS|INVESTMENTS|IRELAND|JAMAICA|JETRO|JONES DAY|LANDSCAPING|LAW FIRM| LEASING | LEASE |LIBERATION|LIMITED|LOS ANGELES|MACHINE|MANAGEMENT|MATUSHITA|MATSUSHITA|MISSIONARY|MINISTRIES|MNGMNT|MOBILE PARK|MOBILE HOME|MOUNTAIN|MULTIPLE|NATIONAL|NEW YORK|NEW ZEALAND|OPTICAL|PACKAGING|PARTNERSHIP|PARTY|PEDIATRICS|PEER REVIEW|PHARMACY|PHARMACEUTICAL|PENSION PLAN|PRODUCTIONS|';
  // entity_string3:= 'PROFESSIONAL|PROMOTION|PROPERTIES|PUBLIC|RAILROAD|REALTY|REBUILDERS|REPAIR|REPRESENT|RESTARAUNT|RESTAURANT|SAN FRANCISCO|SAVINGS|SECURITIES|SEAFOOD|SERVICES|SOLUTION|SPECIALTY| SQUARE |SYSTEMS|STATE BANK|SPECIALIST|SPRCNTR|SCHOOL|SOCIAL|STRATEG|SUPERCENTER|SUPPLY|SURGERY|TELEPHONE|TOURIST|TOURISM|TRADING|TRAVEL |TRADE NAME|TRUCKING| TRANSPORT |TECHNOLOGY|TRANSPORTATION|TRANSMISSION| STORAGE | TRANSFER | TRANSPORT |VALLEY |VISIT|WAREHOUSE|WELLS FARGO|WORLDWIDE|WORLD | AGENCY| MARKET | SALES | RADIO| COUNCIL | PARTNERS| PLAZA| CLINIC| CENTER | REPAIR | SERVICE |GROUP| TRUST | INC | INC.|,INC |,INC. | LLC| L L C| L.L.C.| LTD| LLP| L L P| L.L.P.| LP| L.P.| PLLC|P.L.L.C.|BANK N.A.|BANK NA|, N.A.|, N. A.|, N A|,N.A.|,N. A.| PSC| P S C| F S B|CITY OF|';
  // entity_string4 := 'COUNTY OF|STATE OF |PROVINCE OF |LIQUOR | CORP |OFICIAL| OFFICE | OFFICE|OFFICE | DELI | MOTEL | INN | USA | U S A | AND SONS| & SONS|SISTEMAS |CONSULTING |GROUP |DIGIDATA |UNIVERSAL |TECHNOLOGIES|EQUIPOS | THE |';
  // entity_string5 := 'Manufacture|Investment|Organization|National Tourist Office|Institute|Telekom|Destination|Tourist Board|Distribution|Corporation|Trade Center|Inc.|Industry|Trade|Tourism|Authority|Invest|Northern Ireland|';                                                                                                                                                                                                                                                                                                                                       
  // entity_string6 := 'Government|Travel|Office|Economic Development Board|Tourist|Office|Government|Enterprise|Ltd.|Republic of Northern Cyprus|Council|Liberation Front|North America|Communications|Global|Policy|Initiatives';                                                                                                                                                                                                                                                                                                      
 	// concat_entity := entity_string1 + entity_string2 + entity_string3 + entity_string4 + entity_string5 + entity_string6; 
   
	// self.entity_flag := map(regexfind(concat_entity,l.Short_Form_Name,nocase) = true => 'Y','');		

	self.entity_flag :=
	      map(
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'&',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'ELECTRICAL',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'NETWORK',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'SHIPPING',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'TELECOM',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'COMMUNICATION',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'CORPORATE',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'GRAPHIC',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'ACCOUNTS',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'REVOLUTIONARY',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),' GROUP',1) > 0 => 'Y', 
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'ORGANIZATION',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'ORGANISATION',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'AMBULANCE',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'INDUSTRIE',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'AMERICAN',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'NORTHERN',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'SOUTHERN',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'ADMINISTRATION',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'ALIGNMENT',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'AMUSEMENT',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'ANTIQUE',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'APARTMENTS',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'APLC',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'ARCHITECT',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'ARCHETECT',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'AIR CONDITIONING',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'APPLIANCE',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'ASSOCIATES',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'ASSOCIATION',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'AS AGENT',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'AUTOMOTIVE',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'AUTHORITY',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'AVIATION',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'AIRLINES',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'BOARD',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'BOOKKEEPING',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'BOOKBINDER',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'BROKERAGE',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),' BROKERS',1) > 0 => 'Y', 
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'BUILDING',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'BUSINESS',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'BOUTIQUE',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'CENTER',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'CENTRE',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'CHARTER',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'CHEMICAL',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'CHICAGO',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'COMPUTER',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'CORPORATION',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'CORP.',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'CARBURETOR',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'CHIROPRACTIC',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'CLEANING',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'COMPANIES',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'COMPANY',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'CONSTRUCTION',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'CONST.',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'CONSULTANTS',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'COOPERATIVE',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'CABLEVISION',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'COMMUNITY',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'COMMISSION',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'CMNTY',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'COMMUNICATIONS',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'COUNTRY CLUB',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),' COUNTY',1) > 0 => 'Y', 
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),' CREDIT',1) > 0 => 'Y', 
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),' DEPT',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'DEPARTMENT',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'DEVELOPMENT',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'DETROIT',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'DVLPMNTL',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'DISTRICT',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'DISTRIBUTION',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'DIVISION',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'ELEVATOR',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'ENTERPRISE',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'ENGINEERING',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'ESTATES',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'EQUIPMENT',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'EQUITY',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'EXCAVATING',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'EXPRESS',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'FABRICATORS',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'FINANCIAL',1) > 0 => 'Y', 
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'FINANCE',1) > 0 => 'Y', 
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'FLORIDA',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'FOGARTY KLEIN MONROE',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'FREIGHTLINER',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'FREIGHT',1) > 0 => 'Y', 
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'FULLFILLMENT',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'FULFILLMENT',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'FUNERAL HOME',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'FURNITURE',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'GOVERNMENT',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'GVRNMNT',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),' GROWERS',1) > 0 => 'Y', 
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'DEVELOPMENT',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'DVLPMNTL',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'FREIGHT',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'HEALTHCARE',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'HOSPICE',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),' HOSPITAL',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'INDUSTRIAL',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'INDUSTRIES',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'INFORMATION',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'INNOVATIVE',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'INSTITUTE',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'INTERNATIONAL',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'INTERIORS',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'INVESTMENTS',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'IRELAND',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'JAMAICA',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'JETRO',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'JONES DAY',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'LANDSCAPING',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'LAW FIRM',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),' LEASING',1) > 0 => 'Y', 
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),' LEASE',1) > 0 => 'Y', 
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'LIBERATION',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'LIMITED',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'LOS ANGELES',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'MACHINE',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'MANAGEMENT',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'MATUSHITA',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'MATSUSHITA',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'MISSIONARY',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'MINISTRIES',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'MNGMNT',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'MOBILE PARK',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'MOBILE HOME',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'MOUNTAIN',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'MULTIPLE',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'NATIONAL',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'NEW YORK',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'NEW ZEALAND',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'OPTICAL',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'PACKAGING',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'PARTNERSHIP',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'PARTY',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'PEDIATRICS',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'PEER REVIEW',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'PHARMACY',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'PHARMACEUTICAL',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'PENSION PLAN',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'PRODUCTIONS',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'PROFESSIONAL',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'PROMOTION',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'PROPERTIES',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'PUBLIC',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'RAILROAD',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'REALTY',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'REBUILDERS',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'REPAIR',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'REPRESENT',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'RESTARAUNT',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'RESTAURANT',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'SAN FRANCISCO',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'SAVINGS',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'SECURITIES',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'SEAFOOD',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'SERVICES',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'SOLUTION',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'SPECIALTY',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'SYSTEMS',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'STATE BANK',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'SPECIALIST',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'SPRCNTR',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'SCHOOL',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'SOCIAL',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'STRATEG',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'SUPERCENTER',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'SUPPLY',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'SURGERY',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'TELEPHONE',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'TOURIST',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'TOURISM',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'TRADING',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'TRAVEL',1) > 0 => 'Y', 
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'TRADE NAME',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'TRUCKING',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'TRANSPORT',1) > 0 => 'Y', 
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'TECHNOLOGY',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'TRANSPORTATION',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'TRANSMISSION',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),' STORAGE',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),' TRANSFER',1) > 0 => 'Y', 
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),' TRANSPORT',1) > 0 => 'Y', 
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'VALLEY',1) > 0 => 'Y', 
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'VISIT',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'WAREHOUSE',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'WELLS FARGO',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'WORLDWIDE',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'WORLD',1) > 0 => 'Y', 
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),' AGENCY',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),' MARKET',1) > 0 => 'Y', 
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),' SALES',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),' RADIO',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),' COUNCIL',1) > 0 => 'Y', 
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),' PARTNERS',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),' PLAZA',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),' CLINIC',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),' CENTER',1) > 0 => 'Y', 
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),' REPAIR',1) > 0 => 'Y', 
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),' SERVICE',1) > 0 => 'Y', 
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'GROUP',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),' TRUST',1) > 0 => 'Y', 
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),' INC',1) > 0 => 'Y', 
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),' INC.',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),',INC',1) > 0 => 'Y', 
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),',INC.',1) > 0 => 'Y', 
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),' LLC',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),' L L C',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),' L.L.C.',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),' LTD',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),' LLP',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),' L L P',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),' L.L.P.',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),' LP',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),' L.P.',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),' PLLC',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'P.L.L.C.',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'BANK N.A.',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'BANK NA',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),', N.A.',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),', N. A.',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),', N A',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),',N.A.',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),',N. A.',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),' PSC',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),' P S C',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),' F S B',1) > 0 => 'Y',
				 StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'CITY OF',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'COUNTY OF',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'STATE OF',1) > 0 => 'Y', 
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'PROVINCE OF',1) > 0 => 'Y', 
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'LIQUOR',1) > 0 => 'Y', 
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),' CORP',1) > 0 => 'Y', 
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'OFICIAL',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),' OFFICE',1) > 0 => 'Y', 
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),' OFFICE',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'OFFICE',1) > 0 => 'Y', 
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),' DELI',1) > 0 => 'Y', 
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),' MOTEL',1) > 0 => 'Y', 
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),' INN',1) > 0 => 'Y', 
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),' USA',1) > 0 => 'Y', 
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),' U S A',1) > 0 => 'Y', 
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),' AND SONS',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),' & SONS',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'SISTEMAS',1) > 0 => 'Y', 
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'CONSULTING',1) > 0 => 'Y', 
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'GROUP',1) > 0 => 'Y', 
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'DIGIDATA',1) > 0 => 'Y', 
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'UNIVERSAL',1) > 0 => 'Y', 
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'TECHNOLOGIES',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'EQUIPOS',1) > 0 => 'Y', 
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),' THE ',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'MANUFACTURE',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'INVESTMENT',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'ORGANIZATION',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'NATIONAL TOURIST OFFICE',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'INSTITUTE',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'TELEKOM',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'DESTINATION',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'TOURIST BOARD',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'DISTRIBUTION',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'CORPORATION',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'TRADE CENTER',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'INC.',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'INDUSTRY',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'TRADE',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'TOURISM',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'AUTHORITY',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'INVEST',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'NORTHERN IRELAND',1) > 0 => 'Y',                                                                                                                                                                                                                                                                                                                                    
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'GOVERNMENT',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'TRAVEL',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'OFFICE',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'ECONOMIC DEVELOPMENT BOARD',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'TOURIST',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'OFFICE',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'GOVERNMENT',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'ENTERPRISE',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'LTD',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'REPUBLIC OF NORTHERN CYPRUS',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'COUNCIL',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'LIBERATION FRONT',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'NORTH AMERICA',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'COMMUNICATIONS',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'GLOBAL',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'POLICY',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'INITIATIVES',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'INNOVATION',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'MOVEMENT',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'FCB',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'MOVEMENT',1) > 0 => 'Y',
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'SYRIAN',1) > 0 => 'Y',				
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'NINEVEH PLAIN DEFENSE FUND',1) > 0 => 'Y',                                                                                                                                                                                                                                                                                                                                    
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'BRAND SOUTH AFRICA',1) > 0 => 'Y',                                                                                                                                                                                                                                                                                                                                            
				StringLib.StringFind(StringLib.StringToUpperCase(l.Short_Form_Name),'FRONT FOR INDEPENDENCE OF OROMIA (FIO)',1) > 0 => 'Y',                                                                                                                                                                                                                                                                                                                        

				'');  

	self := [];
	end;

patriot_common_asfr := PROJECT(filter_out_blank_names,tr_patriot_common_asfr(left));
//output(patriot_common_asfr, named('patriot_common_asfr'));

EXPORT Mapping_Foreign_Agents_Registration := patriot_common_ar_afp + patriot_common_asfr

// EXPORT Mapping_Foreign_Agents_Registration := //patriot_common_ar_afp 
                                             // patriot_common_asfr
         : persist('~thor::persist::out::patriot::preprocess::Foreign_Agents_Registration');
