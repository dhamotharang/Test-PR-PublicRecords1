﻿EXPORT _fns_offense_category := module
   
export In_Global_Exclude (string poffense_in,string pcategory ) := function 


special_characters := '~|=|!|-|%|\\^|\\+|:|\\(|\\)|,|;|_|#|%|@|\\*|<|>|"|`|\\[|]|\\{|\\}|\\\\|\\\'';
poffense           := ' '+REGEXREPLACE(special_characters, poffense_in, ' ');
vio_set            := '[/\\. ]VIO[LATIONG]*[/\\. ]|[/\\. ]VIO[LATED]*[/\\. ]|VIOLATION';
   Is_it := MAP(
               REGEXFIND('[/\\. ]CONSP[SIRACY\\.]*[/\\.  ]|CONSPIERACY|CONS[I]*PIRACY|CONSPRI[ER]+|CONSPRRE|CONSPIE[R]* TO'     ,poffense,0) <> '' => 'Y',
							 
							 // REGEXFIND('POSS'                  ,poffense,0) <> '' AND              
               REGEXFIND('BURG'                  ,poffense,0) <> '' AND     
               REGEXFIND('TOOL'                  ,poffense,0) <>  '' => 'Y',							 

               REGEXFIND('WARRANT|BENCH WRT |LITTER|ACCOMPLIC|COMPLIC|APPEAL|WAOJ|GUTTER|CAPAIS|CAPIAS|ACCESRY|FOJ OTHER|CONSPIR|CONTEMPT|^[ ]*DISC[ ]|^[ ]*MTP[/ ]|^[ ]*MTR[/ ]|^[ ]*MTRP[/ ]' ,poffense,0) <> ''  => 'Y',
							 
							 REGEXFIND('ARR'    ,poffense,0) <> '' and 
	             REGEXFIND('DATA'   ,poffense,0) <> '' and 
							 REGEXFIND('NOT'    ,poffense,0) <> '' and 
							 REGEXFIND('REC'    ,poffense,0) <> ''=> 'Y',

	             REGEXFIND(' CMTP| CNMTP| CNTMPT| BWP | BW[/ ]|VOP|V\\.O\\.P| V/P[/ ]|AID(.*)ABET| BW[I]* | V[ ]*O[ ]*C[ ]*C[/ ]| [SW]*VCC[/ ]| VOC[R]*[/ ]' ,poffense,0) <> ''  => 'Y', 
							 // | P\\.O\\.M[/ ]| POM[/ ]||[/ ]P\\.O\\.M[\\./ ]|| P[\\. ]O[\\. ]C[\\. ]S[/ ]|[/ ]P\\.O\\.C\\.S[\\./ ]
							 REGEXFIND('[/ ]VOCC[/ ]|[/ ][SW]*VCC[/ ]|[/ ]VOC[R]*[/ ]' ,poffense,0) <> ''  => 'Y', 
							            
							 REGEXFIND(' F\\.T\\.A|[/\\. ]FTA[/\\. ]' ,poffense,0) <> ''  => 'Y',
							 
							 REGEXFIND('AID'                                   ,poffense,0) <> ''  AND
							 REGEXFIND('ABET'                                  ,poffense,0) <> ''  AND
							 REGEXFIND('ELIZABETH|BETH|LABET|HABET'            ,poffense,0) = ''  => 'Y' ,		
							 
							 REGEXFIND('MOTION'                                ,poffense,0) <> ''  AND
							 REGEXFIND('TO'                                    ,poffense,0) <> ''  => 'Y' ,
							                     
							 REGEXFIND('FAIL'                                  ,poffense,0) <> ''  AND
							 REGEXFIND('TO'                                    ,poffense,0) <> ''  AND
							 REGEXFIND('APPEAR'                                ,poffense,0) <> ''  => 'Y' ,	
							 
							 REGEXFIND('VIO'                                   ,poffense,0) <> ''  AND
							 REGEXFIND('RELEAS'                                ,poffense,0) <> ''  => 'Y' ,	
							                     
							 REGEXFIND('COURT'                                 ,poffense,0) <> ''  AND
							 REGEXFIND('ORD'                                   ,poffense,0)  <> ''  => 'Y' ,
							 
							 REGEXFIND(vio_set+'|REV|RVK[D]*|REVO[CK]*|DISOBE'   ,poffense,0) <> '' and 
               REGEXFIND('COURT|[/\\. ]CRT[/\\. ]|[/\\. ]CT[/\\. ]',poffense,0) <> '' and 
						   REGEXFIND('ORD'                                     ,poffense,0) <> '' => 'Y',	
							 
	             pcategory IN ['ASSAULT','TERROR'] and 
							 REGEXFIND('PAROL|PROB|BOND|BND|PTR'               ,poffense,0) <> '' and 
	             REGEXFIND(vio_set+'|REV'                          ,poffense,0) <> '' => 'Y',	
							 
							 pcategory NOT IN ['ASSAULT','TERROR'] and
							 REGEXFIND('PAROL|PROB|ROR|BOND|BND|PTR'           ,poffense,0) <> '' and 
	             REGEXFIND(vio_set+'|REV|RVK[D]*|REVO[CK]*'        ,poffense,0) <> '' and
							 REGEXFIND('TERROR'                                ,poffense,0) =  ''=> 'Y',	
               
							 REGEXFIND('SHOW'                                  ,poffense,0) <> '' and 
	             REGEXFIND('CAUSE|NO |FAIL'                        ,poffense,0) <> '' => 'Y',
							 
							 REGEXFIND('SOR '                                  ,poffense,0) <> '' AND              
  						 REGEXFIND('REV'                                   ,poffense,0) <> '' => 'Y',
	
	             REGEXFIND(vio_set+'|REV|RVK[D]*|REVO[CK]*'        ,poffense,0) <> '' and 
	             REGEXFIND('PRE'                                   ,poffense,0) <> '' and 
							 REGEXFIND('TRIAL'                                 ,poffense,0) <> '' => 'Y',	   
							 
							 REGEXFIND(vio_set+'|REV|RVK[D]*|REVO[CK]*|DISOBE' ,poffense,0) <> '' and 
	             REGEXFIND('SUSP'                                  ,poffense,0) <> '' and 
							 REGEXFIND('SENT'                                  ,poffense,0) <> '' => 'Y',	
							 
							 REGEXFIND(vio_set+'|REV|RVK[D]*|REVO[CK]*|DISOBE' ,poffense,0) <> '' and 
	             REGEXFIND('COND'                                  ,poffense,0) <> '' and 
							 REGEXFIND('REL'                                   ,poffense,0)  <> '' => 'Y',	
							 //Roger's comment on 7/27/16 QA review Global Expression Round 2
							 REGEXFIND('ABETTING'															 ,poffense,0) <> '' and 
	             REGEXFIND('TURKEY|WILD ANIM|BEAR| DICE|FIREWORKS' ,poffense,0) <> ''  => 'Y',	
							 //Roger's comment QA review Global Expression Round 3 8/26/16
							 REGEXFIND('WRIT' 																 ,poffense,0) <> '' and 
	             REGEXFIND('BOD|OF'                                ,poffense,0) <> '' and 
							 REGEXFIND('ATTACH'                                ,poffense,0) <> '' => 'Y',	
							 REGEXFIND('V\\-O\\-P|AID & ABEDDING|OUT OF CO WRNT|WRIT OF HABEAS CORUPS',poffense,0) <> '' => 'Y', 
							 //Roger's comment QA review Global Expression Round 4 9/23/16
							 REGEXFIND('BE AN ACCESSORY|A[C]+ESS[ORY]* AFTER [THE ]*FACT ',poffense,0) <> '' => 'Y',	
							 REGEXFIND('ACCESSORY TO|ACCESSORY AFTER'					 ,poffense,0) <> '' and
							 REGEXFIND('MURDER|HOMICIDE|SHOOT'                 ,poffense,0) <> '' => 'Y',	
							 REGEXFIND('V O P[\\-| ]'													 ,poffense,0) <> '' => 'Y',	
	             REGEXFIND(' TURKEY[$| ]|WILD ANIM| BEAR[$| ]' 		 ,poffense,0) <> '' => 'Y',	
							 REGEXFIND('BOND '		 													 	 ,poffense,0) <> '' and
							 REGEXFIND('APPL[I|/| ]'                           ,poffense,0) <> '' => 'Y',	
							 //QA Update - Global Expression   Round 5  10/11/16
							 REGEXFIND('VIO[L]?\\.|VIOL |REVOKE|REV '	 	       ,poffense,0) <> '' and
							 REGEXFIND('ROR '                                  ,poffense,0) <> '' => 'Y',	
							 REGEXFIND('RVK[ |D]'	 	                           ,poffense,0) <> '' and
							 REGEXFIND(' PTR '                                 ,poffense,0) <> '' => 'Y',	
							 //QA terrorist Threats  Round 5 10/14/16 Add INTERROG to global expression
							 //Remove compilation warning - change '\\-' to '[\\-]*
							 REGEXFIND('ACCESORY [\\-]* MURDER|ACCESSORY AFT[ER]* THE FAC|ACCESSORY BEFORE [THE ]*FACT|' +
							           'ACCESSORY [ATT ]*MURDER|ACCESSORY FELONY|INTERROG|ANS[W]*[\\.| ]INTERR',poffense,0) <> '' => 'Y',	
							 //QA Update - Global Expression Round 6
							 REGEXFIND('WRIT [OF ]*HABEAS CORPUS|HOLD FOR ANOTHER AGENCY|ZONING VIOLATION[S]*|ZONING COMPLAINTS|' +
							           'ZONING[ |\\-|/]+PERMIT[S]*|F/T PAY FINE[S]*|PETITION FOR|PETITION TO',poffense,0) <> '' => 'Y',	
							 
               REGEXFIND('ACCESSORY|ACCOMPLICE|CONSPIRE|CONSPIRACY'          ,poffense,0) <> '' and
               REGEXFIND('ARSON|BRIBE|BURGLARY|FORGE|FRAUD|KIDNAP|ABDUCT|ROBBERY|ASSAULT|A&B|ASSLT|A\\.B\\.W\\.I\\.K|'+
							           'ABDGR|ASSLT|WOUNDING|AGG BATTERY|ABWIK|CHILD ABUSE',poffense,0) <> '' => 'Y',
												 
	             // trim(poffense) in _fmod_offense_category_list.Globallist =>'Y',
							 'N');
							 
return Is_it;							 
end; 

//-------------------------------------------------------------------------------------------------------------------------------------
export Is_Arson(string poffense_in) := function


special_characters    := '~|=|!|-|%|\\^|\\+|:|\\(|\\)|,|;|_|#|%|\\*|<|>|"|`|\\[|]|\\{|\\}|\\\\|\\\'';
poffense        := ' '+REGEXREPLACE(special_characters, poffense_in, ' ');

Arson            := 'ARS0N|ARSON';
Arson_exc        := 'LARS[0O]N|CARS[0O]N|PEARS[0O]N|PARS[0O]N|PARS[0O]NS|OSBURN|BURNET';

   Is_it := MAP(In_Global_Exclude(poffense,'other')='Y' => 'N',
	             
							 //trim(poffense) in _fmod_offense_category_list.ArsonList =>'Y',

	             REGEXFIND('BURN'                      ,poffense,0) <> '' AND              
							 REGEXFIND('CERTAIN'                   ,poffense,0) <> '' AND
							 REGEXFIND('BUILD'                     ,poffense,0) <> '' AND
							 REGEXFIND('BURNETT|OSBURN|BURNET'     ,poffense,0) = ''=> 'Y',
							 
	             REGEXFIND('BURN'                      ,poffense,0) <> '' AND              
							 REGEXFIND('ARSON|MAL|WI[L]+FUL|FRAUD' ,poffense,0) <> '' AND
							 REGEXFIND('BURNETT|OSBURN|BURNET'     ,poffense,0) = ''=> 'Y',	
               
							 REGEXFIND(Arson ,poffense,0) <> '' and
							 REGEXFIND(Arson_exc ,poffense,0) = ''=> 'Y',	               
							 'N');
							 
return Is_it;
end;

//--------------------------------------------------------------------------------------------------------------------------------------

export Is_Robbery_Res(string poffense_in) := function
special_characters    := '~|=|!|-|%|\\^|\\+|:|\\(|\\)|,|;|_|#|%|@|\\*|<|>|"|`|\\[|]|\\{|\\}|\\\\|\\\'';
poffense              := ' '+REGEXREPLACE(special_characters, poffense_in, ' ');

Robbery               := 'ROBB[EYING]+|ROB[B]+[RE]*R[Y]*|CAR[ ]*JACK[ING]*|AGG ROB|ROBB[/\\. ]|ROBB[0-9]|[/\\. ]R.[B]+ERY|ROBBB|[R]+OBERY'; 
Robbery_exc           := 'PROBATION|PROBHIB'; 
comm                  := 'BANK|STORE|BUILD|BLDG|COMMERC|COMMER[CI]+AL|[/ ]BUS[/\\. ],BU[S]+IN|BUS[INS]+';
	
  Is_it := MAP(In_Global_Exclude(poffense,'other')='Y' => 'N',
	             // trim(poffense) in _fmod_offense_category_list.RobberyResidentialList =>'Y',
	             REGEXFIND('ARM|ATT|PERSON|INTENT'    ,poffense,0) <> '' and
							 REGEXFIND('ROB'                      ,poffense,0) <> '' and 
							 REGEXFIND(Robbery_exc                ,poffense,0) =  '' and
							 REGEXFIND(comm                       ,poffense,0) =  '' => 'Y',
							 
	             REGEXFIND(Robbery                    ,poffense,0) <> '' and 
							 REGEXFIND(Robbery_exc                ,poffense,0)  = '' and 
							 REGEXFIND(comm                       ,poffense,0)  = '' => 'Y',
							 
							 REGEXFIND(' PC 211 |PC 664[/]211 |PC 215 A ',poffense,0)  <> '' => 'Y',
							 
							 'N');
return Is_it;
end;
//---------------------------------------------------------------------------------------------------------------------------------------

export Is_Robbery_comm(string poffense_in) := function
special_characters    := '~|=|!|-|%|\\^|\\+|:|\\(|\\)|,|;|_|#|%|@|\\*|<|>|"|`|\\[|]|\\{|\\}|\\\\|\\\'';
poffense  := ' '+REGEXREPLACE(special_characters, poffense_in, ' ');

//DF-18286 - code review comment #2, change CAR[ ]*JACKING to CAR[ ]*JACK[ING]* as in Is_Robbery_res.
Robbery   := 'ROBB[EYING]+|ROB[B]+[RE]*R[Y]*|CAR[ ]*JACK[ING]*|AGG ROB|ROBB[/\\. ]|ROBB[0-9]|[/\\. ]R.[B]+ERY|ROBBB|[R]+OBERY';  

comm      := 'BANK|STORE|BUILD|BLDG|COMMERC|COMMER[CI]+AL|[/ ]BUS[/\\. ],BU[S]+IN|BUS[INS]+';

exclusion := 'PROBATION|PROBHIB|PRIVACY|TRES|TRSP';
// 'AUTO| M[/]*V |VEH|HOUSE|HAB[/ ]|HABITAT|[/ ]RES[/ ]|RESIDENCE|HOUSE';


  Is_it := MAP(In_Global_Exclude(poffense,'other')='Y' => 'N',
	
	             REGEXFIND('ARM|ATT|PERSON|INTENT'    ,poffense,0) <> '' and
							 REGEXFIND('ROB'                      ,poffense,0) <> '' and 
							 REGEXFIND(comm                       ,poffense,0) <> '' and
							 REGEXFIND(exclusion                  ,poffense,0) =  '' => 'Y',
							 
	             REGEXFIND(Robbery                    ,poffense,0) <> '' and 
							 REGEXFIND(comm                       ,poffense,0) <> '' and
							 REGEXFIND(exclusion                  ,poffense,0) =  '' => 'Y',	               
							 'N');
return Is_it;
end;
//--------------------------------------------------------------------------------------------------------------------------------------
export Is_Homicide(string poffense_in) := function

special_characters:= '~|=|!|-|%|\\^|\\+|:|\\(|\\)|,|;|_|#|%|\\*|<|>|"|`|\\[|]|\\{|\\}|\\\\|\\\'';
poffense          := ' '+REGEXREPLACE(special_characters, poffense_in, ' ');

Homicide1        := 'HOM[IO]C[IDE]*|MURDER|M[A]*NSL[AU]*G[HTER]*|AWDWIKISI|AWDWI[TS]|AWDW[/ ]|HIOMICIDE|MNS[IL]GHT[E]*R|PC 246\\.3|PC 246 |PC 664[/]211 |PC 664[/]187 A |PC 187 A |PC 192 C ';

Homicide2a       := 'KILL|DEATH|ADMINISTER|WILFUL';
Homicide2b       := 'INTENT|CAUSE|RESULT|POISON|MURDER|HOMICIDE';

Homicide_exc     := 'ALLIG$|ALLIGATOR|ANI[N]?MAL|ANIM$| ANTE$|ANTERLESS| BEAR|BIRD|CALF| CAT[TLE]|COW|DEER|[ |\\/|\\.]DOG[\\/|S| |$]| DOVE|DUCK| FOWL|GEESE|HORSE|MOOSE| OWL|PHEASANT|POULTRY|SPECIE[S|$]|TURKE[R]?Y|WATER[F]?OWL|WILDLIFE|WILD ANIM|[ |/]FISH';

Ha               := 'ATMUR|A TO MUR|A[/]MUR |AG MUR|AT MUR|AT[/]MUR|MUR[/ ]2N|MUR 2ND|MUR[/ ]REIN|MUR W[/]MAL|MUR WO|MUR W/O REIN|MUR WITH MALICE|'+
                    'MUR WM|MUR[/ ]W[/]*O[/ ]MAL|MUR WOM|ACC[/]MUR|MUR[/]HAB|MUR[/ ]MAL|MUR[/]MOTOR|MUR[/]PO|MUR[/]W[/]M|MUR[/]W[/]MAL|MUR[/]WO'; 

  Is_it := MAP(In_Global_Exclude(poffense,'other')='Y' => 'N',
	             // trim(poffense) in _fmod_offense_category_list.HomicideList =>'Y',
							 
							 //Roger's comment - QA Update - Homicide Round 3 8/26
	             REGEXFIND('KILL'       							 							,poffense,0) <> '' and
							 REGEXFIND('INTENT'     				 										,poffense,0) <> '' and
							 REGEXFIND('[ |N]W[/]?O[UT]* |WO/|W/OINT|WITHOUT' 	,poffense,0) <> '' AND
							 REGEXFIND('WITH INTENT TO KILL'       							,poffense,0) =  '' => 'N',
							 //Roger's comment - QA Update - Global Expression Round 3 8/26
	             REGEXFIND('[ACCESSORY|ACESSORY] AFTER THE FACT|BE AN ACCESSORY',poffense,0) <> '' => 'N',
							 //Roger's comment - QA Update - Assault Other Round 5 10/17/16
	             REGEXFIND('THREATEN'    							 							,poffense,0) <> '' and
							 REGEXFIND('ACT OF VIOLENCE'		 										,poffense,0) <> '' => 'N',
							 
							 REGEXFIND('MNSLGH|INVLMNSLGH|M[A]*NSL |MANSLA|MNSLAU|MNSL[H]*TR|MANSLT[E]*R|MNSLTLTR|MNSLA[U]*GHTER|MANSALUGHTER|MANSLAUTER|MANSLTER\\.' ,poffense,0) <> '' => 'Y',
							 
							 REGEXFIND(Ha ,poffense,0) <> '' => 'Y',
							 
							 (REGEXFIND('ATT KILL|ATT TO KILL|KILL[/]ATT'       ,poffense,0) <> '' or
							  (REGEXFIND('ATT[E]*MP|ATTM[P]*T|ATTPT|^[ ]*ATT[\\. ]| ATT ',poffense,0) <> '' and REGEXFIND('KILL'       ,poffense,0) <> '' )
							 ) and
							 REGEXFIND('ANIM|BEAR|ANTLERL|ANTE|LIVESTOCK|ALLIGATOR|HAWK|CHICKEN|SPOTLIGHT|SPTLIHT|SPOT|SPLIT|W/SP| DEER' ,poffense,0) = '' 
							 => 'Y',
							 
							 REGEXFIND('SHOOT'             ,poffense,0) <> '' and
							 REGEXFIND('THROW|DEADLY'      ,poffense,0) <> '' and
							 REGEXFIND('MIS[SI]*LE|MALIC'  ,poffense,0) <> '' => 'Y',
							 
							 REGEXFIND('HOMI'       ,poffense,0) <> '' and
							 REGEXFIND('CRIM|NEG|VE[C]*H|AGG|ATT'  ,poffense,0) <> '' => 'Y',
							 
							 REGEXFIND('POISON'            ,poffense,0) <> '' AND   
							 REGEXFIND('LIQUOR|FOOD|WATER|ATTEMPT|MEDICINE| WELL[S]* ',poffense,0) <> '' => 'Y',
							 
							 REGEXFIND('W[/]?I[NTENT]? [TO ]?[/]?KILL|W[/]?I TO KILL',poffense,0) <> '' and
							 REGEXFIND('PISTOL'  									 ,poffense,0) <> '' => 'Y',
							 
               REGEXFIND('MUR'                       ,poffense,0) <> '' and
	             REGEXFIND('CAP|COM|CRIM|INTENT'       ,poffense,0) <> '' and
							 REGEXFIND('DEAD'                      ,poffense,0) <> '' => 'Y',

               REGEXFIND('MANSL|MNSLAU'              ,poffense,0) <> '' and
							 REGEXFIND('DEAD'                      ,poffense,0) <> '' => 'Y',

               REGEXFIND('MUR'                       ,poffense,0) <> '' and
	             REGEXFIND('ATT|CRIM|PREMED|PREM|DEG|CAP|AGG|COM|FEL'       ,poffense,0) <> '' and
							 REGEXFIND('MURDOCK|MURPHY|MURROW|MURRAY'                   ,poffense,0) = '' => 'Y',
							 
							 //Roger's comment
               // REGEXFIND('DEADLY'                    ,poffense,0) <> '' OR
               // (REGEXFIND('DEADLY'                    ,poffense,0) <> '' AND
							  // REGEXFIND('ASSAULT A DEALDLY|ATTEMPTED|KNIFE|SMUGGLE',poffense,0) = '' ) OR
							 //Roger's comment QA Update - Homicide Round 4 9/23/16
	             // (REGEXFIND('DEAD'  ,poffense,0) <> '' and REGEXFIND('CONDUCT'  ,poffense,0) <> '') => 'Y',
	             REGEXFIND('KILL[ |I]'  ,poffense,0) <> '' and 
							 REGEXFIND('STAB[ |B]'  ,poffense,0) <> '' => 'Y',
							 
							 REGEXFIND('CHILD'      ,poffense,0) <> '' and
	             REGEXFIND('KILL'       ,poffense,0) <> '' and
							 REGEXFIND('UNBORN'     ,poffense,0) <> '' => 'Y',
							 
							 REGEXFIND('DEATH'      ,poffense,0) <> '' and
	             (REGEXFIND('BY'        ,poffense,0) <> '' or 
							  (REGEXFIND('CRIM'     ,poffense,0) <> '' and REGEXFIND('OPER' ,poffense,0) <> '')
							 )	 and
							 REGEXFIND('VE[C]*H'       ,poffense,0) <> '' => 'Y',
							 
							 REGEXFIND('POISON'        ,poffense,0) <> '' and
							 REGEXFIND('INTENT'        ,poffense,0) <> '' and 
							 REGEXFIND('INTENT TO DIST',poffense,0) = '' => 'Y',
							 
	             REGEXFIND('MURD'       ,poffense,0) <> '' and
	             REGEXFIND('MURDOCK'    ,poffense,0) = '' and
							 REGEXFIND(Homicide_exc ,poffense,0) = '' => 'Y',
							 
	             REGEXFIND('SHOOT[ING ]+' 						              ,poffense,0) <> '' and //VC 20170519 email
	             REGEXFIND('MALIC[IOUS ]+' 									        ,poffense,0) <> '' and
	             REGEXFIND(Homicide_exc,poffense,0) = '' => 'Y',

							 //QA Update - Homicide/Weapons round 6
	             REGEXFIND('FIRE|FIRING|PROPULSION|PROPEL' 						,poffense,0) <> '' and
	             REGEXFIND('MISSIL[E]?[S]?|MILLILES' 									,poffense,0) <> '' and
	             REGEXFIND('VEH[ICLE]?[S]?|DWELL|BUILD[ING]?|AIRCRAFT',poffense,0) <> '' and
	             REGEXFIND(Homicide_exc,poffense,0) = '' => 'Y',
							 
               REGEXFIND('DSCHG' 						                        ,poffense,0) <> '' and
	             REGEXFIND(' F/A |FIREARM|WEAPON|WEAP|WPN ' 					,poffense,0) <> '' and
	             REGEXFIND('BUILDING|BLDG| BLD |DWELL'                ,poffense,0) <> '' => 'Y', 

	             REGEXFIND(Homicide1 ,poffense,0) <> '' and
	             (REGEXFIND(Homicide_exc ,poffense,0) = '' 
								) => 'Y',

	             REGEXFIND(Homicide2a ,poffense,0) <> '' and
							 REGEXFIND(Homicide2b ,poffense,0) <> '' and 
							 (REGEXFIND(Homicide_exc ,poffense,0) = '' AND
							  ~(REGEXFIND('ALCOH|DRUG|NARC' ,poffense,0) <> '' AND REGEXFIND('VE[C]*H|[/\\. ]M[/]*V[/\\.]|AUTO|INFLU' ,poffense,0) <> '')
								)=> 'Y',

							 'N');
return Is_it;
end;

//--------------------------------------------------------------------------------------------------------------------------------------

export Is_DrivingUndertheInfluence(string poffense_in) := function


special_characters    := '~|=|!|-|\\^|\\+|:|\\(|\\)|,|;|_|#|\\*|<|>|"|`|\\[|]|\\{|\\}|\\\\|\\\'';
poffense        := ' '+REGEXREPLACE(special_characters, poffense_in, ' ');

DrivingUndertheInfluence :=    'DRIV(.*)UND(.*) INFL|[ ]DUI[0-9&]+[ ]*|D[U]I[/\\. ]|OPERATING W[/ ]+PAC|OPERATING WITH PAC|OPER VEH WH INT [(]OWI[)]|' +
                               'DRIV/OPR/W/UND/INFLUENCE|DRIVING/U/INFLUENCE|DRIV/U/INFLU|DRIVE/INFLUENCE|DRIVING W/U THE INFLUENCE|DRIVE WHILE UN INFLUENCE|'+
                               //Roger's comment QA Update - Traffic Round 4
                               'DRIVE U/THE|DRIVE UINDER INFLU|DRIVING [WHIL ]*[UMDER ]*[THE ]*INFLU|DRIVING INFLU|DRIV\\. .* INFLUENCE|' +
															 'BOATING UND/INFLU|DRIV[E]*[ING]* U[/]I|DRIV[E]*[ING]* UTI|' +
                               '[ ]DWUIL[/ ]|[ ][0O][\\.]*V[\\.]*I[\\./ ]| OMVI[/\\. ]|MV UNDER INFL ALC|'+
                               '[/ \\.]DWAI| D\\.[U]\\.I|[/ ]D[/ \\.]*U[/ \\.]*I[I/\\. ]*[/ ]+| D[ ][U][ ]I |'+
															 '^[ ]*BUI[/ ]|DR(.*)V[I]*NG WHILE INTOX| D W I[0-9]|^ BREATH[/ ]|BREATHAL[IYERZ]+|BLOOD/BREATH|'+
															 'BLOOD[- ]+[\\.][0-9]+| W[/]*[\\. ]08[%]| W[/][\\. ]08[% ]|BLOOD SERUM|BLOOD ALCOHOL|[ ]*B[/\\.]*A[/\\.]*C[/\\.0-9 ]+|[ ]DUI[ ]|'+
															 '[\\.][810]+[%]BAC[&/ ]|[ ]APC[/ ]|[ ]A[\\.]P[\\.]C[\\. ]|[/\\.0-9 ]APC[VIMUF]* |'+
															 '316\\.193\\.1|316\\.193\\.1A| OMVUAC | O M V I |[/ \\.]DUIL[/ \\.]|[/ \\.]DUID[/ \\.]';
dwi                      := 	 '[ ]D[ ][UW][ ]I[ ]|^[ ]DWI[/ ]| D\\.[UW]\\.I|[/ ]D[/ \\.]*W[/ \\.]*I[/ \\.]*[)/ ]|D[W]I[/\\. ]|'+
                               'VC 23152 [AB] |VC 23153 [AB] |VC 23222 [AB] |VC 21200\\.5|VC 23140 [A] ';	

                                             
Dwiexc_list	             :=  'AWDWI|BALDWIN|DWIPER|HARDWIRE|SANDWICH|BOARDWITH|DWIGHT|CHADWICK|GOODWIN|GOODWILL|EDWIN|BANDWID|TO[B]+AC|TA[B]+AC|TOPBAC';															 
// DUIexc_list	             :=  'TO[B]+AC|TA[B]+AC|TOPBAC';														 
DUIexc_list	             :=  'TO[B]+AC|TA[B]+AC|TOPBAC';														 
															 
Is_it := MAP(In_Global_Exclude(poffense,'other')='Y' => 'N',
             // trim(poffense_in) in _fmod_offense_category_list.DUIList =>'Y',
             REGEXFIND('BREATH'                ,poffense,0) <> '' and
             REGEXFIND(' DRUI |CONCENTRAT| PRELIM| O[VP]ER[\\./ ]| RTS | FTS |REF[ED]+ | REFED | RE[FS]+[UALSEFG]* | REUSE[D]*| RFSE |O[M]*VUAC| FAIL[/]| FAIL[LURED]* | TEST | RESULT[S]* | ALC[H]* |ALCO[HOL]* |SAMPLE|[ ][\\.][0-9]{2}[0-9 ]* | [0]*[\\.][ ]*1[0-9][% ]| PAC |[/ ]REFUS|[/ ]REF[/\\. ]'        ,poffense,0) <> '' => 'Y',

             REGEXFIND('ALCO'                  ,poffense,0) <> '' and
						 REGEXFIND('MORE|GREATER'          ,poffense,0) <> '' and
             REGEXFIND(' OR | OF |THAN'        ,poffense,0) <> '' => 'Y',
						                                                         //check later   
						 REGEXFIND('[/ ]DR[\\.V ]|DRI[BCING]*[/ ]|DR[OI]V| DR[VING]* |DR[UV]+ING |[/ ]OP[\\.V ]|[/\\. ][O]+P[E]*R[RATINGEOD]*[/\\. ]|OPER[SA]T[IONG]+'    ,poffense,0) <> '' and
						 REGEXFIND('WHILE|VE[C]*H|MOTOR'                              ,poffense,0) <> '' and
             REGEXFIND('[/\\. ]INTX[/\\. ]|INTOX|DRUG|[/\\. ]LIQ[/\\. ]|[/\\. ]OWI[/\\. ]'    ,poffense,0) <> '' => 'Y',
						 
  					 REGEXFIND('C[O]*NSUMP'             ,poffense,0) <> '' and
						 REGEXFIND('VE[C]*H|MOTOR'              ,poffense,0) <> '' and
             REGEXFIND('INTOX|DRUG|[/\\. ]LIQ[/\\. ]'    ,poffense,0) <> '' => 'Y',
 
             REGEXFIND('DRK'                   ,poffense,0) <> '' and
						 REGEXFIND('[/\\. ]IN[/\\. ]|[/ ]OP[\\.V ]|[/\\. ][O]+P[E]*R[RATINGEOD]*[/\\. ]|OPER[SA]T[IONG]+'             ,poffense,0) <> '' and
             REGEXFIND('VE[C]*H|[/\\. ]MV[/\\. ]'              ,poffense,0) <> '' => 'Y',

             REGEXFIND('CONTROL'               ,poffense,0) <> '' and
						 REGEXFIND('MOTOR |[/\\. ]MTR[/\\. ]'          ,poffense,0) <> '' and
						 REGEXFIND('VE[C]*H'               ,poffense,0) <> '' and
             REGEXFIND('INTOX'                 ,poffense,0) <> '' => 'Y',						 

             REGEXFIND('ACTU[R]*A[LT]|[/\\. ]ACT[UAL]*[/\\. ]'             ,poffense,0) <> '' and
						 REGEXFIND('PH[UYISLC]+CIAL|PH[UYISLC]+[SC]AL|PHYS|[/\\. ]PHY[/\\. ]|VE[C]*H|[ ]M[/]*V[ ]'  ,poffense,0) <> '' and
             REGEXFIND('CONTROL|[/\\. ]CTR[/\\. ]|C[N]*TRL|CONT[/ ]'                 ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('PH[UY]SICAL|[/\\. ]PHY[SICAL]*[/\\. ]'     ,poffense,0) <> '' and
						 REGEXFIND('ALCOHOL CONTENT|ALCOHOL OVER|VE[C]*H|[ ]M[/]*V[ ]| CMV |[/\\. ]U/INFLU[ENCE ]+|IONFLU|IF[NLF]+UENCE|[I]*N[DCLF]+UENCE|I[ ]*N[LVF]+LU|INFL |[/ ]INF[L]*[/ ]'  ,poffense,0) <> '' and
             REGEXFIND('CONTROL|[/\\. ]CTR[/\\. ]|CNTRL|CONT[/ ]'                 ,poffense,0) <> '' => 'Y',						 
             
						 REGEXFIND('PHYSICAL CONTROL'     ,poffense,0) <> '' and
             REGEXFIND('ALCOHOL|INTOX|BREATH'                 ,poffense,0) <> '' => 'Y',						 
      

             REGEXFIND('BOD'                         ,poffense,0) <> '' and
						 REGEXFIND('INJU[RY ]+'                  ,poffense,0) <> '' and
						 REGEXFIND('DRI[VE ]|[/ ]OP[\\.V ]|[/\\. ][O]+P[E]*R[RATINGEOD]*[/\\. ]|OPER[SA]T[IONG]+'          ,poffense,0) <> '' and
             REGEXFIND('UNDER|U/INF'           ,poffense,0) <> '' => 'Y',      
						 
						 REGEXFIND(' BA[/ ]| W[/]' ,poffense,0) <> '' and
             REGEXFIND('[\\.]08[%]|[ ][/\\.]08[/% ]|[ ][\\.][ ]*10[% ]',poffense,0) <> '' => 'Y',

             REGEXFIND('BAC[O]*[/ ]' ,poffense,0) <> '' and
             REGEXFIND('[\\.]08[%]|[ ][/\\.][ ]*08[% ]|[\\.]10[%]|[\\.][ ]*10[%]|[ ][/\\.][ ]*10[% ]|[ ][0][\\.][ ]*08[% ]|[ ][0][\\.][ ]*10[% ]' ,poffense,0) <> '' and
						 REGEXFIND('TOBAC' ,poffense,0) = '' => 'Y',
						 
						 REGEXFIND('REFUSE'                ,poffense,0) <> '' and
             REGEXFIND('TEST'                  ,poffense,0) <> '' => 'Y',
						 
             REGEXFIND('DWLS'                  ,poffense,0) <> '' and
             REGEXFIND('[/\\. ]DUI[/\\. ]|[/\\. ]DWI[/\\. ]'             ,poffense,0) <> '' => 'Y', 
						 
						 REGEXFIND('DRUG'                  ,poffense,0) <> '' and
						 REGEXFIND('VE[C]*H|[ ]M[/]*V[ ]|BOAT' ,poffense,0) <>  '' and
						 REGEXFIND(' OP |[/\\. ]APC[/\\. ]',poffense,0) <> ''=> 'Y', 
						 
						 //loose expression
						 REGEXFIND('[/ ]SKI[ING]*[/ ]|[/ ]DR[\\.V ]|DRI[BCING]*[/ ]|DR[OI]V| DR[VING]* |DR[UV]+ING |[/\\. ]DRIVE[/\\. ]|[/\\. ][O]+P[E]*R[RATINGEOD]*[/\\. ]|OPER[SA]T[IONG]+|BOAT|[/\\. ]OP[/\\. ]|OPERMOTOR' ,poffense,0) <>  '' and
						 REGEXFIND('UNDER(.*)INF|ALC[OHOL]*|WHILE(.*) INF(.*)[ ]*ALCOH|WHILE(.*) IMPAIRED(.*)[ ]*|WHILE LIQ[/\\. ]|INTOX|DR[IU]NK',poffense,0) <>  '' and
						 REGEXFIND('FIREA[R]*M|VISIBLY|LICENSE REVOKED'                                                  ,poffense,0) = ''=> 'Y', 

						 // Roger's comment - QA Updates Traffic
						 // Mis-spelling 
						 REGEXFIND('DRIVING |DRIV/|DRIV\\.|DRIV |DROVE |OPER VESSEL'                                     ,poffense,0) <>  '' and
						 REGEXFIND('UDNER |U/|UNDR|UNDER21|UNER |UNTER |DURING '																				 ,poffense,0) <>  '' and
						 REGEXFIND('INFLUENCE'                                                  												 ,poffense,0) <>  '' => 'Y', 
 						                               
						 // REGEXFIND('[/ ]SKI[ING]*[/ ]|VEH[ICLE]* |ACCIDENT|[/ ]DR[\\.V ]|DRI[BCING]*[/ ]| DR[OI]V| DR[VING]* |DR[UV]+ING |[/\\. ]OP[/\\. ]|[/\\. ]OP[E]*R[RATINGEOD]*[/\\. ]|OPER[SA]T[IONG]+'                             ,poffense,0) <>  '' and
						 // REGEXFIND('IMPAIRED|WHILEOPER|CONSUME|UND[E]*R [UI][N]*FLU|UNDER(.*)INF|WHILE(.*) INF(.*)|WHILE UNDER|[/ ]W[/]U[/]I[/ ]| INF LIQ| UN[DR]*[THE ]*INF[LUENCE]* |[/\\. ]U/INFLU[ENCE ]+|IONFLU|IF[NLF]+UENCE|[I]*N[DCLF]+UENCE|I[ ]*N[LVF]+LU|INFL |[/ ]INF[L]*[/ ]'    ,poffense,0) <>  '' and
						 // REGEXFIND('DRUG|ALCOH| ALC[H]*L | ALC[OHOL]* |LIQ|NARC'                                         ,poffense,0) <>  '' and
						 // REGEXFIND('FIREARM|VISIBLY|LICENSE REVOKED|CONTROLLED'                                                     ,poffense,0) = ''=> 'Y', 

						 REGEXFIND('OPEN CONT'            ,poffense,0) <> '' and
						 REGEXFIND('D[/\\.]*U[/\\.]*I[/\\.]*|D[/ \\.]*W[/ \\.]*I[/ \\.]*|D [WU] I|DRIV(.*)UND(.*) INFL(.*)|DRIV(.*)INTOX'  ,poffense,0) <> '' => 'Y',

						 REGEXFIND('DUI DRIV[EING]+'             ,poffense,0) <> '' and
						 REGEXFIND('WHILE'                       ,poffense,0) <> '' and
						 REGEXFIND('UNSER|UNJDER|INDER|UINDER'   ,poffense,0) <> '' and
						 REGEXFIND('INFLU[E]*NCE|INFLUNC|INFLU'  ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('REFUSAL'                     ,poffense,0) <> '' and
						 REGEXFIND('SUBMIT'                      ,poffense,0) <> '' and
						 REGEXFIND('TEST'                        ,poffense,0) <> '' => 'Y',
						 
             REGEXFIND(DrivingUndertheInfluence ,poffense,0) <> '' AND
						 REGEXFIND(DUIexc_list ,poffense,0)              =  '' => 'Y',	    
						 
						 REGEXFIND(dwi ,poffense,0) <> '' AND
						 REGEXFIND(Dwiexc_list ,poffense,0)              =  '' => 'Y',
							 'N');



return Is_it;
end;

//--------------------------------------------------------------------------------------------------------------------------------------

export Is_Assault_aggr(string poffense_in) := function

special_characters    := '~|!|-|%|\\^|\\+|:|\\(|\\)|,|;|_|#|%|\\*|<|>|"|`|\\[|]|\\{|\\}|\\\\|\\\'';
poffense        := ' '+REGEXREPLACE(special_characters, poffense_in, ' ');

Assault         := 'AA/DW|AGG/ASS|ABDGR|ABGEN|ABOFF|ABHAN|ABWIK|ABWITK|STRANGUL|AWDW|STRANGLE|784\\.03\\.1A2|784\\.03\\.1A1|AA[/]DW[/]FV|AA[/]DW/|AA[/]SBI[/]DW[/]FV|784.021.1A|DDLY CONDUCT|'+
                   'PC 243 [BD] |PC 245 [AC] ';
Assault2        := 'A[\\.& ]+B[\\. ]+H[ \\.&]+A[\\. ]+N[\\. ]*|A[\\. ]+B[\\. ]+W[ \\.]+I[\\. ]+K[\\. ]*|A[\\. ]+B[\\. ]+W[\\. ]+I[\\. ]+T[\\. ]+K[\\. ]*';								 
Assault3        := 'ASS[LAN]+UTL|ASSL|AS[SL]*AU[LK]*T|AS[S]+ULT |AS[S]+AULT| A[/]B |'+
                   'ASSA|AS[S]+U|ASST|ASSLT|ASLT|AS[S]*AULT|ASSAT|[/\\. ]AS[L][/\\. ]|ABDOM|ABGEN|ABOFF|BATTER|PHYS[ICAL\\.]+ HARM|SS[A]*U[A]*[/0-9\\. ]|ASSLT|[/0-9\\. ]ASLT[/0-9 ]|ASSAT |'+
									 'ABDOM|ABGEN|ABOFF|BATTER|PHYS[ICAL\\.]+ HARM|[ |^|\\.|/]A[ ]*&[ ]*B[ |\\.|$|/]';

Battery         := '^[ ]*BATT[GERY/ ]+|BATTER| BAT |^[ ]*BAT | BAT$|DOM[\\.MESTIC ]+VIO|[D]*OMESTI(.*) VIO|[/\\. ]BTRY[/\\. ]|[\\. ]ABUS[\\. ]| A[ ]*&[ ]*B|MENACING';

//Roger's comment 7/6 QA Updates for  Assault - Aggravated 
aggravated      := 'AGG|AGGR[\\.]|AG[G]+R|AG[G]+RA[CV]ATED|AGGAVAT|AGG[TGV] |AGGVA|[/\\. ]FEL[/\\. ]|FELONY|FELONI[O]*US|DDLY[/ ]CONDUCT|' +
                   'DANGEROUS W|[/\\. ]W/DE[/\\. ]|INTEN[T]*[\\.]* [TO ]*KILL|[^| ]WEAP| WPN|WEPON|MURD|ACT OF VIOLENCE|'+
									 'W[/]*I[NT]*[EN]*[T]* [TO ]*KILL|INTENT T/KILL|PISTOL[ |$]';                                                 
assault_exc     := 'SEX|RAPE|MOLEST|PORN|FOWL|[\\-|\\.|\\(| ]GAME|PETS|LIVESTOCK|NOISE|GOOSE|FRUIT|ELECTRICAL|HIGHWAY|TELEPHONE|SHELTER|ROSTER';                     										                                                                                                                      
                    										                                                                                                                      
assault_exc1    := 'AGG. CHILD ABUSE|AGGRAVATED CHILD ABUSE|CHILD [ABUSE.]*ENDANGER|ENDANGERMENT/CHILD|ENDANGER[ING]* [A ]*CH[I]?LD';                    										                                                                                                                      
exc             := 'GOAT|PUP|ROBB| PET |PONY|CHOW |TORTIS|PIG|LLAMA|DUCK|FERRET|PARROT|CHIHUAHUAHOUND|SHEP|BIRDS|ROMULUS|KITTEN|ROTT[I]*|RO[T]+WEI|CANINE|LAB | TAB |L[I]*VST[OC]*K|NONLVST';									
	
aggravated_exc  := 'AGGRESSIVE|REVOC|SEX|KIDN|SODOMY|RAPE|PORN|MOLE|NO WPN';	
  
Terrorist_Threats  := 'TERRORIST|TERROR[ISTM]*|W[EA]*P[ON]* MASS DES[RUCT]+';
Terrorist_ecl      := 'HARM|FALSE INFO|FALSE REPORT';

// Roger's comment - Round 8 Assault Other 20161114 File
TT2a := 'EXPLOSIV|BOMB|WEAP[ON]*|WPN|WEPON|MURD| GUN[ |/|$]|FIRE[ ]?ARM|F/ARM| ARMED|DESTRUCTIVE DEVICE';
TT2b := 'TERR';

Is_it := MAP( In_Global_Exclude(poffense,'ASSAULT')='Y' => 'N',
														 
							 REGEXFIND('CRUELTY'        ,poffense,0) <> ''  and
							 REGEXFIND('HORSE|ANIM|ANAIMAL|ANIAL|ANML|A[IMN]I+[MN]+[AL]*|CATS|PIT[ ]*BULL'        ,poffense,0) <> ''=> 'N',
							 
               REGEXFIND('BURG|UNARM|ANIMAL|DOG'        ,poffense,0) <> '' => 'N', 

	             REGEXFIND('BATTER[YI]'        ,poffense,0) <> '' and 
	             REGEXFIND('COVER'             ,poffense,0) <> '' => 'N', 

							 //Roger's comment QA Update - Assault - Aggravated Round 4 9/23/16, 9/27/16
               REGEXFIND('REVOC' 																			,poffense,0) <> '' OR
						   (REGEXFIND('PROBAT', poffense,0) <> '' AND REGEXFIND('H[O]?LD|VIO[L]?', poffense,0) <> '') => 'N',
							 
        REGEXFIND('[\\. ]POSS[\\. ]|POSS[ESSION]+| CARRY' 																			,poffense,0) <> '' OR
						  REGEXFIND('ASSAULT WEAPON|ASSAULT FIREARM|ASLT WPN|INELEIGIBLE PERSON|CONVICTION|UNLAWFUL|PUBLIC PLACE', poffense,0) <> '' => 'N',
							 
	             REGEXFIND('DEAD|DEATH'  			 ,poffense,0) <> '' and
							 REGEXFIND('CONDUCT|THREAT'		 ,poffense,0) <> '' => 'Y',
				
							 REGEXFIND(' MOB | RIOT '  		 ,poffense,0) <> '' and
							 REGEXFIND('ACTION'		         ,poffense,0) <> '' => 'Y',
							 
	             REGEXFIND('THREAT|THRT'  		      ,poffense,0) <> '' and
							 REGEXFIND(TT2a  	 						      ,poffense,0) <> '' and 
							 REGEXFIND('FALSE REPORT|FALSE INFO|FALSE',poffense,0) =  '' => 'Y',
							 
							 REGEXFIND(aggravated_exc           ,poffense,0) <>  '' OR
							 REGEXFIND(assault_exc              ,poffense,0) <>  '' OR
							 REGEXFIND(exc                      ,poffense,0) <>  '' => 'N',	


							 //Roger's comment 8/26 QA Updates for  Assault - Aggravated Round 3
						   REGEXFIND('CH[I]?LD'                           ,poffense,0) <> '' and
               REGEXFIND('ENDANGERMENT|ENDANGERING|ENDANGER ' ,poffense,0) <> '' and
							 REGEXFIND('AGG[\\.]? |AGG ASSLT|AGGRAVATED'		,poffense,0) = '' => 'N',
							 
							 REGEXFIND('RECKLESS|RECK |1ST DEGREE' ,poffense,0) <> '' and
							 REGEXFIND('ENDANGER'		,poffense,0) <> '' => 'Y',
 							 
							 //Roger's comment 7/6 QA Updates for  Assault - Aggravated
							 //Remove to exclude expressions like CARRYING A CONCEALED DANGEROUS WEAPON/MA 1
						   // REGEXFIND('[/\\. ]D[A]?NG[EROUS]*[/\\. ]|DEADLY'         ,poffense,0) <> '' and

               REGEXFIND('[/\\. ]WEAP|[/\\. ]WPN[/\\. ]|GUN[ |$]|KNIFE'  ,poffense,0) <> '' and		
               REGEXFIND('A[ ]*[\\&|/|AND][ ]*B|AS[S]*[A]*[U]*[L]*T[/|\\.|\\&| ]|AS[S]*LT |[ |'+
							           '^]ASSA |AGG[RAVATED]* ASS|AGG [AALT|ALST]|SAULT |ASSAUTL |ASSUALT[\\/| ]'+
												 '| ASS[\\.|\\/]? '                               ,poffense,0) <> '' and
							 REGEXFIND('BRASS|[CG]LASS| A BUS|TRESPASS'					  		 ,poffense,0) =  '' => 'Y',		
							 							 
							 REGEXFIND(aggravated  ,poffense,0) <> '' and
							 REGEXFIND('CH[I]*LD|M[IO]NOR|JUV'                                                          ,poffense,0) <> '' and 
	             REGEXFIND('[/\\. ]ABU[/\\. ]|[/\\. ]AB[/\\. ]|[/\\. ]ABUVE|RECK DRVG|[/\\. ]IA[/\\. ]|[/\\. ]CHLDB[/\\. ]|[/\\. ]A7B[/\\. ]|[/\\. ]ABS[/\\. ]',poffense,0) <> '' and
	             REGEXFIND(aggravated_exc                                                                   ,poffense,0) =  '' => 'Y',
							 
							 REGEXFIND(aggravated  ,poffense,0) <> '' and
							 REGEXFIND('CH[I]*LD|M[IO]NOR|JUV'                                                          ,poffense,0) <> '' and 
	             REGEXFIND('INJ'                                                      ,poffense,0) <> '' => 'Y',
							 
							 REGEXFIND('[/\\. ]HIV[/\\. ]' ,poffense,0) <> '' and
               REGEXFIND('TRANS|EXPO|INFECT|CONDUCT|RISK|[/\\. ]TRNS[/\\. ]|ENGAG|TEST|[/\\. ]EXP[/\\. ]|[/\\. ]CAUS[/\\. ]|HARM|VIO|KNOW|INFC|UNLAW|ANOTHER|DONAT|DISCLOS',poffense,0) <> '' => 'Y',						 
								
							 //***terrorist threat
							 REGEXFIND(aggravated     ,poffense,0) <> '' and
							 REGEXFIND(TT2a           ,poffense,0) <> '' and
               REGEXFIND(TT2b           ,poffense,0) <> '' and 
							 REGEXFIND('FALSE REPORT|FALSE INFO|FALSE',poffense,0) =  '' => 'Y',	                     
             
						   REGEXFIND(aggravated        ,poffense,0) <> '' and
						   REGEXFIND(Terrorist_Threats ,poffense,0) <> '' and
						   REGEXFIND(Terrorist_ecl     ,poffense,0) = '' => 'Y',	
						   //***End terrorist threat
							 
							 REGEXFIND('PLAC|PLCING|PLCE|TRANS|CONT|PROPEL|INGEST',poffense,0) <> '' and   
							 REGEXFIND('BODILY|BODY|BOD'                          ,poffense,0) <> '' and   
							 REGEXFIND('FLUID'                                    ,poffense,0) <> '' =>'Y',
							 
							 REGEXFIND('VIRUS'             ,poffense,0) <> '' and 
	             REGEXFIND('TRANS|EXPOS'       ,poffense,0) <> '' => 'Y',
							 
							 REGEXFIND(aggravated          ,poffense,0) <> '' and
							 REGEXFIND('DOM'               ,poffense,0) <> '' and 
	             REGEXFIND('A/B '              ,poffense,0) <> '' => 'Y',
							 
							 REGEXFIND(aggravated          ,poffense,0) <> '' and
							 REGEXFIND('BOD'               ,poffense,0) <> '' and 
	             REGEXFIND('INJU'              ,poffense,0) <> '' and
							 Is_DrivingUndertheInfluence(poffense)='N'        and
							 Is_Robbery_res(poffense)='N'       							and 
							 Is_Robbery_comm(poffense)='N'=> 'Y',
							 
							 REGEXFIND(aggravated          ,poffense,0) <> '' and
							 REGEXFIND('BATT'              ,poffense,0) <> '' and
							~(REGEXFIND('BATTLE|COVER|STORAGE|DISPOS|BATTON|BATTS',poffense,0) <> '' OR
							   (REGEXFIND('SHELT' ,poffense,0) <> '' and REGEXFIND('BATTERED',poffense,0) <> '' ) 
								)=> 'Y',
							 
               Is_homicide(poffense) ='N' AND							 
							 REGEXFIND('POISON'            ,poffense,0) <> '' AND   
							 REGEXFIND('PET|ANI(MA)*(\\.)* |ANIMAL|REPT|SNAKE|SN |CAT|CONTROLLED SUBSTANCES',poffense,0) = '' => 'Y',
  
               REGEXFIND('POISON'            ,poffense,0) <> '' AND   
							 REGEXFIND('LIQUOR|FOOD|WATER|ATTEMPT|MEDICINE| WELL[S]* ',poffense,0) <> '' => 'Y',

							 REGEXFIND('ARMED'             ,poffense,0) <> '' and 
	             REGEXFIND('VIO'               ,poffense,0) <> '' => 'Y',
							 
							 REGEXFIND('HATE'              ,poffense,0) <> '' and 
	             REGEXFIND('CRIM'              ,poffense,0) <> '' => 'Y',

							 REGEXFIND(aggravated                  ,poffense,0) <> '' and   
               REGEXFIND('STALK|MENAC|THREAT|TREATEN',poffense,0) <> '' and 
	             REGEXFIND(aggravated_exc              ,poffense,0) =  '' => 'Y', 
							 
							 
							 REGEXFIND(Assault3            ,poffense,0) <> '' and 
							 REGEXFIND(aggravated          ,poffense,0) <> '' and
							 ((REGEXFIND('DRIVE' ,poffense,0) <> '' AND REGEXFIND('UNDER' ,poffense,0) <> '' and REGEXFIND('INFL',poffense,0) <> '' ) OR
							   REGEXFIND('[ ]D[\\. ]U[\\. ]I[\\. ]|^[ ]*D[\\. ]U[\\. ]I[\\. ]' ,poffense,0) <> '' 
							  )=> 'Y',			

							 REGEXFIND(aggravated                     ,poffense,0) <> '' and							 						 
							 REGEXFIND('PAIN'                         ,poffense,0) <> '' and 
							 REGEXFIND('INDUC|CAUS|INFLICT|CRUEL'     ,poffense,0) <> '' and 
	             REGEXFIND('PAINT|CHAMPAIN|SPAIN|ANIM|DOG',poffense,0) = '' => 'Y',			

							 REGEXFIND(aggravated               ,poffense,0) <> '' and 
							 REGEXFIND('VE[C]*H'                    ,poffense,0) <> '' and 
               REGEXFIND(Assault3+'|INJURY'       ,poffense,0) <> '' 
							 => 'Y',							 
							 
							 REGEXFIND(Battery                  ,poffense,0) <> '' and
							 REGEXFIND(aggravated               ,poffense,0) <> '' => 'Y',		
							 
							 REGEXFIND(aggravated               ,poffense,0) <> '' and
      	       REGEXFIND(Battery                  ,poffense,0) <> '' and 
	             REGEXFIND('POL|PERSON|CH[I]*LD|DOM|L[/]*E[/]*O|L[\\.]E[\\.]' ,poffense,0) <> '' and
							 REGEXFIND('SEX'                    ,poffense,0) = '' => 'Y', 
							                                                                                                              
               REGEXFIND(aggravated                ,poffense,0) <> '' and               
							 REGEXFIND('ABUSE|[/\\. ]ABUS[/\\. ]',poffense,0) <> '' and 
               REGEXFIND('PERSON|ADULT|[/\\. ]ELD[ERLY]*[/\\. ]|[/\\. ]DIS[ABLED]*[/\\. ]'                  ,poffense,0) <> '' and 
               REGEXFIND('SEX|CARD'                ,poffense,0) =  '' => 'Y',
                                                                                                            
               REGEXFIND(aggravated                ,poffense,0) <> '' and                
							 REGEXFIND('ABUSE|[/\\. ]ABUS[/\\. ]',poffense,0) <> '' and 
               REGEXFIND('PATIENT|RESIDENT|ELDER|NEGL|CARETAKER|CARTAKER|CH[I]*L[D]*|DISABL|IMPAIR|VULNERABLE',poffense,0) <> '' and
							 //new ***
							 // assault_exc1    := 'AGG. CHILD ABUSE|AGGRAVATED CHILD ABUSE|CHILD [ABUSE.]*ENDANGER|ENDANGERMENT/CHILD|ENDANGER[ING]* [A ]*CH[I]?LD';                    										                                                                                                                      
							 // AGG. CHILD ABUSE/CHILD ENDANGERMENT.                                       
							 // AGGRAVATED CHILD ABUSE/ CHILD ENDANGERMENT                                 
	             // REGEXFIND(assault_exc1    ,poffense,0) = '' and 
               REGEXFIND('SEX|CARD'               ,poffense,0) =  '' => 'Y',

							 //QA Update - Assault Aggravated Round 6
							 REGEXFIND('MALICIOUS[LY]*[LEY]*[ |/]WOUND|UNLAWFUL WOUNDING|AGGRAVATED MAL WOUND|WOUNDIN[/]UNLAW|UNLAW\\.WOUND[ING\\.]+',poffense,0) <> '' => 'Y',
							 
							 REGEXFIND(aggravated     ,poffense,0) <> '' and 
	             REGEXFIND(Battery        ,poffense,0) <> ''  and 
	             REGEXFIND(aggravated_exc ,poffense,0) =  '' and 
							 REGEXFIND(exc            ,poffense,0) =  ''  => 'Y',
							 
               REGEXFIND(aggravated     ,poffense,0) <> '' and 
	             REGEXFIND(Assault3       ,poffense,0) <> '' and 
	             REGEXFIND(aggravated_exc ,poffense,0) =  '' and 
							 REGEXFIND(exc            ,poffense,0) =  '' => 'Y',	               
	
	             REGEXFIND(Assault        ,poffense,0) <> '' and 
	             REGEXFIND(assault_exc    ,poffense,0) = '' and 
	             // REGEXFIND(assault_exc1    ,poffense,0) = '' and 
							 REGEXFIND(exc            ,poffense,0) =  ''   => 'Y',
							 
							 REGEXFIND(Assault2       ,poffense,0) <> ''and 
	             REGEXFIND(assault_exc    ,poffense,0) = '' and 
	             // REGEXFIND(assault_exc1    ,poffense,0) = '' and 
							 REGEXFIND(exc            ,poffense,0) =  ''   => 'Y',
							 
							(REGEXFIND(Battery        ,poffense,0) <> ''   or
							 REGEXFIND(Assault3       ,poffense,0) <> ''   or
							 REGEXFIND(Assault2       ,poffense,0) <> ''   or
							 REGEXFIND(Assault        ,poffense,0) <> '' ) and 
							 REGEXFIND('FLUID|FIREARM',poffense,0) <> '' => 'Y', 
							   
							 'N');
return Is_it;
end;
//--------------------------------------------------------------------------------------------------------------------------------------

export Is_Assault_other(string poffense_in) := function

special_characters    := '~|!|-|%|\\^|\\+|:|\\(|\\)|,|;|_|#|%|\\*|<|>|"|`|\\[|]|\\{|\\}|\\\\|\\\'';
poffense        := ' '+REGEXREPLACE(special_characters, poffense_in, ' ');

Assault         := 'SIMP BAT|ASS[AU]+L[T]*|AS[SL]*LT|CRUELTY|[D]*OMESTI(.*) ABUSE|INTIMIDAT|RETALIATION|STRIKING  PERSON|243(E)(1)PC|ACT IN AGGRESSIVE MANOR';
Assault2        := '^[ ]*A[\\.& ]+B[\\.]* |^[ ]*A AND B |[ |^|\\.|/]A[ ]*&[ ]*B[ |\\.|$|/]|A[ ]*&[ ]*B$|'+
                   ' PC 242 | PC 422 |PC 653M A | PC 240 |PC 646\\.9 A |PC 273\\.5 A |PC 243 [CE] | PC 273D |PC 368 C |PC 368 B  1| 2919\\.25 ';

Assault3        := 'ASSAUOLT|ASS[LAN]+UTL|ASSAUTING|ASSLAT|ASSLA[UL]+T|ASSAI[ ]T|ASSAILT |ASSA[OS]*U[I]*[KL]T |ASSAUSLT|AS[SL]*AU[LK]*T|ASSAUST |AS[S]+ULT |ASSAUT[L]*|AS[S]+AULT|ASSAU[/0-9\\.]|'+
                   '[/0-9\\. ]ASSL[/0-9\\. ]|[/0-9\\. ]ASSA[/0-9\\. ]|[/0-9\\. ]ASS[A]*U[A]*[/0-9\\. ]|ASSLT|[/0-9\\. ]ASLT[/0-9 ]|ASSAT |[/\\.]AS[L]+[/\\.]|'+
									 'ABDOM|ABGEN|ABOFF|BATTER|PHYS[ICAL\\.]+ HARM| A[&]B |^ A[/]B |[/\\. ]BTRY[/\\. ]';
                   // [/0-9 ]ASST[/0-9 ]|                                                     
                                                                                                                                                       
// Battery         := '^[ ]*BATT[GERY/ ]+|BATTER|BAT';
Battery         := '^[ ]*BATT[GERY/ ]+|BATTER| BAT |^[ ]*BAT | BAT$';
assault_exc     := 'SEX|RAPE|MOLEST|PORN|FOWL|GAME|PETS|LIVESTOCK|NOISE|GOOSE|FRUIT|ELECTRICAL|HIGHWAY|TELEPHONE|SHELTER|BOMB';
                     										                                                                                                                      
exc             :=  'GOAT|PUP|ROBB| PET |PONY|CHOW |TORTIS|PIG|LLAMA|DUCK|FERRET|PARROT|CHIHUAHUAHOUND|SHEP|BIRDS|ROMULUS|KITTEN|ROTT[I]*|RO[T]+WEI|CANINE| LAB | TAB |L[I]*VST[OC]*K|NONLVST';
										  
//aggravated      := 'AGG|AGGR[\\.]|AG[G]+R|AG[G]+RA[CV]ATED|AGGAVAT|AGG[TGV] |AGGVA|[/\\. ]FEL[/\\. ]|FELONY|FELONI[O]*US|DANGEROUS W|[/\\. ]W/DE[/\\. ]'; 
//Roger 7/6/16
//Please add  WEAP  and  WPN   and  WEPON and  MURD  to  “aggravated”.   The intent is to not select assault offenses containing these key words
aggravated      := 'AGG|AGGR[\\.]|AG[G]+R|AG[G]+RA[CV]ATED|AGGAVAT|AGG[TGV] |AGGVA|[/\\. ]FEL[/\\. ]|FELONY|FELONI[O]*US|DANGEROUS W|[/\\. ]W/DE[/\\. ]|MURD|WEAP|W[E]?P[O]?N/';                                                 

// aggravated_exc  :=  'AGGRESSIVE|PROBAT|REVOC|SEX|KIDN|SODOMY|RAPE|PORN|MOLE';		
// Roger's comment - Round 8 Assault Other 20161114 File
aggravated_exc  :=  'REVOC|SEX|KIDN|SODOMY|RAPE|PORN|MOLE|WEAP[ON]?|WPN|WEPON|MURD| GUN[ |/|$]|FIRE[ ]?ARM|F/ARM| ARMED|DESTRUCTIVE DEVICE';		

Terrorist_Threats  := 'TERRORIST|TERROR[ISTM]*|W[EA]*P[ON]* MASS DES[RUCT]+';
Terrorist_ecl      := 'HARM[ $/\\-]|FALSE INFO|FALSE REPORT';

TT2a               := 'EXPLOSIVES|BOMB';
TT2b               := 'TERR';
                                      

                                                                     
Is_it := MAP( In_Global_Exclude(poffense,'ASSAULT')='Y' => 'N',

               // trim(poffense_in) in _fmod_offense_category_list.AssaultOtherList =>'Y',
							 
							 REGEXFIND('CRUELTY'                                                 ,poffense,0) <> ''  and
							 REGEXFIND('HORSE|ANIM|ANAIMAL|ANIAL|ANML|A[IMN]I+[MN]+[AL]*|CATS|PIT[ ]*BULL'        ,poffense,0) <> ''=> 'N',

               REGEXFIND('PLAC|PLCING|PLCE|TRANS|CONT|PROPEL|INGEST',poffense,0) <> '' and   
							 REGEXFIND('BODILY|BODY|BOD'                          ,poffense,0) <> '' and   
							 REGEXFIND('FLUID'                                    ,poffense,0) <> '' =>'N',
							 
							 REGEXFIND('TERR THRT|TERR THREA|TERR ACTS'           ,poffense,0) <> '' =>'N',
							 							 
               // REGEXFIND(aggravated              ,poffense,0) <> '' => 'N',
							 REGEXFIND(aggravated_exc          ,poffense,0) <> '' OR
							 REGEXFIND(assault_exc          	 ,poffense,0) <> '' OR
							 REGEXFIND(exc          					 ,poffense,0) <> '' => 'N',

							 Is_Assault_aggr(poffense)='Y'												=> 'N',
							 
							 //Roger's comment - Update - Assault Other   Round 5 10/17/16 Added WITH INTENT TO KILL and HOMICIDE
               REGEXFIND('BURG|UNARM|ANIMAL|DOG| INTENT [TO ]*KILL|HOMICIDE' ,poffense,0) <> '' => 'N', 
							 //Roger's comment - Update - Assault Other   Round 6 
               REGEXFIND('WI TO KILL|W/I[NT]* [TO ]*KILL|W/INTENT T/KILL|PISTOL' ,poffense,0) <> '' => 'N', 

	             REGEXFIND('BATTER[YI]'            ,poffense,0) <> '' and 
	             REGEXFIND('COVER'                 ,poffense,0) <> '' => 'N', 
							 
 						   REGEXFIND(' DANG |DEADLY'         ,poffense,0) <> '' and
               REGEXFIND(' WEAP| WPN '           ,poffense,0) <> '' => 'N',								 

							 //Roger's comment - QA Update - Assault Other Round 3 8/26/16, Round 4 9/29/16, 10/5/16
							 REGEXFIND('ENDANGERMENT|ENDANGER[ING]|CRUELTY' ,poffense,0) <> '' and  
							 REGEXFIND('CHILD'            					,poffense,0) <> '' => 'N',
               REGEXFIND('REVOC' 																			,poffense,0) <> '' OR
						   (REGEXFIND('PROBAT', poffense,0) <> '' AND REGEXFIND('H[O]?LD|VIO[L]?|SANCTION', poffense,0) <> '') => 'N',
							 
							 //Roger's comment QA Update - Assault Other Round 4
							 //Roger's comment QA Update - Assault Other Round 5 10/17/16
							 //***terrorist threat
							 // REGEXFIND(TT2a                    ,poffense,0) <> '' and
               // REGEXFIND(TT2b                    ,poffense,0) <> '' => 'Y',	                     
               REGEXFIND('THREAT[EN]*'					 ,poffense,0) <> '' and 
	             REGEXFIND('BOMB|EXPLOSIV|SHOOT'   ,poffense,0) <> '' => 'N', 

							 //QA Update - Assault Other Round 6
						   REGEXFIND(Terrorist_Threats       ,poffense,0) <> '' and
							 REGEXFIND('INTENT TO HARM OTHER'  ,poffense,0) <> '' => 'N',
						   REGEXFIND('TERROR'     					 ,poffense,0) <> '' and
						   REGEXFIND('ACT'				           ,poffense,0) <> '' => 'N',	
							 
						   REGEXFIND(Terrorist_Threats       ,poffense,0) <> '' and
						   REGEXFIND(Terrorist_ecl           ,poffense,0) = '' => 'N',	
						   //***End terrorist threat

							 //Roger comments - Traffic 20161114 File Round 8
							 REGEXFIND('LEAVING [THE ]*SCENE|LEAVE [THE ]*SCENE' ,poffense,0) <> '' and
							 REGEXFIND(' CRASH| ACCIDENT'                        ,poffense,0) <> '' => 'N',
 							 
							 REGEXFIND('DOM'                   ,poffense,0) <> '' and 
	             REGEXFIND('A[/]B '                ,poffense,0) <> '' => 'Y',
							 
							 REGEXFIND('BOD'                   ,poffense,0) <> '' and 
	             REGEXFIND('INJU'                  ,poffense,0) <> '' and
							 Is_DrivingUndertheInfluence(poffense)='N'            and
							 Is_Robbery_res(poffense)             ='N'       			and 
							 Is_Robbery_comm(poffense)            ='N'       			=>'Y',
							 
							 REGEXFIND('BATT'                 ,poffense,0) <> '' and
							~(REGEXFIND('BATTLE|COVER|STORAGE|DISPOS|BATTON|BATTS',poffense,0) <> '' OR
							   (REGEXFIND('SHELT' ,poffense,0) <> '' and REGEXFIND('BATTERED',poffense,0) <> '' ) 
								)=> 'Y',
							 
							 REGEXFIND('SIM|U/S '             ,poffense,0) <> '' and 
							 REGEXFIND('BATT'                 ,poffense,0) <> '' => 'Y',	
							 
							 REGEXFIND('SIMPLE'               ,poffense,0) <> '' and 
	             (REGEXFIND(Assault3+'ASS[A]*UT'      ,poffense,0) <> '' or 
	              REGEXFIND(Battery               ,poffense,0) <> '' )=> 'Y',
							 
							 REGEXFIND('CHILD|MINOR|JUV'      ,poffense,0) <> '' and 
	             REGEXFIND('INJ'                  ,poffense,0) <> '' => 'Y',
							 
							 REGEXFIND('ASSA|ASSU|ASLT|ASSLT|BATT'      ,poffense,0) <> '' and 
							 ((REGEXFIND('DRIVE' ,poffense,0) <> '' AND REGEXFIND('UNDER' ,poffense,0) <> '' and REGEXFIND('INFL',poffense,0) <> '' ) OR
							   REGEXFIND(' D[\\. ]U[\\. ]I[\\. ]|^[ ]*D[\\. ]U[\\. ]I[\\. ]' ,poffense,0) <> '' OR
							   REGEXFIND('PROBAT[ION]* OFFICER' ,poffense,0) <> ''
								)=> 'Y',										 							 						 
							 
							 REGEXFIND('VE[C]*H'                 ,poffense,0) <> '' and 
	             (REGEXFIND(Assault3+'|BAT'      ,poffense,0) <> '' or 
							  REGEXFIND(Battery              ,poffense,0) <> '')=> 'Y',			

               REGEXFIND('STALK|MENAC|THREAT|TREATEN',poffense,0) <> '' and 
	             REGEXFIND(aggravated_exc              ,poffense,0) =  '' => 'Y', 
							 
							 REGEXFIND('PUB'                ,poffense,0) <> '' and 
	             REGEXFIND('SERV'               ,poffense,0) <> '' and
							 REGEXFIND('RETALI|RETAIL|SPIT' ,poffense,0) <> '' => 'Y',	
							 
      	       REGEXFIND('BATT'               ,poffense,0) <> '' and 
	             REGEXFIND('POL|PERSON|CH[I]*LD|DOM|L[/]*E[/]*O|L[\\.]E[\\.]' ,poffense,0) <> '' and
							 REGEXFIND('SEX'                ,poffense,0) = '' => 'Y', 
							 
							 REGEXFIND('[/\\. ]SIM[/\\. ]|[/\\. ]SIMP[/\\. ]'           ,poffense,0) <> '' and 
               REGEXFIND('BAT'                    ,poffense,0) <> '' and
               REGEXFIND('SIMULATED'              ,poffense,0) =  '' => 'Y',
							 
							 REGEXFIND('ABUSE|[/\\. ]ABUS[/\\. ]',poffense,0) <> '' and 
               REGEXFIND('PERSON|ADULT|[/\\. ]ELD[ERLY]*[/\\. ]|[/\\. ]DIS[ABLED]*[/\\. ]|DEAD HUMA'                  ,poffense,0) <> '' and 
               REGEXFIND('SEX|CARD|DRUG|DRG'                ,poffense,0) =  '' => 'Y',

							 REGEXFIND('ABUSE'   ,poffense,0) <> '' and 
	             REGEXFIND('PATIENT|RESIDENT|ELDER|NEGL|CARETAKER|CARTAKER|CH[I]*L[D]*|DISABL|IMPAIR|VULNERABLE',poffense,0) <> '' and
							 REGEXFIND('SEX|CARD',poffense,0) =  '' => 'Y',
							 
	             REGEXFIND('CULPABLE' ,poffense,0)  <>'' and 
							 REGEXFIND('NEGLIGENCE' ,poffense,0) <>  ''   => 'Y',
							            
	             REGEXFIND(Assault ,poffense,0) <> '' and 
	             REGEXFIND(assault_exc ,poffense,0) = '' and 
							 REGEXFIND(exc ,poffense,0) =  ''   => 'Y',
							 
							 REGEXFIND(Assault2 ,poffense,0) <> ''and 
	             REGEXFIND(assault_exc ,poffense,0) = '' and 
							 REGEXFIND(exc ,poffense,0) =  ''   => 'Y',	 
							 
               REGEXFIND(Assault3 ,poffense,0) <> ''and 
	             REGEXFIND(assault_exc ,poffense,0) = '' and 
							 REGEXFIND(exc ,poffense,0) =  ''   => 'Y',	
							 
							 REGEXFIND(Battery ,poffense,0) <> ''and 
	             REGEXFIND(assault_exc ,poffense,0) = '' and 
							 REGEXFIND(exc ,poffense,0) =  ''   => 'Y',
	
							 REGEXFIND('STRIKE|SHOVE|KICK',poffense,0) <> '' and
							 REGEXFIND('HARASSMENT',poffense,0) <> '' => 'Y',
							 'N');
return Is_it;
end;


//--------------------------------------------------------------------------------------------------------------------------------------

export Is_Bribery(string poffense_in) := function //DONE

special_characters    := '~|!|-|%|\\^|\\+|:|\\(|\\)|,|;|_|#|@|\\*|<|>|"|`|\\[|]|\\{|\\}|\\\\|\\\'';
poffense              := ' '+REGEXREPLACE(special_characters, poffense_in, ' ');

Bribery                        := 'BRIB[EI][NGRY]*';										
	//Please add an exception to not select offenses that contain    BRIB and also contain SPORT.  
Bri_excl                       := 'SPORT';
  
Is_it := MAP( In_Global_Exclude(poffense,'other')='Y' => 'N',

              REGEXFIND('UNLAW'  ,poffense,0) <> '' and 
							REGEXFIND('COMP'   ,poffense,0) <> '' and 
							REGEXFIND('OFFIC'  ,poffense,0) <> '' and 
						  REGEXFIND('BEHAV'  ,poffense,0) <> '' => 'Y',
							
              REGEXFIND(Bribery  ,poffense,0) <> '' and 
						  REGEXFIND(Bri_excl ,poffense,0) = '' => 'Y',	               
							 'N');
return Is_it;
end;

//--------------------------------------------------------------------------------------------------------------------------------------

 export Is_Motor_Vehicle_Theft(string poffense_in) := function
 
special_characters    := '~|!|-|%|\\^|\\+|:|\\(|\\)|,|;|_|#|@|\\*|<|>|"|`|\\[|]|\\{|\\}|\\\\|\\\'';
poffense              := ' '+REGEXREPLACE(special_characters, poffense_in, ' ');

Motor_Vehicle_Theft   := ' OMVWOC |[D/\\.& ]U[U]+MV[/\\.& ]|U[\\.]U[\\.]M[\\.]V|STEAL(.*)M[/]*V|MVTHEFT|THEFTMV| NMVTA | [TI]+SMV[I]* | T[XB]TMV | TBRSMV |ATTEMPT UUV|'+
                         'VC 10851 A |VC 10851 |PC 496D A |PC 487 D |VC 664\\/10851A|164135 UUV' ; 
// Motor_Vehicle_Theft            := 'AUTO(.*)THEFT|VEH(.*)THEFT|MV(.*)THEFT|JOYRID|UUV |UUMV |U[\\.]U[\\.]M[\\.]V'; 
MVT_Exc       := 'BURG|BREAK|ENTER';
Burglary      := 'BUROLARY|BUR.LARY|BURBULARY|BURG[/\\. ]|B[RU]+GL|BRGLY|BRG[/]|BRG[/0-9 ]|BUR[LG]+|BYRG|BURGLK|B[OUR]+[GR]+[GLAEY]+R[Y]*|^[ ]BUR[/ ]';	
BreakAndEnter := 'BREAK[ING]* [&] ENTER[ING]*|BREAK[ING]* AND ENTER[ING]*|BREAK[ING]* OR ENTER[ING]*|B[&][ ]*E|[/ ]B[ ]*AND[ ]E| BANDE |B[&]E |B[/]E |BREAKING INTO|INVASION';  

MVb := 'LAR[A]*C[AENY]*|LAR[AC]+[ENY]|LARC|STEAL|TH[E]*FT|[/\\. ]TEFT[/\\. ]|[TH]+EFT|[/\\. ]STLNG[/\\. ]';

//Roger's comment QA Update - Theft Round 4 9/27/16. AIRCRAFT, WATERCRAFT, CRAFT, BOAT and VESSEL are not motor vehicles
veh          := ' COMV |AUTO|VE[C]*H|[/\\. ]M[/]*V[EHICLE/ ]+|[/\\.& ]M[/]*V[/\\.& ]|[/\\.& ]M[\\. ]*V[/\\. ]| MVT[R]* | ATV ';

Is_it        := MAP(In_Global_Exclude(poffense,'other')='Y' => 'N',
                // trim(poffense_in) in _fmod_offense_category_list.TheftMVList =>'Y',

						 REGEXFIND(' REC | RECEIVING| RCV | RCV\\.'      ,poffense,0) <> '' and 
             REGEXFIND(MVb                            ,poffense,0) <> '' => 'N',
						 
             REGEXFIND(veh                            ,poffense,0) <> '' and
						 REGEXFIND('TAMP[ ER]'                    ,poffense,0) <> '' => 'Y',
						 
						 //QA Update - MV Theft   Round 5 10/14/16 Embezzlement is included in Theft
						 REGEXFIND('EMBEZZLE'       						  ,poffense,0) <> '' => 'N',
						 
						 (REGEXFIND(Burglary ,poffense,0) <> '' or REGEXFIND(BreakAndEnter ,poffense,0) <> '') and
             REGEXFIND(veh                            ,poffense,0) <> '' and
						 REGEXFIND('[ ]G[/]*T |GRAND THEFT'       ,poffense,0) <> '' => 'Y',

						 REGEXFIND('OPERATE'                      ,poffense,0) <> '' and
						 REGEXFIND('CHOP SHOP'                    ,poffense,0) <> '' => 'Y',
						 
						 //Roger's comments - QA Update - MV Theft   Round 4 9/23/16
             REGEXFIND('STEAL|[ ]G[/]*T |GRAND THEFT|^[ ]*GL |^[ ]*GL/|^[ ]*GL\\(| GL | GL/|/GL/|GRAND LARCENY|THEFT GRAND|STOLEN' ,poffense,0) <> '' and 
             REGEXFIND(veh                            ,poffense,0) <> '' and
						 REGEXFIND('FROM| TAG'                    ,poffense,0) = '' => 'Y',
						 
             REGEXFIND('[/\\. ]TAK[EING]*[/\\. ]|USE|[/\\. ]OP[ERATEDING]*[/\\. ]|REMOVE|DRIVING'     ,poffense,0) <> '' and 
             REGEXFIND(veh  ,poffense,0) <> '' and 
             REGEXFIND('PERMIS'                ,poffense,0) <> '' and 
             REGEXFIND('WITHOUT|[/\\. ]W[/ ]*O[UT]*[/\\. ]|[/\\. ]NO[/\\. ]'    ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('UNLAW'                 ,poffense,0) <> '' and 
             REGEXFIND('TAKING'                ,poffense,0) <> '' and 
             REGEXFIND(veh                     ,poffense,0) <> '' and
						 REGEXFIND('GAME'                  ,poffense,0) = ''=> 'Y',
						 
						 REGEXFIND('DRIV'                  ,poffense,0) <> '' and 
             REGEXFIND('PERMIS'                ,poffense,0) <> '' and 
             REGEXFIND('WITHOUT|[/\\. ]W[/]*O[UT]*[/\\. ]|[/\\. ]NO[/\\. ]'    ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND(veh+'FELMV | UNMV |[/\\. ]MV[0-9]CT[S]*[/\\. ]|[/\\. ]FELM[/]*V[/\\. ]'      ,poffense,0) <> '' and 
						 REGEXFIND(MVb                     ,poffense,0) <> '' and
						 REGEXFIND('FROM| TAG'             ,poffense,0) = '' => 'Y',					
 	 
						 // |BURG|BREAK|ENTER
						 REGEXFIND(veh+'| OFMV |[/\\. ]MV[0-9]CT[S]*[/\\. ]'           ,poffense,0) <> '' and 
						 REGEXFIND('USE'                   ,poffense,0) <> '' and
						 REGEXFIND('UNAUT'                 ,poffense,0) <> '' and
						 REGEXFIND('RAMP'                  ,poffense,0) = '' => 'Y',

						 //QA Update - MV Theft Round 6 10/24/16 select offenses containing  “TAKE A MOTOR VEHICLE”  or  “TAKE MOTOR VEHICLE”  or  “TAKE VEHICLE”   or  “TAKE A VEHICLE”.  
						 REGEXFIND('TAKE [A ]*[MOTOR ]*VEHICLE',poffense,0) <> '' => 'Y',
						 
             REGEXFIND(Motor_Vehicle_Theft ,poffense,0) <> ''  => 'Y',	               
							 'N');
return Is_it;
end;

//--------------------------------------------------------------------------------------------------------------------------------------

export Is_Burglary_BreakAndEnter_res(string poffense_in) := function

special_characters    := '~|!|-|%|\\^|\\+|:|\\(|\\)|,|;|_|#|%|@|\\*|<|>|"|`|\\[|]|\\{|\\}|\\\\|\\\'';
poffense        := ' '+REGEXREPLACE(special_characters, poffense_in, ' ');

Burglary      := 'BUROLARY|BUR.LARY|BURBULARY|BURG[/\\. ]|B[RU]+GL|BRGLY|BRG[/]|BRG[/0-9 ]|BUR[LG]+|BYRG|BURGLK|[/\\. ]B[OUR]+[GR]+[GLAEY]+R[Y]*|^[ ]BUR[/ ]|^[ ]*BURG[L]? | BURG |'+
                 'PC 459 |PC 664[/]459 ';	
BreakAndEnter := 'BREAK[ING]* [&] EN[T]{1,2}[E]{1,2}R[ING]*|BREAK[ING]* AND EN[T]{1,2}[E]{1,2}R[ING]*|BREAK[ING]* OR ENT[E]{1,2}R[ING]*|B[&][ ]*E|[/ ]B[ ]*AND[ ]E| BANDE |B[&]E |B[/]E |'+
                 'BREAKING INTO|HOUSE(.*)BREAK|INVASION|BREAK[/]ENTERING FELONY';   
//Roger's comment - QA Update - Burglary Residential Round 3 8/26. Added BANK, BUIDL,GTMV, and BLD to BBE_exc
BBE_exc       := 'AUTO|[/\\. ]M[/]*V[H/ ]+| M[/]*V |[/\\. ]M\\.[ ]*V[/\\. ]|BUS|VE[C]*H|BUILD|BLDG|COMMERC|COMMER[IC]+AL|[/ ]BUS[/\\. ]|BU[S]+IN|BUS[INS]+|B\\&EMV| CHURCH|BLD|GTMV|BANK|'+
                 'BUIDL|BLDNG|BLDING|[/\\. ]BUSM[/\\. ]|[/\\. ]BLD[/\\. ]|BLDDG|[/\\. ]BLD[SHTBF2][/\\. ]';
//Roger's comment - QA Update - Burglary Residential Round 3 8/26. Remove Driving W... 
//Roger's comment - QA update - Theft Round 5 remove TRES and TRSP from the list
BBE_exc1      := 'PRIVACY|BREAKAGE|DRIVING[ ]?W[/|\\.|H|I|L| ]';
residence     := ' HABIT |[/ ]HAB[IT]*[/ ]|HABI[A]*TAT|[/ ]RES[ID]*[/ ]|RESIDENCE|HOUSE|HOME';

//Roger's comment QA Update - Theft  Round 5 10/14/16
comm    := 'BUILD|BLD[G| ]|COMMERC|COMMER[IC]+AL|[/ ]BUS[\\. ]|BU[S]+IN|BUS[INES]+|CHURCH|BANK|BUIDL';

// DRIVING W/LIC INV W/PREV CONV/SUSP/W/O FIN RES(INS)                        
// FRAUD / FAIL TO PAY LABORERS, MAN, FOR WORK VALUED A

  Is_it := MAP(In_Global_Exclude(poffense,'other')='Y' => 'N',
	             // trim(poffense_in) in _fmod_offense_category_list.BurglaryResidentialList =>'Y',
	             REGEXFIND(BBE_exc                    ,poffense,0) <> '' and 
							 REGEXFIND(residence + '|/JERRY'      ,poffense,0) = '' => 'N',
							 
						   REGEXFIND(BBE_exc1                    ,poffense,0) <> '' => 'N',
							 
							 (REGEXFIND('NON' ,poffense,0) <> '' AND REGEXFIND('RESID' ,poffense,0) <> '') OR
							   REGEXFIND('NON[ ]*RES',poffense,0) <> ''  => 'N',
								 
               REGEXFIND('[/\\. ]BREAK[ING]*[/\\. ]| BRK |[/\\. ]EN[T]{1,2}[E]{1,2}R[ING]*[/\\. ]'        ,poffense,0) <> '' and
	             REGEXFIND(residence                  ,poffense,0) <> '' and 
							 REGEXFIND('BREAKAGE'                 ,poffense,0) =  '' => 'Y',								 

      	       REGEXFIND(residence                  ,poffense,0) <> '' AND 
							 REGEXFIND('INTENT'                   ,poffense,0) <> '' AND 
							 REGEXFIND('UNLAW'                    ,poffense,0) <> ''
							 => 'Y',
							 
							 REGEXFIND('UNLAW'                    ,poffense,0) <> '' AND 
							 REGEXFIND('ENT'                      ,poffense,0) <> '' AND
							 REGEXFIND('INT'                      ,poffense,0) <> '' AND 
							 REGEXFIND(residence                  ,poffense,0) <> ''
							 => 'Y',
							 
							 REGEXFIND('ENTRY|ENTER'                           ,poffense,0) <> '' AND 
							 REGEXFIND(residence                               ,poffense,0) <> '' AND 
							 REGEXFIND('THEF|FEL |CRIM|DAMAG|UNLAW|CERT[AI]+N' ,poffense,0) <> '' AND
							 ((REGEXFIND('WITH ' ,poffense,0) <> '' AND REGEXFIND('INTENT' ,poffense,0) <> '') OR
							   REGEXFIND('W/INT',poffense,0) <> ''
							 ) => 'Y',
							            
							 REGEXFIND('^[ ]*(.)*BUR(.)*[/\\. ]|[/\\. ](.)*BUR(.)*[/\\. ]|BURLY|BRG'  ,poffense,0) <> '' AND 
							 REGEXFIND('[/\\. ]HAB[/\\. ]|[/\\. ]STEA[/\\. ]|[/\\. ]RES[IDEN]*[/\\. ]|DWELLING',poffense,0) <> '' AND
							 REGEXFIND(BBE_exc                   ,poffense,0) = ''  and		
							 REGEXFIND('BURN|WAYNESBURG'         ,poffense,0) = '' => 'Y',							 
							 
               REGEXFIND(residence                 ,poffense,0) <> '' AND 
							 REGEXFIND('INV |INV[AS]+[TION]+'    ,poffense,0) <> '' => 'Y',	
							 
							 REGEXFIND(residence                 ,poffense,0) <> '' AND 
							 REGEXFIND('FORCE'                   ,poffense,0) <> '' AND 
							 REGEXFIND('ENTRY|ENTER'             ,poffense,0) <> '' => 'Y',	
				 
				       REGEXFIND(Burglary                  ,poffense,0) <> '' AND								 
	             REGEXFIND('BURN|WAYNESBURG'         ,poffense,0) = ''  => 'Y',	
							 							 
							 REGEXFIND(BreakAndEnter             ,poffense,0) <> '' AND
	             REGEXFIND('BURN|WAYNESBURG'         ,poffense,0) = ''  => 'Y',
							 
							 (REGEXFIND(Burglary                 ,poffense,0) <> '' or	
							 REGEXFIND(BreakAndEnter             ,poffense,0) <> '') AND	
							 REGEXFIND(residence                 ,poffense,0) <> '' AND
							 REGEXFIND('LAR[A]*C|THEFT' ,poffense,0) <> '' and REGEXFIND('RED' ,poffense,0) <> '' => 'Y',

							 //Roger's comment QA Update - Theft Round 5 10/14/16
               REGEXFIND('^[ ]*BURG[L]* |[/\\. ]BREAK[ING]*[/\\. ]| BRK |[/\\. ]EN[T]{1,2}[E]{1,2}R[ING]*[/\\. ]'        ,poffense,0) <> '' and
							 REGEXFIND('WITH INTENT|W\\-INTENT|LAR[A]*C|THEFT',poffense,0) <> '' AND							 
	             REGEXFIND(comm                  		 	,poffense,0) =  '' => 'Y', 
               REGEXFIND('^[ ]*BREAKING AND OR ENTERING[ ]*$',poffense,0) <> '' => 'Y',							 								
							 
							 'N');
							 							 
return Is_it;
end;

//--------------------------------------------------------------------------------------------------------------------------------------

export Is_Burglary_BreakAndEnter_comm(string poffense_in) := function

special_characters    := '~|!|-|%|\\^|\\+|:|\\(|\\)|,|;|_|#|%|\\*|<|>|"|`|\\[|]|\\{|\\}|\\\\|\\\'';
poffense        := ' '+REGEXREPLACE(special_characters, poffense_in, ' ');


Burglary      := 'BUROLARY|BUR.LARY|BURBULARY|BURG[/\\. ]|B[RU]+GL|BRGLY|BRG[/]|BRG[/0-9 ]|BUR[LG]+|BYRG|BURGLK|[/\\. ]B[OUR]+[GR]+[GLAEY]+R[Y]*|^[ ]BUR[/ ]|^[ ]*BURG[L]? | BURG ';	
BreakAndEnter := 'BREAK[ING]* [&] EN[T]{1,2}[E]{1,2}R[ING]*|BREAK[ING]* AND EN[T]{1,2}[E]{1,2}R[ING]*|BREAK[ING]* OR EN[T]{1,2}[E]{1,2}R[ING]*|B[&][ ]*E|[/ ]B[ ]*AND[ ]E| BANDE |B[&]E |B[/]E |BREAKING INTO|INVASION';   
BBE_exc       := 'AUTO|[/\\. ]M[/]*V[H/ ]+| M[/]*V |[/\\. ]M\\.[ ]*V[/\\. ]|VE[C]*H|[/ ]HAB[IT]*[/ ]|HABI[A]*TAT|[/ ]RES[ID]*[/ ]|RESIDENCE|HOUSE|HOME';
//Roger's comment - QA update - Theft Round 5 remove TRES and TRSP from the list
BBE_exc1      := 'PRIVACY|BREAKAGE';                                                        
					 
comm    := 'BUILD|BLD[G| ]|COMMERC|COMMER[IC]+AL|[/ ]BUS[\\. ]|BU[S]+IN|BUS[INES]+|CHURCH|BANK|BUIDL';
  Is_it := MAP(In_Global_Exclude(poffense,'other')='Y' => 'N',
	
	             // trim(poffense_in) in _fmod_offense_category_list.BurglaryCommercialList =>'Y',
							 
	             (REGEXFIND(Burglary                   ,poffense,0) <> ''  OR 
							  REGEXFIND(BreakAndEnter              ,poffense,0) <> '') AND 
							 ((REGEXFIND('NON' ,poffense,0) <> '' AND REGEXFIND('RESID' ,poffense,0) <> '') OR
							   REGEXFIND('NON[ ]*RES',poffense,0) <> '' ) => 'Y',					 
							 
							 REGEXFIND('FORCE'                    ,poffense,0) <> '' AND 
							 REGEXFIND('ENTRY'                    ,poffense,0) <> '' AND 
							 ((REGEXFIND('NON' ,poffense,0) <> '' AND REGEXFIND('RESID' ,poffense,0) <> '') OR
							   REGEXFIND('NON[ ]*RES',poffense,0) <> ''
							 ) => 'Y',
							 //this (BBE_exc) has to be after the two above using NON-RES as bbe_exc is excluding the word RESID
               REGEXFIND(BBE_exc                    ,poffense,0) <> '' and 
							 REGEXFIND(comm                       ,poffense,0) = ''=> 'N',
							 
							 REGEXFIND(BBE_exc1                               ,poffense,0) <> '' => 'N',
             	
							 REGEXFIND('[/\\. ]BREAK[ING]*[/\\. ]| BRK |[/\\. ]EN[T]{1,2}[E]{1,2}R[ING]*[/\\. ]'         ,poffense,0) <> '' and
	             REGEXFIND(comm                        ,poffense,0) <> '' and 
							 REGEXFIND('GLASS|BREAKAGE'            ,poffense,0) = ''  => 'Y',

      	       REGEXFIND(comm                       ,poffense,0) <> '' AND 
							 REGEXFIND('INTENT'                   ,poffense,0) <> '' AND 
							 REGEXFIND('UNLAW'                    ,poffense,0) <> ''
							 => 'Y',
							 
							 REGEXFIND('UNLAW'                    ,poffense,0) <> '' AND 
							 REGEXFIND('ENT'                      ,poffense,0) <> '' AND
							 REGEXFIND('INT'                      ,poffense,0) <> '' AND 
							 REGEXFIND(comm                       ,poffense,0) <> ''
							 => 'Y',
							 
							 REGEXFIND('ENTRY|ENTER'                           ,poffense,0) <> '' AND 
							 REGEXFIND(comm                                    ,poffense,0) <> '' AND
							 REGEXFIND('THEF|FEL |CRIM|DAMAG|UNLAW|CERT[AI]+N' ,poffense,0) <> '' AND
							 ((REGEXFIND('WITH ' ,poffense,0) <> '' AND REGEXFIND('INTENT' ,poffense,0) <> '') OR
							   REGEXFIND('W/INT',poffense,0) <> ''
							 ) => 'Y',
 
               REGEXFIND('^[ ]*(.)*BUR(.)*[/\\. ]|[/\\. ](.)*BUR(.)*[/\\. ]|BURLY|BRG'  ,poffense,0) <> '' AND 
							 REGEXFIND(comm                                    ,poffense,0) <> '' AND
							 REGEXFIND('[/\\. ]BLD[G]*[/\\. ]|[/\\. ]STEA[/\\. ]|[/\\. ]AGG[/\\. ]|[/\\. ]BU[I]*LD[/\\. ]|[/\\. ]CO[M]+[/\\. ]|COMMERC|COMMER[IC]+AL|[-/\\. ]BUS[/\\. ]|BU[S]+IN|BUS[INS]+|BUSINESS|[/\\. ]STR[/\\. ]',poffense,0) <> '' AND
               REGEXFIND('BURN|WAYNESBURG'         ,poffense,0) = '' /*and 
							 REGEXFIND(BBE_exc                   ,poffense,0) = '' */=> 'Y',         
							 
							 REGEXFIND(Burglary                   ,poffense,0) <> '' and
	             REGEXFIND(comm                       ,poffense,0) <> '' and 
							 // REGEXFIND(BBE_exc                    ,poffense,0) = '' AND
							 REGEXFIND('BURN|WAYNESBURG'          ,poffense,0) = ''  => 'Y',	
							
							 REGEXFIND(BreakAndEnter              ,poffense,0) <> '' and
	             REGEXFIND(comm                       ,poffense,0) <> '' and 
							 // REGEXFIND(BBE_exc                    ,poffense,0) = '' AND
							 REGEXFIND('BURN|WAYNESBURG'          ,poffense,0) = ''  => 'Y',	

							(REGEXFIND(Burglary                   ,poffense,0) <> '' or
							 REGEXFIND(BreakAndEnter              ,poffense,0) <> '') and
							 REGEXFIND(comm                       ,poffense,0) <> '' AND
							 (REGEXFIND('LAR[A]*C|TH[E]*FT|[/\\. ]TEFT[/\\. ]|[TH]+EFT|[/\\. ]STLNG[/\\. ]'     ,poffense,0) <> '' and 
							  REGEXFIND('RED' ,poffense,0) <> '') => 'N',			
								
							(REGEXFIND(Burglary                  ,poffense,0) <> '' or	
							 REGEXFIND(BreakAndEnter             ,poffense,0) <> '') AND	
							 REGEXFIND('BLDNG|BLDING|[/\\. ]BUSM[/\\. ]|[/\\. ]BLD[/\\. ]|BLDDG|[/\\. ]BLD[SHTBF2]+[/\\. ]' ,poffense,0) <> ''  => 'Y',

							 REGEXFIND('^[ ]*B & E BLDG[ ]*$'     ,poffense,0) <> '' => 'Y',	
							 
							 REGEXFIND('VENDING'                  ,poffense,0) <> '' AND
							 REGEXFIND(' B & E '                  ,poffense,0) <> '' => 'Y',	           
							 
							 'N');
							 							 
return Is_it;
end;

//--------------------------------------------------------------------------------------------------------------------------------------

export Is_Burglary_BreakAndEnter_Veh(string poffense_in) := function

special_characters    := '~|!|-|%|\\^|\\+|:|\\(|\\)|,|;|_|#|%|\\*|<|>|"|`|\\[|]|\\{|\\}|\\\\|\\\'';
poffense              := ' '+REGEXREPLACE(special_characters, poffense_in, ' '); 

//DF-18286 code review comment #3, add ^[ ]*BURG[L]? | BURG to Burglary to keep it in sync with burglary comm and res
Burglary      := 'BUROLARY|BUR.LARY|BURBULARY|BURG[/\\. ]|B[RU]+GL|BRGLY|BRG[/]|BRG[/0-9 ]|BUR[LG]+|BYRG|BURGLK|[/\\. ]B[OUR]+[GR]+[GLAEY]+R[Y]*|'+
                 '^[ ]BUR[/ ]|^[ ]*BURG[L]? | BURG |VEHICLE PROWLING|B & E VEHICLES';	
BreakAndEnter := 'BREAK[ING]* [&] EN[T]{1,2}[E]{1,2}R[ING]*|BREAK[ING]* AND EN[T]{1,2}[E]{1,2}R[ING]*|BREAK[ING]* OR EN[T]{1,2}[E]{1,2}R[ING]*|B[&][ ]*E|[/ ]B[ ]*AND[ ]E| BANDE |B[&]E |B[/]E |BREAKING INTO|INVASION';  


//DF-18286 code review comment #4, BLD should be added to BBE_exc in Is_Burglary_BreakAndEnter_Veh
BBE_exc       := 'BLDNG|BLDING|[/\\. ]BUSM[/\\. ]|[/\\. ]BLD[/\\. ]|BLDDG|[/\\. ]BLD[SHTBF2][/\\. ]|BUILD|BUIDL|BANK|BLDG|BLD|COMMERC|COMMER[IC]+AL|'+
                 '[-/ ]BUS[-/\\. ]|BU[S]+IN|BUS[INS]+|[/ ]HAB[IT]*[/ ]|HABI[A]*TAT|[/ ]RES[ID]*[/ ]|RESIDENCE|HOUSE|HOME| CHURCH[ |$]';
BBE_exc1      := 'PRIVACY|TRES|TRSP|BREAKAGE';

Larceny           := 'LAR[A]*C[AENY]*|LAR[AC]+[ENY]|LARC|STEAL|TH[E]*FT|[/\\. ]TEFT[/\\. ]|[TH]+EFT|[/\\. ]STLNG[/\\. ]';       
Larceny_exc       := 'CHILD STEAL|BURG|VE[C]*H|AUTO|MV|DECLARCATION|SHOPLIF[TING]*|SHOFLIFT|SAFECRACK';
veh               := 'AUTO|VE[C]*H|[/\\. ]M[/]*V[EHICLE/ ]+| M[/]*V |[/\\. ]M[\\. ]*V[/\\. ]';
// L2a               := 'AUTO|VEH|[/ ]MV[-)(;H ]|M/V';
// BURG OF BUILDING W/INT COMM TH 1
  Is_it := MAP(In_Global_Exclude(poffense,'other')='Y' => 'N',
						   // trim(poffense_in) in _fmod_offense_category_list.BurglaryMVList =>'Y',
               REGEXFIND(BBE_exc                                ,poffense,0) <> '' and 
							 REGEXFIND(veh                                    ,poffense,0) = '' => 'N',
							 
						   REGEXFIND(BBE_exc1                               ,poffense,0) <> '' => 'N',
							 
               REGEXFIND('STOL[EN]*|STLN'                       ,poffense,0) <> '' and 
               REGEXFIND('TH[E]*FT|REC[EIV]*|RCV|RVC|POSS|GOODS|PROP|CONCEAL|BUY|SELL|SALE|TRANS' ,poffense,0) <> '' => 'N',

               REGEXFIND('REC[EIV]*|RCV'                        ,poffense,0) <> '' and 
               REGEXFIND('TH[E]*FT|'                             ,poffense,0) <> '' and 
               REGEXFIND('DIRECT'                               ,poffense,0) = '' => 'N',
							 
							 REGEXFIND('[/\\. ]BREAK[ING]*[/\\. ]| BRK |[/\\. ]EN[T]{1,2}[E]{1,2}R[ING]*[/\\. ]'                    ,poffense,0) <> '' and
	             REGEXFIND(veh                                    ,poffense,0) <> '' and 
							 REGEXFIND('INTERSEC|[/\\. ]ROA[DWAY]*[/\\. ]|[/\\. ]RDW[/\\. ]|H[I]*GHW[A]*Y| H[/]WAY |BREAKAGE|CROSSING|CENTER|WIND[H]*SHIE|FAIL YLD|FAILED TO DISP|'+
							 'REST BREAK|FAIL T[O/ ]*YIELD|RESTING AREA|ENTER FALSE INFO|OPERATE VEHICLE|OPERATING|PED-ENTERING|PATH OF VEH|PEDESTRIAN|FAULTY BR|STICKER|TRAFFIC CONTROL|ENT[E]{1,2}R[ING]*[/\\,OR ]+LEAV' ,poffense,0) = ''  => 'Y',
							 							 
							 REGEXFIND('[/\\.\\* ]UEMV[/\\.\\* ]'             ,poffense,0) <> '' => 'Y',                
	
      	       REGEXFIND(veh                                    ,poffense,0) <> '' AND 
							 REGEXFIND('INTENT'                               ,poffense,0) <> '' AND 
							 REGEXFIND('UNLAW'                                ,poffense,0) <> '' => 'Y',                
							                        
							 REGEXFIND('UNLAW'                                ,poffense,0) <> '' AND 
							 REGEXFIND('ENT'                                  ,poffense,0) <> '' AND
							 REGEXFIND('INT'                                  ,poffense,0) <> '' AND 
							 REGEXFIND(veh                                    ,poffense,0) <> ''
							 => 'Y',
							 
							 REGEXFIND('ENTRY|ENTER'                          ,poffense,0) <> '' AND 
							 REGEXFIND(veh                                    ,poffense,0) <> '' AND 
							 REGEXFIND('THEF|FEL |CRIM|DAMAG|UNLAW|CERT[AI]+N',poffense,0) <> '' AND
							 ((REGEXFIND('WITH ' ,poffense,0) <> '' AND REGEXFIND('INTENT' ,poffense,0) <> '') OR
							   REGEXFIND('W/INT' ,poffense,0) <> ''
							 ) => 'Y',
							 
							 REGEXFIND('ENTRY'                                 ,poffense,0) <> '' AND 
							 REGEXFIND(veh                                     ,poffense,0) <> '' AND
							 REGEXFIND('UNLAW|[/\\. ]UNLW[/\\. ]|[/\\. ]UNL[AWFUL]*[/\\. ]|UNLF[/\\. ] |[/\\. ]UN[/\\. ]',poffense,0) <> ''  => 'Y',
							 
							 REGEXFIND('^[ ]*(.)*BUR(.)*[/\\. ]|[/\\. ](.)*BUR(.)*[/\\. ]|BURLY|[/\\. ]BRG[/\\. ]'  ,poffense,0) <> '' AND 
							 REGEXFIND(veh                                     ,poffense,0) <> '' AND
							 REGEXFIND('BURN|WAYNESBURG'                       ,poffense,0) = '' => 'Y',							 						 
								
							 REGEXFIND(Burglary                                ,poffense,0) <> '' and
	             REGEXFIND(veh                                     ,poffense,0) <> '' and 
							 REGEXFIND('BURN|WAYNESBURG'                       ,poffense,0) = ''  => 'Y',
							 
							 REGEXFIND(BreakAndEnter                           ,poffense,0) <> '' and
	             REGEXFIND(veh                                     ,poffense,0) <> '' and 
							 REGEXFIND('BURN|WAYNESBURG'                       ,poffense,0) = ''  => 'Y',
							 
							 REGEXFIND('LARC|ILL|LOCK'                         ,poffense,0) <> '' and 
               REGEXFIND('ENTER|ENTRY'                           ,poffense,0) <> '' and 
						   REGEXFIND(veh                                     ,poffense,0) <> '' => 'Y',	
							 
							 REGEXFIND(Larceny                                 ,poffense,0) <> '' and
               REGEXFIND('FROM'                                  ,poffense,0) <> '' and
							 REGEXFIND(veh                                     ,poffense,0) <> '' => 'Y',
							 
  						 REGEXFIND('PROWL[ING ]+'                          ,poffense,0) <> '' and
							 REGEXFIND(veh                                     ,poffense,0) <> '' => 'Y',
							 
							 (REGEXFIND(Burglary                                ,poffense,0) <> '' or
							  REGEXFIND(BreakAndEnter                           ,poffense,0) <> '') and
                REGEXFIND(veh                                     ,poffense,0) <> '' 	and						 
							 (REGEXFIND('LAR[A]*C|TH[E]*FT|[/\\. ]TEFT[/\\. ]|[TH]+EFT|[/\\. ]STLNG[/\\. ]' ,poffense,0) <> '' and REGEXFIND('RED' ,poffense,0) <> '') => 'Y',	
								
							 'N');							 
							 
return Is_it;
end;

//--------------------------------------------------------------------------------------------------------------------------------------

export Is_Computer_Crimes(string poffense_in) := function //done

special_characters    := '~|!|-|%|\\^|\\+|:|\\(|\\)|,|;|_|#|%|@|\\*|<|>|"|`|\\[|]|\\{|\\}|\\\\|\\\'';
poffense              := ' '+REGEXREPLACE(special_characters, poffense_in, ' ');

Computer_Crimes                := 'COMPU(.*) GRAND TH|COMPU(.*) TRAFF|COMPU(.*)R[ES]|COMPUTER';

CC_exclude                     := 'COMPUL|COMPUTER TRESP';
Is_it := MAP(In_Global_Exclude(poffense,'other')='Y' => 'N',

             // trim(poffense_in) in _fmod_offense_category_list.ComputerCrimesList =>'Y', 
						 
             REGEXFIND(Computer_Crimes ,poffense,0) <> '' and 
             REGEXFIND(CC_exclude ,poffense,0) = '' => 'Y',	               
							 'N');
return Is_it;
end;

//--------------------------------------------------------------------------------------------------------------------------------------

export Is_Counterfeiting_Forgery(string poffense_in) := function //done

special_characters    := '~|!|-|%|\\^|\\+|:|\\(|\\)|,|;|_|#|%|\\*|<|>|"|`|\\[|]|\\{|\\}|\\\\|\\\'';
poffense              := ' '+REGEXREPLACE(special_characters, poffense_in, ' '); 

Counterfeiting_Forgery  := 'FROG|FORG|FO[R]*GERY|FOEGE|FOERG|CTRFT|COUNTERF[IE]*T|COUNTF|PC 475 [ABC] |PC 475A|PC 476A(A)|PC 470 [AD] |PC 470B|PC 476|HS 11368';										

Counterfeiting_Forgery2 := '^[ ](FRG[/ &\\.]|FRGD|FRGE|FRGING|FRGRY|FRGY|FRGNG)';	

  Is_it := MAP(In_Global_Exclude(poffense,'other')='Y' => 'N',
	
     	         REGEXFIND('FALSE|FLS|FAL|FICTI',poffense,0) <> '' and 
							 REGEXFIND('[/\\. ]ID[ENIFVICATION]*[/\\. ]|[/\\. ]ID[ENTIFYING]*[/\\. ]| I[/]D ',poffense,0) <> '' and 
							 REGEXFIND('[/\\. ]AID[/\\. ]',poffense,0) = '' and 
               REGEXFIND('SELL|SALE|DISTRIB|MANUF' ,poffense,0) <> '' => 'Y',							 
	
               REGEXFIND('UTTER',poffense,0) <> '' and 
               REGEXFIND('[/\\. ]BILL[S]*[/\\. ]' ,poffense,0) <> '' => 'Y',							 
							 
	             REGEXFIND(Counterfeiting_Forgery ,poffense,0) <> '' and 
               ~(REGEXFIND('FOR[EI]*GN' ,poffense,0) <> '' and REGEXFIND('OBJ' ,poffense,0) <> '') => 'Y',	
							 
							 REGEXFIND(Counterfeiting_Forgery2 ,poffense,0) <> '' => 'Y',	
							 'N');
return Is_it;
end;
//--------------------------------------------------------------------------------------------------------------------------------------

export Is_Destruction_Damage_Vandalism(string poffense_in) := function //done
                                                               
special_characters    := '~|!|-|%|\\^|\\+|:|\\(|\\)|,|;|_|#|%|\\*|<|>|"|`|\\[|]|\\{|\\}|\\\\|[\\\']';
poffense              := ' '+REGEXREPLACE(special_characters, poffense_in, ' ');

Destruction_Damage_Vandalism   := 'VANDALISM|DESTROY|DESTRUCTION|GRAFFITI|CRIM[\\.]*DAM|MALMISCH|DAMACE PROPERTY|DAMPROPRTY|MALICDAMAG|'+
                                  'PC 594 [AB] |PC 594 |PC 594\\.2|PC 591 | PC 591\\.5';			

Destruction_Damage_Vandalism2   := '^[ ](DAMAG|DAMAMGE|DAMATE|DAMATO|DAMDAGE|DAMEAGE|DAMG|DANAGE)';	
		                                                
damage := 'DAMAMGE|[/\\. ]DA[M]+[AGEING]*[/\\. ]|[/\\. ]DAM[AGES0-9]*[/\\. ]|[/\\. ]DMG[INGSE0-9]*[/\\. ]|DAMAG|DAMAGIN|DMGNG' ;
  Is_it := MAP(In_Global_Exclude(poffense,'other')='Y' => 'N',	
	             // trim(poffense) in _fmod_offense_category_list.DestructionList =>'Y',
							 // REGEXFIND('POSS'                            ,poffense,0) <> '' and 
							 // REGEXFIND('BURG'                            ,poffense,0) <> '' and
               // REGEXFIND('TOOL'                            ,poffense,0) <> '' => 'Y',
							 //Roger's comment QA Update - Destruction Round 5 10/3
							 REGEXFIND('LEAVE |LEAVING '                         ,poffense,0) <> '' and
							 REGEXFIND('SCEN'                                    ,poffense,0) <> '' and
							 REGEXFIND('ACCIDEN'                                 ,poffense,0) <> '' => 'N',
							 
							 REGEXFIND('INJURY|INJURING'                 ,poffense,0) <> '' and 
							 REGEXFIND('PUBLIC'                          ,poffense,0) <> '' and
               REGEXFIND('BUILD'                           ,poffense,0) <> '' => 'Y',						      
                                                                

							 REGEXFIND('CRINIMAL|CRIM|[/\\. ]MAL[L]*[ICIOUS]*[/\\. ]|MAL[AI]CIOUS|MALISH |MALICIAS'     ,poffense,0) <> '' AND              
               REGEXFIND('MISCH'                           ,poffense,0) <> '' => 'Y',
							 
							 REGEXFIND('DEFAC '                          ,poffense,0) <> '' AND              
							 REGEXFIND('DEFACAT'                         ,poffense,0) =  '' AND        
               REGEXFIND('FIREA|ALTER|ALT|LIC|SER|NUMBER|ID|PRESCRIP|VIN|FORG' ,poffense,0) <> '' => 'Y',
							 
							 REGEXFIND('MOLEST'                          ,poffense,0) <> '' AND              
               REGEXFIND('COIN|MACH[INE]*[/\\. ]|AUTO|VE[C]*H|[/\\. ]M[/]*V[EHICLE/ ]+| M[/]*V |[/\\. ]M\\.[ ]*V[/\\. ]|[/\\. ]VEND[ING]*[/\\. ]'      ,poffense,0) <> '' => 'Y',
							 
							 REGEXFIND(damage                           ,poffense,0) <> '' AND              
               REGEXFIND('BUILD|PROP|VE[C]*H|GRAVE|AUT$'  ,poffense,0) <> '' => 'Y',
							 
							 REGEXFIND('PROP'                            ,poffense,0) <> '' and 
							 REGEXFIND('DAMAG|INJ|DEST|GRAFF|DEFACE|CRIM',poffense,0) <> '' and
               REGEXFIND('ACC|INVOL|POSS|STOLEN|TRESPASS| TRES | TR[E]*SP |MOVABLE PROP' ,poffense,0) =  '' => 'Y',
							  
               REGEXFIND('[/\\. ]VAND[A]*[\\\']|[/\\. ]VAN[D]+[ALISUOZNMEDH]*[/\\. ]|[/\\. ]VAND[ALIZED]*[/\\. ]|[/\\. ]VAND[ALIZATIONG]*[/\\. ]',poffense,0)  <> '' => 'Y',
							 
							 // REGEXFIND(damage          ,poffense,0) <> '' and 
							 // REGEXFIND('[/\\. ]MAL[ICIOUS]*[/\\. ]||MALICIOUS'     ,poffense,0) <> '' and
               // REGEXFIND('WI[LL]FUL'      ,poffense,0) <> '' => 'Y',
							 
							 REGEXFIND(damage                       ,poffense,0) <> '' and 
							 REGEXFIND('FACITITY|FACILITIES|WILLFUL|[/\\. ]MAL[ICIOUSLY]*[/\\. ]|MAL[AI]CIOUS|MALICIONS|TAMPER|UNLAW|RECKL|CR[I]*M|CRMNL'      ,poffense,0) <> '' => 'Y',
							 						 
               REGEXFIND(Destruction_Damage_Vandalism ,poffense,0) <> '' and
	             REGEXFIND('EVID|DUI'                   ,poffense,0) = '' => 'Y',	               
							 
							 REGEXFIND(Destruction_Damage_Vandalism2 ,poffense,0) <> '' => 'Y',
  
							 'N');
return Is_it;
end;

//--------------------------------------------------------------------------------------------------------------------------------------

export Is_Drug_Narcotic(string poffense_in) := function //working

special_characters    := '~|!|-|%|\\^|\\+|:|\\(|\\)|,|;|_|#|@|\\*|<|>|"|`|\\[|]|\\{|\\}|\\\\|[\\\']';
poffense              := ' '+REGEXREPLACE(special_characters, poffense_in, ' ')+' ';

special_characters2   := '~|!|-|%|\\^|\\+|:|,|;|_|#|@|\\*|<|>|"|`|\\[|]|\\{|\\}|\\\\|[\\\']';
poffense7             := ' '+REGEXREPLACE(special_characters2, poffense_in, ' ');				
                                                                 

 // causes other offenses to get selected.
Drug_Narcotica        := 'AMPHET|CULTIVATE|CUL OF MARJ|^[ ]CULTIV|\\.5 GRAM|GRAMS|HYPODERMIC|HEROIN|[/ \\.]SCH[E]*D[ULED]*[/ \\.]|SCH [1234I]|P[PHTARA]+PH[ER]*NALIA|PARAP|[ /\\.]POM[ /\\.]|'+
                         'POSS[/]MAR|A[D]+E[R]+AL|AMITRIP|AMPH[IE]T|ATIVAN|BUPRENORPHINE|CARIS[OP]+|COCA[IN]|CANN[AI]B[UI]|HALLUCINOGE| DIST[RIBUTE]*[/\\.]SCH| DIST[/\\. ]MARIJ| DIST[/\\. ]COC[/ A]|'+
                         'CLONAZEPAM|[ /\\.]E[XC]*STA[SC]Y[ /\\.]|DIAZEPA|HALLOCINOG|HYDROXYZINEPAM|HER[OI]+N|HYDROCO|[ /\\.]L[\\.]*S[\\.]*D[ /\\.]|LORAZEPAM|LYSERGIC|LORTAB|HY[DR]+OMORPHONE|MORPHINE|'+
												 'OXYCO[DT]|PHENOBAR|PROPOXYPHENE|PHENCYCLEDINE|PSILOCYBIN|A[L]*P[A]*RAZOL|PSUEDOEP|PHENYL|TRAZODONE|TRAZEPAM|VALIUM|VICODIN|[ZX]AN[EA]X|PROHIB(.*)ACT(.*)SCH[E]*DU[LE]+S';
												 
Drug_Narcoticb        := 'CA[N]+AB|[ /\\.]RX[ /\\.]|[ /\\.]COCA[ /\\.]|DARVOCET|OXYC|MANDRAX|VYVANSE|[ /\\.]OXCO[DN]|HYDRO|[/\\. ]P[S]*/SCH[/\\. ]| DIST CDS | DIST[R]*\\.(.*)[/\\.]SCH[/\\.]|[/\\. ]DRUG[S]*[/\\. ]|'+
												 'PHENCYCLIDINE|PHENMETRA| UCDS | UCDSA |DALPHINE|ACETAMINPHEN|PROPYLHEXEDRINE|DIETHYLPROPION|EPHEDRINE|PARAPHERNALIA|TRAZADONE|PRESCRIBED DR |SYNNARCOTIC|EXTASY|CANNBIS|[/\\. ]DRUG PARA[/\\. ]|'+
												 'PHENETHYLAMINES|BARBIT|COCAEIN|FELPOSCOC|FELPOSSLSD|AMPHE|BENZYLPIPERAZ|AMBENYL|AMOBAR|DEMEROL|DESOXYN|PRELUDEN|PRELUDIN|OPIUM|METHAMPH|DILAUDID|CODONE|PERCOCET|MAR.[HJ][UI]ANA';												 

Drug_Narcotic1        := 'POSS/CS|POSS(.*) DIST| POSSCANN|MARI[HJ]UAN[A]*|[ /\\.]MARI[ /\\.]|[ /\\.]CDS[ /\\.]|[ /\\.]CDS$|SALE/SCH/I|SALE/DEL(.*)[/\\.]SCH|'+
                         'DRUG[S]* ABUSE|DRUG[S]* FREE|DRUG[S]* VIO|DRUG[S]*[/ ]+DIST[/\\. ]|DRUG[S]* SCHEDULE|DRUG[S]* SPOM| [US]POM[ 0-9]| POM[1-9J] | PWID[/ ]|'+
												 ' DISTRIBUTE[/ ]CON[TROLED\\./ ]*SUB| DISTRIBUTE DANG[EROUS\\.]* SUB| DEL OF MARI |DEF OF[ A]* CS TO|COUNTERFEIT C/S |'+ 
												 'PSYLOC|METHO[D]+ONE|[/\\. ]SAL[E ]*COCA...[/\\. ]|[/\\. ]SAL[E ]*CSCOCA[/\\. ]| S[/]M[/]D[/]P[/]W[/]INT|'+												                                                                                              
												 '[/\\. ]SCH[/\\. ]*[IV]+[0-9]*[/\\. ]|[/\\. ]C[/]S SCH[/\\. ]|[/\\. ]POSS[ OF]*DR[/\\. ]|[/\\. ]CON[TROL]*[/\\. ]SCH[EDULED]*[/\\. ]SUB';

Drug_Narcotic2        := 'DEL/DRUGS| CON SUB (.*)/SCH|/SCH[/\\.][IV123]+|POSS CTRL[ DANGEROUS]* SUSBS|POSS SCH SUBS|POSS CONT SUBS|POSS OF C/S|POSS[ /]USE C/S|'+ 
                         'INTRO(.*)[ /]CONTR|[TANCE]*[/\\. ]CON(.*)\\.SUB[STANCE]*[/\\. ]|COUNTERF(.*)\\.SUB|C[N]*T[RL](.*)[ /](SUB|SUSB|SBSTNC) |'+
                         'INT(.*) DEL.|W/I[INT/]* DEL|[/\\. ]DEL[\\./]MAN[UFACTORINGED]*[/\\. ]| DEL SCH |INT(.*)TO DIST|TRAFFIC IN CRAC|TRAFFIC IN COKE|'+
                         'SIMPLE POSS|^[ ]SALE[S]* TO|SYRINGE|STEROID|TRAFFIC DRU|ATTEMPT [(]TRAFFI|TRAFF(.*)COCAIN|COCAIN(.*)TRAFF|TRAFFIC IN PHENE';

Drug_Narcotic3        := 'MARIJ|^[ ]DEL[/ \\.]|TRAF ICE[/ ]|MAN[ /]DEL|DEL(.*) CONT|DEL(.*) CDS| AM[OUN]*T[/]DISTRIBUTE[/ ]*NOT SELL |'+
		                     'ATTEMPT TO (MANU)|ATTEMPT TRAF| DRGS |DRUG| DURG |[/\\. ]NARC[OARTICES]*[/\\. ]|PRESC[R]*IP|S[ALE]*/COC|DEL(.*)COC|TAMPH|SAL[E]* (.*) COC|'+
												 'CONTRIB\\.|CONTRA[BND]+|PCS POSSESSION| DIST COC |[/\\. ]DIST[\\. ]+(.*)COC[\\. ]*(.*) SCH[\\. ]|POSS[ESSION ]*CNTRL SUB|'+
												 '^[ ]CDS[/\\. ]|^[ ]CON-CDS|[/\\. ]A[ \\.]+C[ \\.]+D[ \\.]|[/\\. ]CIG[/\\. ]|PRECURSOR SUBS|OBTAIN CONT SUB|'+
												 ' MFG[\\.]* (.*)CON[T]*[\\.]* SUB[\\.]* | CULT [OF ]*MARI | CULT [OF ]*MARI | DEL [OF ]*MARI |POSSNARCAP|POSSNARCDG|POSSNARCOT|POSSOFCOKE';												 	

Drug_Narcotic4       :=  'CTRL SBST/MFG/DISTRIB|	MFG[ OF]* C[ONTROL]*/S[UBSTANCE]* | MFG/PHEN| MFG/PENTA| MFG CRACK|[/\\. ]MFG MARJ|[/\\. ][P]+OSS[/ ]MJ[/\\. ]|[/\\. ]MFG MJ[/\\. ]|[/\\. ]MFG THC[/\\. ]|[/\\. ]MFG[/\\. OF]*[/ ]CON[TROL]*[/\\. ]SUB| CON[TROL]*[/ ]SUB[-/ ]MFG|^[ ]MFG/D/D[/\\. ]|'+
                         '[/ ]MFG DEL POSS |[/\\. ]DEL[/\\.]MFG[R]*[/\\. ]|[/\\. ]MFG[/\\.]DEL[IVER1]*[/\\. ]|MANUFACTURE|MANUF|[/ ]MFG(.*)CON(.*)SUB[STANCE]*|COCAINE TRAFFIC |SUB[ -]DELIVER/MFG|[/ ]MFG DEL [POSS ]*W/INT|MFG/DCS |'+
												 '[/\\. ]MFG [DRUG ]*PARA[PHERNALIA]*[/\\. ]|TRAFFIC[/ ]COC[/\\. ]| TRAF COC SCH[/\\. ]|[/\\. ]UPCS[/\\. ]|[/\\. ]VIO[LATEION]*[ OF]* PCS[/\\. ]|[/\\. ]PV PCS[/\\. ]|[/\\. ]PCS[ 123I]+[/\\. ]| MFG/DIST CTRL|'+
												 '^[ ]PCS[/\\. ]|^[ ]POM[S0-9/\\. ]|AGG TRAFFFIC DR |XPO[S]+[ OF]* PAR[APH]* |DISTRIBUTE/CONTRLD S|MFGCTRSUBS|ILLPOSCOCA|ILLPOSCOKE|ILLPOSS C[/]S|ILLPOSSCOC|ILPOSCOKE|ILSALEOLSD|POSSCOKEBS|POSSCRACK|POSSCRKCOC|POSSESNARC';

Drug_Ctrl_sub        :=  '[/\\. ]C[ON]*T[RL]+[LED]*[\\. /]SUB[STANCES]*[/\\. ]|[/\\. ]CTR[LED\\.]*[\\./ ]SUBST[STANCES]*[/\\. ]|CONT[ROLED]*(.*)[/\\. ]DANG[EROUS]*[/\\. ]SUB[STANCE]*[/\\. ]|[/\\. ]CONT(.*) S[BU]+S[TANCE]*[/\\. ]|[/\\. ]C[ON]*TR[LED](.*) S[BU]+S[TANCE]*[/\\. ]|'+
                         '[/\\. ]CON[/\\. ]SUB[/\\. ]|CONTROL[LED]*[/ ]SUB[STANCES]*[/\\. ]|[/\\. ]CNT[RLED]*[\\./ ]SUB[STANCES]*[/\\. ]|[/\\. ]CONT(.*) SUS[BTANCES]*[/\\. ]|[\\./ ]CTR[\\./ ]SUBS[\\./ ]| CRTL SUB |'+
												 '[/\\. ]C[ON]*T[RL]+[LED]*(.*) SUS[BTANCEY]*[/\\. ]|C[O]*NTR[OLED]* [DANGEROUS]+ SUBS|OCNTROLLED SUBSTANCE ';												 
                                                   
//TAMP                         
Drug_Narcotic_exc    := 'MISCHIEF|MISCH|SPEEDING|CARD|LICENSE|BURG|DEERSPECIES|IDENTIFICATION|REGISTRATION|TELE|PORNO|STOLEN|SWEEPING|'+
                        'DOG|ANIMAL|TITLE|TOBACCO|TAMP|RAPE |FIREARM|FIREWORK|WEAPON|KNIFE|VESSEL|FORGE|CYCLE|BB RIFLE|SNOOK|BAG LIMIT|DRUM|SNAPPER|'+
												'BASS |ROOSTER|CRAB|SPD LMT|SPEED LIMIT|DIST SPIRIT|[/\\. ]DEER|POSS CONT ALC|ALCOHOL|SHOTGUN|F(.*)[O]+D(.*)[ ]*STAMP|'+
												'FAIL OBTAIN STAMP|POSTMARKING STAMP|GAMBL(.*)DEV(.*)EQUIP|NO EMERG EQUIP|EXPLO|HUMAN TRAF|CHILD PORN|POSS(.*) OF COMPUTER|DIST(.*) OF COMPUTER|'+
												'DREDGING EQUIPMENT|RA[ID]+O EQUIPMENT|CONT[RACTORS]* EQUIP[MENT]*|SURV[EILLANCE]* EQUIP|POSS(.*)ALTER(.*)EQUIP|TAMP(.*)EQUIP|'+
												'ARCHERY EQUIP|EQUIP(.*) MANUF(.*) COUNTERFEIT [IDOC]+|HOMICIDE|MURDER|ROBBERY|LARC|CONTRACTO|GATHERIN|MARI CO |ACTUAL PHYSICAL CONTROL|BAD CK[/ ]';                        																						

Not_Drug_unless			 := 'FIREARM|FIREWORK|WEAPON|KNIFE|VESSEL|FORGE|CYCLE|DEER';
  
MAU_exc              := 'TAMP|ARSON|FIRE|EXPLO|BOMB|INCEN|MAURY|MAURICE|CHECK|MAUDIE|MAUTHORIZE|EMMAUS|MAUPIN|MCMAU|MAUL|MAURIO|MAUST|MAUDRIVING|CLINTON|MAUOPEN|VOP|TRESPASS|DAMAGE';	

cs_set               := '[/\\. ]DIST[RIBUTIONE\\.]*[OFA ]*C[/]*S |[/\\. ]PO[S]+[\\.ESSION]*[OF ALC OR]*C[/]*S | DIS/DEL/MNF/PR[O]*D A C/S | DST/DEL/MNF/PR[O]*D A C/S |'+
                        ' PO[S]+[OR/ ]+USE[ OF A]* C[/]*S | POSS[/OR ]+USE[ OF]* CS | POS(.*) C/S $| MFG[ A]* C/S| A[R]+ANGE TO DIST C[ ]*S | POSS[\\.][ OF]* CS | TRAFFIC CS |'+
												'POSS[\\. ]+COUNTERFEIT CS | MFG [OF ]*CS |DST/DEL/MNF/PR[O]*D[ A]* CS| [P]+O[S]* C[/]*S |POSS GP[ I1234]* CS | POSS INT/DEL CS | POSS FOR SALE CS |'+                   
                        ' DIST/D[ELIVER]*/M[A]*N[FJ]/A[T]+[EMPT]*/PO[S]+ W/INT CS |DIST/D[ELIVER]*/M[N]*[FG]+/(.*)A[T]+[EMPT]*(.*)/PO[S]+ W/(.*) CS | D/D/M/P[ A]* CS |'+
												' MFG[\\.]*(.*) C/SUB[STANCE]*[/\\. ]| POS[ESSION]* [GPO]+(.*) CS |[/\\. ]TRAFF CS[/\\. ]|[/\\. ]DEL CS[/\\. ]|[/\\. ]OBT[AIN]* CS[/\\. ]|DEL[IVER]*/POSS/DEP/CON[C]* CS |'+
												'[/\\. ]PO[S]+[/](.*) OF CS |POSS[/ OF]* CS |[/\\. ]CS POSSESS|DIST[\\./]+DLVR[\\./]+MFG[\\./ ]+C/S |' +
												'SNIFF[ING]* GLUE'; 

Drug2                := '[/\\. ]CDS[/\\. ]|CONT(.*) SUBS|DRUG|MARI[HJ]|[/\\. ]NARC[OTICS]*[/\\. ]|[/\\. ]LSD[/\\. ]|[/\\. ]COC[1GCOAINME]*[/\\. ]|HEROIN|CONTROLLED DANGEROUS SUBSTANCE|CONTROLLED SUBSTANCE';
                       
Drug3                := 'ALC[\\.]';	                                                     

Drug4                := 'PHENMET|LYSERGIC|CTRL SUB|PERCOCE|ROHYPNL|CODONE|DRUG|PHENE|OPIUM|[/\\. ]COC[1GCOAINME]*[/\\. ]| COCAI|[/\\. ]CRANK[/\\. ]|BENZ|[/\\. ]LSD[/\\. ]|[/\\. ]SCED[/\\. ]|DIAZ|SOMA|[/\\. ]ALP|OXY|[/\\. ]C[D]+[/\\. ]|[/\\. ]MAR[IJGQHUANREA]*[/\\. ]|MARIJ|[/\\. ]MJ[/\\. ]|[/\\. ]MET[/\\. ]|AMRIJ|MRJANA|PAR[PA]+[H]*|PENTAZ|PHEN[OC]|'+
                        'CD[W ]+/IN| POSS[OF ]*MAR[IJ][HMLF]*|POSS[OF ]*MAR(.*)35|POSS[OF ]*COC|POSS[OF ]*LSD| POSSCONT(.*)SUB|[P]+OSS[OF ]*MJ|MOL[I]*OTOV|SECOCARBITAL|PSICOCYBIN|ALPRAZOLAM|OXCOCDONE|[/\\. ]OXCO[/\\. ]|'+
										    'TETRAHYD|CONTROLLED(.*)SUBSTANCE|COC[A]*.INE|PO[S]+[C/S ]*COC| CD[SD]+ |BARBITURATE|HEROIN|/CONTRA/| C/SUB | [CD]+CO[N]*C[ ]*W/|[/\\. ]NARC[OTICS]*[/\\. ]';

Drug5                := 'MARIJUANA|[/\\. ]PARA[PHERNALIA]*[/\\. ]|[/\\. ]PRE[S]*C[RIPTIONED]*[/\\. ]|MEHTAM|METH| DR PAR|[/\\. ]DRU[GS]*[/\\. ]|PRECU|[/\\. ]CHEM[ICALES]*[/\\. ]|[/\\. ][PRE]*SC[HEDULE\\.]*[ ]*[12346IV]+[/\\. ]|[/\\. ][OF ]*CRAC[KCOCAINPIE ]*[/\\. ]|[/\\. ][OF ]*CRAC[KCOCAINPIE ]*$|[/\\. ]COKE[/\\. ]|[/\\. ]MBN[/\\. ]|DILAU|'+
                        'TETRAHYDRA|HYDRO|MORPH|PHEN[COT]|PETH|PSE[U]*D| HER | IMITATION|HYPO N|[/\\. ]MDA[/\\. ]|MDMA|HYDROC|OXYC|ECSTA|[/\\. ][OFP]*CD[S]+[W]*[/\\. ]|META|CANN|[/\\. ]C\\.D\\.|[/\\. ]C[/]D[/]| C/S |'+
												'DANG(.*) DR| C[/]*S PG | DR PA |NARCO[C]*T[UI]C| C[O]*NT(.*)SUB[/STANCE]*|CONTROL(.*)DR | MDM[DA]* |[/\\. ]MARJ[UANA]*[/\\. ]| NCDS | MMDA ';

Drug6                := 'HANDROLIN|STANOZ|TYLOX|ULTRAM|XYDONE|SEBOXONE|ENDOCET|ERYTHROMYCIN|ESCTASY|FAKE SUBSTANCE|FENTANYL|FIORINAL|I[M]+IT[ATION]* SUB|LORACET|LORATAB|LORCET|LORITAB|MAIJUANA|MODAFINIL|PROZAC|PSILOCY|RITALIN|'+
                        'HASHISH|DILUADID|COCAINE|[/\\. ]M[AI]RI[JUANA]*[/\\. ]|PROXAMOL|[/\\. ]MAIRJ[UANA]*[/\\. ]|MAIRJUANA|OF[ ]*SCHED|OF LSD';
												
Drug7                := '[ (](ANA|CPAM|KHAT|METC|PCIN|SCAT|SMAR|SYCA|TET|TRIF|METH|ALPR|AMPH|APLR|BUPR|CHLO|COD|DEXT|DIAZ|DPOX|FEN|HCOD|HER|HMOR|K2|LIS|LOR|MARJ|MBN|MDA|MDMA|MDN|MEPR|MORP|MPHE|OPM1|OXY|OXYC|OXYM|PARA|PCP|PENT|PERC|PSIL|RITA|ROID|TYN3|XAN|ZOL)[)]';

Drug8                := '893\\.13\\.6B|893\\.147\\.1|893\\.13\\.6A| VUCSA |893\\.13\\.1A1| P\\.O\\.M\\.[ ]*B |HS 11377 A | HS 11364 |'+
                        'HS 11364\\.1 |HS 11550 A |HS 11350 A |HS 11359 |HS 11550 |HS 11379 A |HS 11379 |HS 11377 |'+
                        'HS 11350 |HS 11532 A |HS 11357 [ABC] |HS 11378 |BP 4140 |VC 23222 B |HS 11352 A |HS 11352 |'+
                        'BP 4060 |HS 11360 A |HS 11358 |PC 4573\\.6|HS 11368 |HS 11365 |BP 4149 |HS 11351 |HS 11375 B ';

veh                  := ' COMV |AUTO|VE[C]*H|[/\\. ]M[/]*V[EHICLE/ ]+|[/\\.& ]M[/]*V[/\\.& ]|[/\\.& ]M[\\. ]*V[/\\. ]| MVT[R]* |BOAT|CRAFT| ATV ';
 
traff_list           := 'TRAFFIN|TRAFF[IN]*CIKING|TRAFFI[CK]+[IK]*NG|TRAFFING|TRAFFINKING|TRAFFKG|TRAFFKICKING|TRAFFRKG|TRAFFKING|TRAFFICK|'+
                        '[/\\. ]TRAF[F]+[AI9ROCEKNGS]*[/\\. ]|TRAF[F]+I[CV][KI]+NG';
                                                        
child_set            := '[/\\. ]CHLD[/\\. ]|[/\\. ]CHIL[DREN]*[/\\. ]|MINOR|JUV';

  Is_it := MAP(In_Global_Exclude(poffense,'other')='Y' => 'N',
							 // trim(poffense_in) in _fmod_offense_category_list.DrugList =>'Y',
							 
               REGEXFIND('MANUF|SELLING|DIST\\.|SALE|MANUFACTURE|SELL',poffense,0) <> '' and 
               REGEXFIND('FALSE'                                      ,poffense,0) <> '' and 
               REGEXFIND('IDENTIFIC|LIC[/]ID| ID |DOCUMENT'           ,poffense,0) <> '' => 'N', 
							 
               REGEXFIND('POSS|DEPOSIT|OPER|SMUGG',poffense,0) <> '' and 
               REGEXFIND('COIN'                   ,poffense,0) <> '' => 'N',
							 							  
							 REGEXFIND('MINOR MISD'             ,poffense,0) <> '' and 
               REGEXFIND('DRUG ABUSE'             ,poffense,0) <> '' => 'N',
							 
							 REGEXFIND('PORN'                   ,poffense,0) <> '' and 
							 REGEXFIND('POSS'                   ,poffense,0) <> '' and 
							 REGEXFIND('CHILD'                  ,poffense,0) <> '' => 'N',
							 
							 REGEXFIND('BAD'                    ,poffense,0) <> '' and
							 REGEXFIND('CHECK|[/ ]C[H]*K[/ ]'   ,poffense,0) <> '' => 'N',
							 
							 REGEXFIND('SPEED'                  ,poffense,0) <> '' and
							 REGEXFIND('[0-9]+/[0-9]*'          ,poffense,0) <> '' => 'N',
							 
							 REGEXFIND('OPER'                                                     ,poffense,0)    <> '' and 
							 REGEXFIND('UNDER(.*) INF(.*)[ ]*ALCOH|WHILE(.*) INF(.*)[ ]*ALCOH|WHILE(.*) IMPAIRED(.*)[ ]*ALCOH',poffense,0) <> '' => 'N',
							 
							 REGEXFIND('CIG'                  ,poffense,0) <> '' and 
               REGEXFIND('MARIJ|DRUG|CDS'       ,poffense,0) = ''  => 'N',
							                               
							 REGEXFIND('EXPLO|BOMB|INCEN'     ,poffense,0) <> '' and 
               REGEXFIND('DRUG|NARC|CDS'        ,poffense,0) = ''  => 'N',
                                             
							 REGEXFIND('HEADLIGHT'     				,poffense,0) <> '' and 
               REGEXFIND('BEAMS REQUIRED'       ,poffense,0) <> ''  => 'N',
                                             
               REGEXFIND(veh                    ,poffense,0) <> '' and
	             REGEXFIND('INFLU|[/\\. ]INF[LUENCE]*[/\\. ]'            ,poffense,0) <> '' and //DO not include offenses
	             REGEXFIND('ALCOH|DRUG|NARC'      ,poffense,0) <> ''  => 'N',	
	             //Roger's comment from 7/7/16							 
	             // REGEXFIND('ODOMETER| DUI | DWI ' ,poffense,0) <> ''  => 'N',    // DO not include offenses
	             REGEXFIND('ODOMETER| DUI | DWI ' ,poffense,0) <> ''  => 'N',    // DO not include offenses
             	  
               REGEXFIND('BEV'                  ,poffense,0) <> '' and         // DO not include offenses
	             REGEXFIND('STAMP'                ,poffense,0) <> ''  => 'N',
							 
							 REGEXFIND(Drug_Narcotica         ,poffense,0) <> '' and         // DO not include offenses that have speed and school
	             REGEXFIND('SPEED'                ,poffense,0) <> '' and
							 REGEXFIND('SCHOOL'               ,poffense,0) <> '' => 'N',
							 
							 REGEXFIND(Drug_Narcoticb         ,poffense,0) <> '' and         // DO not include offenses that have speed and school
	             REGEXFIND('SPEED'                ,poffense,0) <> '' and
							 REGEXFIND('SCHOOL'               ,poffense,0) <> '' => 'N',

               REGEXFIND(Drug_Narcotic1         ,poffense,0) <> '' and         //DO not include offenses that have speed and school
	             REGEXFIND('SPEED'                ,poffense,0) <> '' and
							 REGEXFIND('SCHOOL'               ,poffense,0) <> '' => 'N',
							 
							 REGEXFIND(Drug_Narcotic2         ,poffense,0) <> '' and         //DO not include offenses that have speed and school
	             REGEXFIND('SPEED'                ,poffense,0) <> '' and
							 REGEXFIND('SCHOOL'               ,poffense,0) <> '' => 'N',

               REGEXFIND(Drug_Narcotic3         ,poffense,0) <> '' and         //DO not include offenses that have speed and school
	             REGEXFIND('SPEED'                ,poffense,0) <> '' and
							 REGEXFIND('SCHOOL'               ,poffense,0) <> '' => 'N',

							 //QA Update - Drub Round 6 10/24/16
               REGEXFIND(Drug_Narcotic3         ,poffense,0) <> '' and
	             REGEXFIND('DEL\\.|DEL |DELI[N]*Q|UNRULINESS',poffense,0) <> '' and
							 REGEXFIND('MINOR'    						,poffense,0) <> '' => 'N',
							 
		           //Roger's comment DUI File QA Check Round 7
							 REGEXFIND('DRIV[E|I| |\\.]|BOATING|OPR|POSS[ |E]'		 ,poffense,0) <> '' and
							 REGEXFIND('CONT[ |/|\\.|R]|PRESURS|PERCURSOR|PRECUS|MISCELLANEOUS'  ,poffense,0) <> '' and
							 REGEXFIND('SUBS[T|\\.| |$]|SUB[\\.| |$]'              ,poffense,0) <> '' and
							 REGEXFIND('U/I|INFLUEN|UTI'              ,poffense,0) =  '' => 'Y',

							 REGEXFIND(Drug_Narcotica         ,poffense,0) <> '' and 
	             REGEXFIND(Drug_Narcotic_exc      ,poffense,0) = ''  => 'Y',	

							 REGEXFIND(Drug_Narcoticb         ,poffense,0) <> '' and 
	             REGEXFIND(Drug_Narcotic_exc      ,poffense,0) = ''  => 'Y',	
							 
							 REGEXFIND('DRIV|DUI|DWI|GAMBL|SURV|DREDG|SPIRIT|CONTEM|RADIO|DAMAGE' ,poffense,0)    <> ''  => 'N',//DO not include offenses

							 //Roger's comment on 7/7
							 REGEXFIND('DU[0-9I]+[\\)| ]'     ,poffense,0) <> '' => 'Y',															
 							 REGEXFIND('SPEEDING|COIN-OP|PAROLE[/ ]VIOLATOR|TRAFFIC[ ]+PASSING|TRAFFIC[ /]+SPEEDING|TRAFFIC -HOLDING |TRAFFIC[ /]+POSSESSION |TRAFFIC CONTROL LIGHTS|'+
							           'NON-TRAFFIC|TRAFFIC INFRACTION|TRAFFIC[ ]INSPECTION|TRAFFIC INSTANDER|TRAFFIC[/ ]INSTRUCTION|TRAFFIC[/ ]INSURANCE|TRAFFIC MISC\\.|'+
												 'TRAFFIC OFFENSE|TRAFFIC REGISTRATION|TRAFFIC REGULATION|TRAFFIC SPD |TRAFFIC[ ]SPEEDING-SCHOOL|ACT PHYSICAL CONT|SEX',poffense,0) <> '' AND
							 REGEXFIND('DRUG|CONTR[OLLED]* SUBSTANC' ,poffense,0)    = ''					 => 'N',
							 
               REGEXFIND('COUNTER[FEIT]*[ / ]*[CONTROLLED]*[ ]*SUB|COUNTER[FEIT]*[ / ]*[CONTROLLED]*[ ]*DRUG'   ,poffense,0)  <> ''  => 'Y',

               REGEXFIND('OTHER'                ,poffense,0) <> ''  and
							 REGEXFIND('DRUG'                 ,poffense,0) <> ''  and
							 REGEXFIND('OFF'                  ,poffense,0) <> ''  => 'Y',
							 
							 REGEXFIND('NARC'                 ,poffense,0) <> ''  and
							 REGEXFIND('DIST|MANUF'           ,poffense,0) <> ''  => 'Y',
							 
							 REGEXFIND('[/\\. ]FEL[/\\. ]|FELONY'         ,poffense,0) <> ''  and   
							 REGEXFIND('DISTRIBUTE  CONTR|DISTRIBUTE-EXTASY|DISTRIBUTE CO|DISTRIBUTE MA|OXCOYNTIN|MFG SUB|MFG/SELL/DIST/MA|CNTROLLED|POSS SHCED',poffense,0) <> ''  => 'Y',							 
							 
							 REGEXFIND('[/\\. ]DRG[/\\. ]|[/\\. ]CRANK[/\\. ]|[/\\. ]CRANK[/\\. ]|[/\\. ]MDMA[/\\. ]|[/\\. ]THC[/\\. ]'         ,poffense,0) <> ''  and
							 REGEXFIND('[/\\. ]MFG[D]*[/\\. ]|[/\\. ]W/IN[/\\. ]|[/\\. ]ANALOGUE[/\\. ]'   ,poffense,0) <> ''  => 'Y',
							 
               REGEXFIND('COKE[BS]*[/\\. ]|[/\\. ]ANALOGUE[/\\. ]'                                                  ,poffense,0) <> ''  and
							 REGEXFIND('[/\\. ]MFG[D]*[/\\. ]|[/\\. ]DIST[/\\. ]|[/\\. ]PO[S]+[C]*[/\\. ]' ,poffense,0) <> ''  => 'Y',    
							 
							 REGEXFIND('[/\\. ]C[/]S[MJ]*[/\\. ]'                                                  ,poffense,0) <> ''  and
							 REGEXFIND('[/\\. ][ATTEMPTED ]*MFG[D]*[/\\. ]|[/\\. ]DIST[RIBUTEING]*[/\\. ]|[/\\. ][ATTEMPTED ]*PO[S]+[C]*[/\\. ]|[/\\. ]OBTAIN[/\\. ]|[/\\. ]SALE[C/S]*[/\\. ]' ,poffense,0) <> ''  => 'Y',  
							 
							 REGEXFIND('POSS[/\\. ]'                       ,poffense,0) <> ''  and    
							 REGEXFIND('[/\\. ]CONT[/\\. ]|CONTRL[D]*'     ,poffense,0) <> ''  and
							 REGEXFIND('SUSP|[/\\. ]SCH[/\\. ]'            ,poffense,0) <> ''  => 'Y', 

               REGEXFIND('[/\\. ]CONT[\\.] S '                                               ,poffense,0) <> ''  and
							 REGEXFIND('[/\\. ]MFG[D]*[/\\. ]|[/\\. ]DIST[/\\. ]|[/\\. ]DLVR[/\\. ]'       ,poffense,0) <> ''  => 'Y',
							 
							 REGEXFIND('[/\\. ]CONT[/\\. ]|CONTROLLED'                                     ,poffense,0) <> ''  and
							 REGEXFIND('[/\\. ]CS[/\\. ]|[/\\. ]SU[/\\. ]|[/\\. ]SUBSGT[/\\. ]'            ,poffense,0) <> ''  => 'Y',
							 
							 REGEXFIND('C[ON]*TROLLED| C[DSO]+NTROLLED|[/\\. ]C[N]*TROL[/\\. ]| CNTRLD| CNTR[L]*[\\.]| CTRN | CTRSL | C[NT]+RL |CONTRLD|CONT[ROLLED]*[/\\. ]|XCON|CONTROLLED|CONTROL|CONTR|CTRFT |[/\\. ]CTRK[/\\. ]|CONTOL|CONT\\.|CONTRL|CTRL|[/\\. ]CTR[/\\. ]'   ,poffense,0) <> ''  and
               REGEXFIND('SUSBSTANCE|SUBSTANC|SUBST|SUBSTANCE|SUBSTANCE|CONSUBS|SUBST  SUB|SUSBS[T]* |SUBST|SUB[SST]+| SUBS|SUBJ |SUBSR|SUB[\\.]|SBSUT|SUBSTY|SUSPT|SUBXFR|SUBJS'  ,poffense,0) <> ''  =>'Y',
							 
							 REGEXFIND('CODEIN|OPIUM|DRUG'         ,poffense,0) <> ''  and
               REGEXFIND('DELIV'                     ,poffense,0) <> ''  =>'Y',
							 										 
							 REGEXFIND('SELL|SALE|TRANS'           ,poffense,0) <> '' and             
							 ( REGEXFIND('PHENCYCLIDINE'           ,poffense,0) <> '' OR
							   REGEXFIND('MARJ'                    ,poffense,0) <> '' OR
                (REGEXFIND('CONT' ,poffense,0) <> '' and REGEXFIND('SUB' ,poffense,0) <> '') 
							 ) => 'Y',	

               REGEXFIND('UNLAW'                     ,poffense,0) <> ''  and
							 REGEXFIND('PURCH|ACQUIR'              ,poffense,0) <> ''  and
							 REGEXFIND('EPHEDRINE|PSEUDOEPHEDRINE' ,poffense,0) <> ''  => 'Y',

               REGEXFIND('UNLAW'                     ,poffense,0) <> ''  and
							 REGEXFIND('CONT'                      ,poffense,0) <> ''  and
							 REGEXFIND('[/\\. ]SUB[STANCE]*[/\\.() ]|[/\\. ]SUB[STANCE]*$',poffense,0) <> ''  and
							 REGEXFIND('[/\\. ]OBT[AINGED]*[/\\. ]|CULTIVAT',poffense,0) <> ''  => 'Y',

							 REGEXFIND('UNLAW'                     ,poffense,0) <> '' and
							 REGEXFIND('DEL|DIST'                  ,poffense,0) <> '' and
							 ( REGEXFIND('COCAIN|[/\\. ]METH[/\\.( ]|[/\\. ]CD[W]*[/\\.( ]|[/\\. ]CS[/\\. ]|[/\\. ]CDS[W]*[/\\.( ]|[/\\.( ]MARJ[UANA]*[/\\.) ]|[/\\. ]MJ[/\\. ]|'+
							             '[/\\. ]CD$|[/\\. ]CS$|[/\\. ]CDS$',poffense,0) <> '' OR
                (REGEXFIND('CON' ,poffense,0) <> '' and REGEXFIND('SUB' ,poffense,0) <> '') 
							 ) => 'Y',	
							 							 
							 REGEXFIND('[/\\. ]TRAF[/\\. ]|[/\\. ]TRAFF[/\\. ]|[/\\. ]TRAFFIC[/\\. ]|[/\\. ]TRAN[/\\. ]' ,poffense,0) <> ''   and
							 REGEXFIND('[/\\. ]POSMJ[/\\. ]|NARCOPTICS|[/\\. ]OXY[/\\. ]|[/\\. ]COC[/\\. ]|PSEDOEPHETIME| CTRFT SUBS |[/\\. ]UPOM[/\\. ]|[/\\. ]UPODP[/\\. ]|MARIHUANA|[/\\. ]MARJ[UANA]*[/\\. ]|[/\\. ]MD[M]*A[/\\. ]|PSEDOEPHETIME |MORPHIN|POSCOC|PARAHERNALIA',poffense,0) <> ''  => 'Y',
							 
							 REGEXFIND('[/\\. ]COC[/\\. ]' ,poffense,0) <> ''   and
							 REGEXFIND('[/\\. ]SALE[/\\. ]|NARCOPTICS|[/\\. ]SCH[/\\. ]|[/\\. ]DIS[/\\. ]|[/\\. ]W/IN[T]*[/\\. ]',poffense,0) <> ''  => 'Y',
							 
							 
               REGEXFIND('LIKE SU |SUB|SUBS|SUBSTANCE|SUBSTANC|SUBST' ,poffense,0) <> '' and
							 REGEXFIND('MFG'                               ,poffense,0) <> '' and 
							 REGEXFIND('LOOK[ -]A[ ]*LIKE|DWELLING| C[N ]*SUB[S]* | SCH\\. | ADULTERATED | SELL | CTR | POSS | UNLAW'                               ,poffense,0) <> '' => 'Y',							 
							 
               REGEXFIND('TRAFFI[CK]+[I]*NG|TRAFFING|TRAFFINKING|TRAFFKG|TRAFFKICKING|TRAFFRKG|TRAFFKING|TRAFFICK' ,poffense,0) <> ''  and
							 REGEXFIND(Drug_Narcotic_exc+'|FISH',poffense,0) = ''   and
							 REGEXFIND('FOOD'                   ,poffense,0) = ''  => 'Y',
 
               REGEXFIND('KEEP|MAIN'              ,poffense,0) <> '' and 
							 REGEXFIND('DWEL|PLAC|HOUSE|VE[C]*H',poffense,0) <> '' and
							 REGEXFIND('[/\\. ]TO[/\\. ]|PURP|[/\\. ]FOR[/\\. ]|[/\\. ]USE[D]*[/\\. ]'  ,poffense,0) <> '' and
               REGEXFIND('SELL|DIST'              ,poffense,0) <> '' => 'Y',
							 
							 REGEXFIND('KEEP|MAIN'              ,poffense,0) <> '' and 
							 REGEXFIND('DWEL|PLAC|HOUSE|VE[C]*H',poffense,0) <> '' and
							 REGEXFIND('[/\\. ]CD[S]*[/\\. ]|[/\\. ]LSD[/\\. ]|[/\\. ]MARI[/\\. ]|COCAIN'  ,poffense,0) <> '' and
               REGEXFIND('SELL|DIST'              ,poffense,0) <> '' => 'Y',
							 
               REGEXFIND('POSSES'                 ,poffense,0) <> '' and 
							 REGEXFIND('HAZARD'                 ,poffense,0) <> '' and
               REGEXFIND('SUB'                    ,poffense,0) <> '' => 'Y',				
							 
							 REGEXFIND('PAIN'                                                  ,poffense,0) <> '' and 
               REGEXFIND('MANGEMENT|[/\\. ]MANAG[MENT]*[/\\. ]|[/\\. ]MG[M]*T[/\\. ]|NONREGIST|[/\\. ]MEDS[/\\. ]|[/\\. ]PILLS[/\\. ]',poffense,0) <> '' => 'Y',
							 
							 REGEXFIND('[/\\. ]C[/]S[UBSTANCE]*[/\\. ]|PHENCYCLIDINE| C[/S]NO ',poffense,0) <> '' and 
               REGEXFIND('ILLEGAL'                                               ,poffense,0) <> '' => 'Y',		
							 
							 REGEXFIND('PARA|POSSESION '                                       ,poffense,0) <> '' and 
							 REGEXFIND('DRUG  '                                                ,poffense,0) <> '' => 'Y',	
							 
							 REGEXFIND('[/\\. ]POS[SESION]*[/\\. ]|PWITD',poffense,0) <> '' and 
               REGEXFIND('PWITD |[/\\. ]W/DEL[/\\. ]|[/\\. ]W[ITH]* INTENT[/\\. ]|[/\\. ]W[/]I[NTEN]*[/\\. ]|[/\\. ]INT[/\\. ]|[/\\. ]W[/][INTEN]+[/\\. ]|[/\\. ]W[\\. ]*I[\\. ]*T[O\\. ]*D[/\\. ]|[/\\. ]WI[M/ ]*D[EL]*[/\\. ]|[/\\. ]WIT[/ DEL]*[/\\. ]',poffense,0) <> '' and 
							 REGEXFIND('WEAP|WPN|TRADEMARKS|PORNO|OBSCENE',poffense,0) = '' and 
							 REGEXFIND('CONTROLLED SUB|[/\\. ]SCH[/\\. ]|[/\\. ]MFG[/\\. ]|[/\\. ]MNF[/\\. ]|[/\\. ]DIST[RIBUTE]*[/\\. ]|[/\\. ]DEL[IVER]*[/\\. ]|[/\\. ]CS[/\\. ]|[/\\. ]C/S[UBSTANCE]*[/\\. ]| C/SUBMET ',poffense,0) <> '' => 'Y',	

 							 REGEXFIND('[/\\. ]POS[S]*|DISTRIB|'+traff_list                                               ,poffense,0) <> '' and 
  						 REGEXFIND('METAL|SCANN| TRAFFIC[/ ]|TRAFFIC REG|MOVING|PLATES|TRAFFIC OFFEN|TRAFFIC CONTROL|GAMEFISH' ,poffense,0) =  '' and 
  						 (   REGEXFIND('[OU]35[GR]*MJ| [UJS]MJ ',poffense,0) <> '' OR
							     REGEXFIND(drug4                ,poffense,0) <> '' OR
 								   REGEXFIND(drug5                ,poffense,0) <> '' OR
 								   REGEXFIND(drug6                ,poffense,0) <> '' OR
 								   REGEXFIND(Drug7                ,poffense,0) <> '' OR
									 REGEXFIND(' THC[( ]'           ,poffense,0) <> ''
 								)=> 'Y',

							 //Roger's comment on 7/27
							 REGEXFIND('TRAFFIC[K| ]|TRAFF IN|^[ ]*POSS[ |\\.]| POSS |\\-POSS |POSSESSION|^[ ]*PERMIT| PERMIT| ABUSE',poffense,0) <> '' AND 
									(	 REGEXFIND(' DRUG[S \\-]| COCAINE| METH | HEROIN | PROPOXYPHENE | PARA[P| ]| MARIJ[A ]' ,poffense,0) <>  '' OR 
										 (REGEXFIND(' CONT[R ]',poffense,0) <> ''  AND REGEXFIND(' SUB[S\\. ]',poffense,0) <> '') OR
										 // REGEXFIND(Drug_Ctrl_sub,poffense,0) <> '' OR
										 (REGEXFIND(' PRECU[R ]',poffense,0) <> '' AND REGEXFIND(' SUB[S\\. ]',poffense,0) <> '')	
 								)=> 'Y',
										 
							 REGEXFIND('[/\\.]CS[IX3]*[/\\. ]',poffense,0) <> '' and 
							 REGEXFIND('[/\\. ]SAL[E]*[/\\.]|[/\\. ]DEL[/\\.]|[/\\. ]DIST[/\\.]|[/\\. ]OB[T]*[/\\.]|[/\\. ]POS[/\\.]',poffense,0) <> '' => 'Y',
							 
       				 //*******************************************************************************************************************	 							 
							 REGEXFIND(cs_set                   ,poffense,0)  <> '' => 'Y',			
							 
               //very tricky Please don't change the position of this expression and the one above.
							 REGEXFIND('[/\\. ]POS[S]*|DISTRIB|'+traff_list                                  ,poffense,0) <> '' and 
							 REGEXFIND('[/\\. ]C[/]*S '                                                      ,poffense7,0) = '' and 
 							 REGEXFIND('[(]CS TO |[/\\. ]CS TO CF |[/\\. ]CS TO [0-9][0-9] |[/\\. ]CS TO CT ',poffense7,0) <> '' => 'N',
							 //********************************************************************************************************************

							 REGEXFIND('DISTRIB[U]*|[/\\. ]DIST[R]*[\\./ ]'                           ,poffense,0) <> '' and 
               REGEXFIND('C[N]*TR[LD]*[\\.] SUB[\\./] | A CS | CRACK|COC B[A]*SE| CTRL[/\\. ]SUB[STANCE]*[/\\. ]|[/\\.]SCH[/\\. ][CSIIV]+|OCAINE|[/\\. ]C/SUBS[TANCE]*[/\\. ]|'+
							           'HERO[INE]* |WITHIN (.*)SCHOOL|WITHIN (.*)PARK|SCHOOL ZON|NEAR PARK|NEAR SCHOOL|HARM[FUL]* MATER[IAL]*|COCAIN|CONTROLLED S |ECTASY| LESS THAN| MORE THAN| CSIIA |'+ 
												 'MRIJUANA|PERECETS|WELLBUTRIAN|CONTROLLED STUBSTANCE|LOOK ALIKE SUB|[/\\. ]PCP[/\\. ]|ILL SUBSTANCE|OF C[\\.]*S[\\.]* |SUB PROX|MAIJUANA|'+
												 'BARBITUATES|COACINE|COAINE|CODEINE|CONCAINE|CONT DANG SU[BS]+T|DEPAKOTE|KLONOPIN| PCP | L S D |SHEDULED SUB| SCHWEDULE II|[/\\. ]CON[RTOLED/\\. ]*SUB[STANCE]*|'+  
                         ' CONT. PAR[ ]*$| CONTR. SU[ ]*$| CONTRLD S[ ]*$| CONTROL S[ ]*$| CONTROL[LED\\.]*[ ]*$'    ,poffense,0) <> '' => 'Y',

							 REGEXFIND('TRAFFIC'                                                      ,poffense,0) <> '' and 
               REGEXFIND(' A CS |CRACK|COC B[A]*SE| CTRL[/\\. ]SUB[STANCE]*[/\\. ]|[/\\.]SCH[/\\. ][CSIIV/]+|OCAINE|CON[RTOLED/\\. ]*SUB[STANCE]*| HERO[INE]* |WITHIN (.*)SCHOOL|WITHIN (.*)PARK|SCHOOL ZON|NEAR PARK|NEAR SCHOOL|HARM[FUL]* MATER[IAL]*|COCAIN|ECTASY'          ,poffense,0) <> '' and
							 REGEXFIND('LEAVING[ THE]* SCENE'          ,poffense,0) = '' => 'Y',
							 
							 REGEXFIND('POS[S]*'                                                      ,poffense,0) <> '' and 
							 REGEXFIND('MAR|/SCH/|SCHED(.*)SUBS'                                      ,poffense,0)<>  '' and 
               REGEXFIND('FIREARM|FIREMARM|MARICOPA|MARION|MARIPOSA|MARK|MARLIN|MARSH|MART|MARX|PRIMARY' ,poffense,0) = ''     => 'Y',	 
							 
							 REGEXFIND('TRA|[/\\. ]TRAF[\\. ]|[/\\. ]TRAN|OBT|DISPENSE'               ,poffense,0) <> '' and 
               REGEXFIND('DRUG|MARI[HJ]|OPIUM|COCAINE|OXYCODONE|ECSTASY|CONT/SCH|/SCH/' ,poffense,0) <> '' => 'Y',	

		           //Roger's comment 7/15 QA Updates - Drugs - Updates After Cannot Classify and Traffic Review
							 REGEXFIND('^[ ]*MISD[-/ \\.]|^[ ]*MISD[EA]M|^[ ]*MISD\\.|^[ ]*FELONY',poffense,0) <> '' and 
	             REGEXFIND('DRUG|SCHEDULE II CS'													,poffense,0) <> ''  => 'Y',	
							 
               REGEXFIND('MANU/DEL|MFG/DEL'           ,poffense,0)<>  '' and 
               REGEXFIND('SCH/PUB'                    ,poffense,0) <> ''     => 'Y',	 
							 
               REGEXFIND('DRUG'                       ,poffense,0) <> '' and 
               REGEXFIND('MAINT'                      ,poffense,0) <> '' and 
               REGEXFIND('DWEL|PLAC|HOUSE|VE[C]*H|CAR',poffense,0) <> ''  => 'Y',

               REGEXFIND('DRUG'                       ,poffense,0) <> '' and 
               REGEXFIND('UNL|UNLAW'                  ,poffense,0) <> '' and 
               REGEXFIND('DEL'                        ,poffense,0) <> ''  => 'Y',

               REGEXFIND('DRUG'                       ,poffense,0) <> '' and 
               REGEXFIND(child_set                    ,poffense,0) <> ''  => 'Y',

               REGEXFIND('POSS'                       ,poffense,0) <> '' and 
               REGEXFIND('CONTR'                      ,poffense,0) <> '' and 
               REGEXFIND('SUBST'                      ,poffense,0) <> ''  => 'Y',
	             
							 REGEXFIND('ALCOHOL|SHOTGUN'            ,poffense,0) <> '' and        //Include the ALCOHOL|SHOTGUN offenses  only if
	             REGEXFIND(Drug2                        ,poffense,0) <> '' => 'Y',    //these words are present  
	
            	 REGEXFIND('TAMP|STAMP'                 ,poffense,0) <> '' and              
							 REGEXFIND('EVIDE|[( ]CS TO'            ,poffense,0) = ''  and 
	             (REGEXFIND(Drug2                       ,poffense,0) <> '' )=> 'Y',   
							 
	             REGEXFIND(Not_Drug_unless              ,poffense,0) <> '' and               //Include the offenses with keyword in "Not_drug" only if
	             REGEXFIND('DRUG|PRESCRIP|PRESCIPT|PHENCYCLEDINE|[/\\. ]CDS[/\\. ]' ,poffense,0) <> '' => 'Y',//the word drug is present  
							 
               REGEXFIND('TRANSP'                     ,poffense,0) <> '' and 
	             REGEXFIND('COC'                        ,poffense,0) <> ''  => 'Y',
                                                
							 REGEXFIND('VIO'                        ,poffense,0) <> '' and
							 REGEXFIND('[/\\. ]CDS[/\\. ]'          ,poffense,0) <> '' and
							 ( 
                (REGEXFIND('TRANSP' ,poffense,0) <> '' and REGEXFIND('PROCE|PRECE'          ,poffense,0) <> '') 
							 ) => 'Y',							 
							 
							 REGEXFIND('MAU'                          ,poffense,0) <> '' and 
	             REGEXFIND(MAU_exc                        ,poffense,0) = ''  => 'Y',
							 
               REGEXFIND('DISTRIBUTION OF|^[ ]DIST OF'  ,poffense,0) <> '' and 
	             REGEXFIND('SCHOOL'                       ,poffense,0) <> ''  => 'Y',
							 
 	  					 REGEXFIND('DISTRIBUTION OF|^[ ]DIST OF'  ,poffense,0) <> '' and 
	             REGEXFIND('PEACE|WORSHIP|PROP|PORN|FIREWORKS|TOBACCO|SEX'      ,poffense,0) = ''  => 'Y',	
							 
							 REGEXFIND('METH'                         ,poffense,0) <> '' and 
	             REGEXFIND('METH[O]*D|FISH'               ,poffense,0) = ''  => 'Y',	
							 
							 REGEXFIND('[/\\. ]COKE[/\\. ]|[/\\. ]CANN[/\\. ]|[/\\. ]CRACK[/\\. ]|[/\\. ]COC[/\\. ]'                         ,poffense,0) <> '' and 
	             REGEXFIND('[/\\. ]SELL[/\\. ]|[/\\. ]DEL[/\\. ]|DELIVER|[/\\. ]TRAF[/\\. ]|TRFK|[/\\. ]TRF[/\\. ]|[/\\. ]PURC[/\\. ]|[/\\. ]MAN[/\\. ]' ,poffense,0) <> ''  => 'Y',
							 
							 REGEXFIND(Drug8                          ,poffense,0) <> ''  => 'Y',
							 
							 REGEXFIND(Drug_Narcotic1                 ,poffense,0) <> '' and 
	             REGEXFIND(Drug_Narcotic_exc +'|UNLAWFUL LIQUORS'             ,poffense,0) = ''  => 'Y',	
							 
							 REGEXFIND(Drug_Narcotic2                 ,poffense,0) <> '' and 
	             REGEXFIND(Drug_Narcotic_exc              ,poffense,0) = ''  => 'Y',	
							 
							 REGEXFIND(Drug_Narcotic3                 ,poffense,0) <> '' and 
	             REGEXFIND(Drug_Narcotic_exc              ,poffense,0) = ''  => 'Y',	
							 
							 REGEXFIND(Drug_Narcotic4                 ,poffense,0) <> '' and 
	             REGEXFIND(Drug_Narcotic_exc+'|LIQUOR'    ,poffense,0) = ''  => 'Y',	
							 
							 REGEXFIND(Drug_Ctrl_sub                  ,poffense,0) <> '' and 
	             REGEXFIND(Drug_Narcotic_exc              ,poffense,0) = ''  => 'Y',	
							 
							 'N');
return Is_it;
end;

//--------------------------------------------------------------------------------------------------------------------------------------

export Is_Weapon_Law_Violations(string poffense_in) := function //done

special_characters    := '~|!|-|%|\\^|\\+|:|\\(|\\)|,|;|_|#|%|@|\\*|<|>|"|`|\\[|]|\\{|\\}|\\\\|\\\'';
poffense              := ' '+REGEXREPLACE(special_characters, poffense_in, ' ');
                                             
Weapon_Law_Violations          := 'CONCEALED| C[\\. ]*C[\\. ]*[FW][:\\.-/ ]+|CNCLD.WEAPN|CONCEALED PISTOL|CONCEALED WEAP|CONCEALING G|GUNPOIN|'+
                                  'IRGUNS|[/\\. ][AIR ]*GUN[S0-9]*[/\\. ]|SELLINGUN|[0-9]GUN |SLINGSHOT|GUNSHOT|WE[A]*P[A]*ONS|STUNGUN|'+
																	'H[A]*NDGUN|GUNNING|HAN[D]*GUN|GUNFIRE|MACHINE[ ]*GUN|GUNRUNNING|FIRIN(.*)GUN|STL[N]*GUN|MANS...GUN|CONGUN|CAR[ ]*CON[C]*GUN|'+
                                  '[/\\. ]GUN[/\\. ]|[/\\. ][AIR ]*GUN[S0-9]*[/\\. ]|[/\\. ][SHOTSPEAR ]*GUN[S]*[/\\. ]|WEAP|FIREARM|WPN|'+  //SH[.]*TGUN|
																	'F[IRE ]+ARM|F.ARM|BOMB|EXPLOS|[/\\.  ]U[U]+W|PISTOL| PC 4502 |PC 12280 |PC 30305 A ';		
																	
													
																														
//Roger's comment QA Updates - Weapons Law Violations 7/6
//Roger's comment QA Updates - Weapons Law Violations Round 3 8/26
//DF-16568 Review comment #5, remove ^SEX,^LARC,^FRAUD,^SODOMY
wpn_ecl                        := 'ROB[(B ]+|THEFT|MURD|HOMI|BATT|BURG|BOMB(.)*THREAT|THREAT(.)*BOMB|KIDNAP|AS[S]?AULT|ASSAU|AS[S]?LT |[^| ]AS[AU]*LT| RAPE[/| ]|^[ ]*RAPE |/RAPE|\\.RAPE| RAPE\\-|RAPE$|A[ ]*\\&[ ]*B|HOAX BOMB|ASSULT |ASSUA |AGG[\\/|\\.| ]ASS|AGG[\\/|\\.| ]ASLT|ASSALT |ASSULT |ASSUA|' +
                                  ' SEX| LARC| FRAUD| SODOMY|SODMY|/ABDUCT| ABDUCT|MANSLAU|CONCEALED MA[T ]+';
//DF-16568 Review comment #6, remove ^SEX,^LARC,^FRAUD,^SODOMY
wpn_ecl_2											 := 'ROBB|THEFT|MURD|HOMI|BATT|BURG|BOMB(.)*THREAT|THREAT(.)*BOMB|KIDNAP| RAPE[/| ]|/RAPE|\\.RAPE| RAPE\\-|RAPE$|A[ ]*\\&[ ]*B|HOAX BOMB| SEX| LARC| FRAUD| SODOMY|SODMY|/ABDUCT| ABDUCT|MANSLAU';
wpn_2a                         := 'CONCEAL|[/\\.  ]CONC[/\\.  ]';
wpn_2b                         := 'WEAPON|WEAP[ON]*[/\\. ]|FIREA|GUN[/\\.]|PIST|KNIFE|F[IRE ]+ARM|[/\\.  ]F.ARM|BOMB|EXPLOS';                       
 

Is_it := MAP(In_Global_Exclude(poffense,'other')='Y' => 'N',

             // trim(poffense) in _fmod_offense_category_list.WeaponsLawViolationList =>'Y', 
							
             REGEXFIND('HOAX|FALSE|FALS\\.|WARN|SCARE|FIRE ',poffense,0) <> '' and 
						 REGEXFIND('BOMB'            									  ,poffense,0) <> '' => 'N' ,

             REGEXFIND('LARC[ E]|TH[E]*FT |STEAL[LING ]+|BURG|MURD|ROBBERY|CAR[ ]*JACK',poffense,0) <> '' => 'N' ,

             REGEXFIND('POS'                               ,poffense,0) <> '' and
						 //Roger's comment QA Update - Weapons Law Violations Round 4
             REGEXFIND('DEADWE|DEADWEA|SWITCHBLADE'        ,poffense,0) <> '' => 'Y' ,
						 
						 REGEXFIND('USE|POS|DISP|DISL'                 ,poffense,0) <> '' and
             REGEXFIND('FEL'                               ,poffense,0) <> '' and
             REGEXFIND(' FA | F[/][FZ] | F[-/]A | FA[/ ]|FIRE|FOREARM|FRAM|FRM[/ ]|FRRM|GUN|KNIFE|SHANK',poffense,0) <> '' and 
						 REGEXFIND(wpn_ecl                             ,poffense,0) = '' => 'Y' ,
						 
						 REGEXFIND('STAT| ST |INFO'                    ,poffense,0) <> '' and
						 REGEXFIND('PURCH'                             ,poffense,0) <> '' and
             REGEXFIND('FALS'                              ,poffense,0) <> '' and
             REGEXFIND(' F[/]A ',poffense,0) <> '' => 'Y',

             REGEXFIND('MAK|MAN|PROD|SELL|DISCH|TRANS|USE' ,poffense,0) <> '' and
             REGEXFIND('PERM'                              ,poffense,0) <> '' and
             REGEXFIND('DESTR'                             ,poffense,0) <> '' and
             REGEXFIND('DEV'                               ,poffense,0) <> '' => 'Y' ,

             REGEXFIND('MAK|MAN|PROD|SELL|DISCH|PLAC|PROJ|TRANS|USE' ,poffense,0) <> '' and
             REGEXFIND('DESTR'                                       ,poffense,0) <> '' and
             REGEXFIND('DEV'                                         ,poffense,0) <> '' and 
						 REGEXFIND(wpn_ecl                             ,poffense,0) = ''  => 'Y' ,
						 
						 REGEXFIND('DESTRUCT'                          ,poffense,0) <> '' and
             REGEXFIND('USE'                               ,poffense,0) <> '' and 
						 REGEXFIND('REFUSE'                            ,poffense,0) <> '' => 'Y' ,
						 
						 REGEXFIND('LOAD|DISCHARGE'                           ,poffense,0) <> '' and 
						 REGEXFIND('RIFLE|GUN|WEA|FIR| F[/]A[/\\. ]|[\\. ]FRM[\\. ]|FIREARM',poffense,0) <> '' and 
						 REGEXFIND(wpn_ecl                             ,poffense,0) = ''  => 'Y' ,

						 REGEXFIND('HANDGUN|GUN|HAV WPNS|H[A]*V[I]*NG W[EAPO]+NS(.*) UND|^[ ]*PISTOL(.*) POSS|WEAP[ON]*|WEAPOSN|FIREA[R]*M|WPN|'+ 
                       'F[IRE ]+ARM|WEAP|FIREA|GUN|P[ ]*IST[OL]|KNIFE|F[IRE ]+ARM|[/\\. ]F[/\\.]ARM|BOMB|EXPLOS|PIS[TOL]*[\\.]|[\\.]F[/]A[\\.]'   ,poffense,0) <> '' and 
						 REGEXFIND('PERMIT|PRMT'                       ,poffense,0) <> '' and 
						 REGEXFIND('[\\. ]NO |RVKD|[\\. ]W[/]O[\\. ]|W/[ ]*OUT|WITHOUT' ,poffense,0) <> '' and 
						 REGEXFIND(wpn_ecl                             ,poffense,0) = ''  => 'Y' ,
						 
             REGEXFIND('CARRY|POSS'                        ,poffense,0) <> '' and 
						 REGEXFIND('PISTOL|WEAP|GUN|DAGGER'            ,poffense,0) <> '' and 
						 //REGEXFIND(wpn_ecl                             ,poffense,0) = ''  => 'Y' ,
						 //Code review comment #7, expression is used twice, create wpn_ecl_2
						 REGEXFIND(wpn_ecl_2													 ,poffense,0) = ''  => 'Y',
						 
						 REGEXFIND('VIO'                               ,poffense,0) <> '' and
             REGEXFIND('LIC|PERM'                          ,poffense,0) <> '' and 
						 REGEXFIND('CARRY|TRANS'                       ,poffense,0) <> '' and 
						 REGEXFIND('PIS|GUN|WEAP'                      ,poffense,0) <> '' and 
						 REGEXFIND(wpn_ecl                             ,poffense,0) = ''  => 'Y' ,
						                                     
						 REGEXFIND('CARRY'                             ,poffense,0) <> '' and
             (REGEXFIND('KNIF|ARM|[/\\. ]F[/]A[/\\. ]|CLUB|WEAP|PIST|PISL|RIFLE|KNUCK|REVOL|BAYONET'  ,poffense,0) <> '' OR
						  (REGEXFIND('BLACK',poffense,0)  <> '' and REGEXFIND('JACK',poffense,0) <> '') OR
							(REGEXFIND('SWITCH',poffense,0) <> '' and REGEXFIND('BLADE',poffense,0) <> '')) and 
						 REGEXFIND(wpn_ecl                             ,poffense,0) = '' => 'Y' ,

						 //Roger's comment RE: QA Update - Homicide/Weapons Round 5 10/14/16
						 REGEXFIND('SHOOT'                             ,poffense,0) <> '' and
             REGEXFIND('IN CITY'                           ,poffense,0) <> '' and 
						 REGEXFIND(wpn_ecl                             ,poffense,0) = ''  => 'Y' ,
						 
						 REGEXFIND(wpn_2a                              ,poffense,0) <> '' and
             REGEXFIND(wpn_2b                              ,poffense,0) <> '' and
						 //Code review comment #7, expression is used twice, create wpn_ecl_2
						 REGEXFIND(wpn_ecl_2													 ,poffense,0) = ''  => 'Y',
						 
             REGEXFIND(Weapon_Law_Violations               ,poffense,0) <> '' and
             REGEXFIND(wpn_ecl                             ,poffense,0) = '' => 'Y' ,	  

						 //Roger's comment RE: QA Update - Weapon Law Violation Round 6
						 REGEXFIND('ASSAULT'                           ,poffense,0) <> '' and
						 REGEXFIND('ROSTER'                            ,poffense,0) <> '' and
						 REGEXFIND('PISTOL|FIREARM|HANDGGUN '          ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('PC 12020 A |PC 653K|PC 12021 [AC] |PC 417 A |PC 12025 [AB] | PC 12025 |PC 12031 A |PC 12031 |PC 246\\.3| PC 246 |PC 12316 B |PC 29800 A '   ,poffense,0) <> '' => 'Y',					 
             
						 REGEXFIND('POSS[ESSION ]+'                    ,poffense,0) <> '' and
						 REGEXFIND('ILLEGAL '                          ,poffense,0) <> '' and
						 REGEXFIND('AMMO '                             ,poffense,0) <> '' => 'Y',

          	 'N');
return Is_it;
end;
//--------------------------------------------------------------------------------------------------------------------------------------

export Is_Stolen_Property_Offenses_Fence(string poffense_in) := function //done
special_characters    := '~|!|-|%|\\^|\\+|:|\\(|\\)|,|;|_|#|%|@|\\*|<|>|"|`|\\[|]|\\{|\\}|\\\\|[\\\']';
poffense1             := ' '+REGEXREPLACE(special_characters, poffense_in, ' ');
poffense := stringlib.stringtouppercase(poffense1);

Stolen_Property_Offenses_Fence := 'REC(.*)ST[O]*L(.*)|^[ ]R[/\\. ]*S[/\\. ]*P[0-9/\\. ]|[ /]R[/]S[/]P[R/ ]|RCVESTOLPR|[ ]R[ ]S[ ]PRP| KCSP | RCSP | PC 496 ';
STP_exc := '[0-9]+[/][0-9]+';
Is_it := MAP(In_Global_Exclude(poffense,'other')='Y' => 'N',


             REGEXFIND('GRAND THEFT'    ,poffense,0) <> '' => 'N',  

             REGEXFIND('STOL' ,poffense,0) <> '' and REGEXFIND('PISTOL' ,poffense,0) = '' and
             REGEXFIND('THEFT|RECEIV|[/\\. ]REC[IEVD]*[/\\. ]|[/\\. ]REC[IEVNG]*[0-9/\\. ]|[/\\. ]RCV[ING]*[/\\. ]|[/\\. ]RVC[/\\. ]|POSS|GOODS|PROP|CONCEAL|BUY|SELL|SALE|TRANS|DEAL|TRAFF|VEH' ,poffense,0) <> '' AND
						 //Roger's comments QA Update - Theft  Round 5 10/11/16
             REGEXFIND(' TAG'    ,poffense,0) = '' => 'Y',
						 
						 REGEXFIND('THEFT'           ,poffense,0) <> '' and
						 REGEXFIND('[/\\. ]REC[IEVD]*[/\\. ]|[/\\. ]REC[IEVNG]*[0-9/\\. ]|[/\\. ]RCV[ING]*[/\\. ]'         ,poffense,0) <> '' => 'Y',

						 REGEXFIND('RECEI|CONCEAL'   ,poffense,0) <> '' and 
             REGEXFIND('PROP'            ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('FELON|UNLAW|TAK|STLN' ,poffense,0) <> '' and 
						 REGEXFIND('[/\\. ]REC[IEVE]*[/\\. ]|CONC'        ,poffense,0) <> '' and 
             REGEXFIND('PROP'            ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('PAWN|PWN|OWN'    ,poffense,0) <> '' and 
             REGEXFIND('INFO'            ,poffense,0) <> '' => 'Y',	
						 //Roger's comment 7/15/16 QA Updates - Stolen Property
						 REGEXFIND('OWN |OWN$|OF OWNER[$|/]|OF OWNERS$| OWNE | OWNE$|OWNER METAL|OWN[E]?[R]?[S]?[H]*[I]?[P|$]|' +
						           'OWN[D|E|W]ERSHI$|OWNERESHI$|OWNER SHIP|PAWN|[/\\. ]PWN[BROKER]*[/\\. ]|PWNSHIP|APWN BROKER',poffense,0) <> '' and 
             REGEXFIND('VERIF|DECL'      ,poffense,0) <> '' and
             REGEXFIND('BITTEN '  ,poffense,0) = '' => 'Y',

						 //Roger's comment 7/27/16 QA Updates - Drugs						 
						 REGEXFIND('RECV STLN'		,poffense,0) <> '' => 'Y',
						 
             REGEXFIND(Stolen_Property_Offenses_Fence ,poffense,0) <> '' and
						 REGEXFIND(STP_exc,poffense,0) = '' => 'Y',
						 
						 REGEXFIND(' STLN ' ,poffense,0) <> '' and
						 REGEXFIND('PRPRTY|PROPERTY',poffense,0) <> '' => 'Y',

							 'N');
return Is_it;
end;
//--------------------------------------------------------------------------------------------------------------------------------------

export Is_Identity_Theft(string poffense_in) := function//done

special_characters    := '~|=|!|-|%|\\^|\\+|:|\\(|\\)|,|;|_|#|%|\\*|<|>|"|`|\\[|]|\\{|\\}|\\\\|\\\'';
poffense        := ' '+REGEXREPLACE(special_characters, poffense_in, ' ');

														
Identity_Theft:= 'IDENTITY|TAKE[ THE]IDENTITY|PC 530\\.5 A |PC 529\\.3|PC 368 D ';
IT_exc        := 'SERV[ED]*[ |$]|D[AY]+S|SEX|REFUSAL|ACCID[ENT]*|REFUSAL';	

IT2           := 'CREDIT|CRED|CRD|DEBIT';
IT_exc2       := 'USE|ABUSE|CHARGE|CHRG|FORG';

Is_it := MAP(In_Global_Exclude(poffense,'other')='Y' => 'N',

             // trim(poffense_in) in _fmod_offense_category_list.IdentityTheftList =>'Y',

             REGEXFIND('NAME'                   ,poffense,0) <> '' and
             REGEXFIND('ASSAUME|ASSUM'          ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('UNLAW'                      ,poffense,0) <> '' and 	
						 REGEXFIND('ACQ'                        ,poffense,0) <> '' and
             REGEXFIND('[/\\. ]CC[/\\. ]|[/\\. ]C[ ]*/[ ]*C[/\\. ]| CARD| FIN |FINAN',poffense,0) <> '' => 'Y',						 
					 
						 REGEXFIND('RIDE|PRESCRIPT',poffense,0) = '' AND 
             REGEXFIND('ANOTHER'       ,poffense,0) <> '' AND 						 
						   ( REGEXFIND('[/\\. ]ID[ENIFICATION]*[/\\. ]|[/\\. ]ID[ENTIFYING]*[/\\. ]| I[/]D |[/\\. ]D[/]LIC[ENSE]*[/\\. ]|[/\\. ][SCO]*D[\\.]*L[/\\. ]|DEBIT',poffense,0) <> '' OR 
						    (REGEXFIND('DRIV'              ,poffense,0) <> '' AND REGEXFIND('LIC',poffense,0) <> '' ) OR
								(REGEXFIND('CREDIT|[/\\. ]CDT[/\\. ]|[/\\. ]FIN[/\\. ]'    ,poffense,0) <> '' AND REGEXFIND('CARD|DEV',poffense,0) <> '' ) 
								)				
						 => 'Y',						                               

						 REGEXFIND('UNAUT'                 ,poffense,0) <> '' AND 
             REGEXFIND('POSS'                  ,poffense,0) <> '' AND 
						   (REGEXFIND('DEBIT|CREDIT|[/\\. ]ID[ENIFICATION]*[/\\. ]|[/\\. ]ID[ENTIFYING]*[/\\. ]|[/\\. ]DEV[/\\. ]|CARD| I[/]D ',poffense,0) <> '' OR 
						            (REGEXFIND('FIN|CDT'   ,poffense,0) <> '' AND REGEXFIND('CARD' ,poffense,0) <> '' ) OR
												(REGEXFIND('DRIV'      ,poffense,0) <> '' AND REGEXFIND('LIC'  ,poffense,0) <> '' )  OR
												(REGEXFIND('FOOD'      ,poffense,0) <> '' AND REGEXFIND('STAMP|STPS',poffense,0) <> '' ) 
								)				
						 => 'Y',						 
						 
             REGEXFIND(IT2       ,poffense,0) <> '' AND 
             REGEXFIND('STEAL|LARC|STOL|TAKE|THEFT|LOST|ANOTHER|UNLAW|UNAU'   ,poffense,0) <> '' => 'Y',
						 
             REGEXFIND(Identity_Theft ,poffense,0) <> '' AND 
             REGEXFIND(IT_exc ,poffense,0) = ''=> 'Y',	               

						 // Roger's comment - QA Updates -Theft Round 4 9/23
						 REGEXFIND('ID TH[E]?FT'           ,poffense,0) <> '' => 'Y', 
						 // Roger's comment - QA Updates -Theft Round 5 10/11
						 REGEXFIND('IDENT[ |Y|I|/]'        ,poffense,0) <> '' AND 
						 REGEXFIND('TH[E]?FT'			         ,poffense,0) <> '' AND 
             REGEXFIND(IT_exc 								 ,poffense,0)  = '' => 'Y',	   
						 
						 REGEXFIND('DISCLOSE|USE'          ,poffense,0) <> '' and 	
						 REGEXFIND('CREDIT|DEBIT'          ,poffense,0) <> '' and
             REGEXFIND('CARD| CRD '            ,poffense,0) <> '' and 
						 REGEXFIND('NOS |NUMBER'           ,poffense,0) <> '' => 'Y',
						 'N');
return Is_it;
end;
//--------------------------------------------------------------------------------------------------------------------------------------
   
export Is_Fraud(string poffense_in) := function //done

special_characters:= '~|=|!|-|%|\\^|\\+|:|\\(|\\)|,|;|_|#|%|@|\\*|<|>|"|`|\\[|]|\\{|\\}|\\\\|\\\'';
poffense          := ' '+REGEXREPLACE(special_characters, poffense_in, ' ');

Fraud            := 'DECEPTION|ILL(.*) PROC(.*) DR DOC|'+
                    '^[ ](ATT)[ ]*FR.|MISAPPROPRIATION|MISPRESENT|MISREP|MISAPP FIDUC|F[RAU]+D| FRAID | FRAU |MONEY LAUNDERING|IMPERSONAT|'+
										'517.312|IC 1871.4 A 1|MONEY LAUD|ASSUME NAME OF|CRIMINAL USE OF PERSONAL I\\.D\\.|CREDIT CARD[ /]|FINANCIAL TRANSACTION CARD|'+
                    'PC 530\\.5 A |PC 529\\.3|PC 368 D |WI 10980 C |WI 10980 C |PC 476A A |PC 476 |PC 532 A | 13A-9-13\\.1';
f2a              :=  'FRAUD|PRE[N]*TENSE';
f2b              :=  'FICTITIOUS';

IDSET            := '[/\\. ]ID[ENDIFICATION]*[/\\. ]|[/\\. ]ID[ENTIFYING]*[/\\. ]| I[/]D ';
false_set        := ' FALAE | FALSIRY |[/\\. ]FALSR | AFLSE |FALESELY|FALASE| FALCE |FALE[S]*LY| FALSEL |FALSL[E]*|FALSLEY|FALSLY| FLSSE | FAFLSE |'+
                    'FALSIFY|FALSE|[/\\. ]FAL[STEIFYNG]*[&/\\. ]|[/\\. ]FAL[SFEID]*[/\\. ]|[/\\. ]FLS[ELY]*[&/\\. ]|[/\\. ]FAL[SFICATION]*[/\\. ]|FALSIFICATION';
LIC_set          := '[/\\. ]LIC[ENCSE]*[/\\. ]';

Identity_Theft   := 'CREDIT|CRED|CRD';
IT_exc           := 'SERV[ED]*|D[AY]+S';																	
IT_exc2a         := 'USE|ABUSE';
IT_exc2b1        := false_set; 
IT_exc2b2        := 'CHARGE|CHRG';
			 
		 
Is_it := MAP(In_Global_Exclude(poffense,'other')='Y' => 'N',

             // trim(poffense_in) in _fmod_offense_category_list.FraudList =>'Y',
						 
              Is_Identity_Theft(poffense)='Y' => 'Y',
						 (REGEXFIND('ILL|UNLIC'                 ,poffense,0) <> '' OR 
						  (REGEXFIND('W[/][0O][/\\. ]|[/\\. ]WO[/\\. ]',poffense,0) <> '' and REGEXFIND('LIC',poffense,0) <> '')
							)and 	
             REGEXFIND('PHARM|[/\\. ]PHAR[/\\. ]|[/\\. ]RX[/\\. ]'                      ,poffense,0) <> '' => 'Y',
	                                           

             REGEXFIND('TAMP|FALS|[/\\. ]USE[/\\. ]|FICTI|ANOTHER|FAKE|FRAUD|UNAUT' ,poffense,0) <> '' and 
						 REGEXFIND('RIDE|PLATE'                                                                 ,poffense,0) = '' and 
						 (REGEXFIND('LABEL|TRADEMARK|TAG |SERIAL|[/\\. ]VIN[/\\. ]|[/\\. ]ID[ENIFICATION]*[/\\. ]|[/\\. ]ID[ENTIFYING]*[/\\. ]| I[/]D |[/\\. ]D[/]LIC[ENSE]*[/\\. ]|[/\\. ]DL[/\\. ]|DEBIT',poffense,0) <> '' OR 
						  (REGEXFIND('[/\\. ]FIN[ANCIALE]*[/\\. ]|CREDIT|CDT ',poffense,0) <> '' and REGEXFIND('CARD|DEV',poffense,0) <> '') 
							)=> 'Y',
							
						 REGEXFIND('TAMP'                       ,poffense,0) <> '' and 
						 REGEXFIND('GOV[NT\']*[/\\. ]'          ,poffense,0) <> '' and 
						 REGEXFIND('[/]LIC|SEAL'                ,poffense,0) <> '' 	=> 'Y',
						 
						 REGEXFIND('MAKE[INGS]* '               ,poffense,0) <> '' and 	
						 REGEXFIND('FALSE ENT'                  ,poffense,0) <> '' and 
						 (REGEXFIND('BOOKS'                     ,poffense,0) <> '' OR 
						  REGEXFIND('CORP'                      ,poffense,0) <> '' and REGEXFIND('BOOK'  ,poffense,0) <> '') => 'Y',						 
						 
						 REGEXFIND('UNLAW'                      ,poffense,0) <> '' and 	
             REGEXFIND('PRACT'                      ,poffense,0) <> '' => 'Y',                     

             REGEXFIND('WELFARE'                    ,poffense,0) <> '' and 
						 ( 						 
			  			 REGEXFIND('TAMP|[/\\. ]G/L[/\\. ] |[/\\. ]FR[/\\. ] |[/\\. ]FD[/\\. ]|FRAUND' ,poffense,0) <> '' OR							 
							 REGEXFIND('GRAND|GRNAD',poffense,0) <> '' and REGEXFIND('LAR' ,poffense,0) <> ''
						 ) => 'Y',		
						 
						 REGEXFIND('WELFARE'                      ,poffense,0) <> '' and 
						 REGEXFIND(false_set                      ,poffense,0) <> '' and
						 REGEXFIND('KNOW|[/\\. ]APP[/\\. ]| AP[/ ]|INFO|PRENT|STATE|VERIFI|STMT|REPRES' ,poffense,0) <> '' => 'Y',
						 
             REGEXFIND('UNLAW'                        ,poffense,0) <> '' AND 	
						 REGEXFIND('OBT'                          ,poffense,0) <> '' AND
						 ( 						 
			  		  (REGEXFIND('PUB'      ,poffense,0) <> '' and REGEXFIND('ASSI|ASST| AST ' ,poffense,0) <> '') OR
							(REGEXFIND('MED'      ,poffense,0) <> '' and REGEXFIND('BENE'      ,poffense,0) <> '') 
						 )=> 'Y',
						 
						 REGEXFIND('UNDE|UNLAW'                   ,poffense,0) <> '' and 	
             ( REGEXFIND('OBTAIN|P/ASSIST'            ,poffense,0) <> '' OR
							(REGEXFIND('PUB'      ,poffense,0) <> '' and REGEXFIND('ASSIS' ,poffense,0) <> '') 
						 ) => 'Y',
						 
             REGEXFIND('MONEY'                      ,poffense,0) <> '' and 	
             REGEXFIND('LAUND'                      ,poffense,0) <> '' => 'Y',

             REGEXFIND('CONCEAL|CONCCEAL|CONCEAML|CONCELAM',poffense,0) <> '' and 
						 REGEXFIND('SHOPLIFT|[/\\. ]MERCH[/\\. ]|MERCH[ANDISE]+'      ,poffense,0) = '' and 
             Is_Weapon_Law_Violations(poffense)               ='N'  and 
             Is_Stolen_Property_Offenses_Fence(poffense)      ='N'  => 'Y',
						 
             REGEXFIND(f2a                          ,poffense,0) <> '' and 	
             REGEXFIND(f2b                          ,poffense,0) <> '' => 'Y',

             REGEXFIND('SELL|SALE'                  ,poffense,0) <> '' and 	
             REGEXFIND('SECUR|[/\\. ]GOV[ERNMENT]*[/\\. ]'    ,poffense,0) <> '' and 
						 Is_Drug_Narcotic(poffense) ='N' => 'Y',
						 
             REGEXFIND(' ELECTION|^ELECTION'        ,poffense,0) <> '' => 'Y',             

             REGEXFIND('DEBIT'                      ,poffense,0) <> '' and 	
						 REGEXFIND('CARD'                       ,poffense,0) <> '' and
             REGEXFIND('ABUSE'                      ,poffense,0) <> '' => 'Y',
						 
             REGEXFIND('[/\\. ]PRAC[TICSENG]*[/\\. ]|[/\\. ]PRCT[/\\. ]|[/\\. ]PRAT[ICE]*[/\\. ]'             ,poffense,0) <> '' and 	
             REGEXFIND('MEDICINE'                   ,poffense,0) <> '' and
						 REGEXFIND('UNLAW|[/\\. ]W[/]O[/\\. ]|[/\\. ]WO[/\\. ]|WITHOUT|[/\\. ]W[/]OUT[/\\. ]|UNLIC|VIO|UNAUT' ,poffense,0) <> '' => 'Y',
						 
             REGEXFIND('UNLIC'                      ,poffense,0) <> '' and 	
             REGEXFIND('MEDICINE'                   ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('CRIM[\\. ]|CRIMINAL'        ,poffense,0) <> '' and 	
             REGEXFIND('SIMUL |SIMULA'              ,poffense,0) <> '' => 'Y',
						 						 
						 REGEXFIND('FALSIF|FORG'                ,poffense,0) <> '' and 	
             REGEXFIND('WILL|CODICIL|CONVEY|CONTRA' ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('UNREG'                   ,poffense,0) <> '' and 	
             REGEXFIND('SECUR'                   ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('DECEPT'                  ,poffense,0) <> '' and 	
             REGEXFIND('WRIT'                    ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND(IDSET                     ,poffense,0) <> '' and 	
						 REGEXFIND('[/\\. ]USE[/\\. ]'                     ,poffense,0) <> '' and 
						 REGEXFIND('PERMIS'                  ,poffense,0) <> '' and 
             REGEXFIND('WITHOUT|[/\\. ]W[/]O[/\\. ]|[/\\. ]W[-]*O[/\\. ]|[/\\. ]NO[/\\. ]' ,poffense,0) <> '' => 'Y',
						 
 						 REGEXFIND('CHEAT'                   ,poffense,0) <> '' and 	
             REGEXFIND('CHEATHAM'                ,poffense,0) = '' => 'Y',
						 
						 REGEXFIND('IMPER'                   ,poffense,0) <> '' and 	
             REGEXFIND('PUB'                     ,poffense,0) <> '' and 
						 REGEXFIND('SERV'                    ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('EVAS[I ]|EVAD[EING ]|VIOL[ATION ]',poffense,0) <> '' and 	
             REGEXFIND('TAX'                              ,poffense,0) <> '' => 'Y',

						 REGEXFIND('FAIL'                    ,poffense,0) <> '' and 	
						 REGEXFIND('PAY'                     ,poffense,0) <> '' and 	
             REGEXFIND('TAX'                     ,poffense,0) <> '' => 'Y',

						 REGEXFIND(false_set                 ,poffense,0) <> '' and 	
             REGEXFIND('REPRESENT|TAX|UNEMPLOY|CLAIM|CITIZEN|CERTIF|AFFID|AFFIRM|AFFM|OBTAI[O]*N|OBT' ,poffense,0) <> '' => 'Y',

						 REGEXFIND('UNLAW'      ,poffense,0) <> '' and 	
						 ( (REGEXFIND('USE'                    ,poffense,0) <> '' and REGEXFIND('TITLE'                           ,poffense,0) <> '') OR
  						 (REGEXFIND('DISP[LACYINGED]*[/\\. ]',poffense,0) <> '' and REGEXFIND('LICENSE|[/\\. ]LIC[ENCSE]*[/\\. ]',poffense,0) <> '') OR //|SALE
							 (REGEXFIND('DISP[LACYINGED]*[/\\. ]',poffense,0) <> '' and REGEXFIND(IDSET                             ,poffense,0) <> '') OR
	  					 (REGEXFIND('TRADE'                  ,poffense,0) <> '' and REGEXFIND('PRACTI'                          ,poffense,0) <> '') OR
		  				 (REGEXFIND('DEAL'                   ,poffense,0) <> '' and REGEXFIND('FIDUC|FIDU '                     ,poffense,0) <> '') OR						 
			  			 (REGEXFIND('PYRAMID'                ,poffense,0) <> '' and REGEXFIND('SCHEME|SCHENE'                   ,poffense,0) <> '') OR
							 (REGEXFIND('[/\\. ]OBT[BAINING]*[/\\. ]'           ,poffense,0) <> '' and REGEXFIND('DMV'                             ,poffense,0) <> '') OR
							 (REGEXFIND('[/\\. ]FIN[NANCIAL]*[/\\. ]|FINA[N]*CE',poffense,0) <> '' and REGEXFIND('DISCLO|TRANS|ACTIV|CARD'         ,poffense,0) <> '') OR
							 (REGEXFIND('PROCEED'                               ,poffense,0) <> '' and REGEXFIND('[/\\. ]ACT'                             ,poffense,0) <> '' )
						 )=> 'Y',
				//		 
						 REGEXFIND(false_set+'|FICT'                ,poffense,0) <> '' and 	
						 ( REGEXFIND('PRETENSE|PRTENSE'             ,poffense,0) <> '' or
 						   (REGEXFIND('RECORD|[/\\. ]RCD[S]*[/\\. ]|ENTR|ENTER'   ,poffense,0) <> '' and REGEXFIND('PUB|CO[R]+P|GOV'            ,poffense,0) <> '') OR
  						 (REGEXFIND('[/\\. ]INFO[RMATION]*[/\\. ]|FALSE[ ]*INFO',poffense,0) <> '' and REGEXFIND('NAME|[/\\. ]APP[LICATIONSY]*[/\\. ]|GOV'      ,poffense,0) <> '') OR  //| OFF[I]*C[E]*R|[/\\. ]POLI[CE]*[/\\. ]|[/\\. ]LEO[/\\. ]|LAW ENF
							 (REGEXFIND('[/\\. ]INFO[RMATION]*[/\\. ]',poffense,0) <> '' and REGEXFIND(IDSET                        ,poffense,0) <> '') OR
	  					 (REGEXFIND('STATEMENT| RESID '           ,poffense,0) <> '' and REGEXFIND('[/\\. ]APP[LICATIONSY]*[/\\. ]|INSURANCE' ,poffense,0) <> '') OR
		  				 (REGEXFIND(IDSET                         ,poffense,0) <> '' and REGEXFIND('COMMIT'                     ,poffense,0) <> '') OR						 
			  			 (REGEXFIND('UTTER'                       ,poffense,0) <> '' and REGEXFIND('FRAUD|BANK|CHECK|PRESC|FORGE|CREDIT|DEBIT|CURRENCY|BILL|NOTE|INSTRU' ,poffense,0) <> '') OR
							 (REGEXFIND('DE[C]*LAR|DE[LC]+ARATION|[/\\. ]VERI[FICATION]*[/\\. ]|VERIFICATION'   ,poffense,0) <> '' and REGEXFIND('OF OWNER| PAWN[BROKER]* |METAL DEAL'    ,poffense,0) <> '' ) OR
							 (REGEXFIND('[/\\. ]APP[LICATIONSY]*[/\\. ]|ASST',poffense,0) <> '' and REGEXFIND('PROP|WELFARE',poffense,0) <> '' )
						 )=> 'Y',
						 
						  REGEXFIND(false_set              ,poffense,0) <> '' and 	
						  REGEXFIND('[/\\. ]INFO[RMATION]*[/\\. ]|FALSE[ ]*INFO|STATEMENT',poffense,0) <> '' and 
							(REGEXFIND('FIREARM|MEDICAID|P[A]*WN[ ]*BR[O]*KER|PAWNED| D[\\. ]L[\\. ]| [O][\\.]L[\\.]|METAL|RECORDS|BOARD AGRI|PRACTITIO|DEALER|'+
							          'FINANC| GUN |APPLICA| APPL[/ ]|SCHOOL|GAIN ACCESS|MEDICAL| AID |OWNERSHIP|CANDIDATE(.*)COMM| OATH |SEC OF STATE|MERCHANT| INSUR[ER]* |TITLE|'+
												'GINSENG|MET RECYCLER|VITAL RECORD|AGRICULTURE|CANDIDACY',poffense,0) <> '' OR 
							 (REGEXFIND('SALE|PURC[HASE]* | PUR '  ,poffense,0) <> '' and REGEXFIND(' FI | FIR[EARM]* | F/A |ALCOHOL| GU[N]* ' ,poffense,0) <> '') OR
  						 (REGEXFIND('HAND'               ,poffense,0) <> '' and REGEXFIND('PROP[ERTY]* '                     ,poffense,0) <> '' )						 
  					   )=> 'Y',				 
						              
						 REGEXFIND(false_set+'|FICT'      ,poffense,0) <> '' and 
             REGEXFIND('NAME|'+IDSET          ,poffense,0) <> '' and
						 REGEXFIND('AID'                  ,poffense,0) = ''  and
 						 REGEXFIND('ABET'                 ,poffense,0) = ''  => 'Y',	
						 
             REGEXFIND(false_set              ,poffense,0) <> '' and 	
						 REGEXFIND('PROCU'                ,poffense,0) <> '' and 
             REGEXFIND('LOAN|[/\\. ]CRED[/\\. ]|[/\\. ]CRD[/\\. ]|CREDIT' ,poffense,0) <> '' => 'Y',
						 REGEXFIND(Fraud                  ,poffense,0) <> '' => 'Y',						 

             REGEXFIND('UNAUT|UNLAW'          ,poffense,0) <> '' and 
             REGEXFIND('USE'                  ,poffense,0) <> '' and
						 ( REGEXFIND('DEBIT|CREDIT'       ,poffense,0) <> '' OR
						  (REGEXFIND(' CDT | CR[\\.]'+IDSET                   ,poffense,0) <> '' and REGEXFIND('CARD'          ,poffense,0)<> '') OR
							(REGEXFIND('[/\\. ]FIN[NANCIAL]*[/\\. ]|FINA[N]*CE' ,poffense,0) <> '' and REGEXFIND('CARD|[/\\. ]DEVI[/\\. ]|[/\\. ]DEV[/\\. ]',poffense,0)<> '') OR
							(REGEXFIND('[/\\. ]FIN[NANCIAL]*[/\\. ]|FINA[N]*CE' ,poffense,0) <> '' and REGEXFIND(IDSET           ,poffense,0)<> '') OR
							(REGEXFIND('[/\\. ]DR[IVE]*[/\\. ]|DRIVER'          ,poffense,0) <> '' and REGEXFIND(LIC_set         ,poffense,0)<> '') 
							)=> 'Y',
							
							REGEXFIND('FR[\\.]'             ,poffense,0) <> '' and 
							REGEXFIND('CR[\\.]'             ,poffense,0) <> '' and 
						  REGEXFIND('CARD'                ,poffense,0) <> '' => 'Y',
							
						 REGEXFIND('FOOD'              ,poffense,0) <> '' and 
						 REGEXFIND('STAMP|[/\\. ]STPS[/\\. ]|STMP'   ,poffense,0) <> '' => 'Y',
	
						 //QA Update - Fraud Round 6
						 REGEXFIND('FALSE PERSONATION|HEALTH PROFESSION - UNAUTHORIZED PRACTICE'    ,poffense,0) <> '' => 'Y',
						 
             REGEXFIND(Identity_Theft ,poffense,0) <> '' AND 
             REGEXFIND(IT_exc         ,poffense,0) = '' AND
						 (REGEXFIND(IT_exc2a      ,poffense,0) <> '' OR
						  (REGEXFIND(IT_exc2b1 ,poffense,0) <> '' AND REGEXFIND(IT_exc2b2 ,poffense,0) <> '' ))
							=> 'Y',
	
						 REGEXFIND('DECEPTIVE'              ,poffense,0) <> '' and 
						 REGEXFIND('PRACTICE'               ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('FALSE'                  ,poffense,0) <> '' and 
						 REGEXFIND('INFORMATION'            ,poffense,0) <> '' and 
						 REGEXFIND('PUBLIC OFFICIAL'        ,poffense,0) <> '' => 'Y',						 

						 REGEXFIND('VIOL[ATION ]'           ,poffense,0) <> '' and 
						 REGEXFIND('BANK'                   ,poffense,0) <> '' and 
						 REGEXFIND('LAW'                    ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('FALSE'                  ,poffense,0) <> '' AND              
						 REGEXFIND('INFO'                   ,poffense,0) <> '' AND              
						 REGEXFIND('ID|DR|NAME|APP|GOV'     ,poffense,0) <> '' => 'Y',
						 
						 'N');
return Is_it;
end;																	
//--------------------------------------------------------------------------------------------------------------------------------------

export Is_Gambling(string poffense_in) := function //done

special_characters:= '~|=|!|-|%|\\^|\\+|:|\\(|\\)|,|;|_|#|%|@|\\*|<|>|"|`|\\[|]|\\{|\\}|\\\\|\\\'';
poffense          := ' '+REGEXREPLACE(special_characters, poffense_in, ' ');

Gambling                       := 'GAMBL[ING]*|GAMING|[/| ]BETTING|BOOKMAK[INGER]*';
gam1                           := ' SPORT';
gam2                           := 'BRIB|GAM';
  
Is_it := MAP(In_Global_Exclude(poffense,'other')='Y' => 'N',
             
						 // trim(poffense) in _fmod_offense_category_list.GamblingList =>'Y', 

             REGEXFIND('[/\\. ]MAK[INGER]*[/\\. ]' ,poffense,0) <> '' and 	
             REGEXFIND('BOOK ' ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('DICE' ,poffense,0) <> '' and 	
             REGEXFIND('GAME' ,poffense,0) <> '' => 'Y',

						 REGEXFIND('SLOT' ,poffense,0) <> '' and 	
             REGEXFIND('MACHINE' ,poffense,0) <> '' => 'Y',
						 
             REGEXFIND('POOL' ,poffense,0) <> '' and 	
						 REGEXFIND('SELL' ,poffense,0) <> '' and 	
             REGEXFIND('BOOK' ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('WAGER|GAMB|GAMG|GAMP' ,poffense,0) <> '' and 	
             REGEXFIND('JUDGE' ,poffense,0) = '' => 'Y',
						 
             REGEXFIND(gam1 ,poffense,0) <> '' and 	
             REGEXFIND(gam2 ,poffense,0) <> '' => 'Y',
             REGEXFIND(Gambling ,poffense,0) <> '' => 'Y',	
						 
						 REGEXFIND('LOTTERY' ,poffense,0) <> '' and 	
             REGEXFIND('TICKET| LAW ' ,poffense,0) <> '' => 'Y',

							 'N');
return Is_it;
end;

//--------------------------------------------------------------------------------------------------------------------------------------

export Is_HumanTrafficking(string poffense_in) := function //done

special_characters    := '~|=|!|-|%|\\^|\\+|:|\\(|\\)|,|;|_|#|@|\\*|>|"|`|\\[|]|\\{|\\}|\\\\|\\\'';
poffense              := ' '+REGEXREPLACE(special_characters, poffense_in, ' ');

// FRAUD / FAIL TO PAY LABORERS, MAN, FOR WORK VALUED A

child_set := '[/\\. ]CHLD[/\\. ]|[/\\. ]CHIL[DREN]*[/\\. ]|MINOR|JUV';
Is_it := MAP(In_Global_Exclude(poffense,'other')='Y' => 'N',

             // trim(poffense) in _fmod_offense_category_list.HumanTraffickingList =>'Y',
						 
             REGEXFIND(' COMM[ERCIAL]*[/\\. ]'  ,poffense,0) <> '' and 
						 REGEXFIND('SEX|NUDITY'             ,poffense,0) <> '' and
						 //Roger's comment - QA Update - Human Trafficking  Round 3 8/26/16
						 REGEXFIND('BURG |ASSA[/|U]|A[S]*LT'             ,poffense,0) = ''  => 'Y',	
						 
						 REGEXFIND('TRANS[PORT]*[/\\. ]'    ,poffense,0) <> '' and 
						 REGEXFIND('MINOR '                 ,poffense,0) <> '' and 
						 REGEXFIND('INDECENT '              ,poffense,0) <> '' => 'Y',	
						 
             REGEXFIND('[/\\. ]SLAV[/\\. ]|LABOR|PROST|PORNO',poffense,0) <> '' and 
             REGEXFIND('FORC|COERC|THREAT',poffense,0) <> '' => 'Y',	 
						 
						 REGEXFIND('TRANSP',poffense,0) <> '' and 
						 REGEXFIND(child_set+'|ALIEN',poffense,0) <> '' and 	
             (REGEXFIND('BED|ORDER|INTOX|DUI|D\\.U\\.I|D\\.U\\.|DWI|D\\.W\\.I|SAFETY|WEAP|ESCAPE|[/\\. ]CDS[/\\. ]|'+
						            'ALCOH|BEER|DRUGS|LIQ|INTOX|SECU|CUSTODY|FAIL|TRUCK|[/\\. ]P[/]U[/\\. ]|REAR|REST|UNSECU|SEAT|DIVISION|TEST|MARI',poffense,0) = '' and
						  (REGEXFIND('MOTION',poffense,0) = ''          AND REGEXFIND('TO',poffense,0) = '' and
							 REGEXFIND('UND|UNDER|LESS',poffense,0)  = '' AND REGEXFIND('INFLU|FOUR|4|FIVE|5',poffense,0) = '' and
							 REGEXFIND('PICKUP',poffense,0)  = ''         AND REGEXFIND('TR',poffense,0) = '' ) 
						 ) => 'Y',							 
						 
						 REGEXFIND('SOLICIT|EXPLOIT|CAUS| LURE| LURI|SEDUCE|SEDUCI|PAND',poffense,0) <> '' and 
						 REGEXFIND('PROST|PORNO',poffense,0) <> '' and 	
             REGEXFIND(child_set,poffense,0) <> '' => 'Y',	 
						 
						 REGEXFIND('HUMAN',poffense,0) <> '' and 
             REGEXFIND('TRAF[/F]|SMUGGL|[/\\. ]TRA[<]|TRFC[ :]',poffense,0) <> '' => 'Y',
						 
						 REGEXFIND(child_set+'|PERSON|UDOC',poffense,0) <> '' and 
             REGEXFIND('TRAFFICK',poffense,0) <> '' and 
						 Is_Drug_Narcotic(poffense) = ''
						 => 'Y',

						 //QA Update - Human trafficking round 6
						 REGEXFIND('TRAVEL[ING]* TO MEET',poffense,0) <> '' and 
             REGEXFIND('MINOR|CHILD|PARENT|SOLIC|GUARDIAN',poffense,0) <> ''  => 'Y',
						 
						 REGEXFIND(' PC 236 ',poffense,0) <> ''  => 'Y',
						 

						 'N');
return Is_it;
end;

//--------------------------------------------------------------------------------------------------------------------------------------

export Is_Kidnapping_Abduction(string poffense_in) := function //done
                                            

special_characters    := '~|=|!|-|%|\\^|\\+|:|\\(|\\)|,|;|_|#|@|\\*|>|"|`|\\[|]|\\{|\\}|\\\\|\'';
poffense              := ' '+REGEXREPLACE(special_characters, poffense_in, ' ');
false_set             := 'FALSE|[/\\. ]FAL[STEIFYNG]*[/\\. ]|[/\\. ]FAL[SFEID]*[/\\. ]|[/\\. ]FLS[ELY]*[/\\. ]|[/\\. ]FAL[SFICATION]*[/\\. ]|FALSIFICATION';

Kidnapping_Abduction  := 'CHILD STEALING|HIJACKING|AB[U]*D[U]*CT|KI[DA]+[N]*A[P]+ING|K[I]*DN[A]*P|HOSTAGE|KIDANP|KIDKNA|HIJACKIDNG|PC 236 |PC 207 A ';

Is_it := MAP(In_Global_Exclude(poffense,'other')='Y' => 'N',
           
             // trim(poffense_in) in _fmod_offense_category_list.KidnappingList =>'Y',

             REGEXFIND('UNLAW'                       ,poffense,0) <> '' and 
						 REGEXFIND('IMPRIS|RESTR|DENTEN|DETEN'   ,poffense,0) <> '' and  
						 REGEXFIND('DOG|ANIMAL'                  ,poffense,0) =  '' => 'Y',
						 
             REGEXFIND('CH[I]*LD|MINOR|JUV|KID'      ,poffense,0) <> '' and 
             REGEXFIND('LURE|LUR|ENTIC|ABDUC'        ,poffense,0) <> '' and                                                                                                                                                                  
						 REGEXFIND('PROST|PORN|FAILURE'          ,poffense,0) = ''  => 'Y',
						 
             REGEXFIND('RESTRAIN'                    ,poffense,0) <> '' and 
						 REGEXFIND('CRIM|IMPRIS|FELON|ABUSE'     ,poffense,0) <> '' and 
						 REGEXFIND('ORDER'                       ,poffense,0) = '' => 'Y',
                                                                 
             REGEXFIND('IMPRISIO'                    ,poffense,0) <> '' and 
						 REGEXFIND(false_set+'[/\\. ]UNL[FULY]*[/\\. ]'               ,poffense,0) <> ''  => 'Y',
						 
						 REGEXFIND('[/\\. ]AGG[RAVTED]*[/\\. ]|[/\\. ]ATT[EMPTED]*[/\\. ]| ATTPT '                     ,poffense,0) <> '' and 
						 REGEXFIND('[/ \\.]KI[D]+[/ \\.]|KIDNAP'       ,poffense,0) <> ''  => 'Y',           

             REGEXFIND('CONFIN'                      ,poffense,0) <> '' and 
						 REGEXFIND('ESCAP|DOG|ANIMA|INFANT|SAFETY|CARE|SEAT|PET|BULL|SHEP| NO |CAT|W[/]O|FAIL' ,poffense,0) = ''  => 'Y',

             REGEXFIND(Kidnapping_Abduction          ,poffense,0) <> '' => 'Y',	               
							 'N');
return Is_it;
end;
//--------------------------------------------------------------------------------------------------------------------------------------

export Is_Shoplifting(string poffense_in) := function //done

special_characters    := '~|=|!|-|%|\\^|\\+|:|\\(|\\)|,|;|_|#|%|\\*|<|>|"|`|\\[|]|\\{|\\}|\\\\|\\\'';
poffense              := ' '+REGEXREPLACE(special_characters, poffense_in, ' ');
                               
shopl                   := '^[ ]*TH[E]*FT[ ]*SHOP|SHOP[L]+[OI]FT|SHOPFTING|[ ]SHOPL[\\. ]+|[ ]*SHOP[T ]*L[IGFS]+[TING]*|SHO[PF]+[ ]*LIFT|SHOPLFT|[/ ]SHOP[LIFTING]+[/ ]';                                                                           
                                          
Shopl_exc               := 'CHILD STEAL|BURG|VE[C]*H|AUTO|M/V|DECLARCATION|[/ ]M[/]*V[/ ]|CHOP|D[OCTO]*R SHOP|DRESS SHOP';

Larceny                 := 'LAR[A]*C[AENY]*|LAR[AC]+[ENY]|STEAL|SAFECRACK|TH[E]*FT';
Is_it := MAP(In_Global_Exclude(poffense,'other')='Y' => 'N',             					 
             	  
						 // REGEXFIND(Shopl ,poffense,0) <> '' and 
						 // REGEXFIND(Larceny ,poffense,0) <> '' => 'Y',	
						 
						 REGEXFIND(Shopl ,poffense,0) <> '' and 
						 REGEXFIND(Shopl_exc ,poffense,0) = '' => 'Y',
						 						 	 	               
						'N');						 
				 
return Is_it;
end;

//--------------------------------------------------------------------------------------------------------------------------------------

export Is_theft(string poffense_in) := function //done

special_characters    := '~|=|!|-|%|\\^|\\+|:|\\(|\\)|,|;|_|#|%|\\*|<|"|`|\\[|]|\\{|\\}|\\\\|\\\'';
poffense              := ' '+REGEXREPLACE(special_characters, poffense_in, ' ');
              
Burglary_BreakAndEnter := 'BUROLARY|BUR.LARY|BURBULARY|BURG[/\\. ]|B[RU]+GL|BRGLY|BRG[/]|BRG[/0-9 ]|BUR[LG]+|BYRG|BURG[\\. LK]*|B[OUR]+[GR]+[GLAEY]+R[Y]*|'+
                          'BREAK[ING]* [&] ENTER[ING]*|B[&][ ]*E|[/ ]B[ ]*AND[ ]E| BANDE |B[&]E |B[/]E |BREAKING INTO|HOUSE(.*)BREAK|INVASION';       

Larceny                 := 'LAR[A]*C[AENY]*|LAR[AC]+[ENY]|STEAL|SAFECRACK|TH[E]*FT';
Larceny_exc             := 'CHILD STEAL|VE[C]*H|AUTO|[-/ ]M[/]*V[-/ ]|DECLARCATION';

shopl                   := '^[ ]SHOP |TH[E]*FT[ ]*SHOP|SHOP[L]+[OI]FT|SHOPFTING|X[ ]*SHOP[ ]|[- ]SHOP[L\\.]+|SHOP[L\\.]+|[- ]*SHOP[-T ]*L[IGFS]+[TING]*|SHO[PF]+[ ]*LIFT|SHOPLFT|[/ ]SHOP[LIFTING]*[/ ]';                                                                           

Extortion_Blackmail     := 'EXTORT|BLACK[ ]*MAIL|RACKET| RICO ';
EB_exc                  := 'BRACKET';

Embezzlement            := 'B[B]*REACH OF TRUST|EXPLOIT[ATION]*|EMBZ|EMBEZ[ZLE]*|EMZEZZLE';
Emb_ecl                 := 'SEX|PORN|CHILD|MINOR|JUVE';
E1a := 'CORRUPT';
E1b := 'MINOR|JUVE|CHILD';
E2a := 'BREACH';
E2b := 'PEAC[E]*';

Is_it := MAP(In_Global_Exclude(poffense,'other')='Y' => 'N',

             // trim(poffense) in _fmod_offense_category_list.TheftList =>'Y',
						 
						 REGEXFIND('THEFT[ ]*[ \\-]*[BY ]*CONTROL'  ,poffense,0) <>'' => 'Y',
						 
             REGEXFIND(shopl                ,poffense,0) <> '' => 'N',
						 REGEXFIND('^IDENT| IDENT|^ID |IDENTIFY'    ,poffense,0) <> '' and 
             REGEXFIND('TH[E]*FT|TEFT|TEHT|[^| ]FRAUD|INTIMIDAT|CONCEAL' ,poffense,0) <> '' => 'N',
						 
						 // Roger's comment - QA Updates -Theft Round 5 10/11/16
						 REGEXFIND('STOLEN|THEFT[\\(|/| ]|LARC[ |E]',poffense,0) <> '' and 
						 REGEXFIND('AUTO|VEHICLE'       ,poffense,0) <> '' and 
						 REGEXFIND('TAG'          			,poffense,0) <> '' => 'Y',	
						 
						 REGEXFIND('GRAND THEFT'        ,poffense,0) <> '' and 
						 REGEXFIND('MOTOR VEHICLE|AUTO|VEHICLE|M/VEHICLE|MTR VEH| VEH | MV ' ,poffense,0) =  '' => 'Y',
						 						 
						 REGEXFIND(' PC 484 | PC 666 |PC 484E D |PC 484G A |PC 484G | PC 508 |PC 537 A | PC 485 | PC 503 | 2913\\.02 |PC 487 [ABC] |PC 487\\.1| PC 487 | PC 488 |PC 532 A ' ,poffense,0) <> '' => 'Y',
						 
             REGEXFIND('STOL[EN]*|STLN'     ,poffense,0) <> '' and 
             REGEXFIND('TH[E]*FT|REC[EIV]*|RCV|RVC|POSS|GOODS|PROP|CONCEAL|BUY|SELL|SALE|TRANS' ,poffense,0) <> '' => 'N',
						 
						 REGEXFIND('REC[EIV]*|RCV'      ,poffense,0) <> '' and 
             REGEXFIND('TH[E]*FT'           ,poffense,0) <> '' and 
						 REGEXFIND('DIRECT'             ,poffense,0) = '' => 'N',

             REGEXFIND(Embezzlement            ,poffense,0) <> '' and 
						 REGEXFIND(Emb_ecl                 ,poffense,0) = '' => 'Y',	               
						  

						 // Roger's comment - 7/15 QA Updates -Theft
						 // Roger's comment - QA Updates -Theft Round 3 8/26
						 // Roger's comment - QA Updates -Theft Round 4 9/23
						 REGEXFIND('TH[E]?FT|UNAUTH[O|I]*[RIZED]* USE[ |/]|LARC[ENY]*[ |/]|STEALING|G/T USE',poffense,0) <> '' and 
						 REGEXFIND('AUTO|VE[C]*H|[/\\. ]M[/]*V[H/ ]+| M[/]*V |M\\.V[\\.]?| ATV '+
						           '|M V TA| MVT| M/VEH',poffense,0) <> '' and
						 // REGEXFIND('^EMBEZZLE|AMENDED TO EMBEZZ|USE VEH TO |FROM MV| TAG',poffense,0) = ''  => 'N',
						 REGEXFIND('AMENDED TO EMBEZZ|USE VEH TO |FROM MV| TAG',poffense,0) = ''  => 'N',
						 
						 // Roger's comment - QA Updates -Theft Round 4 9/23
             REGEXFIND('OMVWOC|^U[\\.]?U[\\.]?M[\\.]?V| U[\\.]?U[\\.]?M[\\.]?V| UNMV|STEAL[ING]*MV|MVTHEFT' ,poffense,0) <> '' => 'N',
						 
						 REGEXFIND(Larceny              ,poffense,0) <> '' and 
						 REGEXFIND('CHOP SHOP'          ,poffense,0) <> '' => 'Y',	

						 REGEXFIND(' G[/]T '                                        ,poffense,0) <> '' and 
						 REGEXFIND('MORE|DWELL| RES | ATT[EMPT]* | COMM |OVER | > ' ,poffense,0) <> '' and 
						 REGEXFIND('AUTO|VE[C]H*|[/\\. ]M[/]*V[H/ ]+| M[/]*V '      ,poffense,0) = '' => 'Y',
						 
						 REGEXFIND('SAFE CRACK'          ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('UNLAW'  ,poffense,0) <> '' and 	
						 (                                                     
 						   (REGEXFIND('GAS' ,poffense,0) <> '' and REGEXFIND('APPROPRIAT[I]*ON' ,poffense,0) <> '') OR
  						 (REGEXFIND('TAK' ,poffense,0) <> '' and REGEXFIND('TEFT|TEHFT'  ,poffense,0) <> '') OR
	  					 (REGEXFIND('FAIL',poffense,0) <> '' and REGEXFIND('RTRN'          ,poffense,0) <> '' AND REGEXFIND('RENTD' ,poffense,0) <> '' )
						 )=> 'Y',
						 
						 REGEXFIND('FARE'  ,poffense,0) <> '' and 	
						 (
 						   (REGEXFIND('PAY|VIOL' ,poffense,0) <> '' and REGEXFIND('FAIL|RAIL|PAIL|NOT| NO |FAIR' ,poffense,0) <> '') OR
  						 REGEXFIND('EVAS[I]*ON' ,poffense,0) <> '' 
						 )=> 'Y',
						 
					   REGEXFIND('DRIV'                  ,poffense,0) <> '' and 
             REGEXFIND('WITHOUT|[/\\. ]W[/]O[/\\. ]'         ,poffense,0) <> '' and 
						 REGEXFIND('PAYING'                ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('FAIL'                  ,poffense,0) <> '' and 
             REGEXFIND('RET|REDEL'             ,poffense,0) <> '' and 
						 REGEXFIND('LEAS|RENT'             ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('UNAUT'                 ,poffense,0) <> '' and 
             REGEXFIND('USE'                   ,poffense,0) <> '' and 
						 REGEXFIND('PROP'                  ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('RIDE|RIDING|LEAV'      ,poffense,0) <> '' and 
             REGEXFIND('PAY'                   ,poffense,0) <> '' and 
						 REGEXFIND('WITHOUT|[/\\. ]W[/]O[/\\. ]'         ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('PURSE'                      ,poffense,0) <> '' and 
						 REGEXFIND('SNACH|SNAT|STEL|STOL|STEAL' ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('POCKET'                     ,poffense,0) <> '' and 
						 REGEXFIND('BOOK'                       ,poffense,0) <> '' and
						 REGEXFIND('SNACH|SNAT|STEL|STOL|STEAL' ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('POCKET'                     ,poffense,0) <> '' and 
						 REGEXFIND('BOOK'                       ,poffense,0) <> '' and
						 REGEXFIND('SNACH|SNAT|STEL|STOL|STEAL' ,poffense,0) <> '' => 'Y',
						 
             REGEXFIND('POCKET'                     ,poffense,0) <> '' and 
						 REGEXFIND('PICK'                       ,poffense,0) <> '' => 'Y',							                          
						 
						 REGEXFIND(Burglary_BreakAndEnter       ,poffense,0) <> '' and
						 REGEXFIND(Larceny_exc                  ,poffense,0) = ''  and
	           REGEXFIND(shopl                        ,poffense,0) = ''  and 
	           REGEXFIND('LAR[A]*C|THEFT'             ,poffense,0) <> '' and 
						 REGEXFIND('RED'                        ,poffense,0) <> '' => 'Y',						 
						 
             REGEXFIND(Larceny                 ,poffense,0) <> '' and 
						 REGEXFIND(Larceny_exc             ,poffense,0) = '' => 'Y',	         
						 
//Extortion expressions          
						 REGEXFIND('ORGANIZ| ORG|^ORG'     ,poffense,0) <> '' AND 
						 REGEXFIND('CRIM|CORR'             ,poffense,0) <> '' => 'Y',	
						 						 
						 REGEXFIND('ENGAG'                 ,poffense,0) <> '' AND 
						 REGEXFIND('COR'                   ,poffense,0) <> '' AND 
						 REGEXFIND('ACTIV'                 ,poffense,0) <> '' => 'Y',						 
						 
             REGEXFIND(Extortion_Blackmail     ,poffense,0) <> ''  AND
						 REGEXFIND(EB_exc                  ,poffense,0) = '' => 'Y',
						 
//Embezzlement
             REGEXFIND('MISAPP'                ,poffense,0) <> '' and
             REGEXFIND('MONEY|[/\\. ]ID[/\\. ]|[/\\. ]FID[/\\. ]|FUNDS|PROP|[/\\. ]PAY[/\\. ]' ,poffense,0) <> '' => 'Y',
						 
             REGEXFIND('WRONGFUL'              ,poffense,0) <> '' and
             REGEXFIND('APPRO'                 ,poffense,0) <> '' => 'Y',
						 
             REGEXFIND('MISAPPLY'              ,poffense,0) <> '' and
             REGEXFIND('ENTRUST|PROP|FUND'     ,poffense,0) <> '' => 'Y',

						 //QA Update - Theft Round 6
             REGEXFIND('W/OUT PAY|F/T[ |/]PAY'              ,poffense,0) <> '' and
             REGEXFIND('LEAVING GAS STATION|REST'     ,poffense,0) <> '' => 'Y',
						 
             REGEXFIND(E2a                     ,poffense,0) <> '' and 
             REGEXFIND(E2b                     ,poffense,0) = '' => 'Y',
						 
						 REGEXFIND('812\\.014\\.2C1|GRAND[ ]*>|GRAND TFT PROP',poffense,0) <> '' => 'Y',

						 REGEXFIND('EVAS[I ]|EVAD[EING ]|VIOL[ATION ]' ,poffense,0) <> '' and 	
             REGEXFIND('TAX|TOLL'                          ,poffense,0) <> '' => 'Y',

						 REGEXFIND('FAIL| FT '               ,poffense,0) <> '' and 	
						 REGEXFIND('PAY'                     ,poffense,0) <> '' and 	
             REGEXFIND('TAX|TOLL'                ,poffense,0) <> '' => 'Y',	
						 
						 REGEXFIND('CONCEAL|CONCCEAL|CONCEAML|CONCELAM',poffense,0) <> '' and 
						 REGEXFIND('SHOPLIFT|[/\\. ]MERCH[/\\. ]|MERCH[ANDISE]+'      ,poffense,0) <> '' => 'Y', 
						'N');						 
				 
return Is_it;
end;

//-------------------------------------------------------------

export Is_PeepingTom(string poffense_in) := function //done
  // Please select offenses containing NUD and also contain CAPT  and also contain IMAG. 
 
special_characters:= '~|=|!|-|%|\\^|\\+|:|\\(|\\)|,|;|_|#|@|\\*|<|>|"|`|\\[|]|\\{|\\}|\\\\|\'';
poffense          := ' '+REGEXREPLACE(special_characters, poffense_in, ' ');

PeepingTom   := 'PEEP|VOY[EU]';

Is_it := MAP(In_Global_Exclude(poffense,'other')='Y' => 'N',
             
						 // trim(poffense_in) in _fmod_offense_category_list.PeepingTomList =>'Y', 

             REGEXFIND('NUD'  ,poffense,0)              <> '' and
						 REGEXFIND('CAPT' ,poffense,0)              <> '' and
             REGEXFIND('IMAG' ,poffense,0)              <> '' => 'Y',

             REGEXFIND(PeepingTom ,poffense,0)          <> '' => 'Y',	               
							 'N');
return Is_it;
end;

//--------------------------------------------------------------------------------------------------------------------------------------

export Is_Prostitution(string poffense_in) := function //done
special_characters    := '~|=|!|-|%|\\^|\\+|:|\\(|\\)|,|;|_|#|%|\\*|<|>|"|`|\\[|]|\\{|\\}|\\\\|\\\'';
poffense              := ' '+REGEXREPLACE(special_characters, poffense_in, ' ');
Prostitution                   := 'PROSI|PRSTIT|PROTIT|PROST|PIMP|PAND|PC 647 B ';
P_exc                          := 'EXPAND|PANHAND';
Is_it := MAP(In_Global_Exclude(poffense,'other')='Y' => 'N',

             REGEXFIND('COMMERC'    ,poffense,0) <> '' and 
						 REGEXFIND('SEX'        ,poffense,0) <> ''  => 'Y',	
						
						 REGEXFIND('FORNICAT'   ,poffense,0) <> '' and 
						 REGEXFIND('MONEY'      ,poffense,0) <> ''  => 'Y',
						 
					   REGEXFIND('PROMOTE'    ,poffense,0) <> '' and 
						 REGEXFIND('SEX'        ,poffense,0) <> '' and 
						 REGEXFIND('ACTIV|RELATIONS|IMMORALITY|INTER' ,poffense,0) <> ''  => 'Y',
						 
             REGEXFIND(Prostitution ,poffense,0) <> '' and
						 REGEXFIND(P_exc        ,poffense,0) = ''  => 'Y',	               
							 'N');
return Is_it;
end;
//Determine input expression is SOF(SexOffenseForcible), SONF(SexOffenseNonForcible), or NA
shared determine_SOF_SONF(string poffense) := function
	result := MAP(REGEXFIND('FAIL[ |\\.|/|U]| FT[/| ]|F/T' 			 ,poffense,0) <> '' and
								REGEXFIND('REGISTER|REIGISTER|REG |REQ[I| ]|RESISTER',poffense,0)   <> '' and
								REGEXFIND('OFFEND'            		 ,poffense,0) <> '' 
								=> 'SONF',
								REGEXFIND('SEX'        						 ,poffense,0) <> '' and 
								REGEXFIND('OFF'                		 ,poffense,0) <> '' and
								REGEXFIND('REG|ADDR|[/\\. ]VIO[LATIONG]*[/\\. ]|[/\\. ]VIO[LATED]*[/\\. ]|VIOLATION|UPDATE|CHG |CHANG', poffense,0)   <> ''   
								=> 'SONF',
								REGEXFIND('SEX OF'     						 ,poffense,0) <> '' and 
								REGEXFIND('CHG ADDR'							 ,poffense,0) <> ''   
								=> 'SONF',
						    REGEXFIND('FAIL[ |\\.|/|U]| FT[/| ]|F/T' 			  ,poffense,0) <> '' and
								REGEXFIND('COMP|CMPLY' ,poffense,0) <> '' and
                REGEXFIND('[/\\. ]SEX[UAL]*[/\\. ]',poffense,0) <> '' and 
								REGEXFIND('OFF|REG'        ,poffense,0) <> ''   
							  => 'SONF',
						    REGEXFIND('FAIL[ |\\.|/|U]| FT[/| ]|F/T' 			  ,poffense,0) <> '' and
							  REGEXFIND('OFFEND'     ,poffense,0) <> '' and      
                REGEXFIND('ADD[\\.R]|STATUS| STAT |CHG |CHNAG',poffense,0) <> '' 
							  => 'SONF',      
						    REGEXFIND('FAIL[ |\\.|/|U]| FT[/| ]|F/T' 			  ,poffense,0) <> '' and
						    REGEXFIND('SEX' ,poffense,0) <> ''           AND
						    REGEXFIND('REGISTER|REG[ |/|\\.]|REGIS[ |T|\\.]|RGSTR |REISTER |RGST |COMPLY|COMP|VERIFY|PROVIDE|'+
							            'ADD |CHANGE|CHNG|CHG |IDENTIFY|POSSESS|PREVENT|ABUSE|PAY COST|MAINT RECORD' ,poffense,0) <> ''  
							  => 'SONF',
						    REGEXFIND('FAIL[ |\\.|/|U]| FT[/| ]|F/T' 			  ,poffense,0) <> '' and
	              REGEXFIND('SEX' ,poffense,0) <> ''           AND
	              REGEXFIND('OFF|PRED|VIOL|ASSLT' ,poffense,0) <> '' AND
							  REGEXFIND('REG |REGISTER|REP[O]?RT|RPT|REP |RPRT|REPT|NOTIFY|GIV NOT|COMPLY|COMP |PROVIDE|'+
								          'VERIFY|PROPERTY R|/R/|DL/ID|TO RP' ,poffense,0) <> ''  
							  => 'SONF',
						    REGEXFIND('FAIL[ |\\.|/|U]| FT[/| ]|F/T' 			  ,poffense,0) <> '' and
							  REGEXFIND('REGISTER|REIGISTER| REG '						,poffense,0) <> '' and
	              REGEXFIND('OFFEND'            									,poffense,0) <> '' and
							  REGEXFIND('[/| ]GUN| CAREER'            				,poffense,0) =  '' 
								=> 'SONF',
							  REGEXFIND('FAILREGISTASSEXOFNDANULY'						,poffense,0) <> '' 
								=> 'SONF',
							  REGEXFIND('SEX OFFENDER FAIL TO'								,poffense,0) <> '' 
								=> 'SONF',
						    REGEXFIND('STAT[A|U|O]*[T]*ORY|STAT |\\-STAT |STAT\\.|STATUTAORY' ,poffense,0) <> '' and
						    REGEXFIND('SODOMY[\\-| ]|S[O]?DMY[\\-| |1]|RAPE[\\-|\\.| |1]+|INTERCOURSE|CARNAL[\\-| ]' ,poffense,0) <> ''   
							  => 'SONF',
							 
								'NA');
	RETURN result;
end;


//--------------------------------------------------------------------------------------------------------------------------------------


export Is_SexOffensesForcible(string poffense_in) := function //done

special_characters    := '~|=|!|-|%|\\^|\\+|:|\\(|\\)|,|;|_|#|%|\\*|>|"|`|\\[|]|\\{|\\}|\\\\|\\\'';
poffense              := ' '+REGEXREPLACE(special_characters, poffense_in, ' ');

SexOffensesForcible     := 'AT[TE]*MP[T]*[/\\. ]CSC[/\\. ]|^[ ]*[/\\. ]ATT CSC[/\\. ]|^[ ]*[/\\. ]C[\\. ]*S[\\. ]*C[/\\. ]|DEG(.*)CSC|'+
                           'MOLES|RAPE|[/\\. ]SEX[/\\. ]|SODOM|SODOOMY|SODOBY|SODONY|PENETRAT[ION]*|INTERCOU| IDSI |'+
													 'PC 243\\.4 A |PC 288 [ABC] |PC 261 [A] | PC 220 ';

SexOffensesForcible_exc := 'WRONG SEX|ALLIGATOR|STATU[T]*[AORY]+|INCEST|STAT RAPE|PERFORM|PORN|FILM|MOVIE|TECH|MATERI|CARJACKING|'+
                           'IMPERSON|PROMOTE|PRODUCE|VIDEO|WILDLIFE|COIN|VEND|VE[C]*H|REPRODUC|AUTO| M[/]*V |PRODUCTION|PLATESEXP|'+
													 'PAY COST|POSS PHOTO|SEX MAT|SEXUAL MATERIAL|PERF BY A CHILD|RECORD SEX ACT';

Assault         := 'ABDOM|ABDGR|ABGEN|ABOFF|ABHAN|ABWIK|ABWITK|BATTER|ASSL|ASS[AU]+L[T]*|AS[SL]*LT|CRUELTY|DOM[.MESTIC ]+VIO|DOMESTI(.*) ABUSE|INTIMIDAT|PHYSICAL HARM|RETALIATION';
Assault2        := '^[ ]*A[.& ]+B[.]* |^[ ]*A AND B | A[ ]*&[ ]*B |A[ ]*&[ ]*B$|A[.& ]+B[. ]+H[ .&]+A[. ]+N[. ]*|A[. ]+B[. ]+W[ .]+I[. ]+K[. ]*|A[. ]+B[. ]+W[ .]+I[. ]+T[. ]+K[. ]*';
// assault_ext     := 'SEX|RAPE|MOLES|CARNAL|PENETRAT|INTERCOU|SODOM';
assault_ext     := 'SEX|RAPE|MOLES|PENETRAT';
child_set       := 'M[OI]NOR|[/\\. ]MIN[/\\. ]|JUV|CHI[U]*LD[REN]*|[/\\. ]CHI[KLD]*[/\\. ]|[/\\. ]CH[I]*L[TDEF][/\\. ]|[/\\. ]CHLD[</\\. ]|[/\\. ]CHILED[/\\. ]| CHITL ';

  Is_it := MAP(In_Global_Exclude(poffense,'other')='Y' => 'N',
							 // Roger's comment - QA Update - Sex Offenses Forcible
							 determine_SOF_SONF(poffense)='SONF' => 'N',
							
						   REGEXFIND('PARAPE'                ,poffense,0) <> '' => 'N',
							 // trim(poffense) in _fmod_offense_category_list.SexOffensesForcibleList =>'Y', 
							 							 
							 REGEXFIND('THERAPE'               ,poffense,0) <> '' and 
							 REGEXFIND('RAPE'                  ,poffense,0) <> '' => 'Y',
							 
            	 REGEXFIND('LEWD|LASCIVIOUS'       ,poffense,0) <> '' => 'Y',
							 // REGEXFIND('M[OI]NOR|[/\\. ]MIN[/\\. ]|JUV|CHILD|[/\\. ]CH[I]+[LED]*[/\\. ]|CHLD|DA[UH]GHTER| < |YOA|[/\\. ]YR[/\\. ]| Y |LESS THAN| AGE ' ,poffense,0) = '' => 'Y',
							 
               REGEXFIND('LASC'                  ,poffense,0) <> '' and 
							 REGEXFIND('UNNATURAL'             ,poffense,0) <> '' => 'Y', 
							 // REGEXFIND('M[OI]NOR|[/\\. ]MIN[/\\. ]|JUV|CHILD|[/\\. ]CH[I]+[LED]*[/\\. ]|CHLD|DA[UH]GHTER| < |YOA|[/\\. ]YR[/\\. ]| Y |LESS THAN| AGE ' ,poffense,0) = '' => 'Y',
							 
							 REGEXFIND(child_set ,poffense,0) <> '' and
	             REGEXFIND('[/\\. ]L[&/]L[/\\. ]|LEWD'     ,poffense,0) <> ''   => 'Y',
							 
							 REGEXFIND(Assault2                ,poffense,0) <> '' and
							 REGEXFIND(Assault2                ,poffense,0) <> '' and 
	             REGEXFIND(assault_ext             ,poffense,0) <> '' => 'Y',

               REGEXFIND(SexOffensesForcible     ,poffense,0) <> '' and 
	             REGEXFIND('FORC'                  ,poffense,0) <> '' => 'Y',	
							 
               REGEXFIND(SexOffensesForcible     ,poffense,0) <> '' and 
	             REGEXFIND(SexOffensesForcible_exc ,poffense,0) = ''=> 'Y',	 
							 
							 REGEXFIND(Assault                 ,poffense,0) <> '' and 
	             REGEXFIND(assault_ext             ,poffense,0) <> ''  => 'Y',
							 
							 REGEXFIND('ATT |COMMIT|FORCIBLE'  ,poffense,0) <> ''and
							 REGEXFIND(' SODO '                ,poffense,0) <> ''and 							 
	             REGEXFIND('[/\\. ]STAT[/\\. ]|STAUTORY|STAT[AU][TAORY]+|STA[T]+O[TO]*R|STATRY'             ,poffense,0) = '' => 'Y',							 
							 
							 REGEXFIND('[/\\. ]SXOFF[/\\. ]|[/\\. ]SX OF[/\\. ]|SEX OFF[E]*ND'  ,poffense,0) <> ''and 							 
	             REGEXFIND('[/\\. ]REG[/\\. ]|REGISTER'     ,poffense,0) <> '' => 'Y',
							 'N');
return Is_it;
end;


//--------------------------------------------------------------------------------------------------------------------------------------

export Is_SexOffensesNon_forcible(string poffense_in) := function //done

special_characters    := '~|=|!|-|%|\\^|\\+|:|\\(|\\)|,|;|_|#|@|\\*|>|"|`|\\[|]|\\{|\\}|\\\\|\'';
poffense              := ' '+REGEXREPLACE(special_characters, poffense_in, ' ');
    
SexOffensesNon_forcible        := 'STAT[U/ ]*RAPE|STATSODOMY|STATE(.*)[ ]SEX[UAL]* OFF|STATE SEX[UAL]* [OPFFEC ]*REG|'+
                                  'PC 647\\.6 [A] |PC 647\\.6 |PC 290 [FG]  |PC 290.018 [B] |PC 261.5 [CD] ';
																	
SexOffensesNon_forcible_exc    := 'BURG|OBSCENE|PERFORM|PORN|FILM|MOVIE|COMPUTER|TECH|MATERI|VIDEO|WORDS|GESTURES|PICTURE|PIC|LANGUAGE|PHOTOGRAPH|CONVERSATION|POSING|PHONE|LANUGAGE';

child_set := 'M[OI]NOR|[/\\. ]MIN[/\\. ]|JUV|CHI[U]*LD[REN]*|[/\\. ]CHI[KLD]*[/\\. ]|[/\\. ]CH[I]*L[TDEF][/\\. ]|[/\\. ]CHLD[</\\. ]|[/\\. ]CHILED[/\\. ]| CHITL ';
  Is_it := MAP(In_Global_Exclude(poffense,'other')='Y' => 'N',
	
							 // trim(poffense) in _fmod_offense_category_list.SexOffensesNonForcibleList =>'Y',
							 
							 // Roger's comment - QA Update - Sex Offenses Non-Forcible
							 determine_SOF_SONF(poffense)='SONF' => 'Y',	
               REGEXFIND('^[ ]IND[/]CHILD|^[ ]IND[/]EXPOS',poffense,0) <> ''=>  'Y',
	
	             REGEXFIND('EXPOS|EXPOSURE|EXPOSING|EXPSING' ,poffense,0) <> '' and 
               REGEXFIND('SEXUAL OR|SEX(.*)[ ]*(GEN|ORG[ANS]*|PARTS)',poffense,0) <> '' => 'Y',                

               REGEXFIND('INDEC'             ,poffense,0) <> '' and 
               REGEXFIND(child_set+'| U/[0-9][0-9]* ',poffense,0) <> ''=>  'Y',       

               // REGEXFIND('LEWD|LASCIVIOUS'   ,poffense,0) <> '' and 
               // REGEXFIND(child_set+'|UNDER 16|DA[U][HG]+HTER| < |YOA|[/\\. ]YR[/\\. ]| Y | [0-1][0-7]Y |LESS THAN|[/\\. ]AGE[/\\. ]' ,poffense,0) <> '' => 'Y',
              
	 						 // REGEXFIND('LASC'              ,poffense,0) <> '' and 
               // REGEXFIND('UNNATURAL'         ,poffense,0) <> '' and 
               // REGEXFIND(child_set+'|UNDER 16|DA[U][HG]+HTER| < |YOA|[/\\. ]YR[/\\. ]| Y | [0-1][0-7]Y |LESS THAN|[/\\. ]AGE[/\\. ]' ,poffense,0) <> '' => 'Y',
							 
							 REGEXFIND('SEX'              ,poffense,0) <> '' and 
               REGEXFIND('IMPOSIT'          ,poffense,0) <> '' => 'Y',
	
	             REGEXFIND('[/\\. ]SEX[UAL]*[/\\. ]',poffense,0) <> '' and 
               REGEXFIND('VE[C]*H|AUTO'     ,poffense,0) <> '' and 
               REGEXFIND('USE|HAVING|OFFEN' ,poffense,0) <> '' => 'Y',
							 							 
							 REGEXFIND('FAIL'               ,poffense,0) <> '' and
							 REGEXFIND(' HIV '              ,poffense,0) <> '' and
	             REGEXFIND('STATUS| STAT '      ,poffense,0) <> '' => 'Y',
							 
							 REGEXFIND('UNLAW'        ,poffense,0) <> '' and
							 REGEXFIND('CONTACT|TOUCH',poffense,0) <> '' and
	             REGEXFIND(child_set  ,poffense,0) <> '' => 'Y',
							 
							 REGEXFIND('SEX'          ,poffense,0) <> '' and
							 REGEXFIND('ABUSE'        ,poffense,0) <> '' and
	             REGEXFIND(child_set  ,poffense,0) <> '' => 'Y',
							 
							 REGEXFIND('UNLAW|UNLW'   ,poffense,0) <> '' and
							 REGEXFIND('COND'         ,poffense,0) <> '' and
							 REGEXFIND('TOWARD|[/\\. ]TO[/\\. ]'  ,poffense,0) <> '' and
	             REGEXFIND(child_set  ,poffense,0) <> '' => 'Y',
							 
							 REGEXFIND('UNLAW|UNLW'   ,poffense,0) <> '' and
							 REGEXFIND('TRAVEL'       ,poffense,0) <> '' and
							 REGEXFIND('MEET'         ,poffense,0) <> '' and
	             REGEXFIND(child_set  ,poffense,0) <> '' => 'Y',
							 
	             REGEXFIND('[/\\. ]STAT[/\\. ]|STAUTORY|STAT[AU][TAORY]+|STA[T]+O[TO]*R|STATRY' ,poffense,0) <> '' and
	             REGEXFIND('RAPE| SODO |SOD[O]*MY|INTERCOU|[/\\. ]SEX[USAL]*[/\\. ]|CARNAL|MOLEST' ,poffense,0) <> ''   
							 => 'Y',	
							
							 REGEXFIND('CARNAL|MOLEST'        							,poffense,0) <> '' and
	             REGEXFIND(child_set+'|DAHGHTER| < |YOA|[/\\. ]YR[/\\. ]| Y | [0-1][0-7]Y |LESS THAN|[/\\. ]AGE[/\\. ]' ,poffense,0) <> ''   => 'Y',
							 
							 REGEXFIND('[/\\. ]NUD[EITY]*[/\\. ]'        		,poffense,0) <> '' and
	             REGEXFIND('MASSA'      ,poffense,0) <> ''   		=> 'Y',
							 
							 REGEXFIND('FORNICAT'   ,poffense,0) <> ''   		=> 'Y',
							 
							 REGEXFIND('[/\\. ]VIO[LATIONG]*[/\\. ]|[/\\. ]VIO[LATED]*[/\\. ]|VIOLATION'        ,poffense,0) <> '' and
							 REGEXFIND('PARL|LICENSE|[/\\. ]LIC[ENCSE]*[/\\. ]'   ,poffense,0) <> '' and
	             REGEXFIND('MASSA|MASG' ,poffense,0) <> ''   => 'Y',
	
							 REGEXFIND('[/\\. ]NUD[EITY]*[/\\. ]'        ,poffense,0) <> '' and
							 REGEXFIND('CAPT'       ,poffense,0) <> '' and
							 REGEXFIND('IMAGE|FILM' ,poffense,0) <> '' and
	             REGEXFIND('NONCONSENT' ,poffense,0) <> ''   => 'Y',
							 
							 REGEXFIND(child_set    ,poffense,0) <> '' and
	             REGEXFIND('CORRUPT'    ,poffense,0) <> ''   => 'Y',

							 REGEXFIND('INDEC|INDCE|INDENC'        ,poffense,0) <> '' and
	             REGEXFIND('[/\\. ]LIB[ERTYIES]*[/\\. ]|CONTACT|'+child_set ,poffense,0) <> ''   => 'Y',

							 REGEXFIND('INCEST' ,poffense,0) <> ''   => 'Y',
							 							              
	             REGEXFIND(SexOffensesNon_forcible ,poffense,0) <> '' => 'Y',	
							 
							 'N');
return Is_it;
end;

//--------------------------------------------------------------------------------------------------------------------------------------

export Is_Pornography(string poffense_in) := function //done

special_characters    := '~|=|!|-|%|\\^|\\+|:|\\(|\\)|,|;|_|#|@|\\*|<|>|"|`|\\[|]|\\{|\\}|\\\\|\'';
poffense              := ' '+REGEXREPLACE(special_characters, poffense_in, ' ');
child_set := '[/\\. ]CHLD[/\\. ]|[/\\. ]CHIL[DREN]*[/\\. ]|MINOR|JUV';
	Pornography_Obscene_Material := 'PORN|PRODUCE SEX[UAL]* MAT[ERIAL]*[/\\. ]';
	Is_it := MAP(In_Global_Exclude(poffense,'other')='Y' 	=> 'N',
							 
               REGEXFIND(Pornography_Obscene_Material            ,poffense,0)<> ''  => 'Y',	
							 
							 // trim(poffense_in) in _fmod_offense_category_list.PornList =>'Y',
							 
							 REGEXFIND('[/\\. ]INDE[/\\. ]'                                ,poffense,0) <> ''  and
							 REGEXFIND('OBSCENI|UTTER|LANG|[\\. ]LAN[NDUAGE]*[\\. ]|[/\\. ]CALL[S]*[/\\. ]|PHON[E]*|[/\\. ]WORD[S]*[/\\. ]|[/\\. ]GEST[URES]*[/\\. ]|MESSAGE|BEHAV[IOR]* ' ,poffense,0) <> '' => 'N',							 
															 							 
							 REGEXFIND('DI[SC]*ORDERLY|DISORDER|[/\\. ]DIS[ORDER]*[/\\. ]' ,poffense,0) <> '' and
						   REGEXFIND('[/\\. ]CON[DUCT]*[/\\. ]'                          ,poffense,0) <> '' => 'N',
							 
							 REGEXFIND('TEL MISUSE|TELEPHONE MISUSE'                       ,poffense,0) <> '' => 'N',
							 
							 REGEXFIND('[/\\. ]INDE[CENTY]*[/\\. ]'                        ,poffense,0) <> ''  and
							 REGEXFIND('EXHIBITION|[/\\. ]MAT[ERIALS]*[/\\. ]|WRITING|PERFORMAN|DISPLAY|PHOTO|MOVIES|PRINTING|PUBLCTN|PICTURE' ,poffense,0) <> '' => 'Y',	
							 
							 REGEXFIND('[/\\. ]NUD[EITY]*[/\\. ]|[/\\. ]OBSCEN[EITY]*[/\\. ]'                                ,poffense,0) <> ''  and
							 REGEXFIND('REPRESENTATION|RECORD[ING]*[/\\. ]|[/\\. ]MAT[ERIALS]*[/\\. ]|PERFORMAN||DISPLAY|VIDEO|PHOTO|POSING|PICTURE' ,poffense,0) <> '' => 'Y',
								
							 REGEXFIND('PRODUC[ETION]+|PERFORM|RECORD|[/\\. ]RCRD[/\\. ]| MATERI|VIDEO|PICTURE|FILM|MOVIE|PHOTO' ,poffense,0) <> '' and 
							 REGEXFIND('SEXPLOITATION|SEXUAL EXPLOITATION|SEX[UALLY]* EXP[LICIT]* |SEX[UALLY]* VISUAL |SEXUAL EXLICIT| SEX\\.EXPL\\.MAT|SEX ACT|SEX MATERIAL' ,poffense,0) <> ''   => 'Y',
							 
							 REGEXFIND('[/\\. ]PER[FORMANCEING]*[/\\. ]|[/\\. ]MATERI|VIDEO|PICTURE|FILM|MOVIE|PHOTO' ,poffense,0) <> '' and 
							 REGEXFIND('SEX'                                                                          ,poffense,0) <> ''   and
							 REGEXFIND('PRODUCE|SOLICI| PAND[ERING]*[/\\. ]|POSS|ENGAGE|VOYEURISM|PROMOT|EXPLOIT|DIST[\\.RIBUTE]*|FURNISH|DISPLAY|EXHIBIT|DISSEM|DEVELOP'   ,poffense,0) <> ''   AND
							 //Roger's comments - QA Updates Pornography 7/11. Remove FISH AND GAME - ...
							 REGEXFIND('BIRDS|FISH '                                                                  ,poffense,0) = '' => 'Y',
                                          
               REGEXFIND('[/\\. ]PERFORM[ANCES]*[/\\. ]|PE[R]*FORMANCE|PR[E]*FORM[A]*NCE|VIDEO' ,poffense,0) <> '' and 
							 REGEXFIND('SEX'                                                                  ,poffense,0) <> '' => 'Y',
							 
							 REGEXFIND(' MAT[ERIALS]*[/\\. ]|TAPE|FILM|IMAGES'       ,poffense+' ',0) <> '' and 
							 REGEXFIND('PROMOTE|FILM|USE|SELL| EXP[.PLICIT]* |W/O CONSENT|MAKE|DEPICT|[/\\. ]EXP[PLICIT]*[/\\. ]|EXOLICIT|ORIENTED|ABUSIVE|ILLEGAL'     ,poffense,0) <> '' and 
							 REGEXFIND('SEXUALLY|SEX|NUDITY ORIENTED'                ,poffense,0) <> '' => 'Y',
							  
							 REGEXFIND(' MAT[ERIALS]*[/\\. ]|REPRESE[NATION]*|REPRSNTSNS'                        ,poffense,0) <> '' and 
							 REGEXFIND(' DIST[RIBUTE]* |DEPICT'                      ,poffense,0) <> '' and 
							 REGEXFIND('NUDITY'                                      ,poffense,0) <> '' => 'Y',
							 							 
							 REGEXFIND('INDEC|OBSCENE|/OBSC '                        ,poffense,0) <> ''  and
							 REGEXFIND('EXHIB|PHOTO|MATERIAL|PHOT[O]*GRAPHS'         ,poffense,0) <> ''and
							 REGEXFIND('SOLICI|PROC[UREING]*[/\\. ]'                 ,poffense,0) <> ''   => 'Y',
							 
							 //has to be before Is_SexOffensesForcible
							 // REGEXFIND('[/\\. ]WRITE[/\\. ]|[/\\. ]PROD[UCEING][/\\. ]|REPROD[UCEING][/\\. ]|DIRECT|[/\\. ]DIR[/\\. ]|COMIC|PRINT|[/\\. ]PRT[/\\. ]|RECORD|[/\\. ]RCD[/\\. ]|[/\\. ]RCRD[/\\. ]|DISTRIB|'+
												 // 'DISPLAY|EXHIB|PERFORM|FILM|MOVIE|TECH| MATERI|VIDEO|PICTURE|PHOTO|[/\\. ]POSE[/\\. ]|[/\\. ]POSING|SALE|'+
												 // 'SELL|PURCH|PUBLISH|POSSESS|MANUFACT|PROMO|PANDER|DISSEM' ,poffense,0) <> '' and 
							 // REGEXFIND('[/\\. ]NUD[ALEITY]*[/\\. ]|INDEC|[/\\. ]INDC[/\\. ]|INDENC|OBSCEN|PORN' ,poffense,0) <> ''  and
							 // REGEXFIND('SOLIC|COMPU[TER]* STMT|DISEASE|WEAPON|KIDNAP|BATT|FORC|COMPUL|IMMATERIAL|PHON|MESSAGE|UTTER|LANG| LAN |[/\\. ]CALL[S]*[/\\. ]|[/\\. ]WORD[S]*[/\\. ]|[/\\. ]GEST[URES]*[/\\. ]',poffense,0) = '' => 'Y',	
															 
							 (Is_Assault_aggr(poffense)='Y' OR Is_Assault_other(poffense)='Y' OR Is_SexOffensesForcible(poffense)='Y') and 
							 REGEXFIND('PORN'                                 ,poffense,0) = '' => 'N',	
							
							 REGEXFIND('OBSCENI'                                 ,poffense,0) <> ''  and
							 REGEXFIND('UTTER|LANG|[\\. ]LAN[NDUAGE]*[\\. ]|[/\\. ]CALL[S]*[/\\. ]|PHON[E]*|[/\\. ]WORD[S]*[/\\. ]|[/\\. ]GEST[URES]*[/\\. ]|MESSAGE|BEHAV[IOR]* ',poffense,0) = '' => 'Y',	
							 
							 REGEXFIND('OBSCEN'                                  ,poffense,0) <> ''  and
							 REGEXFIND('LANQUAGE|OBSCENI|UTTER|LANG|[\\. ]LAN[NDUAGE]*[\\. ]|[/\\. ]CALL[S]*[/\\. ]|PHON[E]*|[/\\. ]WORD[S]*[/\\. ]|[/\\. ]GEST[URES]*[/\\. ]|MESSAGE|BEHAV[IOR]* ' ,poffense,0) = '' => 'Y',	
							 
               // |[/\\. ]COMM[ERCIAL]*[/\\. ]|COMMERCIAL
							 REGEXFIND('TRAFF'                                 ,poffense,0) <> ''  and 
							 REGEXFIND('SEX|[/\\. ]NUD[ALEITY]*[/\\. ]|INDEC|[/\\. ]INDC[/\\. ]|INDENC|OBSCEN|PORN' ,poffense,0) <> ''  and
							 REGEXFIND('[/\\. ]MAT[ERIALS]*[/\\. ]'            ,poffense,0) <> '' => 'Y',	
							 
							 REGEXFIND('[/\\. ]NUD[ALEITY]*[/\\. ]'            ,poffense,0) <> '' and 
							 REGEXFIND(child_set+'|IMAGE|PUBLICATION|FILM',poffense,0) <> '' => 'Y',
							 
							 REGEXFIND('[/\\. ]NUD[EITY]*[/\\. ]'              ,poffense,0) <> ''  and 
							 REGEXFIND('ILL'                                   ,poffense,0) <> ''  and
							 REGEXFIND('[/\\. ]USE[/\\. ]'                     ,poffense,0) <> '' => 'Y',
							 
							 REGEXFIND('[/\\. ]SEX[/\\. ]|PORN'                               ,poffense,0) <> ''  and 
							 REGEXFIND(child_set                                ,poffense,0) <> ''  and
							 REGEXFIND('PERF|PROD|PROMOTE|PROM|VIDEO|DIRECT|DIR',poffense,0) <> ''  and
							 REGEXFIND('BATT'                                   ,poffense,0) = '' => 'Y',
							   							 
							                
							 'N');
return Is_it;
end;
//--------------------------------------------------------------------------------------------------------------------------------------

export Is_Terrorist_Threats(string poffense_in) := function //done
special_characters    := '~|=|!|-|%|\\^|\\+|:|\\(|\\)|,|;|_|#|@|\\*|>|"|`|\\[|]|\\{|\\}|\\\\|\'';
poffense              := ' '+REGEXREPLACE(special_characters, poffense_in, ' ');
Terrorist_Threats  := 'TERRORIST|TERROR[ISTM]*|TERRORISTIC|W[EA]*P[ON]*[S]* [OF ]*MASS DES[T]*[RUCT]+|TERR THRT|TERR THREA|TERR ACTS|PC 186\\.22 A ';
// Terrorist_ecl      := 'HARM|FALSE INFO';
Terrorist_ecl      := 'HARM[ |$|/|\\-]|FALSE INFO';

TT2a := 'EXPLOSIV|BOMB';
TT2b := 'TERR';

Is_it := MAP(In_Global_Exclude(poffense,'TERROR') = 'Y' => 'N',						 
             REGEXFIND('REVOC' 																			,poffense,0) <> '' OR
						 (REGEXFIND('PROBAT', poffense,0) <> '' AND REGEXFIND('H[O]?LD|VIO[L]?', poffense,0) <> '') => 'N',
						 
						 //Roger's comment - QA terrorist Threats  Round 5 10/11/16
             // REGEXFIND(TT2b 																				,poffense,0) <> '' => 'Y',	
             REGEXFIND(TT2a 																				,poffense,0) <> '' and
             REGEXFIND(TT2b 																				,poffense,0) <> '' => 'Y',	                                 
						 //QA Update - Assault Other round 6
						 REGEXFIND(Terrorist_Threats 														,poffense,0) <> '' and
						 REGEXFIND('INTENT TO HARM OTHER'												,poffense,0) <> '' => 'Y',	               
						 REGEXFIND('TERROR'     					 											,poffense,0) <> '' and
						 REGEXFIND('ACT'				           											,poffense,0) <> '' => 'Y',	
						 REGEXFIND(Terrorist_Threats 														,poffense,0) <> '' and
						 REGEXFIND(Terrorist_ecl 																,poffense,0) =  '' => 'Y',	               
						 //Roger's comments - QA Update - Terrorist Threats  Round 3 8/26/16
						 REGEXFIND('RPRT|REP '																  ,poffense,0) <> '' and
						 REGEXFIND('BOMB'												,poffense,0) <> '' and
						 REGEXFIND('FALSE |FALSELY |FALS[ |\\.]'								,poffense,0) <> ''  => 'Y',	               
						 //Roger's comments - QA Update - Weapons Law Violations Round 4 9/27/16
						 REGEXFIND('BOMB'																				,poffense,0) <> '' and
						 REGEXFIND('FALSE[LY]* |HOAX'														,poffense,0) <> '' => 'Y',	               
						 REGEXFIND('THREAT[EN]*|THRT|WARN|SCARE|FIRE '					,poffense,0) <> '' and
						 REGEXFIND(TT2a																					,poffense,0) <> '' => 'Y',	               
						 'N');
return Is_it;
end;

//--------------------------------------------------------------------------------------------------------------------------------------

export Is_Restraining_Order_Violations(string poffense_in) := function //done

special_characters    := '~|=|!|-|%|\\^|\\+|:|\\(|\\)|,|;|_|#|@|\\*|>|"|`|\\[|]|\\{|\\}|\\\\|\'';
poffense              := ' '+REGEXREPLACE(special_characters, poffense_in, ' ');

Restraining_Order_Violations   := 'VIO(.*)PROT(.*)|VIO(.*) ORD(.*) PROT|VIO(.*) T[\\. ]*P[\\. ]*O|^[ ]V(.*) T[\\.A-Z]* P[\\.PROTECTIVE]* O[\\.ORDER]|'+
                                  'DOMESTIC - VIOLATION OF O|PC 273\\.6 A |PC 273\\.6 |PC 166 C |PC 646\\.9 B ';
ROV2a                          := 'RESTRAIN(.*) ORDER|PROT(.*) ORDER';
ROV2b                          := 'VIOL';

vio_set := '[/\\. ]VIO[LATIONG]*[/\\. ]|[/\\. ]VIO[LATED]*[/\\. ]|VIOLATION';
Is_it := MAP(In_Global_Exclude(poffense,'TERROR') = 'Y' => 'N',

             // trim(poffense) in _fmod_offense_category_list.RestrainingOrderVioList =>'Y',

             REGEXFIND('[/\\. ]TPO[/\\. ]|[/\\. ]T\\.P\\.O[/\\. ]' ,poffense,0) <> '' and 
	           REGEXFIND(vio_set          ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND(vio_set+'|[/\\. ]REV[/\\. ]|[/\\. ]RVK[D]*[/\\. ]|REVO[CKED]*'             ,poffense,0)  <> '' and 
	           REGEXFIND('[/\\. ]INJ[UNCTION]*[/\\. ]|INJU[NC ]|INJN|INJ$|INJC|INJCT|VIOLINJ|INJTN' ,poffense,0) <> '' => 'Y',	 
               
             REGEXFIND('VIO|REV|RVK[D]*|REVO[CK]*|DISOBE'      ,poffense,0) <> '' and 
             REGEXFIND('COURT|[/\\. ]CRT[/\\. ]|[/\\. ]CT[/\\. ]|RESTR|PROT'               ,poffense,0) <> '' and 
						 REGEXFIND('ORD'                                   ,poffense,0) <> '' => 'Y',	
							 
						 REGEXFIND(vio_set          ,poffense,0) <> '' and 
	           REGEXFIND('CONTACT'        ,poffense,0) <> '' and 
						 REGEXFIND('[/\\. ]NO[/\\. ]' ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('HOME|'+ vio_set     ,poffense,0) <> '' and 
	           REGEXFIND('PROT'      ,poffense,0) <> '' and 
						 REGEXFIND('ORDER|PERS',poffense,0) <> '' => 'Y',						 
						 
						 REGEXFIND('DOMEST'    ,poffense,0) <> '' and 
	           REGEXFIND(vio_set       ,poffense,0) <> '' and 
						 REGEXFIND('COURT'     ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND(vio_set       ,poffense,0) <> '' and 
	           REGEXFIND('RESTR'     ,poffense,0) <> '' and 
						 REGEXFIND('ORD'       ,poffense,0) <> '' => 'Y',
              
             In_Global_Exclude(poffense,'other')='Y' => 'N',
						 
             REGEXFIND(ROV2a       ,poffense,0) <> '' and	               
             REGEXFIND(ROV2b       ,poffense,0) <> '' => 'Y',	               
 
             REGEXFIND(Restraining_Order_Violations ,poffense,0) <> '' => 'Y',	               
						 'N');
return Is_it;
end;	 
	  
//--------------------------------------------------------------------------------------------------------------------------------------
                                                                 
export Is_BadChecks(string poffense_in) := function //done

special_characters:= '~|=|!|-|%|\\^|\\+|:|\\(|\\)|,|;|_|#|@|\\*|<|>|"|`|\\[|]|\\{|\\}|\\\\|\'';
poffense          := ' '+REGEXREPLACE(special_characters, poffense_in, ' ');

BadChecks         := ' BD CK | BAD CH| BAD CK| BAD [BEH]+CK | BADC[H]*K[S]*[0-9 ]|PBADCKU|PASBADCHEC|[/ ]PA[DS]+BAD[H]*CK[S]*|[/0-9 ]P[A]*[S][/]*+BADC[HEC]*K[S]*|P[A]*[S]+[BAD]+C[H]*K[S]* | P/BADCK|HOT CHECK|WRIT[E]*BADCK[S]*|'+
                     '^[ ][FEL ]*W/C[ \\$]*[0-9\\.]+|[/\\. ]BAD C[HEC]*KS[/\\. ]|[/\\. ]BAD CK[/\\. ]|PASS BAD|[/\\. ]P[/]*W[/ ]*C[HEC]*K|PASSING BAD|BAD CHECK|'+
										 'POSSBADCKS|PSBDCKSNSF|PSGBADCHEK|POS(.*)BAD(.)*CHE[C]*KS| HOT CHK[S]*|PC 476A A |PC 476 |2913\\.11| 13A-9-13\\.1';
Bogus_chks        := 'BOGUS [C ]*HECK[/ ]|BOGUS CH|BOGUS CK| BOGU[ ]*SCK|BOGUS [CDW]*HECK[S]*[ /]|PASBOGUSCK';	 

worthless_chks    := 'WORTHLESS CH|WORTHLESS CK|WORTHLESS [CDW]HECK[S]* |PASS(.*)W(.*)CHECK| W/LESSCHKS|'+
                     'WORTHL CHKSF |WORTH CKECK|WORTHLESS [C ]*HECK[/ ]|WORTHLE[S]*CK[ \\.]';											 

ck_set            := 'CH[A]*ECK|[/\\. ]C[E]*H[C]*K[S]*[/\\. ]|[/\\. ]CK[S]*[/\\. ]|[/\\. ]CHCK[/\\. ]|[/\\. ]CHEC[EKHS]*[/\\. ]|'+
                         '[/\\. ]CHE[DX]*K[/\\. ]|[/\\. ]CH[C]*EKC[/\\. ]|[/\\. ]CECK[/\\. ]';                                                                  

Is_it := MAP(In_Global_Exclude(poffense,'other')='Y' => 'N',
             // trim(poffense_in) in _fmod_offense_category_list.BadChecksList =>'Y',
//Please select offenses containing OBT  and also contain PROP    and also contain  WORTHLES or W/L.
             REGEXFIND('[/\\. ]NSF[S]*[-/\\. ]|[/\\. ]INSF[ ]*[FUNDS]+[-/\\. ]|[/\\. ]INSF[CHECK]*[-/\\. ]+|[/\\. ]INSF[FUNDS \\.]+C[HEC]*[CK][S0-9]*[-/\\. ]|[/\\. ]INSFC[HEC]*K[OU]'      ,poffense,0) <> '' => 'Y',
						 REGEXFIND('[/\\. ]BAD[CHECK]+[-/\\. ]+|[/\\. ]BAD[ ]*+C[HEC]*[CK][S0-9]*[-/\\. ]|[/\\. ]BADC[HEC]*K[OUINSUF]+'      ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('[/\\. ]STP[/\\. ]'        ,poffense,0) <> '' AND     
						 REGEXFIND('[/\\. ]PAY[MENT]*[/\\. ]' ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('UTTER'                    ,poffense,0) <> '' AND  
						 REGEXFIND(ck_set+'|[/\\. ]CH[/\\. ]' ,poffense,0) <> '' AND 
						 REGEXFIND('GUTTER'                   ,poffense,0) = '' => 'Y',

             REGEXFIND( ck_set,poffense,0) <> '' AND               
						 REGEXFIND('NON|WITHOUT|[/\\. ]W/O[UT]*[/\\. ]|[/\\. ]NO[/\\. ]|SUFF' ,poffense,0) <> '' AND     
						 REGEXFIND('FUND| ACCT[\\. ]'                     ,poffense,0) <> '' => 'Y',
						 						 
						 REGEXFIND('[/\\. ]NO[/\\. ]|CLOSED'              ,poffense,0) <> '' AND     
						 REGEXFIND('ACCOUNT'                  ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('NON|WITHOUT|[/\\. ]W/O[UT]*[/\\. ]|[/\\. ]NO |[/\\. ]WO[/\\. ]' ,poffense,0) <> '' AND     
						 REGEXFIND('SUFF'                     ,poffense,0) <> '' AND  
             REGEXFIND('FUND'                     ,poffense,0) <> '' => 'Y',

             REGEXFIND(ck_set ,poffense,0) <> '' AND               
						 REGEXFIND('ISSUING|ISSUE'            ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('[/\\. ]W[/]C[HECKS]*[/\\. ]|[/\\. ]W\\.C[/\\. ]'                          ,poffense,0) <> ''  AND               
             REGEXFIND('ISS|FEL|COST|OBT|SWIND|[\\$0-9]+' ,poffense,0) <> ''  AND               
             REGEXFIND('CH[I]*LD|[/\\. ]M[/]*V[/\\. ]|VE[C]*H|FAIL|COMP|COIN|CUST|CLASS|COURT|CHARG|CRIM' ,poffense,0) =  ''  => 'Y',
						 
						 REGEXFIND(ck_set   ,poffense,0) <> ''   AND               
             REGEXFIND('WORTHL|WORTLESS|[/\\. ]W[/]L[/\\. ]|[/\\. ]W[/]LES',poffense,0) <> ''   => 'Y',
						 
						 REGEXFIND('OBT'                 ,poffense,0) <> ''   AND               
						 REGEXFIND('PROP'                ,poffense,0) <> ''   AND
             REGEXFIND('BOGUSCK|WORTHL|W[/]LCK[/\\. ]|[/\\. ]W[/][C]*L[ CHECKS]*[/\\. ]|[/\\. ]W[/]L[CK][/\\. ]|[/\\. ]W[/]L[E]*S|[/\\. ]W[/]*CKS ',poffense,0) <> ''   => 'Y',
						 						 
						 REGEXFIND('[/\\. ]W[/]CHECK|[/\\. ]W[/]CK[/\\. ]'    ,poffense,0) <> ''   AND               
             REGEXFIND('OBT|ISS|SWIND'       ,poffense,0) <> ''   => 'Y',

             REGEXFIND('CHECK|CH[C]*K|[/\\. ]CK[/\\. ]'  ,poffense,0) <> ''   AND               
             REGEXFIND('WITHOU|[/\\. ]W[/]*O[/\\. ]|[/\\. ]NO[/\\. ]'   ,poffense,0) <> ''   AND 
						 REGEXFIND('ACCOU|ACCT|[/\\. ]ACC[/\\. ]'     ,poffense,0) <> ''  => 'Y',
						 
						 REGEXFIND(ck_set   ,poffense,0) <> '' AND               
             REGEXFIND('BAD|BO[G]+US|BOGU[D]*|WORTH|[/\\. ]NSF[/\\. ]'          ,poffense,0) <> '' => 'Y',
             
             REGEXFIND(' UTTER '             ,poffense,0) <> '' AND               
             REGEXFIND('GUTTER'              ,poffense,0) = '' => 'Y',
						 
             REGEXFIND('INSU[F]+|[/\\. ]NO[/\\. ]'        ,poffense,0) <> '' AND               
             REGEXFIND('FUND'                ,poffense,0) <> '' AND               
             REGEXFIND('FORG|COUNTERF'       ,poffense,0) = '' => 'Y',	 
						 //Roger's comment on Cannot Classify - Bad Check
             REGEXFIND('FELONY CHECK'        ,poffense,0) <> '' => 'Y',	   
						 
             REGEXFIND(BadChecks             ,poffense,0) <> '' => 'Y',
						 REGEXFIND(worthless_chks        ,poffense,0) <> '' => 'Y',	
						 REGEXFIND(Bogus_chks            ,poffense,0) <> '' => 'Y',	

             REGEXFIND('CRIMINAL'            ,poffense,0) <> '' AND
						 REGEXFIND('HOT'                 ,poffense,0) <> '' AND
             REGEXFIND(' CHK[S]* '           ,poffense,0) <>'' => 'Y',

             REGEXFIND(' VIO[L ]+'           ,poffense,0) <> '' AND  
             REGEXFIND('CHECK'               ,poffense,0) <> '' AND 
             REGEXFIND(' LAW '               ,poffense,0) <> '' => 'Y',

						 REGEXFIND('OBTAINING'           ,poffense,0) <> '' AND  
             REGEXFIND('PROPERTY'            ,poffense,0) <> '' AND 
             REGEXFIND(' WC '                ,poffense,0) <> '' => 'Y',
						 'N');

return Is_it;
end;
//--------------------------------------------------------------------------------------------------------------------------------------

export Is_CurfewLoiteringVagrancyVio(string poffense_in) := function //done

special_characters:= '~|=|!|-|%|\\^|\\+|:|\\(|\\)|,|;|_|#|@|\\*|<|>|"|`|\\[|]|\\{|\\}|\\\\|\'';
poffense          := ' '+REGEXREPLACE(special_characters, poffense_in, ' ');

CurfewLoiteringVagrancyVio  := 'LOI[T]+|LOTIER|LOUTER|CURF|VAGRA|HOMELES|BEG[G]+IN|BEGG[EA]R|BEGG[/\\. ]|PC 653\\.22 A |HS 11532 A |856\\.021';

Curfew_exc                  := 'EXPLOIT|BEGGINER|HABEGGER ';
Is_it := MAP(In_Global_Exclude(poffense,'other')='Y' => 'N',

             // trim(poffense_in) in _fmod_offense_category_list.LoiteringList =>'Y',

             REGEXFIND('PAN'   ,poffense,0) <> '' AND               
						 REGEXFIND('OCCUPANT'            ,poffense,0) =  '' AND 
             REGEXFIND('HAN'   ,poffense,0) <> '' => 'Y',
						 
						 // REGEXFIND('REFUSE|FAIL'         ,poffense,0) <> '' AND               
             // REGEXFIND('LEAV|IDENTIFY'       ,poffense,0) <> '' AND
						 // REGEXFIND('SCEN|CRASH|INFO'     ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('STAND'               ,poffense,0) <> '' AND               
             REGEXFIND('AROUND|UNLAW|PUBLIC' ,poffense,0) <> '' AND
						 REGEXFIND('URINAT|OUTSTAND'     ,poffense,0) =  '' => 'Y',
						 
						 REGEXFIND('AGG|A[G]+RESS'       ,poffense,0) <> '' AND               
             REGEXFIND('PANHND'              ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('AIRPO[R]*T'          ,poffense,0) <> '' AND               
						 REGEXFIND('LIUE|LIEU'           ,poffense,0) <> '' AND
             REGEXFIND('[/ ]MOTE[/ ]|MOTEL|[/ ]HOTE[/ ]|HOTEL' ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('REMAIN'        ,poffense,0) <> '' AND               
						 (REGEXFIND('SIDEWALK'     ,poffense,0) <> '' OR
						  (REGEXFIND('PUB'         ,poffense,0) <> '' AND  REGEXFIND('STREET|PLACE' ,poffense,0) <> '' ) 						  
						 )=> 'Y',
						  
             REGEXFIND(CurfewLoiteringVagrancyVio ,poffense,0) <> '' AND
						 REGEXFIND(Curfew_exc ,poffense,0) = '' => 'Y',	       
						 
						 REGEXFIND('SLEEP|LODG|CAMP'              ,poffense,0) <> '' and
						 REGEXFIND('PROHIB'                       ,poffense,0) <> '' and	
             REGEXFIND('PLAC |PLACES|AREA'            ,poffense,0) <> '' => 'Y',
						 
             REGEXFIND('PROWL[ING ]+'                 ,poffense,0) <> '' and
						 REGEXFIND(' VEH[\\.ICLE ]+'              ,poffense,0) = ''  => 'Y',

						 'N');
return Is_it;
end;


//--------------------------------------------------------------------------------------------------------------------------------------

export Is_Drunkenness(string poffense_in) := function //done

special_characters:= '~|=|!|-|%|\\^|\\+|:|\\(|\\)|,|;|_|#|@|\\*|<|>|"|`|\\[|]|\\{|\\}|\\\\|\'';
poffense          := ' '+REGEXREPLACE(special_characters, poffense_in, ' ');

Drunkenness                 := 'PUB[LIC]* INTOX|DRUNKENNESS|DUNKNNESS|INTOXICATED IN PUBLIC| 647[ ]*F ';

D3                          := 'DISORDER';  
D3a                         := 'INTOX|ALCOH';

D1                          := 'PUBLIC INTOX|DISORD';
D2                          := 'DRIV'; 
D2a                         := 'DRUNK';


Is_it := MAP(In_Global_Exclude(poffense,'other')='Y' => 'N',
             // trim(poffense_in) in _fmod_offense_category_list.DrunkennessList =>'Y',
             REGEXFIND('INTOX'                ,poffense,0) <> '' and
						 REGEXFIND('[/\\. ][IO]N[/\\. ]|ALONG|UPON'     ,poffense,0) <> '' and
						 REGEXFIND('FREEWAY|HIGHWA|HIWAY|[/\\. ]HWY[/\\. ]|ROAD| H[YW] |[/\\. ]RD[/\\. ]| RDWAY|PREM' ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('INTOX'  ,poffense,0) <> '' and
						 REGEXFIND('[/\\. ]PED[/\\. ]|PEDIS|[/\\. ]PESD[/\\. ]|PEDISTR|PERSON' ,poffense,0) <> '' => 'Y',
						 
             REGEXFIND(D1  ,poffense,0) <> '' and
						 REGEXFIND(D2  ,poffense,0) <> '' and
						 REGEXFIND(D2a ,poffense,0) <> '' => 'Y',
						 
						 //Roger's comment QA Updates - Drunkenness 7/7
						 REGEXFIND('DRUNK|INTOX'  ,poffense,0) <> '' and
						 REGEXFIND('PUB|PUBLIC|CITY' ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('DRUNK'  ,poffense,0) <> '' and
						 REGEXFIND('[/\\. ]DR[IVENG]*[/\\. ]|DRIV|[/\\. ]OP[ERATEING]*[/\\. ]|DROV' ,poffense,0) = '' => 'Y',

						 REGEXFIND('DRINK|DRUNK|INTOX|ALCOH'  ,poffense,0) <> '' and
						 REGEXFIND('[/\\. ]D[/]O[/\\. ]|DISRUPT' ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND(D3  ,poffense,0) <> '' and
						 REGEXFIND(D3a ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND(' INTOX |INTOXICATION'  ,poffense,0) <> '' and
						 REGEXFIND(' DIS | DOC ' ,poffense,0) <> '' => 'Y',						 
						 
						 REGEXFIND(Drunkenness ,poffense,0) <> '' => 'Y',
							 'N');
return Is_it;
end;
//--------------------------------------------------------------------------------------------------------------------------------------
export Is_FamilyOffenses(string poffense) := function

FamilyOffenses  := 'CRIMINAL MISTREATMENT|ALIMONY|PARENTAL RESPONSIBILITY| F S O P C |COMPULSORY EDUCATION|COMPULSORY SCHOOL|TRUANCY|'+
                   'PC 243[(]E[)]| PC 273D |PC 368[(]C[)]|PC 368[(]B[)][(]1| 2919\\.25 |243(E)(1)PC-M PC|'+
                   'PC 273[\\.5 ]+|PC 273A[(][AB2][)]| PC 270 | EC 48262 | EC 48200 | PC 272 ';
fam_excl        := 'NON[ -]*FAMILY|TERR|ASS[AU]*LT|BATT|INCEST|SEX|PORN|RAPE|DELI[N]*Q';

fon2a := 'THREAT|ABUS[EING]+|CRUEL|ABANABON|DESERT|SUPPORT|NEGLECT|CONTRIB|ENDANGE';
fon2b := 'FAMILY|CHILD|CHLD|MINOR|SPOUSE|DEPEND|FAM & HSH';    
Is_it := MAP(In_Global_Exclude(poffense,'other')='Y' => 'N',

             // trim(poffense) in _fmod_offense_category_list.FamilyOffensesList =>'Y',
			 
             REGEXFIND('SODOM|RAPE'                 ,poffense,0) <> '' and 
             REGEXFIND('THERAPEUTIC'                ,poffense,0) = '' => 'N',

             REGEXFIND('[- ]FTP[ /]'                ,poffense,0) <> '' and
						 REGEXFIND('CHILD|CHD'                  ,poffense,0) <> '' and
						 REGEXFIND('SUPP| SP |SAFE'             ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('OMITTING TO PROVIDE FOR'    ,poffense,0) <> '' and
						 REGEXFIND('CHILD|MINOR|CHILDREN'       ,poffense,0) <> '' => 'Y',
						 
						 (REGEXFIND('NON|FAIL|WITHHOLD|REFUSE|FLR|OBLIGAT|SPOUS|CHIL|PARENT|PAY|FTP |F[/]T[/]P|CHILD|MINOR|DESERT|PROVID' ,poffense,0) <> '' OR
						  (REGEXFIND('CRIM',poffense,0) <> '' and REGEXFIND('NO[- ]',poffense,0) <> '')
						 )  and 
             REGEXFIND('SUPPORT'                    ,poffense,0) <> '' and
						 REGEXFIND('REPAIR'                     ,poffense,0) = '' => 'Y',
						 
						 
             REGEXFIND('MINOR|CHILD|JUV'            ,poffense,0) <> '' and 
             (REGEXFIND('ABAND'                     ,poffense,0) <> '' OR
						  (REGEXFIND('ABAN',poffense,0) <> '' and REGEXFIND('PROVIDE',poffense,0) <> '')
						 )=> 'Y',
						 
						 REGEXFIND('FAIL|FLR'                   ,poffense,0) <> '' and 
             ((REGEXFIND('IMPAIR',poffense,0)  <> '' and REGEXFIND('PERS' ,poffense,0) <> '') OR
						  (REGEXFIND('PROTECT',poffense,0) <> '' and REGEXFIND('CHILD',poffense,0) <> '')
						 )=> 'Y',
						 
						 REGEXFIND('PARENT'                     ,poffense,0) <> '' and 
             REGEXFIND('MINOR|CHILD|JUV'            ,poffense,0) <> '' and 
             REGEXFIND('VIO '                       ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('DISRUP'                     ,poffense,0) <> '' and 
             REGEXFIND('TRANQ'                      ,poffense,0) <> '' and 
             REGEXFIND('HOME'                       ,poffense,0) <> '' => 'Y',

						 REGEXFIND('MINOR|JUV'                  ,poffense,0) <> '' and 
             REGEXFIND('CONSUM'                     ,poffense,0) <> '' and 
             REGEXFIND('HOME'                       ,poffense,0) <> '' => 'Y',	
						 
						 REGEXFIND('REMOV'                      ,poffense,0) <> '' and 
             REGEXFIND('MINOR|CHILD|JUV'            ,poffense,0) <> '' => 'Y',

             REGEXFIND('NON'                        ,poffense,0) <> '' and 
             REGEXFIND('SUPPORT'                    ,poffense,0) <> '' and 
             REGEXFIND('FAMILY|SPOUSE|CHILD|DEPEND|MINOR|CRIM' ,poffense,0) <> '' => 'Y',
						 
             REGEXFIND('FAMILY'                     ,poffense,0) <> '' and 
             REGEXFIND('COURT|OFFENSE'              ,poffense,0) <> '' => 'Y',	
						 
						 REGEXFIND('CHILD'                      ,poffense,0) <> '' and 
             REGEXFIND('DEPEND'                     ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('NEGL'                       ,poffense,0) <> '' and 
             REGEXFIND('MINOR|CHILD|CHLD|JUV'       ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('CHILD|MINOR'                ,poffense,0) <> '' and 
						 REGEXFIND('INTERF|INTF'                ,poffense,0) <> '' and 
             REGEXFIND('CUS'                        ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('CHILD|SPOUSE|DEPEND'        ,poffense,0) <> '' and 
						 //Roger's comment QA Update - Family Offenses Round 4
						 REGEXFIND('NON|FAIL TO'                ,poffense,0) <> '' and 
             REGEXFIND('PAY'                        ,poffense,0) <> '' => 'Y',

				     REGEXFIND('CHILD|MINOR|JUV'            ,poffense,0) <> '' and 
						 REGEXFIND('LEAV|LV|LEFT'               ,poffense,0) <> '' and 
             REGEXFIND('UNAT| CAR|CAR |VEH|MV|AUTO' ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('SCHOOL'                     ,poffense,0) <> '' and  
             REGEXFIND('ABSENT|SKIP|SEND|SND |ATTEN[ CST]+|ATT[AET]*ND[ANCE]*|TARDY' ,poffense,0) <> '' => 'Y',
						 
						 //Roger's comment - QA Update - Family Offenses  Round 3 8/26/16
						 REGEXFIND('ENDANGERMENT|ENDANGER[ING]' ,poffense,0) <> '' and  
             REGEXFIND('CHILD'            					,poffense,0) <> '' => 'Y',
						   
             trim(poffense) IN [' DOMESTIC',' CRIMINAL DOMESTIC',' REFUSE/RELINQUISH PHONE/DOMES'] => 'Y', //VC 20170519 email req change

				     REGEXFIND('DOM[ EST]'                                     ,poffense,0) <> '' and     //VC 20170519 email req change
						 REGEXFIND('VIO[LENCE \\.]+|ABUS[E]*|ASSAULT|BATTERY|ABDOM',poffense,0) <> '' => 'Y',
						 
             REGEXFIND(FamilyOffenses ,poffense,0) <> '' and 
             REGEXFIND(fam_excl ,poffense,0) = '' => 'Y',	
             
						 REGEXFIND(fon2a ,poffense,0) <> '' and 
						 REGEXFIND(fon2b ,poffense,0) <> '' and 
             REGEXFIND(fam_excl ,poffense,0) = '' => 'Y',	
						 
						 REGEXFIND('NONSUPP'                          ,poffense,0) <> '' and
						 REGEXFIND('MINOR|CHILD'                      ,poffense,0) <> '' => 'Y',
						 
						 // REGEXFIND('INFLICT'                          ,poffense,0) <> '' and
						 REGEXFIND(' CORP |CORPORAL|TRAUMA|INJ[ URY]+',poffense,0) <> '' and
						 REGEXFIND('SPOUSE|COHABIT|COHABITANT| COHA ' ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('MALICIOUS'                        ,poffense,0) <> '' and
						 REGEXFIND('PUNISHMENT'                       ,poffense,0) <> '' and
						 REGEXFIND('CHILD|MINOR'                      ,poffense,0) <> '' => 'Y',
						 'N');
return Is_it;
end;
//--------------------------------------------------------------------------------------------------------------------------------------

export Is_LiquorLawViolations(string poffense_in) := function

special_characters:= '~|=|!|-|%|\\^|\\+|:|\\(|\\)|,|;|_|#|@|\\*|>|"|`|\\[|]|\\{|\\}|\\\\|\'';
poffense          := ' '+REGEXREPLACE(special_characters, poffense_in, ' ');

dui          := 'INFLU|DRIV|OPER|DUI|DWI';
misc         := 'UNDER|MINOR|AFTER|HOUR|HR|[<]21|[<]18';
IDSET        := '[/\\. ]ID[ENDIFICATION]*[/\\. ]|[/\\. ]ID[ENTIFYING]*[/\\. ]| I[/]D | I[/\\. ]D[/\\. ]';
vio_set      := '[/\\. ]VIO[LATIONGS]*[/\\. ]|[/\\. ]VIO[LATED]*[/\\. ]|[/\\. ]VOL[LATIONGS]*[/\\. ]|[/\\. ]VOL[ILATED]*[/\\. ]|VIOLATION';
liq_set      := '[/\\. ]LIQ[U]*M[0-9]|[/\\. ]LIQ[0UIOERS]*[/\\. ]|LIQUO[LR]';
alc_set      := liq_set+'| ALC/|ALCAHOL|LACOHOL|ACOHOL|ALCOHOL|[/\\. ]AL[C]+[0OHLIC]*[/\\. ]|ALOCH|ALC[OH]+|ALCONHLIC|ALCIHOL| AALC[/]| OFALC[/]|ALCLOHOLIC';
Intox        := alc_set+'|INOTXI[CATING]*[/\\. ]|BEER|INTOX|WINE|[/\\. ]QLCO[/\\. ]|[/\\. ]QALC[/\\. ]';
// Intox        := '[/\\. ]ALC[OHOL]*[/\\. ]|LIQ|BEER|INTOX|WINE|ALOCH| QLCO[/\\. ]|ALCOHOL';
                                                                 
//x43:='2 DRINK ALCOHOL BEV/PASSENGER PROHIBITED 9 ';
Is_it := MAP(In_Global_Exclude(poffense,'other')='Y' OR
						 Is_Drunkenness(poffense)='Y'   OR     
						 Is_DrivingUndertheInfluence(poffense)='Y'	=> 'N',
						 
						 // trim(poffense_in) in _fmod_offense_category_list.LiquorLawViolationsList =>'Y',

             REGEXFIND('DRIV'               		,poffense,0) <> '' and 
						 REGEXFIND('UNDER|WHILE'        		,poffense,0) <> '' and  
						 REGEXFIND('INFL[EU]|INLFU'     		,poffense,0) <> '' => 'N',
						 
						 REGEXFIND('DRIV'               		,poffense,0) <> '' and 
						 REGEXFIND('INTOX|W/INTOX'     		  ,poffense,0) <> '' => 'N',
						 
						 REGEXFIND(alc_set                  ,poffense,0) <> '' AND
						 REGEXFIND('FALSE'                  ,poffense,0) <> '' AND
						 REGEXFIND('STATEMENT|EVIDEN|APPLI|REPP'  ,poffense,0) <> ''  => 'Y',
						 
						 
             REGEXFIND('BP 25662|BP 25658 A |BP 25620|VC 23223 B |VC 23224 A '  ,poffense,0) <> ''  => 'Y',

						 
						 REGEXFIND('CONSUMPTION|CONSUM|CONSUMING'                  ,poffense,0) <> ''  AND
						 REGEXFIND('MINOR|UNDERAGE|ILLEGAL| MV | MOTOR VEHICLE| U/A |PREMISE LIC'  ,poffense,0) <> ''  => 'Y',

						 REGEXFIND('[/\\. ]ALC09[/\\. ]|[/\\. ]ALC21[/\\. ]|[/\\. ]ALC13[/\\. ]|LIQ[UOR]* LAW VIO|ALC[B0OHPOL]*[/\\. ]*BEV|POSS[OF]*ALC[BY ]+|ALCPUBLIC|ALC(.*)UNDER 21|'+
						           'POSSLIQ[U]*M[I]*N|POSSLIQON|SALE[OF]*LIQ[/\\. ]|SELL[OF]*LIQ[/\\. ]|SUPPLYLIQ[UOR]* ',poffense,0) <> '' => 'Y',
						 
						 REGEXFIND(Intox		                ,poffense,0) <> ''and 
						 REGEXFIND('SUPP|[/\\. ]GIV[EING]*[/\\. ]|DISPEN|SOLD|PARK'   ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('IMPORT|BEACH'		        ,poffense,0) <> ''and 
						 REGEXFIND('ALCOH|BEER'             ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('U[N]*LAW|UNL\\.'        ,poffense,0) <> ''and 
						 REGEXFIND('ENTRY'		              ,poffense,0) <> ''and 
						 REGEXFIND('MINOR'		              ,poffense,0) <> ''and 
						 REGEXFIND('BAR|LOUNG|PACKAGE'      ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('UNLAW'                  ,poffense,0) <> '' AND               
						 (REGEXFIND(alc_set                 ,poffense,0) <> '' OR
						  (REGEXFIND('CONSU'      ,poffense,0) <> '' AND  REGEXFIND('POS|PUB' ,poffense,0) <> '' ) OR
							(REGEXFIND('ACQUI'      ,poffense,0) <> '' AND  REGEXFIND(liq_set ,poffense,0) <> '' ) OR
							(REGEXFIND(alc_Set      ,poffense,0) <> '' AND  REGEXFIND('[/\\. ]PO[S]+[/\\. ]|PUR|SALE|ADVERTIS|CONCENT|CONTENT' ,poffense,0) <> '' ) OR
							(REGEXFIND('MINOR|PUB|[/\\. ]ALC[OHOL]*[/\\. ]'  ,poffense,0) <> '' AND  REGEXFIND('COMSUM|[/\\. ]CONS[UMPTION]*[/\\. ]' ,poffense,0) <> '' ) 
						 )=> 'Y',
						 						               
						 REGEXFIND(alc_set     ,poffense,0) <> '' AND
						 REGEXFIND('[/\\. ]PO[S]+[/\\. ]' ,poffense,0) <> ''  AND
						 REGEXFIND('MINOR|UNDER'  ,poffense,0) <> ''  => 'Y',
						 
						 REGEXFIND('DRINK|LIQ[UO]+R[ /]+FELONY',poffense,0) <>  '' => 'Y', 
						 
             REGEXFIND('SELL|SALE|TRANS'        ,poffense,0) <> ''and 
						 REGEXFIND('BEV'        		        ,poffense,0) <> ''and  
						 REGEXFIND('ILLICIT'     		        ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND(liq_set+'|INTOX'         ,poffense,0) <> '' and 
						 REGEXFIND('BUILD|GROUND' 	        ,poffense,0) <>  '' => 'Y',
						 
						 REGEXFIND('OP[OE]+N| OEN |PEON'    ,poffense,0) <> '' and 
						 REGEXFIND('CONT' 	                ,poffense,0) <>  '' => 'Y',
						 
						 REGEXFIND('PROV'                   ,poffense,0) <> '' and 
						 REGEXFIND('[/\\. ]ALC[OHLICE]*[/\\. ]|ALCOHOL|BEER'               ,poffense,0) <> '' and
						 REGEXFIND('PERS'                   ,poffense,0) <> '' and 
						 REGEXFIND('UND'     	              ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('UNLIC|LOCAL'                 ,poffense,0) <> ''and 
						 REGEXFIND(alc_set,poffense,0) <>  '' => 'Y',
						 
						 REGEXFIND(alc_set ,poffense,0) <> ''and 
						 REGEXFIND('[/\\. ]BEV[ERAGES]*[/\\. ]'  ,poffense,0) <>  '' => 'Y',
						 
						 //Roger's comment QA Updates - Liquor Law Violations 7/7/16
						 REGEXFIND('TOC'                		,poffense,0) <> ''and 
						 REGEXFIND('STOC|MOTOC|PONTOTOC|BUTTOCKS|TOCOM|TOCAR|SHOOTOC|BALTOCITY|TOCACCO|NATCHITOCHES|PHOTO|TOCROSS|NARCOTOC|TOCONTROLLED' 	  ,poffense,0) =  '' => 'Y', 
						 
						 REGEXFIND('DRUNK|DRINK'         		,poffense,0) <> ''and 
						 REGEXFIND('PUBLIC|PUB' 		        ,poffense,0) <> '' => 'Y',
						 
	           REGEXFIND('UNDER' 	      		      ,poffense,0) <> '' and 
						 REGEXFIND('AGE'                    ,poffense,0) <> '' and
						 REGEXFIND(Intox+'|'+alc_set        ,poffense,0) <> '' => 'Y',

             REGEXFIND('TRANSP'      		        ,poffense,0) <> '' and 
						 REGEXFIND('SEAL'                   ,poffense,0) <> '' and
						 REGEXFIND('BROK'                   ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('TRANSP'      		        ,poffense,0) <> '' and 
						 (REGEXFIND(liq_set+'|LIGUO|BEER|WINE|INTOX' ,poffense,0) <> '' OR
 						  REGEXFIND('OPEN'                  ,poffense,0) <> '' and REGEXFIND('BOTT'    ,poffense,0) <> ''
						 )  => 'Y',
						 
						 REGEXFIND(Intox        		          ,poffense,0) <> '' and 
						 REGEXFIND('BEV|REST|LIC|PERM|PRMT'   ,poffense,0) <> '' and
						 REGEXFIND(vio_set                    ,poffense,0) <> '' and
						 REGEXFIND('DRIV|[/\\. ]DL[/\\. ]|CHILD'           ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('NUD' 	       		         ,poffense,0) <> '' and 
						 REGEXFIND('EST'                     ,poffense,0) <> '' and
						 REGEXFIND('[/\\. ]ALC[COHOL]*[/\\. ]|LCOHOL|LCPHOL|PUBLIC',poffense,0) <> '' => 'Y',
						 						
						 REGEXFIND('POSS' 	       		       ,poffense,0) <> '' and 
						 REGEXFIND(intox+'|'+alc_set+'|WHISKEY',poffense,0) <> '' and
						 REGEXFIND('PUB|BEV|OPEN|UNDE|MINOR' ,poffense,0) <> '' => 'Y',
						 
             REGEXFIND('NUD'                		    ,poffense,0) <> ''and 
						 REGEXFIND('ENTERT|ESTAB|PROHIB|RESTRI' ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('PARK' 	       		      ,poffense,0) <> '' and 
						 REGEXFIND(intox                    ,poffense,0) <> '' and
						 REGEXFIND('ORDINANCE|[/\\. ]NO[/\\. ]|[/\\. ]IN[/\\. ]|CATIONVIOL|'+vio_set      ,poffense,0) <> '' => 'Y',

             REGEXFIND('ORD' 	       		        ,poffense,0) <> '' and 
						 REGEXFIND(intox+'|BEV'             ,poffense,0) <> '' and
						 REGEXFIND(vio_set                    ,poffense,0) <> '' => 'Y',

						 REGEXFIND('[/\\. ]OP[E]*N[/\\. ]'  ,poffense,0) <> ''and 
						 REGEXFIND('CONTNR'     		        ,poffense,0) <> '' => 'Y',

             REGEXFIND(IDSET 	       		        ,poffense,0) <> '' and 
						 REGEXFIND('[/\\. ]NO[T]*[/\\. ]' 	    ,poffense,0) <> '' and 
						 REGEXFIND('REQ' 	       		        ,poffense,0) <> '' and 
						 REGEXFIND(intox                    ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('HOUR|[/\\. ]HR[S]*[/\\. ]|MINOR| NON-DES AR |PREMIS' ,poffense,0) <> '' and 
						 REGEXFIND(intox                    ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('ABUS[INGE]*[/\\. ]| ABS ' 		,poffense,0) <> '' and 
						 REGEXFIND('H[A]*RMFUL|[/\\. ]HRM[FUL]*[/\\. ]' 		,poffense,0) <> '' and 
						 REGEXFIND(intox                    ,poffense,0) <> '' => 'Y',

						 REGEXFIND('PERMIT|PRMT|PROHIB' 		,poffense,0) <> '' and 
						 REGEXFIND(intox+'|DRINK|DRUNK'     ,poffense,0) <> '' => 'Y',						 
						 
             REGEXFIND('INDEC|INDCE|INDENC'     ,poffense,0) <> '' and 
						 REGEXFIND('SOLD' 	       		      ,poffense,0) <> '' and 
						 REGEXFIND(intox                    ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('EXPOS' 			            ,poffense,0) <> '' and 
						 REGEXFIND(Intox                    ,poffense,0) <> '' and
						 REGEXFIND('GENIT|BREAST'           ,poffense,0) <> '' => 'Y',						 
                         
             REGEXFIND('CONSUM|POSS|OPEN|[/\\. ]CONS[/\\. ]' 			,poffense,0) <> '' and 
						 REGEXFIND(Intox          				  ,poffense,0) <> '' => 'Y',
						 // REGEXFIND('INFLU|DUI|DWI|D[/.]*U[/.]*I[/.]*|D[/.]*W[/.]*I[/.]*|D [WU] I|DRIV(.*)UND(.*) INFL(.*)|DRIV(.*)INTOX',poffense,0) =  '' => 'Y',
					 
						 REGEXFIND('SELL|SALE|SERV|PURCH|FURNI|NUD|TRAF|CHILD|MINOR|JUV'               		,poffense,0) <> ''and 
						 REGEXFIND(Intox               		  ,poffense,0) <> '' => 'Y',

   					 REGEXFIND('FAKE|FALSE' 			      ,poffense,0) <> '' and 
						 REGEXFIND(Intox                    ,poffense,0) <> '' and
						 REGEXFIND('INFO|APP[/\\. ]|[/\\. ]O\\.L\\.|'+IDSET ,poffense,0) <> ''  => 'Y',

	           REGEXFIND(vio_set+'|[/\\. ]VIL[LATION]*[/\\. ]' ,poffense,0) <> '' and
						 REGEXFIND(liq_set                		           ,poffense,0) <> '' => 'Y', 
						 
             REGEXFIND('MANUF|DIST[I]*L|DISTRI' ,poffense,0) <> '' and 
						 REGEXFIND(Intox                    ,poffense,0) <> ''     => 'Y',
						  
						 REGEXFIND('TRANS|DELIVER'  								,poffense,0) <> '' and 
             REGEXFIND(Intox    								,poffense,0) <> '' and  
             REGEXFIND(dui      								,poffense,0) =  ''     => 'Y',
						 
						 REGEXFIND('OPEN(.*)CONT' 					,poffense,0) <> '' and 
						 REGEXFIND(Intox             				,poffense,0) <> '' => 'Y',
						 // REGEXFIND('INFLU|DUI|DWI|D[/\\.]*U[/\\.]*I[/\\.]*|D[/\\.]*W[/\\.]*I[/\\.]*|D [WU] I|DRIV(.*)UND(.*) INFL(.*)|DRIV(.*)INTOX',poffense,0) =  '' => 'Y',
						 
						 REGEXFIND('SELL|SALE|SERV|PURCH|FURNI|AID|ASSIST|[/\\. ]POS[SESION]*[/\\. ]',poffense,0) <> ''and 
						 REGEXFIND(Intox                       ,poffense,0) <> ''and  
						 REGEXFIND(misc                        ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('CONSUM|DRINK'              ,poffense,0) <> ''and 
						 REGEXFIND(Intox                       ,poffense,0) <> ''and  
						 REGEXFIND(misc                        ,poffense,0) <> '' and
						 REGEXFIND(dui    										 ,poffense,0) =  ''     => 'Y',
						 
						 REGEXFIND('^[ ]*[/\\. ]ABC[/\\. ]|[/\\. ]A[ \\.]+B[ \\.]+C[ \\.]+|VIO(.*) A[ \\.]*B[ \\.]*C',poffense,0) <> ''and  
						 REGEXFIND(vio_set+'|[/\\. ]VIL[OATION]*[/\\. ]|VILOATION|LAW|BEER|ALCOH|'+liq_set       ,poffense,0) <> '' => 'Y',

						 REGEXFIND('OPEN BOTTLE|OPEN/C PUBLIC PLACE',poffense,0) <> ''		  => 'Y',
						
						 REGEXFIND(' VEH[ICLE]* |PUBLIC'        ,poffense,0) <> '' and  
						 REGEXFIND(' IN '                       ,poffense,0) <> '' and
						 REGEXFIND(Intox+'|CONSUM'   					  ,poffense,0) <>  '' => 'Y',

						 REGEXFIND(' VEH |PUBLIC'               ,poffense,0) <> '' and  
						 REGEXFIND(' CONT '                     ,poffense,0) <> '' and
						 REGEXFIND(Intox             					  ,poffense,0) <>  '' => 'Y',

						 REGEXFIND('CHAPTER 123'                ,poffense,0) <> '' and
						 REGEXFIND(Intox             					  ,poffense,0) <>  '' => 'Y',
						 
						 REGEXFIND('SELL|SALE' 		                                          ,poffense,0) <> '' and						 
						 REGEXFIND('MALT|BEV'                                            		,poffense,0) <> '' => 'Y',

						 REGEXFIND(alc_set      		                                        ,poffense,0) <> '' and
						 REGEXFIND('POSN'     		                                          ,poffense,0) <> '' and						 
						 REGEXFIND('STORE'                                               		,poffense,0) <> '' => 'Y',

						 REGEXFIND(alc_set      		                                        ,poffense,0) <> '' and
						 REGEXFIND('UNDER'     		                                          ,poffense,0) <> '' and						 
						 REGEXFIND('21'                                                 		,poffense,0) <> '' => 'Y',

						 REGEXFIND('OPEN FLASK| T[\\.][ ]*O[\\.][ ]*C[\\.]| BP 25620| BP 25662 A '     		,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND(alc_set      		                                        ,poffense,0) <> '' and
						 REGEXFIND('PROVISIONS'     		                                    ,poffense,0) <> '' and						 
						 REGEXFIND('VIOLATION'                                          		,poffense,0) <> '' => 'Y',

             REGEXFIND('ALCOHOL VIOLATION|ALCOHOL/PUB/|ALCOHOL/CURB|ALCOHOL/POSN/|ALCOHOL ORDINANCE'	,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('POSS|PURCH'        		                                  ,poffense,0) <> '' and
						 REGEXFIND('MINOR| <21 AG'     		                                  ,poffense,0) <> '' and						 
						 REGEXFIND('MALT BEV'                                            		,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('MINOR IN POSSESSION'                                    ,poffense,0) <> '' => 'Y',
						 
							 'N');							 
							 
return Is_it;
end;
//--------------------------------------------------------------------------------------------------------------------------------------

export Is_DisorderlyConduct(string poffense_in) := function //done
																									
special_characters:= '~|=|!|%|\\^|\\+|:|\\(|\\)|,|;|_|-|#|@|\\*|<|>|"|`|\\[|]|\\{|\\}|\\\\|\'';
poffense          := ' '+REGEXREPLACE(special_characters, poffense_in, ' ');
																	 
DisorderlyConduct   :=  '^ DC |DEF[AE]CAT|ISORDERLY CONDUCT|[/\\ ]D[\\.]C[\\.][/ ]|[/\\. ]D/C[ONDUCT]*[/\\. ]|[/\\ ]D[\\.]C[\\.][PERSITNG\\.]*[/ ]|[/\\ ]D[\\.]C[\\.]I[\\.N]+|'+
                        'NUDE|INDEC|INDCE|INDENC|URIN[A]*TE|DISORDER[L]+[Y]*|DIS ORDER[ER]*LY|DISORDERY|NOISE|URINAT|DEFACAT|INDEC(.*)EXP| DIS[C/\\.]*COND | DIS[\\.][ ]*COND|'+
												'PC 647 A |PC 647 H |PC 288 A |PC 288 C |PC 314\\.1|PC 415 |PC 415 [12] |VC 27151 A | 2917\\.11 ';

DisorderlyConduct1  := 	'DI[S]*ORD[ERLY]* CON[DUCT]*|DISOR(.*)CON[DUCT]*[/\\. ]|DIS(.*)CONDUCT|RECKL[ESS]* COND[AUCT]*|RECKL[ESS]* COND[TACT]*|DIS CON[DUCT]*[/\\. ]| DIS[\\. ]COND[LUISNGCTF]+[INTOX]* |'+
												'DIS[OERDER]+LY COND|DIS[C]*OR[/D][ER]*[/ ]*CON[FD]| DIS[/ ]CONDM[.][ ]|DISC..[ ]*COND PER';
DC_Exc              := 'TAG|T\\.D\\.C\\.J|D[/]COC|WASH STATE|WASHINGTON|FORGE|NO DC|NO VALID|FRAUD|SUSP|CON SUB| REGIS';
                                                     

DisorderlyConduct2  := 'YELL|SHOUT|DISRUPTIV';
DisorderlyConduct3  := 'SPIT |SPITTING|EXPEC[TO]+RAT|EXPECT[UAE]RAT|EXPECTORANT|EXPE[IC]TORAT|EXPECTORIN|EXPECTUATIN|EXPELERAT';                                                                           
vio_set      := '[/\\. ]VIO[LATIONGS]*[/\\. ]|[/\\. ]VIO[LATED]*[/\\. ]|[/\\. ]VOL[LATIONGS]*[/\\. ]|[/\\. ]VOL[ILATED]*[/\\. ]|VIOLATION';                                                     																									 
// DCa                 := 'DIS';
// DCb                 := 'COND[UCT]*[/\\. ]';

DC2a                := 'INDCE|INDEC';
DC2b                := 'LANG|EXPOS|PHONE|WORDS|GESTU|PUBLIC|COND';

DC2c                := 'OBSCEN';
DC2d                := 'LANG|PHONE|WORDS|GESTU|PUBLIC|COND'; 
Is_it := MAP(In_Global_Exclude(poffense,'other')='Y' => 'N',

             // trim(poffense) in _fmod_offense_category_list.DisorderlyConductList =>'Y',
						 
             //this expression has to be above the  Is_LiquorLawViolations clause below. 
						 REGEXFIND('DI[SC]*ORDERLY|DISORDER|[/\\. ]DIS[ORDER]*[/\\. ]' ,poffense,0) <> '' and
						 REGEXFIND('[/\\. ]COND[UCT]*[/\\. ]|CONDUCT'      ,poffense,0) <> '' => 'Y', 
             //this expression has to be above the  Is_SexOffensesNon_forcible clause below. 
						 REGEXFIND('[/\\. ]INDE[CENTLY]*[/\\. ]|[/\\. ]INDC[ECNTY]*[/\\. ]|INDENC|INDECEN' ,poffense,0) <> '' and
						 REGEXFIND('[/\\. ]EXP[\\.0AIOSURE]*[/\\. ]|EXPOSURE'      ,poffense,0) <> '' => 'Y', 
				                                                                 
                                          
 						 Is_Assault_aggr(poffense)='Y'OR                   
						 Is_Assault_other(poffense)='Y'OR                   
						 Is_Pornography(poffense)='Y' OR                   
						 Is_SexOffensesForcible(poffense)='Y' OR          
						 Is_SexOffensesNon_forcible(poffense)='Y'   => 'N', 

             REGEXFIND('OBSCENI'           ,poffense,0) <> '' and
						 REGEXFIND('UTTER'             ,poffense,0) <> '' => 'Y',
						 
             REGEXFIND('EXPOS'             ,poffense,0) <> '' and
						 REGEXFIND('STATUTORY'         ,poffense,0) = '' and
						 REGEXFIND('SEX[UAL]*[/ ]ORGAN|GENIT|BREAST' ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('[/\\. ]DEP[OSITENG]*[/\\. ]' ,poffense,0) <> '' and
						 REGEXFIND('GAR[G]*BA|MATER'             ,poffense,0) <> '' and
						 REGEXFIND('SIDEW|STREE'                 ,poffense,0) <> '' => 'Y',

             REGEXFIND('REFUSE'                      ,poffense,0) <> '' and
						 REGEXFIND('LEAVE'                       ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('[/\\. ]D/O[/\\. ]'           ,poffense,0) <> '' and
						 REGEXFIND('CONDUCT|DRINK|INTOX'         ,poffense,0) <> '' => 'Y',

             REGEXFIND('[/\\. ]PUB[L]*[LICD]*[/\\. ]|PUBLIC',poffense,0) <> '' and
						 REGEXFIND('UR[NI]+ATION|URI[NI]+ATE|URI[NI]+ATING'               ,poffense,0) <> '' => 'Y',
						 
             REGEXFIND('DISORD'            ,poffense,0) <> '' and
						 REGEXFIND('PERSON'            ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('HOOT'              ,poffense,0) <> '' and
						 REGEXFIND('HOLL|SHOUT'        ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('[/\\. ]PUB[LICDSX]*[/\\. ]|PUBLIC' ,poffense,0) <> '' and
						 REGEXFIND('NUISA'                           ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('RECKL|RECKLESS'    ,poffense,0) <> '' and						 
						 REGEXFIND('[/\\. ]COND[AUCT]*[/\\. ]|[/\\. ]CONT[UACT]*[/\\. ]|CONTACT|CONDUCT'         ,poffense,0) <> '' => 'Y',						 
						 //
						 REGEXFIND('MORAL|DECENC'      ,poffense,0) <> '' and
						 REGEXFIND('CRIME'             ,poffense,0) <> '' => 'Y', 
						 
						 REGEXFIND('ROGUE'             ,poffense,0) <> '' and
						 REGEXFIND('VAGABOND'          ,poffense,0) <> '' => 'Y', 

             REGEXFIND('OBSC'              ,poffense,0) <> '' and
						 REGEXFIND('WRIT'              ,poffense,0) <> '' => 'Y', 
						 
             REGEXFIND('CURSE'                         ,poffense,0) <> '' and
						 REGEXFIND('[/\\.& ][A]+BUS[SEINGDV]*[/\\. ]|[/\\.& ][A]+BUS[SERT]*[/\\. ]|ABUSED'    ,poffense,0) <> '' => 'Y', 

						 REGEXFIND('LOUD'      ,poffense,0) <> '' => 'Y',

             REGEXFIND('NOISE'     ,poffense,0) <> '' and
						 REGEXFIND('DISTURB|UNNECE[S]+ARY|ORDINANCE|EXCESS|'+vio_set   ,poffense,0) <> '' => 'Y',

             REGEXFIND('DRUG'      ,poffense,0) <> '' and
             REGEXFIND('CONDITION' ,poffense,0) <> '' => 'N',

             // REGEXFIND(DCa         ,poffense,0) <> '' and
						 // REGEXFIND(DCb         ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND(DC2a ,poffense,0) <> '' and
						 REGEXFIND(DC2b ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND(DC2c ,poffense,0) <> '' and
						 REGEXFIND(DC2d ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND(DisorderlyConduct ,poffense,0) <> '' and 
						 REGEXFIND(DC_Exc            ,poffense,0) = '' => 'Y',
						 
						 REGEXFIND(DisorderlyConduct1 ,poffense,0) <> '' and 
						 REGEXFIND(DC_Exc            ,poffense,0) = '' => 'Y',
						 
						 ( REGEXFIND(DisorderlyConduct2 ,poffense,0) <> '' OR
              (REGEXFIND('DISTURB' ,poffense,0) <> '' and REGEXFIND('PEAC' ,poffense,0) <> '')
						 ) AND
						  REGEXFIND('YELLOW' ,poffense,0) = '' 	 => 'Y',
						 
						 (REGEXFIND(DisorderlyConduct3 ,poffense,0) <> '' OR
						 (REGEXFIND('EXPEL' ,poffense,0) <> '' and REGEXFIND('SALIVA' ,poffense,0) <> '')) and
						  REGEXFIND('HOSPITA' ,poffense,0) = '' => 'Y',

						 'N');
return Is_it;
end;
//--------------------------------------------------------------------------------------------------------------

export Is_TrespassofRealProperty(string poffense_in) := function //done

special_characters:= '~|=|!|%|\\^|\\+|:|\\(|\\)|,|;|_|-|#|@|\\*|<|>|"|`|\\[|]|\\{|\\}|\\\\|\'';
poffense          := ' '+REGEXREPLACE(special_characters, poffense_in, ' ');

TrespassofRealProperty      := 'TRANSPAS|TRES[PASS]*|TRESSPASS|TR[ES]PASS|TREAPAS|TRSP[S]* |810.09.2A|810.08.2A|810.09.2B|810.09.1A1|'+
                               'PC 602\\.5|PC 602 |PC 602\\.1 A |PC 369 I |PC 369I A ';

Is_it := MAP( In_Global_Exclude(poffense,'other')='Y'      OR
              Is_Burglary_BreakAndEnter_res(poffense)='Y'  OR
							Is_Burglary_BreakAndEnter_comm(poffense)='Y' OR
							Is_Burglary_BreakAndEnter_veh(poffense)='Y'  => 'N',
							
						 // trim(poffense_in) in _fmod_offense_category_list.TrespassingList =>'Y',

             REGEXFIND('ENTER|ENTYR|ENTRY'            ,poffense,0) <> '' and	
             (REGEXFIND('UNAUTH'                      ,poffense,0) <> '' or
             ( REGEXFIND('WITHOUT|[/\\. ]W[/]O[UT]*[/\\. ]|[/\\. ]W[- ]O[/\\. ]|[/\\. ]NO[/\\. ]',poffense,0) <> '' and 
						   REGEXFIND('INTENT ',poffense,0) <> '')) and	
						 REGEXFIND('THEF| FEL |CARPENTRY|DAMAG'   ,poffense,0) = '' => 'Y',  
						 
						 REGEXFIND('PARK'                         ,poffense,0) <> '' and
             REGEXFIND('AFTER'                        ,poffense,0) <> '' and	
             REGEXFIND('REMAIN|ENTER|TRESP|TEPASS|BEING|INSIDE|[/\\. ]IN[/\\. ]|OCCUPY',poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('UNLAW'                        ,poffense,0) <> '' and
             REGEXFIND('REMAIN'                       ,poffense,0) <> '' and	
             REGEXFIND('[/\\. ]PK[/\\. ]|PUBLIC'                   ,poffense,0) <> '' => 'Y',	
						 
						 REGEXFIND('FAIL'                         ,poffense,0) <> '' and	
             REGEXFIND('[/\\. ]LEAV[E]*[/\\. ]|LEAVE' ,poffense,0) <> '' and 
						 REGEXFIND('INFO|[/\\. ]ID[ENTIFCAON]*[/\\. ]|IDENTI|[/\\. ]PFD[/\\. ]|COMPLY|SCENE|[/\\. ]ACCI[DENT]*[/\\. ]|COLLISION|CRASH',poffense,0) = ''  => 'Y',
						 
						 REGEXFIND('HUNT|FISH|TRAP'               ,poffense,0) <> '' and	
             REGEXFIND('POST'                         ,poffense,0) <> '' => 'Y',	

						 //QA Update - Trespassing Round 6
             REGEXFIND('REFUS[ALING]+ TO LEAVE'       ,poffense,0) <> '' => 'Y',	   	               
						 
             REGEXFIND(TrespassofRealProperty         ,poffense,0) <> '' => 'Y',	       
						 
             REGEXFIND('SLEEP|LODG|CAMP'              ,poffense,0) <> '' and
						 REGEXFIND('PROHIB'                       ,poffense,0) <> '' and	
             REGEXFIND('PLAC |PLACES|AREA'            ,poffense,0) <> '' => 'Y',
						 
						 'N');
return Is_it;
end;
//--------------------------------------------------------------------------------------------------------------------------------------

export Is_traffic(string poffense) := function
 
LIC1         :=   '^D.LICENSE|^D[/\\. ]*L[IC/\\. ]*NOT|DR(.*)LIC(.*)LAW|DISP[LAY]*(.*) LICENSE|CONDITIONAL LICENSES|CANCEL[LED]* LICENSE|ALLOW(.*)NON[ -]*LICENSED|'+
                  'PERMIT(.*)UNLICENSED|CHAUF(.*) LIC|LICENSE REQ|NO(.*) LICENSE|LIC. SUS.|DRG LIC SUS[/]REV PURS TO SEC|OPERATING WHILE REVOKED|'+
									'ALLOW(.*) UNLIC(.*)|ALLOW(.*) NON(.*)LIC(.*) DR|LICENSE RESTR|ST[ATE]* LIC(.*)PLAT|FAIL WEAR LICEN|FAIL[URE]*(.*)DISPLAY LICENSE|'+
                  'FAIL[URE]*(.*)EXHIBIT[ED]*(.*)LICENSE|LICENSE(.*)CARRIED|SUSPENDED(.*) LICENSE|IMPR(.*) LIC|FAIL(.*) LIC|RESTRICT[ED]* LIC[ENSE]*|'+									
									'SUSP[ \\.]LIC|VALID LIC|^EXP(.*) LIC|^FIC[TICIOUS]* LIC| FIC[TICIOUS]* LIC|NO LIC|PRESENT LICENSE|^O[-\\. /]L[ \\.]|RECK DR:|'+
									'NO DR(.*) LIC|NO OPERATOR(.*) LIC|UNLIC(.*) VEH| DL |^(VIO[ .])*D[/\\. ]*L[/\\. ]*LAW|ALLOW(.*)REVOKE|MOPED LICENS|LICENSE PLATE|'+
									'LICENSE SUSPENSION|LSOA WITHOUT GIVING INFO|NO VALID D[\\./ ]+L[\\. ]|OPER SUSP[/]REV';		
//DIS(.*) LIC|															
traffic_list :=   '^TAG[;: ]|12 P[OIN]*T|^AUTO |ACCIDENT|ABAND(.*)VEH|ABAND(.*)M/V|BUMPER|BRAKES|PERIOD[S]* FOR REQUIRING LIGHTED LAMPS|HEAD[ ]*LAMPS[- ]+(.*)[ ]*VEH|'+	                 
                  'CHILD(.*) SEAT|[ *]CMV|^CMV |EXCEED[ING]* [0-9]+ MPH|^DUS|DR (.*)SUSP|DR (.*)REV|DL SUSP|DISR(.*) SAFE|WINDSHIELD[S]* REQUIRED|'+ 
									'CITATION|COMMERCIAL TAG REQ|CANCEL(.*) O[. /]L|[C]*DL RESTRICTION|PARENT, GUARDIAN, OTHER ALLOWING|ALLOWING UNAUTHORIZED|ALLOWING UNLAWFUL|'+
                  'IMPROPER REG|IMPROPER CLASS|IMPROPER I[.]*D|NO SINGLE STATE|STATE TAG|IMPR(.*) TAG|FINANCIAL RESP|REGISTRATION REQUIRED|^REG(.*) LAW|REG(.*) EXP|'+
                  'NOT[ICE ]+OF CH[AN]*G[E]*(.*) ADD|FAIL(.*)CHANGE(.*)ADD[RESS]|FAIL(.*) TO COMPLY|FAIL TO SURR|FAIL TO REG|FAIL(.*) APPR|'+
                  'NOTIFY CHP|NOTIFY(.*) ADD(.*) CHANGE|SU[SPE]+NDED|EXP[ .]|EXPIRE|^EXP(.*) PL|^EXP(.*) RE|^EXP(.*) TAG|'+
                  'VALID REG|VIOLATION(.*) YOA|DIS(.*) REG|RADAR|^R[./ ]+D[. -/]|^R[ ]*D[:. /]+|DWLS|OBSCURED (.*)[ ]*PLATE|'+
                  '^FIC[TICIOUS]* PL|^FIC[TICIOUS]* RE|^FIC[TICIOUS]* TAG| FIC[TICIOUS]* PL| FIC[TICIOUS]* RE| FIC[TICIOUS]* TAG';
//EXPIRED|FAIL(.*) REG|

 traffic_list2 :=	'LEFT OF CENTER|FOLLOW[ING]* TOO CLOSE|MUFFLER|MUDGUARD|EXCEED 65 OR 70 MPH FOR ALL VEHICLES BY|DEFECTIVE WINDSHIELD|ASSURED CLEAR DIST|'+		                								  
	                'HWY SIGN|HELMET|H[OU]*R[\\. ]*RULE|HIGHWAY|HIT (.*)SKIP|WIDE[ ]*LOAD|WRONG CLASS|NO(.*) O[\\. /]*L|NO CERT|'+
                  'NO(.*) REGISTRATION|^NO OP[A-Z]* |^NO OL |^NO D[\\. ]*L|NO LIAB[ILITY]* INS[URANCE]*|NO VALID MVI|OVER LIC[\\.ENSED ]+WEIGHT|'+
                  '^LOG[ ]*BOOK|NO LOG BOOK|NO O[/ .]L[\\. ]|NO OVERSIZE PERMIT|NO OVERWIDTH PERMIT|OVERW[EI]+GHT|OVERH[EI]+GHT|'+		
							    'OMVI|^OUI|^OWI| OWI | OUIL|OPER(.*) W(.*)O(.*) CARRIER PERMIT|OL(.*) SUSP|OVER [GROSS ]*WEIGHT|'+
                  '[O0]\\.V\\.I|[O0][/]V[/]I|OVI |OVER[ ]*WIDTH|OVER[ ]*SIZE|OVER[ ]*LIMIT|OVER[ ]*LENGTH|OVERDIMENSIONAL LOAD|ODOMETER|'+ 
                  'OPER(.*)CERT|RIGHT OF WAY|RIGHT TURN|CONT(.*) DEV|VEHICLE[S]* SUBJECT TO REGISTRATION|EVIDENCE OF REGIS|EVID REG SIGN';
//ROAD|									
 traffic_list3 := 'SIGNAL|^REV[.OKE ]+|^SUSP|^SURR|SEA[TL][ ]*B[EA]*LT|TRANSPORTER|TOLLWAY|TOO FAST|STO[P]+ING AFTER ACC|'+
                  'UNREGISTERED|UNINSURED|UNSECURE(.*) LO\\]AD|UNSAFE BACKING|VIO(.*) REG|WINDSHIELD WIPERS|STARTING [AND\\&]+ BACKING|'+	
                  'WHEEL|WRONG SIDE|WRONG DIRECTION|WRONG WAY|WINDSHEILD|TINT|UNSIGNED REGISTRATION|YIELD|PK[0-9]+[ 0-9]+$|'+
									 'HORN|FMCSR|FMCSK|PWC|MCV[-:]|PEDEST|VSRL|U[/ -]*TURN|RD[-/]SP|PARKING|RIDE|RIDING|DWLR|CFR[ ]*-|SIDE WINDOWS[-: ]+RESTRICT|'+
									 'CRASH|USDOT | US DOT[ #]|^DPS[- /]|ILLEGAL SUN[ ]*SHAD|WINDSHIELD[S]*[- ]+SIGN[,/ ]+COVERING[,/ ]+SUNSCREEN MATERIAL';

 traffic_list4 := 'SUSPD[-)/ \\.]|SPD[-)/ \\.]|SPDG[-\\. ]|BOAT|BICYCLE|BIKE|CYCLING|D\\.[ ]*U\\.[ ]*S|D[/]U[/]S|D\\.[ ]*W\\.[ ]*[0OD][\\. ]*L|D[ ]*\\.[ ]*W[ ]*\\.[ I]*[OL]|D\\.[ ]*W\\.[ ]*[SR]|'+   
                  'D[/]W[/]O[/]L|D[/]W[/]L|D[/]W[/]O|D[/]W[/]S|D[/]W[/]R';  
									
 traffic_list5 := 'LANE|DISOBEY|^DUS[-/ ]|[-/ ]DUS[-/ ]|[-/ ]DWOL[-/ ]|^DWOL[-/ ]|DWOVDL|[-/ ]DWS[-/ ]|^DWS[-/ ]|[-/ ]DWR[-/ ]|^DWR[-/ ]|D[ ]*W[ ]*L[ ]*S[/]R |'+
                  '^DLWSR[-/ ]|[-/ ]DLWSR[-/ ]|DSLW[/]R |[-/ ]DWSOL[-/ ]|^DWSOL[-/ ]|SPDOMTR|DWLC/S/R/L';
									
 traffic_list6 :='322.34.2|322.031[(]1[)]|322.03.1|3162952[(]2[)]B|169-475-2|322\\.34[(]10[)]|17AAC25\\.210|169-06-5-A-3-III|316130[(]11[)]|316614[(]4[)(]+A[)]|DAC[/]IPS|'+
                 'VC 22350 |VC 22349[(]A[)]|VC 12500[(]A[)]|VC 16028[(][AC][)]|VC 20002[(]A[)]|VC 4000[(]A[)]|VC 12500[(]B[)]|VC 12500[(]D[)]|VC 27315[(][DEF][)]|VC 21453[(][AC][)]|VC 22450[(]A[)]|'+
                 'VC 14601\\.1[(]A[)]|VC 16028[(]A[)]|VC 27315[(][DEF][)]VC 14601\\.5[(]A[)]|VC 26708[(]A[)][(]1[)]|VC 26708\\.5|VC 22101[(][AD][)]|VC 21461[(]A[)]|VC 21461\\.5 |VC 14601\\.[25][(]A[)]|'+
                 'VC 14601[(]A[)]|VC 16028(C)|VC 12951[(]A[)]|VC 23103\\.5|VC 23103 |VC 23103[(]A[)]|VC 22349[(]B[)]|VC 16020[(]A[)]|VC 5200 |VC 5200[(]A[)]|VC 24252[(]A[)]|VC 4454[(]A[)]|VC 22451[(]A[)]|'+
                 'VC 14600[(]A[)]|4511\\.21|4513\\.263|4511\\.21D1|4511\\.202|4511\\.19A1|4511\\.43A|VC 5204[(]A[)]|VC 23123[(]A[)]|VC 23123\\.5[(]A[)]|VC 22454[(]A[)]|VC 26453|VC 21703 |VC 24601 |VC 35550[(]A[)]|'+
                 'VC 27007 |VC 21658[(]A[)]| VC 23222[(]B[)]|VC 2800\\.[12]|VC 27360[(]A[)]|VC 27360\\.5[(][AB][)]|VC 27360[(]B[)]|VC 21212[(]A[)]|VC 21755 |14601VC|VC 21460[(]A[)]|VC 21460\\.5[(]C[)]|VC 24250 ';

 traffic_list7 :='VC 24400 |VC 24400[(]A[)]|74-55-B|VC 24603[(][BE][)]|VC 24603 |VC 24002[(][AB][)]|VC 22107 |VC 26710 |VC 21651[(]A[)]|VC 21651[(]A[)]|VC 2815 |VC 21453[(]B[)]|VC 35551[(]A[)]|VC 21801[(]A[)]|316063[(]1[)]|'+
'VC 4462\\.5|VC 4462[(]B[)]|VC 22406[(][AB][)]|VC 21950[(]A[)]|VC 23111|VC 27600|VC 21650 |VC 21650\\.1|VC 20001[(]A[)]|VC 20001 |VC 21955 |VC 24600[(][ABE][)]|VC 22348[(][BC][)]|VC 22100[(][AB][)]|VC 22400[(]A[)]|'+
'VC 21804[(]A[)]|VC 21802[(]A[)]|487465 VBR|VC 27151[(]A[)]|VC 31 |VC 21201[(][D[)]|VC 27465[(]B[)]|4507\\.02A|VC 21457[(]A[)]|VC 5201 |VC 5201[(]F[)]|VC 21718[(]A[)]|VC 34506\\.3|VC 345063 |VC 23225[(]A[)]|'+
'VC 14603 |VC 22106 |VC 22102 |VC 4159 |VC 26101 |VC 27150[(]A[)]|4513\\.263[(]P|4513\\.263 |VC 38366[(]A[)]|VC 21800[(]D[)][(]1[)]|4507\\.02B|VC 22108 |VC 23223[(]A[)]|VC 23223 |VC 10852|VC 12814\\.6|VC 14604[(]A[)]|'+
'VC 21655\\.5[(]B[)]|VC 27156[(]B[)]|VC 21456[(]B[)]|VC 2800\\.1|VC 22526[(]C[)]|VC 22526[(]A[)]|VC 21209[(]A[)]|VC 27153 |VC 2818 |VC 34507\\.5[(][AB][)]|VC 23109[(]C[)]|VC 27803[(]B[)]|VC 21453[(]D|'+
'VC 24003 |VC 35400[(]A[)]|VC 21367[(]C[)]|VC 23224[(]A[)]|73\\.20[(]A[)]|VC 25950[(]A[)]|VC 38020|VC 24953[(]A[)]|VC 26709[(]A[)]|VC 27400 |VC 21806[(]A[)]|4503\\.21|VC 27900[(]A[)]|VC 23247[(]E[)]|6701H 1B ';																

 exclude_list_traffic := 'DEER|DOG|FISH|WILD[ LIFE]*|SU[SP]*(.*) SENT|SEX|REGISTRY|OCCUPATION|PROBATION|VIO(.*) REGULATION|THEFT|VANDALISM|TRES[S]*PASS|TRAFFICING|TRAFFICKING|'+
		             'NARCOTIC|COCAIN|TRAFFIC[ /]DR[UG]+|CHILD TRAFFIC|TRAFFIC [HERO]*IN|TRAFFIC MAR|TRAFFIC[ /]CO|DRUG TRAFFIC|TRAFFIC NARC|TRAFFIC CRA[CK]+|TRAFFIC ECSTASY|AGG(.*)TRAFFIC|'+
								 'RSP|FIREARM';		

Is_it := MAP(

            // trim(poffense) in _fmod_offense_category_list.Trafficlist =>'Y', 
						
            In_Global_Exclude(poffense,'other')='Y' => 'N',
              
						Is_Arson(poffense)='Y' OR                        
						Is_Assault_aggr(poffense)='Y' OR                      
						Is_Assault_other(poffense)='Y' OR                      
						Is_Bribery(poffense)='Y' OR                      
						Is_Burglary_BreakAndEnter_res(poffense)='Y' OR
						Is_Burglary_BreakAndEnter_comm(poffense)='Y' OR 
						Is_Burglary_BreakAndEnter_veh(poffense)='Y' OR 
	  				Is_Counterfeiting_Forgery(poffense)='Y' OR       
						Is_Destruction_Damage_Vandalism(poffense)='Y' OR
						Is_Drug_Narcotic(poffense)='Y' OR              
						Is_Fraud(poffense)='Y' OR                        
						Is_Gambling(poffense)='Y' OR 
						Is_Homicide(poffense)='Y' OR                     
						Is_Kidnapping_Abduction(poffense)='Y' OR         
						Is_Theft(poffense)='Y' OR   
						Is_Shoplifting(poffense)='Y' OR
						Is_Motor_Vehicle_Theft(poffense)='Y' OR          
						Is_Pornography(poffense)='Y' OR                  
						Is_Prostitution(poffense)='Y' OR                 
						Is_Robbery_res(poffense)='Y' OR    
						Is_Robbery_comm(poffense)='Y' OR    
						Is_SexOffensesForcible(poffense)='Y' OR          
						Is_SexOffensesNon_forcible(poffense)='Y' OR      
						Is_Stolen_Property_Offenses_Fence(poffense)='Y' OR
						Is_Weapon_Law_Violations(poffense)='Y' OR        
						Is_Identity_Theft(poffense)='Y' OR               
						Is_Computer_Crimes(poffense)='Y' OR              
						Is_Terrorist_Threats(poffense)='Y' OR            
						Is_Restraining_Order_Violations(poffense)='Y' OR 
						Is_BadChecks(poffense)='Y' OR                    
						Is_CurfewLoiteringVagrancyVio(poffense)='Y' OR   
						Is_DisorderlyConduct(poffense)='Y' OR            
						Is_DrivingUndertheInfluence(poffense)='Y' OR     
						Is_Drunkenness(poffense)='Y' OR                  
						Is_FamilyOffenses(poffense)='Y' OR     
						(Is_LiquorLawViolations(poffense)='Y' and REGEXFIND('^TRAFFIC',poffense,0)='') OR          
						Is_TrespassofRealProperty(poffense)='Y' OR       
						Is_PeepingTom(poffense)='Y' OR                   
						Is_HumanTrafficking(poffense)='Y' =>  'N', 
						
						REGEXFIND('WILD|ANIMAL|WOLF|RACCOON|HUNT|MONKEY|COUGAR|FARE|FISH|DEER|GAME|BOMB' ,poffense,0) <> ''  => 'N',

						//Roger's comments - QA Update - Traffic   Round 3 8/26/16		
						REGEXFIND('DRIV|OPR'                             		 ,poffense,0) <> '' and
					  REGEXFIND('U/INFLU|/U THE INFLU|/INFLUENCE|W/UND/INFLU',poffense,0) <> ''  => 'N',
						
						REGEXFIND('DRIV[E|I| |\\.]|BOATING|OPR'              ,poffense,0) <> '' and
					  REGEXFIND('INFLUEN'                          				 ,poffense,0) <> ''  AND
						REGEXFIND('UNDER|UND|WHILE|LIQUOR|ALCOH|DRUG|NAC|CONT[.]+SUB|SUB[.*]CONT',poffense,0) <> '' => 'N',						
						
						//Roger's comments - QA Update - Traffic   Round 4 9/23/16 and 9/27/16
						REGEXFIND('BUSIN[ESS]*|VENDOR'                       ,poffense,0) <> '' and
					  REGEXFIND('LICENSE|LIC |LIC[\\.]?$|LICENS$|PERMIT'	 ,poffense,0) <> '' and
					  REGEXFIND('NO[T]? |EXPIRED|FAIL[ |E|U|/]|SUSPEND|NO |REQ[U| ]|WITHOUT|W/O',poffense,0) <> ''  => 'N',
						
						REGEXFIND('HIT'             ,poffense,0) <> '' AND              
						REGEXFIND('RUN'             ,poffense,0) <> '' => 'Y',
						
						REGEXFIND('INFRACTION VC'                            ,poffense,0) <> '' => 'Y',
						
						REGEXFIND('VEH| M[/]*V '                             ,poffense,0) <> '' and
					  REGEXFIND('COMM|SUSP|REVOC'                          ,poffense,0) <> '' and
            REGEXFIND('^DR[-/ ]|[-/ ]DR[-/ ]|[-/ ]OP[-/\\. ]|OPER'       ,poffense,0) <> '' => 'Y',
						
						REGEXFIND('SUSP|REVOC'                               ,poffense,0) <> '' and
            REGEXFIND('^DR[VING]*[-/ ]|[-/ ]DR[VING]*[-/ ]'          ,poffense,0) <> '' => 'Y',
						
						REGEXFIND('VEH| M[/]*V '                              ,poffense,0) <> '' and
					  REGEXFIND(' NO |NON|REQ|REST|DEF|IMPRO| ON |^NO |ALL|OPER|VIEW| W[/]O |MISS| T[/]H ',poffense,0) <> '' and
            REGEXFIND('MIRROR'                                   ,poffense,0) <> '' => 'Y',
						
						REGEXFIND('PASS'                                     ,poffense,0) <> '' and
					  REGEXFIND('SHOULD'                                   ,poffense,0) <> '' and
            REGEXFIND('[-/ ]IN[-/ ]|[-/ ]OF[-/ ]|[-/ ]ON[-/ ]|[-/ ]OL[-/ ]'   ,poffense,0) <> '' => 'Y',
						
						REGEXFIND('^DR[-/ ]|[-/ \\.]DR[-/ ]|DRV[N]*G'              ,poffense,0) <> '' and
					  REGEXFIND('RDWAY'                                    ,poffense,0) <> '' and
            REGEXFIND('[-/ ]OF[-/ ]|[-/ ]ON[-/ ]'                ,poffense,0) <> '' => 'Y',
						
						REGEXFIND('DEF'                                      ,poffense,0) <> '' and
						REGEXFIND('EQUIP'                                    ,poffense,0) <> '' and
					  REGEXFIND('TURN'                                     ,poffense,0) <> '' and
            REGEXFIND('SIG'                                      ,poffense,0) <> '' => 'Y',
						
						REGEXFIND('UNLAW'                                    ,poffense,0) <> '' and
						 ( REGEXFIND('TIRE'   ,poffense,0) <>'' OR
						  (REGEXFIND('LANE'   ,poffense,0) <>'' and REGEXFIND('CHANG|CHANI',poffense,0) <> '') 
						 ) => 'Y',
 
            REGEXFIND('FTO |^FTO' ,poffense,0) <> '' and 
						~(
					   	 (REGEXFIND(' CT '    ,poffense,0) <>'' and REGEXFIND('ORD' ,poffense,0) <> '') or
							 (REGEXFIND('GOOD'    ,poffense,0) <>'' and REGEXFIND('BEHAV',poffense,0) <> '' ) 
						 )  => 'Y',
 
             REGEXFIND('OBEY|OBY'                                ,poffense,0) <> '' and						 
						 REGEXFIND('FA'                                      ,poffense,0) <> '' and	
						 (
							  REGEXFIND('EMERG EQP|CROSSING GU|NO U TUR|SIG|HW[A]*Y|RED|RIGHT|HIGHW|LANE|DEVIC|LIC|FLASH|HGY|HAYW|HI[G]*WAY|HSWY|HW|SGN|BLIN|WAKE|O[\\./]L',poffense,0) <>'' or
							 (REGEXFIND('LN'      ,poffense,0) <>'' and REGEXFIND('CHANG|DREC|DIR|MRKNG' ,poffense,0) <> '') or
							 (REGEXFIND('TRA'     ,poffense,0) <>'' and REGEXFIND('LGHT'                 ,poffense,0) <> '') or
							 (REGEXFIND('TRAF'    ,poffense,0) <>'' and REGEXFIND('DE|CNT|CTRL|CNTRL|CON',poffense,0) <> '' ) or
							 (REGEXFIND('TRF|TRFC',poffense,0) <>'' and REGEXFIND('SGN|DEV|CONTR|LT|LITE',poffense,0) <> '' ) or
							 (REGEXFIND('TURN'    ,poffense,0) <>'' and REGEXFIND('ARROW',poffense,0) <> '' ) 
						 )  => 'Y',
						 
						 REGEXFIND('FAIL'                                    ,poffense,0) <> '' and
						 (
						 (REGEXFIND('VEH'    ,poffense,0) <>'' and REGEXFIND('UNDER'    ,poffense,0) <> '' and REGEXFIND('CONT' ,poffense,0) <> '') or
						 (REGEXFIND('GIVE'   ,poffense,0) <>'' and REGEXFIND('NOTICE'   ,poffense,0) <> '' and REGEXFIND('ACC' ,poffense,0) <> '') or
						 (REGEXFIND('AVOID'  ,poffense,0) <>'' and REGEXFIND('COLLIS'   ,poffense,0) <> '') or
						 (REGEXFIND('DIM'    ,poffense,0) <>'' and REGEXFIND('BEAM| LT | LTS ',poffense,0) <> '') or
						 (REGEXFIND('REMAIN' ,poffense,0) <>'' and REGEXFIND('LANE|SCEN|ACC',poffense,0) <> '') or
						 (REGEXFIND('CONTROL',poffense,0) <>'' and REGEXFIND('WEAVING|VEHICLE',poffense,0) <> '') or
						 (REGEXFIND('RIGHT'  ,poffense,0) <>'' and REGEXFIND('CNT |CTR ',poffense,0) <> '') or
						  REGEXFIND('PROOF OF INSURANCE|KEEP RIGHT',poffense,0) <> ''  
						 
							) => 'Y',


							REGEXFIND('UNLAW'   ,poffense,0) <> '' and REGEXFIND('OP'  ,poffense,0) <>'' and REGEXFIND('HWY' ,poffense,0) <> '' and REGEXFIND(' MV | M[/]V |VEH|MOTOR' ,poffense,0) <> '' => 'Y',
							REGEXFIND('DEADLINE',poffense,0) <> '' and REGEXFIND('OP|OPER'  ,poffense,0) <>'' and REGEXFIND('AFTER|PAST' ,poffense,0) <> '' and REGEXFIND(' M[\\./]*V[\\. ]|VEH' ,poffense,0) <> '' => 'Y',
							
						 REGEXFIND('FAIL|FALSE|WRONG'                      ,poffense,0) <> '' and
						 REGEXFIND('DISPL'                                 ,poffense,0) <> '' and
						 (REGEXFIND('D[\\.]L[\\.]| D[/]L |PLATE| REG | INSP',poffense,0) <>'' or
							 (REGEXFIND('INSPECT| MV[I]* '  ,poffense,0) <>'' and REGEXFIND('STICKER' ,poffense,0) <> '') 
							) => 'Y',
							
 						 REGEXFIND('FAIL'                                    ,poffense,0) <> '' and
						 REGEXFIND('USE'                                     ,poffense,0) <> '' and
						 (REGEXFIND('INDICATOR ',poffense,0) <>'' or
							 (REGEXFIND('SAF'     ,poffense,0) <>'' and REGEXFIND('SEAT' ,poffense,0) <> '') 
							)  => 'Y',
							
						 REGEXFIND('FAIL'                                    ,poffense,0) <> '' and
						 REGEXFIND('EMER'                                    ,poffense,0) <> '' and
						 (REGEXFIND('YLD|YIELD'                              ,poffense,0) <>'' or
							 (REGEXFIND('CHANG'   ,poffense,0) <>'' and REGEXFIND('LANE' ,poffense,0) <> '') 
							)  => 'Y',	
							
						 REGEXFIND('EXHAUST'                                 ,poffense,0) <> '' and
						 REGEXFIND('BATH|VENT'                               ,poffense,0) =  '' => 'Y',	
						
						 REGEXFIND('CARRY '                                  ,poffense,0) <> '' and
						 REGEXFIND('INS'                                     ,poffense,0) <> '' and
						 REGEXFIND('LIAB|COMP|VEH|MOTOR|AUTO| MV | M[/]V '   ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('FAIL'                                    ,poffense,0) <> '' and
						 REGEXFIND('DE |MNT | DR[V]* |MAIN|CHNG |CHG '       ,poffense,0) <> '' and
						 REGEXFIND('SG[N]*L |SIG | SING| [S1][- ]| ONE'      ,poffense,0) <> '' and
						 REGEXFIND('[- ]LN |LANE'                            ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('FAIL'                                    ,poffense,0) <> '' and
						 REGEXFIND('PASS'                                    ,poffense,0) <> '' and
						 REGEXFIND('WEAR|FAST'                               ,poffense,0) <> '' and
						 REGEXFIND('S[/]BEL|SEAT| SE | S '                   ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('FAIL'                                    ,poffense,0) <> '' and
						 REGEXFIND('SGL |SIG | SING|SIGN '                   ,poffense,0) <> '' and
						 REGEXFIND('TURN|INTENT| LN '                        ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('RACING'                                  ,poffense,0) <> '' and
						 REGEXFIND('HWY'                                     ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('DRAG'                                    ,poffense,0) <> '' and
						 REGEXFIND('RAC'                                     ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('DR[/\\. ]|DR[IV][\\. ]|DR[IA]+VE|DRV[IN]*G[\\. ]|DRVE |[-/ ]DRG[-/ ]|^DRG[-/ ]'                                ,poffense,0) <> '' and						 
						 (	REGEXFIND('SHOULDER|ONEWAY'     ,poffense,0) <> '' or
							 (REGEXFIND('LEFT|LFT |LF |PROH'         ,poffense,0) <>'' and REGEXFIND('CNTR|CTR |CENT|SHOULD|SHLDR'     ,poffense,0) <> '') or
							 (REGEXFIND('[-/ ]ON[-/ ]'               ,poffense,0) <>'' and REGEXFIND('SHOULD|SHLDR|MEDIAN|ISLAND|MED ' ,poffense,0) <> '') or
							 (REGEXFIND('[-/ ]WR[-/ ]|[-/ ]WRG[-/ \\.]' ,poffense,0) <>'' and REGEXFIND('[-/ ]SD[-/ ]|SIDE|WAY|[-/ ]RD[-/ ]|[-/ ]SS[-/ ]|[-/ ]ST[-/ ]'    ,poffense,0) <> '') or
							 (REGEXFIND('W[/]O | WO |W[/]OUT',poffense,0) <>'' and REGEXFIND('H[EA]*DLT|[-/ ]LT[-/ ]|[-/ ]LTS[-/ ]',poffense,0) <> '' ) or
							 (REGEXFIND('ONE[-/ ]'           ,poffense,0) <>'' and REGEXFIND('WAY'                             ,poffense,0) <> '' ) or
							 (REGEXFIND('OFF[-/ ]'           ,poffense,0) <>'' and REGEXFIND('RDWAY|RDWY'                      ,poffense,0) <> '' ) 
						 )  => 'Y',
						 
						 REGEXFIND('^FMC |^FOHS[\\( ]|^FMFR |^FTMFR |^DECAL |^FSRA |^FTD[/ ]|^DPS |^EDXP |^EDXPIRED',poffense,0) <>  '' => 'Y',

             REGEXFIND('EXPRI[R]*ED|EXPR[/ ]'                                ,poffense,0) <> '' and
						 REGEXFIND('^DISP[/ ]| DISP[/ ]|DISPLAY| DRVG | DSPLY '          ,poffense,0) <> '' => 'Y',

             REGEXFIND('^EDXP[\\. /]|^EXSP[\\. /]|^EXIRD[\\. /]|^EXPR[\\. /]|^EXSP[\\. /]|^EXPP[\\. /]|^EXPI[\\. /]|^EXPP[\\. /]|^EXPIARED[\\. /]|^EXPPRD[\\. /]|^EXPIARED[\\. /]|^EXPRI[R]*ED[\\. /]|^EXIR[\\. /]|^EXIRP[\\. /]EXIP[\\. /]|^EXIPED[\\. /]|^EXIPIR|^EXIPR|^EXPR[E]*D'                                  ,poffense,0) <> '' and
						 REGEXFIND('DECAL|STICK| INSP | STATE |REG[\\.ISTRATION]+ |RGSTR|REGIST|DECAL| STK |INSPCTN|INSEPCTIO|INPSPECTIO|INPSEC|INSPCTIO|ISPECTIO|INSP[\\.E]| O[\\. ]+L[\\. ]+ |^OL | OL |IMSPECT|INSPEXTION|RGEISTR|REGSTR| STKR |ISPECTION| MVI |MVIS |O[\\. /]+L |TAG|LICEN|METER'              ,poffense,0) <>  '' => 'Y',

             REGEXFIND('[\\. /]EDXP[\\. /]|[\\. /]EXSP[\\. /]| EXIRD[\\. /]|[ /]EXPR[\\. /]| EXSP[\\. /]| EXPP[\\. /]| EXPI[\\. /]| EXPP[\\. /]| EXPIARED[\\. /]| EXPPRD[\\. /]| EXPIARED[\\. /]| EXPRI[R]*ED[\\. /]| EXIR[\\. /]| EXIRP[\\. /]| EXIP[\\. /]| EXIPED[\\. /]| EXIPIR| EXIPR| EXPR[E]*D'                                  ,poffense,0) <> '' and
						 REGEXFIND('DECAL|STICK| INSP | STATE |RGSTR|REG[\\.ISTRATION]+ |REGIST|DECAL| STK |INSEPCTIO|INPSPECTIO|INPSEC|INSPCTIO|ISPECTIO|INSP[\\.E]| O[\\. ]+L[\\. ]+ |^OL | OL |IMSPECT|INSPEXTION|RGEISTR|REGSTR| STKR |ISPECTION| MVI |MVIS |O[\\. /]+L |TAG|LIC[EN ]+|METER'    ,poffense,0) <>  '' => 'Y',

             REGEXFIND('^PK| PK '                                              ,poffense,0) <> '' and
						 REGEXFIND('VIO| VHCL| CURB|METER| MTR| RDWY| HWY| ANGLE| GRASS '  ,poffense,0) <>  '' => 'Y',

             REGEXFIND('(^PKT|^PKG|^PKING|^PKNG)[ ](TKT|TCKT|VIOL|VIO|[0-9]+)[ ]*' ,poffense,0) <>  '' => 'Y',

             REGEXFIND('ENTER|CENTER'                                       ,poffense,0) <> '' and
						 REGEXFIND(' DRWY | RDWY | H[G]*WY | DRVWAY | H[I]*GHWY | FWY ' ,poffense,0) <>  '' => 'Y',

             REGEXFIND('^DOT|[/ ]DOT|[/ ]DOT#'                                      ,poffense,0) <> '' and
						 REGEXFIND(' NUMBER | NAME |#|DISPLAY|VIO| DISP |MARK|INCOR|IMPROP| ID ',poffense,0) <>  '' => 'Y',

             REGEXFIND('EXPRESS'                                 ,poffense,0) <> '' and
						 REGEXFIND('LANE'                                    ,poffense,0) <>  '' => 'Y',

             REGEXFIND('OVERTIME'                                ,poffense,0) <> '' and
						 REGEXFIND(' PK | PKG |METER|DOCK|MOORING'           ,poffense,0) <>  '' => 'Y',
						 
             REGEXFIND('DAMAGE'                                  ,poffense,0) <> '' and
						 REGEXFIND('MV|VEH|AUTO|ACC|WINDSHIELD'              ,poffense,0) <> '' and
						 REGEXFIND('CRIM|WILLFUL|MALIC|REPAIR|TAMPER'        ,poffense,0) =  ''=> 'Y',

             REGEXFIND('^FTK '                                   ,poffense,0) <> '' and
						 REGEXFIND('RIGHT'                                   ,poffense,0) <>  '' => 'Y',

             REGEXFIND('^FTN'                                    ,poffense,0) <> '' and
						 REGEXFIND('DMV '                                    ,poffense,0) <> '' and
						 REGEXFIND('ADD'                                     ,poffense,0) <>  '' => 'Y',

						 REGEXFIND('F[AO][L]+OW'                             ,poffense,0) <> '' and
						 REGEXFIND('CLOS|CLS'                                ,poffense,0) <>  '' => 'Y',
						 
             REGEXFIND('PK |PK[\\./-]'                           ,poffense,0) <> '' and
						 REGEXFIND('TIC |TIC.|TKT|TKT'                       ,poffense,0) <> '' and
						 REGEXFIND('[PROTEST ]*#[ ]*[0-9]+|[PROTEST ]*[0-9]+',poffense,0) <>  '' => 'Y',
						 
             REGEXFIND('PK |PK[\\./-]'                           ,poffense,0) <> '' and
						 REGEXFIND('[PROTEST ]*#[ ]*[0-9]+|[PROTEST ]*[0-9]+',poffense,0) <>  '' => 'Y',

             REGEXFIND('PK |PK[\\.]|PK[/-]'                      ,poffense,0) <> '' and
             REGEXFIND('DECAL[/ ]|DECL '                         ,poffense,0) <> '' and						 
						 REGEXFIND('TIC |#[ ]*[0-9]+|[0-9]+'                 ,poffense,0) <>  '' => 'Y', 

             REGEXFIND('EXHAUST|EXHST'                           ,poffense,0) <> '' and
             REGEXFIND('BATH|VENT'                               ,poffense,0) <> '' => 'Y',

						 REGEXFIND('CHILD'                                   ,poffense,0) <> '' and
						 REGEXFIND('UNSECU|RESTRAINT|UNRESTR'                ,poffense,0) <>  '' => 'Y',	

             REGEXFIND('LEAV'                                    ,poffense,0) <> '' and
						 REGEXFIND('CH[I]*LD'                                ,poffense,0) <> '' and
						 REGEXFIND('CAR|MV|VEH'                              ,poffense,0) <>  '' => 'Y',	
						 
             REGEXFIND('FA[/]'                                   ,poffense,0) <> '' and						 
						 ( 
							 (REGEXFIND('CAR',poffense,0)   <>'' and REGEXFIND('REG',poffense,0) <> '') or
							 (REGEXFIND('DISPL',poffense,0) <>'' and REGEXFIND('HDLGHT|HEADLI|OL|DL|VEH',poffense,0) <> '') or
							 (REGEXFIND('WEAR',poffense,0)  <>'' and REGEXFIND('CORREC',poffense,0) <> '') or
							 (REGEXFIND('HWY|TR',poffense,0)<>'' and REGEXFIND('SIG',poffense,0) <> '')
						 ) => 'Y',

						 REGEXFIND('FAIL|FA[/]'                               ,poffense,0) <> '' and						 
						 ( (REGEXFIND('SHOW|OBTAIN' ,poffense,0) <>'' and REGEXFIND(' DL| ID | CDL '  ,poffense,0) <> '') or
						   (REGEXFIND('MAINT'       ,poffense,0) <>'' and REGEXFIND('CONT'      ,poffense,0) <> '') or
							 (REGEXFIND('DISP|WEAR'   ,poffense,0) <>'' and REGEXFIND('TAG|SEAT'  ,poffense,0) <> '') or
							 (REGEXFIND('RES|SECURE'  ,poffense,0) <>'' and REGEXFIND('CHILD'     ,poffense,0) <> '') or
							 (REGEXFIND('COVER|SECURE',poffense,0) <>'' and REGEXFIND('LOAD'      ,poffense,0) <> '') or
							 (REGEXFIND('TO'          ,poffense,0) <>'' and REGEXFIND('DIM'       ,poffense,0) <> '') or
							 (REGEXFIND('REPORT'      ,poffense,0) <>'' and REGEXFIND('ACC'       ,poffense,0) <> '') 
						 ) => 'Y',
						 
						 REGEXFIND('EX'                                       ,poffense,0) <> '' and						 
						 ( 
							 (REGEXFIND('OPR',poffense,0) <>'' and REGEXFIND('LIC|REG',poffense,0) <> '') or
							 (REGEXFIND('INSPECT',poffense,0)<>'' and REGEXFIND('ST',poffense,0) <> '')
						 ) => 'Y',
						 
						 REGEXFIND('EXIT'                                    ,poffense,0) <> '' and						 
						 REGEXFIND('HWY|FWY|PAY|FARE|HW |RWY|RDWAY',poffense,0) <>'' and REGEXFIND('LIC|REG',poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('LIC'                                     ,poffense,0) <> '' and
						 REGEXFIND('PLATE'                                   ,poffense,0) <> '' and
             REGEXFIND('IMPRO|L[I]*GHT'                          ,poffense,0) <> '' => 'Y',
						 
             REGEXFIND('EXOP'                                    ,poffense,0) <> '' and
             REGEXFIND('SP|INSP|LIC|REG'                         ,poffense,0) <> '' => 'Y',
					 
             REGEXFIND('ESPIRED|EX[P]*IRED'                        ,poffense,0) <> '' and
             ( REGEXFIND('INSP|INSEC|INS[EP]+C|REG|TAG|PLATE|DECAL|LIC|STICK|MOTOR|D[/]L|CDL| OL |O\\.L\\.|REJEC'   ,poffense,0) <> '' or
						  (REGEXFIND('REJ',poffense,0)<>'' and REGEXFIND('STKR',poffense,0) <> '')						 )=> 'Y',						 
						 
						 REGEXFIND(' PASSING '                               ,poffense,0) <> ''  => 'Y',					 
						                            
						 REGEXFIND('DRIV|DROV'                               ,poffense,0) <> '' => 'Y',	
             
						 REGEXFIND('CONTESTED |^CONT |CONT PK'               ,poffense,0) <> '' and
             REGEXFIND('TICKET|TICK |TIC[# ]|TKT '               ,poffense,0) <> '' => 'Y',						 
						 
						 REGEXFIND('OP '                                     ,poffense,0) <> '' and
             REGEXFIND('NOT REASON'                              ,poffense,0) <> '' => 'Y',
                                        
             REGEXFIND('OP '                                     ,poffense,0) <> '' and
						 REGEXFIND('DEVICE'                                  ,poffense,0) <> '' and
             REGEXFIND('WIRELESS'                                ,poffense,0) <> '' => 'Y',

             REGEXFIND('PERM[I]*T|LICENSE|LIC|REG'               ,poffense,0) <> '' and
						 REGEXFIND('VIO|RVKD|LIMIT|REQ|RE |ONLY|W[/][ ]*[OUT]*|WITHOUT|WITH'   ,poffense,0) <> '' and
             REGEXFIND('DRIV|DROV| DR |OP |VEH|MV |WATERCRATFT|BOAT|VESSEL|JET|INSTRUC|INST|INSTR|INSTRN|INS|LEARN|CHAUF|COMMER' ,poffense,0) <> '' => 'Y',             
						 
             REGEXFIND('PERM[I]*T|LICENSE|LIC'                   ,poffense,0) <> '' and
             REGEXFIND('CHAUF|INSTR|BEGI|DRIV|DROV|LEARN|LERN|LRNRS|DR |COMM|COMMERCIAL|HAUL' ,poffense,0) <> '' => 'Y',

             REGEXFIND('PERM[I]*T|LICENSE|LIC|REG'               ,poffense,0) <> '' and
						 REGEXFIND('DRIV|DROV|DR |OP |TRANS'                 ,poffense,0) <> '' and
             REGEXFIND('NO |RVKD|W/[ OUT]*|WITHOUT|UNPAID'       ,poffense,0) <> '' => 'Y',
             
             REGEXFIND('PERM[I]*T|ALLOW'                         ,poffense,0) <> '' and
             REGEXFIND('MINOR|CHILD|PERSON|ANOTHER'              ,poffense,0) <> '' and
             REGEXFIND('WITHOUT|W/O|W/[ ]*OUT'                   ,poffense,0) <> '' and
             REGEXFIND('LIFE'                                    ,poffense,0) <> ''=> 'Y',
             
             REGEXFIND('PERM[I]*T|LICENSE|LIC|REG'               ,poffense,0) <> '' and
						 REGEXFIND('DRIV|DROV|DR |OP'                        ,poffense,0) <> '' and
             REGEXFIND('MINOR|PERSON|PRS|PRSN|CHILD|ANOTHER|UNDER|UNAUTH|U/AUTH|UNATHZ|UNQUAL' ,poffense,0) <> '' => 'Y',
             
             REGEXFIND('PERM[I]*T'                               ,poffense,0) <> '' and
						 REGEXFIND('DRIV|DROV|DR |OP'                        ,poffense,0) <> '' and
						 REGEXFIND('CLASS'                                   ,poffense,0) <> '' and
             REGEXFIND('VEH|M[/]V|MV '                           ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('PERM[I]*T|ALLOW'                         ,poffense,0) <> '' and
						 REGEXFIND('DRIV|DROV|DR |OP '                       ,poffense,0) <> '' and
						 REGEXFIND('WITHOUT|W/[ ]*O[UT]*|NO |UNPAID'         ,poffense,0) <> '' and
             REGEXFIND('VEH|M[/]V|MV |WATERCRATFT|BOAT|VESSEL'   ,poffense,0) <> '' => 'Y',
						 
             REGEXFIND('PERM[I]*T|LICENSE|LIC|REG'               ,poffense,0) <> '' and
						 REGEXFIND('VEH|MV|DRIV|OP'                          ,poffense,0) <> '' and
             REGEXFIND('FICT|FAKE|F[A]*LSE|FAL'                  ,poffense,0) <> '' => 'Y',
             
             REGEXFIND('PERM[I]*T|DEC'                              ,poffense,0) <> '' and
             REGEXFIND('REQ|RE |RVKD|W/[ OUT]*|WITHOUT|WITH'        ,poffense,0) <> '' => 'Y',
						 						                                         
             REGEXFIND('PERM[I]*T'                                  ,poffense,0) <> '' and
             REGEXFIND('DEC'                                        ,poffense,0) <> '' and
             REGEXFIND('PLATE'                                      ,poffense,0) <> '' => 'Y',
                                                              
             REGEXFIND('PERM[I]*T'                                  ,poffense,0) <> '' and
						 REGEXFIND('EXCESS'                                     ,poffense,0) <> '' and
             REGEXFIND('REQ'                                        ,poffense,0) <> '' and
						 REGEXFIND('SIGN'                                       ,poffense,0)  = '' => 'Y',
                                                              
             REGEXFIND('PERM[I]*T'                                  ,poffense,0) <> '' and
						 REGEXFIND('VEH|M[/]V| MV '                             ,poffense,0) <> '' and
						 REGEXFIND('NOT'                                        ,poffense,0) <> '' and
             REGEXFIND('VISI'                                       ,poffense,0) <> '' => 'Y',

             REGEXFIND('PERM[I]*T'                                  ,poffense,0) <> '' and
						 REGEXFIND('VEH|M[/]V| MV '                             ,poffense,0) <> '' and
             REGEXFIND('HIRE'                                       ,poffense,0) <> '' => 'Y',
	                                                   
             REGEXFIND('FR[ON]+[T]*'                                ,poffense,0) <> '' and
             REGEXFIND('LIC|PLATE|REG|TAG'                          ,poffense,0) <> '' => 'Y',
						                                                   
						 REGEXFIND('TAK|USE|OP|REMOVE'                          ,poffense,0) <> '' and 
             REGEXFIND('VEH|AUTO|M[/]*V|BOAT|ATV'                   ,poffense,0) <> '' and 
             REGEXFIND('PERMIS'                                     ,poffense,0) = ''  and 
             REGEXFIND('WITHOUT|W[/-]*O|NO'                         ,poffense,0) <> '' => 'Y',
						 						 
						 REGEXFIND('SCHOOL'                                     ,poffense,0) <> '' and
						 REGEXFIND('BUS|ZONE|ZN'                                ,poffense,0) <> '' and
             REGEXFIND('STOP|STP|PASS|OVERT|DISRE|F\\.T\\.S|FAIL|OBEY| FT |DISK'  ,poffense,0) <>'' => 'Y',
						 
						 REGEXFIND('STOP|STP'                                   ,poffense,0) <> '' and
             REGEXFIND('PAY|PMT|PYMT|FOOD|ARREST|ARST|ARRST|CHECK|CHRISTOPHER|CHRISTOPOLOU|URINATE|ORD|CONT|DEATH|DETH|FRISK|ARRES'  ,poffense,0) = '' => 'Y',
 
             REGEXFIND('STOP SIGN'  ,poffense,0) <> '' => 'Y',

             REGEXFIND('TRAFF|TRAFFIC'                              ,poffense,0) <> '' and
             REGEXFIND('TRAFFICING|TRAFFICNG|TRAFFICO|TRAFFICS|TRAFFING|TRAFFINKING|TRAFFIS|TRAFFKG|TRAFFKICKING|TRAFFKING|TRAFFKNG|TRAFFRKG' ,poffense,0) ='' and 
						 REGEXFIND('COC|CIG|PHENE|OPIUM|FOOD|DOOD|FOD|COKE|CRANK|CRACK|BEER|LIQUOR|ALCOHOL|MAR,|MARI|MARIH|MJ|MDA|MDM|CHILD|PERSON|ROHYP|F.S.|UDOCS|HYDROC|OXYC|PSEDOE|ECSTA|CDS|METH|SEX|WILDLIFE|META|CANN|WILD|PROST|FORCE|SLAV|SEX|PERSON|HUMAN.' ,poffense,0) = '' and 
						 Is_Drug_Narcotic(poffense)                            =  'N' => 'Y', 
						 
             REGEXFIND('INSUR|INSURANCE|INS|LIAB|INSP|INSPEC|STICK' ,poffense,0) <> '' and
						 REGEXFIND('NO|WITHOUT|W[/]O|PROOF|PRF'                 ,poffense,0) <> '' and
             REGEXFIND('FINL|FINC'                                  ,poffense,0) = ''  => 'Y',
						 					 
						 REGEXFIND('DUTY|APPRO|F/[TO]*|F\\.TO|FT|F\\.T\\.| FL |DISRE|F[/-]T|FAI[L]| FA |FIAL|FLURE|R[-]*O[-]*W|ROW|SIGN|DIS|F[-]T-[OS]|OBEY|RIGHT|FALI |FAL | FIL | FLD |WAY|TURN| RT'    ,poffense,0) <> '' and
						 REGEXFIND('YEILD'                                      ,poffense,0) <> '' => 'Y',
	
	           REGEXFIND('UNAU|UNAT |UNSAF'                           ,poffense,0) <> '' and
						 REGEXFIND('VEH|MV|BOAT'                                ,poffense,0) <> '' and
             REGEXFIND('CHILD|MINOR'                                ,poffense,0) = ''  => 'Y',
												 
						 REGEXFIND('DROV|DRIV|OP'                               ,poffense,0) <> '' and
						 REGEXFIND('VEH|MV|BOAT'                                ,poffense,0) <> '' and
             REGEXFIND('INS'                                        ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('VEH|MV|BOAT'                                ,poffense,0) <> '' and
             REGEXFIND('UNREG|COMME[R]+[CI]+AL|COMMERR'             ,poffense,0) <> '' => 'Y',
						 
             REGEXFIND('F[OA]LLOW'                                  ,poffense,0) <> '' and
						 REGEXFIND('CLOSE'                                      ,poffense,0) <> '' and
             REGEXFIND('TOO|TO'                                     ,poffense,0) <> '' => 'Y',
						 
             REGEXFIND('VEH|MV'                                     ,poffense,0) <> '' and
						 REGEXFIND('WRONG|INV'                                  ,poffense,0) <> '' and
             REGEXFIND('INSP|LIC|PLAT|PLT|REG'                      ,poffense,0) <> '' => 'Y',
						 
             REGEXFIND('WRONG'                                      ,poffense,0) <> '' and
						 REGEXFIND('DR|OP|DRIV'                                 ,poffense,0) <> '' and
             REGEXFIND('SIDE|WAY|PLACE|PLC|DIR|LIC|REG|INSP|LIC|PLAT|PLT',poffense,0) <> ''  => 'Y',
						 
						 REGEXFIND('PASS|TURN'                               ,poffense,0) <> '' and
             REGEXFIND('UNLAW|RECKL'                             ,poffense,0) <> '' and
						 REGEXFIND('PASSW|RETURN|TRESPASS'                   ,poffense,0) = '' => 'Y',

						 REGEXFIND('LANE'                                    ,poffense,0) <> '' and
             REGEXFIND('UNSAF|USAF|SWIT|PROHIB|DIR|MAINTAIN|LEFT',poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('IMPRO|IMP'                               ,poffense,0) <> '' and
             REGEXFIND('BACKING|TURN|PASS|REG'                   ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('DRIV|OP'                                 ,poffense,0) <> '' and
             REGEXFIND('COND'                                    ,poffense,0) <> '' and
						 REGEXFIND('DISORD|CONDUCT|CONDE'                    ,poffense,0)  = '' => 'Y',
			  
						 REGEXFIND('RECKL|RCK'                               ,poffense,0) <> '' and
						 REGEXFIND('DR|OP|DRIV'                              ,poffense,0) <> '' and
             REGEXFIND('BOAT|CRAFT|VEH|MV|M/B|PWC|W/C|W/KRFT'    ,poffense,0) <> '' => 'Y',
						 
             REGEXFIND('RECKL| RCK |RECK '                       ,poffense,0) <> '' and
             REGEXFIND('DR'                                      ,poffense,0) <> '' => 'Y',
							  
             REGEXFIND('LANE'                                    ,poffense,0) <> '' and
						 REGEXFIND('IMP'                                     ,poffense,0) <> '' and
             REGEXFIND('CHAG|CHAN'                               ,poffense,0) <> '' => 'Y',
					 
						 REGEXFIND('SP[PE]+D|^SPD[G]*|SPEE[;CEID]+NG|[0-9]{2}[- /][0-9]{2}[ -/]SP|[*]SPD|SP[ ]*[0-9]{2}|^SP[;. /]+[0-9]+[-/]|CTR/[ ]*SPD [S/Z]+ [0-9]+/[0-9]+',poffense,0) <> ''     => 'Y',						 
						 
						 REGEXFIND('LEFT|RIGHT'                              ,poffense,0) <> '' and
             REGEXFIND('TURN|TRN|TUR|RED|MIRR|MAK|MISS|NO|ON|SIDE|CENT|DOUB|DBL|DLB|OVER|SIDE|PASS|PED|PROHIB|DRIV|REAR|RIDE|LANE|LAN|TRAIL|TRLR|TRL|UNSAF',poffense,0) <> ''     => 'Y',

						 REGEXFIND('UNLICENSE|W[ITH/]+OUT(.*) LIC'           ,poffense,0) <> '' and
             REGEXFIND('MOTOR V|BOAT|MOPED|DR[\\.IVG ]+|VEH|TAXI|M[\\./ ]V|MV[\\. ]|MOTO[R ]*CYC|CAB|FARE|PA[SE]+NG'                                ,poffense,0) <> '' => 'Y',

						 REGEXFIND('HOOD'                                    ,poffense,0) <> '' and
             REGEXFIND('SCO[O]+P'                                ,poffense,0) <> '' => 'Y',

             REGEXFIND('LIFE'                                    ,poffense,0) <> '' and
             REGEXFIND('P[ER]+SERV'                              ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('OVER'                                    ,poffense,0) <> '' and
             REGEXFIND('HOUR|HR'                                 ,poffense,0) <> '' and 
						 REGEXFIND('BODY'                                    ,poffense,0) = ''  and 
             REGEXFIND('WASTE'                                   ,poffense,0) = ''  => 'Y',

             REGEXFIND('PLATE'                                   ,poffense,0) <> '' and
						 ( REGEXFIND('VIO',poffense,0) <> '' OR 
							 (REGEXFIND('PREV',poffense,0) <>'' and REGEXFIND('OWN',poffense,0) <> '')
						 ) => 'Y',

             REGEXFIND('VEH|M[/]*V|FUEL'                         ,poffense,0) <> '' and
						 REGEXFIND('POINT'                                   ,poffense,0) <> '' and
             REGEXFIND('SYSTEM'                                  ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('VEH|M[/]*V'                              ,poffense,0) <> '' and
						 REGEXFIND('MAIN'                                    ,poffense,0) <> '' => 'Y',
						 
             REGEXFIND('SAFE|SFTY|SEAT'                          ,poffense,0) <> '' and
             REGEXFIND('B[E]*LT'                                 ,poffense,0) <> '' => 'Y',

             REGEXFIND('TRUCK'                                   ,poffense,0) <> '' and
             REGEXFIND('COMMER|COMMON'                           ,poffense,0) <> '' => 'Y',
						 
             REGEXFIND('FULL'                                    ,poffense,0) <> '' and
						 REGEXFIND('TIME'                                    ,poffense,0) <> '' and
             REGEXFIND('ATT'                                     ,poffense,0) <> '' => 'Y',
						 
 						 REGEXFIND('TRANSPAR'                                ,poffense,0) <> '' and
						 REGEXFIND('WIND|MAT'                                ,poffense,0) <>  '' => 'Y',

             REGEXFIND('PRMT |PERM'                              ,poffense,0) <> '' and
						 REGEXFIND('VIO'                                     ,poffense,0) <> '' and
						 ( REGEXFIND('SPD|LIC',poffense,0) <> '' OR 
							 (REGEXFIND('DR',poffense,0) <>'' and REGEXFIND('CERT',poffense,0) <> '') or
							 (REGEXFIND('AX',poffense,0) <>'' and REGEXFIND('MIN',poffense,0) <> '') or
							 (REGEXFIND('NO',poffense,0) <>'' and REGEXFIND('DIMEN|TRAV',poffense,0) <> '') 
						 ) => 'Y',

             REGEXFIND('P[A]*RK'                                 ,poffense,0) <> '' and
						 REGEXFIND('MINOR'                                   ,poffense,0) = '' and
						 REGEXFIND('TICKET|TK[TE]|T[RC]K|TK|TI[CKT]| TT |FINE|ZONE|PERM|PRMT|VIO|DECAL|CURB|VEH|MV|TRACT|CAR|BOAT|TRLR|S[I]*DEW[A]*LK|CR[O]*SSW[A]*LK|OVERTIME|'+
                       'FRONT|WRONG|WHERE|WRNG| RICKET|DEC|PERM|STICK|PLATES|RDWY|YARD|PRHBD|YLLW|PRHBTD|PROP|SPCE|PHYSIC|EXCEPT|TRVL| SUM/| SUMMON|'+
                       'HYD|SNOW|TRAFF|HGWY|HWY|SPACE|SPCE|LANE|NO |OBST|BEYOND|BLOCK|BOAT|DESIG|DISAB|TRUCK|TRK|SNOW|EXEMPT|H\\.C\\.|H[/]C|IMPR|SCHOOL'
                       ,poffense,0) <>  '' => 'Y',
				 						 
	
             REGEXFIND('P[A]*RK'                                 ,poffense,0) <> '' and
						 ( (REGEXFIND('LOAD'          ,poffense,0) <>'' and REGEXFIND('ZO|ZN',poffense,0) <> '') or
						   (REGEXFIND('PROH'          ,poffense,0) <>'' and REGEXFIND('ZO|ZN',poffense,0) <> '') or						 
							 (REGEXFIND('UNATT'         ,poffense,0) <>'' and REGEXFIND('TRA|TRL|TR',poffense,0) <> '') or
							 (REGEXFIND('REST'          ,poffense,0) <>'' and REGEXFIND('ZN|ZO',poffense,0) <> '') or
							 (REGEXFIND('OVER|EXCESS'   ,poffense,0) <>'' and REGEXFIND('TIME',poffense,0) <> '') or
							 (REGEXFIND('REST|UDNS'     ,poffense,0) <>'' and REGEXFIND('ARE',poffense,0) <> '') or
							   
							 (REGEXFIND('AFTER'         ,poffense,0) <>'' and REGEXFIND('REMAIN|ENTER|TRESP|TEPASS|BEING|INSIDE| IN |OCCUPY|CURFEW|LOITER|WEAPON',poffense,0) = '') or
							 (REGEXFIND('CAR'           ,poffense,0) <>'' and REGEXFIND('CARRY|CARWASH|DAYCARE|DAYCARE',poffense,0) = '') or
							 (REGEXFIND('PROP'          ,poffense,0) <>'' and REGEXFIND('TRESP|DAMAGE|DESTR|REMOV',poffense,0) = '') or
                                  
               (REGEXFIND('CIT'           ,poffense,0) <>'' and REGEXFIND('ALC|FIRE|WEAP|BEER|WINE|DRUNK|DRUG|DRINK|CONSUM|TRESP|DOG|HELMENT|BURG|ABC|LITTER|LEASH|SLEEP|CAMP|THEFT|GLASS|'+
																	                                        'NOISE|LOITER|SOLICT|COC|DEPOSIT|ENTER|DAMAGE|DESTR|REMOV',poffense,0) = '') or
							 (REGEXFIND('EQUIP'         ,poffense,0) <>'' and REGEXFIND('DAMAGE|DESTR|REMOV|SKATE|SEX',poffense,0) = '') or
							 (REGEXFIND('RESTRICT'      ,poffense,0) <>'' and REGEXFIND('DOG|ANIMAL|CURFEW',poffense,0) = '') or
                          
							 (REGEXFIND('FAC'           ,poffense,0) <>'' and REGEXFIND('DRUG|MANUFAC|CARE|COC|DEFAC|ARTIFAC|METER|POSS|TRESP|ALC|DRUNK|SELL',poffense,0) = '') or
							 (REGEXFIND('FEE'           ,poffense,0) <>'' and REGEXFIND('POSS|CDS|DRUG|SELL|SEX|DELIVE|SALE|CDS|DISTRIB',poffense,0) = '') or
							 (REGEXFIND('HAND|HNDCP'    ,poffense,0) <>'' and REGEXFIND('WEAP|GUN|PAN|DEAL|F MERCHANDIS F MERCHAND|RECKLESS|FIREARM',poffense,0) = '') or
							 
							 (REGEXFIND('LOAD'          ,poffense,0) <>'' and REGEXFIND('POSS',poffense,0) = '') or
							 (REGEXFIND('CUT'           ,poffense,0) <>'' and REGEXFIND('TREE|WOOD|DESTR',poffense,0) = '') or
							 (REGEXFIND('HR'            ,poffense,0) <>'' and REGEXFIND('TRESP|ALCO|REMAIN|SLEEP|COC|THROW',poffense,0) = '') 
						 ) => 'Y',

             REGEXFIND('VIO'                                     ,poffense,0) <> '' and
						 ( (REGEXFIND('MV|VEH|TRAF|DR |LANE|HOV',poffense,0) <>'' and REGEXFIND('LAW|REST|TIRE'     ,poffense,0) <> '') or
						   (REGEXFIND('CHILD|LEARN|LRN'         ,poffense,0) <>'' and REGEXFIND('REST'              ,poffense,0) <> '') or						 
							 (REGEXFIND('VEH|MV|BOAT|DR|VETS'     ,poffense,0) <>'' and REGEXFIND('LIC|REG|TAG|PLAT'  ,poffense,0) <> '') or
							 (REGEXFIND('LEARN|LRN|MARINE'        ,poffense,0) <>'' and REGEXFIND('LIC|PERM|PMT'      ,poffense,0) <> '') or
							 (REGEXFIND('LIC| DL |D[/]*L |D[\\.]L[\\.]| OL |O/L|O[\\.]L[\\.]|BOAT|VESSEL|MOOR',poffense,0) <>'' and REGEXFIND('PLAT|TAG|REG|REST|SUSP|WEIGHT',poffense,0) <> '') or
							 (REGEXFIND('VEH|M[/]*V'              ,poffense,0) <>'' and REGEXFIND('I[H]*NSP'          ,poffense,0) <> '') or
							 (REGEXFIND('LIC|D/L'                 ,poffense,0) <>'' and REGEXFIND('DR |FARM|DWLR|DWLS',poffense,0) <> '') 
						 ) => 'Y',

             REGEXFIND('UNATT'                                   ,poffense,0) <> '' and
						 REGEXFIND('VEH|MV|AUTO'                             ,poffense,0) <>  '' => 'Y',
						
						 REGEXFIND('VIO'                                     ,poffense,0) <> '' and
						 REGEXFIND('M[/]C|M CARR|MOT(.*) CAR|MTR(.*) CARR|TOW|BOOT|MOTOR[ ]*CYC' ,poffense,0) <>  '' and 
						 REGEXFIND('TOWN'                                    ,poffense,0) = '' => 'Y',
						 
             REGEXFIND('WRONGFUL'                                ,poffense,0) <> '' and
						 REGEXFIND('ENTRUS|ENTRST'                           ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('LIGHT|LGT'                               ,poffense,0) <> ''  and
						 REGEXFIND('FLIGHT|HUNT|THR[OE]W|ARTIFICIAL|HOUS|SKYLIGHT|PROPERTY MAIN|LIGHTED|SPOT[ ]*LIGHT|ORDINANCE|OUTDOOR|FIRE|SALE|KILL|DEER|WILDLIFE'  ,poffense,0) = ''  => 'Y',

						 REGEXFIND('OPER(.*) PERM'                           ,poffense,0) <> ''  and 
						 REGEXFIND('TAXI|VEH|M[/]V| [C]*MV |MOPED|ATV|MOTOR[ ]*CYCLE|MOTOR CARRIER|BOAT|M[O)*T[O]*R V'   ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('MOTOR'                                   ,poffense,0) <> ''  and 
						 REGEXFIND('CYCL'                                    ,poffense,0) <> '' => 'Y',						 

						 REGEXFIND('DANGL'                                   ,poffense,0) <> ''  and 
						 REGEXFIND('OBJ'                                     ,poffense,0) <> '' => 'Y',						 

						 REGEXFIND('VIO|NO |FAL|MIN'                         ,poffense,0) <> '' and
						 REGEXFIND('WAKE|MOOR'                               ,poffense,0) <> '' and
						 REGEXFIND('ZON'                                     ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('M[/]*V|VEH'                              ,poffense,0) <> '' and
						 REGEXFIND('REG'                                     ,poffense,0) <> '' and
						 REGEXFIND('FAIL|FALSE|LIC|LC|PL|MC|MOT|NOT|NO |REQ|VIO|SUS|NEVER|LAW' ,poffense,0) <>  '' => 'Y',

						 REGEXFIND('UNLAW'                                   ,poffense,0) <> '' and
						 REGEXFIND('TAG|STICK|DECAL|PLATE|TIRE'              ,poffense,0) <> '' and
						 ~(REGEXFIND('ID' ,poffense,0) <> '' and REGEXFIND('CARD|DEER|GAM' ,poffense,0) <> '') => 'Y',
						 
             REGEXFIND('[0-9]+\\-[0-9]+ |[0-9]+[/][0-9]+'        ,poffense,0) <> '' and
						 REGEXFIND('ZONE'                                    ,poffense,0) <> '' => 'Y',

             REGEXFIND('MPH'                                     ,poffense,0) <> '' and
						 REGEXFIND('ZONE'                                    ,poffense,0) <> '' => 'Y',

             REGEXFIND('NO '                                     ,poffense,0) <> '' and
						 REGEXFIND('PASS|TRUCK|SCHOOL'                       ,poffense,0) <> '' and
						 REGEXFIND('ZON'                                     ,poffense,0) <> '' => 'Y',

             REGEXFIND('VEH'                                     ,poffense,0) <> '' and
						 REGEXFIND('REST'                                    ,poffense,0) <> '' and
						 REGEXFIND('ZON'                                     ,poffense,0) <> '' => 'Y',

             REGEXFIND('HEADLIGHT'                               ,poffense,0) <> '' and
						 REGEXFIND('BEAMS REQUIRE'                           ,poffense,0) <> '' => 'Y',
						 
						 //QA Update - Traffic Round 6
             REGEXFIND('^F[\\.]?T[\\.]?Y[\\.]?[R /-]|INSURANCE CARD|[LIABILITY|AUTOMOBILE|VEHICLE] INSURANCE|' +
						           'INSURANCE VERIFICATION|LEAV[E]?[ |/]SC[NE]*[\\.]?[ |/]*[OF ]*ACC|VEHICLES FOLLOWING|FOLLOWING TOO C|' +
											 'TAIL LAMP[S]*|TAIL LITE[S]*|HEAD LAMP[S]* REQUIRE|OPERATE W/O REASONABLE CONTROL|' +
											 '^[ ]*DISPLAY OF PLATES[\\.]*[ ]*$|MILES PER HOUR LIMIT|SQUEAL[ING]* TIRE'
											                                           ,poffense,0) <> '' => 'Y',
						 //QA Update - Traffic Round 6
						 REGEXFIND('ALLOW[ING]*' 														 ,poffense,0) <> '' and
						 REGEXFIND('ILLEG|UNDER[ ]*AGE|UNLAWFUL'						 ,poffense,0) <> '' and
						 REGEXFIND('OPERATION'						 									 ,poffense,0) <> '' => 'Y',
						 
             REGEXFIND('TRAVEL[ING]*'                            ,poffense,0) <> '' and
						 REGEXFIND('TO FAST'                           			 ,poffense,0) <> '' and
						 REGEXFIND('FOR CONDITION'                           ,poffense,0) <> '' => 'Y',
						 
             REGEXFIND('HOV'                                     ,poffense,0) <> '' and 
						 REGEXFIND('SHOVE|SHOVI'                             ,poffense,0) =  '' => 'Y',
						 
						 REGEXFIND('^FL '                                    ,poffense,0) <> '' and //Roger comments - Traffic 20161114 File Round 8
						 REGEXFIND('CARRY'                                   ,poffense,0) <> '' and
						 REGEXFIND(' D[/]*L | [OD]\\.L\\.| O[/]*L '          ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('VOIL'                                    ,poffense,0) <> '' and 
						 REGEXFIND('RULE'                                    ,poffense,0) <> '' and
						 REGEXFIND('BASIC|FAST|TURNPIKE| DPS '               ,poffense,0) <> '' => 'Y',

             REGEXFIND('LEAV'                                    ,poffense,0) <> '' and      
             REGEXFIND('SCENE'                                   ,poffense,0) <> '' and 
						 REGEXFIND('PRIV PROP'                               ,poffense,0) = '' => 'Y',		

             REGEXFIND('MAXIMUM|LIMIT|EXCEED'                                ,poffense,0) <> '' and      
						 REGEXFIND('WEIGHT|AXLE|SIZE|EMISSION| MPH |LICENSE|LOAD|BACKING',poffense,0) <> '' => 'Y',

             REGEXFIND('INSUFF'                                  ,poffense,0) <> '' and 
						 REGEXFIND('TREAD'                                   ,poffense,0) <> '' and     
						 REGEXFIND('TIRE'                                    ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND('METER'                                   ,poffense,0) <> '' and     
						 REGEXFIND('VIOLATION|STREET'                        ,poffense,0) <> '' => 'Y',

             REGEXFIND(traffic_list                              ,poffense,0) <> '' and
             REGEXFIND(exclude_list_traffic                      ,poffense,0) = ''  => 'Y',          
						 
						 REGEXFIND(traffic_list2                             ,poffense,0) <> ''  and
             REGEXFIND(exclude_list_traffic                      ,poffense,0) = ''  => 'Y',	  
						 
						 REGEXFIND(traffic_list3                             ,poffense,0) <> ''  and
             REGEXFIND(exclude_list_traffic                      ,poffense,0) = ''  => 'Y',
						 
						 REGEXFIND(traffic_list4                             ,poffense,0) <> ''  and
             REGEXFIND(exclude_list_traffic                      ,poffense,0) = ''  => 'Y',
						 
						 REGEXFIND(traffic_list5                             ,poffense,0) <> ''  and
             REGEXFIND(exclude_list_traffic                      ,poffense,0) = ''  => 'Y',
						 
						 REGEXFIND(traffic_list6                             ,poffense,0) <> '' => 'Y',
						 
						 REGEXFIND(traffic_list7                             ,poffense,0) <> '' => 'Y',	
						 						 
						 REGEXFIND(LIC1                                      ,poffense,0) <> '' and
             REGEXFIND(exclude_list_traffic                      ,poffense,0) = ''  => 'Y',	 
						 
						 REGEXFIND('^[0-9][0-9][/][0-9][05][ ]*$'            ,poffense,0) <> '' => 'Y',
             REGEXFIND('^[0-9][0-9][/][0-9][05] RD[ ]*$'         ,poffense,0) <> '' => 'Y',
						 REGEXFIND('^[0-9][0-9][-][0-9][05][-]B[ ]*$'        ,poffense,0) <> '' => 'Y',
 						 REGEXFIND('^[0-9][0-9][-][0-9][05][ ]*$'            ,poffense,0) <> '' => 'Y',
 						 REGEXFIND('^[0-9][0-9] IN [0-9][05][ ]*$'           ,poffense,0) <> '' => 'Y',
						 REGEXFIND('^[0-9][0-9][/][0-9][05] DR[V]*[ ]*$'     ,poffense,0) <> '' => 'Y',
						 REGEXFIND('X[0-9][0-9][/][0-9][05][ ]*$'            ,poffense,0) <> '' => 'Y',
						 REGEXFIND('SP [-] [0-9][0-9][/][0-9][05][ ]*$'      ,poffense,0) <> '' => 'Y',
						 REGEXFIND('^[0-9]+[/][0-9][50] (2ND|MPH)[ ]'        ,poffense,0) <> '' => 'Y',
						 REGEXFIND('^[0-9]+[/][0-9][50] RECKLESS[ ]'         ,poffense,0) <> '' => 'Y',						 
						 REGEXFIND('^RD [0-9]+[/][0-9][50][ ]'               ,poffense,0) <> '' => 'Y',

						 REGEXFIND('LIGHTED'                                 ,poffense,0) <> '' and
             REGEXFIND('LIGHT|LAMPS'                             ,poffense,0) <> ''  => 'Y',	
						 
						 // REGEXFIND('LIGHTED'                                 ,poffense,0) <> '' and
             // REGEXFIND('LIGHT|LAMPS'                             ,poffense,0) <> ''  => 'Y',	
						 
						 REGEXFIND('EVAD|EVASI|ELUD[E]*|EVAS |VIOL[ATION ]+'  ,poffense,0) <> '' AND
						 REGEXFIND('TAX|TOLL|TAXES'                           ,poffense,0) = ''  => 'Y',
						
						 REGEXFIND('EVAD|EVASI|ELUD[E]*|EVAS |VIOL[ATION ]+'  ,poffense,0) <> '' AND
						 REGEXFIND('TR[A]*F[FIC ]+'                           ,poffense,0) <> '' AND
						 REGEXFIND('DEVICE'                                   ,poffense,0) = ''  => 'Y',

						 'N');
return Is_it;
end;
//--------------------------------------------------------------------------------------------------------------------------------------

export Is_Other(string poffense) := function

Other1 :='POOL|CONVEY|PERMIS|PARK|LITTER|ACCOMPLIC|COMPLIC|APPEAL|INTERFER|TRAFF|'+ 
         'ALTER|ADULTERA|^AM UN[ AU]+|AID(.*) OFFENDER|AID(.*) PRISONER|AID BY MISREP|'+
    		 'KNOWINGLY|ACCESSORY AFTER(.*) FACT|ACCESSORY BEFORE(.*) FACT|ARRAIGNMENT|ACT(.*)PROH|'+
         '^ALC[- ]|BAIL JUM[OPING]*|BIGAMY|ASSIST(.*) COMMIT|^ALS |^ALT |APPEAL(.*) J[ ]*P#|APPEAL(.*) J[ ]*P #|APPEAL(.*) CORP|'+	  		     
         'CIVIL ASSESSMENT|COERCION|CONS[UM]*P|CONSPIRACY|CAUSING(.*)FIRE|CAUSING(.*)POLLUT|CHALLENG[EING]*(.*)FIGHT|CERT[AIN]* ACT[S]* PRO|'+
         '^CF |^CM |CONSUMER|CUTTING|C[ ]*D[ ]*V|CONVERT|CONTEMPT|TAMPER|'+    
		     'COCK(.*)FIGHT|DISTRIBUTE|DISTURBING|DANGER|FACILITAT|DISARM|CONVERSION|CONSERVATION|ESCAPE|CONSPIR';	  
				 //remove UNAUTHORIZED|
Other2:= 'DISRUPT[ING ]+PUB|DISRUPT[ING ]+MEET|DRAG RACING|DISMISS|HINDER|ELUDE|ESCAPE|ELDERLY|EXTRADITION|ENHANCEMENT|EXPOS|ELDER|'+			  
	       'FIRE|FAIL(.*) TO APPEAR|FUGITIVE|FORFEIT|FIGHTING(.*)PUBLIC|FLEE|FAIL(.*) TO PAY|'+	       		
		     '^FURN|FEDERAL|^FUG|GRAND|RABIES|FISHING LIC|DOG VACCINATION|HEALTH|HABITUAL OFFENDER|^HARB|HAZARD|HARM|HARBORING A RUNAWAY|'+		      		
	       'ILL USE MIN|ILLEGAL|IMPORTUNING|INCIT[EI](.*)RIOT|LAW ENFORCEMENT|MORE THAN|^MOS|MISUSE|MAL.|MALICIOUS|CONTEMPT';				 

Other3:= 'MAKING FALSE|MISCOND|NEGLECT|NON(.*)SUPPORT|PERJU|RESIST|OFFICER|OBSTR[UCTIONG]*|^OBS |'+	 
	       'VIOLATION(.*)COMMUNITY SUP|PROB VIOLATION|PAROLE|PANIC|PROBATION|WORK(.*)PR[OG]+|'+
	       'PRIOR [-]*CONV|POLOGAMY|PATIENT|PER(.*) UNL|PETITION RE:|POLLUT|'+
	    	 '^PERS[IST. ]+|PRIOR|^PRACTIC[IE]|^PREP[ARATION]* OF |PERS(.*) DI|QUARANTINE|'+
	     	 'RECK(.*) OP|RESIST|RIOT|RECKLESS|RESISTING ARREST|TOXIC|THROW|TERMS OF PROB|VOY[EU]+RISM|VICIOUS|'+  
	       '^SPEC AL|SOLIC[I]*T|TAMPERING|TAX|HUNT|IRRIGATE|IRIRGATE|LAWN|HOME|HOOK|'+
	       'VIOLATION OF FED|VIT:|VIT-|SU[SP]*(.*) SENT|VIOLATION OF PROB| OBST|DEC(.*) OBT(.*) D[A]*N|'+
	       '^UCW|CURFEW|WILLFUL|JAIL|SHELLS|W[/ ]*SPEC[ ,]+|^SP[E]*C[- I]|SPEC[ -.//CIAL]+A[L]+EG|TEL MISUSE|TELEPHONE MISUSE';
				 
Other4:= 'TRASH|JUNK|ACCESRY|SERV|INTERF|CAPIAS|LOG|SBPP|TIME ZONE|TOBAC|C[O]*NT[EM]+PT|CONT OF CT|'+
				 'UNPAID|UNPD|ZONE|TRANSP|WALTON|WAOJ|W\\.C\\.|W[/]C|APPEAR|FISH|GAME|WILDLIFE|DEER|TURKEY|DOG|WILD|ANIMAL|WOLF|RACCOON|HUNT|CATTLE|'+
				 'MONKEY|COUGAR|CANINE|PITBULL|CANOE|CARIBOU|CAPAIS |CAPIA|CAPIAS| CAPIS |CDI[- /]|SLEEP| F[ ]*&[ ]*[BCG] |PEDDLING|TEMPER|DEBRIS|FMCSR|FMCSK|'+
				 'LOCAL|EXOTIC|FACILITAT|FACILAT|FACILIAT|FACILITIES|FACILITY|CORPSE|PAINT|PAINTING|ENDAN|EMDAN|ENDG|ENDNG|ENDAG| END |ENGAN|ENFAN|ENDN|ENDGR|EBDANG|'+
				 'EBDAMG|ENDNGR|ENDNAG|ENDENG|ENDAND|EDANG|ENANG|ENDDANG|FAIL|DOOR|DEAD|BATT|CUSTODY|DUMP|DUTY|ERROR|UPDATE|FOCUS|UNDERSIZE|EXTRA|REMOV|UNSWORN';			 

Other5:= ' CAT |843\\.02[\\. ]|843.15.1A|[-/\\. ]VASAP[-/;\\. ]|843\\.15\\.1B|PC 368[(][BC][)]|PC 136\\.1[(][BC][)]|901\\.04 |HS 11365 | PC 118 |42-8-38 |PC 182[(]A[)]| 1244B |'+
         'EC 48200|12\\.44B|VC 2800\\.1|BP 7028| 12\\.44 [(]*[AB][) ]|99-9997|HS 12677 |PC 4502[(][A][)]|VC 40508[(][A][)]|PC 166\\.4|PC 166[(][A][)]|PC 1463\\.07|'+
				 'PC 1320[(][A][)]| PSP [123] | PC 69 | PC 272 |12.44[(][A][)]| PC 32 |FG 7145[(][A][)]|EC 48262|PC 148[(][A][)]|PC 148 |PC 148\\.9|'+
				  'PC 853\\.7|PC 1551\\.1|VC 2800\\.[12]|PC 466 |PC 118[(]A[)]| PC 69 |PC 148\\.5| PC 32 | 948\\.06 ';

Other6:= '^CPF[/ ]|^CPFX|^CTMPT |^D\\.O\\.C\\.|^BW |^C/A ON |C/A FAIL |^FPFC |^FNSB |^FRAM[INGE]*[/ ]|^FRA |^FTC |^ICE |.BENCH WARRANT.|^F REPAIR[/ ]|^FOJ OTHER |^CON ';
Other7:= '^FTO COURT |^FTO CT[\\. ]|^TSO|^F[POR]+ PROSECUTION SEE[:/ ]|^F[POR]+ SENTENC|^FOUND [FG]UI[L]*TY|^FOUND [FG]UI[L]*TU|^FOUND INCOMPETANT|^FOUND INCOMPETENT|^FOUND NOT GUILTY';		 
Other8:= 'HUMAN|MUR[/]ACC|SOLIC[/]MUR|AS[S]*/MUR|INT/EMERG|INTER[/]W[/]EMERG|^B[/]W[-/( ]|WRNT | WRT |WSP WRT|[-/ ]FT[FPAY]+[-/ ]|OBEY|[(]BW[)]';
//Roger's comment 8/5/16 QA Updates - Drugs - Updates After Cannot Classify and Traffic Review
//Other9:= 'PEDDL|ARREST|ARRST|LABEL|LABELING|^MISD[-/ \\.]|^MISD[EA]M|^FELONY|REVOC|WRONG SEX|POSTPONEMENT';
Other9:= 'PEDDL|ARREST|ARRST|LABEL|LABELING|REVOC|WRONG SEX|POSTPONEMENT|FUG WARR/OUT|^PTRP |^PPS VIOLATION SANCTION|' +
         'BUS W/O TRADERS LICENSE|CRIM CONTMP|FTP AFTER CVC CONVICTION|FUGITIVE FROM JUSTIC';
//AMEDNED|AMEND|ATTEMPT|ATTMPTD|
Is_it := MAP(
						 
						 In_Global_Exclude(poffense,'other')='Y' => 'Y', //this stmt has to be before the other tests
						 
						 // trim(poffense) in _fmod_offense_category_list.OtherList =>'Y',
						 
						 REGEXFIND('CONTRIB' ,poffense,0) <> '' AND              
						 REGEXFIND('DELI[N]*Q' ,poffense,0) <> '' => 'Y',

       			 REGEXFIND('FAIL' ,poffense,0) <> '' AND              
						 REGEXFIND('SPEED|LANE|SIGNAL' ,poffense,0) <> '' => 'N',

            Is_Arson(poffense)='Y' OR                        
						Is_Assault_aggr(poffense)='Y' OR                      
						Is_Assault_other(poffense)='Y' OR                      
						Is_Bribery(poffense)='Y' OR					
						Is_Burglary_BreakAndEnter_res(poffense)='Y' OR
						Is_Burglary_BreakAndEnter_comm(poffense)='Y' OR
						Is_Burglary_BreakAndEnter_veh(poffense)='Y' OR
						Is_Counterfeiting_Forgery(poffense)='Y' OR       
						Is_Destruction_Damage_Vandalism(poffense)='Y' OR //
						Is_Drug_Narcotic(poffense)='Y' OR                
						// Is_Embezzlement(poffense)='Y' OR                 
						// Is_Extortion_Blackmail(poffense)='Y' OR						
						Is_Fraud(poffense)='Y' OR                        
						Is_Gambling(poffense)='Y' OR                     
						Is_Homicide(poffense)='Y' OR                     
						Is_Kidnapping_Abduction(poffense)='Y' OR   
						Is_Theft(poffense)='Y' OR 						
						Is_Shoplifting(poffense)='Y' OR 	
						Is_Pornography(poffense)='Y' OR                  
						Is_Prostitution(poffense)='Y' OR                 
						Is_Robbery_res(poffense)='Y' OR                     // 
						Is_Robbery_comm(poffense)='Y' OR
						Is_SexOffensesForcible(poffense)='Y' OR          
						Is_SexOffensesNon_forcible(poffense)='Y' OR      
						Is_Stolen_Property_Offenses_Fence(poffense)='Y' OR						
						Is_Weapon_Law_Violations(poffense)='Y' OR        
						Is_Identity_Theft(poffense)='Y' OR               
						Is_Computer_Crimes(poffense)='Y' OR 
						Is_Terrorist_Threats(poffense)='Y' OR    	//	
						Is_Restraining_Order_Violations(poffense)='Y' OR 		 				
						Is_traffic(poffense)='Y' OR                      
						Is_BadChecks(poffense)='Y' OR     						
						Is_CurfewLoiteringVagrancyVio(poffense)='Y' OR 						
						Is_DisorderlyConduct(poffense)='Y' OR            
						Is_DrivingUndertheInfluence(poffense)='Y' OR     
						Is_Drunkenness(poffense)='Y' OR	//					
						Is_FamilyOffenses(poffense)='Y' OR     
						Is_LiquorLawViolations(poffense)='Y' OR          
						Is_TrespassofRealProperty(poffense)='Y' OR       
						Is_PeepingTom(poffense)='Y' OR  
						//Roger's comment QA Results for Cannot Classify File  and the Other Offenses File 7/15
						Is_Motor_Vehicle_Theft(poffense)='Y' OR 
						Is_HumanTrafficking(poffense)='Y' =>                'N',  	
						
						
						REGEXFIND('UNL[-/ ]'              ,poffense,0) <> '' AND              
						REGEXFIND('CRIM'                  ,poffense,0) <> '' AND     
						REGEXFIND('INSTRU'                ,poffense,0) <>  '' => 'Y',
						
						REGEXFIND('FORFEIT'	              ,poffense,0) <> '' AND     
						REGEXFIND('SPECIFI|BAIL|BOND'     ,poffense,0) <>  '' => 'Y',
						
						REGEXFIND('REPEAT|HABITUAL'	      ,poffense,0) <> '' AND     
						REGEXFIND('OFFEND'                ,poffense,0) <>  '' => 'Y',
												
						REGEXFIND('ZON'	                  ,poffense,0) <> '' AND     
						REGEXFIND('VEH| M[/]*V |AUTO'     ,poffense,0) <>  '' => 'Y',
						
						REGEXFIND('LAW'                   ,poffense,0) <> '' AND              
						REGEXFIND('COMMAN'                ,poffense,0) <> '' AND     
						REGEXFIND('DISREG'                ,poffense,0) <>  '' => 'Y',
						
						REGEXFIND('SOR'                   ,poffense,0) <> '' AND              
						REGEXFIND('RESTR'                 ,poffense,0) <>  '' => 'Y',
						
						REGEXFIND('ADULT'                 ,poffense,0) <> '' AND              
						REGEXFIND('ESTAB'                 ,poffense,0) <>  '' => 'Y',
												
						REGEXFIND('DO NOT'                ,poffense,0) <> '' AND              
						REGEXFIND('REL|OCCUPY|USE'        ,poffense,0) <>  '' => 'Y',
						
						REGEXFIND('FTN'                   ,poffense,0) <> '' AND              
						REGEXFIND(' DMV '                 ,poffense,0) <> '' AND  
						REGEXFIND('ADD'                   ,poffense,0) <>  '' => 'Y',
						
						REGEXFIND('INT[/ ]'               ,poffense,0) <> '' AND              
						REGEXFIND('EMER[/ ]'              ,poffense,0) <> '' AND  
						REGEXFIND('CALL'                  ,poffense,0) <>  '' => 'Y',
						
						REGEXFIND('OBSCEN'                ,poffense,0) <> '' AND              
						REGEXFIND('CALL|PHON|E[-]MAIL|EMAIL|MESSAGE' ,poffense,0) <>  '' => 'Y',
						
						REGEXFIND('KILL|TAKE'             ,poffense,0) <> '' AND              
						REGEXFIND('WRONG'                 ,poffense,0) <> '' AND             
						REGEXFIND('SEX'                   ,poffense,0) <>  '' => 'Y',
						
            REGEXFIND('UNLAW'                 ,poffense,0) <> '' AND              
						REGEXFIND('COND|REMAIN'           ,poffense,0) <> '' => 'Y',
						
						REGEXFIND('CARRY'                 ,poffense,0) <> '' AND              
						REGEXFIND(' INS'                  ,poffense,0) <>  '' => 'Y',
            
						REGEXFIND('^FTA |^FTA[ ]*\\$|^FTA[ ]*[/]' ,poffense,0) <> ''  => 'Y',

            REGEXFIND('FAIL|AILL'            ,poffense,0) <> '' AND              
						REGEXFIND('OBEY'                 ,poffense,0) <> '' AND  
						REGEXFIND('REASONA'              ,poffense,0) <> '' AND
						REGEXFIND('LAW|ORDE'             ,poffense,0) <> '' => 'Y',

            REGEXFIND('FAIL|F[/]T|^FL |^F[/]',poffense,0) <> '' AND              
						REGEXFIND('CARRY'                ,poffense,0) <> '' AND  
						REGEXFIND('SAFE'                 ,poffense,0) <> '' AND 
						REGEXFIND('EQU[I]*P'             ,poffense,0) <> '' => 'Y',


            REGEXFIND('DESTR|WITHHOLD|FABRI|TAMP|TAM|TMPR|DISPO|SUPPR|PREJUDIC',poffense,0) <> '' AND              
						REGEXFIND('EVIDENCE'            ,poffense,0) <> '' => 'Y',
 
            REGEXFIND('COURT'               ,poffense,0) <> '' AND              
						REGEXFIND('COST'                ,poffense,0) <> '' AND  
						REGEXFIND('PAID| PD |REV'       ,poffense,0) <> '' => 'Y',

            REGEXFIND('COURT'               ,poffense,0) <> '' AND              
						REGEXFIND('ORDER'               ,poffense,0) <> '' => 'Y',

            REGEXFIND('COURTESY'            ,poffense,0) <> '' AND              
						REGEXFIND('HOLD'                ,poffense,0) <> '' => 'Y',

            REGEXFIND('FAB'                 ,poffense,0) <> '' AND              
						REGEXFIND('PHY'                 ,poffense,0) <> '' AND  
						REGEXFIND('EVID'                ,poffense,0) <> '' => 'Y',

						//Roger's comment 7/15
            REGEXFIND('ROWOV |PROBAT HLD'   ,poffense,0) <> ''
						=> 'Y',
						
            REGEXFIND('SUPPORT'             ,poffense,0) <> '' AND              
						REGEXFIND('FAIL |WITHHOLD|REFUSE|FLR|OBLIGAT|SPOUS|CHIL|PARENT|PAY|FTP|CHILD|MINOR|DESERT|PROVID' ,poffense,0) = '' and
						~(REGEXFIND('CRIM' ,poffense,0) <> '' and REGEXFIND('NO' ,poffense,0) <> '')
						=> 'Y',

            REGEXFIND('CAMP'                ,poffense,0) <> '' AND              
						REGEXFIND('CAMPBELL'            ,poffense,0) =  '' => 'Y',
 
            REGEXFIND('SIDEWALK'            ,poffense,0) <> '' AND              
						REGEXFIND('BICYCLE'             ,poffense,0) <> '' => 'Y',
						
            REGEXFIND('MOLEST'              ,poffense,0) <> '' AND              
						REGEXFIND('WILDLIFE|BIRD|ALLIGATOR'               ,poffense,0) <> '' => 'Y',

            REGEXFIND('SELL'                ,poffense,0) <> '' AND              
						REGEXFIND('RECEI'               ,poffense,0) <> '' AND  
						REGEXFIND('TRANS'               ,poffense,0) <> '' => 'Y',

 						REGEXFIND('FOOD'                ,poffense,0) <> '' AND              
						REGEXFIND('STAMP|STMP'          ,poffense,0) = '' => 'Y',
						
            REGEXFIND('FAIL|OBEY'           ,poffense,0) <> '' AND              
						REGEXFIND('RENABLE|RENBLE'      ,poffense,0) <> '' AND
						REGEXFIND('LAW'                 ,poffense,0) <> '' => 'Y',

            REGEXFIND('FAIL'              ,poffense,0) <> '' AND              
            REGEXFIND('OBEY'              ,poffense,0) <> '' AND  
						(REGEXFIND('MOVE'             ,poffense,0) <> '' OR
						 (REGEXFIND('LAW',poffense,0) <> '' AND REGEXFIND('ORDER' ,poffense,0) <> '' )
						)=> 'Y',
	
            REGEXFIND('EXHAUST'           ,poffense,0) <> '' AND              
						REGEXFIND('BATH|VENT'         ,poffense,0) <> '' => 'Y',

            REGEXFIND('ILL|UNLAW|UNLW|UNLAF',poffense,0) <> '' AND              
						REGEXFIND('ASSEMB'            ,poffense,0) <> '' => 'Y',

            REGEXFIND('FAIL'              ,poffense,0) <> '' AND  
            REGEXFIND('VERIF'             ,poffense,0) <> '' AND              
						REGEXFIND('SEC|INS|ADDRE'     ,poffense,0) <> '' => 'Y',

            REGEXFIND('FAIL[URE]*'        ,poffense,0) <> '' AND              
            REGEXFIND(' TO '              ,poffense,0) <> '' AND  
						REGEXFIND(' ID |IDENT'        ,poffense,0) <> '' => 'Y',
						
						REGEXFIND('ESCAP'             ,poffense,0) <> '' AND              
						REGEXFIND('CORR|CUST |ARREST | PENAL| DOC |CONFIN| FEL ' ,poffense,0) <> '' => 'Y',

            REGEXFIND('UNLIC'             ,poffense,0) <> '' AND              
						REGEXFIND('CONTR|BUSIN'       ,poffense,0) <> '' => 'Y',

            REGEXFIND('BUILD'             ,poffense,0) <> '' AND              
						REGEXFIND('CODE'              ,poffense,0) <> '' => 'Y',

            REGEXFIND('BUILD'             ,poffense,0) <> '' AND              
						REGEXFIND('CERT|PERMIT|PRMT|INSP|SECUR|VIO|ZONE|NEAR|WITHOUT|W[/]O|SETBACK'               ,poffense,0) <> '' and 
            REGEXFIND('INTENT'             ,poffense,0) = '' => 'Y',

            REGEXFIND('EXIRED'            ,poffense,0) <> '' AND              
						REGEXFIND('MEDICAL'           ,poffense,0) <> '' => 'Y',

            REGEXFIND('EXIT'              ,poffense,0) <> '' AND              
						REGEXFIND('HIGHWAY| HWY |FWY |PAY | FARE | HW | RWY | RDWAY '               ,poffense,0) <> '' => 'Y',

            REGEXFIND('FAIL'              ,poffense,0) <> '' AND              
						REGEXFIND('REPAIR|REPLAC|CORRECT' ,poffense,0) <> '' => 'Y',

            REGEXFIND('ERROR '            ,poffense,0) <> '' AND              
						REGEXFIND('SEE '              ,poffense,0) <> '' => 'Y',				
												
						REGEXFIND('PROHIBIT' ,poffense,0) <> '' AND  
						(REGEXFIND('ALCO|INTOX|DRINK|LIQ|BEER|DRUNK|WINE|SEX|DRUG'  ,poffense,0) = '' or 
						 (REGEXFIND('CONTR' ,poffense,0) = '' and REGEXFIND('SUBST' ,poffense,0) = '')
						 ) 	=> 'Y',
						
						REGEXFIND('POISON'     ,poffense,0) <> ''  => 'Y',
						
						REGEXFIND('CORRUPT|ABANDON'     ,poffense,0) <> '' AND              
						REGEXFIND('CHILD|MINOR|JUVE|ORG',poffense,0) = '' => 'Y',
						
						REGEXFIND('TELEPHONE'         ,poffense,0) <> '' AND              
						REGEXFIND('HAR'               ,poffense,0) <> '' => 'Y',
						 						 
            REGEXFIND('NUISA'             ,poffense,0) <> '' AND              
						REGEXFIND('PUB'               ,poffense,0) = '' => 'Y',
						                          
            REGEXFIND('PROP'              ,poffense,0) <> '' AND  
						REGEXFIND('DEST|DAMAG|DMG'    ,poffense,0) <> '' AND 
						REGEXFIND('ACC|INVOL'         ,poffense,0) <> ''  AND 
						REGEXFIND('INTENT'            ,poffense,0) = '' => 'Y',
                                      
            REGEXFIND('BOOK'              ,poffense,0) <> '' AND  
						REGEXFIND('BOOKMAK'           ,poffense,0) = '' => 'Y',
                                      
            REGEXFIND('MOTION'            ,poffense,0) <> '' AND  
						REGEXFIND('PROMOTION'         ,poffense,0) = '' => 'Y',
						


            REGEXFIND('FALSE|FAL'                           ,poffense,0) <> '' AND              
						REGEXFIND('REPORT|RPT|REPT|ALARM|CALL|INFO|INF' ,poffense,0) <> '' AND  
						// REGEXFIND('BOMB|ARSON|EMERG|LAW|FIRE|POL|RESC|911|9-1-1|AMBUL|SAFE|ARSON' ,poffense,0) <> '' => 'Y',
						REGEXFIND('ARSON|EMERG|LAW|FIRE|POL|RESC|911|9-1-1|AMBUL|SAFE|ARSON' ,poffense,0) <> '' => 'Y',

            REGEXFIND('FALSE|FAL'      ,poffense,0) <> '' AND              
						REGEXFIND('REPORT|RPT|REPT',poffense,0) <> '' AND  
						REGEXFIND('CRIM'           ,poffense,0) <> '' => 'Y',

            REGEXFIND('BOOK'           ,poffense,0) <> '' AND  
						REGEXFIND('LOG'            ,poffense,0) <> '' => 'Y',

            REGEXFIND('PROP'           ,poffense,0) <> '' AND              
						REGEXFIND('MAINT'          ,poffense,0) <> '' AND  
						REGEXFIND('CODE'           ,poffense,0) <> '' => 'Y',
                                       
            REGEXFIND('ADMIN|TRANS'    ,poffense,0) <> '' AND              
 					  REGEXFIND('ORD'            ,poffense,0) <> '' AND  
						REGEXFIND('ADMINISTER'     ,poffense,0) <> '' => 'Y',

            REGEXFIND('OUT'            ,poffense,0) <> '' AND              
						REGEXFIND('CO|COUNTY|CITY' ,poffense,0) <> '' AND  
						REGEXFIND('WARR|WRRT|HIT'  ,poffense,0) <> '' => 'Y',

            REGEXFIND('WRIT'           ,poffense,0) <> '' AND              
						REGEXFIND('BOD'            ,poffense,0) <> '' AND  
						REGEXFIND('ATTACH'         ,poffense,0) <> '' => 'Y',
                                         
            REGEXFIND('WRIT'           ,poffense,0) <> '' AND              
						REGEXFIND('OF'             ,poffense,0) <> '' AND  
						REGEXFIND('ARREST|ARRST'   ,poffense,0) <> '' => 'Y',						
						 
						REGEXFIND('DOG'             ,poffense,0) <> '' AND              
						REGEXFIND('TAG|VAC|REG|RAB' ,poffense,0) <> '' => 'Y',						 

            REGEXFIND('ALTER'           ,poffense,0) <> '' AND              
						REGEXFIND('SALTER|WALTER|ALTERNATIVE' ,poffense,0) <> '' => 'Y',

 					  //Roger's comment QA review Global Expression Round 3 8/26/16
	          REGEXFIND('[ACCESSORY|ACESSORY] AFTER THE FACT|BE AN ACCESSORY',poffense,0) <> '' => 'Y',						 						 

            REGEXFIND('ACC'             ,poffense,0) <> '' AND              
						REGEXFIND('A[/]F|A[/]FAC'   ,poffense,0) <> '' => 'Y',

            REGEXFIND('SHOOT'           ,poffense,0) <> '' AND              
						REGEXFIND('ANIMAL|DOG|DEER|BIRD|OWL|GEESE|WATERFOWL|SPECIES|PHEASANT|DUCK|MOOSE|WILDLIFE|HORSE|CRAP|GAME' ,poffense,0) <> '' => 'Y',
	
            REGEXFIND('RESTRAIN'        ,poffense,0) <> '' AND              
						REGEXFIND('CONFIN|CRIM|UNL|IMPRIS|FELON|ABUSE|CHILD' ,poffense,0) = '' => 'Y',

 				 						 
						REGEXFIND('CRUEL'           ,poffense,0) <> '' AND              
						REGEXFIND('FOWL|GAME|DOG|PETS|LIVESTOCK|GOOSE|HORSE|CAT|KITTEN|A[ANI]+[MA]+L|ANIM|A[NM]I[MN][AL]+|PONY|CHOW|TORTIS|ROTT[I]*|GOAT|PUP|'+
                       'HOUND|SHEP|BIRDS|ROMULUS|LAB|K-9|PIT[ ]*BULL|TAB|PIG|LLAMA|DUCK|FERRET|PARROT|CHIHUAHUA|L[I]*VST[OC]*K|RO[T]+WEI|CANINE' ,poffense,0) <> '' => 'Y',

						REGEXFIND(' ID | CDL | DL ' ,poffense,0) <> '' AND
						REGEXFIND('POSS'            ,poffense,0) <> '' AND 
						REGEXFIND(' NO '            ,poffense,0) <> ''  => 'Y',	
						
						REGEXFIND('POSS'            ,poffense,0) <> '' AND    
						REGEXFIND('ALCOH|LIQ|BEER|INTOX' ,poffense,0) = ''  => 'Y',	

            REGEXFIND('FALSE'           ,poffense,0) <> '' AND              
            REGEXFIND('DECL'            ,poffense,0) <> '' AND              
						REGEXFIND('OWN|OWENRSHIP|OWERSHIP|PAW[MN]' ,poffense,0) = '' => 'Y',

						REGEXFIND('UNL'             ,poffense,0) <> '' AND              
            REGEXFIND('USE'             ,poffense,0) <> '' AND              
						REGEXFIND('COMMUN'          ,poffense,0) <> '' => 'Y',

            REGEXFIND('FALSE'           ,poffense,0) <> '' AND              
						REGEXFIND('REPORT|PRTENSE|SWEAR|TESTIMO' ,poffense,0) <> '' => 'Y',
						
            REGEXFIND('FALSE'           ,poffense,0) <> '' AND              
						REGEXFIND('USE'             ,poffense,0) <> '' AND              
						REGEXFIND('CREDIT|CRD|CRED' ,poffense,0) =  '' => 'Y',
						
						REGEXFIND('FALSE'           ,poffense,0) <> '' AND              
						REGEXFIND('UTTER'           ,poffense,0) <> '' AND 
						REGEXFIND('FRAUD|BANK|CHECK|PRESC|FORGE|CREDIT|DEBIT|CURRENCY|BILL|NOTE|INSTRU|DOC[UMENT ]+|INSTUMENT|FINANCIAL' ,poffense,0) = '' => 'Y',
											 
						REGEXFIND('VIOL'            ,poffense,0) <> '' AND              
						REGEXFIND('ORDER'           ,poffense,0) <> '' => 'Y',
						 
				
						REGEXFIND('VIO'             ,poffense,0) <> '' AND              
						REGEXFIND('PAR|TITL|QUARA|RECORD|QUARE|QUARI|MEDICAL|LOP[ -]|OFFER|ORD' ,poffense,0) <> '' => 'Y',
						 
            REGEXFIND('BURN'            ,poffense,0) <> '' AND              
						REGEXFIND('ARSON|MAL|WI[L]+FUL|FRAUD' ,poffense,0) = '' => 'Y',	
						
            REGEXFIND('LIGHT'           ,poffense,0) <> '' AND                       
						REGEXFIND('HEAD|HUNT|HUN|SHINE|OBSERVE|TAK|KILL|JACK|SPOT|CAST|ARTIFIC|IMPROP|INSF|INSUF|CAST|AREA|ON|PLACE|VIO|ILL' ,poffense,0) <> '' and 
						REGEXFIND('DEER|WILDLIF|FISH|GAME' ,poffense,0) <> '' => 'Y',
						
            REGEXFIND('JUV|CHILD|MINOR' ,poffense,0) <> '' AND              
						REGEXFIND('SMOK|MAR'        ,poffense,0) <> '' AND 
						REGEXFIND('SCHOOL'          ,poffense,0) <> '' => 'Y',
					
            REGEXFIND('PROP'            ,poffense,0) <> '' AND              
						REGEXFIND('DEST|DAMAG|DMG'  ,poffense,0) <> '' AND
						REGEXFIND('ACC|INVOL'       ,poffense,0) <> '' AND
						REGEXFIND('INTENT'          ,poffense,0) <> '' => 'Y',

            REGEXFIND('VIO'             ,poffense,0) <> '' AND              
						REGEXFIND('PAR|TITL|QUARA|QUARE|QUARI|MEDICAL|LOP[ -]|OFFER|ORD' ,poffense,0) <> '' => 'Y',
						
            REGEXFIND('ORD'             ,poffense,0) <> '' AND              
						REGEXFIND('MUNI|CITY'       ,poffense,0) <> '' => 'Y',						
 
						REGEXFIND('HARASS|HARRASS'  ,poffense,0) <> '' => 'Y',	

            REGEXFIND('BEACH'            ,poffense,0) <> '' AND              
						REGEXFIND('HOUR|HR'          ,poffense,0) <> '' => 'Y',

            REGEXFIND('GANG'             ,poffense,0) <> '' AND              
						REGEXFIND('CRIM|PARTIC|STREET|MEMBER|ACTIVITY|RECRUIT|DIRECT'       ,poffense,0) <> '' => 'Y',

            REGEXFIND('VIO'             ,poffense,0) <> '' AND              
						REGEXFIND('DEAL'            ,poffense,0) <> '' AND  
						REGEXFIND('VEH|MV|AUTO'     ,poffense,0) <> '' => 'Y',

            REGEXFIND('HARR'            ,poffense,0) <> '' AND              
						REGEXFIND('PUB'             ,poffense,0) <> '' AND 
						REGEXFIND('SERV'            ,poffense,0) <> '' => 'Y',

            REGEXFIND('SERV'            ,poffense,0) <> '' AND              
						REGEXFIND('WEEKEND'         ,poffense,0) <> '' => 'Y',				
						
            REGEXFIND('POLI|LEO'        ,poffense,0) <> '' AND              
						REGEXFIND('RADIO|SCAN|COMM|OBST|OBEY',poffense,0) <> '' => 'Y',

            REGEXFIND('HOSE'            ,poffense,0) <> '' AND              
						REGEXFIND('BIBB'            ,poffense,0) <> '' => 'Y',

            REGEXFIND('LIVESTOCK'       ,poffense,0) <> '' AND              
						REGEXFIND('HORSE'           ,poffense,0) <> '' => 'Y',

            REGEXFIND('MUZZLE'          ,poffense,0) <> '' AND              
						REGEXFIND('LOAD'            ,poffense,0) <> '' => 'Y',

            REGEXFIND('POINT'           ,poffense,0) <> '' AND              
						REGEXFIND('SALE'            ,poffense,0) <> '' AND
						REGEXFIND('VIO'             ,poffense,0) <> '' => 'Y',

            REGEXFIND('Point|POINT'     ,poffense,0) <> '' AND              
						REGEXFIND('SYSTEM'          ,poffense,0) <> '' => 'Y',

            REGEXFIND('CIG'             ,poffense,0) <> '' AND              
						REGEXFIND('MARIJ|DRUG|CDS'  ,poffense,0) = '' => 'Y',

            REGEXFIND('MV|VEH'          ,poffense,0) <> '' AND              
						REGEXFIND('VIO'             ,poffense,0) <> '' AND              
						REGEXFIND('LAW'             ,poffense,0) <> '' AND              
						REGEXFIND('TRAF'            ,poffense,0) =  '' => 'Y',
						
            REGEXFIND('SHOW'            ,poffense,0) <> '' AND              
						REGEXFIND('CAUSE|NO|FAIL'   ,poffense,0) <> '' => 'Y',

            REGEXFIND('DESTRUC'         ,poffense,0) <> '' AND              
						REGEXFIND('PROP|DEVICE'     ,poffense,0) =  '' => 'Y',

            REGEXFIND('ACCESSORY'       ,poffense,0) <> '' AND              
						(REGEXFIND('STR|USE|ZON|BATH|SHOWER|EQUIP|PARTS|BUILD|QUART|COMMON|BLD|MACHINE|AREA|REPAIR' ,poffense,0) = '' AND
						 (REGEXFIND('PART' ,poffense,0) = '' AND REGEXFIND('LIST' ,poffense,0) = '')
						)
						=> 'Y',

            REGEXFIND('VIO\\(\\.[0-9]+|VIO\\([0-9]+'         ,poffense,0) <> '' => 'Y',
						
						//Roger's comment QA Terrorist Threats Round 5 10/18/16
            REGEXFIND('INTERRUPT[I| ]|INTERR V9'             ,poffense,0) <> '' => 'Y',

            REGEXFIND(Other1 ,poffense,0) <> '' => 'Y',	        
						// REGEXFIND(Other2 ,poffense,0) <> '' => 'Y',	 
						REGEXFIND(Other3 ,poffense,0) <> '' => 'Y',	 
  					REGEXFIND(Other4 ,poffense,0) <> '' => 'Y',
						REGEXFIND(Other5 ,poffense,0) <> '' => 'Y',	 
						REGEXFIND(Other6 ,poffense,0) <> '' => 'Y',
						REGEXFIND(Other7 ,poffense,0) <> '' => 'Y', 
						REGEXFIND(Other8 ,poffense,0) <> '' => 'Y',
						REGEXFIND(Other9 ,poffense,0) <> '' => 'Y',
						//Roger's comments - QA Update - Traffic   Round 4 9/23/16 and 9/27/16
						REGEXFIND('BUSIN[ESS]*|VENDOR'                       ,poffense,0) <> '' and
					  REGEXFIND('LICENSE|LIC |LIC[\\.]?$|LICENS$|PERMIT'	 ,poffense,0) <> '' and
					  REGEXFIND('NO[T]? |EXPIRED|FAIL[ |E|U|/]|SUSPEND|NO |REQ[U| ]|WITHOUT|W/O',poffense,0) <> ''  => 'Y',

						//Roger's comments - QA Update - Other Offenses Round 6
						REGEXFIND('S[\\.]*[/]*C[\\.][ ]*[\\-]*[ ]*BONDSMAN|SC\\-BOND|CASH BOND|NO BOND|BAIL BOND|' + 
						          'BOND [POSTED|JUMP|REDUCED]|FIRE[ ]*WORK|PREVENT[IONG]*|HAZARD|HINDER',poffense,0) <> ''		=> 'Y',
						REGEXFIND('SCHOOL'						                       ,poffense,0) <> '' and
					  REGEXFIND('SMO[I]?K[E|I]|GD\\.| ARM|SIMULAT|M/S/D/P CS|CONT SUB|ALCOHOL|DISTURB|' +
						          'S/C CK TRAF|N[A]*RCTCS|LAW VIOL|DISRUPTING|UNLAWFUL ACT'	 ,poffense,0) <> '' => 'Y',
						REGEXFIND('BUSINESS PURPOSE|MASSAGE'						     ,poffense,0) <> '' and
					  REGEXFIND('VIOL|ILLEGAL|UNLAWF|WITHOUT [A ]*LIC|W[/]*O [A ]*LIC|W/O|PERMIT|IMPROPER|OPERATE AGAINST|' +
						          'GENITALS|EROGENOUS|UNLICENSED|EXIT LOCK'	 ,poffense,0) <> '' 								=> 'Y',

						REGEXFIND('ENDANG'                  ,poffense,0) <> '' AND              
						(REGEXFIND('CRIMINAL|FELONY| FEL '   ,poffense,0) <>  '' OR
						 (REGEXFIND('RISK',poffense,0) <>  '' and REGEXFIND('DEATH ',poffense,0) <>  ''))=> 'Y',
					  'N');
                              		 
return Is_it;
end;

//--------------------------------------------------------------------------------------------------------------------------------------

export Is_Unclassified(string poffense) := function

 Non_offense1  := '^TX[0-9]+$|[PV]C [0-9]+|NOT SPECIFIED|.BW.[ / ]*J[U]*DG[E]*|BOOKING ERROR|THE HONORABLE JUDGE:|'+
                     'M[0-9]{7}[A-Z]*[ ]*$|MAGISTRATE|MAG[.]* BY|NOT SPECIFIED|^VC [0-9]+[(][A-Z][)][0-9]+|MISDEMEANOR[0-9]+[ ]*$|COURT COSTS PAID [A-Z0-9]|'+
										 'CAP/SC REV/UTTER|^["]*(CAMPBELL|BUTLER)[ ]*$|COUNTY CODE VILATION|CAMPBELL|SNOHOMISH|UNKNOWN CHARGE'; 
	                                                             
 Non_offense2  := '#[0-9]+[A-Z-]+[0-9A-Z-]*[ ]*$|#[0-9]+[A-Z-]+[ ]*$|#[A-Z-]+[0-9]+[0-9A-Z-]*[ ]*$|PT [#]*[0-9]{6}|^CR [0-9]+ [0-9 ]+$|^C[TR][C]*[0-9]+[A-Z]+[/A-Z0-9 ]+ CT[ ]*$|'+
                  'CT[ 0-9]+[ OF-]+[A-Z ]*[0-9]+[A-Z]+|C[#0-9]+CT[0-9]+[AX/MB ]*|([ A-Z\\.]+ ([0-9]+[/])+)+[ ]*|[\\*]+FL P/U ONLY[\\*]+|WE WILL EXTRADITE';                                                      
     																																																								
 Non_offense3  := '^F[ -]*[0-9]+[0-9 -]+[A-Z]*|^ECFS[# ]*398275|^["]*EAST POINT [GA ]*PD(.*)[0-9 ]+[A-Z]*[0-9 ]+["]*';
 
 Non_offense4  := '^TXHPD[0-9]+[0-9,* ]*[A-Z ]+|^TXDPS[0-9]+[ A-Z\\.*]+[0-9 ]+$|TX[0-9]+[ A-Z\\.*]+[0-9 ]+$|^ECFS[#]*[0-9]+|^["]*BSC[/]';
 Non_offense4a := '^TX[0-9]+[ ]*[A-Z][ A-Z]$';
 //CO
 Non_offense5  := '(BA[L]*DWIN|BUTLER|BUTTS|CALVERT|CAMDEN|CAMBRIA|CAMPBELL|CALHOUN|CANTON|CARROL[L]*|CARROLLTON|CATOOSA|CALYTON|DALLAS|DAWSON|COWETA|COBB|COOK|DEKALB|COLUMBIA|FORSYTH|FRANKLIN) (CI|CO|CTY)[\\. ]*[SO]*';
 //PD
 Non_offense6  := '((FOREST PK|FORT VALLEY|FORT WORTH|CALHOUN|CAMBRIDGE|CANTON[ GA]*|COLUMBUS|DAWSON|CONYERS|COVINGTON|DALLAS|FRANKLIN|HOMINY) (DIST|P[\\.]*D|CITY|POLICE|PARISH))|CAMADAR [INC ]*VS |^CALIF[ORNIA]* DEPT [OF ]*C[ORRECTION]*|^["]*CALIF[ORNIA]* D[ \\.]*O[ \\.]*C';
 Non_offense6a := '(FORSYTH|FOREST PK|FORT VALLEY|FORT WORTH|CALHOUN|CAMBRIDGE|CANTON[ GA]*|COLUMBUS|DAWSON|CONYERS|COVINGTON|DALLAS) [0-9]*[A-Z]*[0-9]*[ ]*$';
 
 Non_offense7  := '(FELONY|MISDEMEANOR)  COUNT(S) OF  [0-9]+\\.[0-9\\.]+[0-9\\. A-Z]|^[0-9]C[PO][0-9]{2}/[0-9]{2}/[0-9]{2}';
 Non_offense8  := '(DALLAS|CAMPBELL) CO[UNTY]*[ 0-9]*]|^(CALHOUN|CALIF[ORNIA]*) (.*)(HOLD|STATE)';	
 Non_offense9  := '^FS[\\*]+[0-9]+\\.[0-9]+|^FTP [0-9]+\\.[0-9]+|^FTP [0-9]+[/][0-9]+[/][0-9]+';	
 
 Non_offense10 := '^[(]*[\\$][0-9]+|^#[0-9][)] VNM';
 
 Non_offense11 := '^MISD[\\.-/]|^MISDEM|^MISDAM|^FELONY|^UNKNOWN\\(PAPER FILES PURGED\\)|^EMPLOY SEC VIOLATION \\(PRINCIPAL\\)';
 Non_offense12 := '^SECURITY FEE - CRIMINAL \\(AB 1759\\)|^[ ]*ATTEMPT.[ ]*$|^[ ]*HOUSING[ ]*$|^[ ]*REQUIREMENTS FOR SAFETY[ ]*$|^[ ]*VIOLATION OF INSPECTION LAW[ ]*$|' + 
                  '^[ ]*REGISTRATION VIOLATION[S]*[ ]*$|^[ ]*NEVER OBTAINED LICENSE[ ]*$|^[ ]*INTOX[ ]*$|^[ ]*MISD CHG[ ]*$|^[ ]*CRIM MIS/0\\-200[ ]*$|^[ ]*REGISTRATION[ OF]*[ ]*$|^[ ]*OTHER STATE[ ]*$|^UNDERAGE$';
 
 rem_numAndOth := stringlib.stringfilterout(poffense,'0123456789-/() '); 	
 
  Is_it := MAP(
	          In_Global_Exclude(poffense,'other')='Y' => 'N',
	
            Is_Arson(poffense)='Y' OR                        
						Is_Assault_aggr(poffense)='Y' OR                      
						Is_Assault_other(poffense)='Y' OR                      
						Is_Bribery(poffense)='Y' OR					
						Is_Burglary_BreakAndEnter_res(poffense)='Y' OR
						Is_Burglary_BreakAndEnter_comm(poffense)='Y' OR
						Is_Burglary_BreakAndEnter_veh(poffense)='Y' OR
						Is_Counterfeiting_Forgery(poffense)='Y' OR       
						Is_Destruction_Damage_Vandalism(poffense)='Y' OR 
						Is_Drug_Narcotic(poffense)='Y' OR                
						// Is_Embezzlement(poffense)='Y' OR                 
						// Is_Extortion_Blackmail(poffense)='Y' OR						
						Is_Fraud(poffense)='Y' OR                        
						Is_Gambling(poffense)='Y' OR                     
						Is_Homicide(poffense)='Y' OR                     
						Is_Homicide(poffense)='Y' OR                     
						Is_Kidnapping_Abduction(poffense)='Y' OR   
						//Roger's comment QA Results for Cannot Classify File  and the Other Offenses File 7/15
						Is_Motor_Vehicle_Theft(poffense)='Y' OR 
						Is_Theft(poffense)='Y' OR 
						Is_Shoplifting(poffense)='Y' OR 	
						Is_Pornography(poffense)='Y' OR                  
						Is_Prostitution(poffense)='Y' OR                 
						Is_Robbery_res(poffense)='Y' OR                      
						Is_Robbery_comm(poffense)='Y' OR                      
						Is_SexOffensesForcible(poffense)='Y' OR          
						Is_SexOffensesNon_forcible(poffense)='Y' OR      
						Is_Stolen_Property_Offenses_Fence(poffense)='Y' OR						
						Is_Weapon_Law_Violations(poffense)='Y' OR        
						Is_Identity_Theft(poffense)='Y' OR               
						Is_Computer_Crimes(poffense)='Y' OR 
						Is_Terrorist_Threats(poffense)='Y' OR    						
						Is_Restraining_Order_Violations(poffense)='Y' OR 						
						Is_traffic(poffense)='Y' OR                      
						Is_BadChecks(poffense)='Y' OR     						
						Is_CurfewLoiteringVagrancyVio(poffense)='Y' OR 						
						Is_DisorderlyConduct(poffense)='Y' OR            
						Is_DrivingUndertheInfluence(poffense)='Y' OR     
						Is_Drunkenness(poffense)='Y' OR						
						Is_FamilyOffenses(poffense)='Y' OR     
						Is_LiquorLawViolations(poffense)='Y' OR          
						Is_TrespassofRealProperty(poffense)='Y' OR       
						Is_PeepingTom(poffense)='Y' OR      
						Is_HumanTrafficking(poffense)='Y' OR
						Is_Other(poffense)='Y' =>                'N', 
						
	             REGEXFIND('[A-Za-z]'   ,poffense,0) = ''  => 'Y',
	             REGEXFIND(Non_offense1 ,poffense,0) <> '' => 'Y',	               
							 REGEXFIND(Non_offense2 ,poffense,0) <> '' => 'Y',	
							 REGEXFIND(Non_offense3 ,poffense,0) <> '' => 'Y',
							 REGEXFIND(Non_offense4 ,poffense,0) <> '' => 'Y',
							 REGEXFIND(Non_offense4a,poffense,0) <> '' => 'Y',
							 REGEXFIND(Non_offense5 ,poffense,0) <> '' => 'Y',
							 REGEXFIND(Non_offense6 ,poffense,0) <> '' => 'Y',
							 REGEXFIND(Non_offense6a,poffense,0) <> '' => 'Y',
							 REGEXFIND(Non_offense7 ,poffense,0) <> '' => 'Y',
							 REGEXFIND(Non_offense8 ,poffense,0) <> '' => 'Y',
							 REGEXFIND(Non_offense9 ,poffense,0) <> '' => 'Y',
							 REGEXFIND(Non_offense10,poffense,0) <> '' => 'Y',
							 REGEXFIND(Non_offense11,poffense,0) <> '' => 'Y',
							 REGEXFIND(Non_offense12,poffense,0) <> '' => 'Y',
							 length(rem_numAndOth) <4 and length(rem_numAndOth) >0  => 'Y',
							 'N');
return Is_it;
end;

//--------------------------------------------------------------------------------------------------------------------------------------

export set_offense_category(string poffense) := function
bit_Arson                          := IF(Is_Arson(poffense)='Y',                                                                   hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_Arson),0);
bit_Assault_aggr                   := IF(Is_Assault_aggr(poffense)='Y',                       bit_Arson   |                        hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_Assault_aggr)                  ,bit_Arson);
bit_Assault_other                  := IF(Is_Assault_other(poffense)='Y',                      bit_Assault_aggr   |                 hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_Assault_other)                 ,bit_Assault_aggr);
bit_Bribery                        := IF(Is_Bribery(poffense)='Y',                            bit_Assault_other |                  hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_Bribery)                       ,bit_Assault_other);
bit_Burglary_BreakAndEnter_res     := IF(Is_Burglary_BreakAndEnter_res(poffense)='Y',         bit_Bribery |                        hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_Burglary_BreakAndEnter_res),    bit_Bribery);
bit_Burglary_BreakAndEnter_comm    := IF(Is_Burglary_BreakAndEnter_comm(poffense)='Y' ,       bit_Burglary_BreakAndEnter_res |     hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_Burglary_BreakAndEnter_comm),   bit_Burglary_BreakAndEnter_res);
bit_Burglary_BreakAndEnter_veh     := IF(Is_Burglary_BreakAndEnter_veh(poffense)='Y',         bit_Burglary_BreakAndEnter_comm |    hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_Burglary_BreakAndEnter_veh),    bit_Burglary_BreakAndEnter_comm);
bit_Counterfeiting_Forgery         := IF(Is_Counterfeiting_Forgery(poffense)='Y',             bit_Burglary_BreakAndEnter_veh |     hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_Counterfeiting_Forgery)        ,bit_Burglary_BreakAndEnter_veh);
bit_Destruction_Damage_Vandalism   := IF(Is_Destruction_Damage_Vandalism(poffense)='Y',       bit_Counterfeiting_Forgery |         hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_Destruction_Damage_Vandalism)  ,bit_Counterfeiting_Forgery);
bit_Drug_Narcotic                  := IF(Is_Drug_Narcotic(poffense)='Y',                      bit_Destruction_Damage_Vandalism |   hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_Drug_Narcotic)                 ,bit_Destruction_Damage_Vandalism);
bit_Fraud                          := IF(Is_Fraud(poffense)='Y',                              bit_Drug_Narcotic |                  hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_Fraud)                         ,bit_Drug_Narcotic);
bit_Gambling                       := IF(Is_Gambling(poffense)='Y',                           bit_Fraud |                          hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_Gambling)                      ,bit_Fraud);
bit_Homicide                       := IF(Is_Homicide(poffense)='Y',                           bit_Gambling |                       hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_Homicide)                      ,bit_Gambling);
bit_Kidnapping_Abduction           := IF(Is_Kidnapping_Abduction(poffense)='Y',               bit_Homicide |                       hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_Kidnapping_Abduction)          ,bit_Homicide);
bit_Theft                          := IF(Is_theft(poffense)='Y',                              bit_Kidnapping_Abduction |           hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_Theft)                         ,bit_Kidnapping_Abduction);
bit_Shoplifting                    := IF(Is_Shoplifting(poffense)='Y',                        bit_Theft |                          hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_Shoplifting)                   ,bit_Theft);
bit_Motor_Vehicle_Theft            := IF(Is_Motor_Vehicle_Theft(poffense)='Y',                bit_Shoplifting |                    hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_Motor_Vehicle_Theft)           ,bit_Shoplifting);
bit_Pornography                    := IF(Is_Pornography(poffense)='Y',                        bit_Motor_Vehicle_Theft |            hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_Pornography)                   ,bit_Motor_Vehicle_Theft);
bit_Prostitution                   := IF(Is_Prostitution(poffense)='Y',                       bit_Pornography |                    hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_Prostitution)                  ,bit_Pornography);
bit_Robbery_res                    := IF(Is_Robbery_res(poffense)='Y',                        bit_Prostitution |                   hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_Robbery_res)                   ,bit_Prostitution);
bit_Robbery_comm                   := IF(Is_Robbery_comm(poffense)='Y',                       bit_Robbery_res |                    hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_Robbery_comm)                  ,bit_Robbery_res);
bit_SexOffensesForcible            := IF(Is_SexOffensesForcible(poffense)='Y',                bit_Robbery_comm |                   hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_SexOffensesForcible)           ,bit_Robbery_comm);
bit_SexOffensesNon_forcible        := IF(Is_SexOffensesNon_forcible(poffense)='Y',            bit_SexOffensesForcible |            hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_SexOffensesNon_forcible)       ,bit_SexOffensesForcible);
bit_Stolen_Property_Offenses_Fence := IF(Is_Stolen_Property_Offenses_Fence(poffense)='Y',     bit_SexOffensesNon_forcible |        hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_Stolen_Property_Offenses_Fence),bit_SexOffensesNon_forcible);
bit_Weapon_Law_Violations		       := IF(Is_Weapon_Law_Violations(poffense)='Y',              bit_Stolen_Property_Offenses_Fence | hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_Weapon_Law_Violations)         ,bit_Stolen_Property_Offenses_Fence);
bit_Identity_Theft	               := IF(Is_Identity_Theft(poffense)='Y',                     bit_Weapon_Law_Violations |          hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_Identity_Theft)                ,bit_Weapon_Law_Violations);
bit_Computer_Crimes                := IF(Is_Computer_Crimes(poffense)='Y',                    bit_Identity_Theft |                 hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_Computer_Crimes)               ,bit_Identity_Theft);
bit_Terrorist_Threats              := IF(Is_Terrorist_Threats(poffense)='Y',                  bit_Computer_Crimes |                hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_Terrorist_Threats)             ,bit_Computer_Crimes);
bit_Restraining_Order_Violations   := IF(Is_Restraining_Order_Violations(poffense)='Y',       bit_Terrorist_Threats |              hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_Restraining_Order_Violations)  ,bit_Terrorist_Threats);
bit_traffic                        := IF(Is_traffic(poffense)='Y',                            bit_Restraining_Order_Violations |   hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_traffic)                       ,bit_Restraining_Order_Violations);
bit_BadChecks                      := IF(Is_BadChecks(poffense)='Y',                          bit_traffic |                        hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_BadChecks)                     ,bit_traffic);
bit_CurfewLoiteringVagrancyVio     := IF(Is_CurfewLoiteringVagrancyVio(poffense)='Y',         bit_BadChecks |                      hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_CurfewLoiteringVagrancyVio)    ,bit_BadChecks);
bit_DisorderlyConduct              := IF(Is_DisorderlyConduct(poffense)='Y',                  bit_CurfewLoiteringVagrancyVio |     hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_DisorderlyConduct)             ,bit_CurfewLoiteringVagrancyVio);
bit_DrivingUndertheInfluence       := IF(Is_DrivingUndertheInfluence(poffense)='Y',           bit_DisorderlyConduct |              hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_DrivingUndertheInfluence)      ,bit_DisorderlyConduct); 
bit_Drunkenness                    := IF(Is_Drunkenness(poffense)='Y',                        bit_DrivingUndertheInfluence |       hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_Drunkenness)                   ,bit_DrivingUndertheInfluence);
bit_FamilyOffenses                 := IF(Is_FamilyOffenses(poffense)='Y',                     bit_Drunkenness |                    hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_FamilyOffenses)                ,bit_Drunkenness);  
bit_LiquorLawViolations            := IF(Is_LiquorLawViolations(poffense)='Y',                bit_FamilyOffenses |                 hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_LiquorLawViolations)           ,bit_FamilyOffenses); 
bit_TrespassofRealProperty         := IF(Is_TrespassofRealProperty(poffense)='Y',             bit_LiquorLawViolations |            hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_TrespassofRealProperty)        ,bit_LiquorLawViolations); 
bit_PeepingTom                     := IF(Is_PeepingTom(poffense)='Y',                         bit_TrespassofRealProperty|          hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_PeepingTom)                    ,bit_TrespassofRealProperty);
bit_HumanTrafficking               := IF(Is_HumanTrafficking(poffense)='Y',                   bit_PeepingTom|                      hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_Human_Trafficking)             ,bit_PeepingTom);
bit_Other                          := IF(Is_Other(poffense)='Y',                              bit_HumanTrafficking|                hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_Other)                         ,bit_HumanTrafficking);
bit_Unclassified                   := IF(Is_Unclassified(poffense)='Y',                       bit_Other|                           hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_Unclassified)                  ,bit_Other);
return bit_Unclassified;                                                                                                                                                                                                                                       
end;

export Is_not_selected(string poffense) := function

  Is_it := IF(
            Is_Arson(poffense)='Y' OR                        
						Is_Assault_aggr(poffense)='Y' OR                      
						Is_Assault_other(poffense)='Y' OR                      
						Is_Bribery(poffense)='Y' OR					
						Is_Burglary_BreakAndEnter_res(poffense)='Y' OR
						Is_Burglary_BreakAndEnter_comm(poffense)='Y' OR
						Is_Burglary_BreakAndEnter_veh(poffense)='Y' OR
						Is_Counterfeiting_Forgery(poffense)='Y' OR       
						Is_Destruction_Damage_Vandalism(poffense)='Y' OR 
						Is_Drug_Narcotic(poffense)='Y' OR                
						// Is_Embezzlement(poffense)='Y' OR                 
						// Is_Extortion_Blackmail(poffense)='Y' OR						
						Is_Fraud(poffense)='Y' OR                        
						Is_Gambling(poffense)='Y' OR                     
						Is_Homicide(poffense)='Y' OR                     
						Is_Kidnapping_Abduction(poffense)='Y' OR   
						Is_Motor_Vehicle_Theft(poffense)='Y' OR 
						Is_Theft(poffense)='Y' OR 
						Is_Shoplifting(poffense)='Y' OR 	
						Is_Pornography(poffense)='Y' OR                  
						Is_Prostitution(poffense)='Y' OR                 
						Is_Robbery_res(poffense)='Y' OR                      
						Is_Robbery_comm(poffense)='Y' OR                      
						Is_SexOffensesForcible(poffense)='Y' OR          
						Is_SexOffensesNon_forcible(poffense)='Y' OR      
						Is_Stolen_Property_Offenses_Fence(poffense)='Y' OR						
						Is_Weapon_Law_Violations(poffense)='Y' OR        
						Is_Identity_Theft(poffense)='Y' OR               
						Is_Computer_Crimes(poffense)='Y' OR 
						Is_Terrorist_Threats(poffense)='Y' OR    						
						Is_Restraining_Order_Violations(poffense)='Y' OR 						
						Is_traffic(poffense)='Y' OR                      
						Is_BadChecks(poffense)='Y' OR     						
						Is_CurfewLoiteringVagrancyVio(poffense)='Y' OR 						
						Is_DisorderlyConduct(poffense)='Y' OR            
						Is_DrivingUndertheInfluence(poffense)='Y' OR     
						Is_Drunkenness(poffense)='Y' OR						
						Is_FamilyOffenses(poffense)='Y' OR     
						Is_LiquorLawViolations(poffense)='Y' OR          
						Is_TrespassofRealProperty(poffense)='Y' OR       
						Is_PeepingTom(poffense)='Y' OR      
						Is_HumanTrafficking(poffense)='Y',                'N', 
							 'Y');
return Is_it;

end;

end;

