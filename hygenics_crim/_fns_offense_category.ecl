EXPORT _fns_offense_category := module
   
export In_Global_Exclude (string poffense_in,string pcategory ) := function 


special_characters := '~|=|!|-|%|\\^|\\+|:|\\(|\\)|,|;|_|#|%|@|\\*|<|>|"|`|\\[|]|\\{|\\}|\\\\|\\\'';
poffense           := ' '+REGEXREPLACE(special_characters, poffense_in, ' ');
vio_set            := '[/\\. ]VIO[LATIONG]*[/\\. ]|[/\\. ]VIO[LATED]*[/\\. ]|VIOLATION';
   Is_it := MAP(
REGEXFIND('[/\\. ]CONSP[SIRACY\\.]*[/\\.  ]|CONSPIERACY|CONS[I]*PIRACY|CONSPRI[ER]+|CONSPRRE|CONSPIE[R]* TO'     ,poffense)   => 'Y',

REGEXFIND('WARRANT|BENCH WRT |LITTER|ACCOMPLIC|COMPLIC|APPEAL|WAOJ|GUTTER|CAPAIS|CAPIAS|ACCESRY|FOJ OTHER|CONSPIR|CONTEMPT|^[ ]*MTP[/ ]|^[ \\*]*MTR[\\*/ ]+|^[ ]*MTRP[/ ]' ,poffense)    => 'Y',
							 
stringlib.stringfind(poffense,'ARR'    ,1) <> 0 and 
stringlib.stringfind(poffense,'DATA'   ,1) <> 0 and 
stringlib.stringfind(poffense,'NOT'    ,1) <> 0 and 
stringlib.stringfind(poffense,'REC'    ,1) <> 0 => 'Y',

REGEXFIND(' CMTP| CNMTP| CNTMPT| BWP | BW[/ ]|VOP|V\\.O\\.P| V/P[/ ]|AID(.*)ABET| BW[I]* | V[ ]*O[ ]*C[ ]*C[/ ]| [SW]*VCC[/ ]| VOC[R]*[/ ]' ,poffense)    => 'Y', 
REGEXFIND('[/ ]VOCC[/ ]|[/ ][SW]*VCC[/ ]|[/ ]VOC[R]*[/ ]' ,poffense)  => 'Y', 
							            
REGEXFIND(' F\\.T\\.A|[/\\. ]FTA[/\\. ]' ,poffense) => 'Y',
							 
stringlib.stringfind(poffense,'AID'   ,1) <> 0     and
stringlib.stringfind(poffense,'ABET'  ,1) <> 0     and
REGEXFIND('ELIZABETH|BETH|LABET|HABET',poffense) => 'Y' ,		
							 
stringlib.stringfind(poffense,'MOTION',1) <> 0  and 
stringlib.stringfind(poffense,'TO'    ,1) <> 0  => 'Y',
                    
stringlib.stringfind(poffense,'FAIL'  ,1) <> 0  and
stringlib.stringfind(poffense,'TO'    ,1) <> 0  and
stringlib.stringfind(poffense,'APPEAR',1) <> 0  => 'Y' ,	
                  
stringlib.stringfind(poffense,'VIO'   ,1) <> 0  and
stringlib.stringfind(poffense,'RELEAS',1) <> 0  => 'Y' ,	
                            
stringlib.stringfind(poffense,'COURT' ,1) <> 0  and
stringlib.stringfind(poffense,'ORD'   ,1) <> 0  => 'Y' ,

REGEXFIND(vio_set+'|REV|RVK[D]*|REVO[CK]*|DISOBE'   ,poffense)   and 
REGEXFIND('COURT|[/\\. ]CRT[/\\. ]|[/\\. ]CT[/\\. ]',poffense)   and 
REGEXFIND('ORD'                                     ,poffense)   => 'Y',	

/*******************************************************************************/ 
//We want to use the same rule for all categories 
// pcategory IN ['ASSAULT','TERROR'] and 
REGEXFIND('PAROL|PROB|BOND|BND|PTR'               ,poffense)   and 
REGEXFIND(vio_set+'|REV|RVK[D]*|REVO[CK]*'        ,poffense)   => 'Y',	

// pcategory NOT IN ['ASSAULT','TERROR'] and
// REGEXFIND('PAROL|PROB|ROR|BOND|BND|PTR'           ,poffense)   and 
// REGEXFIND(vio_set+'|REV|RVK[D]*|REVO[CK]*'        ,poffense)   and
// REGEXFIND('TERROR'                                ,poffense,0) =  '' => 'Y',	
/**********************************************************************************/

stringlib.stringfind(poffense,'SHOW'              ,1) <> 0     and
REGEXFIND('CAUSE|NO |FAIL'                        ,poffense)   and
~REGEXFIND(' DL | ID | CDL | OL |INSURANCE|DRIVER LICENSE|DRIV LIC| REG[ISTRATION]* '  ,poffense)   	=> 'Y', 

stringlib.stringfind(poffense,'SOR ' ,1) <> 0 and    
stringlib.stringfind(poffense,'REV'  ,1) <> 0 => 'Y',

REGEXFIND(vio_set+'|REV|RVK[D]*|REVO[CK]*'        ,poffense)   and 
stringlib.stringfind(poffense,'PRE'   ,1) <> 0 and    
stringlib.stringfind(poffense,'TRIAL' ,1) <> 0 => 'Y',

REGEXFIND(vio_set+'|REV|RVK[D]*|REVO[CK]*|DISOBE' ,poffense)   and 
stringlib.stringfind(poffense,'SUSP' ,1) <> 0 and 
stringlib.stringfind(poffense,'SENT' ,1) <> 0 => 'Y',	

REGEXFIND(vio_set+'|REV|RVK[D]*|REVO[CK]*|DISOBE' ,poffense)   and 
stringlib.stringfind(poffense,'COND' ,1) <> 0 and    
stringlib.stringfind(poffense,'REL'  ,1) <> 0 => 'Y',
//Roger's comment on 7/27/16 QA review Global Expression Round 2
stringlib.stringfind(poffense,'ABETTING' ,1) <> 0 and
REGEXFIND('TURKEY|WILD ANIM|BEAR| DICE|FIREWORKS' ,poffense)    => 'Y',	

//Roger's comment QA review Global Expression Round 3 8/26/16
stringlib.stringfind(poffense,'WRIT'   ,1) <> 0 and 
stringlib.stringfind(poffense,'ATTACH' ,1) <> 0 and 
REGEXFIND('BOD|OF'                                ,poffense)   => 'Y',	

REGEXFIND('V\\-O\\-P|AID & ABEDDING|OUT OF CO WRNT|WRIT OF HABEAS CORUPS',poffense)   => 'Y', 

//Roger's comment QA review Global Expression Round 4 9/23/16
REGEXFIND('BE AN ACCESSORY|A[C]+ESS[ORY]* AFTER [THE ]*FACT ',poffense)   => 'Y',	

REGEXFIND('ACCESSORY TO|ACCESSORY AFTER'					 ,poffense)   and
REGEXFIND('MURDER|HOMICIDE|SHOOT'                 ,poffense)   => 'Y',	

REGEXFIND('V O P[\\-| ]'													 ,poffense)   => 'Y',	

REGEXFIND(' TURKEY[$| ]|WILD ANIM| BEAR[$| ]' 		 ,poffense)   => 'Y',	

stringlib.stringfind(poffense,'BOND ' ,1) <> 0                 and 
REGEXFIND('APPL[I|/| ]'                           ,poffense)   => 'Y',	
//QA Update - Global Expression   Round 5  10/11/16
REGEXFIND('VIO[L]?\\.|VIOL |REVOKE|REV '	 	       ,poffense)   and
REGEXFIND('ROR '                                  ,poffense)   => 'Y',	

REGEXFIND('RVK[ |D]'	 	                           ,poffense)   and
stringlib.stringfind(poffense,' PTR ' ,1) <> 0                 => 'Y',	

//QA terrorist Threats  Round 5 10/14/16 Add INTERROG to global expression

REGEXFIND('ACCESORY [\\-]* MURDER|ACCESSORY AFT[ER]* THE FAC|ACCESSORY BEFORE [THE ]*FACT|' +
          'ACCESSORY [ATT ]*MURDER|ACCESSORY FELONY|INTERROG|ANS[W]*[\\.| ]INTERR',poffense)   => 'Y',	
//QA Update - Global Expression Round 6
REGEXFIND('WRIT [OF ]*HABEAS CORPUS|HOLD FOR ANOTHER AGENCY|ZONING VIO|ZONING COMPLAINTS|' +
          'ZONING[/\\. ](.*) PERMIT[S]*|F/T PAY FINE[S]*|PETITION FOR|PETITION TO',poffense)   => 'Y',	

REGEXFIND('ACCESSORY|ACCOMPLICE|CONSPIRE|CONSPIRACY'          ,poffense)   and
REGEXFIND('ARSON|BRIBE|BURGLARY|FORGE|FRAUD|KIDNAP|ABDUCT|ROBBERY|ASSAULT|A&B|ASSLT|A\\.B\\.W\\.I\\.K|'+
          'ABDGR|ASSLT|WOUNDING|AGG BATTERY|ABWIK|CHILD ABUSE',poffense)   => 'Y',
					
stringlib.stringfind(poffense,'FAIL'                          ,1) <> 0           and 
stringlib.stringfind(poffense,'OFFEND'                        ,1) <> 0           and
REGEXFIND('CAREER|GUN'                                        ,poffense,0) <> '' and
REGEXFIND('REG|COMPLY|REPORT|CHANGE'                          ,poffense,0) <> '' => 'Y',

'N');

return Is_it;							 
end; 

//-------------------------------------------------------------------------------------------------------------------------------------
export Is_Arson(string poffense_in) := function

special_characters    := '~|=|!|-|%|\\^|\\+|:|\\(|\\)|,|;|_|#|%|\\*|<|>|"|`|\\[|]|\\{|\\}|\\\\|\\\'';
poffense        := ' '+REGEXREPLACE(special_characters, poffense_in, ' ');

Arson            := 'ARS0N|ARSON';
Arson_exc        := 'LARS[0O]N|CARS[0O]N|PEARS[0O]N|PARS[0O]N|PARS[0O]NS|OSBURN|BURNET';

Is_it := MAP( //In_Global_Exclude(poffense,'other')='Y' => 'N',
	             
//trim(poffense) in _fmod_offense_category_list.ArsonList =>'Y',
stringlib.stringfind(poffense,'BURN'   ,1) <> 0 and    
stringlib.stringfind(poffense,'CERTAIN',1) <> 0 and    
stringlib.stringfind(poffense,'BUILD'  ,1) <> 0 and    
~REGEXFIND('BURNETT|OSBURN|BURNET'     ,poffense)=> 'Y',
             
stringlib.stringfind(poffense,'BURN'  ,1) <> 0   and 
REGEXFIND('ARSON|MAL|WI[L]+FUL|FRAUD' ,poffense) and
~REGEXFIND('BURNETT|OSBURN|BURNET'    ,poffense) => 'Y',	
       
REGEXFIND(Arson                       ,poffense) and
~REGEXFIND(Arson_exc                  ,poffense) => 'Y',	 

(stringlib.stringfind(poffense,'SET'  ,1) <> 0   or stringlib.stringfind(poffense,'SETTING'  ,1) <> 0 ) and
stringlib.stringfind(poffense,'FIRE'  ,1) <> 0   and 
REGEXFIND('PROP|PROPERTY|LAND|WOODS'  ,poffense) => 'Y',              

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
	
Is_it := MAP(//In_Global_Exclude(poffense,'other')='Y' => 'N',
	             
REGEXFIND('ARM|ATT|PERSON|INTENT'    ,poffense)   and
stringlib.stringfind(poffense,'ROB'   ,1) <> 0    and 
~REGEXFIND(Robbery_exc               ,poffense)   and
~REGEXFIND(comm                      ,poffense)   => 'Y',

REGEXFIND(Robbery                    ,poffense)   and 
~REGEXFIND(Robbery_exc               ,poffense)   and 
~REGEXFIND(comm                      ,poffense)   => 'Y',

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


Is_it := MAP(//In_Global_Exclude(poffense,'other')='Y' => 'N',
	
REGEXFIND('ARM|ATT|PERSON|INTENT'    ,poffense)   and
stringlib.stringfind(poffense,'ROB'   ,1) <> 0    and 
REGEXFIND(comm                       ,poffense)   and
~REGEXFIND(exclusion                 ,poffense)  => 'Y',

REGEXFIND(Robbery                    ,poffense)   and 
REGEXFIND(comm                       ,poffense)   and
~REGEXFIND(exclusion                 ,poffense)  => 'Y',	 
              
'N');
return Is_it;
end;
//--------------------------------------------------------------------------------------------------------------------------------------
export Is_Homicide(string poffense_in) := function

special_characters:= '~|=|!|-|%|\\^|\\+|:|\\(|\\)|,|;|_|#|%|\\*|<|>|"|`|\\[|]|\\{|\\}|\\\\|\\\'';
poffense          := ' '+REGEXREPLACE(special_characters, poffense_in, ' ');

Homicide1        := 'HOM[IO]C[IDE]*|MURDER|M[A]*NSL[AU]*G[HTER]*|AWDWIKISI|AWDWI[TS]|AWDW[/ ]| AA[/]DW |DEATH BY AUTO|HIOMICIDE|MNS[IL]GHT[E]*R|'+
                    'KILL POLICE|SHOOT.*POLICE|PC 246\\.3|PC 246 |PC 664[/]211 |PC 664[/]187 A |PC 187 A |PC 192 C ';

Homicide2a       := 'KILL|DEATH|ADMINISTER|WILFUL';
Homicide2b       := 'INTENT|CAUSE|RESULT|POISON|MURDER|HOMICIDE';

Homicide_exc     := 'ALLIG$|ALLIGATOR|ANI[N]?MAL|ANIM$| ANTE$|ANTERLESS| BEAR|BIRD|CALF| CAT[TLE]|COW|DEER|[ |\\/|\\.]DOG[\\/|S| |$]| DOVE|DUCK| FOWL|GEESE|HORSE|MOOSE| OWL|PHEASANT|POULTRY|SPECIE[S|$]|TURKE[R]?Y|WATER[F]?OWL|WILDLIFE|WILD ANIM|[ |/]FISH';

Ha               := 'ATMUR|A TO MUR|A[/]MUR |AG MUR|AT MUR|AT[/]MUR|MUR[/ ]2N|MUR 2ND|MUR[/ ]REIN|MUR W[/]MAL|MUR WO|MUR W/O REIN|MUR WITH MALICE|'+
                    'MUR WM|MUR[/ ]W[/]*O[/ ]MAL|MUR WOM|ACC[/]MUR|MUR[/]HAB|MUR[/ ]MAL|MUR[/]MOTOR|MUR[/]PO|MUR[/]W[/]M|MUR[/]W[/]MAL|MUR[/]WO'; 

  Is_it := MAP(//In_Global_Exclude(poffense,'other')='Y' => 'N',

							 
//Roger's comment - QA Update - Homicide Round 3 8/26
stringlib.stringfind(poffense,'KILL'                 ,1) <> 0    and 
stringlib.stringfind(poffense,'INTENT'               ,1) <> 0    and 
REGEXFIND('[ |N]W[/]?O[UT]* |WO/|W/OINT|WITHOUT' 	   ,poffense)  AND
stringlib.stringfind(poffense,'WITH INTENT TO KILL'  ,1) = 0    => 'N',

//Roger's comment - QA Update - Global Expression Round 3 8/26
REGEXFIND('[ACCESSORY|ACESSORY] AFTER THE FACT|BE AN ACCESSORY',poffense)   => 'N',

//Roger's comment - QA Update - Assault Other Round 5 10/17/16
stringlib.stringfind(poffense,'THREATEN'            ,1) <> 0 and 
stringlib.stringfind(poffense,'ACT OF VIOLENCE'     ,1) <> 0 => 'N',

REGEXFIND('MNSLGH|INVLMNSLGH|M[A]*NSL |MANSLA|MNSLAU|MNSL[H]*TR|MANSLT[E]*R|MNSLTLTR|MNSLA[U]*GHTER|MANSALUGHTER|MANSLAUTER|MANSLTER\\.' ,poffense)   => 'Y',

REGEXFIND(Ha ,poffense)   => 'Y',

(REGEXFIND('ATT KILL|ATT TO KILL|KILL[/]ATT'       ,poffense)   or
  (REGEXFIND('ATT[E]*MP|ATTM[P]*T|ATTPT|^[ ]*ATT[\\. ]| ATT ',poffense)   and REGEXFIND('KILL'       ,poffense)   )
) and
REGEXFIND('ANIM|BEAR|ANTLERL|ANTE|LIVESTOCK|ALLIGATOR|HAWK|CHICKEN|SPOTLIGHT|SPTLIHT|SPOT|SPLIT|W/SP| DEER' ,poffense,0) = '' 
=> 'Y',

stringlib.stringfind(poffense,'SHOOT'                    ,1) <> 0 and 
REGEXFIND('THROW|DEADLY'                                 ,poffense)   and
REGEXFIND('MIS[SI]*LE|MALIC'                             ,poffense)   => 'Y',

stringlib.stringfind(poffense,'HOMI'                     ,1) <> 0 and 
REGEXFIND('CRIM|NEG|VE[C]*H|AGG|ATT'                     ,poffense)   => 'Y',

stringlib.stringfind(poffense,'POISON'                   ,1) <> 0 and 
REGEXFIND('LIQUOR|FOOD|WATER|ATTEMPT|MEDICINE| WELL[S]* ',poffense)   => 'Y',

REGEXFIND('W[/]?I[NTENT]? [TO ]?[/]?KILL|W[/]?I TO KILL',poffense)   and
stringlib.stringfind(poffense,'PISTOL'                  ,1) <> 0 => 'Y',
      
stringlib.stringfind(poffense,'MUR'                     ,1) <> 0  and 
REGEXFIND('CAP|COM|CRIM|INTENT'                         ,poffense) and
stringlib.stringfind(poffense,'DEAD'                    ,1) <> 0 => 'Y',
      
REGEXFIND('MANSL|MNSLAU'                                ,poffense) and
stringlib.stringfind(poffense,'DEAD'                    ,1) <> 0 => 'Y',
                                                         
stringlib.stringfind(poffense,'MUR'                  ,1) <> 0                and 
REGEXFIND('ATT|CRIM|PREMED|PREM|DEG|CAP|AGG|COM|FEL' ,poffense)   and
~REGEXFIND('MURDOCK|MURPHY|MURROW|MURRAY'            ,poffense)   => 'Y',

//Roger's comment QA Update - Homicide Round 4 9/23/16
REGEXFIND('KILL[ |I]'                           ,poffense)   and 
REGEXFIND('STAB[ |B]'                           ,poffense)   => 'Y',

stringlib.stringfind(poffense,'CHILD'           ,1) <> 0  and 
stringlib.stringfind(poffense,'KILL'            ,1) <> 0  and 
stringlib.stringfind(poffense,'UNBORN'          ,1) <> 0  => 'Y',

stringlib.stringfind(poffense,'DEATH'           ,1) <> 0 and
( stringlib.stringfind(poffense,'BY'            ,1) <> 0 or 
 (stringlib.stringfind(poffense,'CRIM'          ,1) <> 0 and stringlib.stringfind(poffense,'OPER'   ,1) <> 0)
)	 and
REGEXFIND('VE[C]*H'                             ,poffense)   => 'Y',

stringlib.stringfind(poffense,'POISON'          ,1) <> 0  and 
stringlib.stringfind(poffense,'INTENT'          ,1) <> 0  and 
stringlib.stringfind(poffense,'INTENT TO DIST'  ,1) = 0   => 'Y',
 
stringlib.stringfind(poffense,'MURD'            ,1) <> 0 and 
stringlib.stringfind(poffense,'MURDOCK'         ,1)  = 0 and
~REGEXFIND(Homicide_exc                         ,poffense)    => 'Y',

REGEXFIND('SHOOT[ING ]+' 						            ,poffense)   and //VC 20170519 email
REGEXFIND('MALIC[IOUS ]+' 									    ,poffense)   and
~REGEXFIND(Homicide_exc                         ,poffense)   => 'Y',

//QA Update - Homicide/Weapons round 6
REGEXFIND('FIRE|FIRING|PROPULSION|PROPEL' 			,poffense)   and
REGEXFIND('MISSIL[E]?[S]?|MILLILES' 						,poffense)   and
REGEXFIND('VEH[ICLE]?[S]?|DWELL|BUILD[ING]?|AIRCRAFT',poffense)   and
~REGEXFIND(Homicide_exc                         ,poffense)   => 'Y',

stringlib.stringfind(poffense,'DSCHG'           ,1) <> 0 and 
REGEXFIND(' F/A |FIREARM|WEAPON|WEAP|WPN ' 			,poffense)   and
REGEXFIND('BUILDING|BLDG| BLD |DWELL'           ,poffense)   => 'Y', 

REGEXFIND(Homicide1                             ,poffense)   and
~REGEXFIND(Homicide_exc                         ,poffense)   => 'Y',

REGEXFIND(Homicide2a                            ,poffense)   and
REGEXFIND(Homicide2b                            ,poffense)   and 
(~REGEXFIND(Homicide_exc                        ,poffense)  and
 ~(REGEXFIND('ALCOH|DRUG|NARC' ,poffense)   AND REGEXFIND('VE[C]*H|[/\\. ]M[/]*V[/\\.]|AUTO|INFLU' ,poffense)  )
)=> 'Y',

REGEXFIND('FORCE|[/\\. ]ADW[/\\. ]'             ,poffense)   and 
REGEXFIND('NOT.*FIREA'                          ,poffense)   => 'Y',	
								
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
															 'BOATING UND/INFLU|DRIV[E]*[ING]* U[/]I|DRIV[E]*[ING]* UTI|DWIOVER|' +
                               '[ ]DWUIL[/ ]|[ ][0O][\\.]*V[\\.]*I[\\./ ]| OMVI[/\\. ]|MV UNDER INFL ALC|[/ \\.]DUIL[/ \\.]|[/ \\.]DUID[/ \\.]|'+
                               '[/ \\.]DWAI| D\\.[U]\\.I|[/ ]D[/ \\.]*U[/ \\.]*I[I/\\. ]*[/ ]+| D[ ][U][ ]I | OMVUAC | O M V I |'+
															 '^[ ]*BUI[/ ]|DR(.*)V[I]*NG WHILE INTOX| D W I[0-9]|^ BREATH[/ ]|BREATHAL[IYERZ]+|BLOOD/BREATH|'+
															 'BLOOD[- ]+[\\.][0-9]+| W[/]*[\\. ]08[%]| W[/][\\. ]08[% ]|BLOOD SERUM|BLOOD ALCOHOL|[ ]*B[/\\.]*A[/\\.]*C[/\\.0-9 ]+|[ ]DUI[ ]|'+
															 '[\\.][810]+[%]BAC[&/ ]|[ ]APC[/ ]|[ ]A[\\.]P[\\.]C[\\. ]|[/\\.0-9 ]APC[VIMUF]* |'+
															 '316\\.193\\.[14]|316\\.1939 | 3161939 | 31619391 | 390801 | 4511\\.19 ';
															 
dwi                      := 	 '[ ]D[ ][UW][ ]I[ ]|^[ ]DWI[/ ]| D\\.[UW]\\.I|[/ ]D[/ \\.]*W[/ \\.]*I[/ \\.]*[)/ ]|D[W]I[/\\. ]|'+
                               'VC 23152 [AB] |VC 23153 [AB] |VC 23222 [AB] |VC 21200\\.5|VC 23140 [A] ';	

                                            
Dwiexc_list	             :=  'AWDWI|BALDWIN|DWIPER|HARDWIRE|SANDWICH|BOARDWITH|DWIGHT|CHADWICK|GOODWIN|GOODWILL|EDWIN|BANDWID|TO[B]+AC|TA[B]+AC|TOPBAC';															 
										 
DUIexc_list	             :=  'TO[B]+AC|TA[B]+AC|TOPBAC';														 
															 
Is_it := MAP(//In_Global_Exclude(poffense,'other')='Y' => 'N',


stringlib.stringfind(poffense,'BREATH'               ,1) <> 0 and
REGEXFIND(' DRUI |CONCENTRAT| PRELIM| O[VP]ER[\\./ ]| RTS | FTS |REF[ED]+ | REFED | RE[FS]+[UALSEFG]* | REUSE[D]*| RFSE |O[M]*VUAC| FAIL[/]| FAIL[LURED]* | TEST | RESULT[S]* | ALC[H]* |ALCO[HOL]* |SAMPLE|[ ][\\.][0-9]{2}[0-9 ]* | [0]*[\\.][ ]*1[0-9][% ]| PAC |[/ ]REFUS|[/ ]REF[/\\. ]'        ,poffense)   => 'Y',

stringlib.stringfind(poffense,'ALCO'  ,1) <> 0 and
REGEXFIND('MORE|GREATER'          ,poffense)   and
REGEXFIND(' OR | OF |THAN'        ,poffense)   => 'Y',
                                                        //check later   
REGEXFIND('[/ ]DR[\\.V ]|DRI[BCING]*[/ ]|DR[OI]V| DR[VING]* |DR[UV]+ING |[/ ]OP[\\.V ]|[/\\. ][O]+P[E]*R[RATINGEOD]*[/\\. ]|OPER[SA]T[IONG]+'    ,poffense)   and
REGEXFIND('WHILE|VE[C]*H|MOTOR'                              ,poffense)   and
REGEXFIND('[/\\. ]INTX[/\\. ]|INTOX|DRUG|[/\\. ]LIQ[/\\. ]|[/\\. ]OWI[/\\. ]'    ,poffense)   => 'Y',

REGEXFIND('C[O]*NSUMP'                  ,poffense)   and
REGEXFIND('VE[C]*H|MOTOR'               ,poffense)   and
REGEXFIND('INTOX|DRUG|[/\\. ]LIQ[/\\. ]',poffense)   => 'Y',

stringlib.stringfind(poffense,'DRK'  ,1) <> 0 and
REGEXFIND('[/\\. ]IN[/\\. ]|[/ ]OP[\\.V ]|[/\\. ][O]+P[E]*R[RATINGEOD]*[/\\. ]|OPER[SA]T[IONG]+'             ,poffense)   and
REGEXFIND('VE[C]*H|[/\\. ]MV[/\\. ]'              ,poffense)   => 'Y',

stringlib.stringfind(poffense,'CONTROL' ,1) <> 0     and
REGEXFIND('MOTOR |[/\\. ]MTR[/\\. ]'    ,poffense)   and
REGEXFIND('VE[C]*H'                     ,poffense)   and
stringlib.stringfind(poffense,'INTOX'   ,1) <> 0			  => 'Y',						 

REGEXFIND('ACTU[R]*A[LT]|[/\\. ]ACT[UAL]*[/\\. ]'             ,poffense)   and
REGEXFIND('PH[UYISLC]+CIAL|PH[UYISLC]+[SC]AL|PHYS|[/\\. ]PHY[/\\. ]|VE[C]*H|[ ]M[/]*V[ ]'  ,poffense)   and
REGEXFIND('CONTROL|[/\\. ]CTR[/\\. ]|C[N]*TRL|CONT[/ ]'       ,poffense)   => 'Y',

REGEXFIND('PH[UY]SICAL|[/\\. ]PHY[SICAL]*[/\\. ]'     ,poffense)   and
REGEXFIND('ALCOHOL CONTENT|ALCOHOL OVER|VE[C]*H|[ ]M[/]*V[ ]| CMV |[/\\. ]U/INFLU[ENCE ]+|IONFLU|IF[NLF]+UENCE|[I]*N[DCLF]+UENCE|I[ ]*N[LVF]+LU|INFL |[/ ]INF[L]*[/ ]'  ,poffense)   and
REGEXFIND('CONTROL|[/\\. ]CTR[/\\. ]|CNTRL|CONT[/ ]'  ,poffense)   => 'Y',						 
      
stringlib.stringfind(poffense,'PHYSICAL CONTROL' ,1) <> 0 and
REGEXFIND('ALCOHOL|INTOX|BREATH'                 ,poffense)   => 'Y',						 

stringlib.stringfind(poffense,'BOD'     ,1) <> 0     and
REGEXFIND('INJU[RY ]+|[/\\. ]INJ[/\\. ]',poffense)   and
REGEXFIND('DRI[VE ]|[/ ]OP[\\.V ]|[/\\. ][O]+P[E]*R[RATINGEOD]*[/\\. ]|OPER[SA]T[IONG]+'    ,poffense)   and
REGEXFIND('UNDER|U/INF'                 ,poffense)   => 'Y',      

REGEXFIND(' BA[/ ]| W[/]'               ,poffense)   and
REGEXFIND('[\\.]08[%]|[ ][/\\.]08[/% ]|[ ][\\.][ ]*10[% ]',poffense)   => 'Y',

REGEXFIND('BAC[O]*[/ ]'                 ,poffense)   and
REGEXFIND('[\\.]08[%]|[ ][/\\.][ ]*08[% ]|[\\.]10[%]|[\\.][ ]*10[%]|[ ][/\\.][ ]*10[% ]|[ ][0][\\.][ ]*08[% ]|[ ][0][\\.][ ]*10[% ]' ,poffense)   and
REGEXFIND('TOBAC'                       ,poffense,0) = '' => 'Y',

stringlib.stringfind(poffense,'REFUSE'  ,1) <> 0     and
stringlib.stringfind(poffense,'TEST'    ,1) <> 0     => 'Y',

stringlib.stringfind(poffense,'DWLS'    ,1) <> 0     and
REGEXFIND('[/\\. ]DUI[/\\. ]|[/\\. ]DWI[/\\. ]' ,poffense)   => 'Y', 

stringlib.stringfind(poffense,'DRUG'     ,1) <> 0           and
REGEXFIND('VE[C]*H|[ ]M[/]*V[ ]|BOAT'   ,poffense,0) <>  '' and
REGEXFIND(' OP |[/\\. ]APC[/\\. ]'      ,poffense)          => 'Y', 

//loose expression
REGEXFIND('[/ ]SKI[ING]*[/ ]|[/ ]DR[\\.V ]|DRI[BCING]*[/ ]|DR[OI]V| DR[VING]* |DR[UV]+ING |[/\\. ]DRIVE[/\\. ]|[/\\. ][O]+P[E]*R[RATINGEOD]*[/\\. ]|OPER[SA]T[IONG]+|BOAT|[/\\. ]OP[/\\. ]|OPERMOTOR' ,poffense,0) <>  '' and
REGEXFIND('UNDER(.*)INF|ALC[OHOL]*|WHILE(.*) INF(.*)[ ]*ALCOH|WHILE(.*) IMPAIRED(.*)[ ]*|WHILE LIQ[/\\. ]|INTOX|DR[IU]NK',poffense,0) <>  '' and
REGEXFIND('FIREA[R]*M|VISIBLY|LICENSE REVOKED'                                                  ,poffense,0) = ''=> 'Y', 
      
// Roger's comment - QA Updates Traffic
// Mis-spelling 
REGEXFIND('DRIVING |DRIV/|DRIV\\.|DRIV |DROVE |OPER VESSEL'                 ,poffense,0) <>  '' and
REGEXFIND('UDNER |U/|UNDR|UNDER21|UNER |UNTER |DURING '																				 ,poffense,0) <>  '' and
REGEXFIND('INFLUENCE'                                                  					,poffense,0) <>  '' => 'Y', 
                               
stringlib.stringfind(poffense,'OPEN CONT'     ,1) <> 0 and
REGEXFIND('D[/\\.]*U[/\\.]*I[/\\.]*|D[/ \\.]*W[/ \\.]*I[/ \\.]*|D [WU] I|DRIV(.*)UND(.*) INFL(.*)|DRIV(.*)INTOX'  ,poffense)   => 'Y',
      
REGEXFIND('DUI DRIV[EING]+'             ,poffense)   and
stringlib.stringfind(poffense,'WHILE'     ,1) <> 0   and
REGEXFIND('UNSER|UNJDER|INDER|UINDER'   ,poffense)   and
REGEXFIND('INFLU[E]*NCE|INFLUNC|INFLU'  ,poffense)   => 'Y',

stringlib.stringfind(poffense,'REFUSAL' ,1) <> 0 and
stringlib.stringfind(poffense,'SUBMIT'  ,1) <> 0 and
stringlib.stringfind(poffense,'TEST'    ,1) <> 0 => 'Y',
      
REGEXFIND(DrivingUndertheInfluence      ,poffense)   and
REGEXFIND(DUIexc_list                   ,poffense,0) =  '' => 'Y',	    

REGEXFIND(dwi                           ,poffense)   and
REGEXFIND(Dwiexc_list                   ,poffense,0) =  '' => 'Y',

stringlib.stringfind(poffense,'IGNITION'   ,1) <> 0  and
stringlib.stringfind(poffense,'INTERLOCK'  ,1) <> 0  and
REGEXFIND('[/\\. ]VIOL[ATION]*[/\\. ]|[/\\. ]TAMP[/\\. ]|TAMPER|[/\\. ]FAIL[/\\. ]|FAILING ' ,poffense,0) <>  '' => 'Y',

REGEXFIND('[/\\. ]OUI[/\\.]'            ,poffense)   and
REGEXFIND('[/\\.]LIQ[UOR]*[/\\.]|LIQUOR|[/\\.]VEH[ICLE]*[/\\. ]|VEHICLE|WATERCRAFT' ,poffense,0) <>  '' => 'Y',
                                           
		'N');

return Is_it;
end;

//--------------------------------------------------------------------------------------------------------------------------------------

export Is_Assault_aggr(string poffense_in) := function

special_characters    := '~|!|-|%|\\^|\\+|:|\\(|\\)|,|;|_|#|%|\\*|<|>|"|`|\\[|]|\\{|\\}|\\\\|\\\'';
poffense        := ' '+REGEXREPLACE(special_characters, poffense_in, ' ');

Assault         := 'AA/DW|AGG/ASS|ABDGR|ABGEN|ABOFF|ABHAN|ABWIK|ABWITK|STRANGUL|AWDW|STRANGLE|784\\.03\\.1A2|784\\.03\\.1A1|AA[/]DW[/]FV|AA[/]DW/|AA[/]SBI[/]DW[/]FV|784.021.1A|DDLY CONDUCT|'+
                   'PC 243 [BD] |PC 245 [AC] |FLEEING';
									 
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
exc             := 'GOAT|PUP| PET |PONY|CHOW |TORTIS|PIG|LLAMA|DUCK|FERRET|PARROT|CHIHUAHUAHOUND|SHEP|BIRDS|ROMULUS|KITTEN|ROTT[I]*|RO[T]+WEI|CANINE|LAB | TAB |L[I]*VST[OC]*K|NONLVST';									
	
aggravated_exc  := 'AGGRESSIVE|REVOC|SEX|KIDN|SODOMY|RAPE|PORN|MOLE|NO WPN|FALSE REPORT|FALSE REPT| FALSE ';	
  
Terrorist_Threats  := 'TERRORIST|TERROR[ISTM]*|W[EA]*P[ON]* MASS DES[RUCT]+';
Terrorist_ecl      := 'HARM|FALSE INFO|FALSE REPORT';

// Roger's comment - Round 8 Assault Other 20161114 File
TT2a := 'EXPLOSIV|BOMB|WEAP[ON]*|WPN|WEPON|MURD| GUN[ |/|$]|FIRE[ ]?ARM|F/ARM| ARMED|DESTRUCTIVE DEVICE';
TT2b := 'TERR';

Is_it := MAP( //In_Global_Exclude(poffense,'ASSAULT')='Y' => 'N',
														 
stringlib.stringfind(poffense,'CRUELTY'   ,1) <> 0   and
REGEXFIND('HORSE|ANIM|ANAIMAL|ANIAL|ANML|A[IMN]I+[MN]+[AL]*|CATS|PIT[ ]*BULL'        ,poffense)  => 'N',

REGEXFIND('BURG|UNARM|ANIMAL|DOG'        ,poffense)   => 'N', 

REGEXFIND('BATTER[YI]'                   ,poffense)   and 
stringlib.stringfind(poffense,'COVER'    ,1) <> 0     => 'N', 

//Roger's comment QA Update - Assault - Aggravated Round 4 9/23/16, 9/27/16
stringlib.stringfind(poffense,'REVOC'       ,1) <> 0  or
 (stringlib.stringfind(poffense,'PROBAT'    ,1) <> 0  AND REGEXFIND('H[O]?LD|VIO[L]?', poffense)  ) => 'N',
 
 (REGEXFIND('[\\. ]POSS[\\. ]|POSS[ESSION]+| CARRY' 																			,poffense)   OR
  REGEXFIND('ASSAULT WEAPON|ASSAULT FIREARM|ASLT WPN|INELEIGIBLE PERSON|CONVICTION|UNLAWFUL|PUBLIC PLACE', poffense)  ) and 
~REGEXFIND('AGGRAVATED| AGGR | AGG[RVATED ]+', poffense)  => 'N',

REGEXFIND('DEAD|DEATH'  			                     ,poffense)   and
REGEXFIND('CONDUCT|THREAT'		                     ,poffense)   and 
stringlib.stringfind(poffense,'DISORDERLY CONDUCT' ,1) = 0 => 'Y',

REGEXFIND(' MOB | RIOT '  		                 ,poffense)         and
stringlib.stringfind(poffense ,'ACTION'        ,1) <> 0 => 'Y',

REGEXFIND('THREAT|THRT'  		                   ,poffense)   and
REGEXFIND(TT2a  	 						                 ,poffense)   and 
REGEXFIND('FALSE REPORT|FALSE INFO|FALSE'      ,poffense,0) =  '' => 'Y',

//QA Update - Assault Aggravated Round 6
REGEXFIND('MALICIOUS[LY]*[LEY]*[ |/]WOUND|UNLAWFUL WOUNDING|AGGRAVATED MAL WOUND|WOUNDIN[/]UNLAW|UNLAW\\.WOUND[ING\\.]+|BRANDISH.*FIRE[ EARMN\\.]',poffense)   => 'Y',

REGEXFIND(aggravated_exc                       ,poffense,0) <>  '' OR
REGEXFIND(assault_exc                          ,poffense,0) <>  '' OR
REGEXFIND(exc                                  ,poffense,0) <>  '' => 'N',	

//Roger's comment 8/26 QA Updates for  Assault - Aggravated Round 3
REGEXFIND('CH[I]?LD'                           ,poffense)   and
REGEXFIND('ENDANGERMENT|ENDANGERING|ENDANGER ' ,poffense)   and
~REGEXFIND('AGG[\\.]? |AGG ASSLT|AGGRAVATED'	 ,poffense)   => 'N',

REGEXFIND('RECKLESS|RECK |1ST DEGREE'          ,poffense)   and
stringlib.stringfind(poffense ,'ENDANGER'      ,1) <> 0     => 'Y',
 
REGEXFIND('[/\\. ]WEAP|[/\\. ]WPN[/\\. ]|GUN[ |$]|KNIFE'  ,poffense)   and		
REGEXFIND('A[ ]*[\\&|/|AND][ ]*B|AS[S]*[A]*[U]*[L]*T[/|\\.|\\&| ]|AS[S]*LT |[ |'+
          '^]ASSA |AGG[RAVATED]* ASS|AGG [AALT|ALST]|SAULT |ASSAUTL |ASSUALT[\\/| ]'+
     			'| ASS[\\.|\\/]? '                              ,poffense)   and
~REGEXFIND('BRASS|[CG]LASS| A BUS|TRESPASS'					  		,poffense)   => 'Y',		
							 
REGEXFIND(aggravated                                      ,poffense)   and
REGEXFIND('CH[I]*LD|M[IO]NOR|JUV'                         ,poffense)   and 
REGEXFIND('[/\\. ]ABU[/\\. ]|[/\\. ]AB[/\\. ]|[/\\. ]ABUVE|RECK DRVG|[/\\. ]IA[/\\. ]|[/\\. ]CHLDB[/\\. ]|[/\\. ]A7B[/\\. ]|[/\\. ]ABS[/\\. ]',poffense)   and
~REGEXFIND(aggravated_exc                                 ,poffense)   => 'Y',

REGEXFIND(aggravated                                      ,poffense)   and
REGEXFIND('CH[I]*LD|M[IO]NOR|JUV'                         ,poffense)   and 
stringlib.stringfind(poffense ,'INJ'                      ,1) <> 0     => 'Y',

REGEXFIND('[/\\. ]HIV[/\\. ]'                             ,poffense)   and
REGEXFIND('TRANS|EXPO|INFECT|CONDUCT|RISK|[/\\. ]TRNS[/\\. ]|ENGAG|TEST|[/\\. ]EXP[/\\. ]|[/\\. ]CAUS[/\\. ]|HARM|VIO|KNOW|INFC|UNLAW|ANOTHER|DONAT|DISCLOS',poffense)   => 'Y',						 

//***terrorist threat
REGEXFIND(aggravated                      ,poffense)   and
REGEXFIND(TT2a                            ,poffense)   and
REGEXFIND(TT2b                            ,poffense)   and 
~REGEXFIND('FALSE REPORT|FALSE INFO|FALSE',poffense)   => 'Y',	                     
     
REGEXFIND(aggravated                      ,poffense)   and
REGEXFIND(Terrorist_Threats               ,poffense)   and
~REGEXFIND(Terrorist_ecl                  ,poffense)   => 'Y',	
 //***End terrorist threat

REGEXFIND('PLAC|PLCING|PLCE|TRANS|CONT|PROPEL|INGEST',poffense)   and   
REGEXFIND('BODILY|BODY|BOD'                          ,poffense)   and   
stringlib.stringfind(poffense ,'FLUID'               ,1) <> 0     =>'Y',

stringlib.stringfind(poffense ,'VIRUS'               ,1) <> 0     and
REGEXFIND('TRANS|EXPOS'       ,poffense)   => 'Y',

REGEXFIND(aggravated          ,poffense)   and
REGEXFIND('DOM'               ,poffense)   and 
REGEXFIND('A/B '              ,poffense)   => 'Y',

REGEXFIND(aggravated                    ,poffense)   and
REGEXFIND('BOD'                         ,poffense)   and 
REGEXFIND('INJU[RY ]+|[/\\. ]INJ[/\\. ]',poffense)   and
Is_DrivingUndertheInfluence(poffense)='N'            and
Is_Robbery_res(poffense)='N'       							           and 
Is_Robbery_comm(poffense)='N'                        => 'Y',

REGEXFIND(aggravated          ,poffense)   and
stringlib.stringfind(poffense ,'BATT'               ,1) <> 0     and
~(REGEXFIND('BATTLE|COVER|STORAGE|DISPOS|BATTON|BATTS',poffense) or
  (stringlib.stringfind(poffense ,'SHELT',1) <> 0 and stringlib.stringfind(poffense ,'BATTERED',1) <> 0 ) 
 )=> 'Y',

Is_homicide(poffense) ='N' AND							 
stringlib.stringfind(poffense ,'POISON'               ,1) <> 0 and
REGEXFIND('PET|ANI(MA)*(\\.)* |ANIMAL|REPT|SNAKE|SN |CAT|CONTROLLED SUBSTANCES',poffense,0) = '' => 'Y',

stringlib.stringfind(poffense ,'POISON'               ,1) <> 0 and
REGEXFIND('LIQUOR|FOOD|WATER|ATTEMPT|MEDICINE| WELL[S]* ',poffense)   => 'Y',

stringlib.stringfind(poffense ,'ARMED'             ,1) <> 0  and 
stringlib.stringfind(poffense ,'VIO'               ,1) <> 0  =>'Y',

stringlib.stringfind(poffense ,'HATE'              ,1) <> 0  and 
stringlib.stringfind(poffense ,'CRIM'              ,1) <> 0  => 'Y',

REGEXFIND(aggravated                  ,poffense)   and   
REGEXFIND('STALK|MENAC|THREAT|TREATEN',poffense)   and 
~REGEXFIND(aggravated_exc             ,poffense)   => 'Y', 


REGEXFIND(Assault3            ,poffense)   and 
REGEXFIND(aggravated          ,poffense)   and
((stringlib.stringfind(poffense ,'DRIVE',1) <> 0  AND stringlib.stringfind(poffense ,'UNDER',1) <> 0 and stringlib.stringfind(poffense ,'INFL',1) <> 0 ) OR
  REGEXFIND('[ ]D[\\. ]U[\\. ]I[\\. ]|^[ ]*D[\\. ]U[\\. ]I[\\. ]' ,poffense)   
 )=> 'Y',			

REGEXFIND(aggravated                     ,poffense)   and							 						 
stringlib.stringfind(poffense ,'PAIN'    ,1) <> 0     and
REGEXFIND('INDUC|CAUS|INFLICT|CRUEL'     ,poffense)   and 
REGEXFIND('PAINT|CHAMPAIN|SPAIN|ANIM|DOG',poffense,0) = '' => 'Y',			

REGEXFIND(aggravated               ,poffense)   and 
REGEXFIND('VE[C]*H'                    ,poffense)   and 
REGEXFIND(Assault3+'|INJURY'       ,poffense)   
=> 'Y',							 

REGEXFIND(Battery                  ,poffense)   and
REGEXFIND(aggravated               ,poffense)   => 'Y',		

REGEXFIND(aggravated               ,poffense)   and
REGEXFIND(Battery                  ,poffense)   and 
REGEXFIND('POL|PERSON|CH[I]*LD|DOM|L[/]*E[/]*O|L[\\.]E[\\.]' ,poffense)   and
REGEXFIND('SEX'                    ,poffense,0) = '' => 'Y', 
                                                                                                             
REGEXFIND(aggravated                ,poffense)   and               
REGEXFIND('ABUSE|[/\\. ]ABUS[/\\. ]',poffense)   and 
REGEXFIND('PERSON|ADULT|[/\\. ]ELD[ERLY]*[/\\. ]|[/\\. ]DIS[ABLED]*[/\\. ]'                  ,poffense)   and 
REGEXFIND('SEX|CARD'                ,poffense,0) =  '' => 'Y',
                                                                                                    
REGEXFIND(aggravated                ,poffense)   and                
REGEXFIND('ABUSE|[/\\. ]ABUS[/\\. ]',poffense)   and 
REGEXFIND('PATIENT|RESIDENT|ELDER|NEGL|CARETAKER|CARTAKER|CH[I]*L[D]*|DISABL|IMPAIR|VULNERABLE',poffense)   and
REGEXFIND('SEX|CARD'               ,poffense,0) =  '' => 'Y',

REGEXFIND(aggravated     ,poffense)   and 
REGEXFIND(Battery        ,poffense)    and 
REGEXFIND(aggravated_exc ,poffense,0) =  '' and 
REGEXFIND(exc            ,poffense,0) =  ''  => 'Y',

REGEXFIND(aggravated     ,poffense)   and 
REGEXFIND(Assault3       ,poffense)   and 
REGEXFIND(aggravated_exc ,poffense,0) =  '' and 
REGEXFIND(exc            ,poffense,0) =  '' => 'Y',	               

REGEXFIND(Assault        ,poffense)   and 
REGEXFIND(assault_exc    ,poffense,0) = '' and 
REGEXFIND(exc            ,poffense,0) =  ''   => 'Y',

REGEXFIND(Assault2       ,poffense)  and 
REGEXFIND(assault_exc    ,poffense,0) = '' and 
REGEXFIND(exc            ,poffense,0) =  ''   => 'Y',

(REGEXFIND(Battery       ,poffense)     or
REGEXFIND(Assault3       ,poffense)     or
REGEXFIND(Assault2       ,poffense)     or
REGEXFIND(Assault        ,poffense)   ) and 
REGEXFIND('FLUID|FIREARM',poffense)   => 'Y', 
							 						 
stringlib.stringfind(poffense,'SHOOT',1) <> 0     and    
REGEXFIND('WITH INTENT| W[/]INT '    ,poffense)   and 
REGEXFIND(' INJ[ URE]+'              ,poffense)   => 'Y',

stringlib.stringfind(poffense ,'MALTREAT' ,1) <> 0    and
stringlib.stringfind(poffense ,'ADULT'    ,1) <> 0    and
REGEXFIND(' VUL[\\. ]'                    ,poffense)  and 
stringlib.stringfind(poffense ,' HARM '   ,1) <> 0    => 'Y',

REGEXFIND(' RECK[\\. ]|RECKLESS'     ,poffense)   and 
stringlib.stringfind(poffense,'ENDNGRMNT',1) <> 0 => 'Y',

REGEXFIND(' CRIM[INAL ]+'            ,poffense)   and 
stringlib.stringfind(poffense,'ABUSE',1) <> 0     and 
REGEXFIND(' AGG[R]* |AGGRAVATED'     ,poffense)   => 'Y',

stringlib.stringfind(poffense,'ARREST',1) <> 0    and  
REGEXFIND('EVAD|RESIST'              ,poffense)   and 
REGEXFIND(' AGG[R]* |AGGRAVATED'     ,poffense)   => 'Y',			

stringlib.stringfind(poffense,'POLICE',1) <> 0    and  
REGEXFIND('MIAM |MIAMING|MALIC[/\\. ]|MALICIOUS'  ,poffense)   => 'Y',				

REGEXFIND('FORCE|[/\\. ]ADW[/\\. ]'   ,poffense)   and 
REGEXFIND('NOT.*FIREA'                ,poffense)   => 'Y',	

stringlib.stringfind(poffense,'BRANDISH'               ,1) <> 0     and
REGEXFIND('WEAP|WEAPON|WPN|FIREA[RM]*|[/\\. ]F[/]ARM'  ,poffense)   => 'Y',				

REGEXFIND('POLICE|[/\\. ]LEO[/\\. ]'     ,poffense)   and 
stringlib.stringfind(poffense,'MAIM'     ,1) <> 0     and 
REGEXFIND('WOUND|INJURY'                 ,poffense)   and 
REGEXFIND('MALICIOUS|[/\\. ]MALIC[/\\. ]',poffense)   => 'Y',

'N');
return Is_it;
end;
//--------------------------------------------------------------------------------------------------------------------------------------

export Is_Assault_other(string poffense_in) := function

special_characters    := '~|!|-|%|\\^|\\+|:|\\(|\\)|,|;|_|#|%|\\*|<|>|"|`|\\[|]|\\{|\\}|\\\\|\\\'';
poffense        := ' '+REGEXREPLACE(special_characters, poffense_in, ' ');

Assault         := 'SIMP BAT|ASS[AU]+L[T]*|AS[SL]*LT|CRUELTY|[D]*OMESTI(.*) ABUSE|INTIMIDAT|RETALIATION|STRIKING  PERSON|243(E)(1)PC|ACT IN AGGRESSIVE MANOR|FLEE';
Assault2        := '^[ ]*A[\\.& ]+B[\\.]* |^[ ]*A AND B |[ |^|\\.|/]A[ ]*&[ ]*B[ |\\.|$|/]|A[ ]*&[ ]*B$|'+
                   ' PC 242 | PC 422 |PC 653M A | PC 240 |PC 646\\.9 A |PC 273\\.5 A |PC 243 [CE] | PC 273D |PC 368 C |PC 368 B  1| 2919\\.25 | PC 148\\.9 A |'+
									 '316\\.072 3| 31619351 |784\\.03\\.1A1|784\\.05 1 |784\\.05 2 ';

Assault3        := 'ASSAUOLT|ASS[LAN]+UTL|ASSAUTING|ASSLAT|ASSLA[UL]+T|ASSAI[ ]T|ASSAILT |ASSA[OS]*U[I]*[KL]T |ASSAUSLT|AS[SL]*AU[LK]*T|ASSAUST |AS[S]+ULT |ASSAUT[L]*|AS[S]+AULT|ASSAU[/0-9\\.]|'+
                   '[/0-9\\. ]ASSL[/0-9\\. ]|[/0-9\\. ]ASSA[/0-9\\. ]|[/0-9\\. ]ASS[A]*U[A]*[/0-9\\. ]|ASSLT|[/0-9\\. ]ASLT[/0-9 ]|ASSAT |[/\\.]AS[L]+[/\\.]|'+
									          'ABDOM|ABGEN|ABOFF|BATTER|PHYS[ICAL\\.]+ HARM| A[&]B |^ A[/]B |[/\\. ]BTRY[/\\. ]';                                                           
                                                                                                                                                       
Battery         := '^[ ]*BATT[GERY/ ]+|BATTER| BAT |^[ ]*BAT | BAT$';
assault_exc     := 'SEX|RAPE|MOLEST|PORN|FOWL|GAME|PETS|LIVESTOCK|NOISE|GOOSE|FRUIT|ELECTRICAL|HIGHWAY|SHELTER|BOMB|FLEET';
                     										                                                                                                                      
exc             :=  'GOAT|PUP|ROBB| PET |PONY|CHOW |TORTIS|PIG|LLAMA|DUCK|FERRET|PARROT|CHIHUAHUAHOUND|SHEP|BIRDS|ROMULUS|KITTEN|ROTT[I]*|RO[T]+WEI|CANINE| LAB | TAB |L[I]*VST[OC]*K|NONLVST';
										  
aggravated      := 'AGG|AGGR[\\.]|AG[G]+R|AG[G]+RA[CV]ATED|AGGAVAT|AGG[TGV] |AGGVA|[/\\. ]FEL[/\\. ]|FELONY|FELONI[O]*US|DANGEROUS W|[/\\. ]W/DE[/\\. ]|MURD|WEAP|W[E]?P[O]?N/';                                                 

// Roger's comment - Round 8 Assault Other 20161114 File
aggravated_exc  :=  'REVOC|SEX|KIDN|SODOMY|RAPE|PORN|MOLE|WEAP[ON]?|WPN|WEPON|MURD| GUN[ |/|$]|FIRE[ ]?ARM|F/ARM| ARMED|DESTRUCTIVE DEVICE';		

Terrorist_Threats  := 'TERRORIST|TERROR[ISTM]*|W[EA]*P[ON]* MASS DES[RUCT]+';
Terrorist_ecl      := 'HARM[ $/\\-]|FALSE INFO|FALSE REPORT';

TT2a               := 'EXPLOSIVES|BOMB';
TT2b               := 'TERR';
                                                                     
Is_it := MAP(//In_Global_Exclude(poffense,'ASSAULT')='Y' => 'N',

REGEXFIND('CRUELTY'                                                           ,poffense)  and
REGEXFIND('HORSE|ANIM|ANAIMAL|ANIAL|ANML|A[IMN]I+[MN]+[AL]*|CATS|PIT[ ]*BULL' ,poffense)  => 'N',

REGEXFIND('PLAC|PLCING|PLCE|TRANS|CONT|PROPEL|INGEST',poffense)   and   
REGEXFIND('BODILY|BODY|BOD'                          ,poffense)   and   
stringlib.stringfind(poffense ,'FLUID'               ,1) <> 0     => 'N',

REGEXFIND('TERR THRT|TERR THREA|TERR ACTS'           ,poffense)   => 'N',
       
REGEXFIND(aggravated_exc                             ,poffense)   OR
REGEXFIND(assault_exc          	       	       	     ,poffense)   OR
REGEXFIND(exc          					      		      		         ,poffense)   => 'N',

Is_Assault_aggr(poffense)='Y'												=> 'N',

//Roger's comment - Update - Assault Other   Round 5 10/17/16 Added WITH INTENT TO KILL and HOMICIDE
REGEXFIND('BURG|UNARM|ANIMAL|DOG| INTENT [TO ]*KILL|HOMICIDE' ,poffense)   => 'N', 

//Roger's comment - Update - Assault Other   Round 6 
REGEXFIND('WI TO KILL|W/I[NT]* [TO ]*KILL|W/INTENT T/KILL|PISTOL' ,poffense)   => 'N', 

REGEXFIND('BATTER[YI]'            ,poffense)   and 
stringlib.stringfind(poffense ,'COVER',1) <> 0 => 'N', 

REGEXFIND(' DANG |DEADLY'         ,poffense)   and
REGEXFIND(' WEAP| WPN '           ,poffense)   => 'N',								 

//Roger's comment - QA Update - Assault Other Round 3 8/26/16, Round 4 9/29/16, 10/5/16
REGEXFIND('ENDANGERMENT|ENDANGER[ING]|CRUELTY' ,poffense) and  
stringlib.stringfind(poffense ,'CHILD'         ,1) <> 0   => 'N',

stringlib.stringfind(poffense ,'REVOC'         ,1) <> 0 or
(stringlib.stringfind(poffense,'PROBAT'        ,1) <> 0 and REGEXFIND('H[O]?LD|VIO[L]?|SANCTION', poffense)  ) => 'N',
             
REGEXFIND('THREAT[EN]*'					      ,poffense)   and 
REGEXFIND('BOMB|EXPLOSIV|SHOOT'   ,poffense)   => 'N', 

//QA Update - Assault Other Round 6
REGEXFIND(Terrorist_Threats       ,poffense)   and
REGEXFIND('INTENT TO HARM OTHER'  ,poffense)   => 'N',

stringlib.stringfind(poffense ,'TERROR',1) <> 0 and
stringlib.stringfind(poffense ,'ACT'   ,1) <> 0 => 'N',	

REGEXFIND(Terrorist_Threats       ,poffense)   and
~REGEXFIND(Terrorist_ecl          ,poffense)   => 'N',	
 //***End terrorist threat

//Roger comments - Traffic 20161114 File Round 8
REGEXFIND('LEAVING [THE ]*SCENE|LEAVE [THE ]*SCENE' ,poffense)   and
REGEXFIND(' CRASH| ACCIDENT'                        ,poffense)   => 'N',
 
stringlib.stringfind(poffense ,'DOM',1) <> 0  and
REGEXFIND('A[/]B '                  ,poffense)  => 'Y',

stringlib.stringfind(poffense ,'BOD' ,1) <> 0 and
stringlib.stringfind(poffense ,'INJU',1) <> 0 and
Is_DrivingUndertheInfluence(poffense)='N'     and
Is_Robbery_res(poffense)             ='N'     and 
Is_Robbery_comm(poffense)            ='N'     =>'Y',

stringlib.stringfind(poffense ,'BATT',1) <> 0 and
~(REGEXFIND('BATTLE|COVER|STORAGE|DISPOS|BATTON|BATTS',poffense)   OR
  (stringlib.stringfind(poffense ,'SHELT',1) <> 0 and stringlib.stringfind(poffense ,'BATTERED',1) <> 0 ) 
)=> 'Y',

REGEXFIND('SIM|U/S '             ,poffense)   and 
stringlib.stringfind(poffense ,'BATT',1) <> 0 => 'Y',	

REGEXFIND('SIMPLE'               ,poffense)   and 
(REGEXFIND(Assault3+'ASS[A]*UT'  ,poffense)   or 
 REGEXFIND(Battery               ,poffense)   )=> 'Y',

REGEXFIND('CHILD|MINOR|JUV|ELDER|DISABLED',poffense) and 
stringlib.stringfind(poffense ,'INJ'      ,1) <> 0   and 
~REGEXFIND('[/\\. ]CORP[/\\. ]|CORPORAL|CORPRAL'  ,poffense) => 'Y',							 

REGEXFIND('ASSA|ASSU|ASLT|ASSLT|BATT'      ,poffense)   and 
((REGEXFIND('DRIVE' ,poffense)   AND REGEXFIND('UNDER' ,poffense)   and REGEXFIND('INFL',poffense)   ) OR
  REGEXFIND(' D[\\. ]U[\\. ]I[\\. ]|^[ ]*D[\\. ]U[\\. ]I[\\. ]' ,poffense)   OR
  REGEXFIND('PROBAT[ION]* OFFICER' ,poffense)  
)=> 'Y',										 							 						 

REGEXFIND('VE[C]*H'                 ,poffense)   and 
(REGEXFIND(Assault3+'|BAT'      ,poffense)   or 
REGEXFIND(Battery              ,poffense)  )=> 'Y',			

REGEXFIND('STALK|MENAC|THREAT|TREATEN',poffense)   and 
~REGEXFIND(aggravated_exc             ,poffense)   => 'Y', 

REGEXFIND('PUB'                ,poffense)   and 
REGEXFIND('SERV'               ,poffense)   and
REGEXFIND('RETALI|RETAIL|SPIT' ,poffense)   => 'Y',	

REGEXFIND('BATT'                                             ,poffense)   and 
REGEXFIND('POL|PERSON|CH[I]*LD|DOM|L[/]*E[/]*O|L[\\.]E[\\.]' ,poffense)   and
~REGEXFIND('SEX'                                             ,poffense)   => 'Y', 

REGEXFIND('[/\\. ]SIM[/\\. ]|[/\\. ]SIMP[/\\. ]' ,poffense)   and 
REGEXFIND('BAT'                                  ,poffense)   and
~REGEXFIND('SIMULATED'                           ,poffense)   => 'Y',

REGEXFIND('ABUSE|[/\\. ]ABUS[/\\. ]'                                                 ,poffense)  and 
REGEXFIND('PERSON|ADULT|[/\\. ]ELD[ERLY]*[/\\. ]|[/\\. ]DIS[ABLED]*[/\\. ]|DEAD HUMA',poffense)  and 
~REGEXFIND('SEX|CARD|DRUG|DRG'                                                       ,poffense)  => 'Y',

stringlib.stringfind(poffense ,'ABUSE'      ,1) <> 0 and
REGEXFIND('PATIENT|RESIDENT|ELDER|NEGL|CARETAKER|CARTAKER|CH[I]*L[D]*|DISABL|IMPAIR|VULNERABLE',poffense)   and
~REGEXFIND('SEX|CARD'                   ,poffense) => 'Y',

stringlib.stringfind(poffense ,'CULPABLE'   ,1) <> 0 and
stringlib.stringfind(poffense ,'NEGLIGENCE' ,1) <> 0 => 'Y',
           
REGEXFIND(Assault                       ,poffense)  and 
~REGEXFIND(assault_exc                  ,poffense)  and 
~REGEXFIND(exc                          ,poffense)  => 'Y',	 

REGEXFIND(Assault2                      ,poffense)  and 
~REGEXFIND(assault_exc                  ,poffense)  and 
~REGEXFIND(exc                          ,poffense)  => 'Y',	 

REGEXFIND(Assault3                      ,poffense)  and 
~REGEXFIND(assault_exc                  ,poffense)  and 
~REGEXFIND(exc                          ,poffense)  => 'Y',	 

REGEXFIND(Battery                       ,poffense)  and 
~REGEXFIND(assault_exc                  ,poffense)  and 
~REGEXFIND(exc                          ,poffense)  => 'Y',	 

REGEXFIND('STRIKE|SHOVE|KICK'              ,poffense)  and
stringlib.stringfind(poffense ,'HARASSMENT',1) <> 0    => 'Y',
 
REGEXFIND('HARASS|HARRASS'              ,poffense)  => 'Y',	

REGEXFIND('ENDANGER| ENDANG '           ,poffense) and 
REGEXFIND('CRIMINAL |FELONY| FEL |RISK' ,poffense) and 
stringlib.stringfind(poffense ,'DEATH'  ,1) <> 0   => 'Y',	

stringlib.stringfind(poffense ,'ARREST' ,1) <> 0   and
REGEXFIND('EVAD|RESIST'                 ,poffense) and 
~REGEXFIND(' AGG[R]* |AGGRAVATED'       ,poffense) => 'Y',								 
							 
REGEXFIND(' CRIM[INAL ]+'               ,poffense)  and 
stringlib.stringfind(poffense ,'ABUSE'  ,1) <> 0    and
~REGEXFIND(' AGG[R]* |AGGRAVATED| SX |FORFEITURE|CREDIT CARD|DEBIT CARD'       ,poffense)   => 'Y',

(stringlib.stringfind(poffense ,'POLICE'  ,1) <> 0  or stringlib.stringfind(poffense ,'LEO'  ,1) <> 0 )   and
REGEXFIND('CROSS |CROSSING|INTER W[/] |REFUSE|IMPEDE|IMPEDING|OBEDIENCE| FLENG |ENGAGE|ENGAGING|DISREGARD|DISREGAEDING| F[/]ID |COMPLY|COMPLIANCE| FAI TO COMP|TOUCH|STRIKE|STRIKING|TORMENT|RESIST| RESIS |PROFANITY AT|OPPOSING|OBSTRUCT',poffense) 
  => 'Y',
	
stringlib.stringfind(poffense ,'OBSCENE'   ,1) <> 0 and
REGEXFIND('[/\\. ]TELE[/\\. ] |TELEPHONE'  ,poffense)   => 'Y',

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
  
Is_it := MAP( //In_Global_Exclude(poffense,'other')='Y' => 'N',

stringlib.stringfind(poffense ,'UNLAW' ,1) <> 0 and
stringlib.stringfind(poffense ,'COMP'  ,1) <> 0 and
stringlib.stringfind(poffense ,'OFFIC' ,1) <> 0 and
stringlib.stringfind(poffense ,'BEHAV' ,1) <> 0 => 'Y',
							
REGEXFIND(Bribery   ,poffense)  and 
~REGEXFIND(Bri_excl ,poffense)  => 'Y',	               
'N');

return Is_it;
end;

//--------------------------------------------------------------------------------------------------------------------------------------

 export Is_Motor_Vehicle_Theft(string poffense_in) := function
 
special_characters    := '~|!|-|%|\\^|\\+|:|\\(|\\)|,|;|_|#|@|\\*|<|>|"|`|\\[|]|\\{|\\}|\\\\|\\\'';
poffense              := ' '+REGEXREPLACE(special_characters, poffense_in, ' ');

Motor_Vehicle_Theft   := ' OMVWOC |[D/\\.& ]U[U]+MV[/\\.& ]|U[\\.]U[\\.]M[\\.]V|STEAL(.*)M[/]*V|MVTHEFT|THEFTMV| NMVTA | [TI]+SMV[I]* | T[XB]TMV | TBRSMV |ATTEMPT UUV|'+
                         'VC 10851 A |VC 10851 |PC 496D A |PC 487 D  1|VC 664\\/10851A|164135 UUV|TAKE [A ]*[MOTOR ]*VEHICLE' ; 
                                                        
// Motor_Vehicle_Theft            := 'AUTO(.*)THEFT|VEH(.*)THEFT|MV(.*)THEFT|JOYRID|UUV |UUMV |U[\\.]U[\\.]M[\\.]V'; 
MVT_Exc       := 'BURG|BREAK|ENTER';
Burglary      := 'BUROLARY|BUR.LARY|BURBULARY|BURG[/\\. ]|B[RU]+GL|BRGLY|BRG[/]|BRG[/0-9 ]|BUR[LG]+|BYRG|BURGLK|B[OUR]+[GR]+[GLAEY]+R[Y]*|^[ ]BUR[/ ]';	
BreakAndEnter := 'BREAK[ING]* [&] ENTER[ING]*|BREAK[ING]* AND ENTER[ING]*|BREAK[ING]* OR ENTER[ING]*|B[&][ ]*E|[/ ]B[ ]*AND[ ]E| BANDE |B[&]E |B[/]E |BREAKING INTO|INVASION';  

MVb := 'LAR[A]*C[AENY]*|LAR[AC]+[ENY]|LARC|STEAL|TH[E]*FT|[/\\. ]TEFT[/\\. ]|[TH]+EFT|[/\\. ]STLNG[/\\. ]';

//Roger's comment QA Update - Theft Round 4 9/27/16. AIRCRAFT, WATERCRAFT, CRAFT, BOAT and VESSEL are not motor vehicles
veh          := ' COMV |AUTO|VE[C]*H|[/\\. ]M[/]*V[EHICLE/ ]+|[/\\.& ]M[/]*V[/\\.& ]|[/\\.& ]M[\\. ]*V[/\\. ]| MVT[R]* | ATV ';

Is_it        := MAP(//In_Global_Exclude(poffense,'other')='Y' => 'N',
                
REGEXFIND(' REC | RECEIVING| RCV | RCV\\.' ,poffense)   and 
REGEXFIND(MVb                              ,poffense)   => 'N',

//QA Update - MV Theft   Round 5 10/14/16 Embezzlement is included in Theft
stringlib.stringfind(poffense ,'EMBEZZLE'      ,1) <> 0    => 'N',

(REGEXFIND(Burglary ,poffense)   or REGEXFIND(BreakAndEnter ,poffense)  ) and
REGEXFIND(veh                            ,poffense)   and
REGEXFIND('[ ]G[/]*T |GRAND THEFT'       ,poffense)   => 'Y',

stringlib.stringfind(poffense ,'CHOP SHOP'    ,1) <> 0  => 'Y',

//Roger's comments - QA Update - MV Theft   Round 4 9/23/16
REGEXFIND('STEAL|[ ]G[/]*T |GRAND THEFT|^[ ]*GL |^[ ]*GL/|^[ ]*GL\\(| GL | GL/|/GL/|GRAND LARCENY|THEFT GRAND|STOLEN' ,poffense)   and 
REGEXFIND(veh                            ,poffense)  and
~REGEXFIND('FROM| TAG'                   ,poffense)  => 'Y',

REGEXFIND('[/\\. ]TAK[EING]*[/\\. ]|USE|[/\\. ]OP[ERATEDING]*[/\\. ]|REMOVE|DRIVING'     ,poffense)   and 
REGEXFIND(veh  ,poffense)   and 
REGEXFIND('PERMIS'                ,poffense)   and 
REGEXFIND('WITHOUT|[/\\. ]W[/ ]*O[UT]*[/\\. ]|[/\\. ]NO[/\\. ]'    ,poffense)   => 'Y',

stringlib.stringfind(poffense ,'UNLAW'       ,1) <> 0    and
stringlib.stringfind(poffense ,'TAKING'      ,1) <> 0    and
REGEXFIND(veh                                ,poffense)  and
stringlib.stringfind(poffense ,'GAME'        ,1) = 0     => 'Y',

stringlib.stringfind(poffense ,'DRIV'       ,1) <> 0    and
stringlib.stringfind(poffense ,'PERMIS'     ,1) <> 0    and
REGEXFIND('WITHOUT|[/\\. ]W[/]*O[UT]*[/\\. ]|[/\\. ]NO[/\\. ]',poffense)   => 'Y',

REGEXFIND(veh+'FELMV | UNMV |[/\\. ]MV[0-9]CT[S]*[/\\. ]|[/\\. ]FELM[/]*V[/\\. ]',poffense)   and 
REGEXFIND(MVb                                                                    ,poffense)   and
~REGEXFIND('FROM| TAG'                                                           ,poffense)   => 'Y',					

REGEXFIND(veh+'| OFMV |[/\\. ]MV[0-9]CT[S]*[/\\. ]',poffense)   and 
stringlib.stringfind(poffense ,'USE'               ,1) <> 0     and
stringlib.stringfind(poffense ,'UNAUT'             ,1) <> 0     and
stringlib.stringfind(poffense ,'RAMP'              ,1) = 0      => 'Y',

REGEXFIND(Motor_Vehicle_Theft ,poffense)    => 'Y',	     

REGEXFIND('[/\\. ]MV[/\\. ]|[/\\. ]VEH[/\\. ]',poffense) and
stringlib.stringfind(poffense ,'ALTERED'      ,1) <> 0   and
stringlib.stringfind(poffense ,'VIN'          ,1) = 0    => 'Y',

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
                 'B [&] E [&] L|BREAKING INTO|HOUSE(.*)BREAK|INVASION|BREAK[/]ENTERING FELONY|^[ ]*BREAKING AND OR ENTERING[ ]*$';   
//Roger's comment - QA Update - Burglary Residential Round 3 8/26. Added BANK, BUIDL,GTMV, and BLD to BBE_exc
BBE_exc       := 'AUTO|[/\\. ]M[/]*V[H/ ]+| M[/]*V |[/\\. ]M\\.[ ]*V[/\\. ]|BUS|VE[C]*H|BUILD|BLDG|COMMERC|COMMER[IC]+AL|[/ ]BUS[/\\. ]|BU[S]+IN|BUS[INS]+|B\\&EMV| CHURCH|BLD|GTMV|BANK|'+
                 'BUIDL|BLDNG|BLDING|[/\\. ]BUSM[/\\. ]|[/\\. ]BLD[/\\. ]|BLDDG|[/\\. ]BLD[SHTBF2][/\\. ]';
//Roger's comment - QA Update - Burglary Residential Round 3 8/26. Remove Driving W... 
//Roger's comment - QA update - Theft Round 5 remove TRES and TRSP from the list
BBE_exc1      := 'PRIVACY|BREAKAGE|DRIVING[ ]?W[/|\\.|H|I|L| ]';
residence     := ' HABIT |[/ ]HAB[IT]*[/ ]|HABI[A]*TAT|[/ ]RES[ID]*[/ ]|RESIDENCE|HOUSE|HOME';

//Roger's comment QA Update - Theft  Round 5 10/14/16
comm    := 'BUILD|BLD[G| ]|COMMERC|COMMER[IC]+AL|[/ ]BUS[\\. ]|BU[S]+IN|BUS[INES]+|CHURCH|BANK|BUIDL';
Is_it := MAP(//In_Global_Exclude(poffense,'other')='Y' => 'N',

REGEXFIND(BBE_exc                    ,poffense)   and 
~REGEXFIND(residence + '|/JERRY'     ,poffense)   => 'N',
							 
REGEXFIND(BBE_exc1                   ,poffense)   => 'N',
							 
(stringlib.stringfind(poffense ,'NON' ,1) <> 0   and stringlib.stringfind(poffense ,'RESID' ,1) <> 0) or
REGEXFIND('NON[ ]*RES'               ,poffense)    => 'N',
								 
REGEXFIND('[/\\. ]BREAK[ING]*[/\\. ]| BRK |[/\\. ]EN[T]{1,2}[E]{1,2}R[ING]*[/\\. ]',poffense)   and
REGEXFIND(residence                       ,poffense) and 
stringlib.stringfind(poffense ,'BREAKAGE' ,1) = 0    => 'Y',						 

stringlib.stringfind(poffense ,'UNLAW' ,1) <> 0   and
stringlib.stringfind(poffense ,'INTENT',1) <> 0   and
REGEXFIND(residence                    ,poffense)   => 'Y',

stringlib.stringfind(poffense ,'UNLAW' ,1) <> 0   and
stringlib.stringfind(poffense ,'ENT'   ,1) <> 0   and
stringlib.stringfind(poffense ,'INT'   ,1) <> 0   and
REGEXFIND(residence                    ,poffense)   => 'Y',

REGEXFIND('ENTRY|ENTER'                           ,poffense)   and 
REGEXFIND(residence                               ,poffense)   and 
REGEXFIND('THEF|FEL |CRIM|DAMAG|UNLAW|CERT[AI]+N' ,poffense)   and
((stringlib.stringfind(poffense ,'WITH'  ,1) <> 0   and stringlib.stringfind(poffense ,'INTENT' ,1) <> 0) or
  stringlib.stringfind(poffense ,'W/INT' ,1) <> 0
) => 'Y',
           
REGEXFIND('^[ ]*(.)*BUR(.)*[/\\. ]|[/\\. ](.)*BUR(.)*[/\\. ]|BURLY|BRG'  ,poffense)   and 
REGEXFIND('[/\\. ]HAB[/\\. ]|[/\\. ]STEA[/\\. ]|[/\\. ]RES[IDEN]*[/\\. ]|DWELLING',poffense)   and
~REGEXFIND(BBE_exc                  ,poffense)   and		
~REGEXFIND('BURN|WAYNESBURG'        ,poffense)   => 'Y',							 

stringlib.stringfind(poffense ,'FORCE' ,1) <> 0  and
REGEXFIND(residence                 ,poffense)   and 
REGEXFIND('ENTRY|ENTER'             ,poffense)   => 'Y',	

REGEXFIND(residence                 ,poffense)   and 
REGEXFIND('INV |INV[AS]+[TION]+'    ,poffense)   => 'Y',	

REGEXFIND(Burglary                  ,poffense)   and								 
~REGEXFIND('BURN|WAYNESBURG'        ,poffense)   => 'Y',	
							 
REGEXFIND(BreakAndEnter             ,poffense)   AND
~REGEXFIND('BURN|WAYNESBURG'        ,poffense)   => 'Y',	

(REGEXFIND(Burglary                 ,poffense)   or	
REGEXFIND(BreakAndEnter             ,poffense))  and	
REGEXFIND(residence                 ,poffense)   and
REGEXFIND('LAR[A]*C|THEFT' ,poffense)   and REGEXFIND('RED' ,poffense)   => 'Y',

//Roger's comment QA Update - Theft Round 5 10/14/16
REGEXFIND('^[ ]*BURG[L]* |[/\\. ]BREAK[ING]*[/\\. ]| BRK |[/\\. ]EN[T]{1,2}[E]{1,2}R[ING]*[/\\. ]'        ,poffense)   and
REGEXFIND('WITH INTENT|W\\-INTENT|LAR[A]*C|THEFT',poffense)   AND							 
REGEXFIND(comm                  		 	             ,poffense,0) =  '' => 'Y', 

// REGEXFIND('^[ ]*BREAKING AND OR ENTERING[ ]*$'   ,poffense)   => 'Y',							 								

'N');
							 
return Is_it;
end;

//--------------------------------------------------------------------------------------------------------------------------------------

export Is_Burglary_BreakAndEnter_comm(string poffense_in) := function

special_characters    := '~|!|-|%|\\^|\\+|:|\\(|\\)|,|;|_|#|%|\\*|<|>|"|`|\\[|]|\\{|\\}|\\\\|\\\'';
poffense        := ' '+REGEXREPLACE(special_characters, poffense_in, ' ');


Burglary      := 'BUROLARY|BUR.LARY|BURBULARY|BURG[/\\. ]|B[RU]+GL|BRGLY|BRG[/]|BRG[/0-9 ]|BUR[LG]+|BYRG|BURGLK|[/\\. ]B[OUR]+[GR]+[GLAEY]+R[Y]*|^[ ]BUR[/ ]|^[ ]*BURG[L]? | BURG ';	
BreakAndEnter := 'BREAK[ING]* [&] EN[T]{1,2}[E]{1,2}R[ING]*|BREAK[ING]* AND EN[T]{1,2}[E]{1,2}R[ING]*|BREAK[ING]* OR EN[T]{1,2}[E]{1,2}R[ING]*|B[&][ ]*E|[/ ]B[ ]*AND[ ]E| BANDE |B[&]E |B[/]E |'+
                 'BREAKING INTO|INVASION|^[ ]*B & E BLDG[ ]*$';   
BBE_exc       := 'AUTO|[/\\. ]M[/]*V[H/ ]+| M[/]*V |[/\\. ]M\\.[ ]*V[/\\. ]|VE[C]*H|[/ ]HAB[IT]*[/ ]|HABI[A]*TAT|[/ ]RES[ID]*[/ ]|RESIDENCE|HOUSE|HOME';
//Roger's comment - QA update - Theft Round 5 remove TRES and TRSP from the list
BBE_exc1      := 'PRIVACY|BREAKAGE';                                                        
					 
comm    := 'BUILD|BLD[G| ]|COMMERC|COMMER[IC]+AL|[/ ]BUS[\\. ]|BU[S]+IN|BUS[INES]+|CHURCH|BANK|BUIDL';
  Is_it := MAP(//In_Global_Exclude(poffense,'other')='Y' => 'N',
			 
(REGEXFIND(Burglary                   ,poffense)    OR 
 REGEXFIND(BreakAndEnter              ,poffense)  ) AND 
((stringlib.stringfind(poffense ,'NON',1) <> 0   and stringlib.stringfind(poffense ,'RESID' ,1) <> 0) or
REGEXFIND('NON[ ]*RES'                ,poffense)) => 'Y',		

stringlib.stringfind(poffense ,'FORCE',1) <> 0  and 
REGEXFIND('ENTRY|ENTER'               ,poffense)   AND 
((stringlib.stringfind(poffense ,'NON',1) <> 0   and stringlib.stringfind(poffense ,'RESID' ,1) <> 0) or
REGEXFIND('NON[ ]*RES'                ,poffense)) => 'Y',	
	
//this (BBE_exc) has to be after the two above using NON-RES as bbe_exc is excluding the word RESID
REGEXFIND(BBE_exc                     ,poffense)   and 
REGEXFIND(comm                        ,poffense,0) = ''=> 'N',

REGEXFIND(BBE_exc1                    ,poffense)   => 'N',
     	
REGEXFIND('[/\\. ]BREAK[ING]*[/\\. ]| BRK |[/\\. ]EN[T]{1,2}[E]{1,2}R[ING]*[/\\. ]'         ,poffense)   and
REGEXFIND(comm                        ,poffense)   and 
REGEXFIND('GLASS|BREAKAGE'            ,poffense,0) = ''  => 'Y',

    
stringlib.stringfind(poffense ,'UNLAW' ,1) <> 0   and
stringlib.stringfind(poffense ,'INTENT',1) <> 0   and 
REGEXFIND(comm                         ,poffense)   => 'Y',

stringlib.stringfind(poffense ,'UNLAW' ,1) <> 0   and
stringlib.stringfind(poffense ,'ENT'   ,1) <> 0   and
stringlib.stringfind(poffense ,'INT'   ,1) <> 0   and
REGEXFIND(comm                         ,poffense)   => 'Y',

REGEXFIND('ENTRY|ENTER'                           ,poffense)   AND 
REGEXFIND(comm                                    ,poffense)   AND
REGEXFIND('THEF|FEL |CRIM|DAMAG|UNLAW|CERT[AI]+N' ,poffense)   AND
((stringlib.stringfind(poffense ,'WITH'  ,1) <> 0   and stringlib.stringfind(poffense ,'INTENT' ,1) <> 0) or
  stringlib.stringfind(poffense ,'W/INT' ,1) <> 0 ) => 'Y',

REGEXFIND('^[ ]*(.)*BUR(.)*[/\\. ]|[/\\. ](.)*BUR(.)*[/\\. ]|BURLY|BRG'  ,poffense)   AND 
REGEXFIND(comm                                    ,poffense)   AND
REGEXFIND('[/\\. ]BLD[G]*[/\\. ]|[/\\. ]STEA[/\\. ]|[/\\. ]AGG[/\\. ]|[/\\. ]BU[I]*LD[/\\. ]|[/\\. ]CO[M]+[/\\. ]|COMMERC|COMMER[IC]+AL|[-/\\. ]BUS[/\\. ]|BU[S]+IN|BUS[INS]+|BUSINESS|[/\\. ]STR[/\\. ]',poffense)   AND
~REGEXFIND('BURN|WAYNESBURG'        ,poffense)   => 'Y',		        

REGEXFIND(Burglary                   ,poffense)   and
REGEXFIND(comm                       ,poffense)   and 
~REGEXFIND('BURN|WAYNESBURG'         ,poffense)   => 'Y',		

REGEXFIND(BreakAndEnter              ,poffense)   and
REGEXFIND(comm                       ,poffense)   and 
~REGEXFIND('BURN|WAYNESBURG'         ,poffense)   => 'Y',		

(REGEXFIND(Burglary                   ,poffense)   or
	REGEXFIND(BreakAndEnter              ,poffense)  ) and
	REGEXFIND(comm                       ,poffense)   AND
	(REGEXFIND('LAR[A]*C|TH[E]*FT|[/\\. ]TEFT[/\\. ]|[TH]+EFT|[/\\. ]STLNG[/\\. ]'     ,poffense)   and 
	 REGEXFIND('RED' ,poffense)  ) => 'N',			
	
(REGEXFIND(Burglary                  ,poffense)   or	
REGEXFIND(BreakAndEnter              ,poffense)  ) AND	
REGEXFIND('BLDNG|BLDING|[/\\. ]BUSM[/\\. ]|[/\\. ]BLD[/\\. ]|BLDDG|[/\\. ]BLD[SHTBF2]+[/\\. ]' ,poffense)    => 'Y',

// REGEXFIND('^[ ]*B & E BLDG[ ]*$'     ,poffense)   => 'Y',	
stringlib.stringfind(poffense ,'VENDING' ,1) <> 0 and
REGEXFIND(' B & E '                  ,poffense)   => 'Y',	           
							 
							 'N');
							 							 
return Is_it;
end;

//--------------------------------------------------------------------------------------------------------------------------------------

export Is_Burglary_BreakAndEnter_Veh(string poffense_in) := function

special_characters    := '~|!|-|%|\\^|\\+|:|\\(|\\)|,|;|_|#|%|\\*|<|>|"|`|\\[|]|\\{|\\}|\\\\|\\\'';
poffense              := ' '+REGEXREPLACE(special_characters, poffense_in, ' '); 

//DF-18286 code review comment #3, add ^[ ]*BURG[L]? | BURG to Burglary to keep it in sync with burglary comm and res
Burglary      := 'BUROLARY|BUR.LARY|BURBULARY|BURG[/\\. ]|B[RU]+GL|BRGLY|BRG[/]|BRG[/0-9 ]|BUR[LG]+|BYRG|BURGLK|[/\\. ]B[OUR]+[GR]+[GLAEY]+R[Y]*|'+
                 '^[ ]BUR[/ ]|^[ ]*BURG[L]? | BURG |VEHICLE PROWLING|B & E VEHICLES|[/\\. ]UEMV[/\\. ]';	
BreakAndEnter := 'BREAK[ING]* [&] EN[T]{1,2}[E]{1,2}R[ING]*|BREAK[ING]* AND EN[T]{1,2}[E]{1,2}R[ING]*|BREAK[ING]* OR EN[T]{1,2}[E]{1,2}R[ING]*|B[ ]*[&][ ]*E|[/ ]B[ ]*AND[ ]E| BANDE |B[&]E |B[/]E |BREAKING INTO|INVASION';  


//DF-18286 code review comment #4, BLD should be added to BBE_exc in Is_Burglary_BreakAndEnter_Veh
BBE_exc       := 'BLDNG|BLDING|[/\\. ]BUSM[/\\. ]|[/\\. ]BLD[/\\. ]|BLDDG|[/\\. ]BLD[SHTBF2][/\\. ]|BUILD|BUIDL|BANK|BLDG|BLD|COMMERC|COMMER[IC]+AL|'+
                 '[-/ ]BUS[-/\\. ]|BU[S]+IN|BUS[INS]+|[/ ]HAB[IT]*[/ ]|HABI[A]*TAT|[/ ]RES[ID]*[/ ]|RESIDENCE|HOUSE|HOME| CHURCH[ |$]';
BBE_exc1      := 'PRIVACY|TRES|TRSP|BREAKAGE';

Larceny           := 'LAR[A]*C[AENY]*|LAR[AC]+[ENY]|LARC|STEAL|TH[E]*FT|[/\\. ]TEFT[/\\. ]|[TH]+EFT|[/\\. ]STLNG[/\\. ]';       
Larceny_exc       := 'CHILD STEAL|BURG|VE[C]*H|AUTO|MV|DECLARCATION|SHOPLIF[TING]*|SHOFLIFT|SAFECRACK';
veh               := 'AUTO|VE[C]*H|[/\\. ]M[/]*V[EHICLE/ ]+| M[/]*V |[/\\. ]M[\\. ]*V[/\\. ]';

  Is_it := MAP(//In_Global_Exclude(poffense,'other')='Y' => 'N',

REGEXFIND(BBE_exc                                ,poffense)   and 
~REGEXFIND(veh                                   ,poffense)   => 'N',
							 
REGEXFIND(BBE_exc1                               ,poffense)   => 'N',
							 
REGEXFIND('STOL[EN]*|STLN'                       ,poffense)   and 
REGEXFIND('TH[E]*FT|REC[EIV]*|RCV|RVC|POSS|GOODS|PROP|CONCEAL|BUY|SELL|SALE|TRANS' ,poffense)   => 'N',

REGEXFIND('REC[EIV ]+|RCV'                       ,poffense)   and 
REGEXFIND('TH[E]*FT'                             ,poffense)   and 
stringlib.stringfind(poffense ,'DIRECT'          ,1) = 0      => 'N',
							 
REGEXFIND('[/\\. ]BREAK[ING]*[/\\. ]| BRK |[/\\. ]EN[T]{1,2}[E]{1,2}R[ING]*[/\\. ]'                    ,poffense)   and
REGEXFIND(veh                                    ,poffense)   and 
REGEXFIND('INTERSEC|[/\\. ]ROA[DWAY]*[/\\. ]|[/\\. ]RDW[/\\. ]|H[I]*GHW[A]*Y| H[/]WAY |BREAKAGE|CROSSING|CENTER|WIND[H]*SHIE|FAIL YLD|FAILED TO DISP|'+
'REST BREAK|FAIL T[O/ ]*YIELD|RESTING AREA|ENTER FALSE INFO|OPERATE VEHICLE|OPERATING|PED-ENTERING|PATH OF VEH|PEDESTRIAN|FAULTY BR|STICKER|TRAFFIC CONTROL|ENT[E]{1,2}R[ING]*[/\\,OR ]+LEAV' ,poffense,0) = ''  => 'Y',

stringlib.stringfind(poffense ,'UNLAW'           ,1) <> 0   and
stringlib.stringfind(poffense ,'INTENT'          ,1) <> 0   and 
REGEXFIND(veh                                    ,poffense)   => 'Y',

stringlib.stringfind(poffense ,'UNLAW'           ,1) <> 0   and
stringlib.stringfind(poffense ,'ENT'             ,1) <> 0   and
stringlib.stringfind(poffense ,'INT'             ,1) <> 0   and
REGEXFIND(veh                                    ,poffense)   => 'Y',

REGEXFIND('ENTRY|ENTER'                          ,poffense)   AND 
REGEXFIND(veh                                    ,poffense)   AND 
REGEXFIND('THEF|FEL |CRIM|DAMAG|UNLAW|CERT[AI]+N',poffense)   AND
((stringlib.stringfind(poffense ,'WITH'  ,1) <> 0   and stringlib.stringfind(poffense ,'INTENT' ,1) <> 0) or
  stringlib.stringfind(poffense ,'W/INT' ,1) <> 0 ) => 'Y',

REGEXFIND('ENTRY|ENTER'                           ,poffense)   AND 
REGEXFIND(veh                                     ,poffense)   AND
REGEXFIND('UNLAW|[/\\. ]UNLW[/\\. ]|[/\\. ]UNL[AWFUL]*[/\\. ]|UNLF[/\\. ] |[/\\. ]UN[/\\. ]',poffense)    => 'Y',

REGEXFIND('^[ ]*(.)*BUR(.)*[/\\. ]|[/\\. ](.)*BUR(.)*[/\\. ]|BURLY|[/\\. ]BRG[/\\. ]'  ,poffense)   AND 
REGEXFIND(veh                                     ,poffense)   AND
~REGEXFIND('BURN|WAYNESBURG'                      ,poffense)   => 'Y',							 						 

REGEXFIND(Burglary                                ,poffense)   and
REGEXFIND(veh                                     ,poffense)   and 
~REGEXFIND('BURN|WAYNESBURG'                      ,poffense)   => 'Y',

REGEXFIND(BreakAndEnter                           ,poffense)   and
REGEXFIND(veh                                     ,poffense)   and 
~REGEXFIND('BURN|WAYNESBURG'                      ,poffense)   => 'Y',

REGEXFIND('LARC|ILL|LOCK'                         ,poffense)   and 
REGEXFIND('ENTER|ENTRY'                           ,poffense)   and 
REGEXFIND(veh                                     ,poffense)   => 'Y',	

REGEXFIND(Larceny                                 ,poffense)   and
stringlib.stringfind(poffense ,'FROM'             ,1) <> 0     and
REGEXFIND(veh                                     ,poffense)   => 'Y',

REGEXFIND('PROWL[ING ]+'                          ,poffense)   and
REGEXFIND(veh                                     ,poffense)   => 'Y',

(REGEXFIND(Burglary                               ,poffense)   or
REGEXFIND(BreakAndEnter                           ,poffense)  ) and
REGEXFIND(veh                                     ,poffense)   	and						 
(REGEXFIND('LAR[A]*C|TH[E]*FT|[/\\. ]TEFT[/\\. ]|[TH]+EFT|[/\\. ]STLNG[/\\. ]' ,poffense)   and stringlib.stringfind(poffense ,'RED'  ,1) <> 0) => 'Y',	

REGEXFIND(veh                            ,poffense)   and
REGEXFIND('TAMP[ ER]'                    ,poffense)   => 'Y',	

REGEXFIND('[/\\. ]UEMV[/\\. ]'             ,poffense) => 'Y',

'N');							 
							 
return Is_it;
end;

//--------------------------------------------------------------------------------------------------------------------------------------

export Is_Computer_Crimes(string poffense_in) := function //done

special_characters    := '~|!|-|%|\\^|\\+|:|\\(|\\)|,|;|_|#|%|@|\\*|<|>|"|`|\\[|]|\\{|\\}|\\\\|\\\'';
poffense              := ' '+REGEXREPLACE(special_characters, poffense_in, ' ');

Computer_Crimes       := 'COMPU(.*) GRAND TH|COMPU(.*) TRAFF|COMPU(.*)R[ES]|COMPUTER| 2913\\.04 ';

CC_exclude            := 'COMPUL|COMPUTER TRESP';
Is_it := MAP(//In_Global_Exclude(poffense,'other')='Y' => 'N',
			 
REGEXFIND(Computer_Crimes               ,poffense)   and 
REGEXFIND(CC_exclude                    ,poffense,0) = '' => 'Y',	          
						 
REGEXFIND('ONLINE| ONLN |ELECTRONIC|ELECTRNC| ELECT |INTERNET'               ,poffense)   and
REGEXFIND(' SOL |SOLIC[IT]* '           ,poffense)   and
REGEXFIND('MINOR|CHILD'                 ,poffense )  => 'Y',
						 
'N');
return Is_it;
end;

//--------------------------------------------------------------------------------------------------------------------------------------

export Is_Counterfeiting_Forgery(string poffense_in) := function //done

special_characters    := '~|!|-|%|\\^|\\+|:|\\(|\\)|,|;|_|#|%|\\*|<|>|"|`|\\[|]|\\{|\\}|\\\\|\\\'';
poffense              := ' '+REGEXREPLACE(special_characters, poffense_in, ' '); 

Counterfeiting_Forgery  := 'FROG|FORG|FO[R]*GERY|FOEGE|FOERG|CTRFT|COUNTERF[IE]*T|COUNTF|PC 475 [ABC] |PC 475A|PC 476A(A)|PC 470 [AD] |PC 470B|PC 476|HS 11368';										

Counterfeiting_Forgery2 := '^[ ](FRG[/ &\\.]|FRGD|FRGE|FRGING|FRGRY|FRGY|FRGNG)';	

  Is_it := MAP(//In_Global_Exclude(poffense,'other')='Y' => 'N',
	
REGEXFIND('FALSE|FLS|FAL|FICTI'          ,poffense)   and 
REGEXFIND('[/\\. ]ID[ENIFVICATION]*[/\\. ]|[/\\. ]ID[ENTIFYING]*[/\\. ]| I[/]D ',poffense)   and 
REGEXFIND('[/\\. ]AID[/\\. ]'            ,poffense,0) = '' and 
REGEXFIND('SELL|SALE|DISTRIB|MANUF'      ,poffense)   => 'Y',							 

stringlib.stringfind(poffense ,'UTTER'   ,1) <> 0     and 
REGEXFIND('[/\\. ]BILL[S]*[/\\. ]'       ,poffense)   => 'Y',							 

REGEXFIND(Counterfeiting_Forgery         ,poffense)   and 
~(REGEXFIND('FOR[EI]*GN' ,poffense) and  stringlib.stringfind(poffense ,'OBJ'   ,1) <> 0 ) => 'Y',	

REGEXFIND(Counterfeiting_Forgery2        ,poffense)   => 'Y',	

REGEXFIND('POSS|SELL'                    ,poffense)   and 
REGEXFIND('[/\\. ]DOC[/\\. ]|DOCUMENT'   ,poffense)   and  
stringlib.stringfind(poffense ,'STATUS'  ,1) <> 0     => 'Y',

REGEXFIND('MAKE|ISSU[EING ]+'            ,poffense)   and 
stringlib.stringfind(poffense ,'FICTITI' ,1) <> 0     and
stringlib.stringfind(poffense ,'CHECK'   ,1) <> 0     => 'Y',
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
  Is_it := MAP(//In_Global_Exclude(poffense,'other')='Y' => 'N',	
 
//Roger's comment QA Update - Destruction Round 5 10/3
REGEXFIND('LEAVE|LEAVING|[/\\. ]LV[/\\. ]|[/\\. ]LVE[/\\. ]|FAIL.*TO STOP|FAIL.*TO REMAIN|HIT AND RUN|HIT[/]RUN' ,poffense)   and
stringlib.stringfind(poffense ,'SCEN'       ,1) <> 0     and 
REGEXFIND('ACCIDEN|CRASH|[/\\. ]ACC[/\\. ]|[/\\. ]ACCID[/\\. ]',poffense )    => 'N',

REGEXFIND('INJURY|INJURING'                 ,poffense)   and 
stringlib.stringfind(poffense ,'PUBLIC'     ,1) <> 0     and 
stringlib.stringfind(poffense ,'BUILD'      ,1) <> 0     => 'Y',		

REGEXFIND('CRINIMAL|CRIM|[/\\. ]MAL[L]*[ICIOUS]*[/\\. ]|MAL[AI]CIOUS|MALISH |MALICIAS'     ,poffense)   AND              
stringlib.stringfind(poffense ,'MISCH'      ,1) <> 0=> 'Y',
 
stringlib.stringfind(poffense ,'DEFAC '       ,1) <> 0   and 
// stringlib.stringfind(poffense ,'DEFACAT'    ,1) = 0   and    
REGEXFIND('FIREA|ALTER|ALT|LIC|SER|NUMBER|ID|PRESCRIP|VIN|FORG' ,poffense)   => 'Y',

stringlib.stringfind(poffense ,'MOLEST'       ,1) <> 0   and              
REGEXFIND('COIN|MACH[INE]*[/\\. ]|AUTO|VE[C]*H|[/\\. ]M[/]*V[EHICLE/ ]+| M[/]*V |[/\\. ]M\\.[ ]*V[/\\. ]|[/\\. ]VEND[ING]*[/\\. ]'      ,poffense)   => 'Y',

REGEXFIND(damage                            ,poffense)   and              
REGEXFIND('BUILD|PROP|VE[C]*H|GRAVE|AUT$'   ,poffense)   => 'Y',

stringlib.stringfind(poffense ,'PROP'       ,1) <> 0     and 
REGEXFIND('DAMAG|INJ|DEST|GRAFF|DEFACE|CRIM',poffense)   and
~REGEXFIND('ACC|INVOL|POSS|STOLEN|TRESPASS| TRES | TR[E]*SP |MOVABLE PROP| SHOPLI |SHOPLIF' ,poffense) => 'Y',

REGEXFIND('[/\\. ]VAND[A]*[\\\']|[/\\. ]VAN[D]+[ALISUOZNMEDH]*[/\\. ]|[/\\. ]VAND[ALIZED]*[/\\. ]|[/\\. ]VAND[ALIZATIONG]*[/\\. ]',poffense)  => 'Y',

REGEXFIND(damage                          ,poffense)   and 
REGEXFIND('FACITITY|FACILITIES|WILLFUL|[/\\. ]MAL[ICIOUSLY]*[/\\. ]|MAL[AI]CIOUS|MALICIONS|TAMPER|UNLAW|RECKL|CR[I]*M|CRMNL'      ,poffense)   => 'Y',
						 
REGEXFIND(Destruction_Damage_Vandalism    ,poffense)   and
~REGEXFIND('EVID|DUI|MASS'                ,poffense)   => 'Y',	               

REGEXFIND(Destruction_Damage_Vandalism2   ,poffense)   => 'Y',

stringlib.stringfind(poffense ,'WILLFUL'  ,1) <> 0     and 
REGEXFIND('INJUR| INJ '                   ,poffense)   and
REGEXFIND('JAIL| COUR[THOUSE]* |RAILROAD' ,poffense)   => 'Y',
'N');
return Is_it;
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------------
shared Drug_Narcotica  := 'AMPHET|CULTIVATE|CUL OF MARJ|^[ ]CULTIV|\\.5 GRAM|GRAMS|HYPODERMIC|HEROIN|[/ \\.]SCH[E]*D[ULED]*[/ \\.]|SCH [1234I]|P[PHTARA]+PH[ER]*NALIA|PARAP|[ /\\.]POM[ /\\.]|[ /\\.]CDS[ /\\.]|'+
                         'POSS[/]MAR|A[D]+E[R]+AL|AMITRIP|AMPH[IE]T|ATIVAN|BUPRENORPHINE|CARIS[OP]+|COCA[IN]|CANN[AI]B[UI]|HALLUCINOGE| DIST[RIBUTE]*[/\\.]SCH| DIST[/\\. ]MARIJ| DIST[/\\. ]COC[/ A]|'+
                         'CLONAZEPAM|[ /\\.]E[XC]*STA[SC]Y[ /\\.]|DIAZEPA|HALLOCINOG|HYDROXYZINEPAM|HER[OI]+N|HYDROCO|[ /\\.]L[\\.]*S[\\.]*D[ /\\.]|LORAZEPAM|LYSERGIC|LORTAB|HY[DR]+OMORPHONE|MORPHINE|'+
												             'OXYCO[DT]|PHENOBAR|PROPOXYPHENE|PHENCYCLEDINE|PSILOCYBIN|A[L]*P[A]*RAZOL|PSUEDOEP|PHENYL|TRAZODONE|TRAZEPAM|VALIUM|VICODIN|[ZX]AN[EA]X|PROHIB(.*)ACT(.*)SCH[E]*DU[LE]+S';
shared Drug_Narcoticb  := 'CA[N]+AB|[ /\\.]RX[ /\\.]|[ /\\.]COCA[ /\\.]|DARVOCET|OXYC|MANDRAX|VYVANSE|[ /\\.]OXCO[DN]|HYDRO|[/\\. ]P[S]*/SCH[/\\. ]| DIST CDS | DIST[R]*\\.(.*)[/\\.]SCH[/\\.]|[/\\. ]DRUG[S]*[/\\. ]|'+
												             'PHENCYCLIDINE|PHENMETRA| UCDS | UCDSA |DALPHINE|ACETAMINPHEN|PROPYLHEXEDRINE|DIETHYLPROPION|EPHEDRINE|PARAPHERNALIA|TRAZADONE|PRESCRIBED DR |SYNNARCOTIC|EXTASY|CANNBIS|[/\\. ]DRUG PARA[/\\. ]|'+
												             'PHENETHYLAMINES|BARBIT|COCAEIN|FELPOSCOC|FELPOSSLSD|AMPHE|BENZYLPIPERAZ|AMBENYL|AMOBAR|DEMEROL|DESOXYN|PRELUDEN|PRELUDIN|OPIUM|METHAMPH|DILAUDID|CODONE|PERCOCET|MAR.[HJ][UI]ANA';                           
shared Drug_Narcotic1  := 'POSS/CS|POSS(.*) DIST| POSSCANN|MARI[HJ]UAN[A]*|[ /\\.]MARI[ /\\.]|[ /\\.]CDS$|SALE/SCH/I|SALE/DEL(.*)[/\\.]SCH|'+
                         'DRUG[S]* ABUSE|DRUG[S]* FREE|DRUG[S]* VIO|DRUG[S]*[/ ]+DIST[/\\. ]|DRUG[S]* SCHEDULE|DRUG[S]* SPOM| [US]POM[ 0-9]| POM[1-9J] | PWID[/ ]|'+
												             ' DISTRIBUTE[/ ]CON[TROLED\\./ ]*SUB| DISTRIBUTE DANG[EROUS\\.]* SUB| DEL OF MARI |DEF OF[ A]* CS TO|COUNTERFEIT C/S |'+ 
												             'PSYLOC|METHO[D]+ONE|[/\\. ]SAL[E ]*COCA...[/\\. ]|[/\\. ]SAL[E ]*CSCOCA[/\\. ]| S[/]M[/]D[/]P[/]W[/]INT|'+												                                                                                              
												             '[/\\. ]SCH[/\\. ]*[IV]+[0-9]*[/\\. ]|[/\\. ]C[/]S SCH[/\\. ]|[/\\. ]POSS[ OF]*DR[/\\. ]|[/\\. ]CON[TROL]*[/\\. ]SCH[EDULED]*[/\\. ]SUB';

shared Drug_Narcotic2  := 'DEL/DRUGS| CON SUB (.*)/SCH|/SCH[/\\.][IV123]+|POSS CTRL[ DANGEROUS]* SUSBS|POSS SCH SUBS|POSS CONT SUBS|POSS OF C/S|POSS[ /]USE C/S|'+ 
                         'INTRO(.*)[ /]CONTR|[TANCE]*[/\\. ]CON(.*)\\.SUB[STANCE]*[/\\. ]|COUNTERF(.*)\\.SUB|C[N]*T[RL](.*)[ /](SUB|SUSB|SBSTNC) |'+
                         'INT(.*) DEL.|W/I[INT/]* DEL|[/\\. ]DEL[\\./]MAN[UFACTORINGED]*[/\\. ]| DEL SCH |INT(.*)TO DIST|TRAFFIC IN CRAC|TRAFFIC IN COKE|'+
                         'SIMPLE POSS|^[ ]SALE[S]* TO|SYRINGE|STEROID|TRAFFIC DRU|ATTEMPT [(]TRAFFI|TRAFF(.*)COCAIN|COCAIN(.*)TRAFF|TRAFFIC IN PHENE';

												 
//--------------------------------------------------------------------------------------------------------------------------------------

export Is_Drug_Narcotic(string poffense_in) := function //working

special_characters    := '~|!|-|%|\\^|\\+|:|\\(|\\)|,|;|_|#|@|\\*|<|>|"|`|\\[|]|\\{|\\}|\\\\|[\\\']';
poffense              := ' '+REGEXREPLACE(special_characters, poffense_in, ' ')+' ';

special_characters2   := '~|!|-|%|\\^|\\+|:|,|;|_|#|@|\\*|<|>|"|`|\\[|]|\\{|\\}|\\\\|[\\\']';
poffense7             := ' '+REGEXREPLACE(special_characters2, poffense_in, ' ');				
                                                                 

 // causes other offenses to get selected.
// Drug_Narcotica        := 'AMPHET|CULTIVATE|CUL OF MARJ|^[ ]CULTIV|\\.5 GRAM|GRAMS|HYPODERMIC|HEROIN|[/ \\.]SCH[E]*D[ULED]*[/ \\.]|SCH [1234I]|P[PHTARA]+PH[ER]*NALIA|PARAP|[ /\\.]POM[ /\\.]|'+
                         // 'POSS[/]MAR|A[D]+E[R]+AL|AMITRIP|AMPH[IE]T|ATIVAN|BUPRENORPHINE|CARIS[OP]+|COCA[IN]|CANN[AI]B[UI]|HALLUCINOGE| DIST[RIBUTE]*[/\\.]SCH| DIST[/\\. ]MARIJ| DIST[/\\. ]COC[/ A]|'+
                         // 'CLONAZEPAM|[ /\\.]E[XC]*STA[SC]Y[ /\\.]|DIAZEPA|HALLOCINOG|HYDROXYZINEPAM|HER[OI]+N|HYDROCO|[ /\\.]L[\\.]*S[\\.]*D[ /\\.]|LORAZEPAM|LYSERGIC|LORTAB|HY[DR]+OMORPHONE|MORPHINE|'+
												             // 'OXYCO[DT]|PHENOBAR|PROPOXYPHENE|PHENCYCLEDINE|PSILOCYBIN|A[L]*P[A]*RAZOL|PSUEDOEP|PHENYL|TRAZODONE|TRAZEPAM|VALIUM|VICODIN|[ZX]AN[EA]X|PROHIB(.*)ACT(.*)SCH[E]*DU[LE]+S';
												 
// Drug_Narcoticb        := 'CA[N]+AB|[ /\\.]RX[ /\\.]|[ /\\.]COCA[ /\\.]|DARVOCET|OXYC|MANDRAX|VYVANSE|[ /\\.]OXCO[DN]|HYDRO|[/\\. ]P[S]*/SCH[/\\. ]| DIST CDS | DIST[R]*\\.(.*)[/\\.]SCH[/\\.]|[/\\. ]DRUG[S]*[/\\. ]|'+
												             // 'PHENCYCLIDINE|PHENMETRA| UCDS | UCDSA |DALPHINE|ACETAMINPHEN|PROPYLHEXEDRINE|DIETHYLPROPION|EPHEDRINE|PARAPHERNALIA|TRAZADONE|PRESCRIBED DR |SYNNARCOTIC|EXTASY|CANNBIS|[/\\. ]DRUG PARA[/\\. ]|'+
												             // 'PHENETHYLAMINES|BARBIT|COCAEIN|FELPOSCOC|FELPOSSLSD|AMPHE|BENZYLPIPERAZ|AMBENYL|AMOBAR|DEMEROL|DESOXYN|PRELUDEN|PRELUDIN|OPIUM|METHAMPH|DILAUDID|CODONE|PERCOCET|MAR.[HJ][UI]ANA';												 

// Drug_Narcotic1        := 'POSS/CS|POSS(.*) DIST| POSSCANN|MARI[HJ]UAN[A]*|[ /\\.]MARI[ /\\.]|[ /\\.]CDS[ /\\.]|[ /\\.]CDS$|SALE/SCH/I|SALE/DEL(.*)[/\\.]SCH|'+
                         // 'DRUG[S]* ABUSE|DRUG[S]* FREE|DRUG[S]* VIO|DRUG[S]*[/ ]+DIST[/\\. ]|DRUG[S]* SCHEDULE|DRUG[S]* SPOM| [US]POM[ 0-9]| POM[1-9J] | PWID[/ ]|'+
												             // ' DISTRIBUTE[/ ]CON[TROLED\\./ ]*SUB| DISTRIBUTE DANG[EROUS\\.]* SUB| DEL OF MARI |DEF OF[ A]* CS TO|COUNTERFEIT C/S |'+ 
												             // 'PSYLOC|METHO[D]+ONE|[/\\. ]SAL[E ]*COCA...[/\\. ]|[/\\. ]SAL[E ]*CSCOCA[/\\. ]| S[/]M[/]D[/]P[/]W[/]INT|'+												                                                                                              
												             // '[/\\. ]SCH[/\\. ]*[IV]+[0-9]*[/\\. ]|[/\\. ]C[/]S SCH[/\\. ]|[/\\. ]POSS[ OF]*DR[/\\. ]|[/\\. ]CON[TROL]*[/\\. ]SCH[EDULED]*[/\\. ]SUB';

// Drug_Narcotic2        := 'DEL/DRUGS| CON SUB (.*)/SCH|/SCH[/\\.][IV123]+|POSS CTRL[ DANGEROUS]* SUSBS|POSS SCH SUBS|POSS CONT SUBS|POSS OF C/S|POSS[ /]USE C/S|'+ 
                         // 'INTRO(.*)[ /]CONTR|[TANCE]*[/\\. ]CON(.*)\\.SUB[STANCE]*[/\\. ]|COUNTERF(.*)\\.SUB|C[N]*T[RL](.*)[ /](SUB|SUSB|SBSTNC) |'+
                         // 'INT(.*) DEL.|W/I[INT/]* DEL|[/\\. ]DEL[\\./]MAN[UFACTORINGED]*[/\\. ]| DEL SCH |INT(.*)TO DIST|TRAFFIC IN CRAC|TRAFFIC IN COKE|'+
                         // 'SIMPLE POSS|^[ ]SALE[S]* TO|SYRINGE|STEROID|TRAFFIC DRU|ATTEMPT [(]TRAFFI|TRAFF(.*)COCAIN|COCAIN(.*)TRAFF|TRAFFIC IN PHENE';

//Removed [/\\. ]A[ \\.]+C[ \\.]+D[ \\.]|
Drug_Narcotic3        := 'MARIJ|^[ ]DEL[/ \\.]|TRAF ICE[/ ]|MAN[ /]DEL|DEL(.*) CONT|DEL(.*) CDS| AM[OUN]*T[/]DISTRIBUTE[/ ]*NOT SELL |'+
		                       'ATTEMPT TO (MANU)|ATTEMPT TRAF| DRGS |DRUG| DURG |[/\\. ]NARC[OARTICES]*[/\\. ]|PRESC[R]*IP|S[ALE]*/COC|DEL(.*)COC|TAMPH|SAL[E]* (.*) COC|'+
												             'CONTRIB\\.|CONTRA[BND]+|POSS CONTBND|PCS POSSESSION| DIST COC |[/\\. ]DIST[\\. ]+(.*)COC[\\. ]*(.*) SCH[\\. ]|POSS[ESSION ]*CNTRL SUB|'+
												             '^[ ]CDS[/\\. ]|^[ ]CON-CDS|[/\\. ]CIG[/\\. ]|PRECURSOR SUBS|OBTAIN CONT SUB|'+
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

Drug8                := '893\\.13[15]*[/\\. ]|893\\.147[\\. ]|893\\.13\\.6A| VUCSA | 893[\\.]*13[\\.]*1A| 893132A | P\\.O\\.M\\.[ ]*B |HS 11377 A | HS 11364 |2925\\.11|'+
                        '2925\\.03 A |HS 11364\\.1 |HS 11550 A |HS 11350 A |HS 11359 |HS 11550 |HS 11379 A |HS 11379 |HS 11377 |'+
                        'HS 11350 |HS 11532 A |HS 11357 [ABC] |HS 11378 |BP 4140 |VC 23222 B |HS 11352 A |HS 11352 |'+
                        'BP 4060 |HS 11360 A |HS 11358 |PC 4573\\.6|HS 11368 |HS 11365 |BP 4149 |HS 11351 |HS 11375 B ';

veh                  := ' COMV |AUTO|VE[C]*H|[/\\. ]M[/]*V[EHICLE/ ]+|[/\\.& ]M[/]*V[/\\.& ]|[/\\.& ]M[\\. ]*V[/\\. ]| MVT[R]* |BOAT|CRAFT| ATV ';
 
traff_list           := 'TRAFFIN|TRAFF[IN]*CIKING|TRAFFI[CK]+[IK]*NG|TRAFFING|TRAFFINKING|TRAFFKG|TRAFFKICKING|TRAFFRKG|TRAFFKING|TRAFFICK|'+
                        '[/\\. ]TRAF[F]+[AI9ROCEKNGS]*[/\\. ]|TRAF[F]+I[CV][KI]+NG';
                                                        
child_set            := '[/\\. ]CHLD[/\\. ]|[/\\. ]CHIL[DREN]*[/\\. ]|MINOR|JUV';

  Is_it := MAP(//In_Global_Exclude(poffense,'other')='Y' => 'N',
							 							 
REGEXFIND('MANUF|SELLING|DIST\\.|SALE|MANUFACTURE|SELL',poffense)   and 
stringlib.stringfind(poffense ,'FALSE'                 ,1) <> 0     and
REGEXFIND('IDENTIFIC|LIC[/]ID| ID |DOCUMENT'           ,poffense)   => 'N', 

REGEXFIND('POSS|DEPOSIT|OPER|SMUGG'    ,poffense) and 
stringlib.stringfind(poffense ,'COIN'  ,1) <> 0   => 'N',
							 
stringlib.stringfind(poffense ,'PORN'  ,1) <> 0   and 
stringlib.stringfind(poffense ,'POSS'  ,1) <> 0   and 
stringlib.stringfind(poffense ,'CHILD' ,1) <> 0   => 'N',

stringlib.stringfind(poffense ,'BAD' ,1) <> 0 and
REGEXFIND('CHECK|[/ ]C[H]*K[/ ]'   ,poffense)   => 'N',

stringlib.stringfind(poffense ,'SPEED' ,1) <> 0 and
REGEXFIND('[0-9]+/[0-9]*'          ,poffense)   => 'N',

stringlib.stringfind(poffense ,'OPER' ,1) <> 0 and
REGEXFIND('UNDER(.*) INF(.*)[ ]*ALCOH|WHILE(.*) INF(.*)[ ]*ALCOH|WHILE(.*) IMPAIRED(.*)[ ]*ALCOH',poffense)   => 'N',

stringlib.stringfind(poffense ,'CIG' ,1) <> 0 and
REGEXFIND('MARIJ|DRUG|CDS'       ,poffense,0) = ''  => 'N',
                              
REGEXFIND('EXPLO|BOMB|INCEN'     ,poffense)   and 
REGEXFIND('DRUG|NARC|CDS'        ,poffense,0) = ''  => 'N',
                                     
REGEXFIND('HEADLIGHT'     			   	,poffense)   and 
REGEXFIND('BEAMS REQUIRED'       ,poffense)    => 'N',
                                     
REGEXFIND(veh                                           ,poffense)   and
REGEXFIND('INFLU|[/\\. ]INF[LUENCE]*[/\\. ]'            ,poffense)   and //DO not include offenses
REGEXFIND('ALCOH|DRUG|NARC'                             ,poffense)    => 'N',	

//Roger's comment from 7/7/16							 
REGEXFIND('ODOMETER| DUI | DWI |SHOPLIFT|CULTIVATED LAND' ,poffense)    => 'N',    // DO not include offenses
  
stringlib.stringfind(poffense ,'BEV' ,1) <> 0  and        // DO not include offenses
REGEXFIND('STAMP'                ,poffense)    => 'N',

/*REGEXFIND(Drug_Narcotica         ,poffense)   and         // DO not include offenses that have speed and school
stringlib.stringfind(poffense ,'SPEED'  ,1) <> 0 and
stringlib.stringfind(poffense ,'SCHOOL' ,1) <> 0 => 'N',

REGEXFIND(Drug_Narcoticb         ,poffense)   and         // DO not include offenses that have speed and school
stringlib.stringfind(poffense ,'SPEED'  ,1) <> 0 and
stringlib.stringfind(poffense ,'SCHOOL' ,1) <> 0 => 'N',

REGEXFIND(Drug_Narcotic1         ,poffense)   and         //DO not include offenses that have speed and school
stringlib.stringfind(poffense ,'SPEED'  ,1) <> 0 and
stringlib.stringfind(poffense ,'SCHOOL' ,1) <> 0 => 'N',

REGEXFIND(Drug_Narcotic2         ,poffense)   and         //DO not include offenses that have speed and school
stringlib.stringfind(poffense ,'SPEED'  ,1) <> 0 and
stringlib.stringfind(poffense ,'SCHOOL' ,1) <> 0 => 'N',

REGEXFIND(Drug_Narcotic3         ,poffense)   and         //DO not include offenses that have speed and school
stringlib.stringfind(poffense ,'SPEED'  ,1) <> 0 and
stringlib.stringfind(poffense ,'SCHOOL' ,1) <> 0 => 'N',*/
//Below stmt replaces the above
stringlib.stringfind(poffense ,'SPEED'  ,1) <> 0 and
stringlib.stringfind(poffense ,'SCHOOL' ,1) <> 0 => 'N',

//QA Update - Drub Round 6 10/24/16
REGEXFIND(Drug_Narcotic3         ,poffense)   and
REGEXFIND('DEL\\.|DEL |DELI[N]*Q|UNRULINESS',poffense)   and
stringlib.stringfind(poffense ,'MINOR' ,1) <> 0 => 'N',

//Roger's comment DUI File QA Check Round 7
REGEXFIND('DRIV[E|I| |\\.]|BOATING|OPR|POSS[ |E]'		 ,poffense)   and
REGEXFIND('CONT[ |/|\\.|R]|PRESURS|PERCURSOR|PRECUS|MISCELLANEOUS'  ,poffense)   and
REGEXFIND('SUBS[T|\\.| |$]|SUB[\\.| |$]'              ,poffense)   and
REGEXFIND('U/I|INFLUEN|UTI'              ,poffense,0) =  '' => 'Y',

REGEXFIND(Drug_Narcotica         ,poffense)   and 
~REGEXFIND(Drug_Narcotic_exc     ,poffense)  => 'Y',	

REGEXFIND(Drug_Narcoticb         ,poffense)   and 
~REGEXFIND(Drug_Narcotic_exc     ,poffense)  => 'Y',	

REGEXFIND('DRIV|DUI|DWI|GAMBL|SURV|DREDG|SPIRIT|CONTEM|RADIO|DAMAGE' ,poffense,0)    <> ''  => 'N',//DO not include offenses
                                                                                                                                               
//Roger's comment on 7/7
REGEXFIND('DU[0-9I]+[\\)| ]'     ,poffense)   => 'Y',															
REGEXFIND('SPEEDING|COIN-OP|PAROLE[/ ]VIOLATOR|TRAFFIC[ ]+PASSING|TRAFFIC[ /]+SPEEDING|TRAFFIC -HOLDING |TRAFFIC[ /]+POSSESSION |TRAFFIC CONTROL LIGHTS|'+
          'NON-TRAFFIC|TRAFFIC INFRACTION|TRAFFIC[ ]INSPECTION|TRAFFIC INSTANDER|TRAFFIC[/ ]INSTRUCTION|TRAFFIC[/ ]INSURANCE|TRAFFIC MISC\\.|'+
  	       'TRAFFIC OFFENSE|TRAFFIC REGISTRATION|TRAFFIC REGULATION|TRAFFIC SPD |TRAFFIC[ ]SPEEDING-SCHOOL|ACT PHYSICAL CONT|SEX',poffense)   and
REGEXFIND('DRUG|CONTR[OLLED]* SUBSTANC' ,poffense,0)    = ''					 => 'N',

REGEXFIND('COUNTER[FEIT]*[ / ]*[CONTROLLED]*[ ]*SUB|COUNTER[FEIT]*[ / ]*[CONTROLLED]*[ ]*DRUG'   ,poffense,0)  <> ''  => 'Y',

stringlib.stringfind(poffense ,'OTHER' ,1) <> 0  and
stringlib.stringfind(poffense ,'DRUG'  ,1) <> 0  and
stringlib.stringfind(poffense ,'OFF'   ,1) <> 0  => 'Y',

stringlib.stringfind(poffense ,'NARC' ,1) <> 0   and
REGEXFIND('DIST|MANUF'                ,poffense) => 'Y',

REGEXFIND('[/\\. ]FEL[/\\. ]|FELONY'  ,poffense) and   
REGEXFIND('DISTRIBUTE  CONTR|DISTRIBUTE-EXTASY|DISTRIBUTE CO|DISTRIBUTE MA|OXCOYNTIN|MFG SUB|MFG/SELL/DIST/MA|CNTROLLED|POSS SHCED',poffense)    => 'Y',							 

REGEXFIND('[/\\. ]DRG[/\\. ]|[/\\. ]CRANK[/\\. ]|[/\\. ]CRANK[/\\. ]|[/\\. ]MDMA[/\\. ]|[/\\. ]THC[/\\. ]'         ,poffense)    and
REGEXFIND('[/\\. ]MFG[D]*[/\\. ]|[/\\. ]W/IN[/\\. ]|[/\\. ]ANALOGUE[/\\. ]'   ,poffense)    => 'Y',

REGEXFIND('COKE[BS]*[/\\. ]|[/\\. ]ANALOGUE[/\\. ]'                                                  ,poffense)    and
REGEXFIND('[/\\. ]MFG[D]*[/\\. ]|[/\\. ]DIST[/\\. ]|[/\\. ]PO[S]+[C]*[/\\. ]' ,poffense)    => 'Y',    

REGEXFIND('[/\\. ]C[/]S[MJ]*[/\\. ]'                                                  ,poffense)    and
REGEXFIND('[/\\. ][ATTEMPTED ]*MFG[D]*[/\\. ]|[/\\. ]DIST[RIBUTEING]*[/\\. ]|[/\\. ][ATTEMPTED ]*PO[S]+[C]*[/\\. ]|[/\\. ]OBTAIN[/\\. ]|[/\\. ]SALE[C/S]*[/\\. ]' ,poffense)    => 'Y',  

REGEXFIND('POSS[/\\. ]'                       ,poffense)    and    
REGEXFIND('[/\\. ]CONT[/\\. ]|CONTRL[D]*'     ,poffense)    and
REGEXFIND('SUSP|[/\\. ]SCH[/\\. ]'            ,poffense)    => 'Y', 

REGEXFIND('[/\\. ]CONT[\\.] S '                                               ,poffense)    and
REGEXFIND('[/\\. ]MFG[D]*[/\\. ]|[/\\. ]DIST[/\\. ]|[/\\. ]DLVR[/\\. ]'       ,poffense)    => 'Y',

REGEXFIND('[/\\. ]CONT[/\\. ]|CONTROLLED'                                     ,poffense)    and
REGEXFIND('[/\\. ]CS[/\\. ]|[/\\. ]SU[/\\. ]|[/\\. ]SUBSGT[/\\. ]'            ,poffense)    => 'Y',

REGEXFIND('C[ON]*TROLLED| C[DSO]+NTROLLED|[/\\. ]C[N]*TROL[/\\. ]| CNTRLD| CNTR[L]*[\\.]| CTRN | CTRSL | C[NT]+RL |CONTRLD|CONT[ROLLED]*[/\\. ]|XCON|CONTROLLED|CONTROL|CONTR|CTRFT |[/\\. ]CTRK[/\\. ]|CONTOL|CONT\\.|CONTRL|CTRL|[/\\. ]CTR[/\\. ]'   ,poffense)    and
REGEXFIND('SUSBSTANCE|SUBSTANC|SUBST|SUBSTANCE|SUBSTANCE|CONSUBS|SUBST  SUB|SUSBS[T]* |SUBST|SUB[SST]+| SUBS|SUBJ |SUBSR|SUB[\\.]|SBSUT|SUBSTY|SUSPT|SUBXFR|SUBJS'  ,poffense)    =>'Y',

REGEXFIND('CODEIN|OPIUM|DRUG'            ,poffense)   and
stringlib.stringfind(poffense ,'DELIV'   ,1) <> 0     =>'Y',
										 
REGEXFIND('SELL|SALE|TRANS'               ,poffense)  and             
( REGEXFIND('PHENCYCLIDINE'               ,poffense)  or
  stringlib.stringfind(poffense  ,'MARJ'  ,1) <> 0    or
  (stringlib.stringfind(poffense ,'CONT'  ,1) <> 0    and stringlib.stringfind(poffense ,'SUB'   ,1) <> 0) 
) => 'Y',	

stringlib.stringfind(poffense ,'UNLAW'           ,1) <> 0   and
REGEXFIND('PURCH|ACQUIR|POSS'                    ,poffense) and
REGEXFIND('EPHEDRINE|PSEUDOEPHEDRINE|CONTROLLED' ,poffense) => 'Y',

stringlib.stringfind(poffense ,'UNLAW'           ,1) <> 0   and
stringlib.stringfind(poffense ,'CONT'            ,1) <> 0   and
REGEXFIND('[/\\. ]SUB[STANCE]*[/\\.() ]|[/\\. ]SUB[STANCE]*$',poffense)    and
REGEXFIND('[/\\. ]OBT[AINGED]*[/\\. ]|CULTIVAT',poffense)    => 'Y',

REGEXFIND('UNLAW'                     ,poffense)   and
REGEXFIND('DEL|DIST'                  ,poffense)   and
( REGEXFIND('COCAIN|[/\\. ]METH[/\\.( ]|[/\\. ]CD[W]*[/\\.( ]|[/\\. ]CS[/\\. ]|[/\\. ]CDS[W]*[/\\.( ]|[/\\.( ]MARJ[UANA]*[/\\.) ]|[/\\. ]MJ[/\\. ]|'+
            '[/\\. ]CD$|[/\\. ]CS$|[/\\. ]CDS$',poffense)   OR
   (stringlib.stringfind(poffense ,'CON'  ,1) <> 0 and stringlib.stringfind(poffense ,'SUB'   ,1) <> 0) 
) => 'Y',	
							 
REGEXFIND('[/\\. ]TRAF[/\\. ]|[/\\. ]TRAFF[/\\. ]|[/\\. ]TRAFFIC[/\\. ]|[/\\. ]TRAN[/\\. ]' ,poffense)     and
REGEXFIND('[/\\. ]POSMJ[/\\. ]|NARCOPTICS|[/\\. ]OXY[/\\. ]|[/\\. ]COC[/\\. ]|PSEDOEPHETIME| CTRFT SUBS |[/\\. ]UPOM[/\\. ]|[/\\. ]UPODP[/\\. ]|MARIHUANA|[/\\. ]MARJ[UANA]*[/\\. ]|[/\\. ]MD[M]*A[/\\. ]|PSEDOEPHETIME |MORPHIN|POSCOC|PARAHERNALIA',poffense)    => 'Y',

REGEXFIND('[/\\. ]COC[/\\. ]' ,poffense)     and
REGEXFIND('[/\\. ]SALE[/\\. ]|NARCOPTICS|[/\\. ]SCH[/\\. ]|[/\\. ]DIS[/\\. ]|[/\\. ]W/IN[T]*[/\\. ]',poffense)    => 'Y',
							 
REGEXFIND('LIKE SU |SUB|SUBS|SUBSTANCE|SUBSTANC|SUBST' ,poffense)   and
REGEXFIND('MFG'                                        ,poffense)   and 
REGEXFIND('LOOK[ -]A[ ]*LIKE|DWELLING| C[N ]*SUB[S]* | SCH\\. | ADULTERATED | SELL | CTR | POSS | UNLAW'                               ,poffense)   => 'Y',							 

REGEXFIND('TRAFFI[CK]+[I]*NG|TRAFFING|TRAFFINKING|TRAFFKG|TRAFFKICKING|TRAFFRKG|TRAFFKING|TRAFFICK' ,poffense)    and
~REGEXFIND(Drug_Narcotic_exc+'|FISH|PERSON|CHILD|FORCED LABOR|PERSON'  ,poffense)  and
stringlib.stringfind(poffense ,'FOOD',1) = 0      => 'Y',

REGEXFIND('KEEP|MAIN'              ,poffense)   and 
REGEXFIND('DWEL|PLAC|HOUSE|VE[C]*H',poffense)   and
REGEXFIND('[/\\. ]TO[/\\. ]|PURP|[/\\. ]FOR[/\\. ]|[/\\. ]USE[D]*[/\\. ]|[/\\. ]CD[S]*[/\\. ]|[/\\. ]LSD[/\\. ]|[/\\. ]MARI[/\\. ]|COCAIN'  ,poffense)   and
REGEXFIND('SELL|DIST'              ,poffense)   => 'Y',

stringlib.stringfind(poffense ,'POSSES',1) <> 0  and 
stringlib.stringfind(poffense ,'HAZARD',1) <> 0  and
stringlib.stringfind(poffense ,'SUB',1) <> 0     => 'Y',	

stringlib.stringfind(poffense ,'PAIN',1) <> 0  and
REGEXFIND('MANGEMENT|[/\\. ]MANAG[MENT]*[/\\. ]|[/\\. ]MG[M]*T[/\\. ]|NONREGIST|[/\\. ]MEDS[/\\. ]|[/\\. ]PILLS[/\\. ]',poffense)   => 'Y',

REGEXFIND('[/\\. ]C[/]S[UBSTANCE]*[/\\. ]|PHENCYCLIDINE| C[/S]NO ',poffense)   and 
stringlib.stringfind(poffense ,'ILLEGAL',1) <> 0     => 'Y',	

REGEXFIND('PARA|POSSESION'              ,poffense)   and 
stringlib.stringfind(poffense ,'DRUG'   ,1) <> 0     => 'Y',	

REGEXFIND('[/\\. ]POS[SESION]*[/\\. ]|PWITD',poffense)   and 
       REGEXFIND('PWITD |[/\\. ]W/DEL[/\\. ]|[/\\. ]W[ITH]* INTENT[/\\. ]|[/\\. ]W[/]I[NTEN]*[/\\. ]|[/\\. ]INT[/\\. ]|[/\\. ]W[/][INTEN]+[/\\. ]|[/\\. ]W[\\. ]*I[\\. ]*T[O\\. ]*D[/\\. ]|[/\\. ]WI[M/ ]*D[EL]*[/\\. ]|[/\\. ]WIT[/ DEL]*[/\\. ]',poffense)   and 
REGEXFIND('WEAP|WPN|TRADEMARKS|PORNO|OBSCENE',poffense,0) = '' and 
REGEXFIND('CONTROLLED SUB|[/\\. ]SCH[/\\. ]|[/\\. ]MFG[/\\. ]|[/\\. ]MNF[/\\. ]|[/\\. ]DIST[RIBUTE]*[/\\. ]|[/\\. ]DEL[IVER]*[/\\. ]|[/\\. ]CS[/\\. ]|[/\\. ]C/S[UBSTANCE]*[/\\. ]| C/SUBMET ',poffense)   => 'Y',	

 REGEXFIND('[/\\. ]POS[S]*|DISTRIB|'+traff_list                                               ,poffense)   and 
 REGEXFIND('METAL|SCANN| TRAFFIC[/ ]|TRAFFIC REG|MOVING|PLATES|TRAFFIC OFFEN|TRAFFIC CONTROL|GAMEFISH|STOLEN PROP|IN STOLE' ,poffense,0) =  '' and 
 (   REGEXFIND('[OU]35[GR]*MJ| [UJS]MJ ',poffense)   OR
     REGEXFIND(drug4                ,poffense)   OR
	    REGEXFIND(drug5                ,poffense)   OR
	    REGEXFIND(drug6                ,poffense)   OR
	    REGEXFIND(Drug7                ,poffense)   OR
     REGEXFIND(' THC[( ]'           ,poffense)  
	 )=> 'Y',

//Roger's comment on 7/27
REGEXFIND('TRAFFIC[K| ]|TRAFF IN|^[ ]*POSS[ |\\.]| POSS |\\-POSS |POSSESSION|^[ ]*PERMIT| PERMIT| ABUSE',poffense)   AND 
(	 REGEXFIND(' DRUG[S \\-]| COCAINE| METH | HEROIN | PROPOXYPHENE | PARA[P| ]| MARIJ[A ]' ,poffense,0) <>  '' OR 
  (REGEXFIND(' CONT[R ]',poffense)    AND REGEXFIND(' SUB[S\\. ]',poffense)  ) OR
  // REGEXFIND(Drug_Ctrl_sub,poffense)   OR
  (REGEXFIND(' PRECU[R ]',poffense)   AND REGEXFIND(' SUB[S\\. ]',poffense)  )	
 )=> 'Y',

REGEXFIND('[/\\.]CS[IX3]*[/\\. ]',poffense)   and 
REGEXFIND('[/\\. ]SAL[E]*[/\\.]|[/\\. ]DEL[/\\.]|[/\\. ]DIST[/\\.]|[/\\. ]OB[T]*[/\\.]|[/\\. ]POS[/\\.]',poffense)   => 'Y',

//*******************************************************************************************************************	 							 
       REGEXFIND(cs_set                   ,poffense,0)  <> '' => 'Y',			

       //very tricky Please don't change the position of this expression and the one above.
       REGEXFIND('[/\\. ]POS[S]*|DISTRIB|'+traff_list                                  ,poffense)   and 
       REGEXFIND('[/\\. ]C[/]*S '                                                      ,poffense7,0) = '' and 
       REGEXFIND('[(]CS TO |[/\\. ]CS TO CF |[/\\. ]CS TO [0-9][0-9] |[/\\. ]CS TO CT ',poffense7,0) <> '' => 'N',
//********************************************************************************************************************

REGEXFIND('DISTRIB[U]*|[/\\. ]DIST[R]*[\\./ ]'                           ,poffense)   and 
REGEXFIND('C[N]*TR[LD]*[\\.] SUB[\\./] | A CS | CRACK|COC B[A]*SE| CTRL[/\\. ]SUB[STANCE]*[/\\. ]|[/\\.]SCH[/\\. ][CSIIV]+|OCAINE|[/\\. ]C/SUBS[TANCE]*[/\\. ]|'+
          'HERO[INE]* |WITHIN (.*)SCHOOL|WITHIN (.*)PARK|SCHOOL ZON|NEAR PARK|NEAR SCHOOL|HARM[FUL]* MATER[IAL]*|COCAIN|CONTROLLED S |ECTASY| LESS THAN| MORE THAN| CSIIA |'+ 
  	       'MRIJUANA|PERECETS|WELLBUTRIAN|CONTROLLED STUBSTANCE|LOOK ALIKE SUB|[/\\. ]PCP[/\\. ]|ILL SUBSTANCE|OF C[\\.]*S[\\.]* |SUB PROX|MAIJUANA|'+
	         'BARBITUATES|COACINE|COAINE|CODEINE|CONCAINE|CONT DANG SU[BS]+T|DEPAKOTE|KLONOPIN| PCP | L S D |SHEDULED SUB| SCHWEDULE II|[/\\. ]CON[RTOLED/\\. ]*SUB[STANCE]*|'+  
          ' CONT. PAR[ ]*$| CONTR. SU[ ]*$| CONTRLD S[ ]*$| CONTROL S[ ]*$| CONTROL[LED\\.]*[ ]*$'    ,poffense)   => 'Y',

stringlib.stringfind(poffense ,'TRAFFIC'  ,1) <> 0  and
REGEXFIND(' A CS |CRACK|COC B[A]*SE| CTRL[/\\. ]SUB[STANCE]*[/\\. ]|[/\\.]SCH[/\\. ][CSIIV/]+|OCAINE|CON[RTOLED/\\. ]*SUB[STANCE]*| HERO[INE]* |WITHIN (.*)SCHOOL|WITHIN (.*)PARK|SCHOOL ZON|NEAR PARK|NEAR SCHOOL|HARM[FUL]* MATER[IAL]*|COCAIN|ECTASY'          ,poffense)   and
REGEXFIND('LEAVING[ THE]* SCENE'          ,poffense,0) = '' => 'Y',

REGEXFIND('POS[S]*'                                                      ,poffense)   and 
REGEXFIND('MAR|/SCH/|SCHED(.*)SUBS'                                      ,poffense,0)<>  '' and 
REGEXFIND('FIREARM|FIREMARM|MARICOPA|MARION|MARIPOSA|MARK|MARLIN|MARSH|MART|MARX|PRIMARY' ,poffense,0) = ''     => 'Y',	 

REGEXFIND('TRA|[/\\. ]TRAF[\\. ]|[/\\. ]TRAN|OBT|DISPENSE'               ,poffense)   and 
REGEXFIND('DRUG|MARI[HJ]|OPIUM|COCAINE|OXYCODONE|ECSTASY|CONT/SCH|/SCH/' ,poffense)   => 'Y',	

     //Roger's comment 7/15 QA Updates - Drugs - Updates After Cannot Classify and Traffic Review
REGEXFIND('^[ ]*MISD[-/ \\.]|^[ ]*MISD[EA]M|^[ ]*MISD\\.|^[ ]*FELONY',poffense)   and 
REGEXFIND('DRUG|SCHEDULE II CS'													,poffense)    => 'Y',	

REGEXFIND('MANU/DEL|MFG/DEL'           ,poffense,0) <>  '' and 
REGEXFIND('SCH/PUB'                    ,poffense)       => 'Y',	 

stringlib.stringfind(poffense ,'DRUG'  ,1) <> 0   and
stringlib.stringfind(poffense ,'MAINT' ,1) <> 0   and
REGEXFIND('DWEL|PLAC|HOUSE|VE[C]*H|CAR',poffense) => 'Y',

stringlib.stringfind(poffense ,'DRUG'  ,1) <> 0   and
REGEXFIND('UNL|UNLAW'                  ,poffense) and 
stringlib.stringfind(poffense ,'DEL'   ,1) <> 0   => 'Y',	

stringlib.stringfind(poffense ,'DRUG'  ,1) <> 0   and
REGEXFIND(child_set                    ,poffense) => 'Y',

stringlib.stringfind(poffense ,'POSS'  ,1) <> 0   and
stringlib.stringfind(poffense ,'CONTR' ,1) <> 0   and
stringlib.stringfind(poffense ,'SUBST' ,1) <> 0  => 'Y',	
      
REGEXFIND('ALCOHOL|SHOTGUN'            ,poffense) and        //Include the ALCOHOL|SHOTGUN offenses  only if
REGEXFIND(Drug2                        ,poffense) => 'Y',    //these words are present  

REGEXFIND('TAMP|STAMP'                 ,poffense)         and              
REGEXFIND('EVIDE|[( ]CS TO'            ,poffense,0) = ''  and 
(REGEXFIND(Drug2                       ,poffense)   )     => 'Y',   

REGEXFIND(Not_Drug_unless              ,poffense)   and               //Include the offenses with keyword in "Not_drug" only if
REGEXFIND('DRUG|PRESCRIP|PRESCIPT|PHENCYCLEDINE|[/\\. ]CDS[/\\. ]' ,poffense)   => 'Y',//the word drug is present  
    			 
stringlib.stringfind(poffense ,'TRANSP',1) <> 0     and
stringlib.stringfind(poffense ,'COC'   ,1) <> 0     => 'Y',	
                                                
stringlib.stringfind(poffense ,'VIO'   ,1) <> 0     and
REGEXFIND('[/\\. ]CDS[/\\. ]'          ,poffense)   and
( 
  (stringlib.stringfind(poffense ,'TRANSP'   ,1) <> 0 and REGEXFIND('PROCE|PRECE'          ,poffense)  ) 				) => 'Y',							 

stringlib.stringfind(poffense ,'MAU'     ,1) <> 0     and
~REGEXFIND(MAU_exc                        ,poffense)  => 'Y',

REGEXFIND('DISTRIBUTION OF|^[ ]DIST OF'  ,poffense)   and 
REGEXFIND('SCHOOL'                       ,poffense)    => 'Y',
			 
REGEXFIND('DISTRIBUTION OF|^[ ]DIST OF'  ,poffense)   and 
~REGEXFIND('PEACE|WORSHIP|PROP|PORN|FIREWORKS|TOBACCO|SEX' ,poffense)  => 'Y',	
			 
stringlib.stringfind(poffense ,'METH'    ,1) <> 0     and
~REGEXFIND('METH[O]*D|FISH'               ,poffense)  => 'Y',	
 
REGEXFIND('[/\\. ]COKE[/\\. ]|[/\\. ]CANN[/\\. ]|[/\\. ]CRACK[/\\. ]|[/\\. ]COC[/\\. ]'                         ,poffense)   and 
REGEXFIND('[/\\. ]SELL[/\\. ]|[/\\. ]DEL[/\\. ]|DELIVER|[/\\. ]TRAF[/\\. ]|TRFK|[/\\. ]TRF[/\\. ]|[/\\. ]PURC[/\\. ]|[/\\. ]MAN[/\\. ]' ,poffense)    => 'Y',
			 
REGEXFIND(Drug8                          ,poffense)    => 'Y',

REGEXFIND(Drug_Narcotic1                 ,poffense)   and 
REGEXFIND(Drug_Narcotic_exc +'|UNLAWFUL LIQUORS'             ,poffense,0) = ''  => 'Y',	
    		 
REGEXFIND(Drug_Narcotic2                 ,poffense)   and 
REGEXFIND(Drug_Narcotic_exc              ,poffense,0) = ''  => 'Y',	
   		 
REGEXFIND(Drug_Narcotic3                 ,poffense)   and 
REGEXFIND(Drug_Narcotic_exc              ,poffense,0) = ''  => 'Y',	

REGEXFIND(Drug_Narcotic4                 ,poffense)   and 
REGEXFIND(Drug_Narcotic_exc+'|LIQUOR'    ,poffense,0) = ''  => 'Y',	

REGEXFIND(Drug_Ctrl_sub                  ,poffense)   and 
REGEXFIND(Drug_Narcotic_exc              ,poffense,0) = ''  => 'Y',								 

REGEXFIND('CONTROLLED SUBSTANCE|SUBST SCHED|VAPOR REL|[/\\. ]DEPRES[S]*[/\\. ]|[/\\. ]STIM[/\\. ]|[/\\. ]HALLUC[/\\. ]|[/\\. ]STEROI[/\\. ]|[/\\. ]OPIATES[/\\. ]|[/\\. ]OPIUM[/\\. ]|[/\\. ]KETAMIN[/\\. ]|[/\\. ]ANABOLIC[/\\. ]|STERIODS|[/\\. ]THC[/\\. ]|[/\\. ]CNTL.D[/\\. ]'          ,poffense7,0) <> '' and 
REGEXFIND('[/\\. ]SELL[/\\. ]|[/\\. ]DEL[IVER]*[/\\. ]|[/\\. ]DISTR[IBUTEION]*[/\\. ]|[/\\. ]POSS[ESSION]*[/\\. ]|[/\\. ]SALE[/\\. ]|[-/\\. ]MANU[FACTURING]*[/\\. ]' ,poffense7,0) <> ''  => 'Y',

REGEXFIND('[/\\. ]OZ[/\\. ]|[/\\. ]GRAM[/\\. ]|[/\\. ]KG[/\\. ]'                            ,poffense)   and 
REGEXFIND('[/\\. ]LESS[/\\. ]|[/\\. ]UNDER[/\\. ]|[/\\. ]LT[/\\. ]'                         ,poffense)   and 
REGEXFIND('[/\\. ]SELL[/\\. ]|[/\\. ]DEL[IVER]*[/\\. ]|[/\\. ]DISTR[IBUTEION][/\\. ]|[/\\. ]POSS[ESSION]*[/\\. ]|[/\\. ]SALE[/\\. ]|[/\\. ]MFG[/\\. ]|[-/\\. ]MANU[FACTURING]*[/\\. ]' ,poffense)    => 'Y',
   				
REGEXFIND('INHALANT|[/\\. ]HERO[INE]*[/\\. ]'               ,poffense7,0) <> '' and 
REGEXFIND('[/\\. ]ABUSE[/\\. ]|[/\\. ]POSS[ESSION]*[/\\. ]' ,poffense7,0) <> ''  => 'Y',

REGEXFIND('^ PCS'                  ,poffense7,0) <> '' and 
REGEXFIND('[/\\. ]W[/]I DL[/\\. ]' ,poffense7,0) <> ''  => 'Y',


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
wpn_ecl              := 'ROB[(B ]+|THEFT|MURD|HOMI|BATT|BURG|BOMB(.)*THREAT|THREAT(.)*BOMB|KIDNAP|AS[S]?AULT|ASSAU|AS[S]?LT |[^| ]AS[AU]*LT| RAPE[/| ]|^[ ]*RAPE |/RAPE|\\.RAPE| RAPE\\-|RAPE$|A[ ]*\\&[ ]*B|HOAX BOMB|ASSULT |ASSUA |AGG[\\/|\\.| ]ASS|AGG[\\/|\\.| ]ASLT|ASSALT |ASSULT |ASSUA|' +
                        ' SEX| LARC| FRAUD| SODOMY|SODMY|/ABDUCT| ABDUCT|MANSLAU|CONCEALED MA[T ]+';

wpn_ecl_2											 := 'ROBB|THEFT|MURD|HOMI|BATT|BURG|BOMB(.)*THREAT|THREAT(.)*BOMB|KIDNAP| RAPE[/| ]|/RAPE|\\.RAPE| RAPE\\-|RAPE$|A[ ]*\\&[ ]*B|HOAX BOMB| SEX| LARC| FRAUD| SODOMY|SODMY|/ABDUCT| ABDUCT|MANSLAU';
wpn_2a               := 'CONCEAL|[/\\.  ]CONC[/\\.  ]';
wpn_2b               := 'WEAPON|WEAP[ON]*[/\\. ]|FIREA|GUN[/\\.]|PIST|KNIFE|F[IRE ]+ARM|[/\\.  ]F.ARM|BOMB|EXPLOS';                       

Is_it := MAP(//In_Global_Exclude(poffense,'other')='Y' => 'N',
							
REGEXFIND('HOAX|FALSE|FALS\\.|WARN|SCARE|FIRE ',poffense)  and 
stringlib.stringfind(poffense ,'BOMB'         ,1) <> 0     => 'N' ,

REGEXFIND('LARC[ E]|TH[E]*FT |STEAL[LING ]+|BURG|MURD|ROBBERY|CAR[ ]*JACK',poffense)   => 'N' ,

stringlib.stringfind(poffense ,'POS'          ,1) <> 0     and
//Roger's comment QA Update - Weapons Law Violations Round 4
REGEXFIND('DEADWE|DEADWEA|SWITCHBLADE|EXPLOVE',poffense)   => 'Y' ,

REGEXFIND('USE|POS|DISP|DISL'                 ,poffense)   and
stringlib.stringfind(poffense ,'FEL'          ,1) <> 0     and
REGEXFIND(' FA | F[/][FZ] | F[-/]A | FA[/ ]|FIRE|FOREARM|FRAM|FRM[/ ]|FRRM|GUN|KNIFE|SHANK',poffense)   and 
REGEXFIND(wpn_ecl                             ,poffense,0) = '' => 'Y' ,

REGEXFIND('STAT|[/\\. ]ST[/\\. ]|INFO'        ,poffense)   and
stringlib.stringfind(poffense ,'PURCH'        ,1) <> 0     and
stringlib.stringfind(poffense ,'FALS'         ,1) <> 0     and
REGEXFIND('[/\\. ]F[/]A[/\\. ]'               ,poffense)   => 'Y',

REGEXFIND('MAK|MAN|PROD|SELL|DISCH|TRANS|USE' ,poffense)   and
stringlib.stringfind(poffense ,'PERM'         ,1) <> 0     and
stringlib.stringfind(poffense ,'DESTR'        ,1) <> 0     and
stringlib.stringfind(poffense ,'DEV'          ,1) <> 0     => 'Y',	

REGEXFIND('MAK|MAN|PROD|SELL|DISCH|PLAC|PROJ|TRANS|USE' ,poffense)   and
stringlib.stringfind(poffense ,'DEV'          ,1) <> 0     and
stringlib.stringfind(poffense ,'DESTR'        ,1) <> 0     and
REGEXFIND(wpn_ecl                             ,poffense,0) = ''  => 'Y' ,

stringlib.stringfind(poffense ,'DESTRUCT'     ,1) <> 0     and
stringlib.stringfind(poffense ,'USE'          ,1) <> 0     and
stringlib.stringfind(poffense ,'REFUSE'       ,1) <> 0     => 'Y',	

REGEXFIND('LOAD|DISCHARGE'                    ,poffense)   and 
REGEXFIND('RIFLE|GUN|WEA|FIR|[/\\. ]F[/]A[/\\. ]|[\\. ]FRM[\\. ]|FIREARM',poffense)   and 
REGEXFIND(wpn_ecl                             ,poffense,0) = ''  => 'Y' ,

REGEXFIND('HANDGUN|GUN|HAV WPNS|H[A]*V[I]*NG W[EAPO]+NS(.*) UND|^[ ]*PISTOL(.*) POSS|WEAP[ON]*|WEAPOSN|FIREA[R]*M|WPN|'+ 
          'F[IRE ]+ARM|WEAP|FIREA|GUN|P[ ]*IST[OL]|KNIFE|F[IRE ]+ARM|[/\\. ]F[/\\.]ARM|BOMB|EXPLOS|PIS[TOL]*[\\.]|[\\.]F[/]A[\\.]'   ,poffense)   and 
REGEXFIND('PERMIT|PRMT'                       ,poffense)   and 
REGEXFIND('[\\. ]NO |RVKD|[\\. ]W[/]O[\\. ]|W/[ ]*OUT|WITHOUT' ,poffense)   and 
~REGEXFIND(wpn_ecl                            ,poffense)  => 'Y' ,

REGEXFIND('CARRY|POSS'                        ,poffense)   and 
REGEXFIND('PISTOL|WEAP|GUN|DAGGER'            ,poffense)   and 
//Code review comment #7, expression is used twice, create wpn_ecl_2
~REGEXFIND(wpn_ecl_2                             ,poffense)  => 'Y' ,

stringlib.stringfind(poffense ,'VIO'          ,1) <> 0     and
REGEXFIND('LIC|PERM'                          ,poffense)   and 
REGEXFIND('CARRY|TRANS'                       ,poffense)   and 
REGEXFIND('PIS|GUN|WEAP'                      ,poffense)   and 
~REGEXFIND(wpn_ecl                            ,poffense)  => 'Y' ,
                                    
stringlib.stringfind(poffense ,'CARRY'        ,1) <> 0     and
 (REGEXFIND('KNIF|ARM|[/\\. ]F[/]A[/\\. ]|CLUB|WEAP|PIST|PISL|RIFLE|KNUCK|REVOL|BAYONET'  ,poffense)   or
 ( stringlib.stringfind(poffense ,'BLACK'     ,1) <> 0 and  stringlib.stringfind(poffense ,'JACK'   ,1) <> 0 ) or
 ( stringlib.stringfind(poffense ,'SWITCH'    ,1) <> 0 and  stringlib.stringfind(poffense ,'BLADE'  ,1) <> 0 )) and 
~REGEXFIND(wpn_ecl                             ,poffense)  => 'Y' ,

//Roger's comment RE: QA Update - Homicide/Weapons Round 5 10/14/16
stringlib.stringfind(poffense ,'SHOOT'        ,1) <> 0 and
stringlib.stringfind(poffense ,'IN CITY'      ,1) <> 0 and
~REGEXFIND(wpn_ecl                            ,poffense)  => 'Y' ,

REGEXFIND(wpn_2a                              ,poffense)   and
REGEXFIND(wpn_2b                              ,poffense)   and
//Code review comment #7, expression is used twice, create wpn_ecl_2
~REGEXFIND(wpn_ecl_2                             ,poffense)  => 'Y' ,

REGEXFIND(Weapon_Law_Violations               ,poffense)   and
~REGEXFIND(wpn_ecl                            ,poffense)   => 'Y' ,	  

//Roger's comment RE: QA Update - Weapon Law Violation Round 6
stringlib.stringfind(poffense ,'ASSAULT'      ,1) <> 0 and
stringlib.stringfind(poffense ,'ROSTER'       ,1) <> 0 and
REGEXFIND('PISTOL|FIREARM|HANDGGUN '          ,poffense)   => 'Y',

REGEXFIND('PC 12020 A |PC 653K|PC 12021 [AC] |PC 417 A |PC 12025 [AB] | PC 12025 |PC 12031 A |PC 12031 |PC 246\\.3| PC 246 |PC 12316 B |PC 29800 A '   ,poffense)   => 'Y',					 

REGEXFIND('[/\\. ]POSS[ESSION]*[/\\. ]|SALE|SELL|[/\\. ]SUP[/\\. ]|SUPPLY|GIVE',poffense)   and
REGEXFIND('ILLEGAL|ILLEG |MINOR'                                  ,poffense)   and
REGEXFIND('[/\\. ]AMMO[/\\. ]|AMMUNITION|[/\\. ]F[/]A[/\\. ]'     ,poffense)   => 'Y',

REGEXFIND('[/\\. ]POSS[ESSION]*[/\\. ]'                           ,poffense)   and
stringlib.stringfind(poffense ,'KNIFE'                            ,1) <> 0 and
REGEXFIND('DURING CRIME'                                          ,poffense)   => 'Y',

stringlib.stringfind(poffense ,'FIREA'                            ,1) <> 0 and
REGEXFIND('BRANDISHING|IMP HAND|USE/DISPLAY|USE OF|IMP\\.HDLG|IMP TRANS|POINT|POSSESSION OF|EX CON|REGISTRATION|FELONY|CONVICT|DEALING|IMPROPER HANDLING|PUR ANI W[/]|CONV PERSN POSS|IMPR[/]HAND|HANDLING|IMPROPER|DISCHARG'  ,poffense)   => 'Y',

'N');
return Is_it;
end;
//--------------------------------------------------------------------------------------------------------------------------------------

export Is_Stolen_Property_Offenses_Fence(string poffense_in) := function //done
special_characters    := '~|!|-|%|\\^|\\+|:|\\(|\\)|,|;|_|#|%|@|\\*|<|>|"|`|\\[|]|\\{|\\}|\\\\|[\\\']';
poffense1             := ' '+REGEXREPLACE(special_characters, poffense_in, ' ');
poffense := stringlib.stringtouppercase(poffense1);

Stolen_Property_Offenses_Fence := 'REC(.*)ST[O]*L(.*)|^[ ]R[/\\. ]*S[/\\. ]*P[0-9/\\. ]|[ /]R[/]S[/]P[R/ ]|RCVESTOLPR|[ ]R[ ]S[ ]PRP| KCSP | RCSP | PC 496 |RECV STLN';
STP_exc := '[0-9]+[/][0-9]+';
Is_it := MAP(//In_Global_Exclude(poffense,'other')='Y' => 'N',

// stringlib.stringfind(poffense ,'GRAND THEFT'     ,1) <> 0 => 'N',  

stringlib.stringfind(poffense ,'STOL'     ,1) <> 0  and 
stringlib.stringfind(poffense ,'PISTOL'   ,1) = 0   and 
REGEXFIND('THEFT|RECEIV|[/\\. ]REC[IEVD]*[/\\. ]|[/\\. ]REC[IEVNG]*[0-9/\\. ]|[/\\. ]RCV[ING]*[/\\. ]|[/\\. ]RVC[/\\. ]|POSS|GOODS|PROP|CONCEAL|BUY|SELL|SALE|TRANS|DEAL|TRAFF|VEH' ,poffense)   and
stringlib.stringfind(poffense ,' TAG'     ,1) = 0  => 'Y',

stringlib.stringfind(poffense ,'THEFT'    ,1) <> 0  and 
REGEXFIND('[/\\. ]REC[IEVD]*[/\\. ]|[/\\. ]REC[IEVNG]*[0-9/\\. ]|[/\\. ]RCV[ING]*[/\\. ]'  ,poffense)   => 'Y',

REGEXFIND('RECEI|CONCEAL'                 ,poffense)   and 
stringlib.stringfind(poffense ,'PROP'     ,1) <> 0     => 'Y',

REGEXFIND('FELON|UNLAW|TAK|STLN'          ,poffense)   and 
REGEXFIND('[/\\. ]REC[IEVE]*[/\\. ]|CONC' ,poffense)   and 
stringlib.stringfind(poffense ,'PROP'     ,1) <> 0     => 'Y',

REGEXFIND('PAWN|PWN|OWN|PWNBRKR'          ,poffense)   and 
stringlib.stringfind(poffense ,'INFO'     ,1) <> 0     => 'Y',

//Roger's comment 7/15/16 QA Updates - Stolen Property
REGEXFIND('OWN |OWN$|OF OWNER[$|/]|OF OWNERS$| OWNE | OWNE$|OWNER METAL|OWN[E]?[R]?[S]?[H]*[I]?[P|$]|' +
          'OWN[D|E|W]ERSHI$|OWNERESHI$|OWNER SHIP|PAWN|[/\\. ]PWN[BROKER]*[/\\. ]|PWNSHIP|APWN BROKER',poffense)   and 
REGEXFIND('VERIF|DECL'                   ,poffense)   and
stringlib.stringfind(poffense ,'BITTEN ' ,1) = 0  => 'Y',
 
//Roger's comment 7/27/16 QA Updates - Drugs						 
// REGEXFIND('RECV STLN'		,poffense)   => 'Y',

REGEXFIND(Stolen_Property_Offenses_Fence ,poffense) and
~REGEXFIND(STP_exc                       ,poffense) => 'Y',

REGEXFIND(' STLN |STOLEN'                ,poffense) and
REGEXFIND('PRPRTY|PROPERTY'              ,poffense) => 'Y',

stringlib.stringfind(poffense ,'POSS'    ,1) <> 0   and 
stringlib.stringfind(poffense ,'RENTED'  ,1) <> 0   and 
REGEXFIND('PRPRTY|PROPERTY|PROP'         ,poffense) => 'Y',

stringlib.stringfind(poffense ,'POSS'    ,1) <> 0   and
REGEXFIND('[/\\. ]VEH[ICLE]*[/\\. ]|[/\\. ]M[/]*V[/\\. ]',poffense)   and
stringlib.stringfind(poffense ,'ALTERED' ,1) <> 0   and
stringlib.stringfind(poffense ,'VIN' ,1) <> 0      => 'Y',

REGEXFIND('[/\\. ]STLN[/\\. ]|STOLEN',poffense)     and
stringlib.stringfind(poffense ,'THINGS' ,1) <> 0    => 'Y',
							 'N');
return Is_it;
end;
//--------------------------------------------------------------------------------------------------------------------------------------

export Is_Identity_Theft(string poffense_in) := function//done

special_characters    := '~|=|!|-|%|\\^|\\+|:|\\(|\\)|,|;|_|#|%|\\*|<|>|"|`|\\[|]|\\{|\\}|\\\\|\\\'';
poffense        := ' '+REGEXREPLACE(special_characters, poffense_in, ' ');

														
Identity_Theft:= 'IDENTITY|TAKE[ THE]IDENTITY|PC 530\\.5 A |PC 529\\.3|PC 368 D |ID TH[E]?FT';
IT_exc        := 'D[AY]+S|SEX|REFUSAL|ACCID[ENT]*|REFUSAL|WEAR.*MASK|MASKED|RESIDENT';	
// SERV[ED]*[ |$]|
IT2           := 'CREDIT|CRED|CRD|DEBIT';
IT_exc2       := 'USE|ABUSE|CHARGE|CHRG|FORG';

Is_it := MAP(//In_Global_Exclude(poffense,'other')='Y' => 'N',

stringlib.stringfind(poffense ,'NAME'    ,1) <> 0   and
REGEXFIND('ASSAUME|ASSUM'              ,poffense)   => 'Y',

stringlib.stringfind(poffense ,'UNLAW' ,1) <> 0     and
REGEXFIND('ACQ|SALE|SELL|USE'          ,poffense)   and
REGEXFIND('[/\\. ]CC[/\\. ]|[/\\. ]C[ ]*/[ ]*C[/\\. ]| CARD|CR CARD| FIN |FINAN',poffense)   => 'Y',						 

~REGEXFIND('RIDE|PRESCRIPT'             ,poffense)  and 
stringlib.stringfind(poffense ,'ANOTHER' ,1) <> 0   and						 
( REGEXFIND('[/\\. ]ID[ENIFICATION]*[/\\. ]|[/\\. ]ID[ENTIFYING]*[/\\. ]| I[/]D |[/\\. ]D[/]LIC[ENSE]*[/\\. ]|[/\\. ][SCO]*D[\\.]*L[/\\. ]|DEBIT',poffense)   OR 
  (REGEXFIND('DRIV'              ,poffense)   AND REGEXFIND('LIC',poffense)   ) or
  (REGEXFIND('CREDIT|[/\\. ]CDT[/\\. ]|[/\\. ]FIN[/\\. ]'    ,poffense)   AND REGEXFIND('CARD|DEV',poffense)   ) 
)									 => 'Y',						                               

stringlib.stringfind(poffense ,'UNAUT' ,1) <> 0   and	
stringlib.stringfind(poffense ,'POSS'  ,1) <> 0   and	
   (REGEXFIND('DEBIT|CREDIT|[/\\. ]ID[ENIFICATION]*[/\\. ]|[/\\. ]ID[ENTIFYING]*[/\\. ]|[/\\. ]DEV[/\\. ]|CARD| I[/]D ',poffense)   OR 
   (REGEXFIND('FIN|CDT'   ,poffense)                AND stringlib.stringfind(poffense ,'CARD' ,1) <> 0  ) or
   (stringlib.stringfind(poffense ,'DRIV' ,1) <> 0  AND stringlib.stringfind(poffense ,'LIC'  ,1) <> 0  ) or
   (stringlib.stringfind(poffense ,'FOOD' ,1) <> 0  AND REGEXFIND('STAMP|STPS',poffense)   ) 
   )	 => 'Y',						 

REGEXFIND(IT2                          ,poffense)   AND 
REGEXFIND('STEAL|LARC|STOL|TAKE|THEFT|LOST|ANOTHER|UNLAW|UNAU'   ,poffense)   => 'Y',

REGEXFIND(Identity_Theft               ,poffense)   AND 
~REGEXFIND(IT_exc                      ,poffense)   => 'Y',	               

// Roger's comment - QA Updates -Theft Round 5 10/11
REGEXFIND('IDENT[ |Y|I|/]'             ,poffense)   AND 
REGEXFIND('TH[E]?FT'			                ,poffense)   AND 
REGEXFIND(IT_exc 								              ,poffense,0)  = '' => 'Y',	   
                                       
REGEXFIND('DISCLOSE|USE'               ,poffense)   and 	
REGEXFIND('CREDIT|DEBIT'               ,poffense)   and
REGEXFIND('CARD| CRD '                 ,poffense)   and 
REGEXFIND('NOS |NUMBER'                ,poffense)   => 'Y',

REGEXFIND('DISCLOSE|USE'               ,poffense)   and 	
REGEXFIND('SIGNATURE'                  ,poffense)   => 'Y',

REGEXFIND('FINANCIAL|FIN'              ,poffense)   and 	
REGEXFIND('TRANSACTION|TRANS'          ,poffense)   and
  (
	  stringlib.stringfind(poffense ,'CARD'  ,1) <> 0  and  stringlib.stringfind(poffense ,'OFFENSE',1) <> 0 or
   stringlib.stringfind(poffense ,'DEVICE',1) <> 0  and  stringlib.stringfind(poffense ,'POSS'   ,1) <> 0 
  )=> 'Y',

REGEXFIND('OBTAIN|USE'                      ,poffense) and 	
stringlib.stringfind(poffense ,'PERSONAL'   ,1) <> 0   and
stringlib.stringfind(poffense ,'IDENTIFYING',1) <> 0   and
stringlib.stringfind(poffense ,'INFO'       ,1) <> 0   => 'Y',
                                       
REGEXFIND('ILLEGAL|[/\\. ]ILL[/\\. ]'  ,poffense)   and 	
stringlib.stringfind(poffense ,'POSS'  ,1) <> 0     and
REGEXFIND('CREDIT|DEBIT'               ,poffense)   and 
REGEXFIND('CARD|[/\\. ]CRD[/\\. ]'     ,poffense)   => 'Y',

'N');
return Is_it;
end;
//--------------------------------------------------------------------------------------------------------------------------------------
   
export Is_Fraud(string poffense_in) := function 

special_characters:= '~|=|!|-|%|\\^|\\+|:|\\(|\\)|,|;|_|#|%|@|\\*|<|>|"|`|\\[|]|\\{|\\}|\\\\|\\\'';
poffense         := ' '+REGEXREPLACE(special_characters, poffense_in, ' ');

Fraud            := 'DECEPTION|ILL(.*) PROC(.*) DR DOC|UNLAW.*POLICE BADGE|UNLAW.*POLICE INSIGNIA|IMP[E]*RSN.*POLICE|'+
                    '^[ ](ATT)[ ]*FR.|MISAPPROPRIATION|MISPRESENT|MISREP|MISAPP FIDUC|F[RAU]+D| FRAID | FRAU |MONEY LAUNDERING|IMPERSONAT| ELECTION|^ELECTION|'+
										'517.312|IC 1871.4 A 1|MONEY LAUD|ASSUME NAME OF|CRIMINAL USE OF PERSONAL I\\.D\\.|CREDIT CARD[ /]|FINANCIAL TRANSACTION CARD|'+
                    'PC 530\\.5 A |PC 529\\.3|PC 368 D |WI 10980 C |WI 10980 C |PC 476A A |PC 476 |PC 532 A | 13A-9-13\\.1|FALSE PERSONATION|HEALTH PROFESSION - UNAUTHORIZED PRACTICE';
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
			 
		 
Is_it := MAP(//In_Global_Exclude(poffense,'other')='Y' => 'N',

Is_Identity_Theft(poffense)='Y' => 'Y',
(REGEXFIND('ILL|UNLIC'                                   ,poffense)   OR 
(REGEXFIND('W[/][0O][/\\. ]|[/\\. ]WO[/\\. ]',poffense)   and REGEXFIND('LIC',poffense)  ))and 	
REGEXFIND('PHARM|[/\\. ]PHAR[/\\. ]|[/\\. ]RX[/\\. ]'    ,poffense)   => 'Y',	                                           

REGEXFIND('TAMP|FALS|[/\\. ]USE[/\\. ]|FICTI|ANOTHER|FAKE|FRAUD|UNAUT' ,poffense)   and 
REGEXFIND('RIDE|PLATE'                                                                 ,poffense,0) = '' and 
(REGEXFIND('LABEL|TRADEMARK|TAG |SERIAL|[/\\. ]VIN[/\\. ]|[/\\. ]ID[ENIFICATION]*[/\\. ]|[/\\. ]ID[ENTIFYING]*[/\\. ]| I[/]D |[/\\. ]D[/]LIC[ENSE]*[/\\. ]|[/\\. ]DL[/\\. ]|DEBIT',poffense)   OR 
(REGEXFIND('[/\\. ]FIN[ANCIALE]*[/\\. ]|CREDIT|CDT ',poffense)   and REGEXFIND('CARD|DEV',poffense)  ) 
)=> 'Y',
							
stringlib.stringfind(poffense ,'TAMP'           ,1) <> 0   and											 
REGEXFIND('GOV[NT\']*[/\\. ]'          ,poffense)   and 
REGEXFIND('[/]LIC|SEAL'                ,poffense)   	=> 'Y',
						 
REGEXFIND('MAKE[INGS]* '                             ,poffense) and 							        
stringlib.stringfind(poffense ,'FALSE ENT'           ,1) <> 0   and									 
(stringlib.stringfind(poffense ,'BOOKS'              ,1) <> 0   or 
 (stringlib.stringfind(poffense ,'CORP'               ,1) <> 0   and stringlib.stringfind(poffense ,'BOOK',1) <> 0 )) => 'Y',						 
						 
stringlib.stringfind(poffense ,'UNLAW'           ,1) <> 0   and
stringlib.stringfind(poffense ,'PRACT'           ,1) <> 0   => 'Y',
             
stringlib.stringfind(poffense ,'WELFARE'           ,1) <> 0   and
(REGEXFIND('TAMP|[/\\. ]G/L[/\\. ] |[/\\. ]FR[/\\. ] |[/\\. ]FD[/\\. ]|FRAUND' ,poffense)   OR							 
REGEXFIND('GRAND|GRNAD',poffense)   and stringlib.stringfind(poffense ,'LAR'           ,1) <> 0 
						       ) => 'Y',		
						       
stringlib.stringfind(poffense ,'WELFARE'           ,1) <> 0   and
REGEXFIND(false_set                      ,poffense)   and
REGEXFIND('KNOW|[/\\. ]APP[/\\. ]| AP[/ ]|INFO|PRENT|STATE|VERIFI|STMT|REPRES' ,poffense)   => 'Y',
						 
stringlib.stringfind(poffense ,'UNLAW'          ,1) <> 0 and 
stringlib.stringfind(poffense ,'OBT'            ,1) <> 0   and
( 						 
  (stringlib.stringfind(poffense ,'PUB' ,1) <> 0  and REGEXFIND('ASSI|ASST| AST ' ,poffense)  ) OR
  (stringlib.stringfind(poffense ,'MED' ,1) <> 0  and stringlib.stringfind(poffense ,'BENE'          ,1) <> 0 ) 
)=> 'Y',

REGEXFIND('UNDE|UNLAW'                  ,poffense)   and 	
(REGEXFIND('OBTAIN|P/ASSIST'            ,poffense)   or
(stringlib.stringfind(poffense ,'PUB' ,1) <> 0    and stringlib.stringfind(poffense ,'ASSIS' ,1) <> 0 ) 
) => 'Y',
						 
stringlib.stringfind(poffense ,'MONEY'          ,1) <> 0   and
stringlib.stringfind(poffense ,'LAUND'          ,1) <> 0   => 'Y',

REGEXFIND('CONCEAL|CONCCEAL|CONCEAML|CONCELAM',poffense)   and 
REGEXFIND('SHOPLIFT|[/\\. ]MERCH[/\\. ]|MERCH[ANDISE]+|OFFENDER|YOUTH|FUGITIVE|CHILD|WEAR.*MASK|MASKED'      ,poffense,0) = '' and 
Is_Weapon_Law_Violations(poffense)               ='N'  and 
Is_Stolen_Property_Offenses_Fence(poffense)      ='N'  => 'Y',

REGEXFIND(f2a                          ,poffense)   and 	
REGEXFIND(f2b                          ,poffense)   => 'Y',

REGEXFIND('SELL|SALE'                            ,poffense)   and 	
REGEXFIND('SECUR|[/\\. ]GOV[ERNMENT]*[/\\. ]'    ,poffense)   and 
Is_Drug_Narcotic(poffense) ='N' => 'Y',

stringlib.stringfind(poffense ,'DEBIT'          ,1) <> 0   and
stringlib.stringfind(poffense ,'CARD'           ,1) <> 0   and
stringlib.stringfind(poffense ,'ABUSE'          ,1) <> 0   => 'Y',
						 
REGEXFIND('[/\\. ]PRAC[TICSENG]*[/\\. ]|[/\\. ]PRCT[/\\. ]|[/\\. ]PRAT[ICE]*[/\\. ]'                 ,poffense)   and 	
REGEXFIND('MEDICINE'                                                                                 ,poffense)   and
REGEXFIND('UNLAW|[/\\. ]W[/]O[/\\. ]|[/\\. ]WO[/\\. ]|WITHOUT|[/\\. ]W[/]OUT[/\\. ]|UNLIC|VIO|UNAUT' ,poffense)   => 'Y',
						 
stringlib.stringfind(poffense ,'UNLIC'             ,1) <> 0   and
stringlib.stringfind(poffense ,'MEDICINE'          ,1) <> 0   => 'Y',
						 
REGEXFIND('CRIM[\\. ]|CRIMINAL'        ,poffense)   and 	
REGEXFIND('SIMUL |SIMULA'              ,poffense)   => 'Y',
 
REGEXFIND('FALSIF|FORG'                ,poffense)   and 	
REGEXFIND('WILL|CODICIL|CONVEY|CONTRA' ,poffense)   => 'Y',
						 
stringlib.stringfind(poffense ,'UNREG'           ,1) <> 0   and
stringlib.stringfind(poffense ,'SECUR'          ,1) <> 0   => 'Y',		
						 
stringlib.stringfind(poffense ,'DECEPT'           ,1) <> 0   and
stringlib.stringfind(poffense ,'WRIT'          ,1) <> 0   => 'Y',								 
						 
REGEXFIND(IDSET                        ,poffense)   and 	
REGEXFIND('[/\\. ]USE[/\\. ]'          ,poffense)   and 
REGEXFIND('PERMIS'                     ,poffense)   and 
REGEXFIND('WITHOUT|[/\\. ]W[/]O[/\\. ]|[/\\. ]W[-]*O[/\\. ]|[/\\. ]NO[/\\. ]' ,poffense)   => 'Y',
						 

stringlib.stringfind(poffense ,'CHEAT'         ,1) <> 0   and
stringlib.stringfind(poffense ,'CHEATHAM'      ,1) = 0   => 'Y',								 
						 
stringlib.stringfind(poffense ,'IMPER'         ,1) <> 0   and
stringlib.stringfind(poffense ,'PUB'           ,1) <> 0   and
stringlib.stringfind(poffense ,'SERV'          ,1) <> 0   => 'Y',									 
						 
REGEXFIND('EVAS[I ]|EVAD[EING ]|VIOL[ATION ]'  ,poffense)   and 	
stringlib.stringfind(poffense ,'TAX'           ,1) <> 0    => 'Y',	

stringlib.stringfind(poffense ,'FAIL'          ,1) <> 0    and
REGEXFIND('PAY|FILE|REPORT'                    ,poffense)   and 	
stringlib.stringfind(poffense ,'TAX'           ,1) <> 0    => 'Y',						

REGEXFIND(false_set                            ,poffense)   and 	
REGEXFIND('REPRESENT|TAX|UNEMPLOY|CLAIM|CITIZEN|CERTIF|AFFID|AFFIRM|AFFM|OBTAI[O]*N|OBT|RECORDS' ,poffense)   => 'Y',

REGEXFIND('UNLAW'      ,poffense)   and 	
( (stringlib.stringfind(poffense ,'USE'     ,1) <> 0   and stringlib.stringfind(poffense ,'TITLE'       ,1) <> 0    ) OR									 
  (REGEXFIND('DISP[LACYINGED]*[/\\. ]'      ,poffense) and REGEXFIND('LICENSE|[/\\. ]LIC[ENCSE]*[/\\. ]',poffense)  ) OR //|SALE
  (REGEXFIND('DISP[LACYINGED]*[/\\. ]'      ,poffense) and REGEXFIND(IDSET                              ,poffense)  ) OR
  (stringlib.stringfind(poffense ,'TRADE'   ,1) <> 0   and stringlib.stringfind(poffense ,'PRACTI'      ,1) <> 0    ) OR
  (stringlib.stringfind(poffense ,'DEAL'    ,1) <> 0   and REGEXFIND('FIDUC|FIDU '                      ,poffense)  ) OR						 
  (stringlib.stringfind(poffense ,'PYRAMID' ,1) <> 0   and REGEXFIND('SCHEME|SCHENE'                    ,poffense)  ) OR
  (REGEXFIND('[/\\. ]OBT[BAINING]*[/\\. ]'           ,poffense) and stringlib.stringfind(poffense ,'DMV' ,1) <> 0  ) OR
  (REGEXFIND('[/\\. ]FIN[NANCIAL]*[/\\. ]|FINA[N]*CE',poffense) and REGEXFIND('DISCLO|TRANS|ACTIV|CARD'  ,poffense)) OR
  (stringlib.stringfind(poffense ,'PROCEED'          ,1) <> 0   and REGEXFIND('[/\\. ]ACT'               ,poffense))
)=> 'Y',
		 
REGEXFIND(false_set+'|FICT'                ,poffense)   and 	
( REGEXFIND('PRETENSE|PRTENSE'             ,poffense)   or
 (REGEXFIND('RECORD|[/\\. ]RCD[S]*[/\\. ]|ENTR|ENTER'   ,poffense)   and REGEXFIND('PUB|CO[R]+P|GOV'            ,poffense)  ) OR
	(REGEXFIND('[/\\. ]INFO[RMATION]*[/\\. ]|FALSE[ ]*INFO',poffense)   and REGEXFIND('NAME|[/\\. ]APP[LICATIONSY]*[/\\. ]|GOV'      ,poffense)  ) OR  //| OFF[I]*C[E]*R|[/\\. ]POLI[CE]*[/\\. ]|[/\\. ]LEO[/\\. ]|LAW ENF
 (REGEXFIND('[/\\. ]INFO[RMATION]*[/\\. ]',poffense)   and REGEXFIND(IDSET                        ,poffense)  ) OR
	(REGEXFIND('STATEMENT| RESID '           ,poffense)   and REGEXFIND('[/\\. ]APP[LICATIONSY]*[/\\. ]|INSURANCE' ,poffense)  ) OR
	(REGEXFIND(IDSET                         ,poffense)   and stringlib.stringfind(poffense ,'COMMIT' ,1) <> 0   ) OR						 
	(stringlib.stringfind(poffense ,'UTTER' ,1) <> 0      and REGEXFIND('FRAUD|BANK|CHECK|PRESC|FORGE|CREDIT|DEBIT|CURRENCY|BILL|NOTE|INSTRU' ,poffense)  ) OR
 (REGEXFIND('DE[C]*LAR|DE[LC]+ARATION|[/\\. ]VERI[FICATION]*[/\\. ]|VERIFICATION'   ,poffense)   and REGEXFIND('OF OWNER| PAWN[BROKER]* |METAL DEAL'    ,poffense)   ) OR
 (REGEXFIND('[/\\. ]APP[LICATIONSY]*[/\\. ]|ASST',poffense)   and REGEXFIND('PROP|WELFARE',poffense)   )
)=> 'Y',
						 
REGEXFIND(false_set              ,poffense)   and 	
REGEXFIND('[/\\. ]INFO[RMATION]*[/\\. ]|FALSE[ ]*INFO|STATEMENT|[/\\. ]STMT[/\\. ]',poffense)   and 
(REGEXFIND('FIREARM|MEDICAID|P[A]*WN[ ]*BR[O]*KER|PAWNED| D[\\. ]L[\\. ]| [O][\\.]L[\\.]|METAL|RECORDS|BOARD AGRI|PRACTITIO|DEALER|'+
           'FINANC| GUN |APPLICA| APPL[/ ]|SCHOOL|GAIN ACCESS|MEDICAL| AID |OWNERSHIP|CANDIDATE(.*)COMM| OATH |SEC OF STATE|MERCHANT| INSUR[ER]* |TITLE|'+
       				'GINSENG|MET RECYCLER|VITAL RECORD|AGRICULTURE|CANDIDACY',poffense)   OR 
 (REGEXFIND('SALE|PURC[HASE]* | PUR '  ,poffense)   and REGEXFIND(' FI | FIR[EARM]* | F/A |ALCOHOL| GU[N]* ' ,poffense)  ) OR
 (stringlib.stringfind(poffense ,'HAND',1)<> 0      and REGEXFIND('PROP[ERTY]* '                             ,poffense)   )						 
)=> 'Y',				 
						                    
REGEXFIND(false_set+'|FICT'      ,poffense)   and 
REGEXFIND('NAME|'+IDSET          ,poffense)   and
stringlib.stringfind(poffense ,'AID'          ,1) = 0    and
stringlib.stringfind(poffense ,'ABET'         ,1) = 0    => 'Y',
						 	     
REGEXFIND(false_set              ,poffense)   and 	
stringlib.stringfind(poffense    ,'PROCU' ,1) <> 0   and
REGEXFIND('LOAN|[/\\. ]CRED[/\\. ]|[/\\. ]CRD[/\\. ]|CREDIT' ,poffense)   => 'Y',
REGEXFIND(Fraud                  ,poffense)   => 'Y',						 
             
REGEXFIND('UNAUT|UNLAW'              ,poffense) and 
REGEXFIND('USE'                      ,poffense) and
stringlib.stringfind(poffense ,'USE' ,1) <> 0   and	
(REGEXFIND('DEBIT|CREDIT'            ,poffense)     OR
(REGEXFIND(' CDT | CR[\\.]'+IDSET                   ,poffense)   and REGEXFIND('CARD'          ,poffense,0)<> '') OR
(REGEXFIND('[/\\. ]FIN[NANCIAL]*[/\\. ]|FINA[N]*CE' ,poffense)   and REGEXFIND('CARD|[/\\. ]DEVI[/\\. ]|[/\\. ]DEV[/\\. ]',poffense,0)<> '') OR
(REGEXFIND('[/\\. ]FIN[NANCIAL]*[/\\. ]|FINA[N]*CE' ,poffense)   and REGEXFIND(IDSET           ,poffense,0)<> '') OR
(REGEXFIND('[/\\. ]DR[IVE]*[/\\. ]|DRIVER'          ,poffense)   and REGEXFIND(LIC_set         ,poffense,0)<> '') 
)=> 'Y',
								     
REGEXFIND('FR[\\.]'             ,poffense)   and 
REGEXFIND('CR[\\.]'             ,poffense)   and 
stringlib.stringfind(poffense ,'CARD'          ,1) <> 0  => 'Y',

stringlib.stringfind(poffense ,'FOOD'          ,1) <> 0  and							      
REGEXFIND('STAMP|[/\\. ]STPS[/\\. ]|STMP' ,poffense)     => 'Y',
						 	     
REGEXFIND(Identity_Theft ,poffense)   AND 
REGEXFIND(IT_exc         ,poffense,0) = ''  AND
(REGEXFIND(IT_exc2a      ,poffense)   OR
 (REGEXFIND(IT_exc2b1    ,poffense)   AND REGEXFIND(IT_exc2b2 ,poffense)   ))
=> 'Y',
	
stringlib.stringfind(poffense ,'DECEPTIVE'          ,1) <> 0    and
stringlib.stringfind(poffense ,'PRACTICE'           ,1) <> 0    => 'Y',									 
       	     
REGEXFIND('VIOL[ATION ]'                       ,poffense)   and 
stringlib.stringfind(poffense ,'BANK'          ,1) <> 0    and
stringlib.stringfind(poffense ,'LAW'           ,1) <> 0    => 'Y',
						       
stringlib.stringfind(poffense ,'FALSE'         ,1) <> 0    and
stringlib.stringfind(poffense ,'INFO'          ,1) <> 0    and
REGEXFIND('ID|DR|NAME|APP|GOV|PUBLIC OFFICIAL' ,poffense)   => 'Y',
									 
REGEXFIND('ESCAPE'                             ,poffense)  and 	
stringlib.stringfind(poffense ,'INTENT'        ,1) <> 0    and
stringlib.stringfind(poffense ,'TAX'           ,1) <> 0    => 'Y',

REGEXFIND(false_set                            ,poffense)  and 	
stringlib.stringfind(poffense ,'APPLY'         ,1) <> 0    and
stringlib.stringfind(poffense ,'BENEFIT'       ,1) <> 0    => 'Y',

REGEXFIND('POSS|SELL'                          ,poffense)  and 	
REGEXFIND('[/\\. ]DOC[/\\. ]|DOCUMENT'         ,poffense)  and 	
stringlib.stringfind(poffense ,'FALSE'         ,1) <> 0    and
stringlib.stringfind(poffense ,'STATUS'        ,1) <> 0    => 'Y',

REGEXFIND('[/\\. ]INF[O]*[/\\. ]|INFORMATION' ,poffense)   and 	
REGEXFIND(false_set                           ,poffense)   and 
REGEXFIND('PWNBRKR'                           ,poffense)   => 'Y',
					 
REGEXFIND('[/\\. ]FIN*[/\\. ]|FINANCIAL'      ,poffense)   and 	
REGEXFIND('[/\\. ]TRANS[/\\. ]|TRANSACTION'   ,poffense)   and 
(
stringlib.stringfind(poffense ,'CARD'  ,1) <> 0  and  stringlib.stringfind(poffense ,'OFFENSE',1) <> 0 or
stringlib.stringfind(poffense ,'DEVICE',1) <> 0  and  stringlib.stringfind(poffense ,'POSS'   ,1) <> 0 
)=> 'Y',
	
REGEXFIND(false_set                           ,poffense)   and 									 
((stringlib.stringfind(poffense ,'GOV'  ,1) <> 0           and  stringlib.stringfind(poffense ,'AGENCY',1) <> 0) or
 (REGEXFIND('[/\\. ]FIN*[/\\. ]|FINANCIAL'   ,poffense)    and  REGEXFIND('[/\\. ]TRANS[/\\. ]|TRANSACTION' ,poffense)) 
)		 => 'Y',
		
REGEXFIND('[/\\. ]INF[O]*[/\\. ]|INFORMATION|VERIFICATION' ,poffense)   and 	
REGEXFIND(false_set                              ,poffense)   and 
stringlib.stringfind(poffense ,'PWNBRK|[/\\. ]PAWN[/\\. ]|PAWNBROKER'         ,1) <> 0   => 'Y',

REGEXFIND('[/\\. ]POSS[/\\. ]|POSSESS|DISPLAY'   ,poffense) and 	
REGEXFIND('PLATE|TAG|TITLE'                      ,poffense) and 
stringlib.stringfind(poffense ,'ANOTHER'         ,1) <> 0   => 'Y',

REGEXFIND('SALE|SELL|USE'                        ,poffense) and 	
stringlib.stringfind(poffense ,'CR CARD'         ,1) <> 0   and
stringlib.stringfind(poffense ,'UNLAW'           ,1) <> 0   => 'Y',

REGEXFIND('[/\\. ]ILL[/\\. ]|ILLEGAL'            ,poffense) and 	
REGEXFIND('[/\\. ]POSS[/\\. ]'                   ,poffense) and 
REGEXFIND('CREDIT|DEBIT'                         ,poffense) and 
REGEXFIND('[/\\. ]CRD[/\\. ]|CARD'               ,poffense) => 'Y',						 

REGEXFIND('OBTAIN|USE'                           ,poffense) and 	
stringlib.stringfind(poffense ,'PERSONAL'        ,1) <> 0   and
stringlib.stringfind(poffense ,'IDENTIFY'        ,1) <> 0   and
REGEXFIND('[/\\. ]INF[O]*[/\\. ]|INFORMATION'    ,poffense)   => 'Y',				 
						   
stringlib.stringfind(poffense ,' UTTER '         ,1) <> 0   and             
stringlib.stringfind(poffense ,'GUTTER'          ,1) = 0 => 'Y',

REGEXFIND('EXP[I]*R[IERD]*|NO|INVALID|NO VALID|REQUIRED| REQ ' ,poffense) and 	
stringlib.stringfind(poffense ,'MEDICAL'                       ,1) <> 0	 and	
REGEXFIND('[/\\. ]CRD[/\\. ]|CARD|CERT|[/\\. ]CT[/\\. ]|CERTIFICATE| CAR | CER ',poffense) => 'Y',	


'N');
return Is_it;
end;																	
//--------------------------------------------------------------------------------------------------------------------------------------

export Is_Gambling(string poffense_in) := function 

special_characters:= '~|=|!|-|%|\\^|\\+|:|\\(|\\)|,|;|_|#|%|@|\\*|<|>|"|`|\\[|]|\\{|\\}|\\\\|\\\'';
poffense          := ' '+REGEXREPLACE(special_characters, poffense_in, ' ');

Gambling                       := 'GAMBL[ING]*|GAMING|[/| ]BETTING|BOOKMAK[INGER]*|SLOT.*MACHINE|DICE.*GAME|GAME.*DICE|LOTTERY.*TICKET|TICKET.*LOTTERY|LOTTERY.* LAW ';

gam1                           := ' SPORT';
gam2                           := 'BRIB|GAM';
  
Is_it := MAP(//In_Global_Exclude(poffense,'other')='Y' => 'N',

             REGEXFIND('[/\\. ]MAK[INGER]*[/\\. ]' ,poffense) and 	
             stringlib.stringfind(poffense ,'BOOK ',1) <> 0   => 'Y',
						 
									    stringlib.stringfind(poffense ,'POOL',1) <> 0   and
             stringlib.stringfind(poffense ,'SELL',1) <> 0   and
             stringlib.stringfind(poffense ,'BOOK',1) <> 0   => 'Y',
						 						
												 REGEXFIND('WAGER|GAMB|GAMG|GAMP' ,poffense,0) <> '' and 	
             REGEXFIND('JUDGE'   ,poffense,0) = '' => 'Y',
					 
             REGEXFIND(gam1      ,poffense)   and 	
             REGEXFIND(gam2      ,poffense)   => 'Y',
						 
             REGEXFIND(Gambling  ,poffense)   => 'Y',	


							 'N');
return Is_it;
end;

//--------------------------------------------------------------------------------------------------------------------------------------

export Is_HumanTrafficking(string poffense_in) := function //done

special_characters    := '~|=|!|-|%|\\^|\\+|:|\\(|\\)|,|;|_|#|@|\\*|>|"|`|\\[|]|\\{|\\}|\\\\|\\\'';
poffense              := ' '+REGEXREPLACE(special_characters, poffense_in, ' ');

HumanTrafficking      := ' COMM[ERCIAL]*[/\\. ].*SEX| COMM[ERCIAL]*[/\\. ].*NUDITY|SEX.*[/\\. ]COMM[ERCIAL]*[/\\. ]|NUDITY.*[/\\. ]COMM[ERCIAL]*[/\\. ]| PC 236 |'+
                         'HUMAN.*TRAF[/F]|HUMAN.*SMUGGL|HUMAN.*[/\\. ]TRA[<]|HUMAN.*TRFC[ :]|TRAF[/F].*HUMAN|SMUGGL.*HUMAN|[/\\. ]TRA[<].*HUMAN|TRFC[ :].*HUMAN';
exc_HT                := 'BURG |ASSA[/|U]|A[S]*LT'; 

child_set := '[/\\. ]CHLD[/\\. ]|[/\\. ]CHIL[DREN]*[/\\. ]|MINOR|JUV';
Is_it := MAP(//In_Global_Exclude(poffense,'other')='Y' => 'N',

REGEXFIND('TRANS[PORT]*[/\\. ]'    ,poffense)   and 
stringlib.stringfind(poffense ,'MINOR',1) <> 0  and 
stringlib.stringfind(poffense ,'INDECENT',1) <> 0  => 'Y',	

REGEXFIND('[/\\. ]SLAV[/\\. ]|LABOR|PROST|PORNO',poffense)   and 
REGEXFIND('FORC|COERC|THREAT'      ,poffense)   => 'Y',	 

REGEXFIND('TRANSP'                 ,poffense)   and 
REGEXFIND(child_set+'|ALIEN'       ,poffense)   and 	
      (~REGEXFIND('BED|ORDER|INTOX|DUI|D\\.U\\.I|D\\.U\\.|DWI|D\\.W\\.I|SAFETY|WEAP|ESCAPE|[/\\. ]CDS[/\\. ]|'+
           'ALCOH|BEER|DRUGS|LIQ|INTOX|SECU|CUSTODY|FAIL|TRUCK|[/\\. ]P[/]U[/\\. ]|REAR|REST|UNSECU|SEAT|DIVISION|TEST|MARI|'+
					      'MOTION|TO|UND|UNDER|LESS|INFLU|FOUR|4|FIVE|5|PICKUP|TR' ,poffense)  //and
) => 'Y',							 

REGEXFIND('SOLICIT|EXPLOIT|CAUS| LURE| LURI|SEDUCE|SEDUCI|PAND',poffense)   and 
REGEXFIND('PROST|PORNO'            ,poffense)   and 	
REGEXFIND(child_set                ,poffense)   => 'Y',	 


REGEXFIND(child_set+'|PERSON|UDOC' ,poffense)      and 
stringlib.stringfind(poffense ,'TRAFFICK',1) <> 0  and 
~REGEXFIND(Drug_Narcotica+'|'+Drug_Narcoticb+'|'+Drug_Narcotic2+'|'+'CONT.*SUBS|EMPLOY.*MINOR' ,poffense) => 'Y',
// +'|'+Drug_Narcotic1+'|'+Drug_Narcotic2

//QA Update - Human trafficking round 6
REGEXFIND('TRAVEL[ING]* TO MEET'                      ,poffense)   and 
REGEXFIND('MINOR|CHILD|PARENT|SOLIC|GUARDIAN'         ,poffense)    => 'Y',
	
									 
stringlib.stringfind(poffense ,'PROST'  ,1) <> 0  and 
stringlib.stringfind(poffense ,'SUPPORT',1) <> 0  and 
REGEXFIND('DERIVING|DERIVE'             ,poffense)   => 'Y',

REGEXFIND('CONTACT|SOLICIT|[/\\. ]SOL[CIT]*[/\\. ]'    ,poffense)   and 
stringlib.stringfind(poffense ,'MINOR'                 ,1) <> 0  and 
stringlib.stringfind(poffense ,'W/INT'                 ,1) <> 0  and 
REGEXFIND('SEX|ONLINE|[/\\. ]ONLN[/\\. ]'              ,poffense)   => 'Y',

REGEXFIND('ONLINE|ONLN'                                ,poffense)   and          
REGEXFIND('[/\\. ]SOL[/\\. ]|SOLIC|SOLICIT'            ,poffense)   and
REGEXFIND(child_set                                    ,poffense)   => 'Y',
			 
REGEXFIND('SOLIC|SOLICIT'                              ,poffense)   and
REGEXFIND(child_set+'IMMORAL PURPOSES|IMMORAL PURPOSE' ,poffense)   => 'Y',

REGEXFIND(HumanTrafficking                             ,poffense)   and
~REGEXFIND(exc_HT                                      ,poffense)   => 'Y',						 
									 
						       'N');
return Is_it;
end;

//--------------------------------------------------------------------------------------------------------------------------------------

export Is_Kidnapping_Abduction(string poffense_in) := function //done
                                            

special_characters    := '~|=|!|-|%|\\^|\\+|:|\\(|\\)|,|;|_|#|@|\\*|>|"|`|\\[|]|\\{|\\}|\\\\|\'';
poffense              := ' '+REGEXREPLACE(special_characters, poffense_in, ' ');
false_set             := 'FALSE|[/\\. ]FAL[STEIFYNG]*[/\\. ]|[/\\. ]FAL[SFEID]*[/\\. ]|[/\\. ]FLS[ELY]*[/\\. ]|[/\\. ]FAL[SFICATION]*[/\\. ]|FALSIFICATION';

Kidnapping_Abduction  := 'PLACE OF CONFINE|CHILD STEALING|HIJACKING|AB[U]*D[U]*CT|KI[DA]+[N]*A[P]+ING|K[I]*DN[A]*P|HOSTAGE|KIDANP|KIDKNA|HIJACKIDNG|PC 236 |PC 207 A ';

Is_it := MAP(//In_Global_Exclude(poffense,'other')='Y' => 'N',

stringlib.stringfind(poffense ,'UNLAW'        ,1) <> 0   and 
REGEXFIND('IMPRIS|RESTR|DENTEN|DETEN'         ,poffense) and  
~REGEXFIND('DOG|ANIMAL'                       ,poffense) => 'Y',

REGEXFIND('CH[I]*LD|MINOR|JUV|KID'            ,poffense) and 
REGEXFIND('LURE|LUR|ENTIC|ABDUC'              ,poffense) and                                                                                                                                                                  
~REGEXFIND('PROST|PORN|FAILURE'               ,poffense) => 'Y',

stringlib.stringfind(poffense ,'RESTRAIN'     ,1) <> 0   and 
REGEXFIND('CRIM|IMPRIS|FELON|ABUSE'           ,poffense) and 
stringlib.stringfind(poffense ,'ORDER'        ,1) = 0    => 'Y',
                                                          
stringlib.stringfind(poffense ,'IMPRISIO'     ,1) <> 0   and 
REGEXFIND(false_set+'[/\\. ]UNL[FULY]*[/\\. ]',poffense) => 'Y',

REGEXFIND('[/\\. ]AGG[RAVTED]*[/\\. ]|[/\\. ]ATT[EMPTED]*[/\\. ]| ATTPT ',poffense)   and 
REGEXFIND('[/ \\.]KI[D]+[/ \\.]|KIDNAP'       ,poffense) => 'Y',                          

stringlib.stringfind(poffense ,'CONFIN'       ,1) <> 0  and 
~REGEXFIND('ESCAP|DOG|ANIMA|INFANT|SAFETY|CARE|SEAT|PET|BULL|SHEP| NO |CAT|W[/]O|FAIL' ,poffense) => 'Y',

REGEXFIND(Kidnapping_Abduction                ,poffense)   => 'Y',	               
							 'N');
return Is_it;
end;
//--------------------------------------------------------------------------------------------------------------------------------------

export Is_Shoplifting(string poffense_in) := function //done

special_characters    := '~|=|!|-|%|\\^|\\+|:|\\(|\\)|,|;|_|#|%|\\*|<|>|"|`|\\[|]|\\{|\\}|\\\\|\\\'';
poffense              := ' '+REGEXREPLACE(special_characters, poffense_in, ' ');
                               
shopl                   := '^[ ]*TH[E]*FT[ ]*SHOP|SHOP[L]+[OI]FT|SHOPFTING|[ ]SHOPL[\\. ]+|[ ]*SHOP[T ]*L[IGFS]+[TING]*|SHO[PF]+[ ]*LIFT|SHOPLFT|[/ ]SHOP[LIFTING]+[/ ]|CHOP SHOP';                                                                           
                                          
Shopl_exc               := 'CHILD STEAL|BURG|VE[C]*H|AUTO|M/V|DECLARCATION|[/ ]M[/]*V[/ ]|CHOP|D[OCTO]*R SHOP|DRESS SHOP';

Larceny                 := 'LAR[A]*C[AENY]*|LAR[AC]+[ENY]|STEAL|SAFECRACK|TH[E]*FT';
Is_it := MAP(//In_Global_Exclude(poffense,'other')='Y' => 'N',             					 
             	  
					 
						 REGEXFIND(Shopl ,poffense)   and 
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
													
Burglary_BreakAndEnter2 := 'SAFE CRACK|PICK.*POCKET|POCKET.*PICK|GRAND[ ]*>|GRAND TFT PROP|W/OUT PAY.*LEAVING GAS STATION|F/T[ |/]PAY.*LEAVING GAS STATION|W/OUT PAY.*REST|F/T[ |/]PAY.*REST|'+
                           'LEAVING GAS STATION.*W/OUT PAY|THEFT[ ]*[ \\-]*[BY ]*CONTROL|'+ 
													 'PC 484 | PC 666 |PC 484E D |PC 484G A |PC 484G | PC 508 |PC 537 A | PC 485 | PC 503 | 2913\\.02 |PC 487 [ABC] |PC 487\\.1| PC 487 D 2 | PC 488 |PC 532 A |812\\.014\\.2C|812\\.014\\.3A|812\\.015|812\\.014\\.2C1';
Larceny                 := 'LAR[A]*C[AENY]*|LAR[AC]+[ENY]|STEAL|SAFECRACK|TH[E]*FT';                                                                                     
Larceny_exc             := 'CHILD STEAL|VE[C]*H|AUTO|[-/ ]M[/]*V[-/ ]|DECLARCATION';

shopl                   := '^[ ]SHOP |TH[E]*FT[ ]*SHOP|SHOP[L]+[OI]FT|SHOPFTING|X[ ]*SHOP[ ]|[- ]SHOP[L\\.]+|SHOP[L\\.]+|[- ]*SHOP[-T ]*L[IGFS]+[TING]*|SHO[PF]+[ ]*LIFT|SHOPLFT|[/ ]SHOP[LIFTING]*[/ ]';                                                                           

Extortion_Blackmail     := 'EXTORT|BLACK[ ]*MAIL|RACKET| RICO ';
EB_exc                  := 'BRACKET';

Embezzlement            := 'B[B]*REACH OF TRUST|EXPLOIT[ATION]*|EMBZ|EMBEZ[ZLE]*|EMZEZZLE|WRONGFUL.*APPRO|MISAPPLY.*ENTRUST|MISAPPLY.*PROP|MISAPPLY.*FUND|PROP.*MISAPPLY';
Emb_ecl                 := 'SEX|PORN|CHILD|MINOR|JUVE';

      
E1a := 'CORRUPT';
E1b := 'MINOR|JUVE|CHILD';
E2a := 'BREACH';
E2b := 'PEAC[E]*';

Is_it := MAP(//In_Global_Exclude(poffense,'other')='Y' => 'N',

REGEXFIND(shopl                ,poffense)   => 'N',
REGEXFIND('^IDENT| IDENT|^ID |IDENTIFY'    ,poffense)   and 
REGEXFIND('TH[E]*FT|TEFT|TEHT|[^| ]FRAUD|INTIMIDAT|CONCEAL' ,poffense)   => 'N',

REGEXFIND('GRAND THEFT'        ,poffense)   and 
REGEXFIND('MOTOR VEH|AUTO|VEHICLE|M[/]VEHICLE|MTR VEH|[/\\. ]VEH[/\\. ]|[/\\. ]M[/]*V[/\\. ]' ,poffense,0) <>  '' => 'N',

REGEXFIND(Burglary_BreakAndEnter2      ,poffense) => 'Y',

// Roger's comment - QA Updates -Theft Round 5 10/11/16
REGEXFIND('STOLEN|THEFT[\\(|/| ]|LARC[ |E]',poffense)   and 
REGEXFIND('AUTO|VEHICLE'                   ,poffense)   and 
stringlib.stringfind(poffense ,'TAG'       ,1) <> 0     => 'Y',	

// REGEXFIND('STOL[EN]*|STLN'                  ,poffense)   and 
// REGEXFIND('TH[E]*FT|REC[EIV]*|RCV|RVC|POSS|GOODS|PROP|CONCEAL|BUY|SELL|SALE|TRANS' ,poffense)   => 'N',

REGEXFIND('REC[EIV]*|RCV'                   ,poffense)  and 
REGEXFIND('TH[E]*FT'                        ,poffense)  and 
stringlib.stringfind(poffense ,'DIRECT'     ,1) = 0     => 'N',

REGEXFIND(Embezzlement                      ,poffense)  and 
~REGEXFIND(Emb_ecl                          ,poffense)  => 'Y',	               
              
// Roger's comment - 7/15 QA Updates -Theft
// Roger's comment - QA Updates -Theft Round 3 8/26
// Roger's comment - QA Updates -Theft Round 4 9/23
REGEXFIND('TH[E]?FT|UNAUTH[O|I]*[RIZED]* USE[ |/]|LARC[ENY]*[ |/]|STEALING|G/T USE',poffense)   and 
REGEXFIND('AUTO|VE[C]*H|[/\\. ]M[/]*V[H/ ]+| M[/]*V |M\\.V[\\.]?| ATV '+
          '|M V TA| MVT| M/VEH',poffense)   and
~REGEXFIND('AMENDED TO EMBEZZ|USE VEH TO |FROM MV| TAG',poffense)  => 'N',

// Roger's comment - QA Updates -Theft Round 4 9/23
REGEXFIND('OMVWOC|^U[\\.]?U[\\.]?M[\\.]?V| U[\\.]?U[\\.]?M[\\.]?V| UNMV|STEAL[ING]*MV|MVTHEFT' ,poffense)   => 'N',

REGEXFIND(' G[/]T '                                        ,poffense)   and 
REGEXFIND('MORE|DWELL| RES | ATT[EMPT]* | COMM |OVER | > ' ,poffense)   and 
~REGEXFIND('AUTO|VE[C]H*|[/\\. ]M[/]*V[H/ ]+| M[/]*V '     ,poffense)   => 'Y',

stringlib.stringfind(poffense ,'UNLAW'   ,1) <> 0   and
(                                                     
  (stringlib.stringfind(poffense ,'GAS'  ,1) <> 0 and REGEXFIND('APPROPRIAT[I]*ON'  ,poffense)  ) OR
	 (stringlib.stringfind(poffense ,'TAK'  ,1) <> 0 and REGEXFIND('TEFT|TEHFT'        ,poffense)  ) OR
	 (stringlib.stringfind(poffense ,'FAIL' ,1) <> 0 and stringlib.stringfind(poffense ,'RTRN',1) <> 0  AND stringlib.stringfind(poffense ,'RENTD',1) <> 0)
)=> 'Y',

stringlib.stringfind(poffense ,'FARE'    ,1) <> 0   and
(
  (REGEXFIND('PAY|VIOL' ,poffense)   and REGEXFIND('FAIL|RAIL|PAIL|NOT| NO |FAIR' ,poffense)  ) OR
	 REGEXFIND('EVAS[I]*ON' ,poffense)   
)=> 'Y',

stringlib.stringfind(poffense ,'DRIV'    ,1) <> 0   and
REGEXFIND('WITHOUT|[/\\. ]W[/]O[/\\. ]'  ,poffense) and 
stringlib.stringfind(poffense ,'PAYING'  ,1) <> 0   => 'Y',
						 
stringlib.stringfind(poffense ,'FAIL'    ,1) <> 0   and
REGEXFIND('RET|REDEL'                    ,poffense) and 
REGEXFIND('LEAS|RENT'                    ,poffense) => 'Y',					 

stringlib.stringfind(poffense ,'UNAUT'   ,1) <> 0   and
stringlib.stringfind(poffense ,'USE'     ,1) <> 0   and
stringlib.stringfind(poffense ,'PROP'    ,1) <> 0   => 'Y',

REGEXFIND('RIDE|RIDING|LEAV'             ,poffense) and 
stringlib.stringfind(poffense ,'PAY'     ,1) <> 0   and 
REGEXFIND('WITHOUT|[/\\. ]W[/]O[/\\. ]'  ,poffense) => 'Y',

stringlib.stringfind(poffense ,'PURSE'   ,1) <> 0   and 
REGEXFIND('SNACH|SNAT|STEL|STOL|STEAL'   ,poffense) => 'Y',

stringlib.stringfind(poffense ,'POCKET'  ,1) <> 0   and 
stringlib.stringfind(poffense ,'BOOK'    ,1) <> 0   and 
REGEXFIND('SNACH|SNAT|STEL|STOL|STEAL'   ,poffense) => 'Y',
				                          

REGEXFIND(Burglary_BreakAndEnter         ,poffense)   and
REGEXFIND(Larceny_exc                    ,poffense,0) = ''  and
REGEXFIND(shopl                          ,poffense,0) = ''  and 
REGEXFIND('LAR[A]*C|THEFT'               ,poffense)   and 
stringlib.stringfind(poffense ,'RED'     ,1) <> 0     => 'Y',

REGEXFIND(Larceny                        ,poffense)  and 
~REGEXFIND(Larceny_exc                   ,poffense)  => 'Y',	         

//Extortion expressions          
REGEXFIND('ORGANIZ| ORG'                 ,poffense)   AND 
REGEXFIND('CRIM|CORR'                    ,poffense)   => 'Y',	
						 
stringlib.stringfind(poffense ,'ENGAG'   ,1) <> 0   and 
stringlib.stringfind(poffense ,'COR'     ,1) <> 0   and 
stringlib.stringfind(poffense ,'ACTIV'   ,1) <> 0   => 'Y',

REGEXFIND(Extortion_Blackmail            ,poffense) and
~REGEXFIND(EB_exc                        ,poffense) => 'Y',

//Embezzlement
stringlib.stringfind(poffense ,'MISAPP'  ,1) <> 0   and 
REGEXFIND('MONEY|[/\\. ]ID[/\\. ]|[/\\. ]FID[/\\. ]|FUNDS|PROP|[/\\. ]PAY[/\\. ]' ,poffense)   => 'Y',

REGEXFIND(E2a                          ,poffense)   and 
REGEXFIND(E2b                          ,poffense,0) = '' => 'Y',

// REGEXFIND('812\\.014\\.2C1|GRAND[ ]*>|GRAND TFT PROP',poffense)   => 'Y',

REGEXFIND('EVAS[I ]|EVAD[EING ]|VIOL[ATION ]' ,poffense)   and 	
stringlib.stringfind(poffense ,'TOLL'  ,1) <> 0     => 'Y',

REGEXFIND('FAIL| FT '                  ,poffense) and 	
stringlib.stringfind(poffense ,'PAY'   ,1) <> 0   and 
stringlib.stringfind(poffense ,'TOLL'  ,1) <> 0   => 'Y',

REGEXFIND('CONCEAL|CONCCEAL|CONCEAML|CONCELAM',poffense)   and 
REGEXFIND('SHOPLIFT|[/\\. ]MERCH[/\\. ]|MERCH[ANDISE]+'      ,poffense)   => 'Y', 

REGEXFIND('PETIT|PETTY'                ,poffense) and 
stringlib.stringfind(poffense ,'FAIL'  ,1) <> 0   and 
stringlib.stringfind(poffense ,'RETURN',1) <> 0   => 'Y',



'N');						 
				 
return Is_it;
end;

//-------------------------------------------------------------

export Is_PeepingTom(string poffense_in) := function //done
  // Please select offenses containing NUD and also contain CAPT  and also contain IMAG. 
 
special_characters:= '~|=|!|-|%|\\^|\\+|:|\\(|\\)|,|;|_|#|@|\\*|<|>|"|`|\\[|]|\\{|\\}|\\\\|\'';
poffense          := ' '+REGEXREPLACE(special_characters, poffense_in, ' ');

PeepingTom   := 'PEEP|VOY[EU]|PRURIENT';

Is_it := MAP(//In_Global_Exclude(poffense,'other')='Y' => 'N',
             
						       stringlib.stringfind(poffense ,'NUD'   ,1) <> 0   and
									    stringlib.stringfind(poffense ,'CAPT'  ,1) <> 0   and
             stringlib.stringfind(poffense ,'IMAG'  ,1) <> 0   => 'Y',

             REGEXFIND(PeepingTom ,poffense,0)          <> '' => 'Y',	               
							 'N');
return Is_it;
end;

//--------------------------------------------------------------------------------------------------------------------------------------

export Is_Prostitution(string poffense_in) := function //done
special_characters    := '~|=|!|-|%|\\^|\\+|:|\\(|\\)|,|;|_|#|%|\\*|<|>|"|`|\\[|]|\\{|\\}|\\\\|\\\'';
poffense              := ' '+REGEXREPLACE(special_characters, poffense_in, ' ');
Prostitution          := 'PROSI|PRSTIT|PROTIT|PROST|PIMP|PAND|PC 647 B |COMMERC.*SEX|SEX.*COMMERC|FORNICAT.*MONEY';
P_exc                 := 'EXPAND|PANHAND';
Is_it := MAP(//In_Global_Exclude(poffense,'other')='Y' => 'N',

stringlib.stringfind(poffense ,'PROMOTE'     ,1) <> 0   and 
stringlib.stringfind(poffense ,'SEX'         ,1) <> 0   and 
REGEXFIND('ACTIV|RELATIONS|IMMORALITY|INTER' ,poffense) => 'Y',
 
REGEXFIND(Prostitution ,poffense)   and
REGEXFIND(P_exc        ,poffense,0) = ''  => 'Y',	               
							 'N');
return Is_it;
end;

//Determine input expression is SOF(SexOffenseForcible), SONF(SexOffenseNonForcible), or NA
shared determine_SOF_SONF(string poffense) := function
	result := MAP(
	
REGEXFIND('FAIL[ |\\.|/|U]| FT[/| ]|F/T' 			  ,poffense,0) <> '' and
							 // REGEXFIND('REGISTER|REIGISTER| REG '						,poffense,0) <> '' and
REGEXFIND('REGISTER|REIGISTER|REG |REQ[I| ]|RESISTER|ADD[\\.R]|STATUS| STAT |CHG |CHNAG',poffense,0)   <> '' and
REGEXFIND('OFFEND'            									,poffense,0) <> '' and
REGEXFIND('[/| ]GUN| CAREER'            				,poffense,0) =  '' 								=> 'SONF',
							 
REGEXFIND('SEX'        						 ,poffense,0) <> '' and 
REGEXFIND('OFF|SEX OF'                		 ,poffense,0) <> '' and
REGEXFIND('REG|CHG ADDR|ADDR|[/\\. ]VIO[LATIONG]*[/\\. ]|[/\\. ]VIO[LATED]*[/\\. ]|VIOLATION|UPDATE|CHG |CHANG', poffense,0) <> ''	=> 'SONF',

REGEXFIND('FAIL[EDTING]*[ |\\.|/|U]| FT[/| ]|F/T' 			  ,poffense,0) <> '' and
REGEXFIND('COMP|CMPLY' ,poffense,0) <> '' and
REGEXFIND('[/\\. ]SEX[UAL]*[/\\. ]|[/\\. ]SX[/\\. ]',poffense,0) <> '' and 
REGEXFIND('OFF|REG'        ,poffense,0) <> ''    							  => 'SONF',
				
REGEXFIND('FAIL[ |\\.|/|U]| FT[/| ]|F/T' 			  ,poffense,0) <> '' and
REGEXFIND('SEX' ,poffense,0) <> ''           AND
REGEXFIND('REGISTER|REG[ |/|\\.]|REGIS[ |T|\\.]|RGSTR |REISTER |RGST |COMPLY|COMP|VERIFY|PROVIDE|'+
					       'ADD |CHANGE|CHNG|CHG |IDENTIFY|POSSESS|PREVENT|ABUSE|PAY COST|MAINT RECORD' ,poffense,0) <> ''  							   => 'SONF',
								 
REGEXFIND('FAIL[ |\\.|/|U]| FT[/| ]|F/T' 			  ,poffense,0) <> '' and
REGEXFIND('SEX' ,poffense,0) <> ''           AND
REGEXFIND('OFF|PRED|VIOL|ASSLT' ,poffense,0) <> '' AND
REGEXFIND('REG |REGISTER|REP[O]?RT|RPT|REP |RPRT|REPT|NOTIFY|GIV NOT|COMPLY|COMP |PROVIDE|'+
          'VERIFY|PROPERTY R|/R/|DL/ID|TO RP' ,poffense,0) <> ''  							  => 'SONF',
 
REGEXFIND('FAILREGISTASSEXOFNDANULY|SEX OFFENDER FAIL TO'						,poffense,0) <> '' 								=> 'SONF',
						  							
REGEXFIND('STAT[A|U|O]*[T]*ORY|STAT |\\-STAT |STAT\\.|STATUTAORY' ,poffense,0) <> '' and
REGEXFIND('SODOMY[\\-| ]|S[O]?DMY[\\-| |1]|RAPE[\\-|\\.| |1]+|INTERCOURSE|CARNAL[\\-| ]' ,poffense,0) <> ''   							  => 'SONF',
				 
					'NA');
	RETURN result;
end;


//--------------------------------------------------------------------------------------------------------------------------------------
export Is_SexOffensesForcible(string poffense_in) := function //done

special_characters    := '~|=|!|-|%|\\^|\\+|:|\\(|\\)|,|;|_|#|%|\\*|>|"|`|\\[|]|\\{|\\}|\\\\|\\\'';
poffense              := ' '+REGEXREPLACE(special_characters, poffense_in, ' ');

SexOffensesForcible   := 'AT[TE]*MP[T]*[/\\. ]CSC[/\\. ]|^[ ]*[/\\. ]ATT CSC[/\\. ]|^[ ]*[/\\. ]C[\\. ]*S[\\. ]*C[/\\. ]|DEG(.*)CSC|VOYEUR|VOYERISM|'+
                         'MOLES|RAPE|[/\\. ]SEX[/\\. ]|SODOM|SODOOMY|SODOBY|SODONY|PENETRAT[ION]*|INTERCOU| IDSI |LASC.*UNNATURAL|LEWD|LASCIVIOUS|L[/]L CONDUCT|SEXBAT|'+
                         'SEXUAL.*CONTACT|SEXUAL.*[/\\. ]COMM[/\\. ]|SEXUAL.*OFFENSE|SEXUAL.*EXPLOIT|SEXUAL.*IMPOS|SEXUAL.*[/\\. ]IMP[/\\. ]|SEXUAL.*FORC[EING]+|SEXUAL.*UNLAWFUL|AGGRAVATED.*SEXUAL|SEXUAL.*ABUSIVE|'+
													            'PC 243\\.4 A |PC 288 [ABC] |PC 261 [A] | PC 220 ';



SexOffensesForcible_exc := 'WRONG SEX|ALLIGATOR|STATU[T]*[AORY]+|INCEST|STAT RAPE|PERFORM|PORN|FILM|MOVIE|TECH|MATERI|CARJACKING|'+
                           'IMPERSON|PROMOTE|PRODUCE|VIDEO|WILDLIFE|COIN|VEND|VE[C]*H|REPRODUC|AUTO| M[/]*V |PRODUCTION|PLATESEXP|'+
													              'PAY COST|POSS PHOTO|SEX MAT|SEXUAL MATERIAL|PERF BY A CHILD|RECORD SEX ACT';

Assault         := 'ABDOM|ABDGR|ABGEN|ABOFF|ABHAN|ABWIK|ABWITK|BATTER|ASSL|ASS[AU]+L[T]*|AS[SL]*LT|CRUELTY|DOM[.MESTIC ]+VIO|ABUSE|INTIMIDAT|PHYSICAL HARM|RETALIATION';
Assault2        := '^[ ]*A[.& ]+B[.]* |^[ ]*A AND B | A[ ]*&[ ]*B |A[ ]*&[ ]*B$|A[.& ]+B[. ]+H[ .&]+A[. ]+N[. ]*|A[. ]+B[. ]+W[ .]+I[. ]+K[. ]*|A[. ]+B[. ]+W[ .]+I[. ]+T[. ]+K[. ]*';

assault_ext     := 'SEX|RAPE|MOLES|PENETRAT';
child_set       := 'M[OI]NOR|[/\\. ]MIN[/\\. ]|JUV|CHI[U]*LD[REN]*|[/\\. ]CHI[KLD]*[/\\. ]|[/\\. ]CH[I]*L[TDEF][/\\. ]|[/\\. ]CHLD[</\\. ]|[/\\. ]CHILED[/\\. ]| CHITL ';

Is_it := MAP(//In_Global_Exclude(poffense,'other')='Y' => 'N',
							 
determine_SOF_SONF(poffense)='SONF' => 'N',

REGEXFIND('PARAPE'                                 ,poffense)   => 'N',							 
 							 
REGEXFIND('THERAPE'                                ,poffense)   and 
REGEXFIND('RAPE'                                   ,poffense)   => 'Y',
 
REGEXFIND('LEWD|LASCIVIOUS|L[/]L CONDUCT|SEXBAT'       ,poffense)   => 'Y',
 
REGEXFIND('LASC'                  ,poffense)   and 
REGEXFIND('UNNATURAL'             ,poffense)   => 'Y', 							 
 
REGEXFIND(child_set                                ,poffense)   and
REGEXFIND('[/\\. ]L[&/]L[/\\. ]|LEWD'              ,poffense)   => 'Y',
 
REGEXFIND(Assault2                                 ,poffense)   and
REGEXFIND(assault_ext                              ,poffense)   => 'Y',

REGEXFIND(SexOffensesForcible                      ,poffense)   and 
REGEXFIND('FORC'                                   ,poffense)   => 'Y',	
 
REGEXFIND(SexOffensesForcible                      ,poffense)   and 
~REGEXFIND(SexOffensesForcible_exc                 ,poffense)   => 'Y',	 
 
REGEXFIND(Assault                                  ,poffense)   and 
REGEXFIND(assault_ext                              ,poffense)    => 'Y',
 
REGEXFIND('ATT |COMMIT|FORCIBLE'                   ,poffense)  and
stringlib.stringfind(poffense ,' SODO '            ,1) <> 0     and 		 
REGEXFIND('[/\\. ]STAT[/\\. ]|STAUTORY|STAT[AU][TAORY]+|STA[T]+O[TO]*R|STATRY',poffense,0) = '' => 'Y',							 
 
REGEXFIND('[/\\. ]SXOFF[/\\. ]|[/\\. ]SX OF[/\\. ]|SEX OFF[E]*ND'  ,poffense)  and 							 
REGEXFIND('[/\\. ]REG[/\\. ]|REGISTER'             ,poffense)   => 'Y',
 
REGEXFIND('CONTACT|SOLICIT|[/\\. ]SOL[CIT]*[/\\. ]',poffense)   and 
REGEXFIND('MINOR.*W/INT'                           ,poffense)   and 

REGEXFIND('SEX|ONLINE|[/\\. ]ONLN[/\\. ]'          ,poffense)   => 'Y',

stringlib.stringfind(poffense ,'SEX'               ,1) <> 0     and 		  
REGEXFIND('CONTACT|ACT|CONDUCT|MISCONDUCT'         ,poffense)   and 
REGEXFIND('CRIM|UNLAW'                             ,poffense)   => 'Y',

stringlib.stringfind(poffense ,'SEXUAL'            ,1) <> 0     and 
stringlib.stringfind(poffense ,'ACT'               ,1) <> 0     and 
REGEXFIND('CHILD|MINOR|FORC[EDING]+'               ,poffense)   => 'Y',

stringlib.stringfind(poffense ,'SEXUAL'            ,1) <> 0     and
REGEXFIND('CONTACT|[/\\. ]COMM[/\\. ]|OFFENSE|EXPLOIT|IMPOS|[/\\. ]IMP[/\\. ]|FORC[EING]+|UNLAWFUL|AGGRAVATED|ABUSIVE' ,poffense)   => 'Y',

REGEXFIND('TRAVEL[ING]* TO MEET'                   ,poffense)   and 
REGEXFIND('MINOR|CHILD|PARENT|SOLIC|GUARDIAN'      ,poffense)    => 'Y',

REGEXFIND('TRANS[PORT]*[/\\. ]'                    ,poffense)   and 
stringlib.stringfind(poffense ,'MINOR'             ,1) <> 0     and
stringlib.stringfind(poffense ,'INDECENT'          ,1) <> 0     => 'Y', 

REGEXFIND('[/\\. ]SLAV[/\\. ]|PROST|PORNO'         ,poffense)   and 
REGEXFIND('FORC|COERC|THREAT'                      ,poffense)   => 'Y',           

REGEXFIND('SOLICIT|EXPLOIT|CAUS| LURE| LURI|SEDUCE|SEDUCI|PAND',poffense)   and     
REGEXFIND('PROST|PORNO'                            ,poffense)   and          
REGEXFIND(child_set                                ,poffense)   => 'Y',
						 
REGEXFIND('ONLINE|ONLN'                            ,poffense)   and          
REGEXFIND('[/\\. ]SOL[/\\. ]|SOLIC|SOLICIT'        ,poffense)   and
REGEXFIND(child_set                                ,poffense)   => 'Y',
						 						 
REGEXFIND('SOLIC|SOLICIT'                              ,poffense)   and
REGEXFIND(child_set+'IMMORAL PURPOSES|IMMORAL PURPOSE' ,poffense)   => 'Y',
						 
							 'N');
return Is_it;
end;

//--------------------------------------------------------------------------------------------------------------------------------------

export Is_SexOffensesNon_forcible(string poffense_in) := function //done

special_characters    := '~|=|!|-|%|\\^|\\+|:|\\(|\\)|,|;|_|#|@|\\*|>|"|`|\\[|]|\\{|\\}|\\\\|\'';
poffense              := ' '+REGEXREPLACE(special_characters, poffense_in, ' ');
    
SexOffensesNon_forcible      := 'STAT[U/ ]*RAPE|STATSODOMY|STATE(.*)[ ]SEX[UAL]* OFF|STATE SEX[UAL]* [OPFFEC ]*REG|REGISTER SEXUAL|SEX.*IMPOSIT|IMPOSIT.*SEX|'+
                                'PC 647\\.6 [A] |PC 647\\.6 |PC 290 [FG]  |PC 290.018 [B] |PC 261.5 [CD] |SEX OF.*CHG ADDR|FORNICAT|INCEST|^[ ]IND[/]CHILD|^[ ]IND[/]EXPOS';
																	
SexOffensesNon_forcible_exc  := 'BURG|OBSCENE|PERFORM|PORN|FILM|MOVIE|COMPUTER|TECH|MATERI|VIDEO|WORDS|GESTURES|PICTURE|PIC|LANGUAGE|PHOTOGRAPH|CONVERSATION|POSING|PHONE|LANUGAGE';

child_set := 'M[OI]NOR|[/\\. ]MIN[/\\. ]|JUV|CHI[U]*LD[REN]*|[/\\. ]CHI[KLD]*[/\\. ]|[/\\. ]CH[I]*L[TDEF][/\\. ]|[/\\. ]CHLD[</\\. ]|[/\\. ]CHILED[/\\. ]| CHITL ';
Is_it := MAP(//In_Global_Exclude(poffense,'other')='Y' => 'N',
	
// Roger's comment - QA Update - Sex Offenses Non-Forcible
determine_SOF_SONF(poffense)='SONF' => 'Y',	

REGEXFIND('EXPOS|EXPOSURE|EXPOSING|EXPSING' ,poffense)   and 
REGEXFIND('SEXUAL OR|SEX(.*)[ ]*(GEN|ORG[ANS]*|PARTS)',poffense)   => 'Y',                

stringlib.stringfind(poffense ,'INDEC'      ,1) <> 0     and 
REGEXFIND(child_set+'| U/[0-9][0-9]* '      ,poffense)  =>  'Y',       

REGEXFIND('[/\\. ]SEX[UAL]*[/\\. ]'  ,poffense)   and 
REGEXFIND('VE[C]*H|AUTO'             ,poffense)   and 
REGEXFIND('USE|HAVING|OFFEN'         ,poffense)   => 'Y',
							 
stringlib.stringfind(poffense ,'FAIL' ,1) <> 0     and
stringlib.stringfind(poffense ,' HIV ',1) <> 0     and
REGEXFIND('STATUS| STAT '             ,poffense)   => 'Y',
       
stringlib.stringfind(poffense ,'UNLAW',1) <> 0     and
REGEXFIND('CONTACT|TOUCH'             ,poffense)   and
REGEXFIND(child_set                   ,poffense)   => 'Y',
       
REGEXFIND('SEX.*ABUSE|ABUSE.*SEX'    ,poffense)   and
REGEXFIND(child_set                  ,poffense)   => 'Y',

REGEXFIND('UNLAW|UNLW'               ,poffense)   and
stringlib.stringfind(poffense ,'COND',1) <> 0     and
REGEXFIND('TOWARD|[/\\. ]TO[/\\. ]'  ,poffense)   and
REGEXFIND(child_set                  ,poffense)   => 'Y',
       
REGEXFIND('UNLAW|UNLW'                 ,poffense)   and
stringlib.stringfind(poffense ,'TRAVEL',1) <> 0     and
stringlib.stringfind(poffense ,'MEET'  ,1) <> 0     and
REGEXFIND(child_set                    ,poffense)   => 'Y',
       
REGEXFIND('[/\\. ]STAT[/\\. ]|STAUTORY|STAT[AU][TAORY]+|STA[T]+O[TO]*R|STATRY'    ,poffense)   and
REGEXFIND('RAPE| SODO |SOD[O]*MY|INTERCOU|[/\\. ]SEX[USAL]*[/\\. ]|CARNAL|MOLEST' ,poffense)     							 => 'Y',	

REGEXFIND('CARNAL|MOLEST'        							      ,poffense)   and
REGEXFIND(child_set+'|DAHGHTER| < |YOA|[/\\. ]YR[/\\. ]| Y | [0-1][0-7]Y |LESS THAN|[/\\. ]AGE[/\\. ]' ,poffense)     => 'Y',
       
REGEXFIND('[/\\. ]NUD[EITY]*[/\\. ]'        		,poffense)   and
REGEXFIND('MASSA'                             ,poffense)   => 'Y',
       
REGEXFIND('[/\\. ]VIO[LATIONG]*[/\\. ]|[/\\. ]VIO[LATED]*[/\\. ]|VIOLATION' ,poffense)   and
REGEXFIND('PARL|LICENSE|[/\\. ]LIC[ENCSE]*[/\\. ]'                          ,poffense)   and
REGEXFIND('MASSA|MASG'                                                      ,poffense)     => 'Y',

REGEXFIND('[/\\. ]NUD[EITY]*[/\\. ]'         ,poffense)   and
REGEXFIND('CAPT'                             ,poffense)   and
stringlib.stringfind(poffense ,'CAPT'        ,1) <> 0     and
REGEXFIND('IMAGE|FILM'                       ,poffense)   and
REGEXFIND('NONCONSENT'                       ,poffense)     => 'Y',
      
stringlib.stringfind(poffense ,'CORRUPT'     ,1) <> 0     and
REGEXFIND(child_set                          ,poffense)     => 'Y',
       
REGEXFIND('INDEC|INDCE|INDENC'                             ,poffense)   and
REGEXFIND('[/\\. ]LIB[ERTYIES]*[/\\. ]|CONTACT|'+child_set ,poffense)     => 'Y',
       							              
REGEXFIND(SexOffensesNon_forcible ,poffense)   => 'Y',

REGEXFIND('SEX|PREDATORY'               ,poffense)   and 
REGEXFIND('OFFENDER'                    ,poffense)   and
REGEXFIND('REGISTR'                     ,poffense)     => 'Y',

stringlib.stringfind(poffense ,'REGISTRATION FORM',1) <> 0  and
stringlib.stringfind(poffense ,'OFFENDER'         ,1) <> 0  and
stringlib.stringfind(poffense ,'SUBMIT'           ,1) <> 0  => 'Y',  
   							 

       'N');
return Is_it;
end;

//--------------------------------------------------------------------------------------------------------------------------------------

export Is_Pornography(string poffense_in) := function //done

special_characters    := '~|=|!|-|%|\\^|\\+|:|\\(|\\)|,|;|_|#|@|\\*|<|>|"|`|\\[|]|\\{|\\}|\\\\|\'';
poffense              := ' '+REGEXREPLACE(special_characters, poffense_in, ' ');
child_set             := '[/\\. ]CHLD[/\\. ]|[/\\. ]CHIL[DREN]*[/\\. ]|MINOR|JUV';
Pornography           := 'PORN|PRODUCE SEX[UAL]* MAT[ERIAL]*[/\\. ]|SEX.*[/\\. ]PERFORM[ANCES]*[/\\. ]|SEX.*PE[R]*FORMANCE|SEX.*PR[E]*FORM[A]*NCE|SEX.*VIDEO|'+
                                '[/\\. ]PERFORM[ANCES]*[/\\. ].*SEX|PE[R]*FORMANCE.*SEX|PR[E]*FORM[A]*NCE.*SEX|VIDEO.*SEX' ;
Obscene               := 'OBSCENITY|OBSCEN|OBSC.*MAT';		
												
exc_obsc              := 'LAMP|LANQUAGE|UTTER|LANG|[\\. ]LAN[DUAGE]*[\\. ]|[/\\. ]CALL[S]*[/\\. ]|PHON[E]*|[/\\. ]WORD[S]*[/\\. ]|[/\\. ]GEST[URES]*[/\\. ]|MESSAGE|BEHAV[IOR]* ';

Is_it := MAP(//In_Global_Exclude(poffense,'other')='Y' 	=> 'N',						 

							 
REGEXFIND('[/\\. ]INDE[/\\. ]'                                ,poffense)    and
REGEXFIND('OBSCENI|UTTER|LANG|[\\. ]LAN[NDUAGE]*[\\. ]|[/\\. ]CALL[S]*[/\\. ]|PHON[E]*|[/\\. ]WORD[S]*[/\\. ]|[/\\. ]GEST[URES]*[/\\. ]|MESSAGE|BEHAV[IOR]* ' ,poffense)   => 'N',							 
  							 							 
REGEXFIND('DI[SC]*ORDERLY|DISORDER|[/\\. ]DIS[ORDER]*[/\\. ]' ,poffense)   and
REGEXFIND('[/\\. ]CON[DUCT]*[/\\. ]'                          ,poffense)   => 'N',

REGEXFIND('TEL MISUSE|TELEPHONE MISUSE'                       ,poffense)   => 'N',

REGEXFIND(Pornography                                         ,poffense)   => 'Y',

REGEXFIND('[/\\. ]NUD[EITY]*[/\\. ]|[/\\. ]INDE[CENTY]*[/\\. ]'                                ,poffense)    and
REGEXFIND('EXHIB[ITION ]+| REPRESENTATION|RECORD[ING]*[/\\. ]|[/\\. ]MAT[ERIALS]*[/\\. ]|WRITING|PERFORMAN|DISPLAY|VIDEO|PHOTO|[/\\. ]POSING|MOVIE|PRINT|PICTURE' ,poffense)   => 'Y',

REGEXFIND('PRODUC[ETION]+|PERFORM|RECORD|[/\\. ]RCRD[/\\. ]| MATERI|VIDEO|PICTURE|FILM|MOVIE|PHOTO' ,poffense)   and 
REGEXFIND('SEXPLOITATION|SEXUAL EXPLOITATION|SEX[UALLY]* EXP[LICIT]* |SEX[UALLY]* VISUAL |SEXUAL EXLICIT| SEX\\.EXPL\\.MAT|SEX ACT|SEX MATERIAL' ,poffense)     => 'Y',

REGEXFIND('[/\\. ]PER[FORMANCEING]*[/\\. ]|[/\\. ]MATERI|VIDEO|PICTURE|FILM|MOVIE|PHOTO' ,poffense)  and 
stringlib.stringfind(poffense ,'SEX'                                                     ,1) <> 0    and
REGEXFIND('PRODUCE|SOLICI| PAND[ERING]*[/\\. ]|POSS|ENGAGE|VOYEURISM|PROMOT|EXPLOIT|DIST[\\.RIBUTE]*|FURNISH|DISPLAY|EXHIBIT|DISSEM|DEVELOP'   ,poffense)     AND
//Roger's comments - QA Updates Pornography 7/11. Remove FISH AND GAME - ...
REGEXFIND('BIRDS|FISH '                                                                  ,poffense,0) = '' => 'Y',
                                   
REGEXFIND(' MAT[ERIALS]*[/\\. ]|TAPE|FILM|IMAGES'            ,poffense+' ',0) <> '' and 
REGEXFIND('PROMOTE|FILM|USE|SELL| EXP[.PLICIT]* |W/O CONSENT|MAKE|DEPICT|[/\\. ]EXP[PLICIT]*[/\\. ]|EXOLICIT|ORIENTED|ABUSIVE|ILLEGAL'     ,poffense)   and 
REGEXFIND('SEXUALLY|SEX|NUDITY ORIENTED'                     ,poffense)   => 'Y',
 
REGEXFIND(' MAT[ERIALS]*[/\\. ]|REPRESE[NATION]*|REPRSNTSNS' ,poffense)   and 
REGEXFIND(' DIST[RIBUTE]* |DEPICT'                           ,poffense)   and 
stringlib.stringfind(poffense ,'NUDITY'                      ,1) <> 0     => 'Y',
			 
REGEXFIND('INDEC|OBSCENE|/OBSC '                             ,poffense)   and
REGEXFIND('EXHIB|PHOTO|MATERIAL|PHOT[O]*GRAPHS'              ,poffense)   and
REGEXFIND('SOLICI|PROC[UREING]*[/\\. ]'                      ,poffense)   => 'Y',

REGEXFIND(Obscene ,poffense)    and
~REGEXFIND(exc_obsc ,poffense) => 'Y',
				          
(Is_Assault_aggr(poffense)='Y' OR Is_Assault_other(poffense)='Y' OR Is_SexOffensesForcible(poffense)='Y') and 
stringlib.stringfind(poffense ,'PORN'              ,1) = 0     => 'N',

stringlib.stringfind(poffense ,'TRAFF'             ,1) <> 0     and
REGEXFIND('SEX|[/\\. ]NUD[ALEITY]*[/\\. ]|INDEC|[/\\. ]INDC[/\\. ]|INDENC|OBSCEN|PORN' ,poffense)    and
REGEXFIND('[/\\. ]MAT[ERIALS]*[/\\. ]'             ,poffense)   => 'Y',	

REGEXFIND('[/\\. ]NUD[ALEITYis]*[/\\. ]'             ,poffense)   and 
REGEXFIND(child_set+'|IMAGE|PUBLICATION|FILM'      ,poffense)   => 'Y',

REGEXFIND('[/\\. ]NUD[EITY]*[/\\. ]'               ,poffense)   and 
stringlib.stringfind(poffense ,'ILL'               ,1) <> 0     and
REGEXFIND('[/\\. ]USE[/\\. ]'                      ,poffense)   => 'Y',

REGEXFIND('[/\\. ]SEX[/\\. ]|PORN'                 ,poffense)   and 
REGEXFIND(child_set                                ,poffense)   and
REGEXFIND('PERF|PROD|PROMOTE|PROM|VIDEO|DIRECT|DIR',poffense)   and
stringlib.stringfind(poffense ,'BATT'              ,1) = 0      => 'Y',  

REGEXFIND('POSS|DISPLAY'                           ,poffense)   and
REGEXFIND('PHOTO|FILM|IMAGE'                       ,poffense)   and
REGEXFIND('[/\\. ]SE[X]*[/\\. ]'                   ,poffense)   => 'Y',  							 

// OBSCENE or SEXUAL  or SEX and also contain MATERIAL or MATERIALS or PERFORMANCE  or  ‘PERFOR’ or ‘PERF’. 

// RECORD or DISTRIBUTE or ‘DIST’ or TRANSMIT  and also contains OBSCENITY.	                      
// REGEXFIND('OBSCENE| MAT[ERIALS]*[/\\. ]|PERF[ORMANCE]*[/\\. ]'       ,poffense+' ',0) <> '' and 
// REGEXFIND('SEXUALLY|SEX'                                     ,poffense)   => 'Y',

// REGEXFIND('PROMOTE|FILM|USE|SELL| EXP[.PLICIT]* |W/O CONSENT|MAKE|DEPICT|[/\\. ]EXP[PLICIT]*[/\\. ]|EXOLICIT|ORIENTED|ABUSIVE|ILLEGAL'     ,poffense)   and 
// REGEXFIND('SEXUALLY|SEX|NUDITY ORIENTED'                     ,poffense)   => 'Y',

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

Is_it := MAP(//In_Global_Exclude(poffense,'TERROR') = 'Y' => 'N',			
			 
 REGEXFIND('REVOC' 																			               ,poffense)   OR
(REGEXFIND('PROBAT', poffense)   AND REGEXFIND('H[O]?LD|VIO[L]?', poffense)  ) => 'N',

//Roger's comment - QA terrorist Threats  Round 5 10/11/16
REGEXFIND(TT2a 																			                  	,poffense)   and
REGEXFIND(TT2b 																				                  ,poffense)   => 'Y',	        
                         
//QA Update - Assault Other round 6
REGEXFIND(Terrorist_Threats 														           ,poffense)   and
stringlib.stringfind(poffense ,'INTENT TO HARM OTHER',1) <> 0      => 'Y',
              
stringlib.stringfind(poffense ,'TERROR'  ,1) <> 0      and
stringlib.stringfind(poffense ,'ACT'  ,1) <> 0  => 'Y',	

REGEXFIND(Terrorist_Threats 														           ,poffense)   and
REGEXFIND(Terrorist_ecl 																             ,poffense,0) =  '' => 'Y',	               

//Roger's comments - QA Update - Terrorist Threats  Round 3 8/26/16
REGEXFIND('RPRT|REP '																  ,poffense)    and
stringlib.stringfind(poffense ,'BOMB'  ,1) <> 0      and
REGEXFIND('FALSE |FALSELY |FALS[ |\\.]',poffense)    => 'Y',	               

//Roger's comments - QA Update - Weapons Law Violations Round 4 9/27/16

stringlib.stringfind(poffense ,'BOMB'         ,1) <> 0     and
REGEXFIND('FALSE[LY]* |HOAX'														    ,poffense)   => 'Y',	               

REGEXFIND('THREAT[EN]*|THRT|WARN|SCARE|FIRE '	,poffense)   and
REGEXFIND(TT2a																					           ,poffense)   => 'Y',	               
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
Is_it := MAP(//In_Global_Exclude(poffense,'TERROR') = 'Y' => 'N',

REGEXFIND('[/\\. ]TPO[/\\. ]|[/\\. ]T\\.P\\.O[/\\. ]' ,poffense)   and 
REGEXFIND(vio_set                                     ,poffense)   => 'Y',
						 
REGEXFIND(vio_set+'|[/\\. ]REV[/\\. ]|[/\\. ]RVK[D]*[/\\. ]|REVO[CKED]*'             ,poffense,0)  <> '' and 
REGEXFIND('[/\\. ]INJ[UNCTION]*[/\\. ]|INJU[NC ]|INJN|INJ$|INJC|INJCT|VIOLINJ|INJTN' ,poffense)   => 'Y',	 
               
REGEXFIND('VIO|REV|RVK[D]*|REVO[CK]*|DISOBE'                    ,poffense)   and 
REGEXFIND('COURT|[/\\. ]CRT[/\\. ]|[/\\. ]CT[/\\. ]|RESTR|PROT' ,poffense)   and 
REGEXFIND('ORD'                                                 ,poffense)   => 'Y',	
							 
REGEXFIND(vio_set                       ,poffense) and 
stringlib.stringfind(poffense ,'CONTACT',1) <> 0   and
REGEXFIND('[/\\. ]NO[/\\. ]'            ,poffense) => 'Y',

REGEXFIND('HOME|'+ vio_set             ,poffense) and 
stringlib.stringfind(poffense ,'PROT'  ,1) <> 0   and
REGEXFIND('ORDER|PERS'                 ,poffense) => 'Y',						 

stringlib.stringfind(poffense ,'DOMEST',1) <> 0   and
REGEXFIND(vio_set                      ,poffense) and 
stringlib.stringfind(poffense ,'COURT' ,1) <> 0   => 'Y',	

REGEXFIND(vio_set                      ,poffense) and 
stringlib.stringfind(poffense ,'RESTR' ,1) <> 0   and
stringlib.stringfind(poffense ,'ORD'   ,1) <> 0   => 'Y',       
      
REGEXFIND(ROV2a                        ,poffense) and	               
REGEXFIND(ROV2b                        ,poffense) => 'Y',	               
 
REGEXFIND(Restraining_Order_Violations ,poffense) => 'Y',

REGEXFIND('[/\\. ]OFP[W]*[/\\. ]|[/\\. ]OPP[/\\. ]'                        ,poffense) and	               
REGEXFIND('[/\\. ]VIO[L]*[/\\. ]|VIOLAT'                        ,poffense) => 'Y',		
               
						 'N');
return Is_it;
end;	 
	  
//--------------------------------------------------------------------------------------------------------------------------------------
export Is_BadChecks(string poffense_in) := function //done

special_characters:= '~|=|!|-|%|\\^|\\+|:|\\(|\\)|,|;|_|#|@|\\*|<|>|"|`|\\[|]|\\{|\\}|\\\\|\'';
poffense          := ' '+REGEXREPLACE(special_characters, poffense_in, ' ');

BadChecks         := ' BD CK | BAD CH| BAD CK| BAD [BEH]+CK | BADC[H]*K[S]*[0-9 ]|PBADCKU|PASBADCHEC|[/ ]PA[DS]+BAD[H]*CK[S]*|[/0-9 ]P[A]*[S][/]*+BADC[HEC]*K[S]*|P[A]*[S]+[BAD]+C[H]*K[S]* | P/BADCK|HOT CHECK|WRIT[E]*BADCK[S]*|'+
                     '^[ ][FEL ]*W/C[ \\$]*[0-9\\.]+|[/\\. ]BAD C[HEC]*KS[/\\. ]|[/\\. ]BAD CK[/\\. ]|PASS BAD|[/\\. ]P[/]*W[/ ]*C[HEC]*K|PASSING BAD|BAD CHECK|'+
										           'POSSBADCKS|PSBDCKSNSF|PSGBADCHEK|POS(.*)BAD(.)*CHE[C]*KS| HOT CHK[S]*|PC 476A A |PC 476 |2913\\.11| 13A[-]9[-]13\\.1';
Bogus_chks        := 'BOGUS [C ]*HECK[/ ]|BOGUS CH|BOGUS CK| BOGU[ ]*SCK|BOGUS [CDW]*HECK[S]*[ /]|PASBOGUSCK';	 

worthless_chks    := 'WORTHLESS CH|WORTHLESS CK|WORTHLESS [CDW]HECK[S]* |PASS(.*)W(.*)CHECK| W/LESSCHKS|FELONY CHECK|'+
                     'WORTHL CHKSF |WORTH CKECK|WORTHLESS [C ]*HECK[/ ]|WORTHLE[S]*CK[ \\.]';											 

ck_set            := 'CH[A]*ECK|[/\\. ]C[E]*H[C]*K[S]*[/\\. ]|[/\\. ]CK[S]*[/\\. ]|[/\\. ]CHCK[/\\. ]|[/\\. ]CHEC[EKHS]*[/\\. ]|'+
                         '[/\\. ]CHE[DX]*K[/\\. ]|[/\\. ]CH[C]*EKC[/\\. ]|[/\\. ]CECK[/\\. ]';                                                                  

Is_it := MAP(//In_Global_Exclude(poffense,'other')='Y' => 'N',

REGEXFIND('[/\\. ]NSF[S]*[-/\\. ]|[/\\. ]INSF[ ]*[FUNDS]+[-/\\. ]|[/\\. ]INSF[CHECK]*[-/\\. ]+|[/\\. ]INSF[FUNDS \\.]+C[HEC]*[CK][S0-9]*[-/\\. ]|[/\\. ]INSFC[HEC]*K[OU]'      ,poffense,0) <> '' => 'Y',
REGEXFIND('[/\\. ]BAD[CHECK]+[-/\\. ]+|[/\\. ]BAD[ ]*+C[HEC]*[CK][S0-9]*[-/\\. ]|[/\\. ]BADC[HEC]*K[OUINSUF]+'      ,poffense,0) <> '' => 'Y',
						 
REGEXFIND('[/\\. ]STP[/\\. ]'        ,poffense,0) <> '' AND     
REGEXFIND('[/\\. ]PAY[MENT]*[/\\. ]' ,poffense,0) <> '' => 'Y',
						 
stringlib.stringfind(poffense ,'UTTER'    ,1) <> 0   AND  
REGEXFIND(ck_set+'|[/\\. ]CH[/\\. ]'      ,poffense) and 
stringlib.stringfind(poffense ,'GUTTER'   ,1) = 0    => 'Y',

REGEXFIND( ck_set,poffense,0) <> '' AND               
REGEXFIND('NON|WITHOUT|[/\\. ]W/O[UT]*[/\\. ]|[/\\. ]NO[/\\. ]|SUFF' ,poffense,0) <> '' AND     
REGEXFIND('FUND| ACCT[\\. ]'                     ,poffense,0) <> '' => 'Y',
						 						 
REGEXFIND('[/\\. ]NO[/\\. ]|CLOSED'              ,poffense,0) <> '' AND     
stringlib.stringfind(poffense ,'ACCOUNT'        ,1) <> 0   => 'Y',
						 
REGEXFIND('NON|WITHOUT|[/\\. ]W/O[UT]*[/\\. ]|[/\\. ]NO |[/\\. ]WO[/\\. ]' ,poffense,0) <> '' AND     
stringlib.stringfind(poffense ,'SUFF'   ,1) <> 0   and 
stringlib.stringfind(poffense ,'FUND'   ,1) <> 0   => 'Y',

REGEXFIND(ck_set ,poffense,0) <> '' AND               
REGEXFIND('ISSUING|ISSUE'            ,poffense,0) <> '' => 'Y',
						 
REGEXFIND('[/\\. ]W[/]C[HECKS]*[/\\. ]|[/\\. ]W\\.C[/\\. ]'                          ,poffense,0) <> ''  AND               
REGEXFIND('ISS|FEL|COST|OBT|SWIND|[\\$0-9]+' ,poffense,0) <> ''  AND               
REGEXFIND('CH[I]*LD|[/\\. ]M[/]*V[/\\. ]|VE[C]*H|FAIL|COMP|COIN|CUST|CLASS|COURT|CHARG|CRIM' ,poffense,0) =  ''  => 'Y',
						 
REGEXFIND(ck_set   ,poffense,0) <> ''   AND               
REGEXFIND('WORTHL|WORTLESS|[/\\. ]W[/]L[/\\. ]|[/\\. ]W[/]LES',poffense,0) <> ''   => 'Y',

stringlib.stringfind(poffense ,'OBT'  ,1) <> 0   and
stringlib.stringfind(poffense ,'PROP' ,1) <> 0   and						 
REGEXFIND('BOGUSCK|WORTHL|W[/]LCK[/\\. ]|[/\\. ]W[/][C]*L[ CHECKS]*[/\\. ]|[/\\. ]W[/]L[CK][/\\. ]|[/\\. ]W[/]L[E]*S|[/\\. ]W[/]*CKS ',poffense,0) <> ''   => 'Y',
						 						 
REGEXFIND('[/\\. ]W[/]CHECK|[/\\. ]W[/]CK[/\\. ]'    ,poffense,0) <> ''   AND               
REGEXFIND('OBT|ISS|SWIND'       ,poffense,0) <> ''   => 'Y',

REGEXFIND('CHECK|CH[C]*K|[/\\. ]CK[/\\. ]'  ,poffense,0) <> ''   AND               
REGEXFIND('WITHOU|[/\\. ]W[/]*O[/\\. ]|[/\\. ]NO[/\\. ]'   ,poffense,0) <> ''   AND 
REGEXFIND('ACCOU|ACCT|[/\\. ]ACC[/\\. ]'     ,poffense,0) <> ''  => 'Y',
						 
REGEXFIND(ck_set   ,poffense,0) <> '' AND               
REGEXFIND('BAD|BO[G]+US|BOGU[D]*|WORTH|[/\\. ]NSF[/\\. ]'          ,poffense,0) <> '' => 'Y',
             
REGEXFIND('INSU[F]+|[/\\. ]NO[/\\. ]'        ,poffense,0) <> '' AND               
stringlib.stringfind(poffense ,'FUND' ,1) <> 0   and               
REGEXFIND('FORG|COUNTERF'       ,poffense,0) = '' => 'Y',	 

REGEXFIND(BadChecks             ,poffense,0) <> '' => 'Y',
REGEXFIND(worthless_chks        ,poffense,0) <> '' => 'Y',	
REGEXFIND(Bogus_chks            ,poffense,0) <> '' => 'Y',	

stringlib.stringfind(poffense  ,'CRIMINAL',1) <> 0   and
stringlib.stringfind(poffense  ,'HOT'     ,1) <> 0   and
(stringlib.stringfind(poffense ,' CHKS '  ,1) <> 0   or stringlib.stringfind(poffense ,' CHK ',1) <> 0)=> 'Y',

REGEXFIND(' VIO[L ]+'                     ,poffense)   AND  
stringlib.stringfind(poffense ,'CHECK'    ,1) <> 0   and
stringlib.stringfind(poffense ,' LAW '    ,1) <> 0   => 'Y',  

stringlib.stringfind(poffense ,'OBTAINING',1) <> 0   and
stringlib.stringfind(poffense ,'PROPERTY' ,1) <> 0   and
stringlib.stringfind(poffense ,' WC '     ,1) <> 0   => 'Y', 						 
 
stringlib.stringfind(poffense ,'WORTHLESS'  ,1) <> 0    and						 
REGEXFIND(' NEG[/\\. ]|NEGOTIAT|ISSU[EING]+',poffense,0) <> '' AND 
REGEXFIND('INSTR[\\.UCTION ]+|DRAFT'        ,poffense,0) <> '' => 'Y',
						 
stringlib.stringfind(poffense ,'CHECK'      ,1) <> 0    and						 
REGEXFIND('ISSU[EING ]+|MAK[EING]+|PASS'    ,poffense,0) <> '' AND 
REGEXFIND('DISHONOR|FICTITI| BD '           ,poffense,0) <> '' => 'Y',						 
						 'N');

return Is_it;
end;
//--------------------------------------------------------------------------------------------------------------------------------------

export Is_CurfewLoiteringVagrancyVio(string poffense_in) := function //done

special_characters:= '~|=|!|-|%|\\^|\\+|:|\\(|\\)|,|;|_|#|@|\\*|<|>|"|`|\\[|]|\\{|\\}|\\\\|\'';
poffense          := ' '+REGEXREPLACE(special_characters, poffense_in, ' ');

CurfewLoiteringVagrancyVio  := 'LOI[T]+|LOTIER|LOUTER|CURF|VAGRA|HOMELES|BEG[G]+IN|BEGG[EA]R|BEGG[/\\. ]|PC 653\\.22 A |HS 11532 A |856\\.021';

Curfew_exc                  := 'EXPLOIT|BEGGINER|HABEGGER ';
Is_it := MAP(//In_Global_Exclude(poffense,'other')='Y' => 'N',

stringlib.stringfind(poffense ,'PAN'      ,1) <> 0 AND 
stringlib.stringfind(poffense ,'OCCUPANT' ,1) =  0 AND 
stringlib.stringfind(poffense ,'HAN'      ,1) <> 0 =>'Y', 

stringlib.stringfind(poffense ,'STAND' ,1) <> 0   AND
REGEXFIND('STAND'                      ,poffense) AND               
REGEXFIND('AROUND|UNLAW|PUBLIC'        ,poffense) AND
REGEXFIND('URINAT|OUTSTAND'            ,poffense,0) =  '' => 'Y',

REGEXFIND('AGG|A[G]+RESS'              ,poffense)   AND               
stringlib.stringfind(poffense ,'PANHND',1) <> 0 =>'Y',

REGEXFIND('AIRPO[R]*T'                 ,poffense)   AND               
REGEXFIND('LIUE|LIEU'                  ,poffense)   AND
REGEXFIND('[/ ]MOTE[/ ]|MOTEL|[/ ]HOTE[/ ]|HOTEL' ,poffense)   => 'Y',

stringlib.stringfind(poffense ,'REMAIN' ,1) <> 0   and
(stringlib.stringfind(poffense ,'SIDEWALK' ,1) <> 0   OR
 (stringlib.stringfind(poffense ,'PUB' ,1) <> 0  AND  REGEXFIND('STREET|PLACE' ,poffense)   ) 						  
)=> 'Y',

REGEXFIND(CurfewLoiteringVagrancyVio ,poffense)   AND
REGEXFIND(Curfew_exc ,poffense,0) = '' => 'Y',	       

REGEXFIND('PROWL[ING ]+'                 ,poffense)   and
REGEXFIND(' VEH[\\.ICLE ]+'              ,poffense,0) = ''  => 'Y',									 
			 
REGEXFIND('SLEEP|[/\\. ]LODG[EING]*[/\\. ]|LODGING|CAMP'   ,poffense)   AND               
stringlib.stringfind(poffense ,'PROHIB'             ,1) <> 0   and
REGEXFIND('[/\\. ]PLAC[/\\. ]|PLACE|AREA|URBAN'     ,poffense)   => 'Y',

REGEXFIND('SLEEP|[/\\. ]LODG[EING]*[/\\. ]|LODGING|CAMP'   ,poffense)   AND               
REGEXFIND('PRIVATE|PUBLIC'     ,poffense)   => 'Y',

						 'N');
return Is_it;
end;


//--------------------------------------------------------------------------------------------------------------------------------------

export Is_Drunkenness(string poffense_in) := function //done

special_characters:= '~|=|!|-|%|\\^|\\+|:|\\(|\\)|,|;|_|#|@|\\*|<|>|"|`|\\[|]|\\{|\\}|\\\\|\'';
poffense          := ' '+REGEXREPLACE(special_characters, poffense_in, ' ');

Drunkenness       := 'PUB[LIC]* INTOX|DRUNKENNESS|DUNKNNESS|INTOXICATION|INTOXICATED IN PUBLIC| 647[ ]*F | 10.010.010 C ';

D3                := 'DISORDER';  
D3a               := 'INTOX|ALCOH';

D1                := 'PUBLIC INTOX|DISORD';
D2                := 'DRIV'; 
D2a               := 'DRUNK';


Is_it := MAP(//In_Global_Exclude(poffense,'other')='Y' => 'N',
             
stringlib.stringfind(poffense ,'INTOX'             ,1) <> 0   and
REGEXFIND('[/\\. ][IO]N[/\\. ]|ALONG|UPON'         ,poffense) and
REGEXFIND('FREEWAY|HIGHWA|HIWAY|[/\\. ]HWY[/\\. ]|ROAD| H[YW] |[/\\. ]RD[/\\. ]| RDWAY|PREM' ,poffense)   => 'Y',

stringlib.stringfind(poffense ,'INTOX'             ,1) <> 0   and
REGEXFIND('[/\\. ]PED[/\\. ]|PEDIS|[/\\. ]PESD[/\\. ]|PEDISTR|PERSON' ,poffense)   => 'Y',

REGEXFIND(D1                                  ,poffense)   and
REGEXFIND(D2                                  ,poffense)   and
REGEXFIND(D2a                                 ,poffense)   => 'Y',

//Roger's comment QA Updates - Drunkenness 7/7
REGEXFIND('DRUNK|INTOX'                       ,poffense)   and
REGEXFIND('PUB|PUBLIC|CITY'                   ,poffense)   => 'Y',

stringlib.stringfind(poffense ,'DRUNK'        ,1) <> 0   and
REGEXFIND('[/\\. ]DR[IVENG]*[/\\. ]|DRIV|[/\\. ]OP[ERATEING]*[/\\. ]|DROV' ,poffense,0) = '' => 'Y',

REGEXFIND('DRINK|DRUNK|INTOX|ALCOH'           ,poffense)   and
REGEXFIND('[/\\. ]D[/]O[/\\. ]|DISRUPT'       ,poffense)   => 'Y',

REGEXFIND(D3                                  ,poffense)   and
REGEXFIND(D3a                                 ,poffense)   => 'Y',

REGEXFIND(' INTOX |INTOXICATION'              ,poffense)   and
REGEXFIND(' DIS | DOC '                       ,poffense)   => 'Y',						 

REGEXFIND(Drunkenness                         ,poffense)   => 'Y',

REGEXFIND('[/\\. ]CONSUMP[/\\. ]|CONSUMPTIO'  ,poffense)   and
stringlib.stringfind(poffense ,'PUBLIC'        ,1) <> 0     => 'Y',		
							 'N');
return Is_it;
end;
//--------------------------------------------------------------------------------------------------------------------------------------
export Is_FamilyOffenses(string poffense) := function

FamilyOffenses  := 'CRIMINAL MISTREATMENT|ALIMONY|PARENTAL RESPONSIBILITY| F S O P C |COMPULSORY EDUCATION|COMPULSORY SCHOOL|TRUANCY|'+
                   'PC 243[(]E[)]| PC 273D |PC 368[(]C[)]|PC 368[(]B[)][(]1| 2919\\.25 |243(E)(1)PC-M PC|'+
                   'PC 273[\\.5 ]+|PC 273A[(][AB2][)]| PC 270 | EC 48262 | EC 48200 | PC 272 ';
fam_excl        := 'NON[ -]*FAMILY|TERR|ASS[AU]*LT|BATT|INCEST|SEX|PORN|RAPE|DELI[N]*Q| DEL ';

fon2a := 'THREAT|ABUS[EING]+|CRUEL|ABANABON|DESERT|SUPPORT|NEGLECT|CONTRIB|ENDANGE';
fon2b := 'FAMILY|CHILD|CHLD|MINOR|SPOUSE|DEPEND|FAM & HSH|FAM[/]HOUSE|FAMILY MEMBER';    
Is_it := MAP(//In_Global_Exclude(poffense,'other')='Y' => 'N',
			 
REGEXFIND('SODOM|RAPE'                 ,poffense)   and 
stringlib.stringfind(poffense ,'THERAPEUTIC' ,1) = 0  => 'N',

REGEXFIND('[- ]FTP[ /]'                ,poffense)   and
REGEXFIND('CHILD|CHD'                  ,poffense)   and
REGEXFIND('SUPP| SP |SAFE'             ,poffense)   => 'Y',

REGEXFIND('OMITTING TO PROVIDE FOR'    ,poffense)   and
REGEXFIND('CHILD|MINOR|CHILDREN'       ,poffense)   => 'Y',

(REGEXFIND('NON|FAIL|WITHHOLD|REFUSE|FLR|OBLIGAT|SPOUS|CHIL|PARENT|PAY|FTP |F[/]T[/]P|CHILD|MINOR|DESERT|PROVID' ,poffense)   OR
  (stringlib.stringfind(poffense ,'CRIM',1) <> 0   and REGEXFIND('NO[- ]',poffense)  )
 )  and   
stringlib.stringfind(poffense ,'SUPPORT',1) <> 0 and 
stringlib.stringfind(poffense ,'REPAIR' ,1) = 0 => 'Y',
      

REGEXFIND('MINOR|CHILD|JUV'               ,poffense)   and 
   (stringlib.stringfind(poffense ,'ABAND',1) <> 0  OR
   (stringlib.stringfind(poffense ,'ABAN' ,1) <> 0  and stringlib.stringfind(poffense ,'PROVIDE',1) <> 0  )
)=> 'Y',
      
REGEXFIND('FAIL|FLR'                      ,poffense)   and 
((stringlib.stringfind(poffense ,'IMPAIR' ,1) <> 0  and stringlib.stringfind(poffense ,'PERS' ,1) <> 0 ) OR
 (stringlib.stringfind(poffense ,'PROTECT',1) <> 0  and stringlib.stringfind(poffense ,'CHILD',1) <> 0 )
)=> 'Y',

REGEXFIND('MINOR|CHILD|JUV'             ,poffense)   and 
stringlib.stringfind(poffense ,'PARENT' ,1) <> 0 and
stringlib.stringfind(poffense ,'VIO'    ,1) <> 0 => 'Y',

stringlib.stringfind(poffense ,'DISRUP' ,1) <> 0 and
stringlib.stringfind(poffense ,'TRANQ'  ,1) <> 0 and
stringlib.stringfind(poffense ,'HOME'   ,1) <> 0 => 'Y',

REGEXFIND('MINOR|JUV'                   ,poffense)   and 
stringlib.stringfind(poffense ,'CONSUM' ,1) <> 0 and
stringlib.stringfind(poffense ,'HOME'   ,1) <> 0 => 'Y',

stringlib.stringfind(poffense ,'REMOV' ,1) <> 0 and
REGEXFIND('MINOR|CHILD|JUV'            ,poffense)   => 'Y',

stringlib.stringfind(poffense ,'NON'      ,1) <> 0 and
stringlib.stringfind(poffense ,'SUPPORT'  ,1) <> 0 and
REGEXFIND('FAMILY|SPOUSE|CHILD|DEPEND|MINOR|CRIM' ,poffense)   => 'Y',


stringlib.stringfind(poffense ,'FAMILY'  ,1) <> 0 and
REGEXFIND('COURT|OFFENSE'              ,poffense)   => 'Y',	

stringlib.stringfind(poffense ,'CHILD' ,1) <> 0 and
stringlib.stringfind(poffense ,'DEPEND',1) <> 0 => 'Y',

stringlib.stringfind(poffense ,'NEGL'  ,1) <> 0 and
REGEXFIND('MINOR|CHILD|CHLD|JUV'       ,poffense)   => 'Y',

REGEXFIND('CHILD|MINOR'                ,poffense)   and 
REGEXFIND('INTERF|INTF'                ,poffense)   and 
stringlib.stringfind(poffense ,'CUS'   ,1) <> 0 => 'Y',

REGEXFIND('CHILD|SPOUSE|DEPEND'        ,poffense)   and 
//Roger's comment QA Update - Family Offenses Round 4
REGEXFIND('NON|FAIL TO'                ,poffense)   and 
stringlib.stringfind(poffense ,'PAY'   ,1) <> 0 => 'Y',

REGEXFIND('CHILD|MINOR|JUV'            ,poffense)   and 
REGEXFIND('LEAV|LV|LEFT'               ,poffense)   and 
REGEXFIND('UNAT| CAR|CAR |VEH|MV|AUTO' ,poffense)   => 'Y',

stringlib.stringfind(poffense ,'SCHOOL' ,1) <> 0 and  
REGEXFIND('ABSENT|SKIP|SEND|SND |ATTEN[ CST]+|ATT[AET]*ND[ANCE]*|TARDY' ,poffense)   => 'Y',

//Roger's comment - QA Update - Family Offenses  Round 3 8/26/16
REGEXFIND('ENDANGERMENT|ENDANGER[ING]' ,poffense)   and  
stringlib.stringfind(poffense ,'CHILD'   ,1) <> 0 => 'Y',
  
trim(poffense) IN [' DOMESTIC',' CRIMINAL DOMESTIC',' REFUSE/RELINQUISH PHONE/DOMES'] => 'Y', //VC 20170519 email req change

REGEXFIND('DOM[ EST]'                                     ,poffense)   and     //VC 20170519 email req change
REGEXFIND('VIO[LENCE \\.]+|ABUS[E]*|ASSAULT|BATTERY|ABDOM',poffense)   => 'Y',

REGEXFIND(FamilyOffenses                     ,poffense)   and 
REGEXFIND(fam_excl                           ,poffense,0) = '' => 'Y',	

REGEXFIND(fon2a                              ,poffense)   and 
REGEXFIND(fon2b                              ,poffense)   and 
REGEXFIND(fam_excl                           ,poffense,0) = '' => 'Y',	

stringlib.stringfind(poffense ,'NONSUPP'     ,1) <> 0     and  
REGEXFIND('MINOR|CHILD'                      ,poffense)   => 'Y',

stringlib.stringfind(poffense ,'INFLICT'     ,1) <> 0     and  
REGEXFIND('[/\\. ]CRPL[/\\. ]|CORPORAL'      ,poffense)   and
REGEXFIND('[/\\. ]INJ[/\\. ]'                ,poffense)   => 'Y',

REGEXFIND('INTERFER|DEPRIVE|DEPRIVING'       ,poffense)   and
stringlib.stringfind(poffense ,'CUSTODY'     ,1) <> 0     and  
REGEXFIND('PARENT|GUARDIAN|[/\\. ]GUA[/\\. ]|[/\\. ]PAR[/\\. ]' ,poffense)   => 'Y',
                              

REGEXFIND(' CORP |CORPORAL|TRAUMA|INJ[ URY]+',poffense)   and
REGEXFIND('SPOUSE|COHABIT|COHABITANT| COHA ' ,poffense)   => 'Y',

REGEXFIND('MALICIOUS|^CORP[ORAL]*[/\\. ]|[/\\. ]CORP[ORAL]*[/\\. ]' ,poffense)   and
REGEXFIND('PUNISH[MENT\\. ]*'                       ,poffense)   and
REGEXFIND('CHILD|MINOR'                             ,poffense)   => 'Y',
									 
'N');
return       Is_it;
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

Is_it := MAP(//In_Global_Exclude(poffense,'other')='Y' OR
						       Is_Drunkenness(poffense)='Y'   OR     
						       Is_DrivingUndertheInfluence(poffense)='Y'	=> 'N',

stringlib.stringfind(poffense ,'DRIV'     ,1) <> 0     and
REGEXFIND('UNDER|WHILE'        	         	,poffense)   and  
REGEXFIND('INFL[EU]|INLFU'     		         ,poffense)   => 'N',

stringlib.stringfind(poffense ,'DRIV'     ,1) <> 0     and
REGEXFIND('INTOX|W/INTOX'     		          ,poffense)   => 'N',

REGEXFIND(alc_set                         ,poffense)   AND
REGEXFIND('FALSE'                         ,poffense)   AND
REGEXFIND('STATEMENT|EVIDEN|APPLI|REPP'   ,poffense)    => 'Y',
      
REGEXFIND('BP 25662|BP 25658 A |BP 25620|VC 23223 B |VC 23224 A |OPEN FLASK| T[\\.][ ]*O[\\.][ ]*C[\\.]| BP 25620| BP 25662 A |OPEN BOTTLE|OPEN/C PUBLIC PLACE'  ,poffense)    => 'Y',
 
REGEXFIND('CONSUMPTION|CONSUM|CONSUMING'                                  ,poffense)    AND
REGEXFIND('MINOR|UNDERAGE|ILLEGAL| MV | MOTOR VEHICLE| U/A |PREMISE LIC'  ,poffense)    => 'Y',

REGEXFIND('[/\\. ]ALC09[/\\. ]|[/\\. ]ALC21[/\\. ]|[/\\. ]ALC13[/\\. ]|LIQ[UOR]* LAW VIO|ALC[B0OHPOL]*[/\\. ]*BEV|POSS[OF]*ALC[BY ]+|ALCPUBLIC|ALC(.*)UNDER 21|'+
          'POSSLIQ[U]*M[I]*N|POSSLIQON|SALE[OF]*LIQ[/\\. ]|SELL[OF]*LIQ[/\\. ]|SUPPLYLIQ[UOR]* ',poffense)   => 'Y',

REGEXFIND(Intox		                                            ,poffense)  and 
REGEXFIND('SUPP|[/\\. ]GIV[EING]*[/\\. ]|DISPEN|SOLD|PARK'   ,poffense)   => 'Y',

REGEXFIND('IMPORT|BEACH'		                                   ,poffense)  and 
REGEXFIND('ALCOH|BEER'                                       ,poffense)   => 'Y',

REGEXFIND('U[N]*LAW|UNL\\.'                                  ,poffense)  and 
stringlib.stringfind(poffense ,'ENTRY'                       ,1) <> 0     and
stringlib.stringfind(poffense ,'MINOR'                       ,1) <> 0     and
REGEXFIND('BAR|LOUNG|PACKAGE'                                ,poffense)   => 'Y',
         
stringlib.stringfind(poffense ,'UNLAW'                       ,1) <> 0     and    
(REGEXFIND(alc_set                 ,poffense)   OR
( stringlib.stringfind(poffense ,'CONSU' ,1) <> 0  AND  REGEXFIND('POS|PUB' ,poffense)   ) OR
 (stringlib.stringfind(poffense ,'ACQUI' ,1) <> 0  AND  REGEXFIND(liq_set ,poffense)   ) OR
 (REGEXFIND(alc_Set      ,poffense)   AND  REGEXFIND('[/\\. ]PO[S]+[/\\. ]|PUR|SALE|ADVERTIS|CONCENT|CONTENT' ,poffense)   ) OR
 (REGEXFIND('MINOR|PUB|[/\\. ]ALC[OHOL]*[/\\. ]'  ,poffense)   AND  REGEXFIND('COMSUM|[/\\. ]CONS[UMPTION]*[/\\. ]' ,poffense)   ) 
)=> 'Y',
						               
REGEXFIND(alc_set                                ,poffense)  and
REGEXFIND('[/\\. ]PO[S]+[/\\. ]'                 ,poffense)  and
REGEXFIND('MINOR|UNDER'                          ,poffense)  => 'Y',

REGEXFIND('DRINK|LIQ[UO]+R[ /]+FELONY'           ,poffense,0) <>  '' => 'Y', 

REGEXFIND('SELL|SALE|TRANS'                      ,poffense)  and  
stringlib.stringfind(poffense ,'BEV'             ,1) <> 0    and
stringlib.stringfind(poffense ,'ILLICIT'         ,1) <> 0    => 'Y',
                                                
REGEXFIND(liq_set+'|INTOX'                       ,poffense)  and 
REGEXFIND('BUILD|GROUND' 	                       ,poffense)  => 'Y',

REGEXFIND('OP[OE]+N| OEN |PEON'                  ,poffense)  and 
stringlib.stringfind(poffense ,'CONT'            ,1) <> 0    => 'Y',

stringlib.stringfind(poffense ,'PROV'            ,1) <> 0      and
REGEXFIND('[/\\. ]ALC[OHLICE]*[/\\. ]|ALCOHOL|BEER' ,poffense) and
stringlib.stringfind(poffense ,'PERS'            ,1) <> 0      and
stringlib.stringfind(poffense ,'UND'             ,1) <> 0      => 'Y',

REGEXFIND('UNLIC|LOCAL'                          ,poffense)  and 
REGEXFIND(alc_set                                ,poffense)  => 'Y',

REGEXFIND(alc_set                                ,poffense)  and 
REGEXFIND('[/\\. ]BEV[ERAGES]*[/\\. ]'           ,poffense)  => 'Y',

//Roger's comment QA Updates - Liquor Law Violations 7/7/16
stringlib.stringfind(poffense ,'TOC'             ,1) <> 0     and
REGEXFIND('STOC|MOTOC|PONTOTOC|BUTTOCKS|TOCOM|TOCAR|SHOOTOC|BALTOCITY|TOCACCO|NATCHITOCHES|PHOTO|TOCROSS|NARCOTOC|TOCONTROLLED' 	  ,poffense,0) =  '' => 'Y', 

REGEXFIND('DRUNK|DRINK'         	              	 ,poffense)  and 
REGEXFIND('PUBLIC|PUB' 		                        ,poffense)   => 'Y',
                                               
stringlib.stringfind(poffense ,'UNDER'           ,1) <> 0     and
stringlib.stringfind(poffense ,'AGE'             ,1) <> 0     and
REGEXFIND(Intox+'|'+alc_set                      ,poffense)   => 'Y',

stringlib.stringfind(poffense ,'TRANSP'             ,1) <> 0     and
stringlib.stringfind(poffense ,'SEAL'               ,1) <> 0     and
stringlib.stringfind(poffense ,'BROK'               ,1) <> 0     =>'Y',

stringlib.stringfind(poffense ,'TRANSP'             ,1) <> 0     and
(REGEXFIND(liq_set+'|LIGUO|BEER|WINE|INTOX'         ,poffense)   OR
 ( stringlib.stringfind(poffense ,'OPEN' ,1) <> 0  and stringlib.stringfind(poffense ,'BOTT' ,1) <> 0 )
)  => 'Y',

REGEXFIND(Intox        		                          ,poffense)   and 
REGEXFIND('BEV|REST|LIC|PERM|PRMT'                 ,poffense)   and
REGEXFIND(vio_set                                  ,poffense)   and
REGEXFIND('DRIV|[/\\. ]DL[/\\. ]|CHILD'            ,poffense)   => 'Y',

stringlib.stringfind(poffense ,'NUD'               ,1) <> 0     and
stringlib.stringfind(poffense ,'EST'               ,1) <> 0     and
REGEXFIND('[/\\. ]ALC[COHOL]*[/\\. ]|LCOHOL|LCPHOL|PUBLIC',poffense)   => 'Y',
						
stringlib.stringfind(poffense ,'POSS'              ,1) <> 0     and 
REGEXFIND(intox+'|'+alc_set+'|WHISKEY'             ,poffense)   and
REGEXFIND('PUB|BEV|OPEN|UNDE|MINOR'                ,poffense)   => 'Y',
      
stringlib.stringfind(poffense ,'NUD'               ,1) <> 0     and
REGEXFIND('ENTERT|ESTAB|PROHIB|RESTRI'             ,poffense)   => 'Y',

stringlib.stringfind(poffense ,'PARK'              ,1) <> 0     and
REGEXFIND(intox                                    ,poffense)   and
REGEXFIND('ORDINANCE|[/\\. ]NO[/\\. ]|[/\\. ]IN[/\\. ]|CATIONVIOL|'+vio_set      ,poffense)   => 'Y',
      
REGEXFIND('ORD' 	       		                         ,poffense)   and 
stringlib.stringfind(poffense ,'ORD'               ,1) <> 0     and
REGEXFIND(intox+'|BEV'                             ,poffense)   and
REGEXFIND(vio_set                                  ,poffense)   => 'Y',

REGEXFIND('[/\\. ]OP[E]*N[/\\. ]'                  ,poffense)  and 
stringlib.stringfind(poffense ,'CONTNR'            ,1) <> 0     => 'Y',

REGEXFIND(IDSET 	       		                         ,poffense)   and 
REGEXFIND('[/\\. ]NO[T]*[/\\. ]' 	                 ,poffense)   and 
stringlib.stringfind(poffense ,'REQ'               ,1) <> 0     and 
REGEXFIND(intox                                    ,poffense)   => 'Y',

REGEXFIND('HOUR|[/\\. ]HR[S]*[/\\. ]|MINOR| NON-DES AR |PREMIS' ,poffense)   and 
REGEXFIND(intox                                                 ,poffense)   => 'Y',

REGEXFIND('ABUS[INGE]*[/\\. ]| ABS ' 		            ,poffense)   and 
REGEXFIND('H[A]*RMFUL|[/\\. ]HRM[FUL]*[/\\. ]' 	  	,poffense)   and 
REGEXFIND(intox                                    ,poffense)   => 'Y',
      
REGEXFIND('PERMIT|PRMT|PROHIB' 	  	                ,poffense)   and 
REGEXFIND(intox+'|DRINK|DRUNK'                     ,poffense)   => 'Y',						 

REGEXFIND('INDEC|INDCE|INDENC'                     ,poffense)   and 
stringlib.stringfind(poffense ,'SOLD'              ,1) <> 0     and
REGEXFIND(intox                                    ,poffense)   => 'Y',

stringlib.stringfind(poffense ,'EXPOS'             ,1) <> 0     and
REGEXFIND(Intox                                    ,poffense)   and
REGEXFIND('GENIT|BREAST'                           ,poffense)   => 'Y',						 
                        
REGEXFIND('CONSUM|POSS|OPEN|[/\\. ]CONS[/\\. ]' 			,poffense)   and 
REGEXFIND(Intox          				                      ,poffense)   => 'Y',
					 
REGEXFIND('SELL|SALE|SERV|PURCH|FURNI|NUD|TRAF|CHILD|MINOR|JUV'               		,poffense)  and 
REGEXFIND(Intox               		                   ,poffense)   => 'Y',

REGEXFIND('FAKE|FALSE' 			                         ,poffense)   and 
REGEXFIND(Intox                                    ,poffense)   and
REGEXFIND('INFO|APP[/\\. ]|[/\\. ]O\\.L\\.|'+IDSET ,poffense)    => 'Y',

REGEXFIND(vio_set+'|[/\\. ]VIL[LATION]*[/\\. ]'    ,poffense)   and
REGEXFIND(liq_set                		                ,poffense)   => 'Y', 
      
REGEXFIND('MANUF|DIST[I]*L|DISTRI'                 ,poffense)   and 
REGEXFIND(Intox                                    ,poffense)   => 'Y',
       
REGEXFIND('TRANS|DELIVER'  								                ,poffense)   and 
REGEXFIND(Intox    								                        ,poffense)   and  
~REGEXFIND(dui      								                       ,poffense)   => 'Y',
                                                  
REGEXFIND('OPEN(.*)CONT' 				     	                ,poffense)   and 
REGEXFIND(Intox             				                   ,poffense)   => 'Y',

REGEXFIND('SELL|SALE|SERV|PURCH|FURNI|AID|ASSIST|[/\\. ]POS[SESION]*[/\\. ]',poffense)  and 
REGEXFIND(Intox                                    ,poffense)   and  
REGEXFIND(misc                                     ,poffense)   => 'Y',

REGEXFIND('CONSUM|DRINK'                           ,poffense)   and 
REGEXFIND(Intox                                    ,poffense)   and  
REGEXFIND(misc                                     ,poffense)   and
REGEXFIND(dui    										                        ,poffense,0) =  '' => 'Y',

REGEXFIND('^[ ]*[/\\. ]ABC[/\\. ]|[/\\. ]A[ \\.]+B[ \\.]+C[ \\.]+|VIO(.*) A[ \\.]*B[ \\.]*C',poffense)  and  
REGEXFIND(vio_set+'|[/\\. ]VIL[OATION]*[/\\. ]|VILOATION|LAW|BEER|ALCOH|'+liq_set       ,poffense)   => 'Y',
  		  
REGEXFIND(' VEH[ICLE]* |PUBLIC'                                  ,poffense)   and  
stringlib.stringfind(poffense ,' IN '                            ,1) <> 0     and
REGEXFIND(Intox+'|CONSUM'   					                                ,poffense) => 'Y',
      
REGEXFIND(' VEH |PUBLIC'                                         ,poffense)   and  
stringlib.stringfind(poffense ,' CONT '                          ,1) <> 0     and
REGEXFIND(Intox             					                                ,poffense) => 'Y',
      
stringlib.stringfind(poffense ,'CHAPTER 123'                     ,1) <> 0     and
REGEXFIND(Intox             					                                ,poffense) => 'Y',

REGEXFIND('SELL|SALE|CONSUME'                                    ,poffense)   and						 
REGEXFIND('MALT|BEV'                                             ,poffense)   => 'Y',

REGEXFIND(alc_set      		                                       ,poffense)   and
stringlib.stringfind(poffense ,'POSN'                            ,1) <> 0     and
stringlib.stringfind(poffense ,'STORE'                           ,1) <> 0    => 'Y',
      
REGEXFIND(alc_set      		                                       ,poffense)   and
stringlib.stringfind(poffense ,'UNDER'                           ,1) <> 0     and
stringlib.stringfind(poffense ,'21'                              ,1) <> 0     => 'Y',

REGEXFIND(alc_set      		                                       ,poffense)   and
stringlib.stringfind(poffense ,'PROVISIONS'                      ,1) <> 0     and
stringlib.stringfind(poffense ,'VIOLATION'                       ,1) <> 0     => 'Y',
      
REGEXFIND('ALCOHOL VIOLATION|ALCOHOL/PUB/|ALCOHOL/CURB|ALCOHOL/POSN/|ALCOHOL ORDINANCE|MINOR IN POSSESSION'	,poffense)   => 'Y',

REGEXFIND('[/\\. ]POSS[ESSION]*[/\\. ]|[/\\. ]PURCH[ASE]*[/\\. ]|[/\\. ]PUR*[/\\. ]|CONSUME'  ,poffense)  and
REGEXFIND('MINOR|[/\\. ]<21 AG[/\\. ]|[/\\. ][<]21[YOA]*[/\\. ]'     		                      ,poffense)  and 
~REGEXFIND('FIREARM|F/ARM|WEAPON|HANDGUN|GUN|DRUG|SEX|PORN|PORNO'    		                      ,poffense)  => 'Y',
					       
stringlib.stringfind(poffense ,'MALT'                            ,1) <> 0     and
REGEXFIND('[/\\. ]BEV[AERAGES]*[/\\. ]'                          ,poffense)   and
REGEXFIND('GIVE|MANUF|CONSUME|UNLAWFUL|FURNISH'                  ,poffense)   => 'Y',

stringlib.stringfind(poffense ,'CONSUMP'                         ,1) <> 0     and
stringlib.stringfind(poffense ,'PUBLIC'                          ,1) <> 0      => 'Y',
      'N');							 
							 
return Is_it;
end;
//--------------------------------------------------------------------------------------------------------------------------------------

export Is_DisorderlyConduct(string poffense_in) := function //done
																									
special_characters:= '~|=|!|%|\\^|\\+|:|\\(|\\)|,|;|_|-|#|@|\\*|<|>|"|`|\\[|]|\\{|\\}|\\\\|\'';
poffense          := ' '+REGEXREPLACE(special_characters, poffense_in, ' ');
																	 
DisorderlyConduct   :=  '^ DC |DEF[AE]CAT|ISORDERLY CONDUCT|[/\\ ]D[\\.]C[\\.][/ ]|[/\\. ]D/C[ONDUCT]*[/\\. ]|[/\\ ]D[\\.]C[\\.][PERSITNG\\.]*[/ ]|[/\\ ]D[\\.]C[\\.]I[\\.N]+|'+
                        'NUDE|INDEC|INDCE|INDENC|URIN[A]*TE|DISORDER[L]+[Y]*|DIS ORDER[ER]*LY|DISORDERY|NOISE|URINAT|DEFACAT|INDEC(.*)EXP| DIS[C/\\.]*COND | DIS[\\.][ ]*COND|'+
												            'PC 647 A |PC 647 H |PC 288 A |PC 288 C |PC 314\\.1|PC 415 |PC 415 [12] |VC 27151 A | 2917\\.11 | 877\\.03 ';

DisorderlyConduct1  := 	'DI[S]*ORD[ERLY]* CON[DUCT]*|DISOR(.*)CON[DUCT]*[/\\. ]|DIS(.*)CONDUCT|RECKL[ESS]* COND[AUCT]*|RECKL[ESS]* COND[TACT]*|DIS CON[DUCT]*[/\\. ]| DIS[\\. ]COND[LUISNGCTF]+[INTOX]* |'+
												            'DIS[OERDER]+LY COND|DIS[C]*OR[/D][ER]*[/ ]*CON[FD]| DIS[/ ]CONDM[.][ ]|DISC..[ ]*COND PER|LOUD';
DC_Exc              := 'TAG|T\\.D\\.C\\.J|D[/]COC|WASH STATE|WASHINGTON|FORGE|NO DC|NO VALID|FRAUD|SUSP|CON SUB| REGIS';                                                     

DisorderlyConduct2  := 'YELL|SHOUT|DISRUPTIV';
DisorderlyConduct3  := 'SPIT |SPITTING|EXPEC[TO]+RAT|EXPECT[UAE]RAT|EXPECTORANT|EXPE[IC]TORAT|EXPECTORIN|EXPECTUATIN|EXPELERAT';                                                                           
vio_set      := '[/\\. ]VIO[LATIONGS]*[/\\. ]|[/\\. ]VIO[LATED]*[/\\. ]|[/\\. ]VOL[LATIONGS]*[/\\. ]|[/\\. ]VOL[ILATED]*[/\\. ]|VIOLATION';                                                     																									 
// DCa                 := 'DIS';
// DCb                 := 'COND[UCT]*[/\\. ]';

DC2a                := 'INDCE|INDEC';
DC2b                := 'LANG|EXPOS|PHONE|WORDS|GESTU|PUBLIC|COND';

DC2c                := 'OBSCEN';
DC2d                := 'LANG|PHON|WORDS|GESTU|PUBLIC|COND|CALL|[/\\. ]E MAIL|EMAIL|MESSAGE'; 

Is_it := MAP(//In_Global_Exclude(poffense,'other')='Y' => 'N',

//this expression has to be above the  Is_LiquorLawViolations clause below. 
REGEXFIND('DI[SC]*ORDERLY|DISORDER|[/\\. ]DIS[ORDER]*[/\\. ]' ,poffense)   and
REGEXFIND('[/\\. ]COND[UCT]*[/\\. ]|CONDUCT'      ,poffense)   => 'Y', 
//this expression has to be above the  Is_SexOffensesNon_forcible clause below. 
REGEXFIND('[/\\. ]INDE[CENTLY]*[/\\. ]|[/\\. ]INDC[ECNTY]*[/\\. ]|INDENC|INDECEN' ,poffense)   and
REGEXFIND('[/\\. ]EXP[\\.0AIOSURE]*[/\\. ]|EXPOSURE'      ,poffense)   => 'Y', 

stringlib.stringfind(poffense ,'RIOT'                           ,1) <> 0     and
REGEXFIND('COMMIT|UNLAW|AGG|INCITE|INCITING|COMMISSION|ENGAG'   ,poffense)   => 'Y', 

Is_Assault_aggr(poffense)='Y'OR                   
// Is_Assault_other(poffense)='Y'OR                   
Is_Pornography(poffense)='Y' OR                   
Is_SexOffensesForcible(poffense)='Y' OR          
Is_SexOffensesNon_forcible(poffense)='Y'   => 'N', 

stringlib.stringfind(poffense ,'OBSCENI'    ,1) <> 0     and
stringlib.stringfind(poffense ,'UTTER'      ,1) <> 0     => 'Y',

stringlib.stringfind(poffense ,'EXPOS'      ,1) <> 0     and
stringlib.stringfind(poffense ,'STATUTORY'  ,1) = 0     and
REGEXFIND('SEX[UAL]*[/ ]ORGAN|GENIT|BREAST' ,poffense)   => 'Y',

REGEXFIND('[/\\. ]DEP[OSITENG]*[/\\. ]' ,poffense)   and
REGEXFIND('GAR[G]*BA|MATER'             ,poffense)   and
REGEXFIND('SIDEW|STREE'                 ,poffense)   => 'Y',

stringlib.stringfind(poffense ,'REFUSE'    ,1) <> 0     and
stringlib.stringfind(poffense ,'LEAVE'     ,1) <> 0     => 'Y',

REGEXFIND('[/\\. ]D/O[/\\. ]'           ,poffense)   and
REGEXFIND('CONDUCT|DRINK|INTOX'         ,poffense)   => 'Y',

REGEXFIND('[/\\. ]PUB[L]*[LICD]*[/\\. ]|PUBLIC'   ,poffense)   and
REGEXFIND('UR[NI]+ATION|URI[NI]+ATE|URI[NI]+ATING',poffense)   => 'Y',

stringlib.stringfind(poffense ,'DISORD'       ,1) <> 0     and
stringlib.stringfind(poffense ,'PERSON'       ,1) <> 0     => 'Y',

stringlib.stringfind(poffense ,'REFUSE'       ,1) <> 0     and
stringlib.stringfind(poffense ,'LEAVE'        ,1) <> 0     => 'Y',

stringlib.stringfind(poffense ,'HOOT'         ,1) <> 0     and
REGEXFIND('HOLL|SHOUT'                        ,poffense)   => 'Y',

REGEXFIND('[/\\. ]PUB[LICDSX]*[/\\. ]|PUBLIC' ,poffense)   and
stringlib.stringfind(poffense ,'NUISA'        ,1) <> 0     => 'Y',

REGEXFIND('RECKL|RECKLESS'                                                     ,poffense)   and						 
REGEXFIND('[/\\. ]COND[AUCT]*[/\\. ]|[/\\. ]CONT[UACT]*[/\\. ]|CONTACT|CONDUCT',poffense)   => 'Y',						 
//
REGEXFIND('MORAL|DECENC'                      ,poffense)   and
stringlib.stringfind(poffense ,'CRIME'        ,1) <> 0     => 'Y', 

stringlib.stringfind(poffense ,'ROGUE'       ,1) <> 0     and
stringlib.stringfind(poffense ,'VAGABOND'    ,1) <> 0     => 'Y',

stringlib.stringfind(poffense ,'OBSC'        ,1) <> 0     and
stringlib.stringfind(poffense ,'WRIT'        ,1) <> 0     => 'Y',

stringlib.stringfind(poffense ,'CURSE'       ,1) <> 0     and
REGEXFIND('[/\\.& ][A]+BUS[SEINGDV]*[/\\. ]|[/\\.& ][A]+BUS[SERT]*[/\\. ]|ABUSED'    ,poffense)   => 'Y', 

// REGEXFIND('LOUD'      ,poffense)   => 'Y',

stringlib.stringfind(poffense ,'NOISE'       ,1) <> 0     and
REGEXFIND('DISTURB|UNNECE[S]+ARY|ORDINANCE|EXCESS|'+vio_set   ,poffense)   => 'Y',
   
stringlib.stringfind(poffense ,'DRUG'       ,1) <> 0     and
stringlib.stringfind(poffense ,'CONDITION'  ,1) <> 0 => 'N',

stringlib.stringfind(poffense ,'REFUSE'       ,1) <> 0     and
stringlib.stringfind(poffense ,'LEAVE'        ,1) <> 0     => 'Y',

REGEXFIND(DC2a ,poffense)   and
REGEXFIND(DC2b ,poffense)   => 'Y',

REGEXFIND(DC2c ,poffense)   and
REGEXFIND(DC2d ,poffense)   => 'Y',

REGEXFIND(DisorderlyConduct ,poffense)   and 
REGEXFIND(DC_Exc            ,poffense,0) = '' => 'Y',

REGEXFIND(DisorderlyConduct1 ,poffense)   and 
REGEXFIND(DC_Exc            ,poffense,0) = '' => 'Y',

( REGEXFIND(DisorderlyConduct2 ,poffense)   OR
  (stringlib.stringfind(poffense ,'DISTURB',1) <> 0  and stringlib.stringfind(poffense ,'PEAC',1) <> 0)
) AND
stringlib.stringfind(poffense ,'YELLOW'        ,1) = 0     => 'Y',

(REGEXFIND(DisorderlyConduct3 ,poffense)   OR
(stringlib.stringfind(poffense ,'EXPEL',1) <> 0  and stringlib.stringfind(poffense ,'SALIVA'       ,1) <> 0 )) and
stringlib.stringfind(poffense ,'HOSPITA'        ,1) = 0     => 'Y',

stringlib.stringfind(poffense ,'CONTRIB',1) <> 0  AND              
REGEXFIND('DELI[N]*Q|[/\\. ]DEL[/\\. ]|DELINQUENCY' ,poffense)   => 'Y',

'N');
return Is_it;
end;
//--------------------------------------------------------------------------------------------------------------

export Is_TrespassofRealProperty(string poffense_in) := function //done

special_characters:= '~|=|!|%|\\^|\\+|:|\\(|\\)|,|;|_|-|#|@|\\*|<|>|"|`|\\[|]|\\{|\\}|\\\\|\'';
poffense          := ' '+REGEXREPLACE(special_characters, poffense_in, ' ');

TrespassofRealProperty      := 'TRANSPAS|TRES[PASS]*|TRESSPASS|TR[ES]PASS|TREAPAS|TRSP[S]* |REFUS[ALING]+ TO LEAVE|810.09.2A|810.08.2A|810.09.2B|810.09.1A1|'+
                               'PC 602\\.5|PC 602 |PC 602\\.1 A |PC 369 I |PC 369I A ';

Is_it := MAP( //In_Global_Exclude(poffense,'other')='Y'      OR
              // Is_Burglary_BreakAndEnter_res(poffense)='Y'  OR
							       // Is_Burglary_BreakAndEnter_comm(poffense)='Y' OR
							       // Is_Burglary_BreakAndEnter_veh(poffense)='Y'  => 'N',

stringlib.stringfind(poffense ,'REFUSE'         ,1) <> 0     and
stringlib.stringfind(poffense ,'LEAVE '          ,1) <> 0     => 'Y',

REGEXFIND('ENTER|ENTYR|ENTRY'                   ,poffense)   and	
(stringlib.stringfind(poffense ,'UNAUTH'        ,1) <> 0  or
 (REGEXFIND('WITHOUT|[/\\. ]W[/]O[UT]*[/\\. ]|[/\\. ]W[- ]O[/\\. ]|[/\\. ]NO[/\\. ]',poffense)   and 
 stringlib.stringfind(poffense ,'INTENT '       ,1) <> 0 )) and	
REGEXFIND('THEF| FEL |CARPENTRY|DAMAG'          ,poffense,0) = '' => 'Y',  

stringlib.stringfind(poffense ,'PARK'           ,1) <> 0     and
stringlib.stringfind(poffense ,'AFTER'          ,1) <> 0     and
REGEXFIND('REMAIN|ENTER|TRESP|TEPASS|BEING|INSIDE|[/\\. ]IN[/\\. ]|OCCUPY',poffense)   => 'Y',

stringlib.stringfind(poffense ,'UNLAW'          ,1) <> 0     and
stringlib.stringfind(poffense ,'REMAIN'         ,1) <> 0     and
REGEXFIND('[/\\. ]PK[/\\. ]|PUBLIC'             ,poffense)   => 'Y',	
	
stringlib.stringfind(poffense ,'FAIL'           ,1) <> 0     and
REGEXFIND('[/\\. ]LEAV[E]*[/\\. ]|LEAVE'        ,poffense)   and 
REGEXFIND('INFO|[/\\. ]ID[ENTIFCAON]*[/\\. ]|IDENTI|[/\\. ]PFD[/\\. ]|COMPLY|SCENE|[/\\. ]ACCI[DENT]*[/\\. ]|COLLISION|CRASH',poffense,0) = ''  => 'Y',

REGEXFIND('HUNT|FISH|TRAP'                      ,poffense)   and	 
stringlib.stringfind(poffense ,'POST'           ,1) <> 0     => 'Y',	 	               

REGEXFIND(TrespassofRealProperty                ,poffense)   and
stringlib.stringfind(poffense ,'DISTRESS'       ,1) = 0     => 'Y',	       

REGEXFIND('SLEEP|[/\\. ]LODG[EING]*[/\\. ]|LODGING|CAMP'   ,poffense)   AND               
stringlib.stringfind(poffense ,'PROHIB'                    ,1) <> 0     and
REGEXFIND('[/\\. ]PLAC[/\\. ]|PLACE|AREA|URBAN'            ,poffense)   => 'Y',

REGEXFIND('SLEEP|[/\\. ]LODG[EING]*[/\\. ]|LODGING|CAMP'   ,poffense)   AND               
REGEXFIND('PRIVATE|PUBLIC'                                 ,poffense)   => 'Y',
						 
						 'N');
return Is_it;
end;
//--------------------------------------------------------------------------------------------------------------------------------------

export Is_traffic(string poffense_in) := function
special_characters := '~|=|!|%|\\^|\\+|:|\\(|\\)|,|;|_|-|#|@|\\*|<|>|"|`|\\[|]|\\{|\\}|\\\\|\'';
poffense           := ' '+REGEXREPLACE(special_characters, poffense_in, ' ');
special_characters7:= '~|=|!|%|\\^|\\+|:|\\(|\\)|,|;|_|@|\\*|<|>|"|`|\\[|]|\\{|\\}|\\\\|\'';
poffense7          := ' '+REGEXREPLACE(special_characters7, poffense_in, ' ');

LIC1         :=   ' D.LICENSE| D[/\\. ]*L[IC/\\. ]*NOT|DR(.*)LIC(.*)LAW|DISP[LAY]*(.*) LICENSE|CONDITIONAL LICENSES|CANCEL[LED]* LICENSE|ALLOW(.*)NON[ -]*LICENSED|'+
                  'PERMIT(.*)UNLICENSED|CHAUF(.*) LIC|LICENSE REQ|NO(.*) LICENSE|LIC. SUS.|DRG LIC SUS[/]REV PURS TO SEC|OPERATING WHILE REVOKED|'+
									'ALLOW(.*) UNLIC(.*)|ALLOW(.*) NON(.*)LIC(.*) DR|LICENSE RESTR|ST[ATE]* LIC(.*)PLAT|FAIL WEAR LICEN|FAIL[URE]*(.*)DISPLAY LICENSE|'+
                  'FAIL[URE]*(.*)EXHIBIT[ED]*(.*)LICENSE|LICENSE(.*)CARRIED|SUSPENDED(.*) LICENSE|IMPR(.*) LIC|FAIL(.*) LIC|RESTRICT[ED]* LIC[ENSE]*|'+									
                  'SUSP[ \\.]LIC|VALID LIC| EXP(.*) LIC| FIC[TICIOUS]* LIC| FIC[TICIOUS]* LIC|NO LIC|PRESENT LICENSE| O[-\\. /]L[ \\.]|RECK DR:|'+
                  'NO DR(.*) LIC|NO OPERATOR(.*) LIC|UNLIC(.*) VEH| DL | (VIO[ .])*D[/\\. ]*L[/\\. ]*LAW|ALLOW(.*)REVOKE|MOPED LICENS|LICENSE PLATE|'+
                  'LICENSE SUSPENSION|LSOA WITHOUT GIVING INFO|NO VALID D[\\./ ]+L[\\. ]|OPER SUSP[/]REV|CROSS.*FIRE.*HOS';		
															
traffic_list :=   ' TAG[ ]|12 P[OIN]*T| AUTO |ACCIDENT|ABAND(.*)VEH|ABAND(.*)M/V|BUMPER|BRAKES|PERIOD[S]* FOR REQUIRING LIGHTED LAMPS|HEAD[ ]*LAMPS[- ]+(.*)[ ]*VEH|'+	                 
                  'CHILD(.*) SEAT|[ *]CMV| CMV |EXCEED[ING]* [0-9]+ MPH|DR (.*)SUSP|DR (.*)REV|DL SUSP|DISR(.*) SAFE|WINDSHIELD[S]* REQUIRED|'+ 
									         '[/\\. ]CITATION|COMMERCIAL TAG REQ|CANCEL(.*) O[. /]L|[C]*DL RESTRICTION|PARENT, GUARDIAN, OTHER ALLOWING|ALLOWING UNAUTHORIZED|ALLOWING UNLAWFUL|'+
                  'IMPROPER REG|IMPROPER CLASS|IMPROPER I[.]*D|NO SINGLE STATE|STATE TAG|IMPR(.*) TAG|FINANCIAL RESP|REGISTRATION REQUIRED| REG(.*) LAW|REG(.*) EXP|'+
                  'NOT[ICE ]+OF CH[AN]*G[E]*(.*) ADD|FAIL(.*)CHANGE(.*)ADD[RESS]|FAIL(.*) TO COMPLY|FAIL TO SURR|FAIL TO REG|FAIL(.*) APPR|'+
                  'NOTIFY CHP|NOTIFY(.*) ADD(.*) CHANGE|SU[SPE]+NDED|EXP[ .]|EXPIRE|^ EXP(.*) PL|^ EXP(.*) RE|^ EXP(.*) TAG|'+
                  'VALID REG|VIOLATION(.*) YOA|DIS(.*) REG|RADAR|^ R[./ ]+D[. -/]|^ R[ ]*D[:. /]+|DWLS|OBSCURED (.*)[ ]*PLATE|'+
                  ' FIC[TICIOUS]* PL| FIC[TICIOUS]* RE| FIC[TICIOUS]* TAG';

 traffic_list2 :=	'LEFT OF CENTER|FOLLOW[ING]* TOO CLOSE|MUFFLER|MUDGUARD|EXCEED 65 OR 70 MPH FOR ALL VEHICLES BY|DEFECTIVE WINDSHIELD|ASSURED CLEAR DIST|'+		                								  
	                 'HWY SIGN|HELMET|H[OU]*R[\\. ]*RULE|HIGHWAY|HIT (.*)SKIP|WIDE[ ]*LOAD|WRONG CLASS|NO(.*) O[\\. /]*L|NO CERT|'+
                  'NO(.*) REGISTRATION| NO OP[A-Z]* | NO OL | NO D[\\. ]*L|NO LIAB[ILITY]* INS[URANCE]*|NO VALID MVI|OVER LIC[\\.ENSED ]+WEIGHT|'+
                  ' LOG[ ]*BOOK|NO LOG BOOK|NO O[/ .]L[\\. ]|NO OVERSIZE PERMIT|NO OVERWIDTH PERMIT|OVERW[EI]+GHT|OVERH[EI]+GHT|'+		
							           'OMVI| OUI| OWI| OWI | OUIL|OPER(.*) W(.*)O(.*) CARRIER PERMIT|OL(.*) SUSP|OVER [GROSS ]*WEIGHT|'+
                  '[O0]\\.V\\.I|[O0][/]V[/]I|OVI |OVER[ ]*WIDTH|OVER[ ]*SIZE|OVER[ ]*LIMIT|OVER[ ]*LENGTH|OVERDIMENSIONAL LOAD|ODOMETER|'+ 
                  'OPER(.*)CERT|RIGHT OF WAY|RIGHT TURN|CONT(.*) DEV|VEHICLE[S]* SUBJECT TO REGISTRATION|EVIDENCE OF REGIS|EVID REG SIGN';
																	 
 traffic_list3 := 'SIGNAL|^ REV[.OKE ]+|^ SUSP|^ SURR|SEA[TL][ ]*B[EA]*LT|TRANSPORTER|TOLLWAY|TOO FAST|STO[P]+ING AFTER ACC|INFRACTION VC|'+
                  'UNREGISTERED|UNINSURED|UNSECURE(.*) LO\\]AD|UNSAFE BACKING|VIO(.*) REG|WINDSHIELD WIPERS|STARTING [AND\\&]+ BACKING|'+	
                  'WHEEL|WRONG SIDE|WRONG DIRECTION|WRONG WAY|WINDSHEILD|TINT|UNSIGNED REGISTRATION|YIELD|PK[0-9]+[ 0-9]+$|^ DUSP[- ]+| DUS[123][ STNRDH]+| DUS[0-9]{2}/[0-9]{2}|'+
									         'HORN|FMCSR|FMCSK|PWC|MCV[-: ]|PEDEST|VSRL|U[-/ ]*TURN|RD[-/]SP|PARKING|RIDE|RIDING|DWLR|CFR[ ]*-|SIDE WINDOWS[-: ]+RESTRICT|'+
									         'CRASH|USDOT | US DOT[ #]|^ DPS[-/ ]|ILLEGAL SUN[ ]*SHAD|WINDSHIELD[S]*[- ]+SIGN[,/ ]+COVERING[,/ ]+SUNSCREEN MATERIAL';
									 

 traffic_list4 := 'SUSPD[/\\. ]|SPD[/\\. ]|SPDG[/\\. ]|BOAT|BICYCLE|BIKE|CYCLING|D\\.[ ]*U\\.[ ]*S|D[/]U[/]S|D\\.[ ]*W\\.[ ]*[0OD][\\. ]*L|D[ ]*\\.[ ]*W[ ]*\\.[ I]*[OL]|D\\.[ ]*W\\.[ ]*[SR]|'+   
                  'D[/]W[/]O[/]L|D[/]W[/]L|D[/]W[/]O|D[/]W[/]S|D[/]W[/]R| A[ \\.]+C[ \\.]+D[ \\.]A[ SPEED]+';  
									
 traffic_list5 := 'LANE|DISOBEY|[/\\. ]DUS[/\\. ]|[/\\. ]DWOL[/\\. ]|DWOVDL|[/\\. ]DWS[/\\. ]|[/\\. ]DWR[/\\. ]|D[ ]*W[ ]*L[ ]*S[/]R |'+
                  '[/\\. ]DLWSR[/\\. ]|DSLW[/]R |[/\\. ]DWSOL[/\\. ]|SPDOMTR|DWLC/S/R/L';
                                                        
 traffic_list6 :='VC 22350 |VC 22349 A |VC 12500 A |VC 16028 [AC] |VC 20002 A |VC 4000 A |VC 12500 B |VC 12500 D |VC 27315 [DEF] |VC 21453 [AC] |VC 22450 A |'+
                 'VC 14601\\.1 A |VC 16028 A |VC 27315 [DEF] VC 14601\\.5 A |VC 26708 A  1 |VC 26708\\.5|VC 22101 [AD] |VC 21461 A |VC 21461\\.5 |VC 14601\\.[25] A |'+
                 'VC 14601 A |VC 16028 C |VC 12951 A |VC 23103\\.5|VC 23103 |VC 22349 B |VC 16020 A |VC 5200 |VC 5200 A |VC 24252 A |VC 4454 A |VC 22451 A |'+
                 'VC 27007 |VC 21658 A | VC 23222 B |VC 2800\\.[12]|VC 27360 A |VC 27360\\.5 [AB] |VC 27360 B |VC 21212 A |VC 21755 |14601VC|VC 21460 A |VC 21460\\.5 C |VC 24250 |'+
								 'VC 24400 |VC 24400 A | 74 55 B |VC 24603 [ABDE] |VC 24603 |VC 24002 [AB] |VC 22107 |VC 26710 |VC 21651 A |VC 2815 |VC 21453 B |VC 35551 A |VC 21801 A |316063 1 ';

 traffic_list7 :='VC 4462\\.5|VC 4462 B |VC 22406 [AB] |VC 21950 A |VC 23111|VC 27600|VC 21650 |VC 21650\\.1|VC 20001 |VC 21955 |VC 24600 [ABE] |VC 22348 [BC] |VC 22100 [AB] |VC 22400 A |'+
                 'VC 21804 A |VC 21802 A |487465 VBR|VC 27151 A |VC 31 |VC 21201 D |VC 27465 B |4507\\.02A|VC 21457 A |VC 5201 |VC 21718 A |VC 34506\\.3|VC 345063 |VC 23225 A |'+
                 'VC 21655\\.5 B |VC 27156 B |VC 21456 B |VC 2800\\.1|VC 22526 C |VC 22526 A |VC 21209 A |VC 27153 |VC 2818 |VC 34507\\.5 [AB] |VC 23109 C |VC 27803 B |VC 21453 D|'+
								 'VC 14603 |VC 22106 |VC 22102 |VC 4159 |VC 26101 |VC 27150 A |4513\\.263 P|4513\\.263 |VC 38366 A |VC 21800 D  1 |4507\\.02B|VC 22108 |VC 23223 A |VC 23223 |VC 10852|VC 12814\\.6|'+
                 'VC 24003 |VC 35400 A |VC 21367 C |VC 23224 A |73\\.20 A |VC 25950 A |VC 38020|VC 24953 A |VC 26709 A |VC 27400 |VC 21806 A |4503\\.21|VC 27900 A |VC 23247 E |6701H 1B ';
								 
 traffic_list8 := 'VC 14600 A |4511\\.21|4513\\.263|4511\\.21D1|4511\\.202|4511\\.19A1|4511\\.43A|VC 5204 A |VC 23123 A |VC 23123\\.5 A |VC 22454 A |VC 26453|VC 21703 |VC 24601 |VC 35550 A |'+
                  'VC 22523[ ]*A |VC 23112[ ]*A |VC 23114[ ]*A |VC 24409[ ]*A |VC 26708[ ]*A |VC 4462[ ]*A |VC 5201[ ]*E |VC 14604 A |316\\.183 1 |4511\\.194D|A\\.46\\.2 852|GF8 0308|316\\.072 |'+
                  '322\\.34\\.1 | 322\\.34[\\. ]2 | 316[\\.]*061 1 | 316\\.074 2 | 316\\.075 | 316[\\.]*088 2 | 316\\.090 2 | 316\\.091 1 | 316\\.154 | 316\\.183 1 | 316\\.2061 | 316[\\.]*211 2 | 316[\\.]*215 1 | 316[\\.]*217|'+ 
                  '316[\\.]*2952 2 | 316[\\.]*2953 | 316\\.520 1 | 316\\.605 | 316\\.610 | 316074 2 | 316085 2 | 316121 1 | 316121 4 | 316130 7 B | 3162952 2 | 316605 | 320\\.261 | 320\\.38 | 320021 | 320261 | 32038 |'+
                  '322[\\.]*031 1 | 322\\.19 | 4503\\.11 | 4503\\.21 | 4510\\.16A | 46\\.2 1003|322\\.03[\\. ]1| 169 475 2 |322\\.34 10 |17AAC25\\.210|169 06 5 A 3 III| 316130 11 |316614 4 A|DAC[/]IPS';

 exclude_list_traffic := 'DE[E]+R|DOG|FISH|WILD[ LIFE]*|SU[SP]*(.*) SENT|SEX|REGISTRY|OCCUPATION|PROBATION|VIO(.*) REGULATION|THEFT|VANDALISM|TRES[S]*PASS|TRAFFICING|TRAFFICKING|'+
		                       'NARCOTIC|COCAIN|TRAFFIC[ /]DR[UG]+|CHILD TRAFFIC|TRAFFIC [HERO]*IN|TRAFFIC MAR|DRUG TRAFFIC|TRAFFIC NARC|TRAFFIC CRA[CK]+|'+
								                 'TRAFFIC ECSTASY|AGG(.*)TRAFFIC|RSP|FIREARM|SWAN|ANTLERS|RABIES| DOE|FIREWORK';		

Is_it := MAP(
            //This expression has to be before Gobal otherwise it will get suppressed and the records will end up in Other category  
REGEXFIND('FAIL|FA[/]'                               ,poffense)  and						 
REGEXFIND('SHOW|OBTAIN'                              ,poffense)  and 
REGEXFIND(' DL | ID | CDL | OL |INSURANCE|DRIVER LICENSE|DRIV LIC| REG[ISTRATION]* '  ,poffense)   	=> 'Y', 
						
      //In_Global_Exclude(poffense,'other')='Y' => 'N',
            
						// Is_Arson(poffense)='Y' OR                        
						// Is_Assault_aggr(poffense)='Y' OR                      
						// Is_Assault_other(poffense)='Y' OR                      
						// Is_Bribery(poffense)='Y' OR                      
						// Is_Burglary_BreakAndEnter_res(poffense)='Y' OR
						// Is_Burglary_BreakAndEnter_comm(poffense)='Y' OR 
						// Is_Burglary_BreakAndEnter_veh(poffense)='Y' OR 
	  				// Is_Counterfeiting_Forgery(poffense)='Y' OR       
						// Is_Destruction_Damage_Vandalism(poffense)='Y' OR
						// Is_Drug_Narcotic(poffense)='Y' OR              
						// Is_Fraud(poffense)='Y' OR                        
						// Is_Gambling(poffense)='Y' OR 
						// Is_Homicide(poffense)='Y' OR                     
						// Is_Kidnapping_Abduction(poffense)='Y' OR         
						// Is_Theft(poffense)='Y' OR   
						// Is_Shoplifting(poffense)='Y' OR
						// Is_Motor_Vehicle_Theft(poffense)='Y' OR          
						// Is_Pornography(poffense)='Y' OR                  
						// Is_Prostitution(poffense)='Y' OR                 
						// Is_Robbery_res(poffense)='Y' OR    
						// Is_Robbery_comm(poffense)='Y' OR    
						// Is_SexOffensesForcible(poffense)='Y' OR          
						// Is_SexOffensesNon_forcible(poffense)='Y' OR      
						// Is_Stolen_Property_Offenses_Fence(poffense)='Y' OR
						// Is_Weapon_Law_Violations(poffense)='Y' OR        
						// Is_Identity_Theft(poffense)='Y' OR               
						// Is_Computer_Crimes(poffense)='Y' OR              
						// Is_Terrorist_Threats(poffense)='Y' OR            
						// Is_Restraining_Order_Violations(poffense)='Y' OR 
						// Is_BadChecks(poffense)='Y' OR                    
						// Is_CurfewLoiteringVagrancyVio(poffense)='Y' OR   
						// Is_DisorderlyConduct(poffense)='Y' OR            
						// Is_DrivingUndertheInfluence(poffense)='Y' OR     
						// Is_Drunkenness(poffense)='Y' OR                  
						// Is_FamilyOffenses(poffense)='Y' OR     
						// (Is_LiquorLawViolations(poffense)='Y' and REGEXFIND('^ TRAFFIC',poffense,0)='') OR          
						// Is_TrespassofRealProperty(poffense)='Y' OR       
						// Is_PeepingTom(poffense)='Y' OR                   
						// Is_HumanTrafficking(poffense)='Y' =>  'N', 

						
REGEXFIND('WILD|ANIMAL|WOLF|RACCOON|HUNT|MONKEY|COUGAR|FARE|FISH|DEER|GAME|BOMB' ,poffense)    => 'N',

//Roger's comments - QA Update - Traffic   Round 3 8/26/16		
REGEXFIND('DRIV|OPR'                             		    ,poffense)   and
REGEXFIND('U/INFLU|/U THE INFLU|/INFLUENCE|W/UND/INFLU',poffense)    => 'N',

REGEXFIND('DRIV[E|I| |\\.]|BOATING|OPR'                ,poffense)   and
stringlib.stringfind(poffense ,'INFLUEN'               ,1) <> 0     and
REGEXFIND('UNDER|UND|WHILE|LIQUOR|ALCOH|DRUG|NAC|CONT[.]+SUB|SUB[.*]CONT',poffense)   => 'N',						

//Roger's comments - QA Update - Traffic   Round 4 9/23/16 and 9/27/16
REGEXFIND('BUSIN[ESS]*|VENDOR'                         ,poffense)   and
REGEXFIND('LICENSE|LIC |LIC[\\.]?$|LICENS$|PERMIT'	    ,poffense)   and
REGEXFIND('NO[T]? |EXPIRED|FAIL[ |E|U|/]|SUSPEND|NO |REQ[U| ]|WITHOUT|W/O',poffense)    => 'N',

stringlib.stringfind(poffense ,'HIT'               ,1) <> 0     and
stringlib.stringfind(poffense ,'RUN'               ,1) <> 0     =>'Y',

// REGEXFIND('INFRACTION VC'                            ,poffense)   => 'Y',

REGEXFIND('VEH| M[/]*V '                                ,poffense)   and
REGEXFIND('COMM|SUSP|REVOC'                             ,poffense)   and
REGEXFIND('[/\\. ]DR[/\\. ]|[/\\. ]OP[/\\. ]|OPER'      ,poffense)   => 'Y',

REGEXFIND('SUSP|REVOC'                                  ,poffense)   and
REGEXFIND(' DR[VING]*[/\\. ]|[/\\. ]DR[VING]*[/\\. ]'   ,poffense)   => 'Y',

REGEXFIND('VEH| M[/]*V '                                ,poffense)   and
REGEXFIND(' NO |NON|REQ|REST|DEF|IMPRO| ON | NO |ALL|OPER|VIEW| W[/]O |MISS| T[/]H ',poffense)   and
stringlib.stringfind(poffense ,'MIRROR'                 ,1) <> 0     => 'Y',

stringlib.stringfind(poffense ,'PASS'                   ,1) <> 0     and
stringlib.stringfind(poffense ,'SHOULD'                 ,1) <> 0     and 
REGEXFIND('[/\\. ]IN[/\\. ]|[/\\. ]OF[/\\. ]|[/\\. ]ON[/\\. ]|[/\\. ]OL[/\\. ]'   ,poffense)   => 'Y',

REGEXFIND('[/ \\.]DR[/\\. ]|DRV[N]*G'                   ,poffense)   and
stringlib.stringfind(poffense ,'RDWAY'                  ,1) <> 0     and  
REGEXFIND('[/\\. ]OF[/\\. ]|[/\\. ]ON[/\\. ]'           ,poffense)   => 'Y',

stringlib.stringfind(poffense ,'DEF'                    ,1) <> 0     and  
stringlib.stringfind(poffense ,'EQUIP'                  ,1) <> 0     and  
stringlib.stringfind(poffense ,'TURN'                   ,1) <> 0     and  
stringlib.stringfind(poffense ,'SIG'                    ,1) <> 0     => 'Y',

stringlib.stringfind(poffense ,'UNLAW'                  ,1) <> 0     and 
(stringlib.stringfind(poffense ,'TIRE' ,1) <> 0 OR
	(stringlib.stringfind(poffense ,'LANE' ,1) <> 0 and REGEXFIND('CHANG|CHANI',poffense)  ) 
) => 'Y',
 
REGEXFIND('FTO | FTO' ,poffense)   and 
~((stringlib.stringfind(poffense ,' CT ' ,1) <> 0 and stringlib.stringfind(poffense ,'ORD'   ,1) <> 0 ) or
		(stringlib.stringfind(poffense ,'GOOD' ,1) <> 0 and stringlib.stringfind(poffense ,'BEHAV' ,1) <> 0 ) 
	)  => 'Y',
 
REGEXFIND('OBEY|OBY'                ,poffense)   and						 
stringlib.stringfind(poffense ,'FA' ,1) <> 0     and 
(
 REGEXFIND('EMERG EQP|CROSSING GU|NO U TUR|SIG|HW[A]*Y|[/\\. ]RED|RIGHT|HIGHW|LANE|DEVIC|LIC|FLASH|HGY|HAYW|HI[G]*WAY|HSWY|HW|S[I]*GN|BLIN|WAKE|O[\\./]L',poffense,0) <>'' or
 (stringlib.stringfind(poffense ,'LN'   ,1) <> 0 and REGEXFIND('CHANG|DREC|DIR|MRKNG'      ,poffense)) or
 (stringlib.stringfind(poffense ,'TRA'  ,1) <> 0 and stringlib.stringfind(poffense ,'LGHT' ,1) <> 0  ) or
 (stringlib.stringfind(poffense ,'TRAF' ,1) <> 0 and REGEXFIND('DE|CNT|CTRL|CNTRL|CON'     ,poffense)) or
 (REGEXFIND('TRF|TRFC',poffense,0) <>''          and REGEXFIND('SGN|DEV|CONTR|LT|LITE'     ,poffense)) or
 (stringlib.stringfind(poffense ,'TURN' ,1) <> 0 and stringlib.stringfind(poffense ,'ARROW',1) <> 0  ) 
)  => 'Y',
						 
stringlib.stringfind(poffense ,'FAIL' ,1) <> 0     and
(
 (stringlib.stringfind(poffense ,'VEH'    ,1) <> 0 and stringlib.stringfind(poffense ,'UNDER'   ,1) <> 0 and stringlib.stringfind(poffense ,'CONT' ,1) <> 0 ) or
 (stringlib.stringfind(poffense ,'GIVE'   ,1) <> 0 and stringlib.stringfind(poffense ,'NOTICE'  ,1) <> 0 and stringlib.stringfind(poffense ,'ACC'  ,1) <> 0 ) or
 (stringlib.stringfind(poffense ,'AVOID'  ,1) <> 0 and stringlib.stringfind(poffense ,'COLLIS'  ,1) <> 0 ) or
 (stringlib.stringfind(poffense ,'DIM'    ,1) <> 0 and REGEXFIND('BEAM| LT | LTS ',poffense)  ) or
 (stringlib.stringfind(poffense ,'REMAIN' ,1) <> 0 and REGEXFIND('LANE|SCEN|ACC',poffense)  ) or
 (stringlib.stringfind(poffense ,'CONTROL',1) <> 0 and REGEXFIND('WEAVING|VEHICLE',poffense)  ) or
 (stringlib.stringfind(poffense ,'RIGHT'  ,1) <> 0 and REGEXFIND('CNT |CTR ',poffense)  ) or
  REGEXFIND('PROOF OF INSURANCE|KEEP RIGHT',poffense)    					 
) => 'Y',

stringlib.stringfind(poffense ,'UNLAW'    ,1) <> 0   and
stringlib.stringfind(poffense ,'OP'       ,1) <> 0   and
stringlib.stringfind(poffense ,'HWY'      ,1) <> 0   and
REGEXFIND(' MV | M[/]V |VEH|MOTOR'        ,poffense) => 'Y',

stringlib.stringfind(poffense ,'DEADLINE'    ,1) <> 0   and
REGEXFIND('OP|OPER'                ,poffense)   and 
REGEXFIND('AFTER|PAST'             ,poffense)   and 
REGEXFIND(' M[\\./]*V[\\. ]|VEH'   ,poffense)   => 'Y',

REGEXFIND('FAIL|FALSE|WRONG'                       ,poffense)   and
stringlib.stringfind(poffense ,'DISPL'             ,1) <> 0     and
( REGEXFIND('D[\\.]L[\\.]| D[/]L |PLATE| REG | INSP',poffense,0) <>'' or
 (REGEXFIND('INSPECT| MV[I]* '  ,poffense,0) <>'' and REGEXFIND('STICKER' ,poffense)  ) 
) => 'Y',
							
stringlib.stringfind(poffense ,'FAIL'            ,1) <> 0     and
stringlib.stringfind(poffense ,'USE'             ,1) <> 0     and
( stringlib.stringfind(poffense ,'INDICATOR',1) <> 0 or
 (stringlib.stringfind(poffense ,'SAF'      ,1) <> 0 and stringlib.stringfind(poffense ,'SEAT' ,1) <> 0) 
)  => 'Y',
							
stringlib.stringfind(poffense ,'FAIL'            ,1) <> 0     and
stringlib.stringfind(poffense ,'EMER'            ,1) <> 0     and
( stringlib.stringfind(poffense ,'YLD'  ,1) <> 0 or
  stringlib.stringfind(poffense ,'YIELD',1) <> 0 or
 (stringlib.stringfind(poffense ,'CHANG',1) <> 0 and stringlib.stringfind(poffense ,'LANE' ,1) <> 0) 
)  => 'Y',							

stringlib.stringfind(poffense ,'EXHAUST'            ,1) <> 0     and
REGEXFIND('BATH|VENT'                               ,poffense,0) =  '' => 'Y',	
						
stringlib.stringfind(poffense ,'CARRY '            ,1) <> 0     and
stringlib.stringfind(poffense ,'INS'             ,1) <> 0     and
REGEXFIND('LIAB|COMP|VEH|MOTOR|AUTO| MV | M[/]V '   ,poffense)   => 'Y',
						 
						 
stringlib.stringfind(poffense ,'FAIL'               ,1) <> 0     and
REGEXFIND('DE |MNT | DR[V]* |MAIN|CHNG |CHG '       ,poffense)   and
REGEXFIND('SG[N]*L |SIG | SING| [S1][ ]| ONE'       ,poffense)   and
REGEXFIND('[ ]LN |LANE'                             ,poffense)   => 'Y',
						 
stringlib.stringfind(poffense ,'FAIL'               ,1) <> 0     and
stringlib.stringfind(poffense ,'PASS'               ,1) <> 0     and
REGEXFIND('WEAR|FAST'                               ,poffense)   and
REGEXFIND('S[/]BEL|SEAT| SE | S '                   ,poffense)   => 'Y',
						 
stringlib.stringfind(poffense ,'FAIL'               ,1) <> 0     and
REGEXFIND('SGL |SIG | SING|SIGN '                   ,poffense)   and
REGEXFIND('TURN|INTENT| LN '                        ,poffense)   => 'Y',

stringlib.stringfind(poffense ,'RACING'             ,1) <> 0     and  
stringlib.stringfind(poffense ,'HWY'                ,1) <> 0     => 'Y',

stringlib.stringfind(poffense ,'DRAG'               ,1) <> 0     and  
stringlib.stringfind(poffense ,'RAC'                ,1) <> 0     => 'Y',
						 
REGEXFIND('DR[/\\. ]|DR[IV][\\. ]|DR[IA]+VE|DRV[IN]*G[\\. ]|DRVE |[/\\. ]DRG[/\\. ]| DRG[/\\. ]'            ,poffense)   and						 
(	REGEXFIND('SHOULDER|ONEWAY'             ,poffense)   or
	 (REGEXFIND('LEFT|LFT |LF |PROH'         ,poffense,0) <>'' and REGEXFIND('CNTR|CTR |CENT|SHOULD|SHLDR'     ,poffense)  ) or
  (REGEXFIND('[/\\. ]ON[/\\. ]'           ,poffense,0) <>'' and REGEXFIND('SHOULD|SHLDR|MEDIAN|ISLAND|MED ' ,poffense)  ) or
	 (REGEXFIND('[/\\. ]WR[/\\. ]|[/\\. ]WRG[/\\. ]' ,poffense,0) <>'' and REGEXFIND('[/\\. ]SD[/\\. ]|SIDE|WAY|[/\\. ]RD[/\\. ]|[/\\. ]SS[/\\. ]|[/\\. ]ST[/\\. ]'    ,poffense)  ) or
	 (REGEXFIND('W[/]O | WO |W[/]OUT'        ,poffense,0) <>'' and REGEXFIND('H[EA]*DLT|[/\\. ]LT[/\\. ]|[/\\. ]LTS[/\\. ]',poffense)   ) or
	 (REGEXFIND('ONE[/\\. ]'                 ,poffense,0) <>'' and stringlib.stringfind(poffense ,'WAY'        ,1) <> 0  ) or
	 (REGEXFIND('OFF[/\\. ]'                 ,poffense,0) <>'' and REGEXFIND('RDWAY|RDWY'                      ,poffense)   ) 
)  => 'Y',
						 
REGEXFIND(' FMC | FOHS[\\( ]| FMFR | FTMFR | DECAL | FSRA | FTD[/ ]| DPS | EDXP | EDXPIRED',poffense) => 'Y',

REGEXFIND('EXPRI[R]*ED|EXPR[/ ]'                                ,poffense)   and
REGEXFIND(' DISP[/ ]| DISP[/ ]|DISPLAY| DRVG | DSPLY '          ,poffense)   => 'Y',

REGEXFIND('[/\\. ]EDXP[/\\. ]|[/\\. ]EXSP[/\\. ]|[/\\. ]EXIRD[/\\. ]|[/\\. ]EXPR[/\\. ]|[/\\. ]EXSP[/\\. ]|[/\\. ]EXPP[/\\. ]|[/\\. ]EXPI[/\\. ]|[/\\. ]EXPP[/\\. ]|[/\\. ]EXPIARED[/\\. ]|[/\\. ]EXPPRD[/\\. ]|[/\\. ]EXPIARED[/\\. ]|[/\\. ]EXP[R]*I[R]*ED[/\\. ]|[/\\. ]EXIR[/\\. ]|[/\\. ]EXIRP[/\\. ]|[/\\. ]EXIP[/\\. ]|[/\\. ]EXIPED[/\\. ]|[/\\. ]EXIPIR| EXIPR| EXPR[E]*D' ,poffense)   and
REGEXFIND('DECAL|STICK| INSP | STATE |RGSTR|REG[\\.ISTRATION]+ |REGIST| STK |INSEPCTIO|INPSPECTIO|INPSEC|INSPCTIO|ISPECTIO|INSP[\\.E]| O[/\\. ]+L[\\. ]+ | OL | DL |IMSPECT|INSPEXTION|RGEISTR|REGSTR| STKR |ISPECTION| MVI |MVIS |O[/\\. ]+L |TAG|LIC[EN ]+|METER'    ,poffense,0) <>  '' => 'Y',

REGEXFIND(' PK| PK |PARKING'                                               ,poffense) and
REGEXFIND('VIO| VHCL| CURB|METER| MTR| RDWY| HWY| ANGLE| GRASS |PROHIBITED',poffense) => 'Y',

REGEXFIND('( PKT| PKG| PKING| PKNG)[ ](TKT|TCKT|VIOL|VIO|[0-9]+)[ ]*'  ,poffense) => 'Y',

REGEXFIND('ENTER|CENTER'                                               ,poffense) and
REGEXFIND(' DRWY | RDWY | H[G]*WY | DRVWAY | H[I]*GHWY | FWY '         ,poffense) => 'Y',

REGEXFIND(' DOT|[/ ]DOT|[/ ]DOT#'                                      ,poffense7) and
REGEXFIND(' NUMBER | NAME |#|DISPLAY|VIO| DISP |MARK|INCOR|IMPROP| ID ',poffense7) => 'Y',

stringlib.stringfind(poffense ,'EXPRESS'                               ,1) <> 0     and  
stringlib.stringfind(poffense ,'LANE'                                  ,1) <> 0     => 'Y',

stringlib.stringfind(poffense ,'OVERTIME'           ,1) <> 0     and 
REGEXFIND(' PK | PKG |METER|DOCK|MOORING'           ,poffense,0) <>  '' => 'Y',
						 
stringlib.stringfind(poffense ,'DAMAGE'             ,1) <> 0     and 
REGEXFIND('MV|VEH|AUTO|ACC|WINDSHIELD'              ,poffense)   and
REGEXFIND('CRIM|WILLFUL|MALIC|REPAIR|TAMPER'        ,poffense,0) =  ''=> 'Y',

stringlib.stringfind(poffense ,' FTK '              ,1) <> 0     and  
stringlib.stringfind(poffense ,'RIGHT'              ,1) <> 0     => 'Y',

stringlib.stringfind(poffense ,' FTN'               ,1) <> 0     and  
stringlib.stringfind(poffense ,'DMV '               ,1) <> 0     and  
stringlib.stringfind(poffense ,'ADD'                ,1) <> 0     => 'Y',

REGEXFIND('F[AO][L]+OW'                             ,poffense)   and
REGEXFIND('CLOS|CLS'                                ,poffense,0) <>  '' => 'Y',
						 
REGEXFIND('[\\./ ]PK[\\./ ]'                        ,poffense)   and
REGEXFIND('TIC[\\./ ]|TKT[\\./ ]'                   ,poffense)   and
REGEXFIND('[PROTEST ]*#[ ]*[0-9]+|[PROTEST ]*[0-9]+',poffense7,0) <>  '' => 'Y',
						 
REGEXFIND('[\\./ ]PK[\\./ ]'                        ,poffense)   and
REGEXFIND('[PROTEST ]*#[ ]*[0-9]+|[PROTEST ]*[0-9]+',poffense7,0) <>  '' => 'Y',

REGEXFIND('[\\./ ]PK[\\./ ]'                        ,poffense)   and
REGEXFIND('DECAL[/ ]|DECL '                         ,poffense)   and						 
REGEXFIND('TIC |#[ ]*[0-9]+|[0-9]+'                 ,poffense7,0) <>  '' => 'Y', 

REGEXFIND('EXHAUST|EXHST'                           ,poffense)   and
REGEXFIND('BATH|VENT'                               ,poffense)   => 'Y',

stringlib.stringfind(poffense ,'CHILD'              ,1) <> 0     and  
REGEXFIND('UNSECU|RESTRAINT|UNRESTR'                ,poffense,0) <>  '' => 'Y',	

stringlib.stringfind(poffense ,'LEAV'               ,1) <> 0     and  
REGEXFIND('CH[I]*LD'                                ,poffense)   and
REGEXFIND('CAR|MV|VEH'                              ,poffense,0) <>  '' => 'Y',	
						 
stringlib.stringfind(poffense ,'FA/'               ,1) <> 0     and
( 
 (stringlib.stringfind(poffense ,'CAR'  ,1) <> 0 and stringlib.stringfind(poffense ,'REG'   ,1) <> 0) or
 (stringlib.stringfind(poffense ,'DISPL',1) <> 0 and REGEXFIND('HDLGHT|HEADLI|OL|DL|VEH',poffense)  ) or
 (stringlib.stringfind(poffense ,'WEAR' ,1) <> 0 and stringlib.stringfind(poffense ,'CORREC',1) <> 0) or
 (REGEXFIND('HWY|TR',poffense,0)<>'' and REGEXFIND('SIG',poffense)  )
) => 'Y',

REGEXFIND('FAIL|FA[/]'                               ,poffense)   and						 
(  (stringlib.stringfind(poffense ,'MAINT' ,1) <> 0   and stringlib.stringfind(poffense ,'CONT' ,1) <> 0)  or
	 (REGEXFIND('DISP|WEAR'                  ,poffense) and REGEXFIND('TAG|SEAT'  ,poffense)              )  or
	 (REGEXFIND('RES|SECURE'                 ,poffense) and stringlib.stringfind(poffense ,'CHILD',1) <> 0)  or
	 (REGEXFIND('COVER|SECURE'               ,poffense) and stringlib.stringfind(poffense ,'LOAD' ,1) <> 0)  or
	 (stringlib.stringfind(poffense ,'TO'    ,1) <> 0   and stringlib.stringfind(poffense ,'DIM'  ,1) <> 0)  or
	 (stringlib.stringfind(poffense ,'REPORT',1) <> 0   and stringlib.stringfind(poffense ,'ACC'  ,1) <> 0)  
) => 'Y',
	
stringlib.stringfind(poffense ,'EX'               ,1) <> 0     and
( 
 (stringlib.stringfind(poffense ,'OPR'    ,1) <> 0 and REGEXFIND('LIC|REG',poffense)  ) or
 (stringlib.stringfind(poffense ,'INSPECT',1) <> 0 and stringlib.stringfind(poffense ,'ST' ,1) <> 0)
) => 'Y',
						 		
stringlib.stringfind(poffense ,'EXIT'               ,1) <> 0     and						 
REGEXFIND('HWY|FWY|PAY|FARE|HW |RWY|RDWAY',poffense,0) <>'' and REGEXFIND('LIC|REG',poffense)   => 'Y',
						 
stringlib.stringfind(poffense ,'LIC'                 ,1) <> 0     and
stringlib.stringfind(poffense ,'PLATE'               ,1) <> 0     and						 
REGEXFIND('IMPRO|L[I]*GHT'                           ,poffense)   => 'Y',
						 
stringlib.stringfind(poffense ,'EXOP'                 ,1) <> 0     and						 
REGEXFIND('SP|INSP|LIC|REG'                         ,poffense)   => 'Y',
					 
REGEXFIND('ESPIRED|EX[P]*IRED'                        ,poffense)   and
( REGEXFIND('INSP|INSEC|INS[EP]+C|REG|TAG|PLATE|DECAL|LIC|STICK|MOTOR|D[/]L|CDL| OL |O\\.L\\.|REJEC'   ,poffense)   or
 (stringlib.stringfind(poffense ,'REJ',1) <> 0 and stringlib.stringfind(poffense ,'STKR',1) <> 0) )=> 'Y',						 
						 
stringlib.stringfind(poffense ,' PASSING '          ,1) <> 0     => 'Y',
REGEXFIND('DRIV|DROV'                               ,poffense)   => 'Y',
stringlib.stringfind(poffense ,'STOP SIGN'          ,1) <> 0     => 'Y',
			 
REGEXFIND('CONTESTED | CONT |CONT PK|DUSW'          ,poffense)   and
REGEXFIND('TICKET|TICK |TIC[# ]|TKT '               ,poffense)   => 'Y',						 
						 
stringlib.stringfind(poffense ,'OP '                ,1) <> 0     and
stringlib.stringfind(poffense ,'NOT REASON'         ,1) <> 0     => 'Y',
                                        
stringlib.stringfind(poffense ,'OP '                ,1) <> 0     and
stringlib.stringfind(poffense ,'DEVICE'             ,1) <> 0     and
stringlib.stringfind(poffense ,'WIRELESS'           ,1) <> 0     => 'Y',

REGEXFIND('PERM[I]*T|LICENSE|LIC|REG'               ,poffense)   and
REGEXFIND('VIO|RVKD|LIMIT|REQ|RE |ONLY|W[/][ ]*[OUT]*|WITHOUT|WITH'   ,poffense)   and
REGEXFIND('DRIV|DROV| DR |OP |VEH|MV |WATERCRATFT|BOAT|VESSEL|JET|INSTRUC|INST|INSTR|INSTRN|INS|LEARN|CHAUF|COMMER' ,poffense)   => 'Y',             
						 
REGEXFIND('PERM[I]*T|LICENSE|LIC'                   ,poffense)   and
REGEXFIND('CHAUF|INSTR|BEGI|DRIV|DROV|LEARN|LERN|LRNRS|DR |COMM|COMMERCIAL|HAUL' ,poffense)   => 'Y',

REGEXFIND('PERM[I]*T|LICENSE|LIC|REG'               ,poffense)   and
REGEXFIND('DRIV|DROV|DR |OP |TRANS'                 ,poffense)   and
REGEXFIND('NO |RVKD|W/[ OUT]*|WITHOUT|UNPAID'       ,poffense)   => 'Y',
             
REGEXFIND('PERM[I]*T|ALLOW'                         ,poffense)   and
REGEXFIND('MINOR|CHILD|PERSON|ANOTHER'              ,poffense)   and
REGEXFIND('WITHOUT|W/O|W/[ ]*OUT'                   ,poffense)   and
stringlib.stringfind(poffense ,'LIFE'               ,1) <> 0     => 'Y',
             
REGEXFIND('PERM[I]*T|LICENSE|LIC|REG'               ,poffense)   and
REGEXFIND('DRIV|DROV|DR |OP'                        ,poffense)   and
REGEXFIND('MINOR|PERSON|PRS|PRSN|CHILD|ANOTHER|UNDER|UNAUTH|U/AUTH|UNATHZ|UNQUAL' ,poffense)   => 'Y',
             
REGEXFIND('PERM[I]*T'                               ,poffense)   and
REGEXFIND('DRIV|DROV|DR |OP'                        ,poffense)   and
stringlib.stringfind(poffense ,'CLASS'              ,1) <> 0     and						 
REGEXFIND('VEH|M[/]V|MV '                           ,poffense)   => 'Y',
						 
REGEXFIND('PERM[I]*T|ALLOW'                         ,poffense)   and
REGEXFIND('DRIV|DROV|DR |OP '                       ,poffense)   and
REGEXFIND('WITHOUT|W/[ ]*O[UT]*|NO |UNPAID'         ,poffense)   and
REGEXFIND('VEH|M[/]V|MV |WATERCRATFT|BOAT|VESSEL'   ,poffense)   => 'Y',

REGEXFIND('PERM[I]*T|LICENSE|LIC|REG'               ,poffense)   and
REGEXFIND('VEH|MV|DRIV|OP'                          ,poffense)   and
REGEXFIND('FICT|FAKE|F[A]*LSE|FAL'                  ,poffense)   => 'Y',
      
REGEXFIND('PERM[I]*T|DEC'                           ,poffense)   and
REGEXFIND('REQ|RE |RVKD|W/[ OUT]*|WITHOUT|WITH'     ,poffense)   => 'Y',
						                                         
REGEXFIND('PERM[I]*T'                               ,poffense)   and
stringlib.stringfind(poffense ,'DEC'                ,1) <> 0     and
stringlib.stringfind(poffense ,'PLATE'              ,1) <> 0     => 'Y',			 
                                                              
REGEXFIND('PERM[I]*T'                               ,poffense)   and
stringlib.stringfind(poffense ,'EXCESS'             ,1) <> 0     and
stringlib.stringfind(poffense ,'REQ'                ,1) <> 0     and
stringlib.stringfind(poffense ,'SIGN'               ,1) = 0      => 'Y',						 
                                                              
REGEXFIND('PERM[I]*T'                               ,poffense)   and
REGEXFIND('VEH|M[/]V| MV '                          ,poffense)   and
( (stringlib.stringfind(poffense ,'NOT' ,1) <> 0  and stringlib.stringfind(poffense ,'VISI',1) <> 0 )   or 
   stringlib.stringfind(poffense ,'HIRE',1) <> 0
)   => 'Y',
	                                                   
REGEXFIND('FR[ON]+[T]*'                              ,poffense)   and
REGEXFIND('LIC|PLATE|REG|TAG'                        ,poffense)   => 'Y',
						                                                 
REGEXFIND('TAK|USE|OP|REMOVE'                        ,poffense)   and 
REGEXFIND('VEH|AUTO|M[/]*V|BOAT|ATV'                 ,poffense)   and 
stringlib.stringfind(poffense ,'PERMIS'              ,1) = 0      and
REGEXFIND('WITHOUT|W[/-]*O|NO'                       ,poffense7)  => 'Y',
						 						 
stringlib.stringfind(poffense ,'SCHOOL'              ,1) <> 0     and						 
REGEXFIND('BUS|ZONE|ZN'                              ,poffense)   and
REGEXFIND('STOP|STP|PASS|OVERT|DISRE|F\\.T\\.S|FAIL|OBEY| FT |DISK'  ,poffense) => 'Y',
						 
REGEXFIND('STOP|STP'                                 ,poffense)   and
~REGEXFIND('PAY|PMT|PYMT|FOOD|ARREST|ARST|ARRST|CHECK|CHRISTOPHER|CHRISTOPOLOU|URINATE|ORD|CONT|DEATH|DETH|FRISK|ARRES'  ,poffense) => 'Y',
 
REGEXFIND('TRAFF|TRAFFIC'                            ,poffense)   and
~REGEXFIND('TRAFFICING|TRAFFICNG|TRAFFICO|TRAFFICS|TRAFFING|TRAFFI[CN]KING|TRAFFIS|TRAFFKG|TRAFFKICKING|TRAFFKING|TRAFFKNG|TRAFFRKG' ,poffense) and 
~REGEXFIND('COC|CIG|PHENE|OPIUM|FOOD|DOOD|FOD|COKE|CRANK|CRACK|BEER|LIQUOR|ALCOHOL|MAR,|MARI|MARIH|MJ|MDA|MDM|CHILD|PERSON|ROHYP|F.S.|UDOCS|HYDROC|OXYC|PSEDOE|ECSTA|CDS|METH|SEX|WILDLIFE|META|CANN|WILD|PROST|FORCE|SLAV|SEX|PERSON|HUMAN.' ,poffense) and 
Is_Drug_Narcotic(poffense)                            =  'N' => 'Y', 
						 
REGEXFIND('INSUR|INSURANCE|INS|LIAB|INSP|INSPEC|STICK' ,poffense)   and
REGEXFIND('NO|WITHOUT|W[/]O|PROOF|PRF'                 ,poffense)   and
~REGEXFIND('FINL|FINC'                                 ,poffense)   => 'Y',

REGEXFIND('FAIL|FAILURE|PRODUCE|CARRY'                 ,poffense)   AND
REGEXFIND('FIN|FINANCIAL'                              ,poffense)   AND
REGEXFIND('RESP|INSURANCE'                             ,poffense)    => 'Y',	
						 
REGEXFIND('DUTY|APPRO|F/[TO]*|F\\.TO|FT|F\\.T\\.| FL |DISRE|F[/-]T|FAI[L]| FA |FIAL|F[AI]*LURE|R[-]*O[-]*W|ROW|SIGN|DIS|F[-]T-[OS]|OBEY|RIGHT|FALI |FAL | FIL | FLD |WAY|TURN| RT'    ,poffense7,0) <> '' and
stringlib.stringfind(poffense ,'YEILD'                 ,1) <> 0				 => 'Y',
	
REGEXFIND('UNAU|UNAT |UNSAF'                           ,poffense)   and
REGEXFIND('VEH|MV|BOAT'                                ,poffense)   and
REGEXFIND('CHILD|MINOR'                                ,poffense,0) = ''  => 'Y',
												 
REGEXFIND('DROV|DRIV|OP'                               ,poffense)   and
REGEXFIND('VEH|MV|BOAT'                                ,poffense)   and
stringlib.stringfind(poffense ,'INS'                   ,1) <> 0				 => 'Y',			 
						 
REGEXFIND('VEH|MV|BOAT'                                ,poffense)   and
REGEXFIND('UNREG|COMME[R]+[CI]+AL|COMMERR'             ,poffense)   => 'Y',
						 
REGEXFIND('F[OA]LLOW'                                  ,poffense)   and
stringlib.stringfind(poffense ,'CLOSE'                 ,1) <> 0     and
REGEXFIND('TOO|TO'                                     ,poffense)   => 'Y',
						 
REGEXFIND('VEH|MV'                                     ,poffense)   and
REGEXFIND('WRONG|INV'                                  ,poffense)   and
REGEXFIND('INSP|LIC|PLAT|PLT|REG'                      ,poffense)   => 'Y',
						 
stringlib.stringfind(poffense ,'WRONG'                 ,1) <> 0     and	
REGEXFIND('DR|OP|DRIV'                                 ,poffense)   and
REGEXFIND('SIDE|WAY|PLACE|PLC|DIR|LIC|REG|INSP|LIC|PLAT|PLT',poffense)    => 'Y',
						 
REGEXFIND('PASS|TURN'                               ,poffense)   and
REGEXFIND('UNLAW|RECKL'                             ,poffense)   and
REGEXFIND('PASSW|RETURN|TRESPASS'                   ,poffense,0) = '' => 'Y',

REGEXFIND('LANE'                                    ,poffense)   and
stringlib.stringfind(poffense ,'LANE'               ,1) <> 0     and	
REGEXFIND('UNSAF|USAF|SWIT|PROHIB|DIR|MAINTAIN|LEFT',poffense)   => 'Y',
						 
REGEXFIND('IMPRO|IMP'                               ,poffense)   and
REGEXFIND('BACKING|TURN|PASS|REG'                   ,poffense)   => 'Y',
						 
REGEXFIND('DRIV|OP'                                 ,poffense)   and
stringlib.stringfind(poffense ,'COND'               ,1) <> 0     and	
REGEXFIND('DISORD|CONDUCT|CONDE'                    ,poffense,0)  = '' => 'Y',
			  
REGEXFIND('RECKL|RCK'                               ,poffense)   and
REGEXFIND('DR|OP|DRIV'                              ,poffense)   and
REGEXFIND('BOAT|CRAFT|VEH|MV|M/B|PWC|W/C|W/KRFT'    ,poffense)   => 'Y',
						 
REGEXFIND('RECKL| RCK |RECK '                       ,poffense)   and
stringlib.stringfind(poffense ,'DR'                 ,1) <> 0				 => 'Y',							 
							  
stringlib.stringfind(poffense ,'LANE'               ,1) <> 0     and	
stringlib.stringfind(poffense ,'IMP'                ,1) <> 0     and							 
REGEXFIND('CHAG|CHAN'                               ,poffense)   => 'Y',
					 
REGEXFIND('SP[PE]+D| SPD[G]*|SPEE[ CEID]+NG|[0-9]{2}[- /][0-9]{2}[ -/]SP|[*]SPD|SP[ ]*[0-9]{2}| SP[/\\. ]+[0-9]+[-/ ]|CTR/[ ]*SPD [S/Z]+ [0-9]+/[0-9]+',poffense7,0) <> ''     => 'Y',						 
						 
REGEXFIND('LEFT|RIGHT'                              ,poffense)   and
REGEXFIND('TURN|TRN|TUR|RED|MIRR|MAK|MISS|NO|ON|SIDE|CENT|DOUB|DBL|DLB|OVER|SIDE|PASS|PED|PROHIB|DRIV|REAR|RIDE|LANE|LAN|TRAIL|TRLR|TRL|UNSAF',poffense)       => 'Y',

REGEXFIND('UNLICENSE|W[ITH/]+OUT(.*) LIC'           ,poffense)   and
REGEXFIND('MOTOR V|BOAT|MOPED|DR[\\.IVG ]+|VEH|TAXI|M[/\\. ]V|MV[/\\. ]|MOTO[R ]*CYC|CAB|FARE|PA[SE]+NG'                                ,poffense)   => 'Y',

stringlib.stringfind(poffense ,'HOOD'               ,1) <> 0     and	
REGEXFIND('SCO[O]+P'                                ,poffense)   => 'Y',
            
stringlib.stringfind(poffense ,'LIFE'               ,1) <> 0     and
REGEXFIND('P[ER]+SERV'                              ,poffense)   => 'Y',
						 
stringlib.stringfind(poffense ,'OVER'               ,1) <> 0     and						 
REGEXFIND('HOUR|HR'                                 ,poffense)   and 
stringlib.stringfind(poffense ,'BODY'               ,1) = 0     and
stringlib.stringfind(poffense ,'WASTE'              ,1) = 0 			 => 'Y',

stringlib.stringfind(poffense ,'PLATE'               ,1) <> 0     and		
						 ( REGEXFIND('VIO',poffense)   OR 
							 (REGEXFIND('PREV',poffense,0) <>'' and REGEXFIND('OWN',poffense)  )
						 ) => 'Y',

REGEXFIND('VEH|M[/]*V|FUEL'                         ,poffense)   and
stringlib.stringfind(poffense ,'POINT'              ,1) <> 0     and	
stringlib.stringfind(poffense ,'SYSTEM'             ,1) <> 0     => 'Y',						 
						 
REGEXFIND('VEH|M[/]*V'                              ,poffense)   and
stringlib.stringfind(poffense ,'MAIN'               ,1) <> 0     => 'Y',			
						 
REGEXFIND('SAFE|SFTY|SEAT'                          ,poffense)   and
REGEXFIND('B[E]*LT'                                 ,poffense)   => 'Y',

stringlib.stringfind(poffense ,'TRUCK'              ,1) <> 0     and
REGEXFIND('COMMER|COMMON'                           ,poffense)   => 'Y',
						 
stringlib.stringfind(poffense ,'FULL'               ,1) <> 0     and	
stringlib.stringfind(poffense ,'TIME'               ,1) <> 0     and	
stringlib.stringfind(poffense ,'ATT'                ,1) <> 0     => 'Y',								 
						 
stringlib.stringfind(poffense ,'TRANSPAR'           ,1) <> 0     and						 
(REGEXFIND('WIND',poffense,0) <>  '' or REGEXFIND('MAT',poffense,0) <>  '') => 'Y',

REGEXFIND('PRMT |PERM'                 ,poffense) and
  stringlib.stringfind(poffense ,'VIO' ,1) <> 0  and							 
( stringlib.stringfind(poffense ,'SPD' ,1) <> 0  or 
  stringlib.stringfind(poffense ,'LIC' ,1) <> 0  or
 (stringlib.stringfind(poffense ,'DR'  ,1) <> 0  and stringlib.stringfind(poffense ,'CERT'       ,1) <> 0 ) or
	(stringlib.stringfind(poffense ,'AX'  ,1) <> 0  and stringlib.stringfind(poffense ,'MIN'        ,1) <> 0 ) or
	(stringlib.stringfind(poffense ,'NO'  ,1) <> 0  and REGEXFIND('DIMEN|TRAV',poffense)  ) 
) => 'Y',

REGEXFIND('P[A]*RK'                                 ,poffense) and
stringlib.stringfind(poffense ,'MINOR'              ,1) = 0    and	
REGEXFIND('TICKET|TK[TE]|T[RC]K|TK|TI[CKT]| TT |FINE|ZONE|PERM|PRMT|VIO|DECAL|CURB|VEH|MV|TRACT|CAR|BOAT|TRLR|S[I]*DEW[A]*LK|CR[O]*SSW[A]*LK|OVERTIME|'+
          'FRONT|WRONG|WHERE|WRNG| RICKET|DEC|PERM|STICK|PLATES|RDWY|YARD|PRHBD|YLLW|PRHBTD|PROP|SPCE|PHYSIC|EXCEPT|TRVL| SUM/| SUMMON|'+
          'HYD|SNOW|TRAFF|HGWY|HWY|SPACE|SPCE|LANE|NO |OBST|BEYOND|BLOCK|BOAT|DESIG|DISAB|TRUCK|TRK|SNOW|EXEMPT|H\\.C\\.|H[/]C|IMPR|SCHOOL'
          ,poffense,0) <>  '' => 'Y',
				 						 	
REGEXFIND('P[A]*RK'                                 ,poffense)   and
	((stringlib.stringfind(poffense ,'LOAD'    ,1) <> 0 and          REGEXFIND('ZO|ZN'                             ,poffense)) or
	 (stringlib.stringfind(poffense ,'PROH'    ,1) <> 0 and          REGEXFIND('ZO|ZN'                             ,poffense)) or						 
	 (stringlib.stringfind(poffense ,'UNATT'   ,1) <> 0 and          REGEXFIND('TRA|TRL|TR'                        ,poffense)) or
	 (stringlib.stringfind(poffense ,'REST'    ,1) <> 0 and          REGEXFIND('ZN|ZO'                             ,poffense)) or
	 (REGEXFIND('OVER|EXCESS'                  ,poffense,0) <>'' and stringlib.stringfind(poffense ,'TIME'         ,1) <> 0  ) or
	 (REGEXFIND('REST|UDNS'                    ,poffense,0) <>'' and stringlib.stringfind(poffense ,'ARE'          ,1) <> 0  ) or
	 (stringlib.stringfind(poffense ,'ILLEGAL' ,1) <> 0 and          stringlib.stringfind(poffense ,'INTERSECTION' ,1) <> 0  ) or  
	 (stringlib.stringfind(poffense ,'AFTER'   ,1) <> 0 and          REGEXFIND('REMAIN|ENTER|TRESP|TEPASS|BEING|INSIDE| IN |OCCUPY|CURFEW|LOITER|WEAPON',poffense,0) = '') or
	 (stringlib.stringfind(poffense ,'CAR'     ,1) <> 0 and          REGEXFIND('CARRY|CARWASH|DAYCARE|DAYCARE'     ,poffense,0) = '') or
	 (stringlib.stringfind(poffense ,'PROP'    ,1) <> 0 and          REGEXFIND('TRESP|DAMAGE|DESTR|REMOV'          ,poffense,0) = '') or
                            
  (stringlib.stringfind(poffense ,' CIT'    ,1) <> 0 and          REGEXFIND('ALC|FIRE|WEAP|BEER|WINE|DRUNK|DRUG|DRINK|CONSUM|TRESP|DOG|HELMENT|BURG|ABC|LITTER|LEASH|SLEEP|CAMP|THEFT|GLASS|'+
			                                                                         'NOISE|LOITER|SOLICT|COC|DEPOSIT|ENTER|DAMAGE|DESTR|REMOV',poffense,0) = '') or
	 (stringlib.stringfind(poffense ,'EQUIP'   ,1) <> 0 and          REGEXFIND('DAMAGE|DESTR|REMOV|SKATE|SEX'      ,poffense,0) = '') or
	 (stringlib.stringfind(poffense ,'RESTRICT',1) <> 0 and          REGEXFIND('DOG|ANIMAL|CURFEW'                 ,poffense,0) = '') or                          
	 (stringlib.stringfind(poffense ,'FAC'     ,1) <> 0 and          REGEXFIND('DRUG|MANUFAC|CARE|COC|DEFAC|ARTIFAC|METER|POSS|TRESP|ALC|DRUNK|SELL',poffense,0) = '') or
	 (stringlib.stringfind(poffense ,'FEE'     ,1) <> 0 and          REGEXFIND('POSS|CDS|DRUG|SELL|SEX|DELIVE|SALE|CDS|DISTRIB',poffense,0) = '') or
	 (REGEXFIND('HAND|HNDCP'                   ,poffense,0) <>'' and REGEXFIND('WEAP|GUN|PAN|DEAL|F MERCHANDIS F MERCHAND|RECKLESS|FIREARM',poffense,0) = '') or							 
	 (stringlib.stringfind(poffense ,'LOAD'    ,1) <> 0 and          stringlib.stringfind(poffense ,'POSS'         ,1) = 0 ) or
	 (stringlib.stringfind(poffense ,'CUT'     ,1) <> 0 and          REGEXFIND('TREE|WOOD|DESTR'                   ,poffense,0) = '') or
	 (stringlib.stringfind(poffense ,'HR'      ,1) <> 0 and          REGEXFIND('TRESP|ALCO|REMAIN|SLEEP|COC|THROW' ,poffense,0) = '') 
	) => 'Y',

REGEXFIND('VIO'                                     ,poffense)   and
((REGEXFIND('MV|VEH|TRAF|DR |LANE|HOV',poffense,0) <>'' and REGEXFIND('LAW|REST|TIRE'     ,poffense)  ) or
	(REGEXFIND('CHILD|LEARN|LRN'         ,poffense,0) <>'' and REGEXFIND('REST'              ,poffense)  ) or						 
	(REGEXFIND('VEH|MV|BOAT|DR|VETS'     ,poffense,0) <>'' and REGEXFIND('LIC|REG|TAG|PLAT'  ,poffense)  ) or
	(REGEXFIND('LEARN|LRN|MARINE'        ,poffense,0) <>'' and REGEXFIND('LIC|PERM|PMT'      ,poffense)  ) or
	(REGEXFIND('LIC| DL |D[/]*L |D[\\.]L[\\.]| OL |O/L|O[\\.]L[\\.]|BOAT|VESSEL|MOOR',poffense,0) <>'' and REGEXFIND('PLAT|TAG|REG|REST|SUSP|WEIGHT',poffense)  ) or
	(REGEXFIND('VEH|M[/]*V'              ,poffense,0) <>'' and REGEXFIND('I[H]*NSP'          ,poffense)  ) or
	(REGEXFIND('LIC|D/L'                 ,poffense,0) <>'' and REGEXFIND('DR |FARM|DWLR|DWLS',poffense)  ) 
) => 'Y',

stringlib.stringfind(poffense ,'UNATT'             ,1) <> 0		and				 
REGEXFIND('VEH|MV|AUTO'                            ,poffense,0) <>  '' => 'Y',
						
stringlib.stringfind(poffense ,'VIO'               ,1) <> 0	 and							 
REGEXFIND('M[/]C|M CARR|MOT(.*) CAR|MTR(.*) CARR|TOW|BOOT|MOTOR[ ]*CYC' ,poffense,0) <>  '' and 
stringlib.stringfind(poffense ,'TOWN'              ,1) = 0								 => 'Y',
						 
stringlib.stringfind(poffense ,'WRONGFUL'          ,1) <> 0	  and							 						 
REGEXFIND('ENTRUS|ENTRST'                          ,poffense) => 'Y',
						 
REGEXFIND('LIGHT|LGT'                              ,poffense) and
REGEXFIND('FLIGHT|HUNT|THR[OE]W|ARTIFICIAL|HOUS|SKYLIGHT|PROPERTY MAIN|LIGHTED|SPOT[ ]*LIGHT|ORDINANCE|OUTDOOR|FIRE|SALE|KILL|DEER|WILDLIFE'  ,poffense,0) = ''  => 'Y',

REGEXFIND('OPER(.*) PERM'                          ,poffense) and 
REGEXFIND('TAXI|VEH|M[/]V| [C]*MV |MOPED|ATV|MOTOR[ ]*CYCLE|MOTOR CARRIER|BOAT|M[O)*T[O]*R V'   ,poffense)   => 'Y',
						 
stringlib.stringfind(poffense ,'MOTOR'             ,1) <> 0	  and	
stringlib.stringfind(poffense ,'CYCL'              ,1) <> 0	  => 'Y',						 
		 
stringlib.stringfind(poffense ,'DANGL'             ,1) <> 0	  and	
stringlib.stringfind(poffense ,'OBJ'               ,1) <> 0	  => 'Y',						 

REGEXFIND('VIO|NO |FAL|MIN'                        ,poffense) and
REGEXFIND('WAKE|MOOR'                              ,poffense) and
stringlib.stringfind(poffense ,'ZON'               ,1) <> 0	   => 'Y',	
						 
REGEXFIND('M[/]*V|VEH'                             ,poffense) and
stringlib.stringfind(poffense ,'REG'               ,1) <> 0	  and	
REGEXFIND('FAIL|FALSE|LIC|LC|PL|MC|MOT|NOT|NO |REQ|VIO|SUS|NEVER|LAW' ,poffense,0) <>  '' => 'Y',

stringlib.stringfind(poffense ,'UNLAW'             ,1) <> 0	  and	
REGEXFIND('TAG|STICK|DECAL|PLATE|TIRE'             ,poffense) and
~(stringlib.stringfind(poffense ,'ID'              ,1) <> 0   and REGEXFIND('CARD|DEER|GAM' ,poffense)  ) => 'Y',
						 
REGEXFIND('[0-9]+\\-[0-9]+ |[0-9]+[/][0-9]+|MPH'   ,poffense7) and
stringlib.stringfind(poffense7 ,'ZONE'             ,1) <> 0	   => 'Y',	

stringlib.stringfind(poffense ,'NO '               ,1) <> 0	  and	
REGEXFIND('PASS|TRUCK|SCHOOL'                      ,poffense) and
stringlib.stringfind(poffense ,'ZON'               ,1) <> 0	  => 'Y',

stringlib.stringfind(poffense ,'VEH'               ,1) <> 0	  and	
stringlib.stringfind(poffense ,'REST'              ,1) <> 0	  and							 
stringlib.stringfind(poffense ,'ZON'               ,1) <> 0	  => 'Y',

stringlib.stringfind(poffense ,'HEADLIGHT'         ,1) <> 0	  and	
stringlib.stringfind(poffense ,'BEAMS REQUIRE'     ,1) <> 0	  => 'Y',						 
						 //QA Update - Traffic Round 6
REGEXFIND(' F[\\.]?T[\\.]?Y[\\.]?[R /-]|INSURANCE CARD|[LIABILITY|AUTOMOBILE|VEHICLE] INSURANCE|' +
					'INSURANCE VERIFICATION|LEAV[E]?[ |/]SC[NE]*[\\.]?[ |/]*[OF ]*ACC|VEHICLES FOLLOWING|FOLLOWING TOO C|' +
					'TAIL LAMP[S]*|TAIL LITE[S]*|HEAD LAMP[S]* REQUIRE|OPERATE W/O REASONABLE CONTROL|' +
					'^[ ]*DISPLAY OF PLATES[\\.]*[ ]*$|MILES PER HOUR LIMIT|SQUEAL[ING]* TIRE'  ,poffense)   => 'Y',
						 //QA Update - Traffic Round 6
REGEXFIND('ALLOW[ING]*' 														 ,poffense) and
REGEXFIND('ILLEG|UNDER[ ]*AGE|UNLAWFUL'						   ,poffense) and
stringlib.stringfind(poffense ,'OPERATION'           ,1) <> 0	  => 'Y',		
						 
REGEXFIND('TRAVEL[ING]*'                             ,poffense) and
stringlib.stringfind(poffense ,'TO FAST'             ,1) <> 0	  and	
stringlib.stringfind(poffense ,'FOR CONDITION'       ,1) <> 0	  => 'Y',								 
						 
stringlib.stringfind(poffense ,'HOV'                 ,1) <> 0	  and	
REGEXFIND('SHOVE|SHOVI'                              ,poffense,0) =  '' => 'Y',
						 
REGEXFIND('^ FL |FAIL|FAILURE'                       ,poffense)   and //Roger comments - Traffic 20161114 File Round 8
stringlib.stringfind(poffense ,'CARRY'               ,1) <> 0	  and							 
REGEXFIND('[/\\. ]D[/]*L[/\\. ]|[/\\. ][OD]\\.L\\.|[/\\. ]O[/]*L[/\\. ]'          ,poffense)   => 'Y',
						 
stringlib.stringfind(poffense ,'VOIL'                ,1) <> 0	  and	
stringlib.stringfind(poffense ,'RULE '               ,1) <> 0	  and							 
REGEXFIND('BASIC|FAST|TURNPIKE| DPS '                ,poffense)   => 'Y',

REGEXFIND('LEAV|LV/SCENE'                            ,poffense)   and      
stringlib.stringfind(poffense ,'SCENE'               ,1) <> 0	  and	
stringlib.stringfind(poffense ,'PRIV PROP'           ,1) =  0	  => 'Y',							 

REGEXFIND('MAXIMUM|LIMIT|EXCEED'                                ,poffense)   and      
REGEXFIND('WEIGHT|AXLE|SIZE|EMISSION| MPH |LICENSE|LOAD|BACKING',poffense)   => 'Y',

stringlib.stringfind(poffense ,'INSUFF'              ,1) <> 0	  and	
stringlib.stringfind(poffense ,'TREAD'               ,1) <> 0	  and	
stringlib.stringfind(poffense ,'TIRE'                ,1) <> 0	  => 'Y',								 
						 
stringlib.stringfind(poffense ,'METER'               ,1) <> 0	  and	
REGEXFIND('VIOLATION|STREET'                         ,poffense)   => 'Y',

stringlib.stringfind(poffense ,'ROADBLOCK'          ,1) <> 0	  and	
REGEXFIND('AVOID|RUN|DIS POLICE'                    ,poffense)   => 'Y',

stringlib.stringfind(poffense ,'FIRE'               ,1) <> 0	  and	
stringlib.stringfind(poffense ,'HYDRAN'             ,1) <> 0	  and	
REGEXFIND('WITHIN|BLOCK| PK '                       ,poffense)   => 'Y',

REGEXFIND(traffic_list                              ,poffense)   and
REGEXFIND(exclude_list_traffic                      ,poffense,0) = ''  => 'Y',          
						 
REGEXFIND(traffic_list2                             ,poffense)    and
REGEXFIND(exclude_list_traffic                      ,poffense,0) = ''  => 'Y',	  
						 
REGEXFIND(traffic_list3                             ,poffense7,0) <> ''  and
REGEXFIND(exclude_list_traffic                      ,poffense7,0) = ''  => 'Y',
					 
REGEXFIND(traffic_list4                             ,poffense)    and
REGEXFIND(exclude_list_traffic                      ,poffense,0) = ''  => 'Y',
						 
REGEXFIND(traffic_list5                             ,poffense)    and
REGEXFIND(exclude_list_traffic                      ,poffense,0) = ''  => 'Y',
						 
REGEXFIND(traffic_list6                             ,poffense)   => 'Y',						 
REGEXFIND(traffic_list7                             ,poffense)   => 'Y',	
REGEXFIND(traffic_list8                             ,poffense)   => 'Y',	

REGEXFIND(LIC1                                      ,poffense)   and
REGEXFIND(exclude_list_traffic                      ,poffense,0) = ''  => 'Y',	 
						 
					/*	 REGEXFIND('^ [0-9][0-9].[0-9][05][ ]*$'           ,poffense)   => 'Y',
       REGEXFIND('^ [0-9][0-9][/][0-9][05] RD[ ]*$'        ,poffense)   => 'Y',
 						REGEXFIND('^ [0-9][0-9] IN [0-9][05][ ]*$'          ,poffense)   => 'Y',
						 REGEXFIND('^ [0-9][0-9][/][0-9][05] DR[V]*[ ]*$'    ,poffense)   => 'Y',
						 REGEXFIND('X[0-9][0-9][/][0-9][05][ ]*$'            ,poffense)   => 'Y',
						 REGEXFIND('^ [0-9]+[/][0-9][50] (2ND|MPH)[ ]'       ,poffense)   => 'Y',
						 REGEXFIND('^ [0-9]+[/][0-9][50] RECKLESS[ ]'        ,poffense)   => 'Y',						 
						 REGEXFIND('^ RD[ ]*[0-9]+[/][0-9][50][ ]'           ,poffense)   => 'Y',
						 REGEXFIND('^ [0-9][0-9][-][0-9][05][-]B[ ]*$'       ,poffense7,0) <> '' => 'Y',
						 REGEXFIND('SP [-] [0-9][0-9][/][0-9][05][ ]*$'      ,poffense7,0) <> '' => 'Y',
						 REGEXFIND('^ [0-9]+[/][0-9][50]-PT[ ]'              ,poffense7,0) <> '' => 'Y',			*/			 

REGEXFIND('^ [0-9][0-9].[0-9][05][ ]*$|^ [0-9][0-9][/][0-9][05] RD[ ]*$|^ [0-9][0-9] IN [0-9][05][ ]*$|^ [0-9][0-9][/][0-9][05] DR[V]*[ ]*$|X[0-9][0-9][/][0-9][05][ ]*$|^ [0-9]+[/][0-9][50] (2ND|MPH)[ ]|^ [0-9]+[/][0-9][50] RECKLESS[ ]|^ RD[ ]*[0-9]+[/][0-9][50][ ]',poffense)   => 'Y',
REGEXFIND('^ [0-9][0-9][-][0-9][05][-]B[ ]*$|SP [-] [0-9][0-9][/][0-9][05][ ]*$|^ [0-9]+[/][0-9][50]-PT[ ]*',poffense7)   => 'Y',
						 
stringlib.stringfind(poffense ,'LIGHTED'                   ,1) <> 0	  and	
(stringlib.stringfind(poffense ,'LIGHT',1) <> 0    or stringlib.stringfind(poffense ,'LAMPS',1) <> 0  
)=> 'Y',	

stringlib.stringfind(poffense ,'LEAVE ACC'                 ,1) <> 0	  and	
stringlib.stringfind(poffense ,'VEH'                       ,1) <> 0	  => 'Y',									 
						 
REGEXFIND('EVAD|EVASI|ELUD[E]*|EVAS |VIOL[ATION ]+'        ,poffense) AND
~REGEXFIND('TAX|TOLL|TAXES|ARREST|ZO[N]*ING'               ,poffense) => 'Y',
						
REGEXFIND('EVAD|EVASI|ELUD[E]*|EVAS |VIOL[ATION ]+'        ,poffense) AND
REGEXFIND('TR[A]*F[FIC ]+'                                 ,poffense) AND
stringlib.stringfind(poffense ,'DEVICE'                    ,1) <> 0	  => 'Y',	
					                                                      
stringlib.stringfind(poffense ,'LEARNER'                   ,1) <> 0	  and	
REGEXFIND('[/\\. ]DL[/\\. ]'                               ,poffense) AND
stringlib.stringfind(poffense ,'INVALID'                   ,1) <> 0	  => 'Y',
	                                                          
REGEXFIND('[/\\. ]ID[/\\. ]|[/\\. ]CDL[/\\. ]|[/\\. ]DL[/\\. ]|[/\\. ]O[/]*L[/\\. ]|INSURANCE|DRIVER LICENSE|DRIV LIC|[/\\. ]REG[ISTRAON]*[/\\. ]' ,poffense)   AND 
stringlib.stringfind(poffense ,'POSS'                      ,1) <> 0	  and	
REGEXFIND('[/\\. ]NO[/\\. ]|NOT'                           ,poffense)    => 'Y',
						  
REGEXFIND('DROP|SHIFT|LEAK|BLOW'                           ,poffense)   AND
stringlib.stringfind(poffense ,'LOAD'                      ,1) <> 0	  => 'Y',							 
						 
stringlib.stringfind(poffense ,'PASS'                   ,1) <> 0	  and							 
						 ((stringlib.stringfind(poffense ,'WITHIN'    ,1) <> 0  AND stringlib.stringfind(poffense ,'INTERSECTION'    ,1) <> 0 ) or 
						   stringlib.stringfind(poffense ,'EMERGENCY VEHICLE'    ,1) <> 0  or
							  stringlib.stringfind(poffense ,'UNSAFE'               ,1) <> 0  or
							  stringlib.stringfind(poffense ,'SUFFICIENT CLEARANCE' ,1) <> 0 
						 )
						  => 'Y',
						 
stringlib.stringfind(poffense ,'SPEED'                      ,1) <> 0	  and	
stringlib.stringfind(poffense ,'MAXIMUM'                    ,1) <> 0	  and	
stringlib.stringfind(poffense ,'LIMIT'                      ,1) <> 0	  => 'Y',				
						 
REGEXFIND('DRIV|DRIVING|DRIVE'                              ,poffense)   AND
REGEXFIND('UNDER|WHILE'                                     ,poffense)   AND
REGEXFIND('SUSPENSION|SUSPENDED|REVOC|REVOK'                ,poffense)    => 'Y',
						 
stringlib.stringfind(poffense ,'REAR'                       ,1) <> 0	  and	
stringlib.stringfind(poffense ,'LAMP'                       ,1) <> 0	  and
stringlib.stringfind(poffense ,'REQ'                        ,1) <> 0	  and	
stringlib.stringfind(poffense ,'VEH'                        ,1) <> 0	  => 'Y',				
						 						 
						 
REGEXFIND('RECK|RECKLESS'                                   ,poffense)   AND
stringlib.stringfind(poffense ,'OPER'                       ,1) <> 0	  and	
stringlib.stringfind(poffense ,'VEH'                        ,1) <> 0	  => 'Y',						 
						 
REGEXFIND('FAIL|FAILURE'                                    ,poffense)   AND
REGEXFIND('REG|REGISTRATION|TAG'                            ,poffense)   AND
REGEXFIND('CARRY|EXHIBIT|RENEW'                             ,poffense)    => 'Y',					
						 
stringlib.stringfind(poffense ,'HEADLAMP'                   ,1) <> 0	  and
stringlib.stringfind(poffense ,'EQUIP'                      ,1) <> 0	  and	
stringlib.stringfind(poffense ,'REQ'                        ,1) <> 0	  => 'Y',							 
						 
stringlib.stringfind(poffense ,'IMPROPER'                   ,1) <> 0	  and
(stringlib.stringfind(poffense ,'SUNSHADE',1) <> 0  OR
	(stringlib.stringfind(poffense ,'VEH'    ,1) <> 0  and REGEXFIND('HWY|HIGHWAY' ,poffense))
) => 'Y',	
						 
stringlib.stringfind(poffense ,'ILLEGAL'                    ,1) <> 0	  and	
stringlib.stringfind(poffense ,'XING'                       ,1) <> 0	  and
stringlib.stringfind(poffense ,'DOUBLE'                     ,1) <> 0	  and	
stringlib.stringfind(poffense ,'LINE'                       ,1) <> 0	  => 'Y',							 
						 
stringlib.stringfind(poffense ,'ATV'                        ,1) <> 0	  and	
stringlib.stringfind(poffense ,'OPER'                       ,1) <> 0	  and
(stringlib.stringfind(poffense ,'STREET',1) <> 0	 or stringlib.stringfind(poffense ,'PARK' ,1) <> 0	) => 'Y',		             

						 'N');
return Is_it;
end;
//--------------------------------------------------------------------------------------------------------------------------------------

export Is_Other(string poffense) := function

Other1 :='POOL|CONVEY|PERMIS|PARK|LITTER|ACCOMPLIC|COMPLIC|APPEAL|INTERFER|TRAFF|'+ 
         'ALTER|ADULTERA|^AM UN[ AU]+|AID(.*) OFFENDER|AID(.*) PRISONER|AID BY MISREP|'+
    		   'KNOWINGLY|ACCESSORY AFTER(.*) FACT|ACCESSORY BEFORE(.*) FACT|ARRAIGNMENT|ACT(.*)PROH|'+
         '^ALC[- ]|BAIL JUM[OPING]*|BIGAMY|ASSIST(.*) COMMIT|^ALS |^ALT |APPEAL(.*) J[ ]*P#|APPEAL(.*) J[ ]*P #|APPEAL(.*) CORP|'+	  		     
         'CIVIL ASSESSMENT|COERCION|CONS[UM]*P|CONSPIRACY|CAUSING(.*)POLLUT|CHALLENG[EING]*(.*)FIGHT|CERT[AIN]* ACT[S]* PRO|'+
         '^CF |^CM |CONSUMER|CUTTING|C[ ]*D[ ]*V|CONVERT|CONTEMPT|TAMPER|'+    
		     'COCK(.*)FIGHT|DISTRIBUTE|DISTURBING|DANGER|FACILITAT|DISARM|CONVERSION|CONSERVATION|ESCAPE|CONSPIR';	  

Other2:= 'DISRUPT[ING ]+PUB|DISRUPT[ING ]+MEET|DRAG RACING|DISMISS|HINDER|ELUDE|ESCAPE|ELDERLY|EXTRADITION|ENHANCEMENT|EXPOS|ELDER|'+			  
	        'FIRE|FAIL(.*) TO APPEAR|FUGITIVE|FORFEIT|FIGHTING(.*)PUBLIC|FLEE|FAIL(.*) TO PAY|'+	       		
		       '^FURN|FEDERAL|^FUG|GRAND|RABIES|FISHING LIC|DOG VACCINATION|HEALTH|HABITUAL OFFENDER|^HARB|HAZARD|HARM|HARBORING A RUNAWAY|'+		      		
	        'ILL USE MIN|ILLEGAL|IMPORTUNING|LAW ENFORCEMENT|MORE THAN|^MOS|MISUSE|MAL.|MALICIOUS|CONTEMPT';				 
          
Other3:= 'MAKING FALSE|MISCOND|NEGLECT|NON(.*)SUPPORT|PERJU|RESIST|OFFICER|OBSTR[UCTIONG]*|^OBS |'+	 
	        'VIOLATION(.*)COMMUNITY SUP|PROB VIOLATION|PAROLE|PANIC|PROBATION|WORK(.*)PR[OG]+|'+
	        'PRIOR [-]*CONV|POLOGAMY|PATIENT|PER(.*) UNL|PETITION RE:|POLLUT|'+
	    	   '^PERS[IST. ]+|PRIOR|^PRACTIC[IE]|^PREP[ARATION]* OF |PERS(.*) DI|QUARANTINE|'+
	     	  'RECK(.*) OP|RESIST|RECKLESS|RESISTING ARREST|TOXIC|THROW|TERMS OF PROB|VOY[EU]+RISM|VICIOUS|'+  
	        '^SPEC AL|SOLIC[I]*T|TAMPERING|TAX|HUNT|IRRIGATE|IRIRGATE|LAWN|HOME|HOOK|'+
	        'VIOLATION OF FED|VIT:|VIT-|SU[SP]*(.*) SENT|VIOLATION OF PROB| OBST|DEC(.*) OBT(.*) D[A]*N|'+
	        '^UCW|CURFEW|WILLFUL|JAIL|SHELLS|W[/ ]*SPEC[ ,]+|^SP[E]*C[- I]|SPEC[ -.//CIAL]+A[L]+EG|TEL MISUSE|TELEPHONE MISUSE';
				 
Other4:= 'TRASH|JUNK|ACCESRY|SERV|INTERF|CAPIAS|LOG|SBPP|TIME ZONE|TOBAC|C[O]*NT[EM]+PT|CONT OF CT|'+
				     'UNPAID|UNPD|ZONE|TRANSP|WALTON|WAOJ|W\\.C\\.|W[/]C|APPEAR|FISH|GAME|WILDLIFE|DEER|TURKEY|DOG|WILD|ANIMAL|WOLF|RACCOON|HUNT|CATTLE|'+
				     'MONKEY|COUGAR|CANINE|PITBULL|CANOE|CARIBOU|CAPAIS |CAPIA|CAPIAS| CAPIS |CDI[- /]|SLEEP| F[ ]*&[ ]*[BCG] |PEDDLING|TEMPER|DEBRIS|FMCSR|FMCSK|'+
				     'LOCAL|EXOTIC|FACILITAT|FACILAT|FACILIAT|FACILITIES|FACILITY|CORPSE|PAINT|PAINTING|ENDAN|EMDAN|ENDG|ENDNG|ENDAG| END |ENGAN|ENFAN|ENDN|ENDGR|EBDANG|'+
				     'EBDAMG|ENDNGR|ENDNAG|ENDENG|ENDAND|EDANG|ENANG|ENDDANG|FAIL|DOOR|DEAD|BATT|CUSTODY|DUMP|DUTY|ERROR|UPDATE|FOCUS|UNDERSIZE|EXTRA|REMOV|UNSWORN';			 

Other5:= ' CAT |843\\.02[\\. ]|843.15.1A|[-/\\. ]VASAP[-/;\\. ]|843\\.15\\.1B|PC 368[(][BC][)]|PC 136\\.1[(][BC][)]|901\\.04 |HS 11365 | PC 118 |42-8-38 |PC 182[(]A[)]| 1244B |'+
         'EC 48200|12\\.44B|VC 2800\\.1|BP 7028|12\\.44[ ]*[ (]+[AB][) ]|99-9997|HS 12677 |PC 4502[(][A][)]|VC 40508[(][A][)]|PC 166[\\.(]4[)]*|PC 166[(][A][)]|PC 1463\\.07|'+
				 'PC 1320[(][A][)]| PSP [123] | PC 69 | PC 272 | PC 32 |FG 7145[(][A][)]|EC 48262|PC 148[(][A][)]|PC 148 |PC 148\\.9|2924.14[(]C[)][(]1[)]|'+
				 'PC 853\\.7|PC 1551\\.1|VC 2800\\.[12]|PC 466 |PC 118[(]A[)]| PC 69 |PC 148\\.5| PC 32 |948\\.06|0144\\.350|901\\.36\\.1|901\\.31|941\\.02|'+
         '19-512.*1A | 941.02 | 948.06 | 987.8 | OXO 20-1[(]A[)]|19[-]512[(][MF][)]1A';


Other6:= '^CPF[/ ]|^CPFX|^CTMPT |^D\\.O\\.C\\.|^BW |^C/A ON |C/A FAIL |^FPFC |^FNSB |^FRAM[INGE]*[/ ]|^FRA |^FTC |^ICE |.BENCH WARRANT.|^F REPAIR[/ ]|^FOJ OTHER |^CON ';
Other7:= '^FTO COURT |^FTO CT[\\. ]|^TSO|^F[POR]+ PROSECUTION SEE[:/ ]|^F[POR]+ SENTENC|^FOUND [FG]UI[L]*TY|^FOUND [FG]UI[L]*TU|^FOUND INCOMPETANT|^FOUND INCOMPETENT|^FOUND NOT GUILTY';		 
Other8:= 'HUMAN|MUR[/]ACC|SOLIC[/]MUR|AS[S]*/MUR|INT/EMERG|INTER[/]W[/]EMERG|^B[/]W[-/( ]|WRNT | WRT |WSP WRT|[-/ ]FT[FPAY]+[-/ ]|OBEY|[(]BW[)]';

Other9:= 'PEDDL|ARREST|ARRST|LABEL|LABELING|REVOC|WRONG SEX|POSTPONEMENT|FUG WARR/OUT|^PTRP |^PPS VIOLATION SANCTION|' +
         'BUS W/O TRADERS LICENSE|CRIM CONTMP|FTP AFTER CVC CONVICTION|FUGITIVE FROM JUSTIC';

Is_it := MAP(
						 
						 //In_Global_Exclude(poffense,'other')='Y' => 'Y', //this stmt has to be before the other tests

             REGEXFIND('FAIL' ,poffense)   AND              
						 REGEXFIND('SPEED|LANE|SIGNAL' ,poffense)   => 'N',

             // Is_Arson(poffense)='Y' OR                        
						 // Is_Assault_aggr(poffense)='Y' OR                      
						 // Is_Assault_other(poffense)='Y' OR                      
						 // Is_Bribery(poffense)='Y' OR					
						 // Is_Burglary_BreakAndEnter_res(poffense)='Y' OR
						 // Is_Burglary_BreakAndEnter_comm(poffense)='Y' OR
						 // Is_Burglary_BreakAndEnter_veh(poffense)='Y' OR
						 // Is_Counterfeiting_Forgery(poffense)='Y' OR       
						 // Is_Destruction_Damage_Vandalism(poffense)='Y' OR 
						 // Is_Drug_Narcotic(poffense)='Y' OR                
						 // Is_Embezzlement(poffense)='Y' OR                 
						 // Is_Extortion_Blackmail(poffense)='Y' OR						
						 // Is_Fraud(poffense)='Y' OR                        
						 // Is_Gambling(poffense)='Y' OR                     
						 // Is_Homicide(poffense)='Y' OR                     
						 // Is_Kidnapping_Abduction(poffense)='Y' OR   
						 // Is_Theft(poffense)='Y' OR 						
						 // Is_Shoplifting(poffense)='Y' OR 	
						 // Is_Pornography(poffense)='Y' OR                  
						 // Is_Prostitution(poffense)='Y' OR                 
						 // Is_Robbery_res(poffense)='Y' OR                     
						 // Is_Robbery_comm(poffense)='Y' OR
						 // Is_SexOffensesForcible(poffense)='Y' OR          
						 // Is_SexOffensesNon_forcible(poffense)='Y' OR      
						 // Is_Stolen_Property_Offenses_Fence(poffense)='Y' OR						
						 // Is_Weapon_Law_Violations(poffense)='Y' OR        
						 // Is_Identity_Theft(poffense)='Y' OR               
						 // Is_Computer_Crimes(poffense)='Y' OR 
						 // Is_Terrorist_Threats(poffense)='Y' OR    	
						 // Is_Restraining_Order_Violations(poffense)='Y' OR 		 				
						 // Is_traffic(poffense)='Y' OR                      
						 // Is_BadChecks(poffense)='Y' OR     						
						 // Is_CurfewLoiteringVagrancyVio(poffense)='Y' OR 						
						 // Is_DisorderlyConduct(poffense)='Y' OR            
						 // Is_DrivingUndertheInfluence(poffense)='Y' OR     
						 // Is_Drunkenness(poffense)='Y' OR					
						 // Is_FamilyOffenses(poffense)='Y' OR     
						 // Is_LiquorLawViolations(poffense)='Y' OR          
						 // Is_TrespassofRealProperty(poffense)='Y' OR       
						 // Is_PeepingTom(poffense)='Y' OR  
						 // Is_Motor_Vehicle_Theft(poffense)='Y' OR 
						 // Is_HumanTrafficking(poffense)='Y' =>                'N',  
						   
						 
REGEXFIND('UNL[-/ ]'                    ,poffense)   AND              
stringlib.stringfind(poffense ,'CRIM'   ,1) <> 0	  and	
stringlib.stringfind(poffense ,'INSTRU' ,1) <> 0	  => 'Y',	
     
stringlib.stringfind(poffense ,'FORFEIT',1) <> 0	  and	
REGEXFIND('SPECIFI|BAIL|BOND'           ,poffense) => 'Y',

REGEXFIND('REPEAT|HABITUAL'	            ,poffense)   AND     
stringlib.stringfind(poffense ,'OFFEND' ,1) <> 0	  => 'Y',
						
stringlib.stringfind(poffense ,'ZON'    ,1) <> 0	  and	
REGEXFIND('VEH| M[/]*V |AUTO'           ,poffense) => 'Y',
						
stringlib.stringfind(poffense ,'LAW'    ,1) <> 0	  and	
stringlib.stringfind(poffense ,'COMMAN' ,1) <> 0	  and													 
stringlib.stringfind(poffense ,'DISREG' ,1) <> 0	  => 'Y',	
						 
stringlib.stringfind(poffense ,'SOR'    ,1) <> 0	  and	
stringlib.stringfind(poffense ,'RESTR'  ,1) <> 0	  => 'Y',	
						   
stringlib.stringfind(poffense ,'ADULT'  ,1) <> 0	  and	
stringlib.stringfind(poffense ,'ESTAB'  ,1) <> 0	  => 'Y',	
						 						
stringlib.stringfind(poffense ,'DO NOT' ,1) <> 0	   and	
REGEXFIND('REL|OCCUPY|USE'              ,poffense)  => 'Y',
						
stringlib.stringfind(poffense ,'FTN'     ,1) <> 0	  and	
stringlib.stringfind(poffense ,' DMV '   ,1) <> 0	  and													 
stringlib.stringfind(poffense ,'ADD'     ,1) <> 0	  => 'Y',	
						       
REGEXFIND('INT[/ ]'                      ,poffense) and             
REGEXFIND('EMER[/ ]'                     ,poffense) and  
stringlib.stringfind(poffense ,'CALL'    ,1) <> 0	  => 'Y',
						        
REGEXFIND('KILL|TAKE'                       ,poffense) and              
stringlib.stringfind(poffense ,'WRONG'      ,1) <> 0	  and	
stringlib.stringfind(poffense ,'SEX'        ,1) <> 0	  => 'Y',							 
      
stringlib.stringfind(poffense ,'UNLAW'      ,1) <> 0	  and							 
(stringlib.stringfind(poffense ,'COND'      ,1) <> 0 or stringlib.stringfind(poffense ,'REMAIN'  ,1) <> 0		 ) => 'Y',
						 
stringlib.stringfind(poffense ,'CARRY'      ,1) <> 0	  and	
stringlib.stringfind(poffense ,' INS'       ,1) <> 0	  => 'Y',	
            
REGEXFIND('^FTA |^FTA[ ]*\\$|^FTA[ ]*[/]'   ,poffense)    => 'Y',

REGEXFIND('FAIL|AILL'                       ,poffense) and              
stringlib.stringfind(poffense ,'OBEY'       ,1) <> 0	  and	
stringlib.stringfind(poffense ,'REASONA'    ,1) <> 0	  and							 
REGEXFIND('LAW|ORDE'                        ,poffense) => 'Y',
             
REGEXFIND('FAIL|F[/]T|^FL |^F[/]'           ,poffense)   AND              
stringlib.stringfind(poffense ,'CARRY'      ,1) <> 0	  and	
stringlib.stringfind(poffense ,'SAFE'       ,1) <> 0	  and							 
REGEXFIND('EQU[I]*P'                        ,poffense)   => 'Y',
             
REGEXFIND('DESTR|WITHHOLD|FABRI|TAMP|TAM|TMPR|DISPO|SUPPR|PREJUDIC',poffense)   AND              
stringlib.stringfind(poffense ,'EVIDENCE'   ,1) <> 0	  => 'Y',	
             
stringlib.stringfind(poffense ,'COURT'      ,1) <> 0	  and	
stringlib.stringfind(poffense ,'COST'       ,1) <> 0	  and									 
REGEXFIND('PAID| PD |REV'                   ,poffense)   => 'Y',
             
stringlib.stringfind(poffense ,'COURT'      ,1) <> 0	  and	
stringlib.stringfind(poffense ,'ORDER'      ,1) <> 0	  => 'Y',							 

stringlib.stringfind(poffense ,'COURTESY'   ,1) <> 0	  and	
stringlib.stringfind(poffense ,'HOLD'       ,1) <> 0	  => 'Y',							 

stringlib.stringfind(poffense ,'FAB'        ,1) <> 0	  and	
stringlib.stringfind(poffense ,'PHY'        ,1) <> 0	  and	
stringlib.stringfind(poffense ,'EVID'       ,1) <> 0	  => 'Y',							 
       			 
REGEXFIND('ROWOV |PROBAT HLD|POISON|[ACCESSORY]+ AFTER THE FACT|BE AN ACCESSORY|VIO\\(\\.[0-9]+|VIO\\([0-9]+|INTERRUPT[I ]|INTERR V9|'+
          'POLICE|FIRE|MEDICAL|AMBULANCE'                ,poffense)     => 'Y',

stringlib.stringfind(poffense ,'SUPPORT'    ,1) <> 0	and
REGEXFIND('FAIL |WITHHOLD|REFUSE|FLR|OBLIGAT|SPOUS|CHIL|PARENT|PAY|FTP|CHILD|MINOR|DESERT|PROVID' ,poffense,0) = '' and
~(stringlib.stringfind(poffense ,'CRIM'    ,1) <> 0  and stringlib.stringfind(poffense ,'NO'    ,1) <> 0  )
						   => 'Y',
             
stringlib.stringfind(poffense ,'CAMP'       ,1) <> 0	and	
stringlib.stringfind(poffense ,'CAMPBELL'   ,1)= 0	  => 'Y',							 
 
stringlib.stringfind(poffense ,'SIDEWALK'   ,1) <> 0	  and	
stringlib.stringfind(poffense ,'BICYCLE'    ,1) <> 0	  => 'Y',							 
						
stringlib.stringfind(poffense ,'MOLEST'     ,1) <> 0	  and	
REGEXFIND('WILDLIFE|BIRD|ALLIGATOR'         ,poffense) => 'Y',

stringlib.stringfind(poffense ,'SELL'       ,1) <> 0	  and	
stringlib.stringfind(poffense ,'RECEI'      ,1) <> 0	  and	
stringlib.stringfind(poffense ,'TRANS'      ,1) <> 0	  => 'Y',							 

stringlib.stringfind(poffense ,'FOOD'       ,1) <> 0	  and	
stringlib.stringfind(poffense ,'STAMP'      ,1) = 0	   and  
stringlib.stringfind(poffense ,'STMP'       ,1) = 0    => 'Y',							 
						   
REGEXFIND('FAIL|OBEY'                       ,poffense) AND              
REGEXFIND('RENABLE|RENBLE'                  ,poffense) AND
stringlib.stringfind(poffense ,'LAW'        ,1) <> 0 => 'Y',
       			 
stringlib.stringfind(poffense ,'FAIL'       ,1) <> 0	  and	
stringlib.stringfind(poffense ,'OBEY'       ,1) <> 0	  and							 
(stringlib.stringfind(poffense ,'MOVE'      ,1) <> 0   OR
	(stringlib.stringfind(poffense ,'LAW'      ,1) <> 0   AND stringlib.stringfind(poffense ,'ORDER' ,1) <> 0   )
)=> 'Y',
	                       
stringlib.stringfind(poffense ,'EXHAUST'    ,1) <> 0	  and	
REGEXFIND('BATH|VENT'                       ,poffense) => 'Y',

REGEXFIND('ILL|UNLAW|UNLW|UNLAF'            ,poffense) and              
stringlib.stringfind(poffense ,'ASSEMB'     ,1) <> 0    => 'Y',	
             
stringlib.stringfind(poffense ,'FAIL'       ,1) <> 0	  and	
stringlib.stringfind(poffense ,'VERIF'      ,1) <> 0	   and 
REGEXFIND('SEC|INS|ADDRE'                   ,poffense) => 'Y',
             
REGEXFIND('FAIL[URE]*'                      ,poffense)   AND              
stringlib.stringfind(poffense ,' TO '       ,1) <> 0	  and	
REGEXFIND(' ID |IDENT'                      ,poffense)   => 'Y',					 

stringlib.stringfind(poffense ,'ESCAP'      ,1) <> 0	  and	             
REGEXFIND('CORR|CUST |ARREST | PENAL| DOC |CONFIN| FEL ' ,poffense)   => 'Y',

stringlib.stringfind(poffense ,'UNLIC'      ,1) <> 0	  and
REGEXFIND('CONTR|BUSIN'                     ,poffense) => 'Y',

stringlib.stringfind(poffense ,'BUILD'      ,1) <> 0	  and	
stringlib.stringfind(poffense ,' CODE'      ,1) <> 0	  => 'Y',							 

stringlib.stringfind(poffense ,'BUILD'      ,1) <> 0	  and							 
REGEXFIND('CERT|PERMIT|PRMT|INSP|SECUR|VIO|ZONE|NEAR|WITHOUT|W[/]O|SETBACK'               ,poffense)   and 
stringlib.stringfind(poffense ,'INTENT'     ,1) = 0	  => 'Y',

stringlib.stringfind(poffense ,'EXIT'       ,1) <> 0	  and
REGEXFIND('HIGHWAY| HWY |FWY |PAY | FARE | HW | RWY | RDWAY '               ,poffense)   => 'Y',
                      
stringlib.stringfind(poffense ,'FAIL'       ,1) <> 0	  and
REGEXFIND('REPAIR|REPLAC|CORRECT'           ,poffense) => 'Y',

stringlib.stringfind(poffense ,'ERROR '     ,1) <> 0	  and	
stringlib.stringfind(poffense ,'SEE '       ,1) <> 0	  => 'Y',							 
										
stringlib.stringfind(poffense ,'PROHIBIT'     ,1) <> 0	  and	
(REGEXFIND('ALCO|INTOX|DRINK|LIQ|BEER|DRUNK|WINE|SEX|DRUG'  ,poffense,0) = '' or 
	(stringlib.stringfind(poffense ,'CONTR '     ,1) = 0	  and	stringlib.stringfind(poffense ,'SUBST ',1) = 0	)
		) 	=> 'Y',
						
REGEXFIND('CORRUPT|ABANDON'     ,poffense)   AND              
~REGEXFIND('CHILD|MINOR|JUVE|ORG',poffense) => 'Y',						

stringlib.stringfind(poffense ,'TELEPHONE'      ,1) <> 0	  and	
stringlib.stringfind(poffense ,'HAR'            ,1) <> 0	  => 'Y',							 
						 			 
stringlib.stringfind(poffense ,'NUISA'          ,1) <> 0	  and	
stringlib.stringfind(poffense ,'PUB'            ,1) = 0	  => 'Y',							 
						                           
REGEXFIND('DEST|DAMAG|DMG'                   ,poffense)   AND 
REGEXFIND('ACC|INVOL'                        ,poffense)    AND 
stringlib.stringfind(poffense ,'PROP'        ,1) <> 0	  and							 
stringlib.stringfind(poffense ,'INTENT'      ,1) = 0	  => 'Y',	                                       

stringlib.stringfind(poffense ,'BOOK'        ,1) <> 0	  and	
stringlib.stringfind(poffense ,'BOOKMAK'     ,1) = 0	  => 'Y',							 
                                       

stringlib.stringfind(poffense ,'MOTION'      ,1) <> 0	  and	
stringlib.stringfind(poffense ,'PROMOTION'   ,1) = 0	  => 'Y',							 
						 
REGEXFIND('FALSE|FAL'                           ,poffense)   AND              
REGEXFIND('REPORT|RPT|REPT|ALARM|CALL|INFO|INF' ,poffense)   AND  
REGEXFIND('ARSON|EMERG|LAW|FIRE|POL|RESC|911|9-1-1|AMBUL|SAFE|ARSON' ,poffense)   => 'Y',
     
REGEXFIND('FALSE|FAL'      ,poffense)   AND              
REGEXFIND('REPORT|RPT|REPT',poffense)   AND  

stringlib.stringfind(poffense ,'CRIM'       ,1) <> 0	  => 'Y',							 

stringlib.stringfind(poffense ,'BOOK'      ,1) <> 0	  and	
stringlib.stringfind(poffense ,'LOG'       ,1) <> 0	  => 'Y',							 
            

stringlib.stringfind(poffense ,'PROP'      ,1) <> 0	  and	
stringlib.stringfind(poffense ,'MAINT'      ,1) <> 0	  and	
stringlib.stringfind(poffense ,'CODE'       ,1) <> 0	  => 'Y',							 
                                  
REGEXFIND('ADMIN|TRANS'    ,poffense)   AND              
stringlib.stringfind(poffense ,'ORD'      ,1) <> 0	  and	
stringlib.stringfind(poffense ,'ADMINISTER'       ,1) <> 0	  => 'Y',						 
            
            
stringlib.stringfind(poffense ,'OUT'      ,1) <> 0	  and	
REGEXFIND('CO|COUNTY|CITY' ,poffense)   AND  
REGEXFIND('WARR|WRRT|HIT'  ,poffense)   => 'Y',

stringlib.stringfind(poffense ,'WRIT'      ,1) <> 0	  and	
stringlib.stringfind(poffense ,'BOD'       ,1) <> 0	  and	
stringlib.stringfind(poffense ,'ATTACH'    ,1) <> 0	  => 'Y',						 

stringlib.stringfind(poffense ,'WRIT'      ,1) <> 0	  and	
stringlib.stringfind(poffense ,'OF'       ,1) <> 0	  and							 
REGEXFIND('ARREST|ARRST'   ,poffense)   => 'Y',						
						 
stringlib.stringfind(poffense ,'DOG'      ,1) <> 0	  and							 
REGEXFIND('TAG|VAC|REG|RAB' ,poffense)   => 'Y',						 

stringlib.stringfind(poffense ,'ALTER'      ,1) <> 0	  and	 
REGEXFIND('SALTER|WALTER|ALTERNATIVE' ,poffense)   => 'Y',
            
stringlib.stringfind(poffense ,'ACC'      ,1) <> 0	  and	 			 
REGEXFIND('A[/]F|A[/]FAC'   ,poffense)   => 'Y',
            
stringlib.stringfind(poffense ,'SHOOT'      ,1) <> 0	  and	
REGEXFIND('ANIMAL|DOG|DEER|BIRD|OWL|GEESE|WATERFOWL|SPECIES|PHEASANT|DUCK|MOOSE|WILDLIFE|HORSE|CRAP|GAME' ,poffense)   => 'Y',
          
stringlib.stringfind(poffense ,'RESTRAIN'      ,1) <> 0	  and	
REGEXFIND('CONFIN|CRIM|UNL|IMPRIS|FELON|ABUSE|CHILD' ,poffense,0) = '' => 'Y',
             
stringlib.stringfind(poffense ,'CRUEL'      ,1) <> 0	  and	
REGEXFIND('FOWL|GAME|DOG|PETS|LIVESTOCK|GOOSE|HORSE|CAT|KITTEN|A[ANI]+[MA]+L|ANIM|A[NM]I[MN][AL]+|PONY|CHOW|TORTIS|ROTT[I]*|GOAT|PUP|'+
          'HOUND|SHEP|BIRDS|ROMULUS|LAB|K-9|PIT[ ]*BULL|TAB|PIG|LLAMA|DUCK|FERRET|PARROT|CHIHUAHUA|L[I]*VST[OC]*K|RO[T]+WEI|CANINE' ,poffense)   => 'Y',

stringlib.stringfind(poffense ,'FALSE'      ,1) <> 0	  and	
stringlib.stringfind(poffense ,'DECL'       ,1) <> 0	  and				 
REGEXFIND('OWN|OWENRSHIP|OWERSHIP|PAW[MN]' ,poffense,0) = '' => 'Y',
            
stringlib.stringfind(poffense ,'UNL'       ,1) <> 0	  and	
stringlib.stringfind(poffense ,'USE'       ,1) <> 0	  and	
stringlib.stringfind(poffense ,'COMMUN'    ,1) <> 0	  => 'Y',								 

stringlib.stringfind(poffense ,'FALSE'     ,1) <> 0	  and				 
REGEXFIND('REPORT|PRTENSE|SWEAR|TESTIMO'   ,poffense)   => 'Y',
						 

stringlib.stringfind(poffense ,'FALSE'     ,1) <> 0	  and	
stringlib.stringfind(poffense ,'USE'       ,1) <> 0	  and							 
~REGEXFIND('CREDIT|CRD|CRED'               ,poffense) => 'Y',
						
stringlib.stringfind(poffense ,'FALSE'      ,1) <> 0	  and	
stringlib.stringfind(poffense ,'UTTER'       ,1) <> 0	  and								 
REGEXFIND('FRAUD|BANK|CHECK|PRESC|FORGE|CREDIT|DEBIT|CURRENCY|BILL|NOTE|INSTRU|DOC[UMENT ]+|INSTUMENT|FINANCIAL' ,poffense,0) = '' => 'Y',
						 					 
stringlib.stringfind(poffense ,'VIOL'      ,1) <> 0	  and	
stringlib.stringfind(poffense ,'ORDER'     ,1) <> 0	  => 'Y',								 
           
stringlib.stringfind(poffense ,'VIO'       ,1) <> 0	  and	
REGEXFIND('PAR|TITL|QUARA|RECORD|QUARE|QUARI|MEDICAL|LOP[ -]|OFFER|ORD' ,poffense)   => 'Y',
						             
stringlib.stringfind(poffense ,'BURN'      ,1) <> 0	  and	
REGEXFIND('ARSON|MAL|WI[L]+FUL|FRAUD' ,poffense,0) = '' => 'Y',	
						                       
stringlib.stringfind(poffense ,'LIGHT'     ,1) <> 0	  and	
REGEXFIND('HEAD|HUNT|HUN|SHINE|OBSERVE|TAK|KILL|JACK|SPOT|CAST|ARTIFIC|IMPROP|INSF|INSUF|CAST|AREA|ON|PLACE|VIO|ILL' ,poffense)   and 
REGEXFIND('DEER|WILDLIF|FISH|GAME' ,poffense)   => 'Y',
						
REGEXFIND('JUV|CHILD|MINOR' ,poffense)   AND              
REGEXFIND('SMOK|MAR'        ,poffense)   AND 
stringlib.stringfind(poffense ,'SCHOOL'    ,1) <> 0	  => 'Y',						
          
stringlib.stringfind(poffense ,'PROP'      ,1) <> 0	  and	
REGEXFIND('DEST|DAMAG|DMG'  ,poffense)   AND
REGEXFIND('ACC|INVOL'       ,poffense)   AND
REGEXFIND('INTENT'          ,poffense)   => 'Y',
             
stringlib.stringfind(poffense ,'ORD'      ,1) <> 0	  and	
REGEXFIND('MUNI|CITY'                     ,poffense)   => 'Y',						
            
stringlib.stringfind(poffense,'BEACH'      ,1) <> 0	  and	
REGEXFIND('HOUR|HR'                        ,poffense)   => 'Y',
            
stringlib.stringfind(poffense ,'GANG'      ,1) <> 0	  and	
REGEXFIND('CRIM|PARTIC|STREET|MEMBER|ACTIVITY|RECRUIT|DIRECT'       ,poffense)   => 'Y',
            
stringlib.stringfind(poffense ,'VIO'        ,1) <> 0	  and	
stringlib.stringfind(poffense ,'DEAL'       ,1) <> 0	  and							 
REGEXFIND('VEH|MV|AUTO'                     ,poffense)   => 'Y',

stringlib.stringfind(poffense ,'HARR'       ,1) <> 0	  and	
stringlib.stringfind(poffense ,'PUB'       ,1) <> 0	  and	
stringlib.stringfind(poffense ,'SERV'    ,1) <> 0	  => 'Y',							 

stringlib.stringfind(poffense ,'SERV'       ,1) <> 0	  and	
stringlib.stringfind(poffense ,'WEEKEND'    ,1) <> 0	  => 'Y',							 
						 
REGEXFIND('POLI|LEO'        ,poffense)   AND              
REGEXFIND('RADIO|SCAN|COMM|OBST|OBEY',poffense)   => 'Y',
     
stringlib.stringfind(poffense ,'HOSE'       ,1) <> 0	  and	
stringlib.stringfind(poffense ,'BIBB'       ,1) <> 0	  => 'Y',	
            
stringlib.stringfind(poffense ,'LIVESTOCK'  ,1) <> 0	  and	
stringlib.stringfind(poffense ,'HORSE'      ,1) <> 0	  => 'Y',							 
            
stringlib.stringfind(poffense ,'MUZZLE'     ,1) <> 0	  and	
stringlib.stringfind(poffense ,'LOAD'       ,1) <> 0	  => 'Y',	
            
stringlib.stringfind(poffense ,'POINT'       ,1) <> 0	  and	
stringlib.stringfind(poffense ,'SALE'        ,1) <> 0	  and	
stringlib.stringfind(poffense ,'VIO'         ,1) <> 0	  => 'Y',						 

REGEXFIND('Point|POINT'                    ,poffense)   AND              
stringlib.stringfind(poffense ,'SYSTEM'    ,1) <> 0	  => 'Y',	
            
stringlib.stringfind(poffense ,'CIG'       ,1) <> 0	  and	
~REGEXFIND('MARIJ|DRUG|CDS'                ,poffense) => 'Y',
            
REGEXFIND('MV|VEH'                         ,poffense)   and             
stringlib.stringfind(poffense ,'VIO'       ,1) <> 0	  and	
stringlib.stringfind(poffense ,'LAW'       ,1) <> 0	  and							 
stringlib.stringfind(poffense ,'TRAF'      ,1) = 0	  => 'Y',						 
						 
stringlib.stringfind(poffense ,'SHOW'      ,1) <> 0	  and	
REGEXFIND('CAUSE|NO|FAIL'                  ,poffense) => 'Y',
            
stringlib.stringfind(poffense ,'DESTRUC'   ,1) <> 0	  and	
~REGEXFIND('PROP|DEVICE'                   ,poffense) => 'Y',
            
stringlib.stringfind(poffense ,'ACCESSORY'      ,1) <> 0	  and	
(REGEXFIND('STR|USE|ZON|BATH|SHOWER|EQUIP|PARTS|BUILD|QUART|COMMON|BLD|MACHINE|AREA|REPAIR' ,poffense,0) = '' AND
	(stringlib.stringfind(poffense ,'PART'      ,1) = 0 AND stringlib.stringfind(poffense ,'LIST' ,1) = 0)
)=> 'Y',

REGEXFIND(Other1 ,poffense)   => 'Y',	        
REGEXFIND(Other3 ,poffense)   => 'Y',	 
REGEXFIND(Other4 ,poffense)   => 'Y',
REGEXFIND(Other5 ,poffense+' ') => 'Y',	 
REGEXFIND(Other6 ,poffense)   => 'Y',
REGEXFIND(Other7 ,poffense)   => 'Y', 
REGEXFIND(Other8 ,poffense)   => 'Y',
REGEXFIND(Other9 ,poffense)   => 'Y',
//Roger's comments - QA Update - Traffic   Round 4 9/23/16 and 9/27/16
REGEXFIND('BUSIN[ESS]*|VENDOR'                       ,poffense)   and
REGEXFIND('LICENSE|LIC |LIC[\\.]?$|LICENS$|PERMIT'	 ,poffense)   and
REGEXFIND('NO[T]? |EXPIRED|FAIL[ |E|U|/]|SUSPEND|NO |REQ[U| ]|WITHOUT|W/O',poffense)    => 'Y',

						 //Roger's comments - QA Update - Other Offenses Round 6
REGEXFIND('S[\\.]*[/]*C[\\.][ ]*[\\-]*[ ]*BONDSMAN|SC\\-BOND|CASH BOND|NO BOND|BAIL BOND|BOND POSTED|BOND JUMP|BOND REDUCED|' + 
          'FIRE[ ]*WORK|PREVENT[IONG]*|HAZARD|HINDER',poffense)  		=> 'Y',
												
stringlib.stringfind(poffense ,'SCHOOL'      ,1) <> 0	  and							 
REGEXFIND('SMO[I]?K[E|I]|GD\\.| ARM|SIMULAT|M/S/D/P CS|CONT SUB|ALCOHOL|DISTURB|' +
						           'S/C CK TRAF|N[A]*RCTCS|LAW VIOL|DISRUPTING|UNLAWFUL ACT'	 ,poffense)   => 'Y',
												
REGEXFIND('BUSINESS PURPOSE|MASSAGE'						     ,poffense)   and
REGEXFIND('VIOL|ILLEGAL|UNLAWF|WITHOUT [A ]*LIC|W[/]*O [A ]*LIC|W/O|PERMIT|IMPROPER|OPERATE AGAINST|' +
          'GENITALS|EROGENOUS|UNLICENSED|EXIT LOCK'	 ,poffense)   								=> 'Y',

stringlib.stringfind(poffense ,'MINOR'      ,1) <> 0	  and	
stringlib.stringfind(poffense ,' OF '      ,1) <> 0	  and							 
REGEXFIND('CORRUTION|CORPUTION|CORRUPTION'	   ,poffense)   => 'Y',
							
stringlib.stringfind(poffense ,'INSUFF'            ,1) <> 0	  and	
stringlib.stringfind(poffense ,'FLOATATION'        ,1) <> 0	  and	
stringlib.stringfind(poffense ,'DEVICE'            ,1) <> 0	  => 'Y',						 
							
stringlib.stringfind(poffense ,'CALL'              ,1) <> 0	  and	
stringlib.stringfind(poffense ,'NO EMERGENCY'      ,1) <> 0	  and	
						 
// REGEXFIND('POLICE|FIRE|MEDICAL|AMBULANCE'             ,poffense)   								=> 'Y',
						 
stringlib.stringfind(poffense ,'BUILDING'            ,1) <> 0	  and	
stringlib.stringfind(poffense ,'VIOL'        ,1) <> 0	  and							 
REGEXFIND('CODE|OCCUPANCY STDS|OCCUPANCY STAND[ARDS]*',poffense)   								=> 'Y',
								 
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
	          //In_Global_Exclude(poffense,'other')='Y' => 'N',
	
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
	             REGEXFIND(Non_offense1 ,poffense)   => 'Y',	               
							 REGEXFIND(Non_offense2 ,poffense)   => 'Y',	
							 REGEXFIND(Non_offense3 ,poffense)   => 'Y',
							 REGEXFIND(Non_offense4 ,poffense)   => 'Y',
							 REGEXFIND(Non_offense4a,poffense)   => 'Y',
							 REGEXFIND(Non_offense5 ,poffense)   => 'Y',
							 REGEXFIND(Non_offense6 ,poffense)   => 'Y',
							 REGEXFIND(Non_offense6a,poffense)   => 'Y',
							 REGEXFIND(Non_offense7 ,poffense)   => 'Y',
							 REGEXFIND(Non_offense8 ,poffense)   => 'Y',
							 REGEXFIND(Non_offense9 ,poffense)   => 'Y',
							 REGEXFIND(Non_offense10,poffense)   => 'Y',
							 REGEXFIND(Non_offense11,poffense)   => 'Y',
							 REGEXFIND(Non_offense12,poffense)   => 'Y',
							 length(rem_numAndOth) <4 and length(rem_numAndOth) >0  => 'Y',
							 'N');
return Is_it;
end;

//--------------------------------------------------------------------------------------------------------------------------------------

//Modified to remove other and traffic. they will be invoked independently. 
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
//bit_traffic                        := IF(Is_traffic(poffense)='Y',                            bit_Restraining_Order_Violations |   hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_traffic)                       ,bit_Restraining_Order_Violations);
bit_BadChecks                      := IF(Is_BadChecks(poffense)='Y',                          bit_Restraining_Order_Violations |   hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_BadChecks)                     ,bit_Restraining_Order_Violations);
bit_CurfewLoiteringVagrancyVio     := IF(Is_CurfewLoiteringVagrancyVio(poffense)='Y',         bit_BadChecks |                      hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_CurfewLoiteringVagrancyVio)    ,bit_BadChecks);
bit_DisorderlyConduct              := IF(Is_DisorderlyConduct(poffense)='Y',                  bit_CurfewLoiteringVagrancyVio |     hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_DisorderlyConduct)             ,bit_CurfewLoiteringVagrancyVio);
bit_DrivingUndertheInfluence       := IF(Is_DrivingUndertheInfluence(poffense)='Y',           bit_DisorderlyConduct |              hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_DrivingUndertheInfluence)      ,bit_DisorderlyConduct); 
bit_Drunkenness                    := IF(Is_Drunkenness(poffense)='Y',                        bit_DrivingUndertheInfluence |       hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_Drunkenness)                   ,bit_DrivingUndertheInfluence);
bit_FamilyOffenses                 := IF(Is_FamilyOffenses(poffense)='Y',                     bit_Drunkenness |                    hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_FamilyOffenses)                ,bit_Drunkenness);  
bit_LiquorLawViolations            := IF(Is_LiquorLawViolations(poffense)='Y',                bit_FamilyOffenses |                 hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_LiquorLawViolations)           ,bit_FamilyOffenses); 
bit_TrespassofRealProperty         := IF(Is_TrespassofRealProperty(poffense)='Y',             bit_LiquorLawViolations |            hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_TrespassofRealProperty)        ,bit_LiquorLawViolations); 
bit_PeepingTom                     := IF(Is_PeepingTom(poffense)='Y',                         bit_TrespassofRealProperty|          hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_PeepingTom)                    ,bit_TrespassofRealProperty);
bit_HumanTrafficking               := IF(Is_HumanTrafficking(poffense)='Y',                   bit_PeepingTom|                      hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_Human_Trafficking)             ,bit_PeepingTom);
//bit_Other                          := IF(Is_Other(poffense)='Y',                              bit_HumanTrafficking|                hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_Other)                         ,bit_HumanTrafficking);
bit_Unclassified                   := IF(Is_Unclassified(poffense)='Y',                       bit_HumanTrafficking|                hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_Unclassified)                  ,bit_HumanTrafficking);
return bit_Unclassified;                                                                                                                                                                                                                                       
end;
/*
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
*/
export set_offense_category_traffic(string poffense) := function
bit_traffic      := IF(Is_traffic(poffense)='Y', hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_traffic) ,0);
return bit_traffic;                                                                                                                                                                                                                                       
end;
export set_offense_category_other(string poffense) := function
bit_other      := IF(Is_other(poffense)='Y', hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_Other) ,0);
return bit_other;  
end;
export set_offense_category_Global(string poffense) := function
bit_Global      := IF(In_Global_Exclude(poffense,'other')='Y', hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_Other) ,0);
return bit_Global;  
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

