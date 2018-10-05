/*2015-01-30T16:17:48Z (vchikte)
C:\Users\ChikteVP\AppData\Roaming\HPCC Systems\eclide\vchikte\DATALAND_EOSS_Proxy\hygenics_crim\_functions\2015-01-30T16_17_48Z.ecl
*/
import ut,STD,_validate;
             
                                                                                                                                        


export _functions := module
export StreetAddressToFilter := ['0 05181992','0 BONITA SPRINGS','0 GIVEN','0 IMMOKALEE','0 NAPLES','0 NOIT GIVEN','0 NOT GIVEN 15','0 NOT GIVEN 9204',
                                 '0 NOT GIVENNE','0 NOT GIVENQ','0 NOT GIVEV','0 NOT GIVNE','0 NOT LISTED AV','0 NOTGIVEN','50 NOT GIVEN','O NOT GIVEN',
                                 '0 NOT GIVEN','1 NO ADDRESS','0 IN HOUSE JAIL','0 NOTGIVEN','1 NO ADDDRESS','1 NO ADDESSS',
                                 'HOMELESS','HOMELESSS','CURRENTLY HOMELESS','HOMELESS MOBILE, AL','HOMELESS CURRENT','HOMELESS CURRENT ADDRESS',
                                 '0 NOT ILSTED','0 NOT ISTED','0 NOT L ISTED','0 NOT LISED','0 NOT LIST','0 NOT LISTE',
		                             '0 NOT LISTED','0 HOMELESS','0 UNKNOWN ','HOMELESS','9999 HOMELES','AT LARGE-HOMELESS','(HOMELESS)','AT LARGE', 
																 '? UNKNOWN	','ADD UNKNOWN','ADDRES S UNKNOWN','ADDRESS UNKNOW N','ADDRESS UNKNOWN','ADDRESS UNKNOWN, # EAST L','N/A NONE',
		                             'N/A UNKNOWN N/A','NA UNKNWON','NCHOR MOTEL #3','NEW ADDRESS UNKNOWN, # TE','0 NO GIVEN',
																 'NEW UNKNOWN ADDRESS','NO ADDRESS','NO ADDRESS, # 27','NO ADDRESS, # DEF STATED',
		                             'NO ADDRESS FOUND','NO ADDRESS GIVEN','NO ADDRESS GIVING SANTA','NO ADDRESS - JUST RELEASE',
																 'NO ADDRESS LISTED','NO ADDRESS LISTED ON R A','NO ADDRESS ON',';NONE','NONE','NONE,','NONE, # 1','NONE, # 201','NONE, # 212',
		                             'NONE, # 406','NONE, # A','NONE, # APT 6','NONE /ANYWHERE','NONE ANYWHERE','NONE APT',
																 'NONE AT PRESENT','NONE AT THIS TI ME','NONE AT THIS TIME, # 13','NONE CLAIMS HOMELESS','NONE DID NOT KNOW','NONE ENTERED',
		                             'NONE GIVEN','NONE GIVEN TO O FFICER',';NONE HOMELESS','NONE - HOMELESS','NONE / HOMELESS','NONE HOMELESS',
																 'NONE LISTED','NONE LISTED NONE','NONE NEW','NONE NONE','NONE NONE AT THIS TI ME','NONE NONE GIVEN',
		                             'NONE NOWHERE','NONE PER DEF','NONE PROVIDED','NONE STATED','NONE UNKNOWN','NONE/AT','NOT LISTED','NUMBER AND ST UNKNOWN','UNKNOWN',
																 'OO UNKNOWN','OOO NONE','OOO UNKNOWN','OOOO NONE','OOOO UNKNOWN','OOOOOO UNKNOWN','UN UNKNOWN','UNK NONE','UNK NONE AT THIS TI ME',
		                             'UNK NONE GIVEN','UNK UNKNOWN','UNK UNKNOWN UNK','UNKN','UNKN #2208','UNKN ANYWHERE','UNKN UKNOWNN','UNKN UNKNOWN','UNKNIOWN ADDRESS',
																 'UNKNNOWN','UNKNO UNKNOWN','UNKNO WN','UNKNOE W UNK','UNKNON','UNKNON W','UNKNONW','UNKNONW,','UNKNONWN','UNKNOW','UNKNOW HARBOR','UNKNOW ADDRESS',
		                             'UNKNOW N','UNKNOW N `','UNKNOW UNKNOWN','UNKNOWEN','UNKNOWM',';UNKNOWN',';UNKNOWN, # #406',';UNKNOWN, # (HOUSE)',';UNKNOWN, # 210',
																 ';UNKNOWN, # 242',';UNKNOWN, # 25',';UNKNOWN, # APT 150',';UNKNOWN, # APT L','UNKNOWN','UNKNOWN # 1ST AVE','UNKNOWN # ELGIN',
		                             'UNKNOWN # GOLDENR','UNKNOWN # LOWE ST','UNKNOWN # NILES ST','UNKNOWN #/ADDRESS, **HOME','UNKNOWN - TRAILER IN OCOE',
																 'UNKNOWN / APT 14','UNKNOWN APT A-9','UNKNOWN APTS ON SR 46','UNKNOWN DR','UNKNOWN RD','UNKNOWN ST','UNKNOWN STREET','UNKNOWN `',
		                             'UNKNOWN# ON KAS SERINE PA','UNKNOWN# REA WAN','UNKNOWN,','UNKNOWN, # # 272','UNKNOWN, # # D','UNKNOWN, # #44','UNKNOWN, # (HOUSE)',
																 'UNKNOWN, # (WENTWORTH)','UNKNOWN, # 115','UNKNOWN, # 140','UNKNOWN, # 1523','UNKNOWN, # 2-306','UNKNOWN, # 212 (RED CARPE',
		                             'UNKNOWN, # 225','UNKNOWN, # 227','UNKNOWN, # 303D','UNKNOWN, # 308','UNKNOWN, # 3111','UNKNOWN, # 314','UNKNOWN, # 409 (RED CARPE',
																 'UNKNOWN, # 44','UNKNOWN, # 5','UNKNOWN, # 54','UNKNOWN, # 61','UNKNOWN, # 8','UNKNOWN, # 852D','UNKNOWN, # 9','UNKNOWN, # 9218',
		                             'UNKNOWN, # 9567 RED CLOVE','UNKNOWN, # A','UNKNOWN, # APT #265','UNKNOWN, # APT 11501','UNKNOWN, # APT 1628','UNKNOWN, # APT 201',
																 'UNKNOWN, # APT 352','UNKNOWN, # APT A','UNKNOWN, # APT K16','UNKNOWN, # APT R103','UNKNOWN, # B','UNKNOWN, # D','UNKNOWN, # H-7',
		                             'UNKNOWN, # N/A','UNKNOWN, # ROADWAY INN','UNKNOWN **HOMELESS**','UNKNOWN ADDR','UNKNOWN ADDRESS','UNKNOWN ADDRESS, # APT 33',
																 'UNKNOWN (HOMELE SS)','UNKNOWN HOMELES S','UNKNOWN (HOMELESS)','UNKNOWN HOMELESS','UNKNOWN, UNKANOW','UNKNOWN, UNKNOIWN',
		                             'UNKNOWN UNKNOWN','UNKNOWN, UNKOWN','UNKNOWNED','UNKNOWNS','UNKNWN','UNKNWON','UNKNWON ST','UNKNWOWN','UNKOWN UNKNOWN',
																 '0 H0MELESS','0 NONE','0 NOT ILSTED','0 NOT LIST','0 NOT LISTE','0 NOT LISTED','0 NOT LISTED ST','0 NOT LISTED01901',
		                             '0 NOT LISTEDE','0 NOT LISTERD','0 NOT LISTESD','0 NOT LISTEX','0 UNKN','0 UNKN# ANGLE SIDE DRIVE','0 UNKN# HWY 74 WEST',
																 '0 UNKN#/ADDRESS','0 UNKN#/ADDRESS (AL STATE','0 UNKN#/ADDRESS (HOMELESS','0 UNKN#/ADDRESS (STATE TH','0 UNKNONW',
		                             '0 UNKNONWN','0 (UNKNOWN)','0 UNKNOWN','0 UNKNOWN ST','0 UNKNWON','00 NONE','00 UNKNOWN','00 UNKNOWN ST','00 UNKNOWN BY DEF',
																 '000 NONE','000 UNKNOW','000 UNKNOWN','0000 NO ADDRESS','0000 ADDRESS UNKNOWN','0000 BLK NONE','0000 BLK UNKNOWN','0000 BLK UNKNOWN STR',
		                             '0000 BLK UNKNOWN STREET S','0000 CLAIMS NONE','0000 NONE','0000 NONE GIVEN','0000 NONE KNOWN','0000 NONE STATED','0000 UNKN',
																 '0000 UNKN APTS','0000 UNKNOWN','0000 UNKNOWN ST','0000 UNKNOWN / LOCAL AREA','0000 UNKNOWN ON STRE ETS','0000 UNKNOWN SO HE C LAIM',
		                             '0000 UNKNOWN (SO HE STATE','0000 UNKNOWNM','0000 UNKNWON','00000 NONE','00000 UNKNONW','00000 UNKNOWN','00000 UNKNOWN # BECKE R 4',
																 '00000 UNKNOWN ADDRESS','00000 UNKNOWN (ANYWHE RE)','000000 NONE','000000 UNKNONW','000000 UNKNOWN','000000 UNKNOWN,','000000 UNKNOWNW',
                                 '000000 UNKNWON','\\ UNKNOWN','NO PERMANENT','SALVATION ARMY'];
																 
StreetAddressToFilter2 := 'UNKNOWN ADDRESS|ADDRESS UNKNOW[N]*|MOVED - LEFT NO ADDRESS|NO CURRENT ADDRESS|NO ADDRESS GIVEN|NO ADDRESS AVAILABLE|NO FORWARDING ADDRESS|'+
                          'NO KNOWN ADDRESS|NO PERMANANT ADDR|^NPA [0-9]+[ ]*$|PUBLIC SAFETY BLD|PROTECTIVE ORDER SEALING|UNDELIVERABLE|UNABLE TO FORWARD|'+
													'^WSP [0-9]+[ ]*$|^UNKNOWN [0-9]*$|DOES NOT KNOW ADDRESS|FORWARDING ORDER EXPIRED';

export CleanAddress(string pcitystzip) := FUNCTION
 step1 := MAP(stringlib.stringfind('PRJ REL DATE',pcitystzip,1)>0 => '',
              pcitystzip);
 step2 := Std.Str.CleanSpaces(step1); //clean extra spaces
 step3 := stringlib.stringfindreplace(step2,' ,',','); 
 step4 := regexreplace('(.*)( [0-9]{5})([-]*[0-9]+)',(step3),'$1$2');//remove zip4
 clnAddress := MAP( regexfind('(SC)( SC)( [0-9]{5})',step4)=> regexreplace('(SC)( SC)( [0-9]{5})',step4,'$1$3'),
                    regexfind('(.*)( FL)[A]([0-9]{5})',step4)=> regexreplace('(.*)( FL)[A]([0-9]{5})',step4,'$1$2 $3'),
                    trim(step4,left,right) =',' => '',
                    step4
                   );
 return clnAddress;
end;																 

export statusToFilter := ['PLAINTIFF', 'JUVENILE CLASS: A','JUVENILE CLASS: N','JUVENILE CLASS: JA','JUVENILE CLASS: J'];

export Filterlist     := ['NA','UNK','NULL','R000','E000','0','1','2','3','4','5','6','7','8','9','9999999'];


EXPORT STRING8 GetDate := (STRING8)Std.Date.Today();

EXPORT fn_validate_dt(string st, string dt_type = '') := function
current := st = '' or (unsigned) st = 0 or (_validate.date.fCorrectedDateString(st) <> '' and _validate.date.fCorrectedDateString(st) > '19000101' and _validate.date.fCorrectedDateString(st) <= GetDate);
future  := st = '' or (unsigned) st = 0 or (_validate.date.fCorrectedDateString(st) <> '' and _validate.date.fCorrectedDateString(st) > '19000101');

return if(dt_type = '', (unsigned)current, (unsigned) future);

end;
			
export string is_valid(string8 d1, string8 d2) := function

 return MAP(d2 IN ['19000101','20000000','19000000'] => 'N',
            fn_validate_dt(d2,'')=0     => 'N',
            regexfind('[A-Za-z]',d2)      => 'N',  
            d2 <> '' and (ut.DaysSince1900(d1[1..4], d1[5..6], d1[7..8]) - ut.DaysSince1900(d2[1..4], d2[5..6], d2[7..8])) >0 =>'Y',
      'N' );
			
end;			
export ctg_Arson                           := 'ARSON';   
export ctg_Assault_aggr  	                 := 'ASSAULT_AGGRAVATED';  	                   
export ctg_Assault_other  	               := 'ASSAULT_OTHER';
export ctg_Bribery                         := 'BRIBERY';                       
export ctg_Burglary_BreakAndEnter_res      := 'BURGLARY_BREAK_AND_ENTER_RESIDENTIAL';
export ctg_Burglary_BreakAndEnter_comm     := 'BURGLARY_BREAK_AND_ENTER_COMMERCIAL';   
export ctg_Burglary_BreakAndEnter_veh      := 'BURGLARY_BREAK_AND_ENTER_MOTOR_VEHICLE'; 
export ctg_Counterfeiting_Forgery          := 'COUNTERFEITING_FORGERY';       
export ctg_Destruction_Damage_Vandalism    := 'DESTRUCTION_DAMAGE_VANDALISM';  
export ctg_Drug_Narcotic                   := 'DRUG_NARCOTIC';                 
export ctg_Fraud                           := 'FRAUD';                         
export ctg_Gambling                        := 'GAMBLING';                     
export ctg_Homicide                        := 'HOMICIDE';                      
export ctg_Kidnapping_Abduction            := 'KIDNAPPING_ABDUCTION';          
export ctg_Theft                           := 'THEFT';                       
export ctg_Shoplifting                     := 'SHOPLIFTING'; 
export ctg_Motor_Vehicle_Theft             := 'MOTOR_VEHICLE_THEFT';           
export ctg_Pornography                     := 'PORNOGRAPHY_OBSCENE_MATERIAL';  
export ctg_Prostitution                    := 'PROSTITUTION';                  
export ctg_Robbery_res                     := 'ROBBERY_RESIDENTIAL';                       
export ctg_Robbery_comm                    := 'ROBBERY_COMMERCIAL';
export ctg_SexOffensesForcible             := 'SEXOFFENSES_FORCIBLE';           
export ctg_SexOffensesNon_forcible         := 'SEXOFFENSES_NON_FORCIBLE';       
export ctg_Stolen_Property_Offenses_Fence  := 'STOLEN_PROPERTY_OFFENSES_FENCE';
export ctg_Weapon_Law_Violations           := 'WEAPON_LAW_VIOLATIONS';         
export ctg_Identity_Theft                  := 'IDENTITY_THEFT';                
export ctg_Computer_Crimes                 := 'COMPUTER_CRIMES';               
export ctg_Human_Trafficking               := 'HUMAN_TRAFFICKING';             
export ctg_Terrorist_Threats               := 'TERRORIST_THREATS';             
export ctg_Restraining_Order_Violations    := 'RESTRAINING_ORDER_VIOLATIONS';  
export ctg_Traffic                         := 'TRAFFIC';                       
export ctg_BadChecks                       := 'BADCHECKS';                     
export ctg_CurfewLoiteringVagrancyVio      := 'CURFEW_LOITERING_VAGRANCY';    
export ctg_DisorderlyConduct               := 'DISORDERLY_CONDUCT';             
export ctg_DrivingUndertheInfluence        := 'DRIVING_UNDER_THE_INFLUENCE';      
export ctg_Drunkenness                     := 'DRUNKENNESS';                   
export ctg_FamilyOffenses                  := 'FAMILY_OFFENSES';      
export ctg_LiquorLawViolations             := 'LIQUOR_LAW_VIOLATIONS';           
export ctg_TrespassofRealProperty          := 'TRESPASS_OF_REALPROPERTY'; 
export ctg_PeepingTom                      := 'PEEPING_TOM'; 
export ctg_Other                           := 'OTHER'; 
export ctg_Unclassified                    := 'CANNOT_CLASSIFY'; 
export ctg_Warrant_Fugitive                := 'WARRANT_FUGITIVE';
export ctg_Obstruct_Resist                 := 'OBSTRUCT_RESIST';
// export ctg_Embezzlement                 := 'EMBEZZLEMENT';        //Currently Not used
// export ctg_Extortion_Blackmail          := 'EXTORTION_BLACKMAIL'; //Currently Not used 

//convert the category to bitmap											
export category_to_bitmap  (string category = '')  := map(
													//Sources other than header
													
													category = ctg_Arson                          	=> ut.bit_set(0,0),
													category = ctg_Assault_aggr  	                	=> ut.bit_set(0,1),
													category = ctg_Assault_other  	              	=> ut.bit_set(0,2),
													category = ctg_Bribery                    	    => ut.bit_set(0,3),
													category = ctg_Burglary_BreakAndEnter_res       => ut.bit_set(0,4),
													category = ctg_Burglary_BreakAndEnter_comm      => ut.bit_set(0,5),
													category = ctg_Burglary_BreakAndEnter_veh   	  => ut.bit_set(0,6),
													category = ctg_Counterfeiting_Forgery         	=> ut.bit_set(0,7),
													category = ctg_Destruction_Damage_Vandalism   	=> ut.bit_set(0,8),
													category = ctg_Drug_Narcotic                  	=> ut.bit_set(0,9),
													category = ctg_Fraud                            => ut.bit_set(0,10),
													category = ctg_Gambling                         => ut.bit_set(0,11),
													category = ctg_Homicide                       	=> ut.bit_set(0,12),
													category = ctg_Kidnapping_Abduction           	=> ut.bit_set(0,13),
													category = ctg_Theft                            => ut.bit_set(0,14),
													category = ctg_Shoplifting                    	=> ut.bit_set(0,15),
													category = ctg_Motor_Vehicle_Theft            	=> ut.bit_set(0,16),
													category = ctg_Pornography                    	=> ut.bit_set(0,17),
													category = ctg_Prostitution                   	=> ut.bit_set(0,18),
													category = ctg_Robbery_res                    	=> ut.bit_set(0,19),
													category = ctg_Robbery_comm                   	=> ut.bit_set(0,20),
													category = ctg_SexOffensesForcible            	=> ut.bit_set(0,21),
													category = ctg_SexOffensesNon_forcible        	=> ut.bit_set(0,22),
													category = ctg_Stolen_Property_Offenses_Fence 	=> ut.bit_set(0,23),
													category = ctg_Weapon_Law_Violations            => ut.bit_set(0,24),
													category = ctg_Identity_Theft                 	=> ut.bit_set(0,25),
													category = ctg_Computer_Crimes                	=> ut.bit_set(0,26),
													category = ctg_Human_Trafficking              	=> ut.bit_set(0,27),
													category = ctg_Terrorist_Threats              	=> ut.bit_set(0,28),
													category = ctg_Restraining_Order_Violations     => ut.bit_set(0,29),
													category = ctg_Traffic                          => ut.bit_set(0,30),
													category = ctg_BadChecks                      	=> ut.bit_set(0,31),
													category = ctg_CurfewLoiteringVagrancyVio     	=> ut.bit_set(0,32),
													category = ctg_DisorderlyConduct              	=> ut.bit_set(0,33),
													category = ctg_DrivingUndertheInfluence       	=> ut.bit_set(0,34),
													category = ctg_Drunkenness                    	=> ut.bit_set(0,35),
													category = ctg_FamilyOffenses                   => ut.bit_set(0,36),
													category = ctg_LiquorLawViolations              => ut.bit_set(0,37),
													category = ctg_TrespassofRealProperty         	=> ut.bit_set(0,38),      
													category = ctg_PeepingTom                     	=> ut.bit_set(0,39),      
													category = ctg_Other                            => ut.bit_set(0,40),      
													category = ctg_Unclassified                     => ut.bit_set(0,41),   
													category = ctg_Warrant_Fugitive                 => ut.bit_set(0,42),  
													category = ctg_Obstruct_Resist                  => ut.bit_set(0,43),
													0); //Max 64 sources
 

//-----Convert the bitmap to desc									
export	string	Get_category_from_bitmap(unsigned bitmap_category) := function
		boolean		fis_match(unsigned p_in_bitmap_category, unsigned bitmap_category)	:=	p_in_bitmap_category & bitmap_category = bitmap_category;
		string		translate_bitmap		:=	if(bitmap_category = 0,'',											   							     
																					 if(fis_match(bitmap_category, category_to_bitmap(ctg_Arson                         	)),' ' + ctg_Arson                         	,'')
                                          +if(fis_match(bitmap_category, category_to_bitmap(ctg_Assault_aggr  	               	)),' ' + ctg_Assault_aggr  	               	,'')																					
																					+if(fis_match(bitmap_category, category_to_bitmap(ctg_Assault_other  	             	  )),' ' + ctg_Assault_other  	             	,'')
																					+if(fis_match(bitmap_category, category_to_bitmap(ctg_Bribery                       	)),' ' + ctg_Bribery                       	,'')
																					+if(fis_match(bitmap_category, category_to_bitmap(ctg_Burglary_BreakAndEnter_res      )),' ' + ctg_Burglary_BreakAndEnter_res    	,'')
																					+if(fis_match(bitmap_category, category_to_bitmap(ctg_Burglary_BreakAndEnter_comm     )),' ' + ctg_Burglary_BreakAndEnter_comm   	,'')
																					+if(fis_match(bitmap_category, category_to_bitmap(ctg_Burglary_BreakAndEnter_veh      )),' ' + ctg_Burglary_BreakAndEnter_veh	    ,'')
																					+if(fis_match(bitmap_category, category_to_bitmap(ctg_Counterfeiting_Forgery        	)),' ' + ctg_Counterfeiting_Forgery        	,'')
																					+if(fis_match(bitmap_category, category_to_bitmap(ctg_Destruction_Damage_Vandalism  	)),' ' + ctg_Destruction_Damage_Vandalism  	,'')
																					+if(fis_match(bitmap_category, category_to_bitmap(ctg_Drug_Narcotic                 	)),' ' + ctg_Drug_Narcotic                 	,'')
																					+if(fis_match(bitmap_category, category_to_bitmap(ctg_Fraud                         	)),' ' + ctg_Fraud                         	,'')
																					+if(fis_match(bitmap_category, category_to_bitmap(ctg_Gambling                      	)),' ' + ctg_Gambling                      	,'')
																					+if(fis_match(bitmap_category, category_to_bitmap(ctg_Homicide                      	)),' ' + ctg_Homicide                      	,'')
																					+if(fis_match(bitmap_category, category_to_bitmap(ctg_Kidnapping_Abduction          	)),' ' + ctg_Kidnapping_Abduction          	,'')
																					+if(fis_match(bitmap_category, category_to_bitmap(ctg_Theft                         	)),' ' + ctg_Theft                         	,'')
																					+if(fis_match(bitmap_category, category_to_bitmap(ctg_Shoplifting                   	)),' ' + ctg_Shoplifting                   	,'')
																					+if(fis_match(bitmap_category, category_to_bitmap(ctg_Motor_Vehicle_Theft           	)),' ' + ctg_Motor_Vehicle_Theft           	,'')
																					+if(fis_match(bitmap_category, category_to_bitmap(ctg_Pornography                   	)),' ' + ctg_Pornography                   	,'')
																					+if(fis_match(bitmap_category, category_to_bitmap(ctg_Prostitution                  	)),' ' + ctg_Prostitution                  	,'')
																					+if(fis_match(bitmap_category, category_to_bitmap(ctg_Robbery_res                   	)),' ' + ctg_Robbery_res                   	,'')
																					+if(fis_match(bitmap_category, category_to_bitmap(ctg_Robbery_comm                  	)),' ' + ctg_Robbery_comm                  	,'')
																					+if(fis_match(bitmap_category, category_to_bitmap(ctg_SexOffensesForcible           	)),' ' + ctg_SexOffensesForcible           	,'')
																					+if(fis_match(bitmap_category, category_to_bitmap(ctg_SexOffensesNon_forcible       	)),' ' + ctg_SexOffensesNon_forcible       	,'')
																					+if(fis_match(bitmap_category, category_to_bitmap(ctg_Stolen_Property_Offenses_Fence	)),' ' + ctg_Stolen_Property_Offenses_Fence	,'')
																					+if(fis_match(bitmap_category, category_to_bitmap(ctg_Weapon_Law_Violations         	)),' ' + ctg_Weapon_Law_Violations         	,'')
																					+if(fis_match(bitmap_category, category_to_bitmap(ctg_Identity_Theft                	)),' ' + ctg_Identity_Theft                	,'')	
																					+if(fis_match(bitmap_category, category_to_bitmap(ctg_Computer_Crimes               	)),' ' + ctg_Computer_Crimes               	,'')			
                                          +if(fis_match(bitmap_category, category_to_bitmap(ctg_Human_Trafficking               )),' ' + ctg_Human_Trafficking             	,'')
                                          +if(fis_match(bitmap_category, category_to_bitmap(ctg_Terrorist_Threats               )),' ' + ctg_Terrorist_Threats             	,'')
                                          +if(fis_match(bitmap_category, category_to_bitmap(ctg_Restraining_Order_Violations    )),' ' + ctg_Restraining_Order_Violations  	,'')
                                          +if(fis_match(bitmap_category, category_to_bitmap(ctg_Traffic                         )),' ' + ctg_Traffic                       	,'')
                                          +if(fis_match(bitmap_category, category_to_bitmap(ctg_BadChecks                       )),' ' + ctg_BadChecks                     	,'')
                                          +if(fis_match(bitmap_category, category_to_bitmap(ctg_CurfewLoiteringVagrancyVio      )),' ' + ctg_CurfewLoiteringVagrancyVio    	,'')
                                          +if(fis_match(bitmap_category, category_to_bitmap(ctg_DisorderlyConduct               )),' ' + ctg_DisorderlyConduct             	,'')
                                          +if(fis_match(bitmap_category, category_to_bitmap(ctg_DrivingUndertheInfluence        )),' ' + ctg_DrivingUndertheInfluence      	,'')
                                          +if(fis_match(bitmap_category, category_to_bitmap(ctg_Drunkenness                     )),' ' + ctg_Drunkenness                   	,'')											   
                                          +if(fis_match(bitmap_category, category_to_bitmap(ctg_FamilyOffenses                  )),' ' + ctg_FamilyOffenses                	,'')											   
																					+if(fis_match(bitmap_category, category_to_bitmap(ctg_LiquorLawViolations             )),' ' + ctg_LiquorLawViolations           	,'')	
																					+if(fis_match(bitmap_category, category_to_bitmap(ctg_TrespassofRealProperty          )),' ' + ctg_TrespassofRealProperty         ,'')
																					+if(fis_match(bitmap_category, category_to_bitmap(ctg_PeepingTom                      )),' ' + ctg_PeepingTom                     ,'')	
																					+if(fis_match(bitmap_category, category_to_bitmap(ctg_Other                           )),' ' + ctg_Other                          ,'')	
																					+if(fis_match(bitmap_category, category_to_bitmap(ctg_Unclassified                    )),' ' + ctg_Unclassified                   ,'')	
																					+if(fis_match(bitmap_category, category_to_bitmap(ctg_Warrant_Fugitive                )),' ' + ctg_Warrant_Fugitive               ,'')	
																					+if(fis_match(bitmap_category, category_to_bitmap(ctg_Obstruct_Resist                 )),' ' + ctg_Obstruct_Resist                ,'')
																																								
												 );                                                                                                      	
		
		return		stringlib.stringfindreplace(trim(stringlib.stringcleanspaces(translate_bitmap),left,right),'  ',' ');
end;	




export is_company(string temp_name) := function 

	string1 v_bus_name_flag :=if(StringLib.StringFind(temp_name,'ANCHORAGE ',1)!=0 OR
					StringLib.StringFind(temp_name,'HARVESTING',1) !=0 OR                                      
					StringLib.StringFind(temp_name,'PRODUCTION',1) !=0 OR
					StringLib.StringFind(temp_name,'ENVIRONMENTAL',1) !=0 OR
					StringLib.StringFind(temp_name,'LANDSCAPE',1) !=0 OR
					StringLib.StringFind(temp_name,'FURNISHING',1) !=0 OR
					StringLib.StringFind(temp_name,'UNION ASPHALT',1) !=0 OR
					StringLib.StringFind(temp_name,'UPS GROUND',1) !=0 OR
					StringLib.StringFind(temp_name,' CENTRAL ',1) !=0 OR 											
					StringLib.StringFind(temp_name,' CONTINENTAL ',1) !=0 OR 									
					StringLib.StringFind(temp_name,' OPEN ERROR ',1) !=0 OR                                              
					StringLib.StringFind(temp_name,' PAINTINT ',1) !=0 OR 
					StringLib.StringFind(temp_name,' CLEANUP ',1) !=0 OR								
					StringLib.StringFind(temp_name,' PROGRESSIVE ',1) !=0 OR	
					StringLib.StringFind(temp_name,' CERTIFIED ',1) !=0 OR 
					StringLib.StringFind(temp_name,' WASTE ',1) !=0 OR	
					StringLib.StringFind(temp_name,' WASTE ',1) !=0 OR	
					StringLib.StringFind(temp_name,' INDUSTRIES ',1) !=0 OR
					StringLib.StringFind(temp_name,' ADVANCED ',1) !=0 OR
					StringLib.StringFind(temp_name,' USE PID ',1) !=0 OR
					StringLib.StringFind(temp_name,' AUTHORITY ',1) !=0 OR
					StringLib.StringFind(temp_name,' CAMPGD ',1) !=0 OR
				 // StringLib.StringFind(temp_name,' CAMPGROUND ',1)!=0 OR
					StringLib.StringFind(temp_name,' CONTRACTORS ',1)!=0 OR
					StringLib.StringFind(temp_name,'SPORTSFISHING',1)!=0 OR
					StringLib.StringFind(temp_name,'SPORTFISHING',1)!=0 OR
				 // StringLib.StringFind(temp_name,' BROTHERS ',1) !=0 OR
					StringLib.StringFind(temp_name,'POWERSPORTS',1)!=0 OR
					StringLib.StringFind(temp_name,'POWER SPORTS',1) !=0 OR
					StringLib.StringFind(temp_name,' & SON',1)!=0 OR
					StringLib.StringFind(temp_name, 'PRECISION',1)!=0 OR
					StringLib.StringFind(temp_name,' ISLANDS  ',1)!=0 OR
					//StringLib.StringFind(temp_name,' ISLAND ',1)!=0 OR
				 //StringLib.StringFind(temp_name,' SPORT ',1)!=0 OR
			StringLib.StringFind(temp_name,' SPORTS ',1)!=0 OR
			StringLib.StringFind(temp_name,' ADVENTURES ',1)!=0 OR
			//StringLib.StringFind(temp_name,', N A',1)!=0 OR
			StringLib.StringFind(temp_name,', N. A.',1)!=0 OR
			StringLib.StringFind(temp_name, ' RENTALS ',1)!=0 OR
			StringLib.StringFind(temp_name, ' RENTAL ',1)!=0 OR 
			StringLib.StringFind(temp_name,' ASSN ',1)!=0 OR
			StringLib.StringFind(temp_name,' S&LA ',1)!=0 OR
			StringLib.StringFind(temp_name,' S & LA ',1)!=0 OR
			StringLib.StringFind(temp_name,' ASSN. ',1)!=0 OR
			StringLib.StringFind(temp_name,' ASSOCIATION ',1)!=0 OR
			StringLib.StringFind(temp_name,'ASSOC ',1) != 0 OR
			StringLib.StringFind(temp_name,'ASSOC.',1) != 0 OR
			StringLib.StringFind(temp_name,'ASSOCIATES L L P',1)!=0 OR
			StringLib.StringFind(temp_name,'ASSOCIATES',1)!=0 OR
			StringLib.StringFind(temp_name,' COMMONWEALTH ',1)!=0 OR
//////////////////////////////////////////////////////////////////////////////////									
				
		  StringLib.StringFind(temp_name,'CONCRETE ',1)!=0 OR
		  //StringLib.StringFind(temp_name,' CONDO ',1)!=0 OR
		  StringLib.StringFind(temp_name,' PRODUCTS ',1)!=0 OR
		  //StringLib.StringFind(temp_name,' FIRM ',1)!=0 OR
		  //StringLib.StringFind(temp_name,' PC ',1)!=0 OR
		  StringLib.StringFind(temp_name,' P.C. ',1)!=0 OR
		  StringLib.StringFind(temp_name,' DIST  ',1)!=0 OR
		  StringLib.StringFind(temp_name,' INS ',1)!=0 OR
		  StringLib.StringFind(temp_name,' INS. ',1)!=0 OR
		  StringLib.StringFind(temp_name,' INSURANCE ',1)!=0 OR			
		  //StringLib.StringFind(temp_name,' LEAGUE ',1)!=0 OR
		  StringLib.StringFind(temp_name,' LANDFILL ',1)!=0 OR
		  StringLib.StringFind(temp_name,'ELECTRICAL',1)!=0 OR
		  StringLib.StringFind(temp_name,'NETWORK',1)!=0 OR
		  StringLib.StringFind(temp_name,'MANUFACTUR',1)!=0 OR
		  StringLib.StringFind(temp_name,' WILDLIFE ',1)!=0 OR
		  StringLib.StringFind(temp_name,'COMMERCE',1)!=0 OR
		  StringLib.StringFind(temp_name,'MERCHANTS ',1)!=0 OR
		  StringLib.StringFind(temp_name,' LEARNING ',1)!=0 OR
		  StringLib.StringFind(temp_name,' SER. ',1)!=0 OR
		  StringLib.StringFind(temp_name,' CLUB ',1)!=0 OR
		  //StringLib.StringFind(temp_name,' HUNTING ',1)!=0 OR
		  //StringLib.StringFind(temp_name,' GAZETTE ',1)!=0 OR

		  StringLib.StringFind(temp_name,' AND KNEE',1)!=0 OR
		  StringLib.StringFind(temp_name,'SHIPPING',1)!=0 OR
		  StringLib.StringFind(temp_name,'TELECOM',1)!=0 OR
		  StringLib.StringFind(temp_name,'COMMUNICATION',1)!=0 OR
		  StringLib.StringFind(temp_name,'CORPORATE',1)!=0 OR
		  StringLib.StringFind(temp_name,'ACCOUNTS',1)!=0 OR
		  StringLib.StringFind(temp_name,'AMBULANCE',1)!=0 OR
		  StringLib.StringFind(temp_name,' ORTHO ',1)!=0 OR
		  StringLib.StringFind(temp_name,' ORTHOPEDIC ',1)!=0 OR
		  StringLib.StringFind(temp_name,'NEUROLOGICAL',1)!=0 OR
		  StringLib.StringFind(temp_name,'NEUROLOGY',1)!=0 OR
		  StringLib.StringFind(temp_name,'OPTHAMOLOGY',1)!=0 OR
		 ( StringLib.StringFind(temp_name,'EASTERN',1)!=0 and StringLib.StringFind(temp_name,',',1)=0) OR
		 ( StringLib.StringFind(temp_name,'EASTERN',1)!=0 and StringLib.StringFind(trim(temp_name),' ',5)> 0) OR
		 ( StringLib.StringFind(temp_name,'WESTERN',1)!=0 and StringLib.StringFind(temp_name,',',1)=0)OR
		 ( StringLib.StringFind(temp_name,'WESTERN',1)!=0 and StringLib.StringFind(trim(temp_name),' ',5)> 0) OR
		 ( StringLib.StringFind(temp_name,'NORTHERN',1)!=0 and StringLib.StringFind(temp_name,',',1)=0)OR
		 ( StringLib.StringFind(temp_name,'NORTHERN',1)!=0 and StringLib.StringFind(trim(temp_name),' ',5)> 0) OR
		 ( StringLib.StringFind(temp_name,'SOUTHERN',1)!=0 and StringLib.StringFind(temp_name,',',1)=0)OR
		 ( StringLib.StringFind(temp_name,'SOUTHERN',1)!=0 and StringLib.StringFind(trim(temp_name),' ',5)> 0) OR
		  StringLib.StringFind(temp_name,'ADMINISTRATION',1)!=0 OR
		  StringLib.StringFind(temp_name,'ALIGNMENT',1)!=0 OR
		  StringLib.StringFind(temp_name,'AMUSEMENT',1)!=0 OR
		  StringLib.StringFind(temp_name,' ANTIQUES ',1)!=0 OR
		  StringLib.StringFind(temp_name,' BUTANE ',1)!=0 OR
		  StringLib.StringFind(temp_name,' PETROLEUM ',1)!=0 OR
		  StringLib.StringFind(temp_name,'APARTMENTS',1)!=0 OR
		  StringLib.StringFind(temp_name,'APLC',1)!=0 OR
		  StringLib.StringFind(temp_name,'ARCHITECTU',1)!=0 OR
		  StringLib.StringFind(temp_name,'ARCHETECTU',1)!=0 OR
		  StringLib.StringFind(temp_name,'AIR CONDITIONING',1)!=0 OR
		  StringLib.StringFind(temp_name,'APPLIANCE',1)!=0 OR  
		  StringLib.StringFind(temp_name,'AS AGENT',1)!=0 OR
		  StringLib.StringFind(temp_name,'AUTOMOTIVE',1)!=0 OR
		  StringLib.StringFind(temp_name,'AVIATION',1)!=0 OR
		  StringLib.StringFind(temp_name,'AIRLINES',1)!=0 OR
		  StringLib.StringFind(temp_name,'BLUE CROSS',1)!=0 OR
		  StringLib.StringFind(temp_name,'BLUE SHIELD',1)!=0 OR
		  StringLib.StringFind(temp_name,'BOOKKEEPING',1)!=0 OR
		  //StringLib.StringFind(temp_name,'BOOKBINDER',1)!=0 OR
			( StringLib.StringFind(temp_name,'BOOKBINDER',1)!=0 and StringLib.StringFind(trim(temp_name),' ',5)> 0) OR
		  StringLib.StringFind(temp_name,' BOTTLING ',1)!=0 OR
		  //StringLib.StringFind(temp_name,' BAPTIST ',1)!=0 OR // added space
		  StringLib.StringFind(temp_name,'METHODIST',1)!=0 OR
		//  StringLib.StringFind(temp_name,' MILLING ',1)!=0 OR
		  StringLib.StringFind(temp_name,'BROKERAGE',1)!=0 OR
		  StringLib.StringFind(temp_name,' BROKERS ',1)!=0 OR
		  StringLib.StringFind(temp_name,' BUILDING ',1)!=0 OR
		  StringLib.StringFind(temp_name,' BUYERS ',1)!=0 OR
		  StringLib.StringFind(temp_name,'BUSINESS',1)!=0 OR
		  StringLib.StringFind(temp_name,'BOUTIQUE',1)!=0 OR
		  StringLib.StringFind(temp_name,'CHEMICAL',1)!=0 OR
		  StringLib.StringFind(temp_name,'COMPUTER',1)!=0 OR
		  StringLib.StringFind(temp_name,'CORPORATION',1)!=0 OR
		  StringLib.StringFind(temp_name,'CARBURETOR',1)!=0 OR
		  StringLib.StringFind(temp_name,'CASUALTY',1)!=0 OR
		  StringLib.StringFind(temp_name,'SECURITY',1)!=0 OR
		  StringLib.StringFind(temp_name,'CHIROPRACTIC',1)!=0 OR
		  //StringLib.StringFind(temp_name,' CHIRO ',1)!=0 OR
		  StringLib.StringFind(temp_name,'CHAPTER ',1)!=0  OR
		  StringLib.StringFind(temp_name,'CLEANING',1)!=0 OR
		  StringLib.StringFind(temp_name,'COMPANY',1)!=0 OR
		  StringLib.StringFind(temp_name,'CONSTRUCTION',1)!=0 OR
		  StringLib.StringFind(temp_name,'CONTRACTING',1)!=0 OR
		  StringLib.StringFind(temp_name,' FLYING ',1)!=0 OR
		  StringLib.StringFind(temp_name,'CONST.',1)!=0 OR
		  StringLib.StringFind(temp_name,'CONSULTANTS',1)!=0 OR
		  StringLib.StringFind(temp_name,'COOPERATIVE',1)!=0 OR
		  StringLib.StringFind(temp_name,'CABLEVISION',1)!=0 OR
		  StringLib.StringFind(temp_name,'COMMUNITY',1)!=0 OR
		  StringLib.StringFind(temp_name,'CMNTY',1)!=0 OR
		  StringLib.StringFind(temp_name,'COMMUNICATIONS',1)!=0 OR
		  StringLib.StringFind(temp_name,'COUNTRY CLUB',1)!=0 OR
		  //StringLib.StringFind(temp_name,' COUNTY ',1)!=0 OR
		 ( StringLib.StringFind(temp_name,'COUNTY',1)!=0 and StringLib.StringFind(temp_name,',',1)=0)OR
		 ( StringLib.StringFind(temp_name,'COUNTY',1)!=0 and StringLib.StringFind(trim(temp_name),' ',5)> 0) OR
		  StringLib.StringFind(temp_name,' CREDIT ',1)!=0 OR
		  StringLib.StringFind(temp_name,'DEPARTMENT',1)!=0 OR
		  StringLib.StringFind(temp_name,' DEPT ',1)!=0 OR
		  StringLib.StringFind(temp_name,' DEPT.',1)!=0 OR
		  StringLib.StringFind(temp_name,' DEPARTMT ',1)!=0 OR
		  StringLib.StringFind(temp_name,'DEVELOPMENT',1)!=0 OR
		  //StringLib.StringFind(temp_name,'DETROIT',1)!=0 OR
		  StringLib.StringFind(temp_name,'DVLPMNTL',1)!=0 OR
		  StringLib.StringFind(temp_name,'DISTRICT',1)!=0 OR
		  StringLib.StringFind(temp_name,'DISTRIBUTION',1)!=0 OR
		  StringLib.StringFind(temp_name,'DISTRIBUTING',1)!=0 OR
		StringLib.StringFind(temp_name,'DIVISION',1)!= 0 OR
		  StringLib.StringFind(temp_name,'ELEVATOR',1)!=0 OR
		  StringLib.StringFind(temp_name,'ENTERPRISE',1)!=0 OR
		  StringLib.StringFind(temp_name,'ENGINEERING',1)!=0 OR
		  StringLib.StringFind(temp_name,'ESTATES',1)!=0 OR
		  StringLib.StringFind(temp_name,'EQUIPMENT',1)!=0 OR
		  StringLib.StringFind(temp_name,'EQUITY',1)!=0 OR
		  StringLib.StringFind(temp_name,'EXCAVATING',1)!=0 OR
		  StringLib.StringFind(temp_name,'EXPRESS',1)!=0 OR
		  StringLib.StringFind(temp_name,'FINANCIAL ',1)!=0 OR
		  StringLib.StringFind(temp_name,'FINANCE ',1)!=0 OR
		  StringLib.StringFind(temp_name,'FABRICATORS',1)!=0 OR
		  StringLib.StringFind(temp_name,'FREIGHTLINER',1)!=0 OR
		  StringLib.StringFind(temp_name,'FREIGHT ',1)!=0 OR
		  StringLib.StringFind(temp_name,'FULLFILLMENT',1)!=0 OR
		  StringLib.StringFind(temp_name,'FULFILLMENT',1)!=0 OR
		  StringLib.StringFind(temp_name,'FUNERAL HOME',1)!=0 OR
		  StringLib.StringFind(temp_name,'FURNITURE',1)!=0 OR
		  StringLib.StringFind(temp_name,'GOVERNMENT',1)!=0 OR
		  StringLib.StringFind(temp_name,'GVRNMNT',1)!=0 OR
		  StringLib.StringFind(temp_name,' GROWERS ',1)!=0 OR
		  StringLib.StringFind(temp_name,'DEVELOPMENT',1)!=0 OR
		  StringLib.StringFind(temp_name,'DVLPMNTL',1)!=0 OR
		  StringLib.StringFind(temp_name,'FREIGHT',1)!=0 OR
		  StringLib.StringFind(temp_name,'HEALTHCARE',1)!=0 OR
		  StringLib.StringFind(temp_name,'INNOVATIVE',1)!=0 OR
		  StringLib.StringFind(temp_name,'HOSPICE',1)!=0 OR
		  StringLib.StringFind(temp_name,' HOSPITAL',1)!=0 OR
		  StringLib.StringFind(temp_name,' HOSP ',1)!=0 OR
		  StringLib.StringFind(temp_name,' HOSP.',1)!=0 OR
		  StringLib.StringFind(temp_name,'INSTITUTE',1)!=0 OR
		  StringLib.StringFind(temp_name,'INDUSTRIAL',1)!=0 OR
		  StringLib.StringFind(temp_name,'INTERNATIONAL',1)!=0 OR
		  StringLib.StringFind(temp_name,'INTERIORS',1)!=0 OR
		  StringLib.StringFind(temp_name,'INVESTMENTS',1)!=0 OR
		  StringLib.StringFind(temp_name,'LANDSCAPING',1)!=0 OR
		  StringLib.StringFind(temp_name,' LEASING ',1)!=0 OR
		 // StringLib.StringFind(temp_name,' LEASE ',1)!=0 OR
		 // StringLib.StringFind(temp_name,' LOAN ',1)!=0 OR
		  StringLib.StringFind(temp_name,'MACHINE',1)!=0 OR
		  StringLib.StringFind(temp_name,'MANAGEMENT',1)!=0 OR
		  // StringLib.StringFind(temp_name,'MATUSHITA',1)!=0 OR
		  // StringLib.StringFind(temp_name,'MATSUSHITA',1)!=0 OR
		  StringLib.StringFind(temp_name,'MISSIONARY',1)!=0 OR
		  StringLib.StringFind(temp_name,'MINISTRIES',1)!=0 OR
		  StringLib.StringFind(temp_name,'MNGMNT',1)!=0 OR
		  StringLib.StringFind(temp_name,'MOBILE PARK',1)!=0 OR
		  StringLib.StringFind(temp_name,'MOBILE HOME',1)!=0 OR
		  StringLib.StringFind(temp_name,'MOHAVE COUNTY',1)!=0 OR                                           
		  //StringLib.StringFind(temp_name,'MOUNTAIN',1)!=0 OR
		  StringLib.StringFind(temp_name,' NATIONAL ',1)!=0 OR
			StringLib.StringFind(temp_name,'NATIONAL, ',1)!=0 OR
		  //StringLib.StringFind(temp_name,' NATION ',1)!=0 OR
		  StringLib.StringFind(temp_name,' NAT\'L',1)!=0 OR
		  StringLib.StringFind(temp_name,' NATL ',1)!=0 OR
		  StringLib.StringFind(temp_name,' NATL. ',1)!=0 OR
		  StringLib.StringFind(temp_name,'OPTICAL',1)!=0 OR
		  StringLib.StringFind(temp_name,'PACKAGING',1)!=0 OR
		  StringLib.StringFind(temp_name,'PARTNERSHIP',1)!=0 OR
		  StringLib.StringFind(temp_name,'PEDIATRICS',1)!=0 OR
		  StringLib.StringFind(temp_name,' CONTROL ',1)!=0 OR
		  StringLib.StringFind(temp_name,' POLICE ',1)!=0 OR
		  StringLib.StringFind(temp_name,' ANIMAL ',1)!=0 OR
		  StringLib.StringFind(temp_name,' FIRE ',1)!=0 OR
		  StringLib.StringFind(temp_name,' MUNCIPAL ',1)!=0 OR
		  StringLib.StringFind(temp_name,' BUREAU ',1)!=0 OR
		  StringLib.StringFind(temp_name,'PEER REVIEW',1)!=0 OR
		  StringLib.StringFind(temp_name,'PHARMACY',1)!=0 OR
		  StringLib.StringFind(temp_name,'PHARMACEUTICAL',1)!=0 OR
		  StringLib.StringFind(temp_name,'PENSION PLAN',1)!=0 OR
		  StringLib.StringFind(temp_name,'PLUMBING',1)!=0 OR
		  StringLib.StringFind(temp_name,'PRODUCTIONS',1)!=0 OR
		  StringLib.StringFind(temp_name,'PROFESSIONAL',1)!=0 OR
		  StringLib.StringFind(temp_name,'PROPERTIES',1)!=0 OR
		  StringLib.StringFind(temp_name,'RAILROAD',1)!=0 OR
		  StringLib.StringFind(temp_name,'REALTY',1)!=0 OR
		  StringLib.StringFind(temp_name,'REBUILDERS',1)!=0 OR
		  StringLib.StringFind(temp_name,'REPAIR',1)!=0 OR
		  StringLib.StringFind(temp_name,'RESTARAUNT',1)!=0 OR
		  StringLib.StringFind(temp_name,'RESTAURANT',1)!=0 OR
		  StringLib.StringFind(temp_name,'SAVINGS',1)!=0 OR
		  StringLib.StringFind(temp_name,'SECURITIES',1)!=0 OR
		  StringLib.StringFind(temp_name,'SEAFOOD',1)!=0 OR
		  StringLib.StringFind(temp_name,'SOLUTION',1)!=0 OR
		  StringLib.StringFind(temp_name,'SPECIALTY',1)!=0 OR
		  StringLib.StringFind(temp_name,' SQUARE ',1)!=0 OR
		  StringLib.StringFind(temp_name,'SYSTEMS',1)!=0 OR
		  StringLib.StringFind(temp_name,'STATE BANK',1)!=0 OR
		  StringLib.StringFind(temp_name,'SPECIALIST',1)!=0 OR
		  StringLib.StringFind(temp_name,'SPRCNTR',1)!=0 OR
		  StringLib.StringFind(temp_name,'SUPERCENTER',1)!=0 OR
		  StringLib.StringFind(temp_name,'SUPPLY',1)!=0 OR
		  StringLib.StringFind(temp_name,'SURGERY',1)!=0 OR
		  StringLib.StringFind(temp_name,'TELEPHONE',1)!=0 OR
		  StringLib.StringFind(temp_name,'TRAVEL ',1)!=0 OR
		  StringLib.StringFind(temp_name,'TRADE NAME',1)!=0 OR
		  StringLib.StringFind(temp_name,' TRACTOR ',1)!=0 OR
		  StringLib.StringFind(temp_name,'TRUCKING',1)!=0 OR
		  StringLib.StringFind(temp_name,' TRANSPORT ',1)!=0 OR
		  StringLib.StringFind(temp_name,'TECHNOLOGY',1)!=0 OR
			StringLib.StringFind(temp_name,'TECHNOLOG',1) != 0 OR
		  StringLib.StringFind(temp_name,'TRANSPORTATION',1)!=0 OR
		  StringLib.StringFind(temp_name,'TRANSMISSION',1)!=0 OR
		  StringLib.StringFind(temp_name,' STORAGE ',1)!=0 OR
		  StringLib.StringFind(temp_name,' TRANSFER ',1)!=0 OR		  
		  StringLib.StringFind(temp_name,'VALLEY ',1)!=0 OR
		  StringLib.StringFind(temp_name,'WAREHOUSE',1)!=0 OR
		  StringLib.StringFind(temp_name,'WELLS FARGO',1)!=0 OR
		  StringLib.StringFind(temp_name,' AGENCY',1)!=0 OR
		  StringLib.StringFind(temp_name,' MARKET ',1)!=0 OR
		  StringLib.StringFind(temp_name,' SALES ',1)!=0 OR
		  StringLib.StringFind(temp_name,' RADIO',1)!=0 OR
		  StringLib.StringFind(temp_name,' COUNCIL ',1)!=0 OR
		  StringLib.StringFind(temp_name,' PARTNERS',1)!=0 OR
		 // StringLib.StringFind(temp_name,' PLAZA',1)!=0 OR
		  StringLib.StringFind(temp_name,' CLINIC',1)!=0 OR
		  StringLib.StringFind(temp_name,' CENTER ',1)!=0 OR
		  StringLib.StringFind(temp_name,' SERVICE ',1)!=0 OR
		  StringLib.StringFind(temp_name,' GROUP ',1)!=0 OR
		  StringLib.StringFind(temp_name,'TRUSTEES ',1)!=0 OR
		  StringLib.StringFind(temp_name,' TRUSTEE ',1)!=0 OR
		  StringLib.StringFind(temp_name,' TRUSTEE,',1)!=0 OR
		  StringLib.StringFind(temp_name,',TRUSTEE',1)!=0 OR
		  StringLib.StringFind(temp_name,'TRUSTEE,',1)!=0 OR
		  StringLib.StringFind(temp_name,' TRUST ',1)!=0 OR
			StringLib.StringFind(temp_name,',TRUST ',1)!=0 OR
			StringLib.StringFind(temp_name,' TRUST,',1)!=0 OR
			StringLib.StringFind(temp_name,' TRST ' ,1)!=0 OR
		  StringLib.StringFind(temp_name,'REVOCAB',1)!=0 OR
		  StringLib.StringFind(temp_name,' INC ',1)!=0 OR
		  StringLib.StringFind(temp_name,' INC.',1)!=0 OR
		  StringLib.StringFind(temp_name,',INC ',1)!=0 OR
		  StringLib.StringFind(temp_name,',INC. ',1)!=0 OR
		  //StringLib.StringFind(temp_name,' LLC',1)!=0 OR
		  StringLib.StringFind(temp_name,' L L C',1)!=0 OR
		  StringLib.StringFind(temp_name,' LTD',1)!=0 OR
		  StringLib.StringFind(temp_name,' LTD ',1)!=0 OR
		  //StringLib.StringFind(temp_name,' LLP',1)!=0 OR
		  StringLib.StringFind(temp_name,' L L P',1)!=0 OR
			StringLib.StringFind(temp_name,',LLC',1)!=0 OR
			StringLib.StringFind(temp_name,'L.L.C.',1) != 0  OR
			StringLib.StringFind(temp_name,'L.L.P.',1) != 0 OR
			StringLib.StringFind(temp_name,'L.T.D.',1) != 0  OR
			StringLib.StringFind(temp_name,'.INC',1)!=0 OR
			StringLib.StringFind(' '+temp_name+' ',' LLC ',1) != 0 OR
			StringLib.StringFind(temp_name,' LLP ',1) != 0 OR
			StringLib.StringFind(temp_name,' LP ',1) != 0 OR
			StringLib.StringFind(temp_name,' L.P.',1)!=0 OR
			StringLib.StringFind(temp_name,' COOP ',1)!=0 OR
			StringLib.StringFind(temp_name,' CO-OP ',1)!=0 OR
			StringLib.StringFind(temp_name,' CO ',1) != 0 OR
			StringLib.StringFind(temp_name,' CO.',1) != 0 OR
			StringLib.StringFind(temp_name,'CORP.',1)!=0 OR
			StringLib.StringFind(temp_name,' CORP ',1)!=0 OR
			StringLib.StringFind(temp_name,' CITY  ',1)!= 0 OR
			StringLib.StringFind(temp_name,' STATE ',1)!= 0 OR
			StringLib.StringFind(temp_name,' PROVINCE ',1)!= 0 OR
			StringLib.StringFind(temp_name,'LIQUOR ',1)!=0 OR
		  
		  StringLib.StringFind(temp_name,' OFFICE ',1)!=0 OR
		  StringLib.StringFind(temp_name,' DELI ',1)!=0 OR
		  StringLib.StringFind(temp_name,' MOTEL ',1)!=0 OR
		  StringLib.StringFind(temp_name,' INN ',1)!=0 OR
		  StringLib.StringFind(temp_name,' USA ',1)!=0 OR
		  StringLib.StringFind(temp_name,' SCHOOL ',1)!=0 OR
		  StringLib.StringFind(temp_name,' DISTRICT ',1)!=0 OR
		  StringLib.StringFind(temp_name,'ORGANIZATION',1)!=0 OR
		  StringLib.StringFind(temp_name,'ORGANISATION',1)!=0 OR
		  
		  StringLib.StringFind(temp_name,' DBA ',1)!=0 OR
		  StringLib.StringFind(temp_name,' D/B/A ',1)!=0 OR
		  StringLib.StringFind(temp_name,' FEDERAL ',1)!=0 OR
		  StringLib.StringFind(temp_name,' UNIVERSITY',1)!=0 OR
      //StringLib.StringFind(temp_name,' PORT ',1)!=0 OR
			( StringLib.StringFind(temp_name,' PORT ',1)!=0 and StringLib.StringFind(temp_name,',',1)=0)OR
		  ( StringLib.StringFind(temp_name,' PORT ',1)!=0 and StringLib.StringFind(trim(temp_name),' ',5)> 0) OR
			( StringLib.StringFind(temp_name,' PARK ',1)!=0 and StringLib.StringFind(temp_name,',',1)=0)OR
		  ( StringLib.StringFind(temp_name,' PARK ',1)!=0 and StringLib.StringFind(trim(temp_name),' ',5)> 0) OR
		  StringLib.StringFind(temp_name,' TRAINING',1)!=0 OR
		  //StringLib.StringFind(temp_name,' AMERICA ',1)!=0 OR
      //StringLib.StringFind(temp_name,' CABLE',1)!=0 OR
			( StringLib.StringFind(temp_name,'CABLE',1)!=0 and StringLib.StringFind(temp_name,',',1)=0)OR
		  ( StringLib.StringFind(temp_name,'CABLE',1)!=0 and StringLib.StringFind(trim(temp_name),' ',5)> 0) OR
		  
			StringLib.StringFind(temp_name,' WATERPROOFING',1)!=0 OR
			StringLib.StringFind(temp_name,' TOWING',1)!=0 OR
			StringLib.StringFind(temp_name,' LIVING ',1)!=0 OR
			StringLib.StringFind(temp_name,' FAMILY',1)!=0 OR
			StringLib.StringFind(temp_name,' AUTO ',1)!=0 OR
			StringLib.StringFind(temp_name,' WELDING',1)!=0 OR
			StringLib.StringFind(temp_name,' LEGISTICS',1)!=0 OR
			StringLib.StringFind(temp_name,' SALVAGE',1)!=0 OR 
			StringLib.StringFind(temp_name,' HEATING ',1)!=0 OR 
		  
			StringLib.StringFind(temp_name,' SPECIALTIES ',1) !=0 OR  
			StringLib.StringFind(temp_name,'PONTOONS ',1)!=0 OR 
			StringLib.StringFind(temp_name,'RECREATION',1)!=0 OR 		  
			StringLib.StringFind(temp_name,' CAMPGRO ',1)!=0 OR 	
			StringLib.StringFind(temp_name,' AFB ',1)!=0 OR 
			StringLib.StringFind(temp_name,' CREEK ',1)!=0 OR                    
			StringLib.StringFind(temp_name,' INCORP',1)!=0 OR
			StringLib.StringFind(temp_name,'ACADEMY ',1)!=0 OR
			StringLib.StringFind(temp_name,' ACADEMY$',1)!=0 OR
			StringLib.StringFind(temp_name,'ACCOUNTING',1) != 0 OR
			StringLib.StringFind(temp_name,'AFFORDABLE',1) != 0 OR
			StringLib.StringFind(temp_name,' ATTORNEYS',1) != 0 OR
			StringLib.StringFind(temp_name,'AUTORAMA',1) != 0 OR
			StringLib.StringFind(temp_name,' BOAT ',1) != 0 OR
			StringLib.StringFind(temp_name,' BOATS ',1) != 0 OR
      // StringLib.StringFind(temp_name,' MARINA ',1) != 0 OR
			StringLib.StringFind(temp_name,' SPORTSMAN',1) != 0 OR
			StringLib.StringFind(temp_name,'RECREATION ',1) != 0 OR
			StringLib.StringFind(temp_name,'WATERCRAFT',1) != 0 OR
			StringLib.StringFind(temp_name,'WATERSPORT',1) != 0 OR			
		
			StringLib.StringFind(temp_name,'BOUTIQUE',1) != 0 OR
			StringLib.StringFind(temp_name,' BROKERS',1) != 0 OR
			//StringLib.StringFind(temp_name,'BUREAU ',1) != 0 OR
			( StringLib.StringFind(temp_name,'BUREAU ',1)!=0 and StringLib.StringFind(temp_name,',',1)=0)OR
		  ( StringLib.StringFind(temp_name,'BUREAU ',1)!=0 and StringLib.StringFind(trim(temp_name),' ',5)> 0) OR
		  
			StringLib.StringFind(temp_name,'CABLEVISION',1) != 0 OR
			//StringLib.StringFind(temp_name,' CHAPTER ',1) != 0 OR
			( StringLib.StringFind(temp_name,' CHAPTER ',1)!=0 and StringLib.StringFind(temp_name,',',1)=0)OR
		  ( StringLib.StringFind(temp_name,' CHAPTER ',1)!=0 and StringLib.StringFind(trim(temp_name),' ',5)> 0) OR
		  
			StringLib.StringFind(temp_name,'CHARITIES',1) != 0 OR
			
			StringLib.StringFind(temp_name,'CITIBANK',1) != 0 OR
			StringLib.StringFind(temp_name,'CITIGROUP',1) != 0 OR
			StringLib.StringFind(temp_name,'COLLECT',1) != 0 OR
			StringLib.StringFind(temp_name,'COMMERCE',1) != 0 OR
			StringLib.StringFind(temp_name,'COMMUNICATION',1) != 0 OR
			StringLib.StringFind(temp_name,'COMMUNITY',1) != 0 OR
			StringLib.StringFind(temp_name,'COMPANY',1) != 0 OR
			StringLib.StringFind(temp_name,'COMPUTER',1) != 0 OR
			StringLib.StringFind(temp_name,'CONSUMER ',1) != 0 OR
			StringLib.StringFind(temp_name,'COURT ORDER',1) != 0 OR
			StringLib.StringFind(temp_name,' DEVELOPERS ',1) != 0 OR
			StringLib.StringFind(temp_name,' DIST ',1) != 0 OR
			StringLib.StringFind(temp_name,'DISTRIBUTI',1) != 0 OR
			StringLib.StringFind(temp_name,' ESQS ',1) != 0 OR
			StringLib.StringFind(temp_name,' ESQS. ',1) != 0 OR
			StringLib.StringFind(temp_name,' FSB',1) != 0 OR
			//StringLib.StringFind(temp_name,'FARM ',1) != 0 OR
			( StringLib.StringFind(temp_name,' FARM ',1)!=0 and StringLib.StringFind(temp_name,',',1)=0)OR
		  ( StringLib.StringFind(temp_name,' FARM ',1)!=0 and StringLib.StringFind(trim(temp_name),' ',5)> 0) OR
		  
			StringLib.StringFind(temp_name,'FOUNDATION',1) != 0 OR 
			StringLib.StringFind(temp_name,' GROCERY ',1) != 0 OR
			StringLib.StringFind(temp_name,' GYM ',1) != 0 OR
			StringLib.StringFind(temp_name,' HEALTH ',1) != 0 OR
			StringLib.StringFind(temp_name,' HOTEL',1) != 0 OR
			StringLib.StringFind(temp_name,'IMPROVEMENT',1) != 0 OR
			StringLib.StringFind(temp_name,'IN US CURRENCY', 1) != 0 OR
			StringLib.StringFind(temp_name,'INTEREST',1) != 0 OR
			StringLib.StringFind(temp_name,'INVESTMENT',1) != 0 OR
			StringLib.StringFind(temp_name,'JPMORGAN ',1) != 0 OR
			StringLib.StringFind(temp_name,'LABORATORIES',1) != 0 OR
			StringLib.StringFind(temp_name,'LAUNDROMAT',1) != 0 OR
			StringLib.StringFind(temp_name,' LAWYERS ',1) != 0 OR
			//StringLib.StringFind(temp_name,' LEAGUE ',1) != 0 OR
			
			StringLib.StringFind(temp_name,'LIBRARY',1) != 0 OR
			StringLib.StringFind(temp_name,'LIMITED',1) != 0 OR
			StringLib.StringFind(temp_name,' LIQUOR ',1) != 0 OR
		//	StringLib.StringFind(temp_name,'LOGGING',1) != 0 OR
			StringLib.StringFind(temp_name,' MEDICAL ',1) != 0 OR
			StringLib.StringFind(temp_name,'MGMT',1) != 0 OR
			StringLib.StringFind(temp_name,'MUSEUM',1) != 0 OR
			StringLib.StringFind(temp_name,'NATIONSBANK',1) != 0 OR
			StringLib.StringFind(temp_name,'NCNB',1) != 0 OR
			StringLib.StringFind(temp_name,'OPTHAMOLOG',1) != 0 OR
			StringLib.StringFind(temp_name,'OPHTHAMOLOG',1) != 0 OR
			StringLib.StringFind(temp_name,'PETROLEUM',1) != 0 OR
			StringLib.StringFind(temp_name,'PHOTOGRAPHIC',1) != 0 OR
			StringLib.StringFind(temp_name,'PLANNED',1) != 0 OR
			StringLib.StringFind(temp_name,' PLASTIC ',1) != 0 OR
			//StringLib.StringFind(temp_name,' PLAZA',1) != 0 OR
			StringLib.StringFind(temp_name,'PNC ',1) != 0 OR
			StringLib.StringFind(temp_name,' POLICE ',1) != 0 OR
			StringLib.StringFind(temp_name,'PUBLICATIONS',1) != 0 OR
			StringLib.StringFind(temp_name,' QUARTER ',1) != 0 OR
			StringLib.StringFind(temp_name,' RAILWAY',1) != 0 OR
			StringLib.StringFind(temp_name,'REALTORS',1) != 0 OR
			StringLib.StringFind(temp_name,'REMODELING',1) != 0 OR
			StringLib.StringFind(temp_name,'REPUBLIC ',1) != 0 OR
			StringLib.StringFind(temp_name,'RESIDENTIAL',1) != 0 OR
			StringLib.StringFind(temp_name,'RESOURCES',1) != 0 OR
			StringLib.StringFind(temp_name,' RETAIL',1) != 0 OR
			StringLib.StringFind(temp_name,'RETIREMENT',1) != 0 OR
			StringLib.StringFind(temp_name,'SAVINGS',1) != 0 OR
			StringLib.StringFind(temp_name,'SERVICES',1) != 0 OR			
			StringLib.StringFind(temp_name,'SOCIETY',1) != 0 OR
			StringLib.StringFind(temp_name,'TELEPHON',1) != 0 OR
			//StringLib.StringFind(temp_name,'TRAVEL ',1) != 0 OR
			StringLib.StringFind(temp_name,'UNITED ',1) != 0 OR                  
			StringLib.StringFind(temp_name,' UNIV ',1) != 0 OR
			StringLib.StringFind(temp_name,'UNIVERSAL',1) != 0 OR			
			StringLib.StringFind(temp_name,'UNVERSITY',1) != 0 OR
			StringLib.StringFind(temp_name,'VOCATIONAL',1) != 0 OR			
			StringLib.StringFind(temp_name,' WARRANTY ',1) != 0 OR			
			StringLib.StringFind(temp_name,'WIRELESS',1) != 0 OR	
			StringLib.StringFind(temp_name,'OPTOMETRISTS',1)!=0 OR
			StringLib.StringFind(temp_name,'PHOTOGRAPHY',1)!=0 OR	
			//StringLib.StringFind(temp_name,'RESCUE',1)!=0 OR
			StringLib.StringFind(temp_name,'SAILING ',1)!=0 OR		
			StringLib.StringFind(temp_name,'UTILITY',1)!=0 OR
			StringLib.StringFind(temp_name,'YACHT ',1)!=0 OR
			StringLib.StringFind(temp_name,'YACHT & RV',1)!=0 OR
//////////////////////////////////////////////////////////////////////////////////////////////
			StringLib.StringFind(temp_name,'BISHOP OF',1)!=0 OR
			StringLib.StringFind(temp_name,'CHURCH OF',1)!=0 OR
			StringLib.StringFind(temp_name,'CITY OF',1)!=0 OR
			StringLib.StringFind(temp_name,'TOWN OF',1)!=0 OR
			StringLib.StringFind(temp_name,' BEEP OF ',1) != 0 OR
			StringLib.StringFind(temp_name,' LAND RENT',1)!=0 OR
			StringLib.StringFind(temp_name,' P S C',1) != 0 OR
			StringLib.StringFind(temp_name,'DAY CARE',1) != 0 OR
			StringLib.StringFind(temp_name,' & SONS',1)!=0 OR
			StringLib.StringFind(temp_name,'REAL ESTATE',1) != 0 OR
			StringLib.StringFind(temp_name,'OF AMERICA',1) != 0 OR
			StringLib.StringFind(temp_name,'CHASE BANK',1) != 0 OR
			StringLib.StringFind(temp_name,'CAMP GROUND',1)!=0 OR 
			StringLib.StringFind(temp_name,'REC ASSN',1)!=0 OR
			StringLib.StringFind(temp_name,'COUNTY OF ',1)!= 0 OR	  	  
			StringLib.StringFind(temp_name,'STATE OF ',1)!= 0 OR	  	 
			StringLib.StringFind(temp_name,'PROVINCE OF ',1)!= 0 OR
			StringLib.StringFind(temp_name,'REVOCBL TR',1)!=0 OR
			StringLib.StringFind(temp_name,'REVOCBLE TR',1)!=0 OR
			StringLib.StringFind(temp_name,'REVOCABLE TR',1)!=0 OR
			StringLib.StringFind(temp_name,' FISH CAMP ',1)!=0 OR 
			StringLib.StringFind(temp_name,' REC ARE ',1)!=0 OR
			StringLib.StringFind(temp_name,' AND KNEE',1) != 0 OR
			StringLib.StringFind(temp_name,' AND SONS',1) != 0 OR
			StringLib.StringFind(temp_name,'CHURCH OF ',1) != 0 OR
			StringLib.StringFind(temp_name,'CRESTAR BANK',1) != 0 OR
			StringLib.StringFind(temp_name,'BANK N.A.',1) != 0  OR
			StringLib.StringFind(temp_name,'BANK NA',1) != 0 OR
			StringLib.StringFind(temp_name,', N.A.',1)!=0 OR
			StringLib.StringFind(temp_name,', N. A.',1)!=0 OR
			StringLib.StringFind(temp_name,',N.A.',1)!=0 OR
			StringLib.StringFind(temp_name,',N. A.',1)!=0 OR
			StringLib.StringFind(temp_name,' PSC ',1)!=0 OR
			StringLib.StringFind(temp_name,' P S C',1)!=0 OR
			StringLib.StringFind(temp_name,' F S B',1)!=0 OR
			StringLib.StringFind(temp_name,' U S A ',1)!=0 OR
			StringLib.StringFind(temp_name,' AND SONS',1)!=0 OR
			StringLib.StringFind(temp_name,'REVOLUTIONARY',1)!=0 OR
			StringLib.StringFind(temp_name,'PERFORMING ARTS',1) != 0 OR
			StringLib.StringFind(temp_name,'NATIONS BANK',1) != 0 OR
			StringLib.StringFind(temp_name,' NAT\'L ',1) != 0 OR
			StringLib.StringFind(temp_name,'NATURAL GAS',1) != 0 OR
			StringLib.StringFind(temp_name,'LAW FIRM',1) != 0 OR 
			StringLib.StringFind(temp_name,'LAW OFFICES',1) != 0 OR 
			StringLib.StringFind(temp_name,'1ST BANK',1)!=0 OR
			StringLib.StringFind(temp_name,'BANK OF',1)!=0 OR
			StringLib.StringFind(temp_name,'FIRST BANK',1)!=0 OR
			StringLib.StringFind(temp_name,'2ND BANK',1)!=0 OR
			StringLib.StringFind(temp_name,'SECOND BANK',1)!=0 OR
			StringLib.StringFind(temp_name,'HOME LIFE',1) != 0 OR
			StringLib.StringFind(temp_name,'FIDELITY BANK',1) != 0 OR
			StringLib.StringFind(temp_name,'CITIZENS BANK',1) != 0 OR
			StringLib.StringFind(temp_name,' REC PARK',1) != 0 OR
			StringLib.StringFind(temp_name,'CHASE MANHATTAN BANK',1) != 0 OR
			StringLib.StringFind(temp_name,'FLEET BANK',1) != 0 OR
			StringLib.StringFind(temp_name,'SECOND BANK',1) != 0 OR
			StringLib.StringFind(temp_name,'STATE BANK',1) != 0 OR
			StringLib.StringFind(temp_name,'STATE OF ',1) != 0 OR
			StringLib.StringFind(temp_name,'TRADE NAME',1) != 0 OR
			StringLib.StringFind(temp_name,'TIRE & RUBBER',1) != 0 OR
			    StringLib.StringFind(temp_name,' FAMILY TRU',1) != 0 OR
					StringLib.StringFind(temp_name,'UNITED STATES',1) != 0 OR
					StringLib.StringFind(temp_name,'WELLS FARGO',1) != 0 OR
					StringLib.StringFind(temp_name,'RESRCH&PRSRVTION',1)!=0 OR
					StringLib.StringFind(temp_name,'BALL BEARINGS',1) != 0 OR
					StringLib.StringFind(temp_name,'BANK ONE',1) != 0 OR
					StringLib.StringFind(temp_name,'WACHOVIA BANK',1) != 0 OR
					StringLib.StringFind(temp_name,'BANK,NA',1) != 0 OR
					StringLib.StringFind(temp_name,'MARLBOROUGH COUNTRY',1) != 0 OR
					stringLib.StringFind(temp_name,'MELLON BANK',1) != 0 OR
					StringLib.StringFind(temp_name,' U/A ',1)!=0 OR
					StringLib.StringFind(temp_name,' U/A/ ',1)!=0 OR
					StringLib.StringFind(temp_name,' U/A/D',1)!=0 OR
					StringLib.StringFind(temp_name,' U/A/D ',1)!=0 OR
					StringLib.StringFind(temp_name,' U/D ',1)!=0 OR
					StringLib.StringFind(temp_name,' U/D/T ',1)!=0 OR
					StringLib.StringFind(temp_name,' U/I OF',1)!=0 OR
					StringLib.StringFind(temp_name,' U/T/A ',1)!=0 OR
					StringLib.StringFind(temp_name,' U/T/D ',1)!=0 OR
					StringLib.StringFind(temp_name,' UAD ',1)!=0 OR
					StringLib.StringFind(temp_name,' & EQP ',1)!=0 OR
					StringLib.StringFind(temp_name,' & GRINDING',1)!=0 OR
					StringLib.StringFind(temp_name,'NATURES WAY AND TAXIDERMY',1)!=0 OR
					StringLib.StringFind(temp_name,'NEW YORK & NEW JERSEY',1)!=0 OR
					StringLib.StringFind(temp_name,'NURSE FINDERS',1)!=0 OR
					StringLib.StringFind(temp_name,'OPTOMETRISTS',1)!=0 OR
					StringLib.StringFind(temp_name,'P & J ENTERPRISES LLC',1)!=0 OR
					StringLib.StringFind(temp_name,'PACIFIC COUNC',1)!=0 OR
					StringLib.StringFind(temp_name,'PACIFIC COUNCIL',1)!=0 OR
					StringLib.StringFind(temp_name,'PAINT & DECOR',1)!=0 OR
					StringLib.StringFind(temp_name,'PAINT & WALLPAPER',1)!=0 OR
					StringLib.StringFind(temp_name,'PARENTS AND FRIENDS',1)!=0 OR
					StringLib.StringFind(temp_name,'PARK/MARINE',1)!=0 OR
					StringLib.StringFind(temp_name,'PARKING TICK',1)!=0 OR
					StringLib.StringFind(temp_name,'PARKS & LAND',1)!=0 OR
					StringLib.StringFind(temp_name,'PARKS & LANDS',1)!=0 OR
					StringLib.StringFind(temp_name,'PARKS & REC',1)!=0 OR
					StringLib.StringFind(temp_name,'PINAL COUNTY',1)!=0 OR
					StringLib.StringFind(temp_name,'PLUMBNG',1)!=0 OR
					StringLib.StringFind(temp_name,'PNTC LDS AND G',1)!=0 OR
					StringLib.StringFind(temp_name,'PORT OF ',1)!=0 OR
					StringLib.StringFind(temp_name,'PRENTICE HALL',1)!=0 OR 
					StringLib.StringFind(temp_name,'PK/MARINA',1)!=0 OR
					StringLib.StringFind(temp_name,'PLACID PRODUCTIO',1)!=0 OR
					StringLib.StringFind(temp_name,'PLEASANT VIEW',1)!=0 OR		
					StringLib.StringFind(temp_name,'PRODUCTS&SERVICE',1)!=0 OR
					StringLib.StringFind(temp_name,'PTRNSHP',1)!=0 OR
					StringLib.StringFind(temp_name,'PULP & PAPER',1)!=0 OR
					StringLib.StringFind(temp_name,'R & R INVESTMETS',1)!=0 OR
					StringLib.StringFind(temp_name,'REC ASSN',1)!=0 OR
					StringLib.StringFind(temp_name,'REED & REED',1)!=0 OR
					StringLib.StringFind(temp_name,'REFINING/DISTRIB',1)!=0 OR
					StringLib.StringFind(temp_name,'RENSSELAER AND POLYTECHNIC',1)!=0 OR			
					StringLib.StringFind(temp_name,'REV LIV TRS',1)!=0 OR
					StringLib.StringFind(temp_name,'REV LIV TRU',1)!=0 OR
					StringLib.StringFind(temp_name,'REV TR',1)!=0 OR
					StringLib.StringFind(temp_name,'REV TRS',1)!=0 OR
					StringLib.StringFind(temp_name,'REV TRST',1)!=0 OR
					StringLib.StringFind(temp_name,'REV TRT',1)!=0 OR
					StringLib.StringFind(temp_name,'REV TRU',1)!=0 OR
					StringLib.StringFind(temp_name,'REV TRUST',1)!=0 OR
					StringLib.StringFind(temp_name,'REV TST',1)!=0 OR
					StringLib.StringFind(temp_name,'REVISED TRU',1)!=0 OR
					StringLib.StringFind(temp_name,'REVOC LIVING',1)!=0 OR
					StringLib.StringFind(temp_name,'REVOC TST',1)!=0 OR
					StringLib.StringFind(temp_name,'REVOCALBE TR',1)!=0 OR
					StringLib.StringFind(temp_name,'REVOCALBE TRUS',1)!=0 OR
					StringLib.StringFind(temp_name,'RIVER BEND ',1)!=0 OR
					StringLib.StringFind(temp_name,'SAILING ',1)!=0 OR
					StringLib.StringFind(temp_name,'SAILING & YACHT',1)!=0 OR
					StringLib.StringFind(temp_name,'SAILS & RI',1)!=0 OR
					StringLib.StringFind(temp_name,'SAINT MARY AND CAPUCHIN ORDER',1)!=0 OR
					StringLib.StringFind(temp_name,'SALES&SERVICE',1)!=0 OR
					StringLib.StringFind(temp_name,'SALES&SRVCE',1)!=0 OR
					StringLib.StringFind(temp_name,'SALVATION ARMY',1)!=0 OR
					StringLib.StringFind(temp_name,'SAND & GRAVEL ',1)!=0 OR
					StringLib.StringFind(temp_name,'SAND AND GRAVEL',1)!=0 OR
					StringLib.StringFind(temp_name,'SARANACAND VLG',1)!=0 OR
					StringLib.StringFind(temp_name,'SCI & FORESTRY',1)!=0 OR
					StringLib.StringFind(temp_name,'SCIENCE&FORESTRY',1)!=0 OR
					StringLib.StringFind(temp_name,'SEARCH & RESCUE',1)!=0 OR
					StringLib.StringFind(temp_name,'SHORE AND JEEP EAGLE',1)!=0 OR
					StringLib.StringFind(temp_name,'SIGNS AND STUFF',1)!=0 OR
					StringLib.StringFind(temp_name,'SKANEATELES MRNA',1)!=0 OR
					StringLib.StringFind(temp_name,'STAIRWAY & MILLWORK',1)!=0 OR
					StringLib.StringFind(temp_name,'SUM OF $',1)!=0 OR
					StringLib.StringFind(temp_name,'THE HOUSE OF',1)!=0 OR
					StringLib.StringFind(temp_name,'THE SOUTHRN PART',1)!=0 OR 
					StringLib.StringFind(temp_name,'TIC SILVER CITY',1)!=0 OR
					StringLib.StringFind(temp_name,'TOWING & ROADSIDE',1)!=0 OR 
					StringLib.StringFind(temp_name,'TOWN&COUNTRY MOTORS',1)!=0 OR
					StringLib.StringFind(temp_name,'TRADE-WINDS AND ENVIRONMENTAL',1)!=0 OR
					StringLib.StringFind(temp_name,'TRIBES OF WARM SPRINGS',1)!=0 OR
					StringLib.StringFind(temp_name,'TRILER SVC',1)!=0 OR
					StringLib.StringFind(temp_name,'TTEES OF ',1)!=0 OR
					StringLib.StringFind(temp_name,'US ARMY',1)!=0 OR
					StringLib.StringFind(temp_name,'U S CURRENCY',1)!=0 OR
					StringLib.StringFind(temp_name,'U.S. CURRENCY',1)!=0 OR
					StringLib.StringFind(temp_name,'US $',1)!=0 OR
					StringLib.StringFind(temp_name,'US CURRENC',1)!=0 OR
					StringLib.StringFind(temp_name,'US CURRENCY',1)!=0 OR
					StringLib.StringFind(temp_name,'UTILITY',1)!=0 OR
					StringLib.StringFind(temp_name,'WALMART',1)!=0 OR
					StringLib.StringFind(temp_name,'WAL MART',1)!=0 OR
					StringLib.StringFind(temp_name,'WAL-MART',1)!=0 OR
					StringLib.StringFind(temp_name,'WARRANT #',1)!=0 OR
					StringLib.StringFind(temp_name,'WATER & LIGHT',1)!=0 OR
					StringLib.StringFind(temp_name,'WATER & SEWE ',1)!=0 OR
					StringLib.StringFind(temp_name,'WATER SHOWS',1)!=0 OR
					StringLib.StringFind(temp_name,'WATER/ELECTRIC',1)!=0 OR
					StringLib.StringFind(temp_name,'WOODS & WATERS',1)!=0 OR
					//StringLib.StringFind(temp_name,'YACHT ',1)!=0 OR
					StringLib.StringFind(temp_name,'YACHT & RV',1)!=0 OR
					StringLib.StringFind(temp_name,'BUSINESS',1)!=0 OR                                                               
          StringLib.StringFind(temp_name,'RENTACAR',1)!=0 OR  
					StringLib.StringFind(temp_name,'AMERICAN HERITAGE 18929',1)!=0 OR
					StringLib.StringFind(temp_name,'MERGED WITH PID',1)!=0 OR
					(StringLib.StringFind(temp_name,'SIMPLY',1)!=0 and StringLib.StringFind(temp_name,'FASHIONS',1)=0) OR
					(StringLib.StringFind(temp_name,'BUDGET',1)!=0 and StringLib.StringFind(temp_name,'RENT',1)=0) OR
					(StringLib.StringFind(temp_name,'WINN',1)!=0 and StringLib.StringFind(temp_name,'DIXIE',1)=0) OR
					(StringLib.StringFind(temp_name,'NATIONAL',1)!=0 and StringLib.StringFind(temp_name,'CAR',1)=0) OR
					StringLib.StringFind(temp_name,'MOVIES',1)!=0 OR
					StringLib.StringFind(temp_name,'NASIRS 1',1)!=0 OR
					StringLib.StringFind(temp_name,'CENTEX HOMES',1)!=0 OR
					StringLib.StringFind(temp_name,'ENTERPRISE',1)!=0 OR
					StringLib.StringFind(temp_name,'AMERICAN LEGION',1)!=0 OR
					StringLib.StringFind(temp_name,'JEFFERSON POINT',1)!=0 OR
					StringLib.StringFind(temp_name,'HERMITAGE CENTRE',1)!=0 OR
					StringLib.StringFind(temp_name,'BURGER KING',1)!=0 OR
					StringLib.StringFind(temp_name,'CHECKERS',1)!=0 OR
					StringLib.StringFind(temp_name,'CHECKERS',1)!=0 OR
					StringLib.StringFind(temp_name,'TRANSFERRED',1)!=0 OR
					StringLib.StringFind(temp_name,'SYSTEM, 99',1)!=0 OR
					StringLib.StringFind(temp_name,'CORP, 4M4',1)!=0 OR
					StringLib.StringFind(temp_name,'US HOME',1)!=0 OR
					StringLib.StringFind(temp_name,'RENT 4 LESS',1)!=0 OR
					StringLib.StringFind(temp_name,'TACO BELL',1)!=0 OR
					StringLib.StringFind(temp_name,'NON-DISCLOSURE',1)!=0 OR
					StringLib.StringFind(temp_name,'SUAREZ HOUSING',1)!=0 OR
					StringLib.StringFind(temp_name,'APARTMENTS',1)!=0 OR
					StringLib.StringFind(temp_name,'SUNTRUST BANK',1)!=0 OR
					StringLib.StringFind(temp_name,'HOUSING CORP',1)!=0 OR
					StringLib.StringFind(temp_name,'BIG, 4 RENTS',1)!=0 OR
					StringLib.StringFind(temp_name,'BOSTON MARKET',1)!=0 OR   
					StringLib.StringFind(temp_name,'CARS 4 CAUSES',1)!=0 OR  
					StringLib.StringFind(temp_name,'EZ 2 RENT A CAR',1)!=0 OR                                                                                                     
					StringLib.StringFind(temp_name,'NATIONS BANK',1)!=0 OR                                                                                          
					StringLib.StringFind(temp_name,'PIZZA HUT',1)!=0 OR                                                                                                       
					StringLib.StringFind(temp_name,'PLANTATION KEY APTS',1)!=0 OR                                                                                            
					StringLib.StringFind(temp_name,'SEMI-TRAILER',1)!=0 OR                                                                       
					StringLib.StringFind(temp_name,'MORRISON HOMES',1)!=0 OR                                                                                        
					StringLib.StringFind(temp_name,'GRAND JURY DATA 1990 ',1)!=0 OR                                                                                               
					StringLib.StringFind(temp_name,'MERCEDES HOMES INC',1)!=0 OR                                                                                             
					StringLib.StringFind(temp_name,'CARMAX',1)!=0 OR                                                                                                         
					StringLib.StringFind(temp_name,'CARPETS 4 YOU',1)!=0 OR                                                                                                       
					StringLib.StringFind(temp_name,'CARS 4 CAUSES',1)!=0 OR                                                                                                       
					StringLib.StringFind(temp_name,'BIG 5 SPORTING GOODS',1)!=0 OR                                                                          
					StringLib.StringFind(temp_name,'CASH 4 CARS',1)!=0 OR                                                                                                         
          StringLib.StringFind(temp_name,'SEALED',1)!=0 OR 
					StringLib.StringFind(temp_name,'PAYLESS SHOE',1)!=0 OR                                                                                           
					StringLib.StringFind(temp_name,'PACIFIC 9 LINES',1)!=0 OR    
					StringLib.StringFind(temp_name,'ORDERS,',1)!=0 OR
    
/////////////////////////////////////////////////////////////////////////////////////////////////	
					regexfind('( WORLD$|^WORLD |^U OF |,PC$|^NAT L |^GROUP | GROUP$| FNB$|,FNB$|^FIRE | FIRE$| CHURCH$|^SKIFFS | SKIFFS |^OUTBOARD | OUTBOARD |MAY, [0-9]+|JUNE, [0-9]+|MARCH, [0-9]+|'+
	' OUTFITTER|OUTFITTERS |^OUTFITTER|^OUTFITTERS|^MUTUAL | MUTUAL |ADVENTURES|EXPEDITION|EXCURSION|EXTINGUISHER|JANUARY, [0-9]+|DECEMBER, [0-9]+|JULY, [0-9]+|'+
	'^PERFORMANCE | PERFORMANCE | PROFITEERS |RIVER BEND |RIVERBEND | FACILITY |^FACILITY |UNKNOWN, [0-9]+|NOVEMBER, [0-9]+|OCTOBER, [0-9]+|MAY, [0-9]+|MARCH, [0-9]+|'+
	'^MARINE |^IMPORT | IMPORT|^IMPORTS |[WEEKLY]+ HOMES|[SKINNER[S]* NURSERY| IMPORTS|^[1-9][ ]*|^[A-Z]{3}[ -]*[0-9]{2}[A-Z]$| ^FIRST |^SECOND |^THIRD )',temp_name) //or 				
					          //StringLib.StringFind(temp_name,' THE ',1)!=0 
					          , 'Y' , ' ');
                                                                                                                        
                                                                                                           
                                                                               

				return  if(trim(v_bus_name_flag,left,right)='',0 , 1);
			end;
/*					regexfind('(FIRM$| INC$| WORLD$|^WORLD |BUREAU$|^U OF |^UNIV |^TOWN |^SECOND| SALES$|'+ 
				'^PARTNERS | PC$|,PC$|^NAT L |^NATL | MOTEL$|^MEDICAL | LP$| MARKET$|'+
				'^LANDFILL | LANDFILL$| INN$| HUNTING$| HEALTH$| GYM$|^GROUP | GROUP$| GAZETTE$|'+
				' FLYING$| FNB$|,FNB$|^FIRE | FIRE$|^FIRST |^CITY | CHURCH$| CHAPTER$|^CHAPTER |'+
				' CENTER$|^CENTER |BUREAU$|^BOAT |^BOATS |^YACHTS |,INC$|'+
				' INC$|^SEA | SEA | FUND |^SKIFFS | SKIFFS |^OUTBOARD | OUTBOARD |^LAKE |'+
				' LAKE |^PARK |^[1-9]|^FIRST|^SECOND|^THIRD|^CREDIT |^FNB |'+
				'^ADVENTURES | ^ISLAND |^ISLANDS|^SPORT |^SPORTS |^BROTHERS | OUTFITTER|OUTFITTERS |'+
				'^OUTFITTER|^OUTFITTERS|^MUTUAL | MUTUAL |ADVENTURES|EXPEDITION|EXCURSION|EXTINGUISHER|'+
				'^PERFORMANCE | PERFORMANCE | PROFITEERS |RIVER BEND |RIVERBEND | FACILITY |^FACILITY |'+
				'^MARINE | HARBOR |^IMPORT | IMPORT|^IMPORTS | IMPORTS| ISLAND| ISLANDS|'+  //MARINE |
				'^ISLAND|^ISLANDS|^CAMPGD |^CAMPGROUND|^AUTHORITY )',temp_name)*/

export fn_dateMMMDDYYYY(string pdate) := function
	findMonth 	:= MAP(regexfind('JAN',trim(StringLib.StringToUpperCase(pdate),left,right)[1..3],0)<>'' and regexfind('\\/', trim(pdate,left,right)[4],0)='' => '01',
							regexfind('FEB',trim(StringLib.StringToUpperCase(pdate),left,right)[1..3],0)<>'' and regexfind('\\/', trim(pdate,left,right)[4],0)='' => '02',
							regexfind('MAR',trim(StringLib.StringToUpperCase(pdate),left,right)[1..3],0)<>'' and regexfind('\\/', trim(pdate,left,right)[4],0)='' => '03',
							regexfind('APR',trim(StringLib.StringToUpperCase(pdate),left,right)[1..3],0)<>'' and regexfind('\\/', trim(pdate,left,right)[4],0)='' => '04',
							regexfind('MAY',trim(StringLib.StringToUpperCase(pdate),left,right)[1..3],0)<>'' and regexfind('\\/', trim(pdate,left,right)[4],0)='' => '05',
							regexfind('JUN',trim(StringLib.StringToUpperCase(pdate),left,right)[1..3],0)<>'' and regexfind('\\/', trim(pdate,left,right)[4],0)='' => '06',
							regexfind('JUL',trim(StringLib.StringToUpperCase(pdate),left,right)[1..3],0)<>'' and regexfind('\\/', trim(pdate,left,right)[4],0)='' => '07',
							regexfind('AUG',trim(StringLib.StringToUpperCase(pdate),left,right)[1..3],0)<>'' and regexfind('\\/', trim(pdate,left,right)[4],0)='' => '08',
							regexfind('SEP',trim(StringLib.StringToUpperCase(pdate),left,right)[1..3],0)<>'' and regexfind('\\/', trim(pdate,left,right)[4],0)='' => '09',
							regexfind('OCT',trim(StringLib.StringToUpperCase(pdate),left,right)[1..3],0)<>'' and regexfind('\\/', trim(pdate,left,right)[4],0)='' => '10',
							regexfind('NOV',trim(StringLib.StringToUpperCase(pdate),left,right)[1..3],0)<>'' and regexfind('\\/', trim(pdate,left,right)[4],0)='' => '11',
							regexfind('DEC',trim(StringLib.StringToUpperCase(pdate),left,right)[1..3],0)<>'' and regexfind('\\/', trim(pdate,left,right)[4],0)='' => '12',
							regexfind('JAN',trim(StringLib.StringToUpperCase(pdate),left,right)[5..7],0)<>'' and regexfind('\\/', trim(pdate,left,right)[4],0)<>'' => '01',
							regexfind('FEB',trim(StringLib.StringToUpperCase(pdate),left,right)[5..7],0)<>'' and regexfind('\\/', trim(pdate,left,right)[4],0)<>'' => '02',
							regexfind('MAR',trim(StringLib.StringToUpperCase(pdate),left,right)[5..7],0)<>'' and regexfind('\\/', trim(pdate,left,right)[4],0)<>'' => '03',
							regexfind('APR',trim(StringLib.StringToUpperCase(pdate),left,right)[5..7],0)<>'' and regexfind('\\/', trim(pdate,left,right)[4],0)<>'' => '04',
							regexfind('MAY',trim(StringLib.StringToUpperCase(pdate),left,right)[5..7],0)<>'' and regexfind('\\/', trim(pdate,left,right)[4],0)<>'' => '05',
							regexfind('JUN',trim(StringLib.StringToUpperCase(pdate),left,right)[5..7],0)<>'' and regexfind('\\/', trim(pdate,left,right)[4],0)<>'' => '06',
							regexfind('JUL',trim(StringLib.StringToUpperCase(pdate),left,right)[5..7],0)<>'' and regexfind('\\/', trim(pdate,left,right)[4],0)<>'' => '07',
							regexfind('AUG',trim(StringLib.StringToUpperCase(pdate),left,right)[5..7],0)<>'' and regexfind('\\/', trim(pdate,left,right)[4],0)<>'' => '08',
							regexfind('SEP',trim(StringLib.StringToUpperCase(pdate),left,right)[5..7],0)<>'' and regexfind('\\/', trim(pdate,left,right)[4],0)<>'' => '09',
							regexfind('OCT',trim(StringLib.StringToUpperCase(pdate),left,right)[5..7],0)<>'' and regexfind('\\/', trim(pdate,left,right)[4],0)<>'' => '10',
							regexfind('NOV',trim(StringLib.StringToUpperCase(pdate),left,right)[5..7],0)<>'' and regexfind('\\/', trim(pdate,left,right)[4],0)<>'' => '11',
							regexfind('DEC',trim(StringLib.StringToUpperCase(pdate),left,right)[5..7],0)<>'' and regexfind('\\/', trim(pdate,left,right)[4],0)<>'' => '12',
						'');

	findDay		:= if(length(trim(pdate[stringlib.stringfind(pdate, ' ', 1)..stringlib.stringfind(pdate, ',', 1)-1], left, right))=1,
					'0'+trim(pdate[stringlib.stringfind(pdate, ' ', 1)..stringlib.stringfind(pdate, ',', 1)-1], left, right),
					if(length(trim(pdate[stringlib.stringfind(pdate, ' ', 1)..stringlib.stringfind(pdate, ',', 1)-1], left, right))=2,
						trim(pdate[stringlib.stringfind(pdate, ' ', 1)..stringlib.stringfind(pdate, ',', 1)-1], left, right),
					''));
					
	findYear	:= if(length(trim(pdate[length(pdate)-3..length(pdate)], left, right))=4 and trim(pdate[length(pdate)-3..length(pdate)-2], left, right) in ['19', '20'],
						trim(pdate[length(pdate)-3..length(pdate)], left, right),
					'');
						
	return findYear+findMonth+findDay;
end;

export fn_Validate_date(string pdate) := function
  
	pyear := (integer)pdate[1..4];
	pmonth:= (integer)pdate[5..6];
	pday := (integer)pdate[7..8];
	
  stddate := MAP(pyear >1900 and pmonth in [1,3,5,7,8,10,12] and pday <= 31 => pdate,
                 pyear >1900 and pmonth in [4,6,9,11] and pday <= 30 => pdate,
								 pyear >1900 and pmonth in [2] and pday <= 29 => pdate,								 
							'');
return stddate;
end;

export clean_case_number (string p_case_number) := function //Clean casenumbers to facilitate search.

counts_regex_str1 := '(.*)[( -/]C[N]*T[S]*.[XV/I,. &,#0-9]+[) ]*$';
counts_regex_str2 := '^(.*)[ (]CTS.[ ]*[IVX,0-9]+[ ]*[-][ ]*[IVX0-9]+[) ]*$';
counts_regex_str3 := '(.*)[ (/]*[0-9 ]+CT[S]*.[) ]*$';
chrgs_regex_str1  := '(.*)[ ]*[(][0-9 ]+CHGS.[) ]*$';
counts_regex_str4 := '^(.*)[ (]COUNT[ ]*[0-9]+[) ]*$';
Prob_regex_str1   := '(.*)[( ]*PROB.[ ]*(.*)[ ]*$';
Prob_regex_str2   :='(.*)[- ]P.V.[ ]*$';
Prob_regex_str3   :='(.*)[- ]*PRO.*VIO[ ]*$';
EXT_regex_str1    := '^(.*)[, (]EXT.[ 0-9](.*)[) ]*$';
step1 := MAP( p_case_number[1..4] ='ARR:' => p_case_number[5..],
              regexfind(counts_regex_str3,p_case_number) =>regexreplace(counts_regex_str3,p_case_number,'$1') ,
              regexfind(counts_regex_str1,p_case_number) =>regexreplace(counts_regex_str1,p_case_number,'$1') ,
							regexfind(counts_regex_str2,p_case_number) =>regexreplace(counts_regex_str2,p_case_number,'$1') ,
							regexfind(counts_regex_str4,p_case_number) =>regexreplace(counts_regex_str4,p_case_number,'$1') ,
              regexfind(chrgs_regex_str1 ,p_case_number) =>regexreplace(chrgs_regex_str1 ,p_case_number,'$1') ,
              regexfind(Prob_regex_str1  ,p_case_number) =>regexreplace(Prob_regex_str1,p_case_number,'$1') ,
							regexfind(Prob_regex_str2  ,p_case_number) =>regexreplace(Prob_regex_str2,p_case_number,'$1') ,
							regexfind(Prob_regex_str3  ,p_case_number) =>regexreplace(Prob_regex_str3,p_case_number,'$1') ,
							regexfind(EXT_regex_str1   ,p_case_number) =>regexreplace(EXT_regex_str1,p_case_number,'$1') ,
							regexfind('(.*)[/( ]CLASS C FEL.[ ]*$',p_case_number) =>regexreplace('(.*)[/( ]CLASS C FEL.[ ]*$',p_case_number,'$1') ,
              regexfind('(.*)[( ]RED.[) ]*$',p_case_number) =>regexreplace('(.*)[( ]RED.[) ]*$',p_case_number,'$1') ,
              
							p_case_number
						 );
clean_case_num := stringlib.stringfilter(stringlib.stringtouppercase(step1),'abcdefABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890');

//clean_case_num2 := unicodelib.unicodefilterout(clean_case_num,U'î' );

No_leading_Zero  := regexreplace('^[0]+(.*)',(string)clean_case_num,'$1');

return No_leading_Zero;
end; 

export strip_name_from_AKA(string name ,string plastname,string firstname,string Pmiddlename,string suffix) := function
 lastname   := MAP(regexfind('^(.*)[ ]*[(]AKA[:)][ ]*(.*)[ ]*$',plastname)=> regexreplace('^(.*)[ ]*[(]AKA[:)][ ]*(.*)[ ]*$',plastname,'$1'),
                   regexfind('^(.*)[ ]*[(]AKA (.*)[)]*[ ]*$',plastname)=> regexreplace('^(.*)[ ]*[(]AKA (.*)[)]*[ ]*$',plastname,'$1'),
                  ' '+ plastname); 
 middlename := MAP(regexfind('^[(]AKA[)][ ]*$',pmiddlename) => '',
                   regexfind('^[(]AKA (.*)[)][ ]*$',pmiddlename) => '',
									 regexfind('^[(]AKA(.*)[)] (.*)[ ]*$',pmiddlename) => '',
                   regexfind('^(.*)[ ]*[(]+AKA[: ](.*)[)][ ]*$',pmiddlename)=> regexreplace('^(.*)[ ]*[(]AKA[: ](.*)[)][ ]*$',pmiddlename,'$1'),
									 //regexfind('^(.*)[ (]+AKA (.*)[)][ ]*$',pmiddlename)=> regexreplace('^(.*)[ (]+AKA (.*)[)][ ]*$',pmiddlename,'$1'),
									 regexfind('^[(]AKA(.*)[ ]*$',pmiddlename)=> '',
									 regexfind('^(.*)[ (]+AKA (.*)[ ]*$',pmiddlename)=> regexreplace('^(.*)[ (]+AKA (.*)[ ]*$',pmiddlename,'$1'),
									 regexfind('^(.*)[ ]*[(]AKA[)][ ]*(.*)[ ]*$',pmiddlename)=> regexreplace('^(.*)[ ]*[(]AKA[)][ ]*(.*)[ ]*$',pmiddlename,'$1'),
									 
									 regexfind('^"AKA[ ]*(.*)"[ ]*$',pmiddlename)=> '',
									 regexfind('^(.*)[ ]*"AKA"[ ]*$',pmiddlename) => regexreplace('^(.*)[ ]*"AKA"[ ]*$',pmiddlename,'$1'),
									 
									 pmiddlename
                   );
 outname := MAP(regexfind('(.*)([": ,-;/]AKA[": ,-;/])(.*)([": ,-;/]AKA[": ,-;/](.*))+',name) => regexreplace('(.*)([": ,-;/]AKA[": ,-;/])(.*)([": ,-;/]AKA[": ,-;/](.*))+',name,'$1'),
	
	                 regexfind('(.*)([": ,-;/]AKA[": ,-;/])(.*)',lastname) and 
	                 regexfind('(.*)([": ,-;/]AKA[": ,-;/])(.*)',middlename) and 
	                 firstname <> ''  => trim(trim(regexreplace('(.*)([": ,-;/]AKA[": ,-;/])(.*)',lastname,'$1')) +', '+trim(firstname)+' '+trim(regexreplace('(.*)([": ,-;/]AKA[": ,-;/])(.*)',middlename,'$1'))+' '+trim(suffix),left,right),
	                 
	                 regexfind('(.*)([": ,-;/]AKA[": ,-;/])(.*)',lastname) and 
	                 firstname <> '' and middlename <> '' => trim(trim(regexreplace('(.*)([": ,-;/]AKA[": ,-;/])(.*)',lastname,'$1')) +', '+trim(firstname)+' '+trim(middlename)+' '+trim(suffix),left,right),
	                 regexfind('(.*)([": ,-;/]AKA[": ,-;/])(.*)',lastname) and 
	                 firstname <> '' and middlename = ''  => trim(trim(regexreplace('(.*)([": ,-;/]AKA[": ,-;/])(.*)',lastname,'$1')) +', '+trim(firstname)+' '+trim(suffix),left,right),
	                 regexfind('(.*)([": ,-;/]AKA[": ,-;/])(.*)',lastname) and 
	                 firstname = '' and middlename <> ''  => trim(trim(regexreplace('(.*)([": ,-;/]AKA[": ,-;/])(.*)',lastname,'$1')) +', '+trim(middlename)+' '+trim(suffix),left,right),
	                 
									 regexfind('(.*)[ ]*["]AKA(.*)',name) and  regexfind('["]AKA',pmiddlename) => trim(trim(lastname) +', '+trim(firstname)+' '+trim(middlename)+' '+trim(suffix),left,right),
									 regexfind('(.*)[ ]*[(]AKA(.*)',name) and  regexfind('[(]AKA',pmiddlename) => trim(trim(lastname) +', '+trim(firstname)+' '+trim(middlename)+' '+trim(suffix),left,right),
									 regexfind('(.*)[ ]*[(]AKA(.*)',name) and  regexfind('[(]AKA',plastname)   => trim(trim(lastname) +', '+trim(firstname)+' '+trim(middlename)+' '+trim(suffix),left,right),
									 regexfind('(.*)[ ]*[(]AKA (.*)[)][ ]*(.*)',name) => regexreplace('(.*)[ ]*[(]AKA (.*)[)][ ]*(.*)',name,'$1 $3') ,
									 regexfind('(.*)(- AKA[ ,-;/])(.*)',name) => regexreplace('(.*)(- AKA[ ,-;/])(.*)',name,'$1'),
	                 regexreplace('(.*)([": ,-;/]AKA[": ,-;/])(.*)',name,'$1')
									 );
	
	return outname;
end;

export strip_alias_from_AKA(string name ,string plastname,string firstname,string middlename,string suffix) := function

	lastname := ' '+ plastname; 		 
	alias:= MAP(     regexfind('^[(]AKA[)][ ]*$',middlename) => '',
                   regexfind('^[(]AKA (.*)[)][ ]*$',middlename) => '',
									 regexfind('^[(]AKA(.*)[)] (.*)[ ]*$',middlename) => '',
                   regexfind('^(.*)[ ]*[(]+AKA[: ](.*)[)][ ]*$',middlename)=> '',
									 regexfind('^[(]AKA(.*)[ ]*$',middlename)=> '',
									 regexfind('^(.*)[ (]+AKA (.*)[ ]*$',middlename)=> '',
									 regexfind('^(.*)[ ]*[(]AKA[)][ ]*(.*)[ ]*$',middlename)=> '',

                   regexfind('^"AKA[ ]*(.*)"[ ]*$',middlename)=> '',
									 regexfind('^(.*)[ ]*"AKA"[ ]*$',middlename) => '',
									 
									 regexfind('^(.*)[ ]*[(]AKA[:)][ ]*(.*)[ ]*$',plastname)=> '',
                   regexfind('^(.*)[ ]*[(]AKA (.*)[)]*[ ]*$',plastname)=> '',
									 
									 
	                 regexfind('(.*)[": ,-;/]AKA[": ,-;/][A-Z]+ [A-Z]+',lastname) => trim(regexreplace('(.*)([": ,-;/]AKA[": ,-;/])(.*)',lastname,'$3')),
	                 regexfind('(.*)[": ,-;/]AKA[": ,-;/](.*)[": ,-;/]AKA (.*)',lastname) => '',
	                 regexfind('(.*)([": ,-;/]AKA[": ,-;/])(.*)([": ,-;/]AKA[": ,-;/](.*))+',name) => '',
	                 regexfind('(.*)([": ,-;/]AKA[": ,-;/])(.*)',lastname) and 
	                 regexfind('(.*)([": ,-;/]AKA[": ,-;/])(.*)',middlename) and 
	                 firstname <> ''                         => trim(trim(regexreplace('(.*)([": ,-;/]AKA[": ,-;/])(.*)',lastname,'$3')) +', '+trim(firstname)+' '+trim(regexreplace('(.*)([": ,-;/]AKA[": ,-;/])(.*)',middlename,'$1'))+' '+trim(suffix),left,right),
	                 
	                 regexfind('(.*)([": ,-;/]AKA[": ,-;/])(.*)',lastname) and 
	                 firstname <> '' and  middlename <> '' => trim(trim(regexreplace('(.*)([": ,-;/]AKA[": ,-;/])(.*)',lastname,'$3')) +', '+trim(firstname)+' '+trim(middlename)+' '+trim(suffix),left,right),
	                 regexfind('(.*)([": ,-;/]AKA[": ,-;/])(.*)',lastname) and 
	                 firstname <> '' and middlename = ''  => trim(trim(regexreplace('(.*)([": ,-;/]AKA[": ,-;/])(.*)',lastname,'$3')) +', '+trim(firstname)+' '+trim(suffix),left,right),
	                 regexfind('(.*)([": ,-;/]AKA[": ,-;/])(.*)',lastname) and 
	                 firstname = '' and middlename <> ''  => trim(trim(regexreplace('(.*)([": ,-;/]AKA[": ,-;/])(.*)',lastname,'$3')) +', '+trim(middlename)+' '+trim(suffix),left,right),
	                 regexfind('(.*)[ ]*[(]AKA (.*)[)][ ]*(.*)',name) => '',
	                 regexfind('(.*)(- AKA[ ,-;/])(.*)',name) => regexreplace('(.*)([": ,-;/]AKA[": ,-;/])(.*)',name,'$3'),
									 
	                 regexreplace('(.*)([": ,-;/]AKA[": ,-;/])(.*)',name,'$3'));

	return alias;

end;

export fn_standarddize_race(string race) := function
  inputrace := stringlib.stringtouppercase(trim(race));
	
  stdrace := MAP(inputrace='A' => 'ASIAN/PACIFIC ISLAND',
                inputrace IN ['HAWAIIAN','HAWAIIN / PACIFIC IS','PACIFIC ISLAND (NOT','PACIFIC ISLANDR', 'AFGHANI','CAMBODIAN','JPN','[ASIAN OR AMERICAN NA','AMERASIAN','ASIAN/ORTL',
								'PACIFIC ISLANDER','NATIVE HAWAIIAN OR P','VIETNAMESE','KOREAN','MAURITIAN','PAKISTANI','OTHER PACIFIC ISLAND', 'VIETNAMESE CHINESE','PACIFIC ISLANDER/HAW',
 							  'FLIPINO','PHILLIPINO', 'ASIAN/CHINESE/JAPANE','ORIENTAL','ORNENTAL','PACIFIC ISLANDE','CHINESE','JAPANESE','OTHER ASIAN','FILIPINO','FILLIPINO',
                'THAI/TAI/SIAMESE','NATIVE HAWAIIAN OR OTHER PACIFIC ISLANDER','NATIVE HAWAIIAN OR PACIFIC ISLANDER','NATIVE HAWAIIAN/PACIFIC ISLANDER','PACIFIC ISLANDER/HAWAIIAN', 
                'CHINESE (NOT ELSEWHE','ASAIN','ASIAN (NOT FURTHER D','ASIAN INDIAN','ASIAN OR AMERICAN NA','ASIAN OR PACIFI','S ASIAN',
								'ASIAN OR PACIFIC ISLANDER','ASIAN PACIFIC ISLANDER','ASIAN/PACIFIC ISLANDER','HAWAIIN / PACIFIC ISLANDER',
                'ASIAN PACIFIC ISLAND','ASIAN, NATIVE HAWAII','ASIAN-PACIFIC-ISL','ASIAN/ORIENTAL','ORIENTAL/A','OTHER ASIAN!'] =>  'ASIAN/PACIFIC ISLAND',
								
								inputrace in ['B','BB','B]','BL','AF/AMERICAN','BK','GLACK','NIGERIAN','BLACK - AFRICAN AMERICAN','BLACK OR AFRICAN AMERICAN'] => 'BLACK',
								inputrace[1..3] IN ['AFR','BLA','BLC','BLK','BAL'] => 'BLACK',
								inputrace in ['HISP/BLACK'] => 'HISPANIC BLACK',
								inputrace      ='H' => 'HISPANIC',
								inputrace[1..3]IN ['HIS','MEX']=> 'HISPANIC',
								inputrace IN ['SPANISH OR HISPANIC','COSTA RICAN','CUBAN','COLOMBIAN','COLUMBIA','ECUADORIAN','BRAZILIAN','HISPANIC/LATIN/SPANISH','MEXICAN-LATIN AMERICAN'] => 'HISPANIC',
								inputrace[1..2]='LA' => 'HISPANIC',
								inputrace      ='L' => 'HISPANIC',								
								inputrace in ['INDIAN (AMERICAN)','INDIAN (NOT ELSEWHER','INDIAN (NOT FURTHER','INDIAN - NATIVE AMER','INDIAN OR ALASKAN NA','INDIAN-ALASKAN',                
								'AMER INDN','NATIVE INDIAN','AM. INDIAN','NATIVE AMER.','NAT AM/ALASKAN','NA INDIAN','INDAM','AMIND','I','AMER.IND.','AMER. IND','NATIVE AMERICAN',
								'AMERICAN NATIVE','AMERICAN INDIAN OR P','AMERICAN I','AMER. INDIAN OR ALAS','NATIV AMER','NATIVE A','NATIVE AM','NATIVE AMER/ALASKAN',
                'NATIVE AMERICAN OR A','NATIVE HAWAIIAN OR O','AMER-INDIAN','AMER INDIAN','AM INDIAN','ALASKAN NATIVE','NATIVE','AMERICAN IN','AMERICAN INDIAN, ALA',
								'INDIAN','INDIAN (NATIVE AMERI','AM. INDIAN/ALASKAN N','AM.INDIAN OR ALASKAN','AMER IND/ALASKAN NAT',
								'AMERICAN INDIAN','AMERICAN INDIAN/ESKI','AMERIND','AMINDIAN',
								'AM. INDIAN/ALASKAN NATIVE','AM.INDIAN OR ALASKAN NATIVE','AMER IND/ALASKAN NATIVE','AMERICAN INDIAN / ALASKAN','AMERICAN INDIAN / ALASKAN NATIVE',
                'AMERICAN INDIAN OR ALASKA NATIVE','AMERICAN INDIAN OR ALASKAN NATIVE','AMERICAN INDIAN OR AMERICAN NATIVE','AMERICAN INDIAN/ALASKA NATIVE',
                'AMERICAN INDIAN/ALASKAN','AMERICAN INDIAN/ALASKAN NATIVE','INDIAN - NATIVE AMER/ESKIMO','INDIAN (NATIVE AMERICAN)','INDIAN OR ALASKAN NATIVE',
                'NATIVE AMERICAN OR ALASKAN','NATIVE AMERICAN/ALASKAN NATIVE'] => 'AMER INDIAN/ALASKAN',	
								                                                                   
								inputrace='W' => 'WHITE',
								inputrace='C' => 'WHITE',
								inputrace in ['BI-RACIAL', 'MULTI-RACIAL OR OTHE','MULTI RACE','MULTI-RACIAL','MULTIRACIAL','MULTI-RACIAL OR OTHER'] => 'MIXED',
								inputrace[1..3]='WHI' => 'WHITE',
								inputrace in ['OTHER EUROPEAN (NOT','NEW ZEALAND EUROPEAN','IRISH','GERMAN','BRITISH (NOT ELSEWHE','ISRAEL','ISRAELI/JEWISH/HEBRE','ITALIAN',
								  'CAUCASIAN / WHITE','EUROPEAN/N.AM./AUSTR','FRENCH','W`','W/NH','WGHITE','WH ITE','WHI','WH','.W',']W','WW','WWHITE',';WHITE','W.','WGHITE','WH ITE','WHI',
								  'WHITE/S S A','WHITEE','WHITRE','WHITYE','WHIUTE','WHJITE','WHOITE','WHIT','WHIT E','WHITE','NORDIC/SCANDANAVIAN','NORWEGIAN',
									'WHT','WHTIE','WHYITE','WITE','WJITE','WM','WW','WWHITE','W\\H','WHI TE','WHIE','WHIRE',
									'ANGELO','ANGLO','AUSTRIAN','BELGIAN','WHITE (INCL HISPANICS)'] => 'WHITE',
									
                inputrace in ['ARAB','ARABIC','IRANIAN/PERSIAN'] => 'MIDDLE EASTERN',              
								inputrace='AMER INDIAN/ALASKAN' => 'AMER INDIAN/ALASKAN', 
								inputrace='AMERICAN INDIAN OR A' => 'AMER INDIAN/ALASKAN',
								inputrace='AMER IND' => 'AMER INDIAN/ALASKAN',            
								inputrace='AMER INDIAN/ALASKAN' => 'AMER INDIAN/ALASKAN', 
								inputrace='AMERICAN INDIAN' => 'AMER INDIAN/ALASKAN',     
								inputrace='AMERICAN INDIAN / AL' => 'AMER INDIAN/ALASKAN',
								inputrace='AMERICAN INDIAN OR A' => 'AMER INDIAN/ALASKAN',
								inputrace='AMERICAN INDIAN/ALAS' => 'AMER INDIAN/ALASKAN',
								inputrace='ASIAN' => 'ASIAN/PACIFIC ISLAND',
								inputrace='ASIAN OR PACIFIC ISL' => 'ASIAN/PACIFIC ISLAND',
								inputrace='ASIAN/PACIFIC ISLAND' => 'ASIAN/PACIFIC ISLAND',
								inputrace='ASIAN OR PACIFIC ISL' => 'ASIAN/PACIFIC ISLAND',
								inputrace='ASIAN/PAC.ISLD' => 'ASIAN/PACIFIC ISLAND',      
								inputrace='ASIAN/PACIFIC ISLAND' => 'ASIAN/PACIFIC ISLAND',
								inputrace='BLACK' => 'BLACK',
								inputrace='BLACK OR AFRICAN AME' => 'BLACK',
								inputrace='AFRICAN AMERICAN' => 'BLACK',
								inputrace in ['CAUCASION','CAUCASIAN','CAUCASIANCAUCASIAN','CAUSCASIAN'] => 'WHITE',
								inputrace='WHITE/CAUCASIAN' => 'WHITE',
								inputrace='[NO RACE CODE ENTERED]' => '',
								length(inputrace)>3 and regexfind('[0-9]',race,0)='' and 
								inputrace not in ['[NO RACE CODE ENTERE','TWIN)  (W','FDOA)  (W','ETHNICITY','* RACE *','*UNMATCHED CODE*','<BR>','F="DOCS/JA|IL_INSPE|','F="DOCS/JA|IL_INSPE|',
                   'DO NOT USE THIS RACE','BREAST, LEFT','BREAST, NONSPECIFIC','BREAST, RIGHT','BUTTOCK, RIGHT','FEMALE','CORPORATION','CHEEK (FACE), NONSPE', 
									 'RACE','MALE','OTHER OR UNKNOWN','NOT APPLICABLE','NOT AVAILABLE','NOT ENTERED','NOT FOUND','NOT SPECIFIED','OTHER (NOT ELSEWHERE',
                   'OTHER (NOT FURTHER D','UNAVAILABLE','UNKNOW','UNKNOWN, OTHER','HORSLEY, ISAAC NATHANIEL','HARBOR JUSTICE CENTER','OTHER (INCLUDES NOT',
								   'ALL OTHERS','OTHER','NULL','UNKWN','HIP, LEFT','HIP, RIGHT','NON-PERSON','NONE','ALL OTHERS/UNKNOWN','UNKNOWN','UNKNOWN,UNKNOWN','BUSINESS','MISSING','INACTIVE','UNASSIGNED',
									 'ACTIVE','PROTRUDING UPPER JAW','RIB(S), NONSPECIFIC','TOE(S), LEFT FOOT','NARCOTICS (HEROIN, M','NMN)  (W'] => inputrace,
							'');
return stdrace;

end;

export fn_standardize_haircolor(string haircolor) := function
  stdhair := map(
                 haircolor='B' => '',
								 haircolor='BLACK' => 'BLACK',
								 haircolor in ['WHT','WHITE','WHI','W','WHITE / LT'] => 'WHITE',
								 haircolor in ['TOTAL BALD','BLD','BAL','BALD','UNKOWN/BAL'] => 'BALD',
								 haircolor in ['BLK','BLA','BLC'] => 'BLACK',
								 haircolor in ['BLN','BLOND','BLO','BLONDE','BLND','LT BLOND','LT BLOND /'] => 'BLOND',
								 haircolor in ['BLN&STR','STRAWBERRY','BLONDE OR','BLOND, STR','BLOND/STRA','BLONDE/STR','BLOND OR S'] => 'BLOND OR STRAWBERRY',
		  					 haircolor='BLU' => 'BLUE',
								 haircolor='BLUE' => 'BLUE',
								 haircolor IN ['BROWN','BR0','BRO','BRN','BR','BROWN BROW'] => 'BROWN',
								 haircolor IN ['LBR'] => 'LIGHT BROWN',
								 haircolor IN ['DBR'] => 'DARK BROWN',
								 haircolor in ['GRAY','GRA'] => 'GRAY',
								 haircolor in ['GRAY / BLA','GRAY / BRO','GRAY / LT','GRAY / OTH','GRAY / RED','GRAY / WHI','GRAY AND B',     
                               'BLACK / WH','BLACK/GRAY','BL/G/SILVE','GRAY, ETC.','SLT&PEP','SALT & PEP','SALT AND P','SALT/PEPPR',
								               'PARTIAL GR','PARTIALLY','GRAY/PARTI','GRAY OR PA','BR/G/SILVE','GREY OR','GREY OR PA','GREY/PARTI',     
                               'GREYORPART','SLT/PEP','WHITE / GR'] => 'GRAY OR PARTIALLY GRAY',
								 haircolor in ['GRY','GREY'] => 'GRAY',
								 haircolor in ['GRN','GRE','GREEN'] => 'GREEN',
								 haircolor='H' => '',
								 haircolor in ['HAZ','HZL','HAZEL','HZL'] => 'HAZEL',
								 haircolor='LT BLOND' => 'LT BLOND',
								 haircolor in ['MUL','MULT','MIX','MIXED','MULTI-COLO','MULTICOLOR'] => 'MULTIPLE',
								 haircolor IN ['RED','RD'] => 'RED',
								 haircolor in ['RED, AUBUR','RED/AUBURN','RED OR AUB','AUB','AUBURN','RED&ABN','RED OR','RED/AUBU'] => 'RED OR AUBURN',
								 haircolor in ['SANDY','SDY','SND','SNY'] => 'SANDY',
								 haircolor in ['PNK','PINK']=> 'PINK',
								 haircolor<>'' and regexfind('[0-9]',haircolor) => '',
								 haircolor<>'' and length(trim(haircolor)) >3 and 
								 haircolor not in ['UNKOWN','NOT LISTED','NULL','HAIR','HAIRCOLOR','UNASSIGNED','*UNMATCHED','UNKNOWN',
								 'OTHER (INCLUDES NOT','UNKNOWN OR','OTHER','UNKNO' ]=>haircolor ,'');
return stdhair;

end;

export fn_standardize_eyecolor(string eyecolor) := function
  stdeye := map(eyecolor='1' => '',
								 eyecolor='2' => '',
								 eyecolor='BLACK' => 'BLACK',
								 eyecolor='BLK' => 'BLACK',
								 eyecolor='BLA' => 'BLACK',
								 eyecolor IN ['BLN','BLO','BLOND OR S','BLOND'] => '',
								 
								 eyecolor IN ['BLU','BLUE / BLU','BLUEB','BL;UE'] => 'BLUE',
								 eyecolor='BLUE' => 'BLUE',
								 eyecolor='BRN' => 'BROWN', 
								 eyecolor='BRO' => 'BROWN',
								 eyecolor IN ['BWORN','BRWON','BROWN / BR','BROWN','BORWN','BROW','BROWN /'] => 'BROWN',
								 eyecolor in ['GREEN','GREEM','GRN','GREEN / GR','GREEN / OT'] => 'GREEN',
								 eyecolor in ['GREY','GRAY','GRY','GRA','GRAY / OTH','GRAYOTHER'] => 'GRAY',
								 eyecolor in ['HAZ','HZL','HAZEL'] => 'HAZEL',
								 eyecolor in ['MULTI-COLO','MULTIPLE C','MULTICOLOR','MULTI','MULTIC','MULTICO'] => 'MIXED',
								 eyecolor in ['PNK','PINK']=> 'PINK',
								 eyecolor='RED' => 'RED',
								 eyecolor IN ['BURGUNDY','GREY OR PA','UNKNOWN','BALD','*UNMATCHED','ALBINO','ALBINO - R','BLONDE'] => '',
								 eyecolor<>'' and regexfind('[0-9]',eyecolor) => '',
								 eyecolor<>'' and length(trim(eyecolor)) >3 and 
								 eyecolor not in ['NOT REPORT','UNKNOWN OR','OTHER','UNKNO','UNASSIGNED','UNKNOW'] =>eyecolor ,
								 '');
								 
return stdeye;

end;

export fn_height_to_inches(string pheight) := function
	idx_quote  := MAP(stringlib.stringfind(stringlib.StringToUpperCase(pheight),'FT',1) > 0 => stringlib.stringfind(stringlib.StringToUpperCase(pheight),'FT',1),
	                  stringlib.stringfind(pheight,'"',1)
										);
	idx_inches := MAP(stringlib.stringfind(stringlib.StringToUpperCase(pheight),'FT',1) > 0 => idx_quote +1,
	                  stringlib.stringfind(stringlib.StringToUpperCase(pheight),'IN',1) > 0  => 1,
	                  stringlib.stringfind(pheight,'\'',1) >0 =>1,
										0);
	inches     := MAP(stringlib.stringfind(stringlib.StringToUpperCase(pheight),'FT',1) > 0 => (integer)pheight[1..1]*12 + (integer) stringlib.stringfilter(pheight[4..],'0123456789'),
	                 idx_quote<>0 or idx_inches<>0 => (integer)pheight[1..1]*12 + (integer) stringlib.stringfilter(pheight[3..],'0123456789'),
									 regexfind('[0-9]{3}',pheight)=> (integer)pheight[1..1]*12 + (integer) stringlib.stringfilter(pheight[3..],'0123456789'),
					0);	
	return if(inches>36 and inches<96, intformat(inches,3,1),'');
end;

export fn_persistent_offender_key(string5 pvendor, string ppty_nm, string pdob, string pdoc_num, string pid_num, 
                       string pdle_num, string pfbi_num,string pcase_number ,string pcase_filing_dt,string pcase_type) := function
// string  V_sysdate       := StringLib.GetDateYYYYMMDD(); 
		// integer V_sysYear       := (integer)V_sysdate[1..4];
		// integer V_age		        := (integer)age;
    //string  V_Year_of_birth := IF ( V_age < 5  or V_age > 110 , '' , (string) (V_sysYear - V_age));
		v_pty_nm                := StringLib.StringFilter(StringLib.StringToUpperCase(ppty_nm),'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); 
    v_P_key                 := (string)HASH64( v_pty_nm,pdob/*, L. height, L.weight, V_Year_of_birth */);
		
    v_doc_num               := StringLib.StringFilter(StringLib.StringToUpperCase(pdoc_num),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'); 
		v_id_num								:= StringLib.StringFilter(StringLib.StringToUpperCase(pid_num), '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ');
		v_dle_num								:= StringLib.StringFilter(StringLib.StringToUpperCase(pdle_num),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'); 
		v_fbi_num								:= StringLib.StringFilter(StringLib.StringToUpperCase(pfbi_num),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ');		                           
		
		v_def_num               := MAP( //L.vendor ='EL' and L.dle_num <> '' => L.dle_num,	//TX DOC removed as per Judy.
									                  //L.vendor ='DR' and L.dle_num <> '' => L.dle_num,	//KY DOC
									                  //pdoc_num[1..3]='000' and regexfind('[1-9]',pdoc_num) => trim(pdoc_num[4..],left,right),
																		// pid_num  <> ''       and regexfind('[1-9]',pid_num) => trim(pid_num,left,right),
									                  //pid_num[1..3]='000'  and regexfind('[1-9]',pid_num) => trim(pid_num[4..],left,right),
																		// pdle_num <> '' and regexfind('[1-9]',pdle_num) and
									                  // regexreplace('-',pdle_num,'') <> '' and 
									                  // regexreplace('-',pdle_num,'') <> '0' => trim(regexreplace('-',pdle_num,''),left,right),
																		// pfbi_num <> ''   => trim(pfbi_num,left,right),
                                    regexfind('[0-9]',v_doc_num) =>v_doc_num,
																		regexfind('[0-9]',v_id_num)  =>v_id_num,
																		regexfind('[0-9]',v_dle_num) =>v_dle_num,
																		regexfind('[0-9]',v_fbi_num) =>v_fbi_num,
									   ''  )	;
    vcase_filing_dt         := map(trim(pcase_filing_dt) ='19000101' => '',
                               trim(pcase_filing_dt)[1..2] between '19' and '20' and length(trim(pcase_filing_dt))>=4 
								               and pcase_filing_dt<=stringlib.GetDateYYYYMMDD() => trim(pcase_filing_dt),
								'');																			
		voffender_key           :=  MAP(trim(pvendor) = 'EA' =>  trim(pvendor)+v_P_key+trim(v_def_num)+trim(pcase_type)+trim(pcase_number,all)+trim(vcase_filing_dt),
		                                trim(pvendor)+v_P_key+trim(v_def_num)+trim(pcase_number,all)+trim(vcase_filing_dt)
		                                );

return voffender_key;

end;

export fn_offender_key(string5 pvendor, string precordid, string pcaseid, string pfileddate) := function
  cln_recordid := MAP(regexfind('DOCPAR',precordid) => 'H'+'R'+precordid[9..],
                      regexfind('DOCPRO',precordid) => 'H'+'B'+precordid[9..],
										  regexfind('DOCALT',precordid) => 'H'+'A'+precordid[9..],
										  regexfind('DOC',precordid)    => 'H'+'D'+precordid[6..],
											regexfind('PAR',precordid)    => 'H'+'R'+precordid[6..],
										'HD'+precordid
										);
										
	voffender_key:=trim(trim(trim(pvendor)+trim(cln_recordid)+IF(pcaseid<> '',pcaseid, ' '))+IF(length(trim(pfileddate,left,right))>=4 and trim(pfileddate,left)[1..2] in ['19','20'], pfileddate, ''));
	return voffender_key;
end;

export fn_choose_def_number (string2 pstatecode, string precordid, string pstateidnumber, string pdocnumber, string pinmatenumber) := function
cln_docnum := MAP( regexfind('[1-9]',pdocnumber) => pdocnumber,
    '');
cln_recordid := MAP(regexfind('DOCPAR',precordid) => precordid[9..],
                    regexfind('DOCPRO',precordid) => precordid[9..],
										regexfind('DOCALT',precordid) => precordid[9..],
										precordid[6..]
										);
cln_stateid  := MAP(pstateidnumber ='R000' => '',
                    pstateidnumber);
def_number := MAP( pstatecode = 'NJ' => cln_recordid,
                   pstatecode ='TX' and cln_stateid <> '' => cln_stateid,	
									 pstatecode ='KY' and cln_stateid <> '' => cln_stateid,	
									 cln_docnum[1..3]='000' and regexfind('[1-9]',cln_docnum) => cln_docnum[4..],
                   cln_docnum  <> ''      and regexfind('[1-9]',cln_docnum) => cln_docnum,
									 pinmatenumber[1..3]='000' and regexfind('[1-9]',pinmatenumber) => pinmatenumber[4..],
	                 pinmatenumber  <> ''      and regexfind('[1-9]',pinmatenumber) => pinmatenumber,
									 cln_stateid <> '' and  
									 regexfind('[1-9]',cln_stateid) and
									 regexreplace('-',cln_stateid,'') <> '' and 
									 regexreplace('-',cln_stateid,'') <> '0' => trim(regexreplace('-',cln_stateid,''),left,right),
									 cln_recordid
	                )	;
	return trim(def_number);
end;
export fn_offender_key_Alternate(string source, string IDS, string DOB) := function
  ls_source := regexreplace('DOC',
	             regexreplace('WA_DC_DOC',
	             regexreplace('DOC_PROB',
							 regexreplace('DOC_ALT',
	             regexreplace('DOC_PAROLE',source,'DR'),'DA'),'DB'),'DC_DO'),'DO');
	voffender_key:=trim('H'+trim(ls_source[1..2])+trim(ls_source[4..])+trim(IDS)+trim(DOB),all);
	return voffender_key;
end;

export fn_shorten_sourcename(string psourcename) := function
		result1 :=  
		      regexreplace('ARRESTS',
					regexreplace('COMMON_PLEAS',
					regexreplace('COMMON_PLEAS_COURT',
					regexreplace('COUNTY',
					regexreplace('DISTRICT_COURT',
					regexreplace('CIRCUIT_COURT[S]*',
					regexreplace('TRAFFIC_COURT',
					regexreplace('MUNICIPAL_COURT',
					regexreplace('MUNICIPAL_TRAFFIC_COURT',
					//regexreplace('BROWN_MUNICIPAL',	
					regexreplace('DEPARTMENT_OF_CORRECTIONS',
					regexreplace('DEPARTMENT_OF_CORRECTIONS_PROBATION',
					regexreplace('DEPARTMENT_OF_CORRECTIONS_PAROLE',	
					regexreplace('DEPARTMENT_OF_CORRECTIONS_ALTERNATE',
					regexreplace('DEPARTMENT_OF_CORRECTIONS_ALTERNATE_FILE',
					regexreplace('SUMMARY_COURTS',
					regexreplace('ADMINISTRATOR_OF_THE_COURTS',
					regexreplace('JUSTICE_OF_THE_PEACE_COURTS',
					regexreplace('SUPERIOR_COURT',
					regexreplace('JUSTICE_COURT',
					//regexreplace('WEBSITE',
					regexreplace('BOOKING',
					regexreplace('COUNTY_POLICE',
          regexreplace('COUNTY_SHERIFF', 
					regexreplace('SHERIFFS_OFFICE',
          regexreplace('POLICE_DEPARTMENT',
          regexreplace('SHERIFFS_DEPARTMENT',
					regexreplace('CURRENT_INMATES_LIST',
          regexreplace('DETENTION_CENTER',
					regexreplace('_CW',psourcename,''),'DTC'),'CIL'),'SD'),'PD'),'SO'),'CTY_SO'),'CTY_PD'),'BKN')/*,'WEB')*/,'JUSTICE'),'SPC'),'JPC'),'AOC'),'SC'),'DOC_ALT'),'DOC_ALT'),'DOC_PAROLE'),'DOC_PROB'),'DOC'),'MTC'),'MC'),'TC'),'CRC'),'DC'),'CTY'),'CPC'),'CPC'),'ARR');
			
					
	space_count := 
	if(stringlib.stringfind(psourcename,'NEW_YORK',1)<>0 or
	   stringlib.stringfind(psourcename,'NEW_JERSEY',1)<>0 or
		 stringlib.stringfind(psourcename,'NEW_HAMPSHIRE',1)<>0 or
	   stringlib.stringfind(psourcename,'WEST_VIRGINIA',1)<>0 or
	   stringlib.stringfind(psourcename,'NORTH_CAROLINA',1)<>0 or
	   stringlib.stringfind(psourcename,'SOUTH_CAROLINA',1)<>0 or
	   stringlib.stringfind(psourcename,'NORTH_DAKOTA',1)<>0 or
	   stringlib.stringfind(psourcename,'SOUTH_DAKOTA',1)<>0 or
		 stringlib.stringfind(psourcename,'RHODE_ISLAND',1)<>0 or
	   stringlib.stringfind(psourcename,'NEW_MEXICO',1)<>0 ,2, 1);
	state_end := MAP(stringlib.stringfind(psourcename,'DISTRICT_OF_COLUMBIA',1)<>0 => 20,                                                               
                   stringlib.stringfind(psourcename,'_',space_count)-1);
	
	state_name := regexreplace('_', psourcename[1..state_end], ' ');
	state_name2 := psourcename[1..state_end];
	state_abbrev := ut.st2abbrev(state_name);
	result2 := if(state_abbrev<>'', regexreplace(state_name2, result1, state_abbrev),result1);
	
	result3 := MAP(psourcename = 'ARIZONA_MARICOPA_COUNTY_GILBERT_MUNICIPAL_COURT'      => 'AZMARICOP_GILBRT_MC',
	               psourcename = 'CALIFORNIA_RIVERSIDE_COUNTY_CITY_OF_INDIO'            => 'CA_RIVERSIDE_INDIO',
								 psourcename = 'CALIFORNIA_SAN_BERNARDINO_COUNTY'                     => 'CA_SAN_BERNARDINOCTY',
								 psourcename = 'OHIO_ALLEN_COUNTY_LIMA_MUNICIPAL_COURT'               => 'OH_ALLEN_CTY_LIMA_MC',                                                               
								 psourcename = 'OHIO_SUMMIT_COUNTY_CUYAHOGA_FALLS_MUNICIPAL_COURT'    => 'OHSUMCUYAHOGA_FLS_MC',                                                    
								 psourcename = 'OHIO_MONTGOMERY_COUNTY_DAYTON_MUNICIPAL_COURT'        => 'OHMONTGOMRY_DAYTN_MC',                                                        
								 psourcename = 'OHIO_WARREN_COUNTY_MASON_MUNICIPAL_COURT'             => 'OH_WARREN_MASON_MC',                                                             
								 psourcename = 'OHIO_FRANKLIN_COUNTY_MUNICIPAL_COURT'                 => 'OH_FRANKLIN_CTY_MC',  
								 psourcename = 'OHIO_LAWRENCE_COUNTY_MUNICIPAL_COURT'                 => 'OH_LAWRENCE_CTY_MC',
								 psourcename = 'OHIO_GREENE_COUNTY_XENIA_MUNICIPAL_COURT'             => 'OH_GREENE_XENIA_MC',
								 psourcename = 'OHIO_SUMMIT_COUNTY_BARBERTON_MUNICIPAL_COURT'         => 'OH_SUMM_BARBERTON_MC',                                                         
								 psourcename = 'OHIO_ROSS_COUNTY_CHILLICOTHE_MUNICIPAL_COURT'         => 'OH_ROS_CHILICOTHE_MC',                                                         
								 psourcename = 'OHIO_CUYAHOGA_COUNTY_EUCLID_MUNICIPAL_COURT'          => 'OH_CUYHOGA_EUCLID_MC',                                                          
								 psourcename = 'OHIO_TRUMBULL_COUNTY_NEWTON_FALLS_MUNICIPAL_COURT'    => 'OHTRMBULL_NEWTNFLSMC',                                                    
								 psourcename = 'OHIO_MONTGOMERY_COUNTY_VANDALIA_MUNICIPAL_COURT'      => 'OHMNTGMRY_VANDALIAMC',                                                      
								 psourcename = 'OHIO_SUMMIT_COUNTY_AKRON_MUNICIPAL_COURT'             => 'OH_SUMMIT_AKRON_MC',                                                             
								 psourcename = 'OHIO_STARK_COUNTY_COMMON_PLEAS_COURT'                 => 'OH_STARK_CTY_CP',                                                                 
								 psourcename = 'OHIO_MONTGOMERY_COUNTY_NEW_LEBANON_COUNTY_COURT'      => 'OHMNGMRY_N_LEBNON_CC',                                                      
								 psourcename = 'OHIO_CUYAHOGA_COUNTY_BEREA_MUNICIPAL_COURT'           => 'OH_CUYHOGA_BEREA_MC',                                                           
								 psourcename = 'OHIO_MONTGOMERY_COUNTY_HUBER_HEIGHTS_COUNTY_COURT'    => 'OH_MNGMRY_HUBRHTS_CC',                                                    
								 psourcename = 'OHIO_MONTGOMERY_COUNTY_KETTERING_MUNICIPAL_COURT'     => 'OH_MNGMRY_KETERIN_MC',                                                     
								 psourcename = 'OHIO_ATHENS_COUNTY_ATHENS_MUNICIPAL_COURT'            => 'OH_ATHENS_CTY_MC',                                                            
								 // psourcename = 'OHIO_BROWN_COUNTY_BROWN_MUNICIPAL_COURT'              => 'OH_BROWN_CTY_MC', 
								 psourcename = 'TEXAS_ARLINGTON_POLICE_ARRESTS'                       => 'TX_ARLINGTON_POL_ARR',
								 psourcename = 'MASSACHUSETTS_WELLFLEET_POLICE_ARRESTS'               => 'MA_WELLFLEET_POL_ARR',
								 psourcename = 'LOUISIANA_EAST_BATON_ROUGE_COUNTY_ARRESTS'            => 'LA_ESTBATN_ROUGE_ARR',
								 psourcename = 'FLORIDA_HILLSBOROUGH_COUNTY_ARRESTS'                  => 'FL_HILSBOROUG_CTY_AR',
								 psourcename = 'FLORIDA_INDIAN_RIVER_COUNTY_ARRESTS'                  => 'FL_INDINRIVER_CTY_AR',
								 psourcename = 'FLORIDA_ESCAMBIA_COUNTY_ARRESTS_BLOTTER_FILE'         => 'FL_ESCAMBIA_CTY_ARBF',
	               psourcename = 'OHIO_BROWN_COUNTY_BROWN_MUNICIPAL_TRAFFIC_COURT'      => 'OH_BROWN_CTY_BRWN_MT',
								 psourcename = 'OHIO_LAKE_COUNTY_PAINESVILLE_MUNICIPAL_COURT'   	    => 'OH_LAKE_CTY_PAINS_MC',
								 psourcename = 'OHIO_LAKE_COUNTY_MENTOR_MUNICIPAL_COURT'              => 'OH_LAKE_CTY_MENTR_MC',
                 psourcename = 'OHIO_BROWN_COUNTY_BROWN_MUNICIPAL_COURT'              => 'OH_BROWN_CTY_BRWN_MC',                                   
								 psourcename = 'CALIFORNIA_CONTRA_COSTA_COUNTY_ALTERNATE_FILE'        => 'CA_CONTRA_COSTA_CTYA',
								 psourcename = 'CALIFORNIA_FRESNO_COUNTY_ALTERNATE_FILE'              => 'CA_FRESNO_CTY_AF',
								 psourcename = 'CALIFORNIA_LOS_ANGELES_COUNTY_ALTERNATE_FILE'         => 'CA_LOS_ANGELES_CTYAF',
								 psourcename = 'CALIFORNIA_MARIN_COUNTY_ALTERNATE_FILE'               => 'CA_MARIN_CTY_AF',
								 psourcename = 'CALIFORNIA_SACRAMENTO_COUNTY_ALTERNATE_FILE'          => 'CA_SACRAMENTO_CTY_AF',
								 psourcename = 'CALIFORNIA_SANTA_CRUZ_COUNTY_ALTERNATE_FILE'          => 'CA_SANTA_CRUZ_CTY_AF',
								 psourcename = 'CALIFORNIA_SAN_LUIS_OBISPO_COUNTY'                    => 'CA_SANLUISOBISPO_CTY',
								 psourcename = 'CALIFORNIA_SAN_MATEO_COUNTY_ALTERNATE_FILE'           => 'CA_SAN_MATEO_CTY_AF',
								 psourcename = 'CALIFORNIA_SISKIYOU_COUNTY_SUPERIOR_COURT'            => 'CA_SISKIYOU_CTY_SC',
								 psourcename = 'ILLINOIS_COUNTY_CIRCUIT_CLERK_OF_COURTS'              => 'IL_CTY_CIR_CLRK_CRTS',
								 psourcename = 'OHIO_ADAMS_COMMON_PLEAS_COURT'                        => 'OH_ADAMS_COMMON_PLEA',
								 psourcename = 'OHIO_PICKAWAY_COUNTY_COMMON_PLEAS_COURT'              => 'OH_PICKAWAY_CTY_CP',
								 psourcename = 'OHIO_RICHLAND_COUNTY_MANSFIELD_MUNICIPAL_COURT'       => 'OH_RCHLND_CT_MNSFLMC',
								 psourcename = 'SOUTH_CAROLINA_GREENVILLE_COUNTY_CURCUIT_COURTS'      => 'SC_GREENVILLE_CTY_CC',
								 psourcename = 'SOUTH_CAROLINA_GREENVILLE_COUNTY_SUMMARY_COURTS'      => 'SC_GREENVILL_CTY_SUM',
								 psourcename = 'SOUTH_CAROLINA_ORANGEBURG_COUNTY_CIRCUIT_COURTS'      => 'SC_ORANGEBURG_CTY_CC',
                 psourcename = 'CALIFORNIA_RIVERSIDE_COUNTY_CITY_OF_INDIO_ALTERNATE_FILE'=>'CA_RIVERSIDEINDIO_AF',                                            
                 psourcename = 'CALIFORNIA_SAN_BERNARDINO_COUNTY_ALTERNATE_FILE'      => 'CA_SAN_BERNARDINO_AF',
                 psourcename = 'TENNESSEE_METHAMPHETAMINE_CONVICTIONS_FILE'           => 'TN_METH_CONVICTIONS',																						
								 psourcename = 'CALIFORNIA_SANTA_BARBARA_COUNTY_ALTERNATE_FILE'       => 'CA_SANTABARBARACTYAF',
								 psourcename = 'CALIFORNIA_SANTA_CLARA_COUNTY_ALTERNATE_FILE'         => 'CA_SANTACLARA_CTY_AF',
								 psourcename = 'OHIO_BELMONT_COUNTY_COURT_EASTERN_DISTRICT'           => 'OH_BELMONT_CTY_EDIST',                                                            
                 psourcename = 'OHIO_BELMONT_COUNTY_COURT_NORTHERN_DISTRICT'          => 'OH_BELMONT_CTY_NDIST',                                                        
								 psourcename = 'OHIO_BELMONT_COUNTY_COURT_WESTERN_DISTRICT'           => 'OH_BELMONT_CTY_WDIST',  
                 psourcename = 'MICHIGAN_THIRTEENTH_CIRCUIT_COURT'                    => 'MI_THIRTEENTH_CC',
								 psourcename = 'NEVADA_CLARK_COUNTY_JUSTICE_COURTS'                   => 'NV_CLARK_CTY_JC',
								 psourcename = 'OHIO_BUTLER_COUNTY_HAMILTON_MUNICIPAL_COURT'          => 'OH_BUTLER_CTY_HMILMC',
								 psourcename = 'OHIO_BUTLER_COUNTY_MIDDLETOWN_MUNICIPAL_COURT'        => 'OH_BUTLR_CTY_MIDTNMC',
								 psourcename = 'OHIO_COSHOCTON_COMMON_PLEAS_COURT'                    => 'OH_COSHOCTON_CP',
								 psourcename = 'OHIO_CUYAHOGA_COUNTY_BEDFORD_MUNICIPAL_COURT'         => 'OH_CUYAHOGA_BEDFRDMC',
								 psourcename = 'OHIO_CUYAHOGA_COUNTY_EAST_CLEVELAND_MUNICIPAL_COURT'  => 'OH_CUYAHOGA_E_CLEVMC',  
								 psourcename = 'OHIO_CUYAHOGA_COUNTY_GARFIELD_HEIGHTS_MUNICIPAL_COURT'=> 'OH_CUYAHOGA_GARFHTMC',
								 psourcename = 'OHIO_CUYAHOGA_COUNTY_PARMA_MUNICIPAL_COURT'           => 'OH_CUYAHOGA_PARMA_MC',           
								 psourcename = 'OHIO_CUYAHOGA_COUNTY_ROCKY_RIVER_MUNICIPAL_COURT'     => 'OH_CUYAHOGA_RKYRIVMC',     
								 psourcename = 'OHIO_CUYAHOGA_COUNTY_SHAKER_HEIGHTS_MUNICIPAL_COURT'  => 'OH_CUYAHOGA_SHKRHTMC', 
								 psourcename = 'OHIO_ERIE_COUNTY_VERMILION_MUNICIPAL_COURT'           => 'OH_ERIE_VERMILION_MC',           
								 psourcename = 'OHIO_GEAUGA_COUNTY_CHARDON_MUNICIPAL_COURT'           => 'OH_GEAUGA_CHARDON_MC',          
								 psourcename = 'OHIO_GUERNSEY_COUNTY_CAMBRIDGE_MUNICIPAL_COURT'       => 'OH_GUERNSEY_CMBRDGMC',      
								 psourcename = 'OHIO_HIGHLAND_COUNTY_HILLSBORO_MUNICIPAL_COURT'       => 'OH_HIGHLAND_HILLSBMC',       
								 psourcename = 'OHIO_JEFFERSON_COUNTY_DILLONVALE'                     => 'OH_JEFFERSON_DILLONV',                     
								 psourcename = 'OHIO_JEFFERSON_COUNTY_TORONTO'                        => 'OH_JEFFERSON_TORONTO',                        
								 psourcename = 'OHIO_JEFFERSON_COUNTY_WINTERSVILLE'                   => 'OH_JEFFERSON_WNTERSV',                   
								 psourcename = 'OHIO_KNOX_COUNTY_COMMON_PLEAS_COURT'                  => 'OH_KNOX_CTY_CP' ,                 
								 psourcename = 'OHIO_KNOX_COUNTY_MOUNT_VERNON_MUNICIPAL_COURT'        => 'OH_KNOX_MT_VERNON_MC',        
								 psourcename = 'OHIO_LORAIN_COUNTY_AVON_LAKE_MUNICIPAL_COURT'           => 'OH_LORAIN_AVONLAKEMC',       
								 psourcename = 'OHIO_LORAIN_COUNTY_ELYRIA_MUNICIPAL_COURT'              => 'OH_LORAIN_ELYRIA_MC' ,       
								 psourcename = 'OHIO_LORAIN_COUNTY_OBERLIN_MUNICIPAL_COURT'             => 'OH_LORAIN_OBERLIN_MC',       
								 psourcename = 'OHIO_LUCAS_COUNTY_MAUMEE_MUNICIPAL_COURT'               => 'OH_LUCAS_MAUMEE_MC'  ,       
								 psourcename = 'OHIO_LUCAS_COUNTY_SYLVANIA_MUNICIPAL_COURT'             => 'OH_LUCAS_SYLVANIA_MC',       
								 psourcename = 'OHIO_MONTGOMERY_MIAMISBURG_MUNICIPAL_COURT'             => 'OH_MNTGMRY_MIAMSBRGM', 
								 psourcename = 'NORTH_CAROLINA_ADMINISTRATIVE_OFFICE_OF_THE_COURTS_DEMOGRAPHIC_INDEX'  => 'NC_AOC_DEMOG_INDEX',                                
								 psourcename = 'SOUTH_CAROLINA_DEPARMENT_OF_PROBATION_PAROLE_AND_PARDON'=> 'SC_DOPROB_PAR_PARDON',                                              
								 psourcename = 'OKLAHOMA_DOC_VIOLENT_OFFENDER_REGISTRY'                 => 'OK_DOC_VIOL_OFND_REG',                                              
                 psourcename = 'CALIFORNIA_SACRAMENTO_COUNTY_SUPERIOR_COURT_WEBSITE'    => 'CA_SACRAMENTO_CTY_SC',
								 psourcename = 'OHIO_PREBLE_COUNTY_COMMON_PLEAS_COURT'                  => 'OH_PREBLE_CTY_CP',
								 psourcename = 'OHIO_PREBLE_COUNTY_EATON_MUNICIPAL_COURT'               => 'OH_PREBLE_EATON_MC',
								 psourcename = 'OHIO_ROSS_COUNTY_CHILLICOTHE_MUNICIPAL_COURT_WEBSITE'   => 'OH_ROSS_CHILICOTH_MC',
								 psourcename = 'OHIO_SENECA_COUNTY_TIFFIN_MUNICIPAL_COURT'              => 'OH_SENECA_TIFFIN_MC',
								 psourcename = 'OHIO_SHELBY_COUNTY_SIDNEY_MUNICIPAL_COURT'              => 'OH_SHELBY_SIDNEY_MC',
								 psourcename = 'OHIO_TRUMBULL_COUNTY_GIRARD_MUNICIPAL_COURT'            => 'OH_TRUMBUL_GIRARD_MC',
								 psourcename = 'OHIO_WASHINGTON_COUNTY_MARIETTA_MUNICIPAL_COURT'        => 'OH_WASHNGTNMARIET_MC',
								 psourcename = 'OHIO_WOOD_COUNTY_BOWLING_GREEN_MUNICIPAL_COURT'         => 'OH_WOODBWLNGGREEN_MC',
								 psourcename = 'OKLAHOMA_DISTRICT_COURTS_HISTORY_FILE'                  => 'OK_DISTRICT_COURTSH',
								 psourcename = 'SOUTH_CAROLINA_SPARTANBURG_COUNTY_CIRCUIT_COURTS'       => 'SC_SPARTANBRG_CTYCRC',
								 psourcename = 'SOUTH_CAROLINA_SPARTANBURG_COUNTY_SUMMARY_COURTS'       => 'SC_SPARTANBRG_CTY_SC',
								 psourcename = 'SOUTH_CAROLINA_WILLIAMSBURG_COUNTY_CIRCUIT_COURTS'      => 'SC_WILLIAMSBRG_CRC',
                 psourcename = 'SOUTH_CAROLINA_WILLIAMSBURG_COUNTY_SUMMARY_COURTS'      => 'SC_WILLIAMSBRG_SC',
                 psourcename = 'TEXAS_HOPKINS_COUNTY_DISTRICT_COURT'                    => 'TX_HOPKINS_CTY_DC',        
								 psourcename = 'ARIZONA_MARICOPA_COUNTY_SUPERIOR_COURT_FILINGS'         => 'AZ_MARICOPA_SPCFILNG',
								 psourcename = 'OHIO_GEAUGA_COUNTY_CHARDON_MUNICIPAL_COURT_WEBSITE'     => 'OH_GEAUGA_CHARDON_MC',
								 psourcename = 'OHIO_BUTLER_FAIRFIELD_MUNICIPAL_COURT'                  => 'OH_BUTLERFAIRFELD_MC',
	               psourcename = 'OHIO_GALLIA_COUNTY_GALLIPOLIS_MUNICIPAL_COURT'          => 'OH_GALLIA_GALIPLS_MC',
								 psourcename = 'FLORIDA_MANATEE_CIRCUIT_AND_COUNTY_COURTS'              => 'FL_MANATEE_CRC_CTYCO',
								 psourcename = 'ILLINOIS_COOK_COUNTY_MISDEMEANOR'                       => 'IL_COOK_CTY_MISD',                                                                  
								 psourcename = 'ILLINOIS_VIOLENT_OFFENDER_AGAINST_YOUTH'                => 'IL_VIOFNDRAGANSTYOUT', 
								 psourcename = 'FLORIDA_HILLSBOROUGH_COUNTY_TRAFFIC'                    => 'FL_HILLSBORO_CTY_TRA', 
                 psourcename = 'OHIO_MERCER_COUNTY_CELINA_MUNICIPAL_COURT'              => 'OH_MERCR_CTYCELNA_MC',
                 psourcename = 'OHIO_SENECA_COUNTY_FOSTORIA_MUNICIPAL_COURT'            => 'OH_SENCACTYFOSTRIAMC',   
                 psourcename = 'OHIO_WOOD_COUNTY_PERRYSBURG_MUNICIPAL_COURT'            => 'OH_WOODCTYPERYBRG_MC',
                 psourcename = 'LOUISIANA_ST_LANDRY_PARISH_SHERIFF_CW'                  => 'LA_ST_LANDRY_PARS_SO',                                                                 
                 psourcename = 'MASSACHUSETTS_SPRINGFIELD_POLICE_CW'                    => 'MA_SPRINGFIELD_PD',                                                                    
                 psourcename = 'NORTH_CAROLINA_TRANSYLVANIA_COUNTY_DETENTION_CENTER_CW' => 'NC_TRNSLVNIA_CTY_DTC',
								 psourcename = 'ALABAMA_BALDWIN_COUNTY_CORRECTIONS_CENTER_CW'           => 'AL_BALDWIN_CTY_COR',
                 psourcename = 'CALIFORNIA_SAN_JOAQUIN_COUNTY_BOOKINGS_CW'              => 'CA_SANJOAQUINCTY_BKN',
                 psourcename = 'LOUISIANA_JEFFERSON_PARISH_SHERIFF_CW'                  => 'LA_JEFRSON_PARISH_SO',
                 psourcename = 'LOUISIANA_ST_TAMMANY_PARISH_SHERIFF_CW'                 => 'LA_STTAMMANY_PAR_SO', 
                 psourcename = 'MASSACHUSETTS_EAST_LONGMEADOW_CW'                       => 'MA_EAST_LONGMEADOW',   
                 psourcename = 'MASSACHUSETTS_TOWN_OF_SHREWSBURY_CW'                    => 'MA_TOWN_SHREWSBURY',   
                 psourcename = 'OHIO_WARREN_COUNTY_LEBANON_MUNICIPAL_COURT_CW'          => 'OH_WARRENCTY_LEBN_MC',
                 psourcename = 'OHIO_GREENE_COUNTY_FAIRBORN_MUNICIPAL_COURT_CW'         => 'OH_GREENECTYFARBRNMC',
								 psourcename = 'OHIO_CUYAHOGA_COUNTY_CLEVELAND_MUNICIPAL_COURT'         => 'OHCUYAHOGACLVELND_MC',
	               psourcename = 'OHIO_CUYAHOGA_COUNTY_CLEVELANDHEIGHTS_MUNICIPAL_COURT'  => 'OHCUYAHGCLVLNDHTS_MC',
								 psourcename = 'OHIO_HURON_COUNTY_NORWALK_MUNICIPAL_COURT'              => 'OH_HURONCTY_NRWLK_MC',
								 psourcename = 'TENNESSEE_HAMILTON_CRIMINAL_COURT'                      => 'TN_HAMILTON_CRIM_CRT', 
								 psourcename = 'OHIO_STARK_COUNTY_ALLIANCE_MUNICIPAL_COURT'             => 'OH_STARK_ALLIANCE_MC',
                 psourcename = 'OHIO_COLUMBIANA_COUNTY_EASTLIVERPOOL_MUNICIPAL_COURT'   => 'OH_COLUMNIANAELIV_MC', 
                 psourcename = 'OHIO_CUYAHOGA_COUNTY_LAKEWOOD_MUNICIPAL_COURT'          => 'OH_CUYAHOGA_LAKWD_MC',   
                 psourcename = 'OHIO_JEFFERSON_COUNTY_STEUBENVILLE'                     => 'OH_JEFFERSON_STUBNVL',   
							   psourcename = 'OHIO_TRUMBULL_COUNTY_WARREN_MUNICIPAL_COURT'            => 'OH_TRUMBULL_WAREN_MC',
                 psourcename = 'OHIO_CUYAHOGA_COUNTY_LYNDHURST_MUNICIPAL_COURT'         => 'OH_CUYAHOGALNDHRSTMC',
							   psourcename = 'OHIO_GREENE_COUNTY_FAIRBORN_MUNICIPAL_COURT'            => 'OH_GREENE_FAIRBORNMC',
							   psourcename = 'OHIO_MEDINA_COUNTY_WADSWORTH_MUNICIPAL_COURT'           => 'OH_MEDINA_WADSWRTHMC',
                 psourcename = 'OHIO_ERIE_COUNTY_SANDUSKY_MUNICIPAL_COURT_CW'           => 'OH_ERIE_SANDUSKY_MC',
							   psourcename = 'CALIFORNIA_SAN_LUIS_OBISPO_COUNTY_WEBSITE_CW'           => 'CA_SANLUISOBISPO_WEB',
							   psourcename = 'OHIO_LAKE_COUNTY_PAINSVILLE_MUNICIPAL_COURT_CW'         => 'OH_LAKE_PAINSVILE_MC',
							   psourcename = 'FLORIDA_VOLUSIA_COUNTY_CORRECTIONS_CW         '         => 'FL_VOLUSIA_CTY_CORR',
                 psourcename = 'FLORIDA_HILLSBOROUGH_COUNTY_SHERIFFS_OFFICE_CW'         => 'FL_HILSBOROUGH_CTYSO', 
							   psourcename = 'FLORIDA_INDIAN_RIVER_COUNTY_SHERIFFS_OFFICE_CW'         => 'FL_INDIANRIVER_CTYSO',
							   psourcename = 'MASSACHUSETTS_BARNSTABLE_COUNTY_ARRESTS_CW    '         => 'MA_BARNSTABLE_CTY_AR',
							   psourcename = 'NORTH_CAROLINA_MECKLENBURG_COUNTY_SHERIFF_CW  '         => 'NC_MECKLENBURG_CTYSO',
							   psourcename = 'CALIFORNIA_VENTURA_COUNTY_WEBSITE'                      => 'CA_VENTURA_CTY_WEB',
							   psourcename = 'OHIO_MONTGOMERY_COUNTY_COMMON_PLEAS_COURT     '         => 'OH_MONTGOMERY_CTYCPC',		
								 psourcename = 'OHIO_SCIOTO_COUNTY_PORTSMOUTH_MUNICIPAL_COURT'          => 'OH_SCIOTO_PRTSMUTHMC',
                 psourcename = 'OHIO_STARK_COUNTY_CANTON_MUNICIPAL_COURT'               => 'OH_STARK_CTYCANTONMC',
								 psourcename = 'OHIO_STARK_COUNTY_MASSILLON_MUNICIPAL_COURT'            => 'OH_STARK_CTYMASLONMC',
                 psourcename = 'MASSACHUSETTS_EAST_BRIDGEWATER_ARRESTS_CW           '   => 'MA_E_BRIDGEWATER_ARR',                                                       
                 psourcename = 'MASSACHUSETTS_EAST_LONGMEADOW_ARRESTS_CW            '   => 'MA_E_LONGMEADOW_ARR',                                             
                 psourcename = 'MASSACHUSETTS_TOWN_OF_BILLERICA_POLICE_DEPARTMENT_CW'   => 'MA_TOWN_BILLERICA_PD',                                          
                 psourcename = 'NORTH_CAROLINA_RUTHERFORD_COUNTY_DETENTION_CENTER_CW'   => 'NC_RUTHERFORD_CTYDTC',   
								 psourcename = 'CALIFORNIA_PLACER_COUNTY_TRAFFIC_CW'                    => 'CA_PLACER_CTY_TRAF',
								 psourcename = 'OHIO_JEFFERSON_COUNTY_DILLONVALE_MUNICIPAL_COURT_CW'    => 'OH_JEFERSNDILNVLE_MC',
								 psourcename = 'ARIZONA_DEPARTMENT_OF_PUBLIC_SAFETY_CW             '    => 'AZ_DOPUB_SAFETY',
                 psourcename = 'TEXAS_DEPARTMENT_OF_CRIMINAL_JUSTICE_INMATES_CW    '    => 'TX_DO_CRM_JUSTINMATS',
								 psourcename = 'MASSACHUSETTS_NORTH_ATTLEBORO_ARRESTS_CW           '    => 'MA_NRTH_ATTLEBOO_ARR',
								 psourcename = 'MASSACHUSETTS_WEST_BRIDGEWATER_ARRESTS_CW          '    => 'MA_WES_BRDGEWATR_ARR',
								 psourcename = 'MONTANA_YELLOWSTONE_COUNTY_DETENTION_CW            '    => 'MT_YELLOWSTONCTY_DET', 
								 psourcename = 'FLORIDA_OSCEOLA_COUNTY_CORRECTIONS_CW              '    => 'FL_OSCEOLA_CTY_CORR', 
								 psourcename = 'UTAH_WHITE_COLLAR_CRIME_OFFENDER_REGISTRY          '    => 'UT_WHITECOLAR_OFNREG',                                                           
								 psourcename = 'MONTANA_VIOLENT_OFFENDER_REGISTRY                  '    => 'MT_VIOLENT_OFNREG',                   
								 psourcename = 'NORTH_DAKOTA_OFFENDERS_AGAINST_CHILDREN            '    => 'ND_OFFND_AGANST_CHIL',
								 psourcename = 'TEXAS_DALLAS_JUSTICE_OF_THE_PEACE_TRAFFIC          '    => 'TX_DALAS_JUSPEACE_TR',
								 psourcename = 'GEORGIA_PAROLE_RELEASED_INMATES                    '    => 'GA_PAR_RELEASED_INM',
								 
								 
								 result2);
	return result3;    
end;                 
                     
export fn_sourcename_to_vendor(string psourcename, string2 statecode ) := function
string5 vendor :=     
map(      
/***********************************************HYGENICS CRIM****************************************************************/           
//------------------------------------------AOC Phase1 ---------------------------------------------------------------------
 	psourcename = 'ARIZONA_ADMINISTRATOR_OF_THE_COURTS' 				=> 'Z1',
	psourcename = 'ALASKA_ADMINISTRATOR_OF_THE_COURTS' 					=> 'RC',
	psourcename = 'ARKANSAS_ADMINISTRATOR_OF_THE_COURTS' 				=> 'RD',
	psourcename = 'CONNECTICUT_ADMINISTRATOR_OF_THE_COURTS' 		=> 'CP',
	psourcename = 'FLORIDA_ADMINISTRATOR_OF_THE_COURTS' 				=> 'FV',
	psourcename = 'GEORGIA_BUREAU_OF_INVESTIGATION' 					  => 'GD',
	psourcename = 'HAWAII_STATE_JUDICIARY' 								      => 'HA',
	psourcename = 'INDIANA_ADMINISTRATOR_OF_THE_COURTS' 				=> 'Z4', //replaced 'ID' with Z4,
	psourcename = 'IOWA_ADMINISTRATOR_OF_THE_COURTS' 					  => 'IC',
	psourcename = 'MARYLAND_ADMINISTRATOR_OF_THE_COURTS' 				=> 'MF',
	psourcename = 'MINNESOTA_DEPARTMENT_OF_PUBLIC_SAFETY' 			=> 'MH',
	psourcename = 'MISSOURI_ADMINISTRATOR_OF_THE_COURTS' 				=> 'MG',
	psourcename = 'NEW_JERSEY_ADMINISTRATOR_OF_THE_COURTS' 			=> 'NA',
	psourcename = 'NEW_MEXICO_ADMINISTRATOR_OF_THE_COURTS' 			=> 'NB',
	//psourcename = 'NORTH_CAROLINA_ADMINISTRATIVE_OFFICE_OF_THE_COURTS' 	=> 'NF', 			//removing vendor
	psourcename = 'NORTH_CAROLINA_ADMINISTRATIVE_OFFICE_OF_THE_COURTS_DEMOGRAPHIC_INDEX' 	=> 'NF', //vc 20130917
	psourcename = 'NORTH_DAKOTA_ADMINISTRATOR_OF_THE_COURTS' 		=> 'NG',
	psourcename = 'OKLAHOMA_ADMINISTRATOR_OF_THE_COURTS' 				=> 'PS',
	psourcename = 'OREGON_ADMINISTRATOR_OF_THE_COURTS' 					=> 'PT',
	psourcename = 'PENNSYLVANIA_ADMINISTRATOR_OF_THE_COURTS' 		=> 'PU',
	psourcename = 'PENNSYLVANIA_ADMINISTRATOR_OF_THE_COURTS_COURT_OF_COMMON_PLEAS' => 'PV',
	psourcename = 'RHODE_ISLAND_ADMINISTRATOR_OF_THE_COURTS' 		=> 'RA',
	psourcename = 'RHODE_ISLAND_ADMINISTRATOR_OF_THE_COURTS_TRAFFIC' 	=> 'RB',
	psourcename = 'TEXAS_DEPARTMENT_OF_PUBLIC_SAFETY' 					=> 'TB',
	psourcename = 'TENNESSEE_ADMINISTRATOR_OF_THE_COURTS' 			=> 'TA',
	psourcename = 'UTAH_ADMINISTRATOR_OF_THE_COURTS' 					  => 'UA',
	psourcename = 'VIRGINIA_ADMINISTRATOR_OF_THE_COURTS' 				=> 'VB',
	psourcename = 'WISCONSIN_ADMINISTRATOR_OF_THE_COURTS' 			=> 'WB',
	                   
	// Make sure these vendor codes are not applied to warrants
	psourcename = 'WASHINGTON_PUBLIC_SCOMIS_CRIMINAL_INDEX' 			=> 'Z8',
	psourcename = 'WASHINGTON_COURTS_OF_LIMITED_JURISDICTION_CRIMINAL_INDEX' 			=> 'Z9',
	               
//------------------------------------------AOC Phase2 ---------------------------------------------------------------------	               
	psourcename = 'WISCONSIN_ADMINISTRATOR_OF_THE_COURTS_TRAFFIC' 			=> 'PY',
//------------------------------------------AOC Phase3 sources. 07/13/2015 --------------------------------------------------
  psourcename = 'SOUTH_CAROLINA_ADMINISTRATOR_OF_THE_COURTS'           => '7A', 
	psourcename = 'UTAH_JUSTICE_COURT_TRAFFIC'                           => '7B',
  psourcename = 'MARYLAND_ADMINISTRATOR_OF_THE_COURTS_TRAFFIC'         => '7Q',
//----------------------------------------------------------------------20151028
	psourcename = 'ILLINOIS_VIOLENT_OFFENDER_AGAINST_YOUTH'              => '8F',
	psourcename = 'UTAH_JUSTICE_COURT'                                   => '8G',
  psourcename = 'WEST_VIRGINIA_CIRCUIT_COURTS'                         => '8H',
//----------------------------------------------------------------------20171025 
	psourcename = 'UTAH_WHITE_COLLAR_CRIME_OFFENDER_REGISTRY' 		       => '10D',
	psourcename = 'MONTANA_VIOLENT_OFFENDER_REGISTRY        ' 			     => '10E',
	psourcename = 'NORTH_DAKOTA_OFFENDERS_AGAINST_CHILDREN  ' 			     => '10F',
	
                                                                                        
//------------------------------------------DOC Phase1 ---------------------------------------------------------------------
	psourcename = 'ALABAMA_DEPARTMENT_OF_CORRECTIONS' 								=> 'DA',
	psourcename = 'ARKANSAS_DEPARTMENT_OF_CORRECTIONS' 								=> 'DB',
	psourcename = 'ARIZONA_DEPARTMENT_OF_CORRECTIONS' 								=> 'DD',
	psourcename = 'CALIFORNIA_DEPARTMENT_OF_CORRECTIONS_AND_REHABILITATION' 								=> 'DF',
	psourcename = 'CONNECTICUT_DEPARTMENT_OF_CORRECTIONS' 						=> 'DG',
	psourcename = 'COLORADO_DEPARTMENT_OF_CORRECTIONS' 								=> 'DH',
	psourcename = 'FLORIDA_DEPARTMENT_OF_CORRECTIONS' 								=> 'DI',
	psourcename = 'FLORIDA_DEPARTMENT_OF_CORRECTIONS_HISTORY_FILE'	  => 'DI',
	psourcename = 'GEORGIA_DEPARTMENT_OF_CORRECTIONS' 								=> 'DJ',
	psourcename = 'GEORGIA_PAROLE' 																		=> 'DK',
	psourcename = 'HAWAII_DEPARTMENT_OF_CORRECTIONS' 				          => 'DL',	
	psourcename = 'IDAHO_DEPARTMENT_OF_CORRECTIONS' 									=> 'DM',
	psourcename = 'INDIANA_DEPARTMENT_OF_CORRECTIONS' 								=> 'DN',
	psourcename = 'IOWA_DEPARTMENT_OF_CORRECTIONS' 										=> 'DO',
	psourcename = 'IOWA_DEPARTMENT_OF_CORRECTIONS_PROBATION' 					=> 'DP',	
	psourcename = 'ILLINOIS_DEPARTMENT_OF_CORRECTIONS'                => 'DQ',
	psourcename = 'KENTUCKY_DEPARTMENT_OF_CORRECTIONS' 								=> 'DR',
	psourcename = 'KANSAS_DEPARTMENT_OF_CORRECTIONS' 								  => 'SB',
	psourcename = 'LOUISIANA_DEPARTMENT_OF_CORRECTIONS_PAROLE' 				=> 'DS',
	psourcename = 'MAINE_DEPARTMENT_OF_CORRECTIONS' 									=> 'DT',
	psourcename = 'MARYLAND_DEPARTMENT_OF_CORRECTIONS' 								=> 'DU',
	psourcename = 'MICHIGAN_DEPARTMENT_OF_CORRECTIONS' 								=> 'DV',
	psourcename = 'MICHIGAN_DEPARTMENT_OF_CORRECTIONS_ALTERNATE_FILE' => 'DW',	
  	
	psourcename = 'MONTANA_DEPARTMENT_OF_CORRECTIONS' 								=> 'DX',
	psourcename = 'MISSISSIPPI_DEPARTMENT_OF_CORRECTIONS' 						=> 'DY',
	psourcename = 'MINNESOTA_DEPARTMENT_OF_CORRECTIONS' 							=> 'DZ',	
	psourcename = 'MISSOURI_DEPARTMENT_OF_CORRECTIONS' 								=> 'EU',	
	psourcename = 'NORTH_CAROLINA_DEPARTMENT_OF_CORRECTIONS' 					=> 'EV',	
	psourcename = 'NORTH_DAKOTA_DEPARTMENT_OF_CORRECTIONS' 						=> 'EW',
	psourcename = 'NEBRASKA_DEPARTMENT_OF_CORRECTIONS' 								=> 'EX',
	psourcename = 'NEW_HAMPSHIRE_DEPARTMENT_OF_CORRECTIONS' 					=> 'EY',	
	psourcename = 'NEW_JERSEY_DEPARTMENT_OF_CORRECTIONS' 							=> 'EA',
	psourcename = 'NEW_MEXICO_DEPARTMENT_OF_CORRECTIONS' 							=> 'EB',
	psourcename = 'NEVADA_DEPARTMENT_OF_CORRECTIONS' 									=> 'EC',
	psourcename = 'NEW_YORK_DEPARTMENT_OF_CORRECTIONS' 								=> 'ED',
	psourcename = 'OHIO_DEPARTMENT_OF_CORRECTIONS' 										=> 'EE',
	psourcename = 'OKLAHOMA_DEPARTMENT_OF_CORRECTIONS' 								=> 'EF',
	psourcename = 'OREGON_DEPARTMENT_OF_CORRECTIONS' 									=> 'EG',
	psourcename = 'PENNSYLVANIA_DEPARTMENT_OF_CORRECTIONS' 						=> 'EH',
	psourcename = 'RHODE_ISLAND_DEPARTMENT_OF_CORRECTIONS' 						=> 'EI',
	psourcename = 'SOUTH_CAROLINA_DEPARTMENT_OF_CORRECTIONS' 					=> 'EJ',
	psourcename = 'TENNESSEE_DEPARTMENT_OF_CORRECTIONS' 							=> 'EK',
	psourcename = 'TEXAS_DEPARTMENT_OF_CORRECTIONS' 									=> 'EL',
	psourcename = 'UTAH_DEPARTMENT_OF_CORRECTIONS' 										=> 'EM',
	psourcename = 'VIRGINIA_DEPARTMENT_OF_CORRECTIONS' 								=> 'EN',
	psourcename = 'VERMONT_DEPARTMENT_OF_CORRECTIONS' 								=> 'EO',
	psourcename = 'WASHINGTON_DEPARTMENT_OF_CORRECTIONS' 							=> 'EP',
	psourcename = 'WASHINGTON_DC_DEPARTMENT_OF_CORRECTIONS' 					=> 'EQ',
	psourcename = 'WISCONSIN_DEPARTMENT_OF_CORRECTIONS' 							=> 'ER',
	psourcename = 'WEST_VIRGINIA_DEPARTMENT_OF_CORRECTIONS' 					=> 'ES',
	psourcename = 'WEST_VIRGINIA_DEPARTMENT_OF_CORRECTIONS_ALTERNATE' => 'ET',	
	psourcename = 'MISSISSIPPI_DEPARTMENT_OF_CORRECTIONS_WEBSITE'     => 'WL',
  psourcename = 'NEVADA_DEPARTMENT_OF_CORRECTIONS_WEBSITE'          => 'WC',
  psourcename = 'NEW_HAMPSHIRE_DEPARTMENT_OF_CORRECTIONS_WEBSITE'   => 'WD',
  psourcename = 'NEW_JERSEY_DEPARTMENT_OF_CORRECTIONS_WEBSITE'      => 'WE',
  psourcename = 'NEW_YORK_DEPARTMENT_OF_CORRECTIONS_WEBSITE'        => 'WF',
  psourcename = 'NORTH_CAROLINA_DEPARTMENT_OF_CORRECTIONS_WEBSITE'  => 'WG',
  psourcename = 'OKLAHOMA_DEPARTMENT_OF_CORRECTIONS_WEBSITE'        => 'WH',
  psourcename = 'OHIO_DEPARTMENT_OF_CORRECTIONS_WEBSITE'            => 'WJ',
  psourcename = 'UTAH_DEPARTMENT_OF_CORRECTIONS_WEBSITE' 	          => 'WK',
	psourcename = 'GEORGIA_DEPARTMENT_OF_CORRECTIONS_WEBSITE' 				=> 'VE', //20130812
//---------------------------DOC Batch4 12092013-------------------------------------------
  psourcename = 'KENTUCKY_DEPARTMENT_OF_CORRECTIONS_WEBSITE'               => '6Z',      
  psourcename = 'MISSISSIPPI_PAROLE_BOARD'                                 => '6X', 
  psourcename = 'OKLAHOMA_DOC_VIOLENT_OFFENDER_REGISTRY'                   => 'ZB',
	psourcename = 'SOUTH_CAROLINA_DEPARMENT_OF_PROBATION_PAROLE_AND_PARDON'  => '6H',
  psourcename = 'MICHIGAN_DEPARTMENT_OF_CORRECTIONS_WEBSITE'               => '6W', // VC 20141027

//---------------------------DOC Batch4 20171025-------------------------------------------
	psourcename = 'GEORGIA_PAROLE_RELEASED_INMATES'           		           => '10G',
	
//------------------------------------------County Phase1 ---------------------------------------------------------------------
	psourcename = 'ARIZONA_MARICOPA_COUNTY_GILBERT_MUNICIPAL_COURT' 	=> 'RE',                                                     
	psourcename = 'ARIZONA_MARICOPA_COUNTY' 													=> 'RF',                                                                              
	psourcename = 'ARIZONA_PIMA_COUNTY' 															=> 'RG',                                                                                  
	//psourcename = 'CALIFORNIA_MARIN_COUNTY' 													=> 'CB', //20130821 -VC : Using alternate file instead                                                                             
	//psourcename = 'CALIFORNIA_RIVERSIDE_COUNTY_CITY_OF_INDIO' 				=> 'CC', //20130821 -VC : Using alternate file instead                                                         
	//psourcename = 'CALIFORNIA_SANTA_CRUZ_COUNTY' 											=> 'CD', //20130821 -VC : Using alternate file instead                                                                     
	//psourcename = 'CALIFORNIA_SAN_DIEGO_COUNTY' 											=> 'CE', //20130821 -VC : Using alternate file instead                                                                         
	//psourcename = 'CALIFORNIA_SANTA_BARBARA_COUNTY' 									=> 'CF', //20130821 -VC : Using alternate file instead                                                                     
	psourcename = 'CALIFORNIA_CONTRA_COSTA_COUNTY' 										=> 'CG',                                                                       
	psourcename = 'CALIFORNIA_ORANGE_COUNTY' 													=> 'CH',                                                                             
	psourcename = 'CALIFORNIA_FRESNO_COUNTY' 													=> 'CI',                                                                             
	//psourcename = 'CALIFORNIA_SANTA_CLARA_COUNTY' 										=> 'CJ',  //20130821 -VC : Using alternate file instead                                                                      
	//psourcename = 'CALIFORNIA_SAN_BERNARDINO_COUNTY' 								=> 'CK',//20130821 -VC : Using alternate file instead                                                                     
	psourcename = 'CALIFORNIA_RIVERSIDE_COUNTY' 											=> 'CL',                                                                          
	//psourcename = 'CALIFORNIA_VENTURA_COUNTY' 												=> 'CM',  //20130821 -VC : Using alternate file instead 
	psourcename = 'CALIFORNIA_LOS_ANGELES_COUNTY' 										=> 'CN',                                                                         
	psourcename = 'FLORIDA_HIGHLANDS_COUNTY' 													=> 'FA',                                                                             
	psourcename = 'FLORIDA_SARASOTA_COUNTY' 													=> 'FB',                                                                              
	psourcename = 'FLORIDA_LEE_COUNTY' 																=> 'FC',                                                                                   
	psourcename = 'FLORIDA_PALM_BEACH_COUNTY' 												=> 'FD',                                                                            
	psourcename = 'FLORIDA_BROWARD_COUNTY' 														=> 'FE',                                                                               
	psourcename = 'FLORIDA_HILLSBOROUGH_COUNTY' 											=> 'FG',                                                                          
	psourcename = 'FLORIDA_ALACHUA_COUNTY' 														=> 'FH',                                                                               
	psourcename = 'FLORIDA_BAY_COUNTY' 																=> 'FI',                                                                                   
	psourcename = 'FLORIDA_OSCEOLA_COUNTY' 														=> 'FJ',                                                                               
	psourcename = 'FLORIDA_CHARLOTTE_COUNTY' 													=> 'FK',                                                                             
	psourcename = 'FLORIDA_LEON_COUNTY' 															=> 'FM',                                                                                  
	psourcename = 'FLORIDA_DUVAL_COUNTY' 															=> 'FN',                                                                                 
	psourcename = 'FLORIDA_DADE_COUNTY' 															=> 'FO',                                                                                  
	psourcename = 'FLORIDA_BREVARD_COUNTY' 														=> 'FP',                                                                               
	psourcename = 'FLORIDA_HERNANDO_COUNTY' 													=> 'FQ',                                                                              
	psourcename = 'FLORIDA_ORANGE_COUNTY' 														=> 'FR',                                                                                
	psourcename = 'FLORIDA_PINELLAS_COUNTY' 													=> 'FS',                                                                              
	psourcename = 'FLORIDA_MONROE_COUNTY' 														=> 'FT',                                                                                
	psourcename = 'FLORIDA_MARION_COUNTY' 														=> 'FU',                                                                                
	psourcename = 'GEORGIA_COBB_COUNTY' 															=> 'GB',                                                                                  
	psourcename = 'GEORGIA_GWINNETT_COUNTY' 													=> 'GC',                                                                              
	psourcename = 'ILLINOIS_COOK_COUNTY' 															=> 'IB',                                                                                 
	psourcename = 'LOUISIANA_ST_TAMMANY_COUNTY' 											=> 'LB',                                                                          
	psourcename = 'MICHIGAN_WAYNE_COUNTY' 														=> 'MB',                                                                                
	psourcename = 'MISSISSIPPI_HINDS_COUNTY' 													=> 'MC',                                                                             
	psourcename = 'OHIO_ALLEN_COUNTY_LIMA_MUNICIPAL_COURT' 						=> 'OA',                                                               
	psourcename = 'OHIO_SUMMIT_COUNTY_CUYAHOGA_FALLS_MUNICIPAL_COURT' => 'OB',                                                    
	psourcename = 'OHIO_MONTGOMERY_COUNTY_DAYTON_MUNICIPAL_COURT' 		=> 'OC',                                                        
	psourcename = 'OHIO_WARREN_COUNTY_MASON_MUNICIPAL_COURT' 					=> 'OD',                                                             
	psourcename = 'OHIO_FRANKLIN_COUNTY_MUNICIPAL_COURT' 							=> 'OE',                                                                 
	psourcename = 'OHIO_WARREN_COUNTY' 																=> 'OF',                                                                                   
	psourcename = 'OHIO_CLINTON_COUNTY' 															=> 'OG',                                                                                  
	psourcename = 'OHIO_COLUMBIANA_COUNTY' 														=> 'OI',                                                                               
	psourcename = 'OHIO_LAWRENCE_COUNTY_MUNICIPAL_COURT' 							=> 'OJ',                                                                 
	psourcename = 'OHIO_TRUMBULL_COUNTY' 															=> 'OL',                                                                                 
	psourcename = 'OHIO_ALLEN_COUNTY' 																=> 'OM',                                                                                    
	psourcename = 'OHIO_PORTAGE_COUNTY' 															=> 'ON',                                                                                  
	psourcename = 'OHIO_LICKING_COUNTY' 															=> 'OO',                                                                                  
	psourcename = 'OHIO_GREENE_COUNTY_XENIA_MUNICIPAL_COURT' 					=> 'OP',                                                             
	psourcename = 'OHIO_CLERMONT_COUNTY' 															=> 'OQ',                                                                                 
	psourcename = 'OHIO_SUMMIT_COUNTY_BARBERTON_MUNICIPAL_COURT' 			=> 'EZ',                                                         
	psourcename = 'OHIO_ROSS_COUNTY' 																	=> 'OS',                                                                                     
	psourcename = 'OHIO_GREENE_COUNTY' 																=> 'OT',                                                                                   
	psourcename = 'OHIO_TUSCARAWAS_COUNTY' 														=> 'OU',                                                                               
	psourcename = 'OHIO_SUMMIT_COUNTY' 																=> 'OV',                                                                                   
	psourcename = 'OHIO_ROSS_COUNTY_CHILLICOTHE_MUNICIPAL_COURT' 			=> 'OW',                                                         
	psourcename = 'OHIO_CUYAHOGA_COUNTY_EUCLID_MUNICIPAL_COURT' 			=> 'OX',                                                          
	psourcename = 'OHIO_MONTGOMERY_COUNTY' 														=> 'OY',                                                                               
	psourcename = 'OHIO_TRUMBULL_COUNTY_NEWTON_FALLS_MUNICIPAL_COURT' => 'OZ',                                                    
	psourcename = 'OHIO_BUTLER_COUNTY' 																=> 'PB',                                                                                   
	psourcename = 'OHIO_MONTGOMERY_COUNTY_VANDALIA_MUNICIPAL_COURT' 	=> 'PC',                                                      
	psourcename = 'OHIO_DELAWARE_COUNTY' 															=> 'PD',                                                                                 
	psourcename = 'OHIO_WARREN_COUNTY_COURT' 													=> 'PE',                                                                             
	psourcename = 'OHIO_SUMMIT_COUNTY_AKRON_MUNICIPAL_COURT' 					=> 'PF',                                                             
	psourcename = 'OHIO_FRANKLIN_COUNTY' 															=> 'PG',                                                                                 
	psourcename = 'OHIO_STARK_COUNTY_COMMON_PLEAS_COURT' 							=> 'PH',                                                                 
	psourcename = 'OHIO_MONTGOMERY_COUNTY_NEW_LEBANON_COUNTY_COURT' 	=> 'PI',                                                      
	psourcename = 'OHIO_CUYAHOGA_COUNTY_BEREA_MUNICIPAL_COURT' 				=> 'PJ',                                                           
	psourcename = 'OHIO_MONTGOMERY_COUNTY_HUBER_HEIGHTS_COUNTY_COURT' => 'PK',                                                    
	psourcename = 'OHIO_MONTGOMERY_COUNTY_KETTERING_MUNICIPAL_COURT' 	=> 'PL',                                                     
	psourcename = 'OHIO_ATHENS_COUNTY_ATHENS_MUNICIPAL_COURT' 				=> 'PM',                                                            
	psourcename = 'OHIO_FULTON_COUNTY' 																=> 'PN',                                                                                   
	psourcename = 'OHIO_STARK_COUNTY' 																=> 'PO',                                                                                    
	psourcename = 'OHIO_BROWN_COUNTY_BROWN_MUNICIPAL_COURT' 					=> 'PQ',     
	psourcename = 'SOUTH_CAROLINA_RICHLAND_COUNTY_CIRCUIT_COURTS' 		=> 'SA',                                                       
  psourcename = 'TEXAS_BEXAR_COUNTY'         												=> 'TR',                                                                          
  psourcename = 'TEXAS_BRAZORIA_COUNTY'      												=> 'TC',                                                                          
  psourcename = 'TEXAS_COLLIN_COUNTY'        												=> 'TD',                                                                                 
  psourcename = 'TEXAS_DALLAS_COUNTY'        												=> 'TE',                                                                                 
  psourcename = 'TEXAS_DENTON_COUNTY'        												=> 'TF',                                                                                 
  psourcename = 'TEXAS_EL_PASO_COUNTY'       												=> 'TG',                                                                                
  psourcename = 'TEXAS_FORT_BEND_COUNTY'     												=> 'TH',                                                                              
  psourcename = 'TEXAS_GREGG_COUNTY'         												=> 'TI',                                                                                    
  psourcename = 'TEXAS_HARRIS_COUNTY'        												=> 'TJ',                                                                                 
  psourcename = 'TEXAS_JEFFERSON_COUNTY'     												=> 'TK',                                                                              
  psourcename = 'TEXAS_JOHNSON_COUNTY'       												=> 'TL',                                                                                
  psourcename = 'TEXAS_MIDLAND_COUNTY'       												=> 'TM',                                                                                
  psourcename = 'TEXAS_POTTER_COUNTY'        												=> 'TP',                                                                                 
  psourcename = 'TEXAS_VICTORIA_COUNTY'      												=> 'TO',  
	psourcename = 'TEXAS_MONTGOMERY_COUNTY'    												=> 'TQ', 
	psourcename = 'VIRGINIA_FAIRFAX_COUNTY' 													=> 'PR', 
	 
//------------------------------------------County Phase2 20120424---------------------------------------------------------------------
  //psourcename = 'CALIFORNIA_SACRAMENTO_COUNTY' 									=> '',  
  psourcename = 'CALIFORNIA_ALAMEDA_COUNTY' 										            => 'QK', 
  psourcename = 'CALIFORNIA_BUTTE_COUNTY'                                   => 'QX',  
	psourcename = 'CALIFORNIA_MARIN_COUNTY_ALTERNATE_FILE' 						        => 'QL', 	
  psourcename = 'CALIFORNIA_NEVADA_COUNTY'                                  => 'QI',	
	psourcename = 'CALIFORNIA_GLENN_COUNTY'                                   => 'PZ', 
	psourcename = 'CALIFORNIA_RIVERSIDE_COUNTY_CITY_OF_INDIO_ALTERNATE_FILE'  => 'TS', 
  psourcename = 'CALIFORNIA_SACRAMENTO_COUNTY_ALTERNATE_FILE'         			=> 'QJ',	
	psourcename = 'CALIFORNIA_SAN_BERNARDINO_COUNTY_ALTERNATE_FILE'           => 'TV', 
	psourcename = 'CALIFORNIA_SAN_DIEGO_COUNTY_ALTERNATE_FILE'                => 'TW', 
	psourcename = 'CALIFORNIA_SAN_LUIS_OBISPO_COUNTY'                         => 'UB', 
	psourcename = 'CALIFORNIA_SAN_MATEO_COUNTY_ALTERNATE_FILE'                => 'UE', 
	psourcename = 'CALIFORNIA_SANTA_BARBARA_COUNTY_ALTERNATE_FILE'            => 'UF', 
	psourcename = 'CALIFORNIA_SANTA_CLARA_COUNTY_ALTERNATE_FILE'              => 'UG', 
	psourcename = 'CALIFORNIA_SANTA_CRUZ_COUNTY_ALTERNATE_FILE'               => 'UH', 
	psourcename = 'CALIFORNIA_SISKIYOU_COUNTY_SUPERIOR_COURT'                 => 'UI', 
	psourcename = 'CALIFORNIA_SONOMA_COUNTY'                                  => 'UJ',
	psourcename = 'CALIFORNIA_TEHAMA_COUNTY'                                  => 'UK', 
	psourcename = 'CALIFORNIA_VENTURA_COUNTY_ALTERNATE_FILE'                  => 'UL',
  psourcename = 'COLORADO_DENVER_COUNTY' 														=> 'QN',  
	psourcename = 'FLORIDA_LAKE_COUNTY' 													    => 'QM', 
  psourcename = 'FLORIDA_INDIAN_RIVER_COUNTY' 											=> 'UO', 	
  psourcename = 'MISSISSIPPI_HARRISON_COUNTY' 											=> 'VD',
  psourcename = 'OHIO_AUGLAIZE_COUNTY'    		  										=> 'VK', 
	psourcename = 'OHIO_CHAMPAIGN_COUNTY' 					    							=> 'VR',  
	psourcename = 'OHIO_LAKE_COUNTY' 																	=> 'QO',
  psourcename = 'OHIO_LAKE_COUNTY_MENTOR_MUNICIPAL_COURT' 					=> 'QP',
  psourcename = 'OHIO_LAKE_COUNTY_PAINESVILLE_MUNICIPAL_COURT' 			=> 'QQ',
  psourcename = 'OHIO_SANDUSKY_COUNTY' 															=> 'QR',
  psourcename = 'OHIO_MEDINA_COUNTY' 																=> 'QS',
  psourcename = 'OHIO_MEDINA_COUNTY_MUNICIPAL_COURT' 								=> 'QT',
  psourcename = 'OHIO_HAMILTON_COUNTY' 															=> 'QU',
  psourcename = 'OHIO_ADAMS_COMMON_PLEAS_COURT' 										=> 'QV',
  psourcename = 'OHIO_ADAMS_COUNTY_COURT' 													=> 'QW',
	psourcename = 'OHIO_BROWN_COUNTY_BROWN_MUNICIPAL_TRAFFIC_COURT' 	=> 'QY',
  psourcename = 'OHIO_MAHONING_COUNTY' 															=> 'QZ',
  psourcename = 'OHIO_HANCOCK_COUNTY' 															=> 'RY',
  //psourcename = 'OHIO_HANCOCK_COUNTY_WEBSITE' 											=> '', 
  psourcename = 'OHIO_HARDIN_COUNTY' 																=> 'RJ',
  psourcename = 'OHIO_PICKAWAY_COUNTY_COMMON_PLEAS_COURT' 					=> 'RK',
  psourcename = 'OHIO_RICHLAND_COUNTY' 															=> 'RL',
  psourcename = 'OHIO_RICHLAND_COUNTY_MANSFIELD_MUNICIPAL_COURT' 		=> 'RM',
  psourcename = 'OHIO_WAYNE_COUNTY' 																=> 'RN',	
  psourcename = 'OHIO_PUTNAM_COUNTY' 																=> 'RO',
  psourcename = 'TENNESSEE_HAMILTON_COUNTY' 												=> 'RP',
	psourcename = 'TENNESSEE_RUTHERFORD_COUNTY'                       => 'RQ',
  psourcename = 'TENNESSEE_METHAMPHETAMINE_CONVICTIONS_FILE' 			  => 'UC',  
	psourcename = 'SOUTH_CAROLINA_GREENVILLE_COUNTY' 									=> 'RR',
  psourcename = 'SOUTH_CAROLINA_GREENVILLE_COUNTY_CURCUIT_COURTS' 	=> 'RS',
  psourcename = 'SOUTH_CAROLINA_GREENVILLE_COUNTY_SUMMARY_COURTS' 	=> 'RT',
  psourcename = 'SOUTH_CAROLINA_YORK_COUNTY' 												=> 'RU',
  psourcename = 'TEXAS_TRAVIS_COUNTY' 															=> 'RV',
  psourcename = 'TEXAS_WILLIAMSON_COUNTY' 													=> 'RW',
  psourcename = 'TEXAS_WALLER_COUNTY' 															=> 'RX',
  
//------------------------------------------County Phase2 20130716---------------------------------------------------------------------
	psourcename = 'FLORIDA_FLAGLER_COUNTY'  											=> 'UN',
  psourcename = 'FLORIDA_OKALOOSA_COUNTY' 											=> 'UP',
  psourcename = 'FLORIDA_SEMINOLE_COUNTY' 											=> 'UQ',
  psourcename = 'FLORIDA_ST_JOHNS_COUNTY' 											=> 'UR',
  psourcename = 'GEORGIA_CHATHAM_COUNTY'  											=> 'UX',
  psourcename = 'ILLINOIS_COUNTY_CIRCUIT_CLERK_OF_COURTS' 			=> 'US',
  psourcename = 'ILLINOIS_DUPAGE_COUNTY'  											=> 'UU',
  psourcename = 'ILLINOIS_MCLEAN_COUNTY'  											=> 'UV',
  psourcename = 'KANSAS_JOHNSON_COUNTY'   											=> 'UW',
  psourcename = 'MICHIGAN_MACOMB_COUNTY' 	  										=> 'UY',
  psourcename = 'MICHIGAN_OAKLAND_COUNTY' 											=> 'UZ',
	psourcename = 'MICHIGAN_SAGINAW_COUNTY' 											=> 'VC',
  psourcename = 'MICHIGAN_THIRTEENTH_CIRCUIT_COURT' 						=> 'VV',
  psourcename = 'NEVADA_CLARK_COUNTY_JUSTICE_COURTS' 						=> 'VF',
  psourcename = 'NEW_MEXICO_BERNALILLO_COUNTY' 	      					=> 'VG',
  psourcename = 'OHIO_ASHLAND_COUNTY'     											=> 'VI',
  psourcename = 'OHIO_ASHTABULA_COUNTY' 	 											=> 'VJ',
  psourcename = 'OHIO_BELMONT_COUNTY_COURT_EASTERN_DISTRICT'  	=> 'VL',
  psourcename = 'OHIO_BELMONT_COUNTY_COURT_NORTHERN_DISTRICT' 	=> 'VM',
  psourcename = 'OHIO_BELMONT_COUNTY_COURT_WESTERN_DISTRICT'  	=> 'VN',
  psourcename = 'OHIO_BUTLER_COUNTY_HAMILTON_MUNICIPAL_COURT' 	=> 'VO',
  psourcename = 'OHIO_BUTLER_COUNTY_MIDDLETOWN_MUNICIPAL_COURT' => 'VP',
  psourcename = 'OHIO_COSHOCTON_COMMON_PLEAS_COURT' 	          => 'VU',
  psourcename = 'OHIO_COSHOCTON_COUNTY_MUNICIPAL_COURT'       	=> 'VW',
  psourcename = 'OHIO_COSHOCTON_COUNTY_MUNICIPAL_COURT_WEBSITE' => '',//'VW',
  psourcename = 'OHIO_CRAWFORD_COUNTY'                         	=> 'VX',
  psourcename = 'OHIO_CUYAHOGA_COUNTY_BEDFORD_MUNICIPAL_COURT' 	=> 'VY',
  psourcename = 'OHIO_CUYAHOGA_COUNTY_EAST_CLEVELAND_MUNICIPAL_COURT' 	=> 'VZ',
  psourcename = 'OHIO_CUYAHOGA_COUNTY_GARFIELD_HEIGHTS_MUNICIPAL_COURT' => 'WM',
  psourcename = 'OHIO_CUYAHOGA_COUNTY_PARMA_MUNICIPAL_COURT' 	          => 'WN',
  psourcename = 'OHIO_CUYAHOGA_COUNTY_ROCKY_RIVER_MUNICIPAL_COURT' 	    => 'WO',
  psourcename = 'OHIO_CUYAHOGA_COUNTY_SHAKER_HEIGHTS_MUNICIPAL_COURT' 	=> 'WP',
  psourcename = 'OHIO_ERIE_COUNTY_VERMILION_MUNICIPAL_COURT' 	          => 'WQ',
  psourcename = 'OHIO_GEAUGA_COUNTY_CHARDON_MUNICIPAL_COURT' 	          => 'WR',
  
  psourcename = 'OHIO_GUERNSEY_COUNTY_CAMBRIDGE_MUNICIPAL_COURT' 	      => 'WT', 
  psourcename = 'OHIO_HIGHLAND_COUNTY_HILLSBORO_MUNICIPAL_COURT' 	      => 'WU',
  psourcename = 'OHIO_JACKSON_COUNTY_MUNICIPAL_COURT' 	                => 'WW',
  psourcename = 'OHIO_JEFFERSON_COUNTY_DILLONVALE' 	                    => 'WX',
  psourcename = 'OHIO_JEFFERSON_COUNTY_TORONTO' 	                			=> 'WS',
  psourcename = 'OHIO_JEFFERSON_COUNTY_WINTERSVILLE' 	            			=> 'WZ',
  psourcename = 'OHIO_KNOX_COUNTY_COMMON_PLEAS_COURT' 	          			=> 'XX',
  psourcename = 'OHIO_KNOX_COUNTY_MOUNT_VERNON_MUNICIPAL_COURT' 				=> 'XY',
  psourcename = 'OHIO_LORAIN_COUNTY_AVON_LAKE_MUNICIPAL_COURT' 	  			=> 'XZ',
  psourcename = 'OHIO_LORAIN_COUNTY' 	                            			=> 'YA',
  psourcename = 'OHIO_LORAIN_COUNTY_ELYRIA_MUNICIPAL_COURT' 	    			=> 'YB',
  psourcename = 'OHIO_LORAIN_COUNTY_MUNICIPAL_COURT' 	            			=> 'YC',
  psourcename = 'OHIO_LORAIN_COUNTY_OBERLIN_MUNICIPAL_COURT' 	    			=> 'YD',
  psourcename = 'OHIO_LUCAS_COUNTY_MAUMEE_MUNICIPAL_COURT' 	      			=> 'YE',
  psourcename = 'OHIO_LUCAS_COUNTY_SYLVANIA_MUNICIPAL_COURT' 	    			=> 'YF',
  psourcename = 'OHIO_LUCAS_COUNTY_SYLVANIA_MUNICIPAL_COURT_WEBSITE'  	=> '',//'YG',
  psourcename = 'OHIO_MARION_COUNTY' 																		=> 'YH',
  psourcename = 'OHIO_MONTGOMERY_MIAMISBURG_MUNICIPAL_COURT' 						=> 'YK',
  psourcename = 'OHIO_MUSKINGUM_COUNTY_MUNICIPAL_COURT' 							  => 'YL',
  psourcename = 'OHIO_OTTAWA_COUNTY_MUNICIPAL_COURT' 										=> 'YM',
  psourcename = 'OHIO_PERRY_COUNTY_COURT' 															=> 'YN',
 //------------------------------------------County Phase2 20130909---------------------------------------------------------------------
  psourcename = 'SOUTH_CAROLINA_ABBEVILLE_COUNTY_CIRCUIT_COURTS'    => 'ZC',
  psourcename = 'SOUTH_CAROLINA_ABBEVILLE_COUNTY_SUMMARY_COURTS'    => 'ZD',
  psourcename = 'SOUTH_CAROLINA_AIKEN_COUNTY_CIRCUIT_COURTS'  	    => 'ZE',
  psourcename = 'SOUTH_CAROLINA_AIKEN_COUNTY_SUMMARY_COURTS'  	    => 'ZF',
  psourcename = 'SOUTH_CAROLINA_ALLENDALE_COUNTY_CIRCUIT_COURTS'    => 'ZG',
  psourcename = 'SOUTH_CAROLINA_ALLENDALE_COUNTY_SUMMARY_COURTS'    => 'ZH',
  psourcename = 'SOUTH_CAROLINA_BAMBERG_COUNTY_CIRCUIT_COURTS'  	  => 'ZI',
  psourcename = 'SOUTH_CAROLINA_BAMBERG_COUNTY_SUMMARY_COURTS'  	  => 'ZJ',
  psourcename = 'SOUTH_CAROLINA_BARNWELL_COUNTY_CIRCUIT_COURTS'  	  => 'ZK',
  psourcename = 'SOUTH_CAROLINA_BARNWELL_COUNTY_SUMMARY_COURTS'  	  => 'ZL',
  psourcename = 'SOUTH_CAROLINA_BERKELEY_COUNTY_CIRCUIT_COURTS'  	  => 'ZM',
  psourcename = 'SOUTH_CAROLINA_BERKELEY_COUNTY_SUMMARY_COURTS'  	  => 'ZN',
  psourcename = 'SOUTH_CAROLINA_CALHOUN_COUNTY_CIRCUIT_COURTS'  	  => 'ZO',
  psourcename = 'SOUTH_CAROLINA_CALHOUN_COUNTY_SUMMARY_COURTS'  	  => 'ZP',
  psourcename = 'SOUTH_CAROLINA_CHEROKEE_COUNTY_CIRCUIT_COURTS'  	  => 'ZQ',
  psourcename = 'SOUTH_CAROLINA_CHEROKEE_COUNTY_SUMMARY_COURTS'  	  => 'ZR',
  psourcename = 'SOUTH_CAROLINA_CHESTER_COUNTY_CIRCUIT_COURTS'  	  => 'ZS',
  psourcename = 'SOUTH_CAROLINA_CHESTER_COUNTY_SUMMARY_COURTS'  	  => 'ZT',
  psourcename = 'SOUTH_CAROLINA_CLARENDON_COUNTY_CIRCUIT_COURTS'  	=> 'ZU',
  psourcename = 'SOUTH_CAROLINA_CLARENDON_COUNTY_SUMMARY_COURTS'  	=> 'ZV',
  psourcename = 'SOUTH_CAROLINA_COLLETON_COUNTY_CIRCUIT_COURTS'  	  => 'ZW',
  psourcename = 'SOUTH_CAROLINA_COLLETON_COUNTY_SUMMARY_COURTS'  	  => 'ZX',
  psourcename = 'SOUTH_CAROLINA_DARLINGTON_COUNTY_CIRCUIT_COURTS'  	=> 'ZY',
  psourcename = 'SOUTH_CAROLINA_DARLINGTON_COUNTY_SUMMARY_COURTS'  	=> 'ZZ',
  psourcename = 'SOUTH_CAROLINA_DILLON_COUNTY_CIRCUIT_COURTS'  	    => '3A',
  psourcename = 'SOUTH_CAROLINA_DILLON_COUNTY_SUMMARY_COURTS'  	    => '3B',
  psourcename = 'SOUTH_CAROLINA_DORCHESTER_COUNTY_CIRCUIT_COURTS'  	=> '6F',
  psourcename = 'SOUTH_CAROLINA_DORCHESTER_COUNTY_SUMMARY_COURTS'  	=> '6G',
  psourcename = 'SOUTH_CAROLINA_EDGEFIELD_COUNTY_CIRCUIT_COURTS'  	=> '3P',
  psourcename = 'SOUTH_CAROLINA_EDGEFIELD_COUNTY_SUMMARY_COURTS'  	=> '3S',
  psourcename = 'SOUTH_CAROLINA_FAIRFIELD_COUNTY_CIRCUIT_COURTS'  	=> '3T',
  psourcename = 'SOUTH_CAROLINA_FAIRFIELD_COUNTY_SUMMARY_COURTS'  	=> '3U',
  psourcename = 'SOUTH_CAROLINA_FLORENCE_COUNTY_CIRCUIT_COURTS'  	  => '3V',
  psourcename = 'SOUTH_CAROLINA_GEORGETOWN_COUNTY_CIRCUIT_COURTS'  	=> '3W',
  psourcename = 'SOUTH_CAROLINA_GEORGETOWN_COUNTY_SUMMARY_COURTS'  	=> '3Z',
  psourcename = 'SOUTH_CAROLINA_GREENWOOD_COUNTY_CIRCUIT_COURTS'  	=> '4A',
  psourcename = 'SOUTH_CAROLINA_GREENWOOD_COUNTY_SUMMARY_COURTS'  	=> '4H',
  psourcename = 'SOUTH_CAROLINA_HAMPTON_COUNTY_CIRCUIT_COURTS'  	  => '4I',  
  psourcename = 'SOUTH_CAROLINA_HAMPTON_COUNTY_SUMMARY_COURTS'  	  => '4J',  
  psourcename = 'SOUTH_CAROLINA_HORRY_COUNTY_CIRCUIT_COURTS'  	    => '4K',    
  psourcename = 'SOUTH_CAROLINA_HORRY_COUNTY_SUMMARY_COURTS'  	    => '4L',    
  psourcename = 'SOUTH_CAROLINA_KERSHAW_COUNTY_CIRCUIT_COURTS'  	  => '4M',  
  psourcename = 'SOUTH_CAROLINA_KERSHAW_COUNTY_SUMMARY_COURTS'  	  => '4N',  
  psourcename = 'SOUTH_CAROLINA_LANCASTER_COUNTY_CIRCUIT_COURTS'  	=> '4O',
  psourcename = 'SOUTH_CAROLINA_LANCASTER_COUNTY_SUMMARY_COURTS'  	=> '4P',
  psourcename = 'SOUTH_CAROLINA_LAUREN_COUNTY_CIRCUIT_COURTS'  	    => '4Q',   
  psourcename = 'SOUTH_CAROLINA_LAUREN_COUNTY_SUMMARY_COURTS'  	    => '4R',   
  psourcename = 'SOUTH_CAROLINA_LEXINGTON_COUNTY_CIRCUIT_COURTS'  	=> '4S',
  psourcename = 'SOUTH_CAROLINA_LEXINGTON_COUNTY_SUMMARY_COURTS'  	=> '4T',
  psourcename = 'SOUTH_CAROLINA_MARION_COUNTY_CIRCUIT_COURTS'  	    => '4U',   
  psourcename = 'SOUTH_CAROLINA_MARION_COUNTY_SUMMARY_COURTS'  	    => '4V',

 //------------------------------------------County Phase2 20131209---------------------------------------------------------------------	
  psourcename = 'CALIFORNIA_SACRAMENTO_COUNTY_SUPERIOR_COURT_WEBSITE'	  => 'TU',
  psourcename = 'OHIO_CLERMONT_TRAFFIC'                               	=> '6K',
  psourcename = 'OHIO_PREBLE_COUNTY_COMMON_PLEAS_COURT'                 => 'YO',
  psourcename = 'OHIO_PREBLE_COUNTY_EATON_MUNICIPAL_COURT'              => '6J',
  //psourcename = 'OHIO_SENECA_COUNTY_TIFFIN_MUNICIPAL_COURT'            	=> 'YS', //comment this later
  psourcename = 'OHIO_SHELBY_COUNTY_SIDNEY_MUNICIPAL_COURT'             => 'YT',
  psourcename = 'OHIO_TRUMBULL_COUNTY_GIRARD_MUNICIPAL_COURT'           => 'YU',
  psourcename = 'OHIO_WASHINGTON_COUNTY_MARIETTA_MUNICIPAL_COURT'      	=> 'YW',
  psourcename = 'OHIO_WOOD_COUNTY'                                     	=> 'YY',
  psourcename = 'OHIO_WOOD_COUNTY_BOWLING_GREEN_MUNICIPAL_COURT'      	=> 'YZ',
  psourcename = 'OKLAHOMA_DISTRICT_COURTS'                            	=> '5W',
  psourcename = 'OKLAHOMA_DISTRICT_COURTS_HISTORY_FILE'               	=> '5W',
  psourcename = 'SOUTH_CAROLINA_MARLBORO_COUNTY_CIRCUIT_COURTS'       	=> '4W',
  psourcename = 'SOUTH_CAROLINA_MARLBORO_COUNTY_SUMMARY_COURTS'         => '4X',
  psourcename = 'SOUTH_CAROLINA_MCCORMICK_COUNTY_CIRCUIT_COURTS'       	=> '4Y',
  psourcename = 'SOUTH_CAROLINA_MCCORMICK_COUNTY_SUMMARY_COURTS'       	=> '4Z',
  psourcename = 'SOUTH_CAROLINA_NEWBERRY_COUNTY_CIRCUIT_COURTS'       	=> 'YG', 
  psourcename = 'SOUTH_CAROLINA_NEWBERRY_COUNTY_SUMMARY_COURTS'       	=> '5A',
  psourcename = 'SOUTH_CAROLINA_OCONEE_COUNTY_CIRCUIT_COURTS'           => '5B',
  psourcename = 'SOUTH_CAROLINA_OCONEE_COUNTY_SUMMARY_COURTS'           => '5C',
  psourcename = 'SOUTH_CAROLINA_ORANGEBURG_COUNTY_CIRCUIT_COURTS'       => '5D',
  psourcename = 'SOUTH_CAROLINA_ORANGEBURG_COUNTY_SUMMARY_COURTS'       => '5E',
  psourcename = 'SOUTH_CAROLINA_PICKENS_COUNTY_CIRCUIT_COURTS'          => '5F',
  psourcename = 'SOUTH_CAROLINA_PICKENS_COUNTY_SUMMARY_COURTS'          => '5G',
  psourcename = 'SOUTH_CAROLINA_RICHLAND_COUNTY_SUMMARY_COURTS'       	=> '5H',
  psourcename = 'SOUTH_CAROLINA_SALUDA_COUNTY_CIRCUIT_COURTS'         	=> '5I',
  psourcename = 'SOUTH_CAROLINA_SALUDA_COUNTY_SUMMARY_COURTS'           => '5J',
  psourcename = 'SOUTH_CAROLINA_SPARTANBURG_COUNTY_CIRCUIT_COURTS'      => '5K',
  psourcename = 'SOUTH_CAROLINA_SPARTANBURG_COUNTY_SUMMARY_COURTS'    	=> '5L',
  psourcename = 'SOUTH_CAROLINA_UNION_COUNTY_CIRCUIT_COURTS'          	=> '5M',
  psourcename = 'SOUTH_CAROLINA_UNION_COUNTY_SUMMARY_COURTS'            => '5N',
  psourcename = 'SOUTH_CAROLINA_WILLIAMSBURG_COUNTY_CIRCUIT_COURTS'     => '5O',
  psourcename = 'SOUTH_CAROLINA_WILLIAMSBURG_COUNTY_SUMMARY_COURTS'     => '5P',
  psourcename = 'TENNESSEE_DAVIDSON_COUNTY'                             => '5Q',
  psourcename = 'TEXAS_BOWIE_COUNTY'                                    => '5S',
  psourcename = 'TEXAS_FRANKLIN_COUNTY'                                 => '5X',
  psourcename = 'TEXAS_GALVESTON_COUNTY'                                => '5Y',
  psourcename = 'TEXAS_HOPKINS_COUNTY_COURT'                          	=> '5Z',
  psourcename = 'TEXAS_HOPKINS_COUNTY_DISTRICT_COURT'                 	=> '6A',
  psourcename = 'TEXAS_ORANGE_COUNTY_COURT'                             => '6C',
  psourcename = 'TEXAS_SMITH_COUNTY'                                    => '6E',
 //------------------------------------------County Phase2 20150113---------------------------------------------------------------------	
  psourcename = 'TEXAS_BURNET_COUNTY'                                  => '6L',
  psourcename = 'OHIO_BUTLER_FAIRFIELD_MUNICIPAL_COURT'                => '6M',
  psourcename = 'OHIO_GEAUGA_COUNTY_CHARDON_MUNICIPAL_COURT_WEBSITE'   => '6N',
  psourcename = 'OHIO_GALLIA_COUNTY'                                   => '6P',
  psourcename = 'TEXAS_CAMERON_COUNTY'                                 => '6Q',
  psourcename = 'TEXAS_CHAMBERS_COUNTY'                                => '6R',  
	psourcename = 'TEXAS_EL_PASO_COUNTY_COURT'                           => '6S',                                                                         
  //psourcename = 'PENNSYLVANIA_ADMINISTRATOR_OF_THE_COURTS_PHILADELPHIA MUNICIPAL COURT' => '6U',    
  psourcename = 'OHIO_CLARK_MUNICIPAL_COURT'                           => '6O', 
	psourcename = 'OHIO_CLARK_COUNTY_COMMON_PLEAS_COURT'                 => '6T',
  psourcename = 'OHIO_CUYAHOGA_COMMON_PLEAS_COURT'                     => '6Y',                                                                     

//------------------------------------------County Phase3 20150713---------------------------------------------------------------------                       
	psourcename = 'CALIFORNIA_SHASTA_COUNTY_SUPERIOR_COURT'              => '7C',
  psourcename = 'FLORIDA_COLLIER'                                      => '7D',
  psourcename = 'FLORIDA_COLLIER_TRAFFIC'                              => '7E',
	psourcename = 'FLORIDA_MARTIN_COUNTY'                                => '7F',
  psourcename = 'MINNESOTA_DISTRICT_COURTS'                            => '7G',
  psourcename = 'OHIO_GALLIA_COUNTY_GALLIPOLIS_MUNICIPAL_COURT'        => '7H',
	psourcename = 'OHIO_MONROE_COUNTY_COMMON_PLEAS_COURT'                => '7I',   
  psourcename = 'OHIO_MORROW_COUNTY_MUNICIPAL_COURT'                   => '7J',
  psourcename = 'TEXAS_BELL_COUNTY'                                    => '7K',
	psourcename = 'TEXAS_HOOD_COUNTY'                                    => '7L',
  psourcename = 'TEXAS_JEFFERSON_COUNTY_DISTRICT_COURT'                => '7M',
  psourcename = 'TEXAS_LAMAR_COUNTY'                                   => '7N',
	psourcename = 'TEXAS_LAMAR_COUNTY_JUSTICE_OF_THE_PEACE_COURTS'       => '7O',
  psourcename = 'TEXAS_LIBERTY_COUNTY'                                 => '7P',
  psourcename = 'FLORIDA_PASCO_COUNTY'                                 => '7R',
	psourcename = 'FLORIDA_PASCO_COUNTY_TRAFFIC'                         => '7S',
//------------------------------------------County Phase3 20151028---------------------------------------------------------------------
	psourcename = 'ARIZONA_MARICOPA_COUNTY_SUPERIOR_COURT_FILINGS'       => '7T',
	psourcename = 'DISTRICT_OF_COLUMBIA_SUPERIOR_COURT'                  => '7U',
	psourcename = 'FLORIDA_ESCAMBIA_COUNTY_CIRCUIT_COURT'                => '7V',
	psourcename = 'FLORIDA_FLAGLER_COUNTY_CIRCUIT_COURT'                 => '7W',
	psourcename = 'FLORIDA_MANATEE_CIRCUIT_AND_COUNTY_COURTS'            => '7X',
	psourcename = 'ILLINOIS_COOK_COUNTY_MISDEMEANOR'                     => '7Y',
	psourcename = 'ILLINOIS_PEORIA_COUNTY'                               => '7Z',
	psourcename = 'NEVADA_CLARK_COUNTY_DISTRICT_COURTS'                  => '8A',
  psourcename = 'FLORIDA_PUTNAM_COUNTY'                                => '8B',
	psourcename = 'FLORIDA_PUTNAM_COUNTY_TRAFFIC'                        => '8C',
	psourcename = 'OHIO_SHELBY_COUNTY_COMMON_PLEAS_COURT'                => '8D',
	psourcename = 'TEXAS_LIBERTY_COUNTY_DISTRICT_COURT'                  => '8E',
	psourcename = 'FLORIDA_HILLSBOROUGH_COUNTY_TRAFFIC'                  => '8I',
//------------------------------------------County Phase3 20160929---------------------------------------------------------------------
	psourcename = 'OHIO_MADISON_COMMON_PLEAS_COURT'                       => '8J',
	psourcename = 'OHIO_SANDUSKY_COUNTY_COMMON_PLEAS_COURT'               => '8K',
	psourcename = 'TEXAS_BEXAR_COUNTY_DISTRICT_COURTS'                    => '8L',
	
	psourcename = 'OHIO_FAYETTE_COUNTY_COMMON_PLEAS_COURT'                => '8M', 
	psourcename = 'OHIO_HURON_COUNTY_NORWALK_MUNICIPAL_COURT'             => '8N',
	psourcename = 'OHIO_LUCAS_COUNTY_COMMON_PLEAS_COURT'                  => '8O',
	psourcename = 'OHIO_CUYAHOGA_COUNTY_CLEVELAND_MUNICIPAL_COURT'        => '8P',//done
	psourcename = 'OHIO_CUYAHOGA_COUNTY_CLEVELANDHEIGHTS_MUNICIPAL_COURT' => '8Q',//done
	psourcename = 'TENNESSEE_HAMILTON_CRIMINAL_COURT'                     => '8R',
	psourcename = 'TEXAS_COLLIN_COUNTY_WEBSITE'                           => '8S',

//------------------------------------------County VC 20160123 DF-18051(Dec)-----------------------------------------------------
	psourcename = 'FLORIDA_CITRUS_COUNTY'                                 => '8T',
	psourcename = 'OHIO_STARK_COUNTY_ALLIANCE_MUNICIPAL_COURT'            => '8U',
//------------------------------------------County VC 20160123 DF-18331(Jan)-----------------------------------------------------
	psourcename = 'OHIO_COLUMBIANA_COUNTY_EASTLIVERPOOL_MUNICIPAL_COURT'  => '8V',
	psourcename = 'OHIO_CUYAHOGA_COUNTY_LAKEWOOD_MUNICIPAL_COURT'         => '8W',
	psourcename = 'OHIO_JEFFERSON_COUNTY_STEUBENVILLE'                    => '8X',
	psourcename = 'OHIO_MONTGOMERY_COUNTY_COMMON_PLEAS_COURT'             => '8Y',
	psourcename = 'OHIO_PAULDING_COUNTY'                                  => '8Z',
	psourcename = 'OHIO_TRUMBULL_COUNTY_WARREN_MUNICIPAL_COURT'           => '9A',
	psourcename = 'OHIO_CUYAHOGA_COUNTY_LYNDHURST_MUNICIPAL_COURT'        => '9B',
	psourcename = 'OHIO_GEAUGA_COUNTY_COMMON_PLEAS_COURT'                 => '9C',
	psourcename = 'OHIO_MERCER_COUNTY_COMMON_PLEAS_COURT'                 => '9D',
	psourcename = 'OHIO_GREENE_COUNTY_FAIRBORN_MUNICIPAL_COURT'           => '9E',
	psourcename = 'OHIO_JEFFERSON_COMMON_PLEAS_COURT'                     => '9F',
	psourcename = 'OHIO_LAWRENCE_COUNTY_COMMON_PLEAS_COURT'               => '9G',
	psourcename = 'OHIO_LICKING_COUNTY_MUNICIPAL_COURT'                   => '9H',
	// psourcename = 'OHIO_MARION_COUNTY_MUNICIPAL_COURT'                    => '9I',
	psourcename = 'OHIO_MEDINA_COUNTY_WADSWORTH_MUNICIPAL_COURT'          => '9J',
	psourcename = 'OHIO_MEIGS_COUNTY_MUNICIPAL_COURT'                     => '9K',
	psourcename = 'FLORIDA_ST_LUCIE_COUNTY_CIRCUIT_COURT'                 => '9L',
	psourcename = 'OHIO_ASHTABULA_COMMON_PLEAS_COURT'                     => '9M',
	psourcename = 'OHIO_DARKE_COUNTY_MUNICIPAL_COURT'                     => '9N',
	psourcename = 'OHIO_FRANKLIN_COUNTY_COMMON_PLEAS'                     => '9O',
	//20170227
	psourcename = 'OHIO_SCIOTO_COUNTY_PORTSMOUTH_MUNICIPAL_COURT'         => '9P',
	psourcename = 'OHIO_SENECA_COUNTY_COMMON_PLEAS_COURT'                 => '9Q',	
	
//------------------------------------------County VC 20170303 DF-18331(Jan)-----------------------------------------------------	
	psourcename = 'OHIO_STARK_COUNTY_MASSILLON_MUNICIPAL_COURT'           => '9R',
	psourcename = 'OHIO_STARK_COUNTY_CANTON_MUNICIPAL_COURT'              => '9S',
	psourcename = 'OHIO_OTTAWA_COUNTY_COMMON_PLEAS_COURT'                 => '9T',
	psourcename = 'OHIO_UNION_COUNTY_COMMON_PLEAS_COURT'                  => '9U',
	psourcename = 'OHIO_WYANDOT_COUNTY_COMMON_PLEAS_COURT'                => '9V',
	psourcename = 'TEXAS_KAUFMAN_COUNTY'                                  => '9W',
	psourcename = 'TEXAS_RANDALL_COUNTY'                                  => '9X',

 //------------------------------------------County VC 20171025 -----------------------------------------------------
 psourcename = 'CALIFORNIA_EL_DORADO_COUNTY_SUPERIOR_COURT'            => '9Y',
 psourcename = 'FLORIDA_MANATEE_COUNTY'                                => '9Z',
 psourcename = 'OHIO_VINTON_COUNTY_COMMON_PLEAS_COURT'                 => '10A',
 psourcename = 'TEXAS_AUSTIN_COUNTY_MUNICIPAL_COURT'                   => '10B',
 psourcename = 'TEXAS_DALLAS_JUSTICE_OF_THE_PEACE_TRAFFIC'             => '10C',
 
//------------------------------------------Hygenics Crim Arrest Phase1 ---------------------------------------------- 
 psourcename = 'ALABAMA_BALDWIN_COUNTY_ARRESTS' => 'BA',
 psourcename = 'ALABAMA_CALHOUN_COUNTY_ARRESTS' => 'BB',
 psourcename = 'ALABAMA_HOUSTON_COUNTY_ARRESTS' => 'BC',
 psourcename = 'ALABAMA_JEFFERSON_COUNTY_ARRESTS' => 'BD',
 psourcename = 'ALABAMA_MOBILE_COUNTY_ARRESTS' => 'BE',
 psourcename = 'ALABAMA_MONTGOMERY_COUNTY_ARRESTS' => 'BF',
 psourcename = 'ALABAMA_SHELBY_COUNTY_ARRESTS' => 'BG',
 psourcename = 'ALABAMA_TUSCALOOSA_COUNTY_ARRESTS' => 'BH',
 psourcename = 'ARIZONA_MARICOPA_COUNTY_ARRESTS' => 'BL',
 psourcename = 'ARIZONA_PIMA_COUNTY_ARRESTS' => 'BM',
 psourcename = 'ARKANSAS_BENTON_COUNTY_ARRESTS' => 'BI',
 psourcename = 'ARKANSAS_UNION_COUNTY_ARRESTS' => 'BJ',
 psourcename = 'ARKANSAS_WASHINGTON_COUNTY_ARRESTS' => 'BK',
 psourcename = 'CALIFORNIA_FRESNO_COUNTY_ARRESTS' => 'BN',
 psourcename = 'CALIFORNIA_KERN_COUNTY_ARRESTS' => 'BO',
 psourcename = 'CALIFORNIA_KINGS_COUNTY_ARRESTS' => 'BP',
 psourcename = 'CALIFORNIA_LOS_ANGELES_COUNTY_ARRESTS' => 'BQ',
 psourcename = 'CALIFORNIA_MARIN_COUNTY_ARRESTS' => 'BR',
 psourcename = 'CALIFORNIA_ORANGE_COUNTY_ARRESTS' => 'BS',
 psourcename = 'CALIFORNIA_PLACER_COUNTY_ARRESTS' => 'BT',
 psourcename = 'CALIFORNIA_RIVERSIDE_COUNTY_ARRESTS' => 'BU',
 psourcename = 'CALIFORNIA_SACRAMENTO_COUNTY_ARRESTS' => 'BV',
 psourcename = 'CALIFORNIA_SAN_BERNARDINO_COUNTY_ARRESTS' => 'BW',
 psourcename = 'CALIFORNIA_SAN_DIEGO_COUNTY_ARRESTS' => 'BX',
 psourcename = 'CALIFORNIA_TEHAMA_COUNTY_ARRESTS' => 'BY',
 psourcename = 'COLORADO_EL_PASO_COUNTY_ARRESTS' => 'BZ',
 psourcename = 'COLORADO_MESA_COUNTY_ARRESTS' => 'CQ',
 psourcename = 'COLORADO_PITKIN_COUNTY_ARRESTS' => 'CR',
 psourcename = 'COLORADO_PUEBLO_COUNTY_ARRESTS' => 'CS',
 psourcename = 'COLORADO_WELD_COUNTY_ARRESTS' => 'CU',
 psourcename = 'CONNECTICUT_MADISON_COUNTY_ARRESTS' => 'CV',
 psourcename = 'FLORIDA_BREVARD_COUNTY_ARRESTS' => 'CW',
 psourcename = 'FLORIDA_BROWARD_COUNTY_ARRESTS' => 'CX',
 psourcename = 'FLORIDA_CHARLOTTE_COUNTY_ARRESTS' => 'CY',
 psourcename = 'FLORIDA_CITRUS_COUNTY_ARRESTS' => 'CZ',
 psourcename = 'FLORIDA_DESOTO_COUNTY_ARRESTS' => 'Z5', // replaced 'DE' with Z5 (VC),
 psourcename = 'FLORIDA_ESCAMBIA_COUNTY_ARRESTS' => 'FW',
 psourcename = 'FLORIDA_ESCAMBIA_COUNTY_ARRESTS_BLOTTER_FILE' => 'FX',
 psourcename = 'FLORIDA_HARDEE_COUNTY_ARRESTS' => 'FY',
 psourcename = 'FLORIDA_HERNANDO_COUNTY_ARRESTS' => 'FZ',
 psourcename = 'FLORIDA_HILLSBOROUGH_COUNTY_ARRESTS' => 'GE',
 psourcename = 'FLORIDA_INDIAN_RIVER_COUNTY_ARRESTS' => 'GF',
 psourcename = 'FLORIDA_LAKE_COUNTY_ARRESTS' => 'GG',
 psourcename = 'FLORIDA_LEE_COUNTY_ARRESTS' => 'GH',
 psourcename = 'FLORIDA_MARTIN_COUNTY_ARRESTS' => 'GI',
 psourcename = 'FLORIDA_MONROE_COUNTY_ARRESTS' => 'GJ',
 psourcename = 'FLORIDA_ORANGE_COUNTY_ARRESTS' => 'GK',
 psourcename = 'FLORIDA_OSCEOLA_COUNTY_ARRESTS' => 'GL',
 psourcename = 'FLORIDA_PALM_BEACH_COUNTY_ARRESTS' => 'GM',
 psourcename = 'FLORIDA_POLK_COUNTY_ARRESTS' => 'GN',
 psourcename = 'FLORIDA_PUTNAM_COUNTY_ARRESTS' => 'GO',
 psourcename = 'FLORIDA_SEMINOLE_COUNTY_ARRESTS' => 'GP',
 psourcename = 'FLORIDA_SUWANNEE_COUNTY_ARRESTS' => 'GQ',
 psourcename = 'FLORIDA_VOLUSIA_COUNTY_ARRESTS' => 'GR',
 psourcename = 'GEORGIA_BIBB_COUNTY_ARRESTS' => 'GS',
 psourcename = 'GEORGIA_CHATHAM_COUNTY_ARRESTS' => 'GT',
 psourcename = 'GEORGIA_CLARKE_COUNTY_ARRESTS' => 'GU',
 psourcename = 'GEORGIA_DAWSON_COUNTY_ARRESTS' => 'GV',
 psourcename = 'GEORGIA_FULTON_COUNTY_ARRESTS' => 'GW',
 psourcename = 'GEORGIA_GWINNETT_COUNTY_ARRESTS' => 'GX',
 psourcename = 'IDAHO_ADA_COUNTY_ARRESTS' => 'HB',
 psourcename = 'IDAHO_CANYON_COUNTY_ARRESTS' => 'HC',
 psourcename = 'IDAHO_KOOTENAI_COUNTY_ARRESTS' => 'HD',
 psourcename = 'ILLINOIS_COOK_COUNTY_ARRESTS' => 'HE',
 psourcename = 'ILLINOIS_PEORIA_COUNTY_ARRESTS' => 'HF',
 psourcename = 'ILLINOIS_WILL_COUNTY_ARRESTS' => 'HG',
 psourcename = 'IOWA_BUENA_VISTA_COUNTY_ARRESTS' => 'GY',
 psourcename = 'IOWA_DALLAS_COUNTY_ARRESTS' => 'GZ',
 psourcename = 'KANSAS_JOHNSON_COUNTY_ARRESTS' => 'HH',
 psourcename = 'KANSAS_WYANDOTTE_COUNTY_ARRESTS' => 'HJ',
 psourcename = 'KENTUCKY_BOONE_COUNTY_ARRESTS' => 'HK',
 psourcename = 'KENTUCKY_FULTON_COUNTY_ARRESTS' => 'HL',
 psourcename = 'KENTUCKY_MCCRACKEN_COUNTY_ARRESTS' => 'HM',
 psourcename = 'LOUISIANA_BOSSIER_COUNTY_ARRESTS' => 'HN',
 psourcename = 'LOUISIANA_EAST_BATON_ROUGE_COUNTY_ARRESTS' => 'HO',
 psourcename = 'LOUISIANA_LAFAYETTE_COUNTY_ARRESTS' => 'HP',
 psourcename = 'LOUISIANA_LAFOURCHE_COUNTY_ARRESTS' => 'HQ',
 psourcename = 'LOUISIANA_ORLEANS_COUNTY_ARRESTS' => 'HR',
 psourcename = 'LOUISIANA_OUACHITA_COUNTY_ARRESTS' => 'HS',
 psourcename = 'MASSACHUSETTS_BILLERICA_POLICE_ARRESTS' => 'HT',
 psourcename = 'MASSACHUSETTS_ORLEANS_POLICE_ARRESTS' => 'HU',
 psourcename = 'MASSACHUSETTS_WALTHAM_COUNTY_ARRESTS' => 'HV',
 psourcename = 'MASSACHUSETTS_WELLFLEET_POLICE_ARRESTS' => 'HW',
 psourcename = 'MASSACHUSETTS_WRENTHAM_POLICE_ARRESTS' => 'HX',
 psourcename = 'MICHIGAN_KENT_COUNTY_ARRESTS' => 'HY',
 psourcename = 'MICHIGAN_WAYNE_COUNTY_ARRESTS' => 'HZ',
 psourcename = 'MINNESOTA_DAKOTA_COUNTY_ARRESTS' => 'IE',
 psourcename = 'MINNESOTA_HENNEPIN_COUNTY_ARRESTS' => 'IF',
 psourcename = 'MINNESOTA_OLMSTED_COUNTY_ARRESTS' => 'IG',
 psourcename = 'MISSISSIPPI_HARRISON_COUNTY_ARRESTS' => 'IJ',
 psourcename = 'MISSISSIPPI_LEE_COUNTY_ARRESTS' => 'IK',
 psourcename = 'MISSOURI_CLAY_COUNTY_ARRESTS' => 'IH',
 psourcename = 'MISSOURI_ST_FRANCOIS_COUNTY_ARRESTS' => 'II',
 psourcename = 'MONTANA_MISSOULA_COUNTY_ARRESTS' => 'IO',
 psourcename = 'MONTANA_YELLOWSTONE_COUNTY_ARRESTS' => 'IP',
 psourcename = 'NEBRASKA_HALL_COUNTY_ARRESTS' => 'IZ',
 psourcename = 'NEVADA_CLARK_COUNTY_ARRESTS' => 'KE',
 psourcename = 'NEVADA_HUMBOLDT_COUNTY_ARRESTS' => 'KF',
 psourcename = 'NEW_JERSEY_HUNTERDON_COUNTY_ARRESTS' => 'KA',
 psourcename = 'NEW_MEXICO_BERNALILLO_COUNTY_ARRESTS' => 'KB',
 psourcename = 'NEW_MEXICO_SAN_JUAN_COUNTY_ARRESTS' => 'KC',
 psourcename = 'NEW_MEXICO_SANTA_FE_COUNTY_ARRESTS' => 'KD',
 psourcename = 'NEW_YORK_FULTON_POLICE_ARRESTS' => 'KG',
 psourcename = 'NEW_YORK_ONEIDA_COUNTY_ARRESTS' => 'KH',
 psourcename = 'NEW_YORK_ONONDAGA_COUNTY_ARRESTS' => 'KI',
 psourcename = 'NORTH_CAROLINA_CABARRUS_COUNTY_ARRESTS' => 'IQ',
 psourcename = 'NORTH_CAROLINA_CATAWBA_COUNTY_ARRESTS' => 'IR',
 psourcename = 'NORTH_CAROLINA_DURHAM_COUNTY_ARRESTS' => 'IS',
 psourcename = 'NORTH_CAROLINA_GUILFORD_COUNTY_ARRESTS' => 'IT',
 psourcename = 'NORTH_CAROLINA_LINCOLN_COUNTY_ARRESTS' => 'IU',
 psourcename = 'NORTH_CAROLINA_MECKLENBURG_COUNTY_ARRESTS' => 'IV',
 psourcename = 'NORTH_CAROLINA_RANDOLPH_COUNTY_ARRESTS' => 'IW',
 psourcename = 'NORTH_CAROLINA_ROWAN_COUNTY_ARRESTS' => 'IX',
 psourcename = 'NORTH_CAROLINA_UNION_COUNTY_ARRESTS' => 'IY',
 psourcename = 'OHIO_FAYETTE_COUNTY_ARRESTS' => 'KJ',
 psourcename = 'OHIO_GALLIA_COUNTY_ARRESTS' => 'KK',
 psourcename = 'OHIO_HAMILTON_COUNTY_ARRESTS' => 'KL',
 psourcename = 'OHIO_HIGHLAND_COUNTY_ARRESTS' => 'KM',
 psourcename = 'OHIO_LICKING_COUNTY_ARRESTS' => 'KN',
 psourcename = 'OHIO_LOGAN_COUNTY_ARRESTS' => 'KO',
 psourcename = 'OHIO_MONTGOMERY_COUNTY_ARRESTS' => 'KP',
 psourcename = 'OHIO_SANDUSKY_COUNTY_ARRESTS' => 'KQ',
 psourcename = 'OHIO_SHELBY_COUNTY_ARRESTS' => 'KR',
 psourcename = 'OHIO_SOUTHEAST_COUNTY_ARRESTS' => 'KT',
 psourcename = 'OHIO_WASHINGTON_COUNTY_ARRESTS' => 'KU',
 psourcename = 'OKLAHOMA_CARTER_COUNTY_ARRESTS' => 'KV',
 psourcename = 'OKLAHOMA_COMANCHE_COUNTY_ARRESTS' => 'KW',
 psourcename = 'OKLAHOMA_OSAGE_COUNTY_ARRESTS' => 'KX',
 psourcename = 'OREGON_CLACKAMAS_COUNTY_ARRESTS' => 'KZ',
 psourcename = 'OREGON_DESCHUTES_COUNTY_ARRESTS' => 'LC',
 psourcename = 'OREGON_DOUGLAS_COUNTY_ARRESTS' => 'LD',
 psourcename = 'OREGON_JACKSON_COUNTY_ARRESTS' => 'LE',
 psourcename = 'OREGON_JOSEPHINE_COUNTY_ARRESTS' => 'LF',
 psourcename = 'OREGON_LANE_COUNTY_ARRESTS' => 'LG',
 psourcename = 'OREGON_LINCOLN_COUNTY_ARRESTS' => 'LH',
 psourcename = 'OREGON_LINN_COUNTY_ARRESTS' => 'LI',
 psourcename = 'OREGON_MARION_COUNTY_ARRESTS' => 'LJ',
 psourcename = 'OREGON_MORROW_COUNTY_ARRESTS' => 'LK',
 psourcename = 'OREGON_MULTNOMAH_COUNTY_ARRESTS' => 'LL',
 psourcename = 'OREGON_POLK_COUNTY_ARRESTS' => 'LM',
 psourcename = 'OREGON_UMATILLA_COUNTY_ARRESTS' => 'LN',
 psourcename = 'OREGON_WASHINGTON_COUNTY_ARRESTS' => 'LO',
 psourcename = 'OREGON_YAMHILL_COUNTY_ARRESTS' => 'LP',
 psourcename = 'PENNSYLVANIA_LANCASTER_COUNTY_ARRESTS' => 'LQ',
 psourcename = 'PENNSYLVANIA_YORK_COUNTY_ARRESTS' => 'LR',
 psourcename = 'SOUTH_CAROLINA_CHEROKEE_COUNTY_ARRESTS' => 'LS',
 psourcename = 'SOUTH_CAROLINA_FLORENCE_COUNTY_ARRESTS' => 'LT',
 psourcename = 'SOUTH_CAROLINA_HORRY_COUNTY_ARRESTS' => 'LU',
 psourcename = 'SOUTH_CAROLINA_RICHLAND_COUNTY_ARRESTS' => 'LV',
 psourcename = 'SOUTH_CAROLINA_YORK_COUNTY_ARRESTS' => 'LW',
 psourcename = 'TENNESSEE_DAVIDSON_COUNTY_ARRESTS' => 'LX',
 psourcename = 'TENNESSEE_MONTGOMERY_COUNTY_ARRESTS' => 'LY',
 psourcename = 'TENNESSEE_SHELBY_COUNTY_ARRESTS' => 'LZ',
 psourcename = 'TEXAS_ARLINGTON_POLICE_ARRESTS' => 'MJ',
 psourcename = 'TEXAS_BEXAR_COUNTY_ARRESTS' => 'MK',
 psourcename = 'TEXAS_BRAZORIA_COUNTY_ARRESTS' => 'ML',
 psourcename = 'TEXAS_CAMERON_COUNTY_ARRESTS' => 'MM',
 psourcename = 'TEXAS_DALLAS_COUNTY_ARRESTS' => 'MP',
 psourcename = 'TEXAS_DENTON_COUNTY_ARRESTS' => 'MQ',
 psourcename = 'TEXAS_ECTOR_COUNTY_ARRESTS' => 'MR',
 psourcename = 'TEXAS_GREGG_COUNTY_ARRESTS' => 'MU',
 psourcename = 'TEXAS_HARRIS_COUNTY_ARRESTS' => 'MV',
 psourcename = 'TEXAS_MIDLAND_COUNTY_ARRESTS' => 'MW',
 psourcename = 'TEXAS_MONTGOMERY_COUNTY_ARRESTS' => 'MX',
 psourcename = 'TEXAS_PARKER_COUNTY_ARRESTS' => 'MY',
 psourcename = 'TEXAS_POTTER_COUNTY_ARRESTS' => 'MZ',
 psourcename = 'TEXAS_RANDALL_COUNTY_ARRESTS' => 'Z6', // replaced 'ND' with Z6 (VC),
 psourcename = 'TEXAS_SMITH_COUNTY_ARRESTS' => 'NI',
 psourcename = 'TEXAS_TOM_GREEN_COUNTY_ARRESTS' => 'NK',
 psourcename = 'TEXAS_WISE_COUNTY_ARRESTS' => 'NL',
 psourcename = 'UTAH_DAVIS_COUNTY_ARRESTS' => 'NO',
 psourcename = 'UTAH_IRON_COUNTY_ARRESTS' => 'NP',
 psourcename = 'UTAH_SALT_LAKE_COUNTY_ARRESTS' => 'NQ',
 psourcename = 'UTAH_SAN_PETE_COUNTY_ARRESTS' => 'NR',
 psourcename = 'UTAH_UTAH_COUNTY_ARRESTS' => 'NS',
 psourcename = 'UTAH_WASHINGTON_COUNTY_ARRESTS' => 'NT',
 psourcename = 'VIRGINIA_DANVILLE_POLICE_ARRESTS' => 'NU',
 psourcename = 'VIRGINIA_FAIRFAX_COUNTY_ARRESTS' => 'NW',
 psourcename = 'VIRGINIA_WASHINGTON_COUNTY_ARRESTS' => 'NX',
 psourcename = 'WASHINGTON_CLARK_COUNTY_ARRESTS' => 'Z7', // replaced 'NY' with Z7 (VC),
 psourcename = 'WASHINGTON_COWLITZ_COUNTY_ARRESTS' => 'NZ',
 psourcename = 'WASHINGTON_JEFFERSON_COUNTY_ARRESTS' => 'QA',
 psourcename = 'WASHINGTON_KITSAP_COUNTY_ARRESTS' => 'QB',
 psourcename = 'WASHINGTON_LEWIS_COUNTY_ARRESTS' => 'QC',
 psourcename = 'WASHINGTON_PIERCE_COUNTY_ARRESTS' => 'QD',
 psourcename = 'WASHINGTON_THURSTON_COUNTY_ARRESTS' => 'QE',
 psourcename = 'WASHINGTON_WHATCOM_COUNTY_ARRESTS'  => 'QF',
 psourcename = 'WISCONSIN_KENOSHA_COUNTY_ARRESTS'   => 'QG',
 psourcename = 'WEST_VIRGINIA_REGIONAL_ARRESTS'     => 'QH',

//------------------------------------------Hygenics Crim Arrest Phase2 Batch4 ---------------------------------------------- 	
 psourcename = 'KENTUCKY_MONROE_COUNTY_ARRESTS' => '6I',
/***************************************************HYGENICS CRIM END************************************************************/ 

/************************************************HYGENICS CRIMWISE START*********************************************************/
//------------------------------------------Hygenics Crimwise AOC Batch1----------------------------------------------
 psourcename = 'ILLINOIS_ADMINISTRATOR_OF_THE_COURTS_CW                        ' => 'W0001',
 psourcename = 'MINNESOTA_ADMINISTRATOR_OF_THE_COURTS_CW                       ' => 'W0002',
 psourcename = 'VIRGINIA_ADMINISTRATOR_OF_THE_COURTS_CIRCUIT_COURTS_WEBSITE_CW ' => 'W0003',
 psourcename = 'VIRGINIA_ADMINISTRATOR_OF_THE_COURTS_DISTRICT_COURTS_WEBSITE_CW' => 'W0004',          
					
//------------------------------------------Hygenics Crimwise County Batch1----------------------------------------------
 psourcename = 'CALIFORNIA_AMADOR_COUNTY_CW                                    ' => 'W0005',
 psourcename = 'CALIFORNIA_COLUSA_COUNTY_CW                                    ' => 'W0006',
 psourcename = 'CALIFORNIA_EL_DORADO_COUNTY_CW                                 ' => 'W0007',
 psourcename = 'CALIFORNIA_HUMBOLDT_COUNTY_CW                                  ' => 'W0008',
 psourcename = 'CALIFORNIA_IMPERIAL_COUNTY_CW                                  ' => 'W0009',
 psourcename = 'CALIFORNIA_KERN_COUNTY_CW                                      ' => 'W0010',
 psourcename = 'CALIFORNIA_LAKE_COUNTY_CW                                      ' => 'W0011',
 psourcename = 'CALIFORNIA_LAKE_COUNTY_SUPERIOR_COURT_CW                       ' => 'W0012',
 psourcename = 'CALIFORNIA_LASSEN_COUNTY_CW                                    ' => 'W0013',
 psourcename = 'CALIFORNIA_MADERA_COUNTY_CW                                    ' => 'W0014',
 psourcename = 'CALIFORNIA_MARIN_COUNTY_WEBSITE_CW                             ' => 'W0015',
 psourcename = 'CALIFORNIA_MENDOCINO_COUNTY_CW                                 ' => 'W0016',
 psourcename = 'CALIFORNIA_MONTEREY_COUNTY_CW                                  ' => 'W0017',
 psourcename = 'CALIFORNIA_NAPA_COUNTY_CW                                      ' => 'W0018',
 psourcename = 'CALIFORNIA_PLACER_COUNTY_CW                                    ' => 'W0019',
 psourcename = 'CALIFORNIA_SAN_BENITO_COUNTY_CW                                ' => 'W0020',
 psourcename = 'CALIFORNIA_SAN_JOAQUIN_COUNTY_CW                               ' => 'W0021',
 psourcename = 'CALIFORNIA_SUTTER_COUNTY_CW                                    ' => 'W0022',
 psourcename = 'CALIFORNIA_TULARE_COUNTY_WEBSITE_CW                            ' => 'W0023',
 psourcename = 'CALIFORNIA_TUOLUMNE_COUNTY_CW                                  ' => 'W0024',
 psourcename = 'CALIFORNIA_YOLO_COUNTY_CW                                      ' => 'W0025',
 psourcename = 'INDIANA_LAKE_COUNTY_CW                                         ' => 'W0026',            
 psourcename = 'NORTH_CAROLINA_MECKLENBURG_COUNTY_CW                           ' => 'W0027',            
 psourcename = 'OHIO_ERIE_COUNTY_HURON_MUNICIPAL_COURT_CW                      ' => 'W0028',            
 psourcename = 'OHIO_FAIRFIELD_COUNTY_COMMON_PLEAS_COURT_CW                    ' => 'W0029',            
 psourcename = 'OHIO_GUERNSEY_COUNTY_COMMON_PLEAS_COURT_CW                     ' => 'W0030',            
 psourcename = 'OHIO_HARRISON_COUNTY_MUNICIPAL_COURT_CW                        ' => 'W0031',            
 psourcename = 'OHIO_LOGAN_COUNTY_COMMON_PLEAS_COURT_CW                        ' => 'W0032',            
 psourcename = 'OHIO_LUCAS_COUNTY_CW                                           ' => 'W0033',
 psourcename = 'OHIO_MARION_COUNTY_MUNICIPAL_COURT_CW                          ' => 'W0034',
 psourcename = 'OHIO_MERCER_COUNTY_CELINA_MUNICIPAL_COURT_CW                   ' => 'W0035',
 psourcename = 'OHIO_SENECA_COUNTY_FOSTORIA_MUNICIPAL_COURT_CW                 ' => 'W0036',   
 psourcename = 'OHIO_WOOD_COUNTY_PERRYSBURG_MUNICIPAL_COURT_CW                 ' => 'W0037',
 psourcename = 'TEXAS_HOCKLEY_COUNTY_CW                                        ' => 'W0038',
 psourcename = 'TEXAS_KAUFMAN_COUNTY_DISTRICT_COURT_CW                         ' => 'W0039',
 psourcename = 'FLORIDA_POLK_COUNTY_TRAFFIC_CW                                 ' => 'W0040',
 psourcename = 'FLORIDA_HIGHLANDS_COUNTY_TRAFFIC_CW                            ' => 'W0041',
 
//------------------------------------------Hygenics Crimwise Arrest Batch1---------------------------------------------- 
 psourcename = 'CALIFORNIA_YUBA_COUNTY_BOOKINGS_CW                             ' => 'W0042',
 psourcename = 'CALIFORNIA_GLENN_COUNTY_BOOKINGS_CW                            ' => 'W0043',
 psourcename = 'CALIFORNIA_CALAVERAS_COUNTY_BOOKINGS_CW                        ' => 'W0044',
 psourcename = 'CALIFORNIA_NEVADA_COUNTY_BOOKINGS_CW                           ' => 'W0045',

 
//------------------------------------------Hygenics Crimwise Arrest Batch2.1 20160929-------------------------------------
 psourcename = 'CALIFORNIA_SOLANO_COUNTY_JAIL_CW                                      ' => 'W0046',
 psourcename = 'FLORIDA_MANATEE_COUNTY_SHERIFFS_OFFICE_CW                             ' => 'W0047',
 psourcename = 'NORTH_CAROLINA_CHATHAM_COUNTY_SHERIFF_CW                              ' => 'W0048',
 psourcename = 'FLORIDA_PASCO_SHERIFFS_OFFICE_CW                                      ' => 'W0049',
 psourcename = 'FLORIDA_MARION_COUNTY_SHERIFFS_OFFICE_CW                              ' => 'W0050',
 psourcename = 'COLORADO_BOULDER_COUNTY_SHERIFFS_OFFICE_CW                            ' => 'W0051',
 psourcename = 'TENNESSEE_KNOX_COUNTY_ARRESTS_CW                                      ' => 'W0052',
 psourcename = 'TEXAS_BROWN_COUNTY_ARRESTS_CW                                         ' => 'W0053',
 psourcename = 'CALIFORNIA_GLENDALE_POLICE_DEPARTMENT_CW                              ' => 'W0054',
 psourcename = 'IOWA_WATERLOO_POLICE_DEPARTMENT_CW                                    ' => 'W0055',
 psourcename = 'NEW_HAMPSHIRE_NASHUA_POLICE_DEPARTMENT_CW                             ' => 'W0056',
 psourcename = 'NORTH_CAROLINA_MOORE_COUNTY_DETENTION_CENTER_CW                       ' => 'W0057',
 psourcename = 'TENNESSEE_ROANE_COUNTY_ARRESTS_CW                                     ' => 'W0058',
 psourcename = 'FLORIDA_OKEECHOBEE_COUNTY_SHERIFFS_OFFICE_CW                          ' => 'W0059',
 psourcename = 'NORTH_CAROLINA_CHEROKEE_COUNTY_SHERIFF_CW                             ' => 'W0060',
 psourcename = 'NORTH_CAROLINA_PENDER_COUNTY_CURRENT_INMATES_LIST_CW                  ' => 'W0061',
 psourcename = 'NORTH_CAROLINA_ANSON_COUNTY_SHERIFF_CW                                ' => 'W0062',
 psourcename = 'LOUISIANA_SHREVEPORT_POLICE_DEPARTMENT_CW                             ' => 'W0063',
 psourcename = 'FLORIDA_HENDRY_COUNTY_SHERIFFS_OFFICE_CW                              ' => 'W0064',
 psourcename = 'FLORIDA_OKALOOSA_COUNTY_SHERIFFS_OFFICE_CW                            ' => 'W0065',
 psourcename = 'CALIFORNIA_NEVADA_COUNTY_SHERIFFS_OFFICE_CW                           ' => 'W0066',
 psourcename = 'IOWA_IOWA_CITY_POLICE_DEPARTMENT_CW                                   ' => 'W0067',
 psourcename = 'FLORIDA_GLADES_COUNTY_SHERIFFS_OFFICE_CW                              ' => 'W0068',
 psourcename = 'TEXAS_KAUFMAN_COUNTY_SHERIFFS_DEPARTMENT_CW                           ' => 'W0069',
 psourcename = 'NORTH_CAROLINA_TRANSYLVANIA_COUNTY_DETENTION_CENTER_CW                ' => 'W0070',
 psourcename = 'CONNECTICUT_HARTFORD_POLICE_DEPARTMENT_CW                             ' => 'W0071',
 psourcename = 'MASSACHUSETTS_SPRINGFIELD_POLICE_CW                                   ' => 'W0072',
 psourcename = 'OREGON_BENTON_COUNTY_SHERIFF_CW                                       ' => 'W0073',
 psourcename = 'MASSACHUSETTS_BROCKTON_CW                                             ' => 'W0074',
 psourcename = 'IOWA_BURLINGTON_POLICE_DEPARTMENT_CW                                  ' => 'W0075',
 psourcename = 'IOWA_SIOUX_COUNTY_SHERIFFS_OFFICE_CW                                  ' => 'W0076',
 psourcename = 'TENNESSEE_HAMILTON_COUNTY_ARRESTS_CW                                  ' => 'W0077', 
 psourcename = 'MINNESOTA_CARVER_COUNTY_JAIL_CW                                       ' => 'W0078',   
 psourcename = 'FLORIDA_COLUMBIA_COUNTY_SHERIFFS_OFFICE_CW                            ' => 'W0079',
 psourcename = 'FLORIDA_FLAGLER_COUNTY_SHERIFFS_OFFICE_CW                             ' => 'W0080',
 psourcename = 'NORTH_CAROLINA_HARNETT_COUNTY_SHERIFF_CW                              ' => 'W0081',
 psourcename = 'FLORIDA_JACKSON_COUNTY_SHERIFFS_OFFICE_CW                             ' => 'W0082',
 psourcename = 'MASSACHUSETTS_TAUNTON_POLICE_DEPARTMENT_CW                            ' => 'W0083',
 psourcename = 'NORTH_CAROLINA_GASTON_COUNTY_SHERIFFS_OFFICE_CW                       ' => 'W0084',
 psourcename = 'TENNESSEE_WASHINGTON_COUNTY_SHERIFFS_OFFICE_CW                        ' => 'W0085',
 psourcename = 'TENNESSEE_STEWART_COUNTY_ARRESTS_CW                                   ' => 'W0086',
 psourcename = 'LOUISIANA_OPELOUSAS_POLICE_CW                                         ' => 'W0087',
 psourcename = 'CALIFORNIA_SANTA_CLARA_POLICE_DEPARTMENT_CW                           ' => 'W0088',
 psourcename = 'MASSACHUSETTS_HOLYOKE_POLICE_DEPARTMENT_CW                            ' => 'W0089',
 psourcename = 'NORTH_CAROLINA_CONCORD_POLICE_DEPARTMENT_CW                           ' => 'W0090',
 psourcename = 'CALIFORNIA_GLENN_COUNTY_ARRESTS_CW                                    ' => 'W0091',
 psourcename = 'LOUISIANA_ST_LANDRY_PARISH_SHERIFF_CW                                 ' => 'W0092',
 psourcename = 'NORTH_CAROLINA_WAKE_FOREST_POLICE_DEPARTMENT_CW                       ' => 'W0093',
 psourcename = 'NORTH_CAROLINA_PITT_COUNTY_SHERIFFS_OFFICE_CW                         ' => 'W0094',
 psourcename = 'FLORIDA_BRADFORD_COUNTY_SHERIFFS_OFFICE_CW                            ' => 'W0095',
 psourcename = 'MASSACHUSETTS_WEYMOUTH_POLICE_DEPARTMENT_CW                           ' => 'W0096',
 psourcename = 'NEW_HAMPSHIRE_KEENE_POLICE_DEPARTMENT_CW                              ' => 'W0097',
 psourcename = 'MASSACHUSETTS_CAMBRIDGE_CW                                            ' => 'W0098', 
 psourcename = 'MAINE_WELLS_POLICE_DEPARTMENT_CW                                      ' => 'W0099', 
 psourcename = 'MASSACHUSETTS_CARVER_POLICE_DEPARTMENT_CW                             ' => 'W0100',
 
//------------------------------------------Hygenics Crimwise Arrest Batch2.2 ------------------------------------- 
 psourcename = 'ALABAMA_BALDWIN_COUNTY_CORRECTIONS_CENTER_CW                          ' => 'W0101',
 psourcename = 'CALIFORNIA_KINGS_COUNTY_BOOKINGS_CW                                   ' => 'W0102',
 psourcename = 'CALIFORNIA_LAKE_COUNTY_BOOKINGS_CW                                    ' => 'W0103',
 psourcename = 'CALIFORNIA_MARIPOSA_COUNTY_BOOKINGS_CW                                ' => 'W0104',
 psourcename = 'CALIFORNIA_ORANGE_COUNTY_SHERIFF_CW                                   ' => 'W0105',
 psourcename = 'CALIFORNIA_SONOMA_COUNTY_BOOKINGS_CW                                  ' => 'W0106',
 psourcename = 'CALIFORNIA_SUTTER_COUNTY_BOOKINGS_CW                                  ' => 'W0107',
 psourcename = 'CALIFORNIA_YOLO_COUNTY_BOOKINGS_CW                                    ' => 'W0108',
 psourcename = 'MAINE_BIDDEFORD_POLICE_DEPARTMENT_CW                                  ' => 'W0109',
 psourcename = 'MASSACHUSETTS_AMHERST_POLICE_CW                                       ' => 'W0110',
 psourcename = 'MASSACHUSETTS_BREWSTER_POLICE_CW                                      ' => 'W0111',
 psourcename = 'MAINE_SCARBOROUGH_POLICE_DEPARTMENT_CW                                ' => 'W0112',
 psourcename = 'CALIFORNIA_HUMBOLDT_COUNTY_BOOKINGS_CW                                ' => 'W0113',
 psourcename = 'CALIFORNIA_IRVINE_POLICE_DEPARTMENT_CW                                ' => 'W0114',
 psourcename = 'CALIFORNIA_NAPA_COUNTY_BOOKINGS_CW                                    ' => 'W0115',
 psourcename = 'CALIFORNIA_SAN_JOAQUIN_COUNTY_BOOKINGS_CW                             ' => 'W0116',
 psourcename = 'CALIFORNIA_SOLANO_COUNTY_BOOKINGS_CW                                  ' => 'W0117',
 psourcename = 'COLORADO_GARFIELD_COUNTY_SHERIFF_CW                                   ' => 'W0118',
 psourcename = 'FLORIDA_BAKER_COUNTY_SHERIFFS_OFFICE_CW                               ' => 'W0119',
 psourcename = 'FLORIDA_BAY_COUNTY_JAIL_CW                                            ' => 'W0120',
 psourcename = 'FLORIDA_WALTON_COUNTY_DOC_CW                                          ' => 'W0121',
 psourcename = 'IOWA_CEDAR_FALLS_POLICE_DEPARTMENT_CW                                 ' => 'W0122',
 psourcename = 'IOWA_DYERSVILLE_POLICE_DEPARTMENT_CW                                  ' => 'W0123',
 psourcename = 'KANSAS_JOHNSON_COUNTY_SHERIFFS_OFFICE_CW                              ' => 'W0124',
 psourcename = 'LOUISIANA_JEFFERSON_PARISH_SHERIFF_CW                                 ' => 'W0125',
 psourcename = 'LOUISIANA_MANDEVILLE_POLICE_CW                                        ' => 'W0126',
 psourcename = 'LOUISIANA_ST_TAMMANY_PARISH_SHERIFF_CW                                ' => 'W0127',
 psourcename = 'MAINE_CUMBERLAND_COUNTY_SHERIFFS_OFFICE_CW                            ' => 'W0128',
 psourcename = 'MAINE_GORHAM_POLICE_DEPARTMENT_CW                                     ' => 'W0129',
 psourcename = 'MARYLAND_FREDERICK_COUNTY_SHERIFF_CW                                  ' => 'W0130',
 psourcename = 'MASSACHUSETTS_CHICOPEE_POLICE_CW                                      ' => 'W0131',
 psourcename = 'MASSACHUSETTS_DUXBURY_CW                                              ' => 'W0132',
 psourcename = 'MASSACHUSETTS_EAST_LONGMEADOW_CW                                      ' => 'W0133',
 psourcename = 'MASSACHUSETTS_EVERETT_CW                                              ' => 'W0134',
 psourcename = 'MASSACHUSETTS_FRANKLIN_POLICE_CW                                      ' => 'W0135',
 psourcename = 'MASSACHUSETTS_HALIFAX_POLICE_DEPARTMENT_CW                            ' => 'W0136',
 psourcename = 'MASSACHUSETTS_HAMPDEN_POLICE_DEPARTMENT_CW                            ' => 'W0137',
 psourcename = 'MASSACHUSETTS_MARION_POLICE_DEPARTMENT_CW                             ' => 'W0138',
 psourcename = 'MASSACHUSETTS_MELROSE_POLICE_DEPARTMENT_CW                            ' => 'W0139',
 psourcename = 'MASSACHUSETTS_NANTUCKET_POLICE_DEPARTMENT_CW                          ' => 'W0140',
 psourcename = 'MASSACHUSETTS_ROCHESTER_CW                                            ' => 'W0141',
 psourcename = 'MASSACHUSETTS_SALEM_POLICE_CW                                         ' => 'W0142',
 psourcename = 'MASSACHUSETTS_SWANSEA_POLICE_DEPARTMENT_CW                            ' => 'W0143',
 psourcename = 'MASSACHUSETTS_TOWN_OF_SHREWSBURY_CW                                   ' => 'W0144',
 psourcename = 'NEW_HAMPSHIRE_HANOVER_POLICE_DEPARTMENT_CW                            ' => 'W0145',
 psourcename = 'NEW_HAMPSHIRE_MANCHESTER_POLICE_DEPARTMENT_CW                         ' => 'W0146',
 psourcename = 'TENNESSEE_HARDEMAN_COUNTY_ARRESTS_CW                                  ' => 'W0147',
 
//------------------------------------------Hygenics Crimwise County Batch2.1 20160929---------------------------------------------- 
 psourcename = 'CALIFORNIA_TULARE_COUNTY_CW                                           ' => 'W0148',
 // psourcename = 'OHIO_GREENE_COUNTY_FAIRBORN_MUNICIPAL_COURT_CW                        ' => 'W0149', Using crim instead due to address and offense fields
 psourcename = 'OHIO_WARREN_COUNTY_LEBANON_MUNICIPAL_COURT_CW                         ' => 'W0150',          

//------------------------------------------Hygenics Crimwise County Batch3 20160929---------------------------------------------- 
 psourcename = 'ARIZONA_MARICOPA_WEBSITE_CW                                            ' =>'W0151',//??
 psourcename = 'ARIZONA_PHOENIX_CW                                                     ' =>'W0152',
 psourcename = 'OHIO_ERIE_COUNTY_SANDUSKY_MUNICIPAL_COURT_CW                           ' =>'W0153',
 psourcename = 'TEXAS_CHAMBERS_COUNTY_DISTRICT_COURT_CW                                ' =>'W0154',
 psourcename = 'CALIFORNIA_SAN_LUIS_OBISPO_COUNTY_WEBSITE_CW                           ' =>'W0155',
 psourcename = 'CALIFORNIA_SISKIYOU_COUNTY_CW                                          ' =>'W0156',
 psourcename = 'CALIFORNIA_VENTURA_COUNTY_WEBSITE_CW                                   ' =>'W0157',
 // psourcename = 'OHIO_LAKE_COUNTY_PAINSVILLE_MUNICIPAL_COURT_CW                         ' =>'W0158',//QQ the crim version is current now.
 psourcename = 'OHIO_TUSCARAWAS_COUNTY_MUNICIPAL_COURT_CW                              ' =>'W0159',
 psourcename = 'TEXAS_JOHNSON_COUNTY_DISTRICT_COURT_CW                                 ' =>'W0160',
//------------------------------------------Hygenics Crimwise arrest Batch3 20160929----------------------------------------------
 psourcename = 'ALABAMA_JEFFERSON_COUNTY_SHERIFFS_OFFICE_CW                            ' =>'W0161',
 psourcename = 'ARIZONA_MARICOPA_SHERIFFS_OFFICE_CW                                    ' =>'W0162',
 psourcename = 'LOUISIANA_SHREVEPORT_ARRESTS_CW                                        ' =>'W0163',
 psourcename = 'CONNECTICUT_HARTFORD_COUNTY_ARRESTS_CW                                 ' =>'W0164',  
 psourcename = 'MASSACHUSETTS_SPRINGFIELD_ARRESTS_CW                                   ' =>'W0165',
 psourcename = 'MASSACHUSETTS_LYNN_ARRESTS_CW                                          ' =>'W0166',//??
 psourcename = 'MASSACHUSETTS_NEW_BEDFORD_ARRESTS_CW                                   ' =>'W0167',
 psourcename = 'MASSACHUSETTS_QUINCY_ARRESTS_CW                                        ' =>'W0168',
 psourcename = 'MASSACHUSETTS_HOLYOKE_ARRESTS_CW                                       ' =>'W0169',
 psourcename = 'MASSACHUSETTS_BARNSTABLE_COUNTY_ARRESTS_CW                             ' =>'W0170',
 psourcename = 'CALIFORNIA_SAN_BERNARDINO_POLICE_DEPARTMENT_CW                         ' =>'W0171',
 psourcename = 'COLORADO_WELD_COUNTY_SHERIFF_CW                                        ' =>'W0172',
 psourcename = 'FLORIDA_BREVARD_COUNTY_SHERIFFS_OFFICE_CW                              ' =>'W0173',
 psourcename = 'FLORIDA_CHARLOTTE_COUNTY_SHERIFF_CW                                    ' =>'W0174',
 psourcename = 'FLORIDA_HILLSBOROUGH_COUNTY_SHERIFFS_OFFICE_CW                         ' =>'W0175',
 psourcename = 'FLORIDA_INDIAN_RIVER_COUNTY_SHERIFFS_OFFICE_CW                         ' =>'W0176',
 psourcename = 'FLORIDA_LAKE_COUNTY_SHERIFFS_OFFICE_CW                                 ' =>'W0177',
 psourcename = 'FLORIDA_MONROE_COUNTY_SHERIFFS_OFFICE_CW                               ' =>'W0178',
 psourcename = 'FLORIDA_PALM_BEACH_COUNTY_SHERIFFS_OFFICE_CW                           ' =>'W0179',
 psourcename = 'FLORIDA_PUTNAM_COUNTY_SHERIFFS_OFFICE_CW                               ' =>'W0180',
 psourcename = 'FLORIDA_VOLUSIA_COUNTY_CORRECTIONS_CW                                  ' =>'W0181',
 psourcename = 'GEORGIA_CHATHAM_COUNTY_SHERIFFS_OFFICE_CW                              ' =>'W0182',
 psourcename = 'GEORGIA_GWINNETT_COUNTY_DETENTION_CENTER_CW                            ' =>'W0183',
 psourcename = 'MASSACHUSETTS_WALTHAM_ARRESTS_CW                                       ' =>'W0184',
 psourcename = 'MICHIGAN_KENT_COUNTY_SHERIFFS_DEPARTMENT_CW                            ' =>'W0185',
 psourcename = 'NEW_MEXICO_BERNALILLO_MDC_CW                                           ' =>'W0186',
 psourcename = 'NEW_YORK_FULTON_POLICE_DEPARTMENT_CW                                   ' =>'W0187',
 psourcename = 'NORTH_CAROLINA_GUILFORD_COUNTY_SHERIFFS_OFFICE_CW                      ' =>'W0188',
 psourcename = 'NORTH_CAROLINA_MECKLENBURG_COUNTY_SHERIFF_CW                           ' =>'W0189',
 psourcename = 'OREGON_WASHINGTON_COUNTY_SHERIFF_CW                                    ' =>'W0190',
 psourcename = 'SOUTH_CAROLINA_YORK_COUNTY_SHERIFF_CW                                  ' =>'W0191',
 psourcename = 'TENNESSEE_SHELBY_COUNTY_SHERIFFS_OFFICE_CW                             ' =>'W0192',
 psourcename = 'TEXAS_POTTER_COUNTY_SHERIFFS_OFFICE_CW                                 ' =>'W0193',
 psourcename = 'UTAH_IRON_COUNTY_SHERIFFS_OFFICE_CW                                    ' =>'W0194',

//------------------------------------------Hygenics Crimwise arrest Batch4 20170405---------------------------------------------- 
 psourcename = 'VIRGINIA_ARLINGTON_COUNTY_ARRESTS_CW                                   ' =>'W0195',                                   
 psourcename = 'NORTH_CAROLINA_ROWAN_COUNTY_SHERIFFS_OFFICE_CW                         ' =>'W0196', 
 psourcename = 'MASSACHUSETTS_ATTLEBORO_ARRESTS_CW                                     ' =>'W0197', 
 psourcename = 'MASSACHUSETTS_SALEM_ARRESTS_CW                                         ' =>'W0198', 
 psourcename = 'MASSACHUSETTS_PLYMOUTH_COUNTY_ARRESTS_CW                               ' =>'W0199', 
 psourcename = 'MASSACHUSETTS_EVERETT_ARRESTS_CW                                       ' =>'W0200', 
 psourcename = 'FLORIDA_ALACHUA_COUNTY_SHERIFFS_OFFICE_CW                              ' =>'W0201', 
 psourcename = 'MASSACHUSETTS_PEABODY_ARRESTS_CW                                       ' =>'W0202', 
 psourcename = 'MASSACHUSETTS_FALMOUTH_ARRESTS_CW                                      ' =>'W0203', 
 psourcename = 'MASSACHUSETTS_CAMBRIDGE_POLICE_DEPARTMENT_CW                           ' =>'W0204', 
 psourcename = 'MASSACHUSETTS_FRAMINGHAM_ARRESTS_CW                                    ' =>'W0205', 
 psourcename = 'CALIFORNIA_ANAHEIM_ARRESTS_CW                                          ' =>'W0206', 
 psourcename = 'MASSACHUSETTS_BROOKLINE_ARRESTS_CW                                     ' =>'W0207', 
 psourcename = 'MASSACHUSETTS_NATICK_ARRESTS_CW                                        ' =>'W0208', 
 psourcename = 'FLORIDA_COLLIER_COUNTY_SHERIFFS_OFFICE_CW                              ' =>'W0209', 
 psourcename = 'MASSACHUSETTS_WEYMOUTH_ARRESTS_CW                                      ' =>'W0210', 
 psourcename = 'MASSACHUSETTS_BROCKTON_POLICE_DEPARTMENT_CW                            ' =>'W0211', 
 psourcename = 'MASSACHUSETTS_WAREHAM_ARRESTS_CW                                       ' =>'W0212', 
 psourcename = 'MASSACHUSETTS_GLOUCESTER_ARRESTS_CW                                    ' =>'W0213', 
 psourcename = 'FLORIDA_SARASOTA_COUNTY_SHERIFFS_OFFICE_CW                             ' =>'W0214', 
 psourcename = 'NORTH_CAROLINA_RUTHERFORD_COUNTY_DETENTION_CENTER_CW                   ' =>'W0215', 
 psourcename = 'MASSACHUSETTS_SAUGUS_ARRESTS_CW                                        ' =>'W0216', 
 psourcename = 'MASSACHUSETTS_TAUNTON_ARRESTS_CW                                       ' =>'W0217', 
 psourcename = 'MASSACHUSETTS_WHITMAN_ARRESTS_CW                                       ' =>'W0218', 
 psourcename = 'MASSACHUSETTS_FRANKLIN_ARRESTS_CW                                      ' =>'W0219', 
 psourcename = 'MASSACHUSETTS_ABINGTON_ARRESTS_CW                                      ' =>'W0220', 
 psourcename = 'MINNESOTA_BELTRAMI_COUNTY_SHERIFF_CW                                   ' =>'W0221', 
 psourcename = 'MASSACHUSETTS_TOWN_OF_BILLERICA_POLICE_DEPARTMENT_CW                   ' =>'W0222', 
 psourcename = 'MASSACHUSETTS_SWANSEA_ARRESTS_CW                                       ' =>'W0223', 
 psourcename = 'MASSACHUSETTS_HANOVER_ARRESTS_CW                                       ' =>'W0224', 
 psourcename = 'NORTH_CAROLINA_GOLDSBORO_ARRESTS_CW                                    ' =>'W0225', 
 psourcename = 'MASSACHUSETTS_HINGHAM_ARRESTS_CW                                       ' =>'W0226', 
 psourcename = 'MASSACHUSETTS_HARWICH_ARRESTS_CW                                       ' =>'W0227', 
 psourcename = 'MASSACHUSETTS_SANDWICH_ARRESTS_CW                                      ' =>'W0228', 
 psourcename = 'FLORIDA_LEVY_COUNTY_SHERIFFS_OFFICE_CW                                 ' =>'W0229', 
 psourcename = 'MASSACHUSETTS_HULL_ARRESTS_CW                                          ' =>'W0230', 
 psourcename = 'MASSACHUSETTS_PEMBROKE_ARRESTS_CW                                      ' =>'W0231', 
 psourcename = 'MASSACHUSETTS_WEBSTER_ARRESTS_CW                                       ' =>'W0232', 
 psourcename = 'MASSACHUSETTS_EAST_BRIDGEWATER_ARRESTS_CW                              ' =>'W0233', 
 psourcename = 'MASSACHUSETTS_STOUGHTON_ARRESTS_CW                                     ' =>'W0234', 
 psourcename = 'MASSACHUSETTS_EAST_LONGMEADOW_ARRESTS_CW                               ' =>'W0235', 
 psourcename = 'MASSACHUSETTS_IPSWICH_ARRESTS_CW                                       ' =>'W0236', 
 psourcename = 'MASSACHUSETTS_ROCKLAND_ARRESTS_CW                                      ' =>'W0237', 
 psourcename = 'FLORIDA_PINELLAS_COUNTY_SHERIFFS_OFFICE_CW                             ' =>'W0238', 
 psourcename = 'FLORIDA_HIGHLANDS_COUNTY_SHERIFFS_OFFICE_CW                            ' =>'W0239', 
 psourcename = 'MASSACHUSETTS_MELROSE_ARRESTS_CW                                       ' =>'W0240', 
 psourcename = 'CALIFORNIA_TULARE_COUNTY_BOOKINGS_CW                                   ' =>'W0241', 
 psourcename = 'MASSACHUSETTS_CARVER_ARRESTS_CW                                        ' =>'W0242', 
 psourcename = 'CALIFORNIA_DOWNEY_ARRESTS_CW                                           ' =>'W0243',
 psourcename = 'MASSACHUSETTS_BELCHERTOWN_ARRESTS_CW                                   ' =>'W0244',
 psourcename = 'MASSACHUSETTS_MIDDLETON_ARRESTS_CW                                     ' =>'W0245',
 psourcename = 'ILLINOIS_ROCKFORD_ARRESTS_CW                                           ' =>'W0246',
 psourcename = 'MASSACHUSETTS_CANTON_POLICE_DEPARTMENT_CW                              ' =>'W0247',
 psourcename = 'MASSACHUSETTS_DEDHAM_ARRESTS_CW                                        ' =>'W0248',
 psourcename = 'MASSACHUSETTS_MARBLEHEAD_ARRESTS_CW                                    ' =>'W0249',
 psourcename = 'MASSACHUSETTS_NORWELL_ARRESTS_CW                                       ' =>'W0250',

//------------------------------------------Hygenics Crimwise Count Batch4 ---------------------------------------------- 
 psourcename = 'TEXAS_COLLIN_COUNTY_DISTRICT_COURT_CW                                  ' =>'W0251',
 // psourcename = 'OHIO_AUGLAIZE_COUNTY_MUNICIPAL_COURT_CW                                ' =>'W0252',    // most of the rec are in OHIO_AUGLAIZE_COUNTY           
 psourcename = 'FLORIDA_ESCAMBIA_COUNTY_CW                                             ' =>'W0253',
 psourcename = 'TEXAS_FORT_BEND_COUNTY_DISTRICT_COURT_CW                               ' =>'W0254',                                    
 psourcename = 'OHIO_PUTNAM_COUNTY_COMMON_PLEAS_COURT_CW                               ' =>'W0255',
 psourcename = 'ARIZONA_MESA_CW                                                        ' =>'W0256',
 psourcename = 'OHIO_JEFFERSON_COUNTY_DILLONVALE_MUNICIPAL_COURT_CW                    ' =>'W0257',
 psourcename = 'OHIO_MORGAN_COUNTY_MUNICIPAL_COURT_CW                                  ' =>'W0258',
 psourcename = 'OHIO_LICKING_COUNTY_COMMON_PLEAS_COURT_CW                              ' =>'W0259',
 psourcename = 'ARIZONA_GLENDALE_CW                                                    ' =>'W0260',
 psourcename = 'ARIZONA_TEMPE_CW                                                       ' =>'W0261',
 psourcename = 'ARIZONA_SCOTTSDALE_CW                                                  ' =>'W0262',
 psourcename = 'ARIZONA_CHANDLER_CW                                                    ' =>'W0263',
 psourcename = 'ARIZONA_GILBERT_CW                                                     ' =>'W0264',
 psourcename = 'ARIZONA_PEORIA_CW                                                      ' =>'W0265',
 psourcename = 'CALIFORNIA_PLACER_COUNTY_TRAFFIC_CW                                    ' =>'W0266',
 //AOC
 psourcename = 'ARIZONA_DEPARTMENT_OF_PUBLIC_SAFETY_CW                                 ' =>'W0267',
 //DOC
 psourcename = 'TEXAS_DEPARTMENT_OF_CRIMINAL_JUSTICE_INMATES_CW                        ' =>'W0268',

//------------------------------------------Hygenics Crimwise Arrest Batch5 ----------------------------------------------  
 psourcename = 'CALIFORNIA_MENDOCINO_COUNTY_BOOKINGS_CW                                ' => 'W0269',
 psourcename = 'CALIFORNIA_TEHAMA_COUNTY_BOOKINGS_CW                                   ' => 'W0270',
 psourcename = 'FLORIDA_CITRUS_COUNTY_SHERIFFS_OFFICE_CW                               ' => 'W0271',
 psourcename = 'FLORIDA_DIXIE_COUNTY_SHERIFFS_OFFICE_CW                                ' => 'W0272',
 psourcename = 'FLORIDA_LEE_COUNTY_SHERIFFS_OFFICE_CW                                  ' => 'W0273',
 psourcename = 'FLORIDA_ST_JOHNS_COUNTY_SHERIFFS_OFFICE_CW                             ' => 'W0274',
 psourcename = 'FLORIDA_ST_LUCIE_COUNTY_SHERIFFS_OFFICE_CW                             ' => 'W0275',
 psourcename = 'LOUISIANA_SLIDELL_POLICE_CW                                            ' => 'W0276',
 psourcename = 'MASSACHUSETTS_BOURNE_ARRESTS_CW                                        ' => 'W0277',
 psourcename = 'MASSACHUSETTS_BRIDGEWATER_ARRESTS_CW                                   ' => 'W0278',
 psourcename = 'MASSACHUSETTS_CHICOPEE_ARRESTS_CW                                      ' => 'W0279',
 psourcename = 'MASSACHUSETTS_COHASSET_ARRESTS_CW                                      ' => 'W0280',
 psourcename = 'MASSACHUSETTS_DALTON_ARRESTS_CW                                        ' => 'W0281',
 psourcename = 'MASSACHUSETTS_DENNIS_ARRESTS_CW                                        ' => 'W0282',
 psourcename = 'MASSACHUSETTS_DUXBURY_ARRESTS_CW                                       ' => 'W0283',
 psourcename = 'MASSACHUSETTS_FITCHBURG_ARRESTS_CW                                     ' => 'W0284',
 psourcename = 'MASSACHUSETTS_FOXBORO_ARRESTS_CW                                       ' => 'W0285',
 psourcename = 'MASSACHUSETTS_GARDNER_ARRESTS_CW                                       ' => 'W0286',
 psourcename = 'MASSACHUSETTS_LEOMINSTER_ARRESTS_CW                                    ' => 'W0287',
 psourcename = 'MASSACHUSETTS_LONGMEADOW_ARRESTS_CW                                    ' => 'W0288',
 psourcename = 'MASSACHUSETTS_MASHPEE_ARRESTS_CW                                       ' => 'W0289',
 // psourcename = 'MASSACHUSETTS_MELROSE_POLICE_DEPARTMENT_CW                             ' => 'W0290',
 psourcename = 'MASSACHUSETTS_MIDDLETON_POLICE_DEPARTMENT_CW                           ' => 'W0291',
 psourcename = 'MASSACHUSETTS_MILFORD_ARRESTS_CW                                       ' => 'W0292',
 psourcename = 'MASSACHUSETTS_NORTH_ATTLEBORO_ARRESTS_CW                               ' => 'W0293',
 psourcename = 'MASSACHUSETTS_NORTHAMPTON_ARRESTS_CW                                   ' => 'W0294',
 psourcename = 'MASSACHUSETTS_ORLEANS_ARRESTS_CW                                       ' => 'W0295',
 psourcename = 'MASSACHUSETTS_PALMER_ARRESTS_CW                                        ' => 'W0296',
 psourcename = 'MASSACHUSETTS_PLYMPTON_ARRESTS_CW                                      ' => 'W0297',
 psourcename = 'MASSACHUSETTS_ROCHESTER_ARRESTS_CW                                     ' => 'W0298',
 psourcename = 'MASSACHUSETTS_SOUTHWICK_ARRESTS_CW                                     ' => 'W0299',
 psourcename = 'MASSACHUSETTS_TEWKSBURY_POLICE_CW                                      ' => 'W0300', 
 psourcename = 'MASSACHUSETTS_TRURO_ARRESTS_CW                                         ' => 'W0301',
 psourcename = 'MASSACHUSETTS_WAYLAND_ARRESTS_CW                                       ' => 'W0302',
 psourcename = 'MASSACHUSETTS_WEST_BRIDGEWATER_ARRESTS_CW                              ' => 'W0303',
 psourcename = 'MASSACHUSETTS_WESTFIELD_ARRESTS_CW                                     ' => 'W0304',
 psourcename = 'MASSACHUSETTS_WRETNAM_ARRESTS_CW                                       ' => 'W0305',
 psourcename = 'MASSACHUSETTS_WRENTHAM_ARRESTS_CW                                      ' => 'W0306', 
 psourcename = 'MASSACHUSETTS_YARMOUTH_ARRESTS_CW                                      ' => 'W0307',
 psourcename = 'MINNESOTA_BROWN_COUNTY_SHERIFF_CW                                      ' => 'W0308',
 psourcename = 'MONTANA_YELLOWSTONE_COUNTY_DETENTION_CW                                ' => 'W0309',
 psourcename = 'FLORIDA_OSCEOLA_COUNTY_CORRECTIONS_CW                                  ' => 'W0310',                                                                              
//------------------------------------------Hygenics Crimwise County Batch5 ----------------------------------------------
 psourcename = 'ARIZONA_AVONDALE_CW                                                    ' => 'W0311',
 psourcename = 'ARIZONA_BUCKEYE_CW                                                     ' => 'W0312',
 psourcename = 'ARIZONA_EL_MIRAGE_CW                                                   ' => 'W0313',
 psourcename = 'ARIZONA_GOODYEAR_CW                                                    ' => 'W0314',
 psourcename = 'ARIZONA_SURPRISE_CW                                                    ' => 'W0315',
 psourcename = 'ARIZONA_TOLLESON_CW                                                    ' => 'W0316',
 psourcename = 'ARIZONA_WICKENBURG_CW                                                  ' => 'W0317',
 psourcename = 'OHIO_CHAMPAIGN_COUNTY_MUNICIPAL_COURT_CW                               ' => 'W0318',
 psourcename = 'OHIO_SENECA_COUNTY_TIFFIN_MUNICIPAL_COURT_CW                           ' => 'W0319',
 //AOC                                                                                 
 psourcename = 'KANSAS_OFFENDER_REGISTRY_CW                                            ' => 'W0320',

/************************************************HYGENICS CRIMWISE END*************************************************************/

/************************************************IE DATA START*************************************************************/ 	
//-------------------------------IE AOC Batch 1 20181005 ---------------------------------------------------------
  psourcename = 'FL CAREER OFFENDER REGISTRY_IE'                                          => 'IE001',
	psourcename = 'KS BUREAU OF INVESTIGATION - VIOLENT AND DRUG_IE'                        => 'IE002',
	psourcename = 'OK VIOLENT CRIME OFFENDER REGISTRY_IE'                                   => 'IE003',  //IE fix
	psourcename = 'IA ADMINISTRATIVE OFFICE OF COURTS(MISDEMEANORS)_IE'                     => 'IE004',
	psourcename = 'IL STATE POLICE MURDERER AND VIOLENT OFFENDER AGAINST YOUTH REGISTRY_IE' => 'IE005',
	psourcename = 'MD ADMINISTRATIVE OFFICE OF COURTS DISTRICT COURTS_IE   '                => 'IE006',
	psourcename = 'ND DISTRICT AND MUNICIPAL COURTS_IE'                                     => 'IE007',
	psourcename = 'RI DISTRICT AND SUPERIOR COURTS_IE'                                      => 'IE008',  //IE fix
  // psourcename = 'WI ADMINISTRATIVE OFFICE OF COURTS(CM)_IE'));                            => 'IE008',  //IE fix
	// psourcename = 'WI ADMINISTRATIVE OFFICE OF COURTS(CF)_IE'));                            => 'IE009',  //IE fix
	// psourcename = 'WI ADMINISTRATIVE OFFICE OF COURTS(CT)_IE'));                            => 'IE010',  //IE fix			
	
//-------------------------------IE County Batch 1 20181005 ---------------------------------------------------
 psourcename = 'GA CARROLL SUPERIOR CLERK OF COURTS_IE '                                  => 'I0011',
 psourcename = 'GA GWINNETT LAWRENCEVILLE - SUPERIOR COURT_IE'                            => 'I0012',
 psourcename = 'OH CUYAHOGA CLERK OF COURTS_IE'                                           => 'I0013',
 psourcename = 'OH FAIRFIELD MUNICIPAL COURT_IE'                                          => 'I0014',
 psourcename = 'OK CLEVELAND DISTRICT COURT_IE'                                           => 'I0015',
 psourcename = 'OK COMANCHE DISTRICT COURT_IE'                                            => 'I0016',
 psourcename = 'OK OKLAHOMA DISTRICT COURT_IE'                                            => 'I0017',
 psourcename = 'OK PAYNE DISTRICT COURT_IE'                                               => 'I0018',
 psourcename = 'OK ROGERS DISTRICT COURT_IE'                                              => 'I0019',
 psourcename = 'OK TULSA DISTRICT COURT_IE'                                               => 'I0020',
 psourcename = 'SC JASPER SUMMARY COURT_IE'                                               => 'I0021',
 psourcename = 'TN DAVIDSON GENERAL SESSIONS COURT_IE'                                    => 'I0022',
 psourcename = 'TN HAMILTON GENERAL SESSIONS COURT_IE'                                    => 'I0023',
 psourcename = 'TX BOWIE DISTRICT AND COUNTY COURTS_IE'                                   => 'I0024',
 psourcename = 'TX EL PASO COUNTY COURTS_IE'                                              => 'I0025',
 psourcename = 'TX TAYLOR COUNTY COURTS_IE'                                               => 'I0026',
 psourcename = 'TX TAYLOR JUSTICE OF THE PEACE_IE'                                        => 'I0027',
 // psourcename = 'CA KERN SUPERIOR COURT_IE'                                                => 'I0028',
 // psourcename = 'CA SAN BERNARDINO SUPERIOR COURT_IE'                                      => 'I0029',
 // psourcename = 'CO DENVER COUNTY COURT_IE'                                                => 'I0030',
 // psourcename = 'IL KANE CIRCUIT COURT_IE'                                                 => 'I0031',         
 // psourcename = 'LA ORLEANS PARISH DISTRICT COURT_IE'                                      => 'I0032',
 // psourcename = 'NE LANCASTER COUNTY AND DISTRICT COURTS_IE'                               => 'I0033',
 // psourcename = 'OH FRANKLIN COURT OF COMMON PLEAS_IE'                                     => 'I0034',
 // psourcename = 'OH PORTAGE RAVENNA MUNICIPAL COURT_IE'                                    => 'I0035',
 // psourcename = 'TN DAVIDSON GENERAL SESSIONS COURT (LEGACY)_IE'                           => 'I0036',
 // psourcename = 'TX HARRIS COUNTY COURTS DISPOSITION_IE'                                   => 'I0037',
//-------------------------------IE DOC Batch 1 20181005 ---------------------------------------------------
 psourcename = 'CO DEPARTMENT OF CORRECTIONS_IE'                                            => 'I0038',                                                                
 psourcename = 'NY DEPARTMENT OF CORRECTIONS RELEASED_IE'                                   => 'I0039',
 psourcename = 'UT DEPARTMENT OF CORRECTIONS_IE'                                            => 'I0040',

/************************************************IE DATA END*************************************************************/
																																						 
 '');                                                                            											



      

 
         
 

 return vendor;                                                                                       
end;                                                                                   
                                                                                       
                                                                                                       
export fn_vendorcode_sourcename(string5 vendor_code, string8 src_upload_date) := function
	string sourcename :=                                                             
	map(                                                                             
 //AOC
 vendor_code = 'Z1' => 'ARIZONA ADMINISTRATOR OF THE COURTS',
 vendor_code = 'RC' => 'ALASKA ADMINISTRATOR OF THE COURTS',
 vendor_code = 'RD' => 'ARKANSAS ADMINISTRATOR OF THE COURTS',
 vendor_code = 'CP' => 'CONNECTICUT ADMINISTRATOR OF THE COURTS',
 vendor_code = 'FV' => 'FLORIDA ADMINISTRATOR OF THE COURTS',
 vendor_code = 'GD' => 'GEORGIA BUREAU OF INVESTIGATION',
 vendor_code = 'HA' => 'HAWAII STATE JUDICIARY',
 vendor_code = 'Z4' => 'INDIANA ADMINISTRATOR OF THE COURTS',
 vendor_code = 'IC' => 'IOWA ADMINISTRATOR OF THE COURTS',
 vendor_code = 'MF' => 'MARYLAND ADMINISTRATOR OF THE COURTS',
 vendor_code = 'MH' => 'MINNESOTA DEPARTMENT OF PUBLIC SAFETY',
 vendor_code = 'MG' => 'MISSOURI ADMINISTRATOR OF THE COURTS',
 vendor_code = 'NA' => 'NEW JERSEY ADMINISTRATOR OF THE COURTS',
 vendor_code = 'NB' => 'NEW MEXICO ADMINISTRATOR OF THE COURTS',
 vendor_code = 'NG' => 'NORTH DAKOTA ADMINISTRATOR OF THE COURTS',
 vendor_code = 'PS' => 'OKLAHOMA ADMINISTRATOR OF THE COURTS',
 vendor_code = 'PT' => 'OREGON ADMINISTRATOR OF THE COURTS',
 vendor_code = 'PU' => 'PENNSYLVANIA ADMINISTRATOR OF THE COURTS',
 vendor_code = 'PV' => 'PENNSYLVANIA ADMINISTRATOR OF THE COURTS COURT OF COMMON PLEAS',
 vendor_code = 'RA' => 'RHODE ISLAND ADMINISTRATOR OF THE COURTS',
 vendor_code = 'RB' => 'RHODE ISLAND ADMINISTRATOR OF THE COURTS TRAFFIC',
 vendor_code = 'TB' => 'TEXAS DEPARTMENT OF PUBLIC SAFETY',
 vendor_code = 'TA' => 'TENNESSEE ADMINISTRATOR OF THE COURTS',
 vendor_code = 'UA' => 'UTAH ADMINISTRATOR OF THE COURTS',
 vendor_code = 'VB' => 'VIRGINIA ADMINISTRATOR OF THE COURTS',
 vendor_code = 'WB' => 'WISCONSIN ADMINISTRATOR OF THE COURTS',
 vendor_code = 'NF' => 'NORTH_CAROLINA_ADMINISTRATIVE_OFFICE_OF_THE_COURTS_DEMOGRAPHIC_INDEX',
 
//////////////Phase3 
  vendor_code = '7A'=> 'SOUTH_CAROLINA_ADMINISTRATOR_OF_THE_COURTS'          , 
	vendor_code = '7B'=> 'UTAH_JUSTICE_COURT_TRAFFIC'                          , 
  vendor_code = '7Q'=> 'MARYLAND_ADMINISTRATOR_OF_THE_COURTS_TRAFFIC'        , 
 
 //DOC
 vendor_code = 'Z8' => 'WASHINGTON PUBLIC SCOMIS CRIMINAL INDEX',
 vendor_code = 'Z9' => 'WASHINGTON COURTS OF LIMITED JURISDICTION CRIMINAL INDEX',
 vendor_code = 'DA' => 'ALABAMA DEPARTMENT OF CORRECTIONS',
 vendor_code = 'DB' => 'ARKANSAS DEPARTMENT OF CORRECTIONS',
 vendor_code = 'DD' => 'ARIZONA DEPARTMENT OF CORRECTIONS',
 vendor_code = 'DF' => 'CALIFORNIA DEPARTMENT OF CORRECTIONS AND REHABILITATION',
 vendor_code = 'DG' => 'CONNECTICUT DEPARTMENT OF CORRECTIONS',
 vendor_code = 'DH' => 'COLORADO DEPARTMENT OF CORRECTIONS',
 vendor_code = 'DI' and src_upload_date[1..4]<>'2004' => 'FLORIDA DEPARTMENT OF CORRECTIONS',
 vendor_code = 'DI' and src_upload_date[1..4]='2004'  => 'FLORIDA DEPARTMENT OF CORRECTIONS HISTORY FILE',
 vendor_code = 'DJ' => 'GEORGIA DEPARTMENT OF CORRECTIONS',
 vendor_code = 'DK' => 'GEORGIA PAROLE',
 vendor_code = 'DL' => 'HAWAII DEPARTMENT OF CORRECTIONS',
 vendor_code = 'DM' => 'IDAHO DEPARTMENT OF CORRECTIONS',
 vendor_code = 'DN' => 'INDIANA DEPARTMENT OF CORRECTIONS',
 vendor_code = 'DO' => 'IOWA DEPARTMENT OF CORRECTIONS',
 vendor_code = 'DP' => 'IOWA DEPARTMENT OF CORRECTIONS PROBATION',
 vendor_code = 'DQ' => 'ILLINOIS DEPARTMENT OF CORRECTIONS',
 vendor_code = 'DR' => 'KENTUCKY DEPARTMENT OF CORRECTIONS',
 vendor_code = 'SB' => 'KANSAS DEPARTMENT OF CORRECTIONS'  ,
 vendor_code = 'DS' => 'LOUISIANA DEPARTMENT OF CORRECTIONS PAROLE',
 vendor_code = 'DT' => 'MAINE DEPARTMENT OF CORRECTIONS',
 vendor_code = 'DU' => 'MARYLAND DEPARTMENT OF CORRECTIONS',
 vendor_code = 'DV' => 'MICHIGAN DEPARTMENT OF CORRECTIONS',
 vendor_code = 'DW' => 'MICHIGAN DEPARTMENT OF CORRECTIONS ALTERNATE FILE',
 vendor_code = 'DX' => 'MONTANA DEPARTMENT OF CORRECTIONS',
 vendor_code = 'DY' => 'MISSISSIPPI DEPARTMENT OF CORRECTIONS',
 vendor_code = 'DZ' => 'MINNESOTA DEPARTMENT OF CORRECTIONS',
 vendor_code = 'EU' => 'MISSOURI DEPARTMENT OF CORRECTIONS',
 vendor_code = 'EV' => 'NORTH CAROLINA DEPARTMENT OF CORRECTIONS',
 vendor_code = 'EW' => 'NORTH DAKOTA DEPARTMENT OF CORRECTIONS',
 vendor_code = 'EX' => 'NEBRASKA DEPARTMENT OF CORRECTIONS',
 vendor_code = 'EY' => 'NEW HAMPSHIRE DEPARTMENT OF CORRECTIONS',
 vendor_code = 'EA' => 'NEW JERSEY DEPARTMENT OF CORRECTIONS',
 vendor_code = 'EB' => 'NEW MEXICO DEPARTMENT OF CORRECTIONS',
 vendor_code = 'EC' => 'NEVADA DEPARTMENT OF CORRECTIONS',
 vendor_code = 'ED' => 'NEW YORK DEPARTMENT OF CORRECTIONS',
 vendor_code = 'EE' => 'OHIO DEPARTMENT OF CORRECTIONS',
 vendor_code = 'EF' => 'OKLAHOMA DEPARTMENT OF CORRECTIONS',
 vendor_code = 'EG' => 'OREGON DEPARTMENT OF CORRECTIONS',
 vendor_code = 'EH' => 'PENNSYLVANIA DEPARTMENT OF CORRECTIONS',
 vendor_code = 'EI' => 'RHODE ISLAND DEPARTMENT OF CORRECTIONS',
 vendor_code = 'EJ' => 'SOUTH CAROLINA DEPARTMENT OF CORRECTIONS',
 vendor_code = 'EK' => 'TENNESSEE DEPARTMENT OF CORRECTIONS',
 vendor_code = 'EL' => 'TEXAS DEPARTMENT OF CORRECTIONS',
 vendor_code = 'EM' => 'UTAH DEPARTMENT OF CORRECTIONS',
 vendor_code = 'EN' => 'VIRGINIA DEPARTMENT OF CORRECTIONS',
 vendor_code = 'EO' => 'VERMONT DEPARTMENT OF CORRECTIONS',
 vendor_code = 'EP' => 'WASHINGTON DEPARTMENT OF CORRECTIONS',
 vendor_code = 'EQ' => 'WASHINGTON DC DEPARTMENT OF CORRECTIONS',
 vendor_code = 'ER' => 'WISCONSIN DEPARTMENT OF CORRECTIONS',
 vendor_code = 'ES' => 'WEST VIRGINIA DEPARTMENT OF CORRECTIONS',
 vendor_code = 'ET' => 'WEST VIRGINIA DEPARTMENT OF CORRECTIONS ALTERNATE',
 vendor_code = 'WL' => 'MISSISSIPPI DEPARTMENT OF CORRECTIONS WEBSITE',
 vendor_code = 'WC' => 'NEVADA DEPARTMENT OF CORRECTIONS WEBSITE'  ,
 vendor_code = 'WD' => 'NEW HAMPSHIRE DEPARTMENT OF CORRECTIONS WEBSITE',
 vendor_code = 'WE' => 'NEW JERSEY DEPARTMENT OF CORRECTIONS WEBSITE'  ,
 vendor_code = 'WF' => 'NEW YORK DEPARTMENT OF CORRECTIONS WEBSITE',
 vendor_code = 'WG' => 'NORTH CAROLINA DEPARTMENT OF CORRECTIONS WEBSITE'  ,
 vendor_code = 'WH' => 'OKLAHOMA DEPARTMENT OF CORRECTIONS WEBSITE',
 vendor_code = 'WJ' => 'OHIO DEPARTMENT OF CORRECTIONS WEBSITE',
 vendor_code = 'WK' => 'UTAH DEPARTMENT OF CORRECTIONS WEBSITE'  ,
 vendor_code = 'VE' => 'GEORGIA DEPARTMENT OF CORRECTIONS WEBSITE', 
 //County
 vendor_code = 'RE' => 'ARIZONA MARICOPA COUNTY GILBERT MUNICIPAL COURT',
 vendor_code = 'RF' => 'ARIZONA MARICOPA COUNTY',
 vendor_code = 'RG' => 'ARIZONA PIMA COUNTY',
 vendor_code = 'CB' => 'CALIFORNIA MARIN COUNTY',
 vendor_code = 'CC' => 'CALIFORNIA RIVERSIDE COUNTY CITY OF INDIO',
 vendor_code = 'CD' => 'CALIFORNIA SANTA CRUZ COUNTY',
 vendor_code = 'CE' => 'CALIFORNIA SAN DIEGO COUNTY',
 vendor_code = 'CF' => 'CALIFORNIA SANTA BARBARA COUNTY',
 vendor_code = 'CG' => 'CALIFORNIA CONTRA COSTA COUNTY',
 vendor_code = 'CH' => 'CALIFORNIA ORANGE COUNTY',
 vendor_code = 'CI' => 'CALIFORNIA FRESNO COUNTY',
 vendor_code = 'CJ' => 'CALIFORNIA SANTA CLARA COUNTY',
 vendor_code = 'CK' => 'CALIFORNIA SAN BERNARDINO COUNTY',
 vendor_code = 'CL' => 'CALIFORNIA RIVERSIDE COUNTY',
 vendor_code = 'CM' => 'CALIFORNIA VENTURA COUNTY',
 vendor_code = 'CN' => 'CALIFORNIA LOS ANGELES COUNTY',
 vendor_code = 'FA' => 'FLORIDA HIGHLANDS COUNTY',
 vendor_code = 'FB' => 'FLORIDA SARASOTA COUNTY',
 vendor_code = 'FC' => 'FLORIDA LEE COUNTY',
 vendor_code = 'FD' => 'FLORIDA PALM BEACH COUNTY',
 vendor_code = 'FE' => 'FLORIDA BROWARD COUNTY',
 vendor_code = 'FG' => 'FLORIDA HILLSBOROUGH COUNTY',
 vendor_code = 'FH' => 'FLORIDA ALACHUA COUNTY',
 vendor_code = 'FI' => 'FLORIDA BAY COUNTY',
 vendor_code = 'FJ' => 'FLORIDA OSCEOLA COUNTY',
 vendor_code = 'FK' => 'FLORIDA CHARLOTTE COUNTY',
 vendor_code = 'FM' => 'FLORIDA LEON COUNTY',
 vendor_code = 'FN' => 'FLORIDA DUVAL COUNTY',
 vendor_code = 'FO' => 'FLORIDA DADE COUNTY',
 vendor_code = 'FP' => 'FLORIDA BREVARD COUNTY',
 vendor_code = 'FQ' => 'FLORIDA HERNANDO COUNTY',
 vendor_code = 'FR' => 'FLORIDA ORANGE COUNTY',
 vendor_code = 'FS' => 'FLORIDA PINELLAS COUNTY',
 vendor_code = 'FT' => 'FLORIDA MONROE COUNTY',
 vendor_code = 'FU' => 'FLORIDA MARION COUNTY',
 vendor_code = 'GB' => 'GEORGIA COBB COUNTY',
 vendor_code = 'GC' => 'GEORGIA GWINNETT COUNTY',
 vendor_code = 'IB' => 'ILLINOIS COOK COUNTY',
 vendor_code = 'LB' => 'LOUISIANA ST TAMMANY COUNTY',
 vendor_code = 'MB' => 'MICHIGAN WAYNE COUNTY',
 vendor_code = 'MC' => 'MISSISSIPPI HINDS COUNTY',
 vendor_code = 'OA' => 'OHIO ALLEN COUNTY LIMA MUNICIPAL COURT',
 vendor_code = 'OB' => 'OHIO SUMMIT COUNTY CUYAHOGA FALLS MUNICIPAL COURT',
 vendor_code = 'OC' => 'OHIO MONTGOMERY COUNTY DAYTON MUNICIPAL COURT',
 vendor_code = 'OD' => 'OHIO WARREN COUNTY MASON MUNICIPAL COURT',
 vendor_code = 'OE' => 'OHIO FRANKLIN COUNTY MUNICIPAL COURT',
 vendor_code = 'OF' => 'OHIO WARREN COUNTY',
 vendor_code = 'OG' => 'OHIO CLINTON COUNTY',
 vendor_code = 'OI' => 'OHIO COLUMBIANA COUNTY',
 vendor_code = 'OJ' => 'OHIO LAWRENCE COUNTY MUNICIPAL COURT',
 vendor_code = 'OL' => 'OHIO TRUMBULL COUNTY',
 vendor_code = 'OM' => 'OHIO ALLEN COUNTY',
 vendor_code = 'ON' => 'OHIO PORTAGE COUNTY',
 vendor_code = 'OO' => 'OHIO LICKING COUNTY',
 vendor_code = 'OP' => 'OHIO GREENE COUNTY XENIA MUNICIPAL COURT',
 vendor_code = 'OQ' => 'OHIO CLERMONT COUNTY',
 vendor_code = 'EZ' => 'OHIO SUMMIT COUNTY BARBERTON MUNICIPAL COURT',
 vendor_code = 'OS' => 'OHIO ROSS COUNTY',
 vendor_code = 'OT' => 'OHIO GREENE COUNTY',
 vendor_code = 'OU' => 'OHIO TUSCARAWAS COUNTY',
 vendor_code = 'OV' => 'OHIO SUMMIT COUNTY',
 vendor_code = 'OW' => 'OHIO ROSS COUNTY CHILLICOTHE MUNICIPAL COURT',
 vendor_code = 'OX' => 'OHIO CUYAHOGA COUNTY EUCLID MUNICIPAL COURT',
 vendor_code = 'OY' => 'OHIO MONTGOMERY COUNTY',
 vendor_code = 'OZ' => 'OHIO TRUMBULL COUNTY NEWTON FALLS MUNICIPAL COURT',
 vendor_code = 'PB' => 'OHIO BUTLER COUNTY',
 vendor_code = 'PC' => 'OHIO MONTGOMERY COUNTY VANDALIA MUNICIPAL COURT',
 vendor_code = 'PD' => 'OHIO DELAWARE COUNTY',
 vendor_code = 'PE' => 'OHIO WARREN COUNTY COURT',
 vendor_code = 'PF' => 'OHIO SUMMIT COUNTY AKRON MUNICIPAL COURT',
 vendor_code = 'PG' => 'OHIO FRANKLIN COUNTY',
 vendor_code = 'PH' => 'OHIO STARK COUNTY COMMON PLEAS COURT',
 vendor_code = 'PI' => 'OHIO MONTGOMERY COUNTY NEW LEBANON COUNTY COURT',
 vendor_code = 'PJ' => 'OHIO CUYAHOGA COUNTY BEREA MUNICIPAL COURT',
 vendor_code = 'PK' => 'OHIO MONTGOMERY COUNTY HUBER HEIGHTS COUNTY COURT',
 vendor_code = 'PL' => 'OHIO MONTGOMERY COUNTY KETTERING MUNICIPAL COURT',
 vendor_code = 'PM' => 'OHIO ATHENS COUNTY ATHENS MUNICIPAL COURT',
 vendor_code = 'PN' => 'OHIO FULTON COUNTY',
 vendor_code = 'PO' => 'OHIO STARK COUNTY',
 vendor_code = 'PQ' => 'OHIO BROWN COUNTY BROWN MUNICIPAL COURT',
 vendor_code = 'SA' => 'SOUTH CAROLINA RICHLAND COUNTY CIRCUIT COURTS',
 vendor_code = 'TR' => 'TEXAS BEXAR COUNTY',
 vendor_code = 'TC' => 'TEXAS BRAZORIA COUNTY',
 vendor_code = 'TD' => 'TEXAS COLLIN COUNTY',
 vendor_code = 'TE' => 'TEXAS DALLAS COUNTY',
 vendor_code = 'TF' => 'TEXAS DENTON COUNTY',
 vendor_code = 'TG' => 'TEXAS EL PASO COUNTY',
 vendor_code = 'TH' => 'TEXAS FORT BEND COUNTY',
 vendor_code = 'TI' => 'TEXAS GREGG COUNTY',
 vendor_code = 'TJ' => 'TEXAS HARRIS COUNTY',  
 vendor_code = 'TK' => 'TEXAS JEFFERSON COUNTY',
 vendor_code = 'TL' => 'TEXAS JOHNSON COUNTY',
 vendor_code = 'TM' => 'TEXAS MIDLAND COUNTY',
 vendor_code = 'TP' => 'TEXAS POTTER COUNTY',
 vendor_code = 'TO' => 'TEXAS VICTORIA COUNTY',
 vendor_code = 'TQ' => 'TEXAS MONTGOMERY COUNTY',
 vendor_code = 'PR' => 'VIRGINIA FAIRFAX COUNTY',

//////////////Phase3
	vendor_code = '7C'=> 'CALIFORNIA_SHASTA_COUNTY_SUPERIOR_COURT'              ,
  vendor_code = '7D'=> 'FLORIDA_COLLIER'                                      ,
  vendor_code = '7E'=> 'FLORIDA_COLLIER_TRAFFIC'                              ,
	vendor_code = '7F'=> 'FLORIDA_MARTIN_COUNTY'                                ,
  vendor_code = '7G'=> 'MINNESOTA_DISTRICT_COURTS'                            ,
  vendor_code = '7H'=> 'OHIO_GALLIA_COUNTY_GALLIPOLIS_MUNICIPAL_COURT'        ,
	vendor_code = '7I'=> 'OHIO_MONROE_COUNTY_COMMON_PLEAS_COURT'                ,   
  vendor_code = '7J'=> 'OHIO_MORROW_COUNTY_MUNICIPAL_COURT'                   ,
  vendor_code = '7K'=> 'TEXAS_BELL_COUNTY'                                    ,
	vendor_code = '7L'=> 'TEXAS_HOOD_COUNTY'                                    ,
  vendor_code = '7M'=> 'TEXAS_JEFFERSON_COUNTY_DISTRICT_COURT'                ,
  vendor_code = '7N'=> 'TEXAS_LAMAR_COUNTY'                                   ,
	vendor_code = '7O'=> 'TEXAS_LAMAR_COUNTY_JUSTICE_OF_THE_PEACE_COURTS'       ,
  vendor_code = '7P'=> 'TEXAS_LIBERTY_COUNTY'                                 ,
  vendor_code = '7R'=> 'FLORIDA_PASCO_COUNTY'                                 ,
	vendor_code = '7S'=> 'FLORIDA_PASCO_COUNTY_TRAFFIC'                         ,
	
  //VC 20151105	
	vendor_code = '7T'=> 'ARIZONA_MARICOPA_COUNTY_SUPERIOR_COURT_FILINGS'       ,
	vendor_code = '7U'=> 'DISTRICT_OF_COLUMBIA_SUPERIOR_COURT'                  ,
	vendor_code = '7V'=> 'FLORIDA_ESCAMBIA_COUNTY_CIRCUIT_COURT'                ,
	vendor_code = '7W'=> 'FLORIDA_FLAGLER_COUNTY_CIRCUIT_COURT'                 ,
	vendor_code = '7X'=> 'FLORIDA_MANATEE_CIRCUIT_AND_COUNTY_COURTS'            ,
	vendor_code = '7Y'=> 'ILLINOIS_COOK_COUNTY_MISDEMEANOR'                     ,
	vendor_code = '7Z'=> 'ILLINOIS_PEORIA_COUNTY'                               ,
	vendor_code = '8A'=> 'NEVADA_CLARK_COUNTY_DISTRICT_COURTS'                  ,
  vendor_code = '8B'=> 'FLORIDA_PUTNAM_COUNTY'                                ,
	vendor_code = '8C'=> 'FLORIDA_PUTNAM_COUNTY_TRAFFIC'                        ,
	vendor_code = '8D'=> 'OHIO_SHELBY_COUNTY_COMMON_PLEAS_COURT'                ,
	vendor_code = '8E'=> 'TEXAS_LIBERTY_COUNTY_DISTRICT_COURT'                  ,
	vendor_code = '8F'=> 'ILLINOIS_VIOLENT_OFFENDER_AGAINST_YOUTH'              ,
	vendor_code = '8G'=> 'UTAH_JUSTICE_COURT'                                   ,
  vendor_code = '8H'=> 'WEST_VIRGINIA_CIRCUIT_COURTS'                         ,
	vendor_code = '8I'=> 'FLORIDA_HILLSBOROUGH_COUNTY_TRAFFIC'                  ,
	
 //Arrests                                                                   
 vendor_code = 'BA' => 'ALABAMA BALDWIN COUNTY ARRESTS',
 vendor_code = 'BB' => 'ALABAMA CALHOUN COUNTY ARRESTS',
 vendor_code = 'BC' => 'ALABAMA HOUSTON COUNTY ARRESTS',
 vendor_code = 'BD' => 'ALABAMA JEFFERSON COUNTY ARRESTS',
 vendor_code = 'BE' => 'ALABAMA MOBILE COUNTY ARRESTS',
 vendor_code = 'BF' => 'ALABAMA MONTGOMERY COUNTY ARRESTS',
 vendor_code = 'BG' => 'ALABAMA SHELBY COUNTY ARRESTS',
 vendor_code = 'BH' => 'ALABAMA TUSCALOOSA COUNTY ARRESTS',
 vendor_code = 'BL' => 'ARIZONA MARICOPA COUNTY ARRESTS',
 vendor_code = 'BM' => 'ARIZONA PIMA COUNTY ARRESTS',
 vendor_code = 'BI' => 'ARKANSAS BENTON COUNTY ARRESTS',
 vendor_code = 'BJ' => 'ARKANSAS UNION COUNTY ARRESTS',
 vendor_code = 'BK' => 'ARKANSAS WASHINGTON COUNTY ARRESTS',
 vendor_code = 'BN' => 'CALIFORNIA FRESNO COUNTY ARRESTS',
 vendor_code = 'BO' => 'CALIFORNIA KERN COUNTY ARRESTS',
 vendor_code = 'BP' => 'CALIFORNIA KINGS COUNTY ARRESTS',
 vendor_code = 'BQ' => 'CALIFORNIA LOS ANGELES COUNTY ARRESTS',
 vendor_code = 'BR' => 'CALIFORNIA MARIN COUNTY ARRESTS',
 vendor_code = 'BS' => 'CALIFORNIA ORANGE COUNTY ARRESTS',
 vendor_code = 'BT' => 'CALIFORNIA PLACER COUNTY ARRESTS',
 vendor_code = 'BU' => 'CALIFORNIA RIVERSIDE COUNTY ARRESTS',
 vendor_code = 'BV' => 'CALIFORNIA SACRAMENTO COUNTY ARRESTS',
 vendor_code = 'BW' => 'CALIFORNIA SAN BERNARDINO COUNTY ARRESTS',
 vendor_code = 'BX' => 'CALIFORNIA SAN DIEGO COUNTY ARRESTS',
 vendor_code = 'BY' => 'CALIFORNIA TEHAMA COUNTY ARRESTS',
 vendor_code = 'BZ' => 'COLORADO EL PASO COUNTY ARRESTS',
 vendor_code = 'CQ' => 'COLORADO MESA COUNTY ARRESTS',
 vendor_code = 'CR' => 'COLORADO PITKIN COUNTY ARRESTS',
 vendor_code = 'CS' => 'COLORADO PUEBLO COUNTY ARRESTS',
 vendor_code = 'CU' => 'COLORADO WELD COUNTY ARRESTS',
 vendor_code = 'CV' => 'CONNECTICUT MADISON COUNTY ARRESTS',
 vendor_code = 'CW' => 'FLORIDA BREVARD COUNTY ARRESTS',
 vendor_code = 'CX' => 'FLORIDA BROWARD COUNTY ARRESTS',
 vendor_code = 'CY' => 'FLORIDA CHARLOTTE COUNTY ARRESTS',
 vendor_code = 'CZ' => 'FLORIDA CITRUS COUNTY ARRESTS',
 vendor_code = 'Z5' => 'FLORIDA DESOTO COUNTY ARRESTS',
 vendor_code = 'FW' => 'FLORIDA ESCAMBIA COUNTY ARRESTS',
 vendor_code = 'FX' => 'FLORIDA ESCAMBIA COUNTY ARRESTS BLOTTER FILE',
 vendor_code = 'FY' => 'FLORIDA HARDEE COUNTY ARRESTS',
 vendor_code = 'FZ' => 'FLORIDA HERNANDO COUNTY ARRESTS',
 vendor_code = 'GE' => 'FLORIDA HILLSBOROUGH COUNTY ARRESTS',
 vendor_code = 'GF' => 'FLORIDA INDIAN RIVER COUNTY ARRESTS',
 vendor_code = 'GG' => 'FLORIDA LAKE COUNTY ARRESTS',
 vendor_code = 'GH' => 'FLORIDA LEE COUNTY ARRESTS',
 vendor_code = 'GI' => 'FLORIDA MARTIN COUNTY ARRESTS',
 vendor_code = 'GJ' => 'FLORIDA MONROE COUNTY ARRESTS',
 vendor_code = 'GK' => 'FLORIDA ORANGE COUNTY ARRESTS',
 vendor_code = 'GL' => 'FLORIDA OSCEOLA COUNTY ARRESTS',
 vendor_code = 'GM' => 'FLORIDA PALM BEACH COUNTY ARRESTS',
 vendor_code = 'GN' => 'FLORIDA POLK COUNTY ARRESTS',
 vendor_code = 'GO' => 'FLORIDA PUTNAM COUNTY ARRESTS',
 vendor_code = 'GP' => 'FLORIDA SEMINOLE COUNTY ARRESTS',
 vendor_code = 'GQ' => 'FLORIDA SUWANNEE COUNTY ARRESTS',
 vendor_code = 'GR' => 'FLORIDA VOLUSIA COUNTY ARRESTS',
 vendor_code = 'GS' => 'GEORGIA BIBB COUNTY ARRESTS',
 vendor_code = 'GT' => 'GEORGIA CHATHAM COUNTY ARRESTS',
 vendor_code = 'GU' => 'GEORGIA CLARKE COUNTY ARRESTS',
 vendor_code = 'GV' => 'GEORGIA DAWSON COUNTY ARRESTS',
 vendor_code = 'GW' => 'GEORGIA FULTON COUNTY ARRESTS',
 vendor_code = 'GX' => 'GEORGIA GWINNETT COUNTY ARRESTS',
 vendor_code = 'HB' => 'IDAHO ADA COUNTY ARRESTS',
 vendor_code = 'HC' => 'IDAHO CANYON COUNTY ARRESTS',
 vendor_code = 'HD' => 'IDAHO KOOTENAI COUNTY ARRESTS',
 vendor_code = 'HE' => 'ILLINOIS COOK COUNTY ARRESTS',
 vendor_code = 'HF' => 'ILLINOIS PEORIA COUNTY ARRESTS',
 vendor_code = 'HG' => 'ILLINOIS WILL COUNTY ARRESTS',
 vendor_code = 'GY' => 'IOWA BUENA VISTA COUNTY ARRESTS',
 vendor_code = 'GZ' => 'IOWA DALLAS COUNTY ARRESTS',
 vendor_code = 'HH' => 'KANSAS JOHNSON COUNTY ARRESTS',
 vendor_code = 'HJ' => 'KANSAS WYANDOTTE COUNTY ARRESTS',
 vendor_code = 'HK' => 'KENTUCKY BOONE COUNTY ARRESTS',
 vendor_code = 'HL' => 'KENTUCKY FULTON COUNTY ARRESTS',
 vendor_code = 'HM' => 'KENTUCKY MCCRACKEN COUNTY ARRESTS',
 vendor_code = 'HN' => 'LOUISIANA BOSSIER COUNTY ARRESTS',
 vendor_code = 'HO' => 'LOUISIANA EAST BATON ROUGE COUNTY ARRESTS',
 vendor_code = 'HP' => 'LOUISIANA LAFAYETTE COUNTY ARRESTS',
 vendor_code = 'HQ' => 'LOUISIANA LAFOURCHE COUNTY ARRESTS',
 vendor_code = 'HR' => 'LOUISIANA ORLEANS COUNTY ARRESTS',
 vendor_code = 'HS' => 'LOUISIANA OUACHITA COUNTY ARRESTS',
 vendor_code = 'HT' => 'MASSACHUSETTS BILLERICA POLICE ARRESTS',
 vendor_code = 'HU' => 'MASSACHUSETTS ORLEANS POLICE ARRESTS',
 vendor_code = 'HV' => 'MASSACHUSETTS WALTHAM COUNTY ARRESTS',
 vendor_code = 'HW' => 'MASSACHUSETTS WELLFLEET POLICE ARRESTS',
 vendor_code = 'HX' => 'MASSACHUSETTS WRENTHAM POLICE ARRESTS',
 vendor_code = 'HY' => 'MICHIGAN KENT COUNTY ARRESTS',
 vendor_code = 'HZ' => 'MICHIGAN WAYNE COUNTY ARRESTS',
 vendor_code = 'IE' => 'MINNESOTA DAKOTA COUNTY ARRESTS',
 vendor_code = 'IF' => 'MINNESOTA HENNEPIN COUNTY ARRESTS',
 vendor_code = 'IG' => 'MINNESOTA OLMSTED COUNTY ARRESTS',
 vendor_code = 'IJ' => 'MISSISSIPPI HARRISON COUNTY ARRESTS',
 vendor_code = 'IK' => 'MISSISSIPPI LEE COUNTY ARRESTS',
 vendor_code = 'IH' => 'MISSOURI CLAY COUNTY ARRESTS',
 vendor_code = 'II' => 'MISSOURI ST FRANCOIS COUNTY ARRESTS',
 vendor_code = 'IO' => 'MONTANA MISSOULA COUNTY ARRESTS',
 vendor_code = 'IP' => 'MONTANA YELLOWSTONE COUNTY ARRESTS',
 vendor_code = 'IZ' => 'NEBRASKA HALL COUNTY ARRESTS',
 vendor_code = 'KE' => 'NEVADA CLARK COUNTY ARRESTS',
 vendor_code = 'KF' => 'NEVADA HUMBOLDT COUNTY ARRESTS',
 vendor_code = 'KA' => 'NEW JERSEY HUNTERDON COUNTY ARRESTS',
 vendor_code = 'KB' => 'NEW MEXICO BERNALILLO COUNTY ARRESTS',
 vendor_code = 'KC' => 'NEW MEXICO SAN JUAN COUNTY ARRESTS',
 vendor_code = 'KD' => 'NEW MEXICO SANTA FE COUNTY ARRESTS',
 vendor_code = 'KG' => 'NEW YORK FULTON POLICE ARRESTS',
 vendor_code = 'KH' => 'NEW YORK ONEIDA COUNTY ARRESTS',
 vendor_code = 'KI' => 'NEW YORK ONONDAGA COUNTY ARRESTS',
 vendor_code = 'IQ' => 'NORTH CAROLINA CABARRUS COUNTY ARRESTS',
 vendor_code = 'IR' => 'NORTH CAROLINA CATAWBA COUNTY ARRESTS',
 vendor_code = 'IS' => 'NORTH CAROLINA DURHAM COUNTY ARRESTS',
 vendor_code = 'IT' => 'NORTH CAROLINA GUILFORD COUNTY ARRESTS',
 vendor_code = 'IU' => 'NORTH CAROLINA LINCOLN COUNTY ARRESTS',
 vendor_code = 'IV' => 'NORTH CAROLINA MECKLENBURG COUNTY ARRESTS',
 vendor_code = 'IW' => 'NORTH CAROLINA RANDOLPH COUNTY ARRESTS',
 vendor_code = 'IX' => 'NORTH CAROLINA ROWAN COUNTY ARRESTS',
 vendor_code = 'IY' => 'NORTH CAROLINA UNION COUNTY ARRESTS',
 vendor_code = 'KJ' => 'OHIO FAYETTE COUNTY ARRESTS',
 vendor_code = 'KK' => 'OHIO GALLIA COUNTY ARRESTS',
 vendor_code = 'KL' => 'OHIO HAMILTON COUNTY ARRESTS',
 vendor_code = 'KM' => 'OHIO HIGHLAND COUNTY ARRESTS',
 vendor_code = 'KN' => 'OHIO LICKING COUNTY ARRESTS',
 vendor_code = 'KO' => 'OHIO LOGAN COUNTY ARRESTS',
 vendor_code = 'KP' => 'OHIO MONTGOMERY COUNTY ARRESTS',
 vendor_code = 'KQ' => 'OHIO SANDUSKY COUNTY ARRESTS',
 vendor_code = 'KR' => 'OHIO SHELBY COUNTY ARRESTS',
 vendor_code = 'KT' => 'OHIO SOUTHEAST COUNTY ARRESTS',
 vendor_code = 'KU' => 'OHIO WASHINGTON COUNTY ARRESTS',
 vendor_code = 'KV' => 'OKLAHOMA CARTER COUNTY ARRESTS',
 vendor_code = 'KW' => 'OKLAHOMA COMANCHE COUNTY ARRESTS',
 vendor_code = 'KX' => 'OKLAHOMA OSAGE COUNTY ARRESTS',
 vendor_code = 'KZ' => 'OREGON CLACKAMAS COUNTY ARRESTS',
 vendor_code = 'LC' => 'OREGON DESCHUTES COUNTY ARRESTS',
 vendor_code = 'LD' => 'OREGON DOUGLAS COUNTY ARRESTS',
 vendor_code = 'LE' => 'OREGON JACKSON COUNTY ARRESTS',
 vendor_code = 'LF' => 'OREGON JOSEPHINE COUNTY ARRESTS',
 vendor_code = 'LG' => 'OREGON LANE COUNTY ARRESTS',
 vendor_code = 'LH' => 'OREGON LINCOLN COUNTY ARRESTS',
 vendor_code = 'LI' => 'OREGON LINN COUNTY ARRESTS',
 vendor_code = 'LJ' => 'OREGON MARION COUNTY ARRESTS',
 vendor_code = 'LK' => 'OREGON MORROW COUNTY ARRESTS',
 vendor_code = 'LL' => 'OREGON MULTNOMAH COUNTY ARRESTS',
 vendor_code = 'LM' => 'OREGON POLK COUNTY ARRESTS',
 vendor_code = 'LN' => 'OREGON UMATILLA COUNTY ARRESTS',
 vendor_code = 'LO' => 'OREGON WASHINGTON COUNTY ARRESTS',
 vendor_code = 'LP' => 'OREGON YAMHILL COUNTY ARRESTS',
 vendor_code = 'LQ' => 'PENNSYLVANIA LANCASTER COUNTY ARRESTS',
 vendor_code = 'LR' => 'PENNSYLVANIA YORK COUNTY ARRESTS',
 vendor_code = 'LS' => 'SOUTH CAROLINA CHEROKEE COUNTY ARRESTS',
 vendor_code = 'LT' => 'SOUTH CAROLINA FLORENCE COUNTY ARRESTS',
 vendor_code = 'LU' => 'SOUTH CAROLINA HORRY COUNTY ARRESTS',
 vendor_code = 'LV' => 'SOUTH CAROLINA RICHLAND COUNTY ARRESTS',
 vendor_code = 'LW' => 'SOUTH CAROLINA YORK COUNTY ARRESTS',
 vendor_code = 'LX' => 'TENNESSEE DAVIDSON COUNTY ARRESTS',
 vendor_code = 'LY' => 'TENNESSEE MONTGOMERY COUNTY ARRESTS',
 vendor_code = 'LZ' => 'TENNESSEE SHELBY COUNTY ARRESTS',
 vendor_code = 'MJ' => 'TEXAS ARLINGTON POLICE ARRESTS',
 vendor_code = 'MK' => 'TEXAS BEXAR COUNTY ARRESTS',
 vendor_code = 'ML' => 'TEXAS BRAZORIA COUNTY ARRESTS',
 vendor_code = 'MM' => 'TEXAS CAMERON COUNTY ARRESTS',
 vendor_code = 'MP' => 'TEXAS DALLAS COUNTY ARRESTS',
 vendor_code = 'MQ' => 'TEXAS DENTON COUNTY ARRESTS',
 vendor_code = 'MR' => 'TEXAS ECTOR COUNTY ARRESTS',
 vendor_code = 'MU' => 'TEXAS GREGG COUNTY ARRESTS',
 vendor_code = 'MV' => 'TEXAS HARRIS COUNTY ARRESTS',
 vendor_code = 'MW' => 'TEXAS MIDLAND COUNTY ARRESTS',
 vendor_code = 'MX' => 'TEXAS MONTGOMERY COUNTY ARRESTS',
 vendor_code = 'MY' => 'TEXAS PARKER COUNTY ARRESTS',
 vendor_code = 'MZ' => 'TEXAS POTTER COUNTY ARRESTS',
 vendor_code = 'Z6' => 'TEXAS RANDALL COUNTY ARRESTS',
 vendor_code = 'NI' => 'TEXAS SMITH COUNTY ARRESTS',
 vendor_code = 'NK' => 'TEXAS TOM GREEN COUNTY ARRESTS',
 vendor_code = 'NL' => 'TEXAS WISE COUNTY ARRESTS',
 vendor_code = 'NO' => 'UTAH DAVIS COUNTY ARRESTS',
 vendor_code = 'NP' => 'UTAH IRON COUNTY ARRESTS',
 vendor_code = 'NQ' => 'UTAH SALT LAKE COUNTY ARRESTS',
 vendor_code = 'NR' => 'UTAH SAN PETE COUNTY ARRESTS',
 vendor_code = 'NS' => 'UTAH UTAH COUNTY ARRESTS',
 vendor_code = 'NT' => 'UTAH WASHINGTON COUNTY ARRESTS',
 vendor_code = 'NU' => 'VIRGINIA DANVILLE POLICE ARRESTS',
 vendor_code = 'NW' => 'VIRGINIA FAIRFAX COUNTY ARRESTS',
 vendor_code = 'NX' => 'VIRGINIA WASHINGTON COUNTY ARRESTS',
 vendor_code = 'Z7' => 'WASHINGTON CLARK COUNTY ARRESTS',
 vendor_code = 'NZ' => 'WASHINGTON COWLITZ COUNTY ARRESTS',
 vendor_code = 'QA' => 'WASHINGTON JEFFERSON COUNTY ARRESTS',
 vendor_code = 'QB' => 'WASHINGTON KITSAP COUNTY ARRESTS',
 vendor_code = 'QC' => 'WASHINGTON LEWIS COUNTY ARRESTS',
 vendor_code = 'QD' => 'WASHINGTON PIERCE COUNTY ARRESTS',
 vendor_code = 'QE' => 'WASHINGTON THURSTON COUNTY ARRESTS',
 vendor_code = 'QF' => 'WASHINGTON WHATCOM COUNTY ARRESTS',
 vendor_code = 'QG' => 'WISCONSIN KENOSHA COUNTY ARRESTS',
 vendor_code = 'QH' => 'WEST VIRGINIA REGIONAL ARRESTS',
 
 //Phase 2 - Batches 1 & 2
vendor_code = 'QK' => 'CALIFORNIA_ALAMEDA_COUNTY',
vendor_code = 'QX' => 'CALIFORNIA_BUTTE_COUNTY',
vendor_code = 'QL' => 'CALIFORNIA_MARIN_COUNTY_ALTERNATE_FILE',
vendor_code = 'QI' => 'CALIFORNIA_NEVADA_COUNTY',
vendor_code = 'PZ' => 'CALIFORNIA_GLENN_COUNTY',
vendor_code = 'TS' => 'CALIFORNIA_RIVERSIDE_COUNTY_CITY_OF_INDIO_ALTERNATE_FILE',
vendor_code = 'QJ' => 'CALIFORNIA_SACRAMENTO_COUNTY_ALTERNATE_FILE',
vendor_code = 'TV' => 'CALIFORNIA_SAN_BERNARDINO_COUNTY_ALTERNATE_FILE',
vendor_code = 'TW' => 'CALIFORNIA_SAN_DIEGO_COUNTY_ALTERNATE_FILE',
vendor_code = 'UB' => 'CALIFORNIA_SAN_LUIS_OBISPO_COUNTY',
vendor_code = 'UE' => 'CALIFORNIA_SAN_MATEO_COUNTY_ALTERNATE_FILE',
vendor_code = 'UF' => 'CALIFORNIA_SANTA_BARBARA_COUNTY_ALTERNATE_FILE',
vendor_code = 'UG' => 'CALIFORNIA_SANTA_CLARA_COUNTY_ALTERNATE_FILE',
vendor_code = 'UH' => 'CALIFORNIA_SANTA_CRUZ_COUNTY_ALTERNATE_FILE',
vendor_code = 'UI' => 'CALIFORNIA_SISKIYOU_COUNTY_SUPERIOR_COURT',
vendor_code = 'UJ' => 'CALIFORNIA_SONOMA_COUNTY',
vendor_code = 'UK' => 'CALIFORNIA_TEHAMA_COUNTY',
vendor_code = 'UL' => 'CALIFORNIA_VENTURA_COUNTY_ALTERNATE_FILE',
vendor_code = 'QN' => 'COLORADO_DENVER_COUNTY',
vendor_code = 'QM' => 'FLORIDA_LAKE_COUNTY',
vendor_code = 'UO' => 'FLORIDA_INDIAN_RIVER_COUNTY',
vendor_code = 'VD' => 'MISSISSIPPI_HARRISON_COUNTY',
vendor_code = 'VK' => 'OHIO_AUGLAIZE_COUNTY',
vendor_code = 'VR' => 'OHIO_CHAMPAIGN_COUNTY',
vendor_code = 'QO' => 'OHIO_LAKE_COUNTY',
vendor_code = 'QP' => 'OHIO_LAKE_COUNTY_MENTOR_MUNICIPAL_COURT',
vendor_code = 'QQ' => 'OHIO_LAKE_COUNTY_PAINESVILLE_MUNICIPAL_COURT',
vendor_code = 'QR' => 'OHIO_SANDUSKY_COUNTY',
vendor_code = 'QS' => 'OHIO_MEDINA_COUNTY',
vendor_code = 'QT' => 'OHIO_MEDINA_COUNTY_MUNICIPAL_COURT',
vendor_code = 'QU' => 'OHIO_HAMILTON_COUNTY',
vendor_code = 'QV' => 'OHIO_ADAMS_COMMON_PLEAS_COURT',
vendor_code = 'QW' => 'OHIO_ADAMS_COUNTY_COURT',
vendor_code = 'QY' => 'OHIO_BROWN_COUNTY_BROWN_MUNICIPAL_TRAFFIC_COURT',
vendor_code = 'QZ' => 'OHIO_MAHONING_COUNTY',
vendor_code = 'RY' => 'OHIO_HANCOCK_COUNTY',
vendor_code = 'RJ' => 'OHIO_HARDIN_COUNTY',
vendor_code = 'RK' => 'OHIO_PICKAWAY_COUNTY_COMMON_PLEAS_COURT',
vendor_code = 'RL' => 'OHIO_RICHLAND_COUNTY',
vendor_code = 'RM' => 'OHIO_RICHLAND_COUNTY_MANSFIELD_MUNICIPAL_COURT',
vendor_code = 'RN' => 'OHIO_WAYNE_COUNTY',
vendor_code = 'RO' => 'OHIO_PUTNAM_COUNTY',
vendor_code = 'RP' => 'TENNESSEE_HAMILTON_COUNTY',
vendor_code = 'RQ' => 'TENNESSEE_RUTHERFORD_COUNTY',
vendor_code = 'UC' => 'TENNESSEE_METHAMPHETAMINE_CONVICTIONS_FILE',
vendor_code = 'RR' => 'SOUTH_CAROLINA_GREENVILLE_COUNTY',
vendor_code = 'RS' => 'SOUTH_CAROLINA_GREENVILLE_COUNTY_CURCUIT_COURTS',
vendor_code = 'RT' => 'SOUTH_CAROLINA_GREENVILLE_COUNTY_SUMMARY_COURTS',
vendor_code = 'RU' => 'SOUTH_CAROLINA_YORK_COUNTY',
vendor_code = 'RV' => 'TEXAS_TRAVIS_COUNTY',
vendor_code = 'RW' => 'TEXAS_WILLIAMSON_COUNTY',
vendor_code = 'RX' => 'TEXAS_WALLER_COUNTY',
//-----------------------------------20130716--------------------------------
vendor_code = 'UN' => 'FLORIDA_FLAGLER_COUNTY',
vendor_code = 'UP' => 'FLORIDA_OKALOOSA_COUNTY',
vendor_code = 'UQ' => 'FLORIDA_SEMINOLE_COUNTY',
vendor_code = 'UR' => 'FLORIDA_ST_JOHNS_COUNTY',
vendor_code = 'UX' => 'GEORGIA_CHATHAM_COUNTY',
vendor_code = 'US' => 'ILLINOIS_COUNTY_CIRCUIT_CLERK_OF_COURTS',
vendor_code = 'UU' => 'ILLINOIS_DUPAGE_COUNTY',
vendor_code = 'UV' => 'ILLINOIS_MCLEAN_COUNTY',
vendor_code = 'UW' => 'KANSAS_JOHNSON_COUNTY',
vendor_code = 'UY' => 'MICHIGAN_MACOMB_COUNTY',
vendor_code = 'UZ' => 'MICHIGAN_OAKLAND_COUNTY',
vendor_code = 'VC' => 'MICHIGAN_SAGINAW_COUNTY',
vendor_code = 'VV' => 'MICHIGAN_THIRTEENTH_CIRCUIT_COURT',
vendor_code = 'VF' => 'NEVADA_CLARK_COUNTY_JUSTICE_COURTS',
vendor_code = 'VG' => 'NEW_MEXICO_BERNALILLO_COUNTY',
vendor_code = 'VI' => 'OHIO_ASHLAND_COUNTY',
vendor_code = 'VJ' => 'OHIO_ASHTABULA_COUNTY',
vendor_code = 'VL' => 'OHIO_BELMONT_COUNTY_COURT_EASTERN_DISTRICT',
vendor_code = 'VM' => 'OHIO_BELMONT_COUNTY_COURT_NORTHERN_DISTRICT',
vendor_code = 'VN' => 'OHIO_BELMONT_COUNTY_COURT_WESTERN_DISTRICT',
vendor_code = 'VO' => 'OHIO_BUTLER_COUNTY_HAMILTON_MUNICIPAL_COURT',
vendor_code = 'VP' => 'OHIO_BUTLER_COUNTY_MIDDLETOWN_MUNICIPAL_COURT',
vendor_code = 'VU' => 'OHIO_COSHOCTON_COMMON_PLEAS_COURT',
vendor_code = 'VW' => 'OHIO_COSHOCTON_COUNTY_MUNICIPAL_COURT',
vendor_code = 'VW' => 'OHIO_COSHOCTON_COUNTY_MUNICIPAL_COURT_WEBSITE',
vendor_code = 'VX' => 'OHIO_CRAWFORD_COUNTY',
vendor_code = 'VY' => 'OHIO_CUYAHOGA_COUNTY_BEDFORD_MUNICIPAL_COURT',
vendor_code = 'VZ' => 'OHIO_CUYAHOGA_COUNTY_EAST_CLEVELAND_MUNICIPAL_COURT',
vendor_code = 'WM' => 'OHIO_CUYAHOGA_COUNTY_GARFIELD_HEIGHTS_MUNICIPAL_COURT',
vendor_code = 'WN' => 'OHIO_CUYAHOGA_COUNTY_PARMA_MUNICIPAL_COURT',
vendor_code = 'WO' => 'OHIO_CUYAHOGA_COUNTY_ROCKY_RIVER_MUNICIPAL_COURT',
vendor_code = 'WP' => 'OHIO_CUYAHOGA_COUNTY_SHAKER_HEIGHTS_MUNICIPAL_COURT',
vendor_code = 'WQ' => 'OHIO_ERIE_COUNTY_VERMILION_MUNICIPAL_COURT',
vendor_code = 'WR' => 'OHIO_GEAUGA_COUNTY_CHARDON_MUNICIPAL_COURT',
vendor_code = 'WS' => 'OHIO_JEFFERSON_COUNTY_TORONTO',
vendor_code = 'WT' => 'OHIO_GUERNSEY_COUNTY_CAMBRIDGE_MUNICIPAL_COURT',
vendor_code = 'WU' => 'OHIO_HIGHLAND_COUNTY_HILLSBORO_MUNICIPAL_COURT',
vendor_code = 'WW' => 'OHIO_JACKSON_COUNTY_MUNICIPAL_COURT',
vendor_code = 'WX' => 'OHIO_JEFFERSON_COUNTY_DILLONVALE',
vendor_code = 'WY' => 'OHIO_JEFFERSON_COUNTY_TORONTO',
vendor_code = 'WZ' => 'OHIO_JEFFERSON_COUNTY_WINTERSVILLE',
vendor_code = 'XX' => 'OHIO_KNOX_COUNTY_COMMON_PLEAS_COURT',
vendor_code = 'XY' => 'OHIO_KNOX_COUNTY_MOUNT_VERNON_MUNICIPAL_COURT',
vendor_code = 'XZ' => 'OHIO_LORAIN_COUNTY_AVON_LAKE_MUNICIPAL_COURT',
vendor_code = 'YA' => 'OHIO_LORAIN_COUNTY',
vendor_code = 'YB' => 'OHIO_LORAIN_COUNTY_ELYRIA_MUNICIPAL_COURT',
vendor_code = 'YC' => 'OHIO_LORAIN_COUNTY_MUNICIPAL_COURT',
vendor_code = 'YD' => 'OHIO_LORAIN_COUNTY_OBERLIN_MUNICIPAL_COURT',
vendor_code = 'YE' => 'OHIO_LUCAS_COUNTY_MAUMEE_MUNICIPAL_COURT',
vendor_code = 'YF' => 'OHIO_LUCAS_COUNTY_SYLVANIA_MUNICIPAL_COURT',
vendor_code = 'YF' => 'OHIO_LUCAS_COUNTY_SYLVANIA_MUNICIPAL_COURT_WEBSITE',
vendor_code = 'YH' => 'OHIO_MARION_COUNTY',
vendor_code = 'YK' => 'OHIO_MONTGOMERY_MIAMISBURG_MUNICIPAL_COURT',
vendor_code = 'YL' => 'OHIO_MUSKINGUM_COUNTY_MUNICIPAL_COURT',
vendor_code = 'YM' => 'OHIO_OTTAWA_COUNTY_MUNICIPAL_COURT',
vendor_code = 'YN' => 'OHIO_PERRY_COUNTY_COURT',
vendor_code = 'PY' => 'WISCONSIN_ADMINISTRATOR_OF_THE_COURTS_TRAFFIC',
 
//-----------------------------Batch3-----------------------------------------
vendor_code = 'ZC' => 'SOUTH_CAROLINA_ABBEVILLE_COUNTY_CIRCUIT_COURTS' ,
vendor_code = 'ZD' => 'SOUTH_CAROLINA_ABBEVILLE_COUNTY_SUMMARY_COURTS' ,
vendor_code = 'ZE' => 'SOUTH_CAROLINA_AIKEN_COUNTY_CIRCUIT_COURTS'  	 ,
vendor_code = 'ZF' => 'SOUTH_CAROLINA_AIKEN_COUNTY_SUMMARY_COURTS'  	 ,
vendor_code = 'ZG' => 'SOUTH_CAROLINA_ALLENDALE_COUNTY_CIRCUIT_COURTS' ,
vendor_code = 'ZH' => 'SOUTH_CAROLINA_ALLENDALE_COUNTY_SUMMARY_COURTS' ,
vendor_code = 'ZI' => 'SOUTH_CAROLINA_BAMBERG_COUNTY_CIRCUIT_COURTS'   ,
vendor_code = 'ZJ' => 'SOUTH_CAROLINA_BAMBERG_COUNTY_SUMMARY_COURTS'   ,
vendor_code = 'ZK' => 'SOUTH_CAROLINA_BARNWELL_COUNTY_CIRCUIT_COURTS'  ,
vendor_code = 'ZL' => 'SOUTH_CAROLINA_BARNWELL_COUNTY_SUMMARY_COURTS'  ,
vendor_code = 'ZM' => 'SOUTH_CAROLINA_BERKELEY_COUNTY_CIRCUIT_COURTS'  ,
vendor_code = 'ZN' => 'SOUTH_CAROLINA_BERKELEY_COUNTY_SUMMARY_COURTS'  ,
vendor_code = 'ZO' => 'SOUTH_CAROLINA_CALHOUN_COUNTY_CIRCUIT_COURTS'   ,
vendor_code = 'ZP' => 'SOUTH_CAROLINA_CALHOUN_COUNTY_SUMMARY_COURTS'   ,
vendor_code = 'ZQ' => 'SOUTH_CAROLINA_CHEROKEE_COUNTY_CIRCUIT_COURTS'  ,
vendor_code = 'ZR' => 'SOUTH_CAROLINA_CHEROKEE_COUNTY_SUMMARY_COURTS'  ,
vendor_code = 'ZS' => 'SOUTH_CAROLINA_CHESTER_COUNTY_CIRCUIT_COURTS'   ,
vendor_code = 'ZT' => 'SOUTH_CAROLINA_CHESTER_COUNTY_SUMMARY_COURTS'   ,
vendor_code = 'ZU' => 'SOUTH_CAROLINA_CLARENDON_COUNTY_CIRCUIT_COURTS' ,
vendor_code = 'ZV' => 'SOUTH_CAROLINA_CLARENDON_COUNTY_SUMMARY_COURTS' ,
vendor_code = 'ZW' => 'SOUTH_CAROLINA_COLLETON_COUNTY_CIRCUIT_COURTS'  ,
vendor_code = 'ZX' => 'SOUTH_CAROLINA_COLLETON_COUNTY_SUMMARY_COURTS'  ,
vendor_code = 'ZY' => 'SOUTH_CAROLINA_DARLINGTON_COUNTY_CIRCUIT_COURTS',
vendor_code = 'ZZ' => 'SOUTH_CAROLINA_DARLINGTON_COUNTY_SUMMARY_COURTS',
vendor_code = '3A' => 'SOUTH_CAROLINA_DILLON_COUNTY_CIRCUIT_COURTS'  	 ,
vendor_code = '3B' => 'SOUTH_CAROLINA_DILLON_COUNTY_SUMMARY_COURTS'  	 ,
vendor_code = '6F' => 'SOUTH_CAROLINA_DORCHESTER_COUNTY_CIRCUIT_COURTS',
vendor_code = '6G' => 'SOUTH_CAROLINA_DORCHESTER_COUNTY_SUMMARY_COURTS',
vendor_code = '3P' => 'SOUTH_CAROLINA_EDGEFIELD_COUNTY_CIRCUIT_COURTS' ,
vendor_code = '3S' => 'SOUTH_CAROLINA_EDGEFIELD_COUNTY_SUMMARY_COURTS' ,
vendor_code = '3T' => 'SOUTH_CAROLINA_FAIRFIELD_COUNTY_CIRCUIT_COURTS' ,
vendor_code = '3U' => 'SOUTH_CAROLINA_FAIRFIELD_COUNTY_SUMMARY_COURTS' ,
vendor_code = '3V' => 'SOUTH_CAROLINA_FLORENCE_COUNTY_CIRCUIT_COURTS'  ,
vendor_code = '3W' => 'SOUTH_CAROLINA_GEORGETOWN_COUNTY_CIRCUIT_COURTS',
vendor_code = '3Z' => 'SOUTH_CAROLINA_GEORGETOWN_COUNTY_SUMMARY_COURTS',
vendor_code = '4A' => 'SOUTH_CAROLINA_GREENWOOD_COUNTY_CIRCUIT_COURTS' ,
vendor_code = '4H' => 'SOUTH_CAROLINA_GREENWOOD_COUNTY_SUMMARY_COURTS' ,
vendor_code = '4I' => 'SOUTH_CAROLINA_HAMPTON_COUNTY_CIRCUIT_COURTS'   ,  
vendor_code = '4J' => 'SOUTH_CAROLINA_HAMPTON_COUNTY_SUMMARY_COURTS'   ,  
vendor_code = '4K' => 'SOUTH_CAROLINA_HORRY_COUNTY_CIRCUIT_COURTS'  	 ,    
vendor_code = '4L' => 'SOUTH_CAROLINA_HORRY_COUNTY_SUMMARY_COURTS'  	 ,    
vendor_code = '4M' => 'SOUTH_CAROLINA_KERSHAW_COUNTY_CIRCUIT_COURTS'   ,  
vendor_code = '4N' => 'SOUTH_CAROLINA_KERSHAW_COUNTY_SUMMARY_COURTS'   ,  
vendor_code = '4O' => 'SOUTH_CAROLINA_LANCASTER_COUNTY_CIRCUIT_COURTS' ,
vendor_code = '4P' => 'SOUTH_CAROLINA_LANCASTER_COUNTY_SUMMARY_COURTS' ,
vendor_code = '4Q' => 'SOUTH_CAROLINA_LAUREN_COUNTY_CIRCUIT_COURTS'  	 ,   
vendor_code = '4R' => 'SOUTH_CAROLINA_LAUREN_COUNTY_SUMMARY_COURTS'  	 ,   
vendor_code = '4S' => 'SOUTH_CAROLINA_LEXINGTON_COUNTY_CIRCUIT_COURTS' ,
vendor_code = '4T' => 'SOUTH_CAROLINA_LEXINGTON_COUNTY_SUMMARY_COURTS' ,
vendor_code = '4U' => 'SOUTH_CAROLINA_MARION_COUNTY_CIRCUIT_COURTS'  	 ,   
vendor_code = '4V' => 'SOUTH_CAROLINA_MARION_COUNTY_SUMMARY_COURTS'  	 ,
//-----------------------Batch4------------------------
vendor_code = 'TU'  => 'CALIFORNIA_SACRAMENTO_COUNTY_SUPERIOR_COURT_WEBSITE' ,
vendor_code = '6K'	=> 'OHIO_CLERMONT_TRAFFIC'                               ,
vendor_code = 'YO'  => 'OHIO_PREBLE_COUNTY_COMMON_PLEAS_COURT'               ,
vendor_code = '6J'  => 'OHIO_PREBLE_COUNTY_EATON_MUNICIPAL_COURT'            ,
vendor_code = 'YS' 	=> 'OHIO_SENECA_COUNTY_TIFFIN_MUNICIPAL_COURT'           ,
vendor_code = 'YT'  => 'OHIO_SHELBY_COUNTY_SIDNEY_MUNICIPAL_COURT'           ,
vendor_code = 'YU'  => 'OHIO_TRUMBULL_COUNTY_GIRARD_MUNICIPAL_COURT'         ,
vendor_code = 'YW' 	=> 'OHIO_WASHINGTON_COUNTY_MARIETTA_MUNICIPAL_COURT'     ,
vendor_code = 'YY' 	=> 'OHIO_WOOD_COUNTY'                                    ,
vendor_code = 'YZ'	=> 'OHIO_WOOD_COUNTY_BOWLING_GREEN_MUNICIPAL_COURT'      ,
vendor_code = '5W'	=> 'OKLAHOMA_DISTRICT_COURTS'                            ,
vendor_code = '5W'	=> 'OKLAHOMA_DISTRICT_COURTS_HISTORY_FILE'               ,
vendor_code = '4W'	=> 'SOUTH_CAROLINA_MARLBORO_COUNTY_CIRCUIT_COURTS'       ,
vendor_code = '4X'  => 'SOUTH_CAROLINA_MARLBORO_COUNTY_SUMMARY_COURTS'       ,
vendor_code = '4Y' 	=> 'SOUTH_CAROLINA_MCCORMICK_COUNTY_CIRCUIT_COURTS'      ,
vendor_code = '4Z' 	=> 'SOUTH_CAROLINA_MCCORMICK_COUNTY_SUMMARY_COURTS'      ,
vendor_code = 'YG'	=> 'SOUTH_CAROLINA_NEWBERRY_COUNTY_CIRCUIT_COURTS'       ,
vendor_code = '5A'	=> 'SOUTH_CAROLINA_NEWBERRY_COUNTY_SUMMARY_COURTS'       ,
vendor_code = '5B'  => 'SOUTH_CAROLINA_OCONEE_COUNTY_CIRCUIT_COURTS'         ,
vendor_code = '5C'  => 'SOUTH_CAROLINA_OCONEE_COUNTY_SUMMARY_COURTS'         ,
vendor_code = '5D'  => 'SOUTH_CAROLINA_ORANGEBURG_COUNTY_CIRCUIT_COURTS'     ,
vendor_code = '5E'  => 'SOUTH_CAROLINA_ORANGEBURG_COUNTY_SUMMARY_COURTS'     ,
vendor_code = '5F'  => 'SOUTH_CAROLINA_PICKENS_COUNTY_CIRCUIT_COURTS'        ,
vendor_code = '5G'  => 'SOUTH_CAROLINA_PICKENS_COUNTY_SUMMARY_COURTS'        ,
vendor_code = '5H'	=> 'SOUTH_CAROLINA_RICHLAND_COUNTY_SUMMARY_COURTS'       ,
vendor_code = '5I'	=> 'SOUTH_CAROLINA_SALUDA_COUNTY_CIRCUIT_COURTS'         ,
vendor_code = '5J'  => 'SOUTH_CAROLINA_SALUDA_COUNTY_SUMMARY_COURTS'         ,
vendor_code = '5K'  => 'SOUTH_CAROLINA_SPARTANBURG_COUNTY_CIRCUIT_COURTS'    ,
vendor_code = '5L'	=> 'SOUTH_CAROLINA_SPARTANBURG_COUNTY_SUMMARY_COURTS'    ,
vendor_code = '5M'	=> 'SOUTH_CAROLINA_UNION_COUNTY_CIRCUIT_COURTS'          ,
vendor_code = '5N'  => 'SOUTH_CAROLINA_UNION_COUNTY_SUMMARY_COURTS'          ,
vendor_code = '5O'  => 'SOUTH_CAROLINA_WILLIAMSBURG_COUNTY_CIRCUIT_COURTS'   ,
vendor_code = '5P'  => 'SOUTH_CAROLINA_WILLIAMSBURG_COUNTY_SUMMARY_COURTS'   ,
vendor_code = '5Q'  => 'TENNESSEE_DAVIDSON_COUNTY'                           ,
vendor_code = '5S'  => 'TEXAS_BOWIE_COUNTY'                                  ,
vendor_code = '5X'  => 'TEXAS_FRANKLIN_COUNTY'                               ,
vendor_code = '5Y'  => 'TEXAS_GALVESTON_COUNTY'                              ,
vendor_code = '5Z'	=> 'TEXAS_HOPKINS_COUNTY_COURT'                          ,
vendor_code = '6A'	=> 'TEXAS_HOPKINS_COUNTY_DISTRICT_COURT'                 ,
vendor_code = '6C'  => 'TEXAS_ORANGE_COUNTY_COURT'                           ,
vendor_code = '6E'  => 'TEXAS_SMITH_COUNTY'                                  , 

vendor_code = '6Z'  => 'KENTUCKY_DEPARTMENT_OF_CORRECTIONS_WEBSITE'             ,      
vendor_code = '6X'  => 'MISSISSIPPI_PAROLE_BOARD'                               , 
vendor_code = 'ZB'  => 'OKLAHOMA_DOC_VIOLENT_OFFENDER_REGISTRY'                 ,
vendor_code = '6H'  => 'SOUTH_CAROLINA_DEPARMENT_OF_PROBATION_PAROLE_AND_PARDON',
vendor_code = '6I'  => 'KENTUCKY_MONROE_COUNTY_ARRESTS'                         ,    

vendor_code = '6L' => 'TEXAS_BURNET_COUNTY'                                   ,
vendor_code = '6M' => 'OHIO_BUTLER_FAIRFIELD_MUNICIPAL_COURT'                 ,
vendor_code = '6N' => 'OHIO_GEAUGA_COUNTY_CHARDON_MUNICIPAL_COURT_WEBSITE'    ,
vendor_code = '6P' => 'OHIO_GALLIA_COUNTY'                                    ,
vendor_code = '6Q' => 'TEXAS_CAMERON_COUNTY'                                  ,
vendor_code = '6R' => 'TEXAS_CHAMBERS_COUNTY'                                 ,  
vendor_code = '6S' => 'TEXAS_EL_PASO_COUNTY_COURT'                            ,
                                                                              
vendor_code = '6O' => 'OHIO_CLARK_MUNICIPAL_COURT'                            ,                                                      
vendor_code = '6T' => 'OHIO_CLARK_COUNTY_COMMON_PLEAS_COURT'                  ,
vendor_code = '6Y' => 'OHIO_CUYAHOGA_COMMON_PLEAS_COURT'                      ,
vendor_code = '6W' => 'MICHIGAN_DEPARTMENT_OF_CORRECTIONS_WEBSITE'            ,                                                    

//---------------------------------------------------------------------20160929
vendor_code = '8J' => 'OHIO_MADISON_COMMON_PLEAS_COURT'                       ,
vendor_code = '8K' => 'OHIO_SANDUSKY_COUNTY_COMMON_PLEAS_COURT'               ,
vendor_code = '8L' => 'TEXAS_BEXAR_COUNTY_DISTRICT_COURTS'                    ,
                                                                             
vendor_code = '8M' => 'OHIO_FAYETTE_COUNTY_COMMON_PLEAS_COURT'                , 
vendor_code = '8N' => 'OHIO_HURON_COUNTY_NORWALK_MUNICIPAL_COURT'             ,
vendor_code = '8O' => 'OHIO_LUCAS_COUNTY_COMMON_PLEAS_COURT'                  ,
vendor_code = '8P' => 'OHIO_CUYAHOGA_COUNTY_CLEVELAND_MUNICIPAL_COURT'        ,
vendor_code = '8Q' => 'OHIO_CUYAHOGA_COUNTY_CLEVELANDHEIGHTS_MUNICIPAL_COURT' ,
vendor_code = '8R' => 'TENNESSEE_HAMILTON_CRIMINAL_COURT'                     ,
vendor_code = '8S' => 'TEXAS_COLLIN_COUNTY_WEBSITE'                           ,

vendor_code = '8T' => 'FLORIDA_CITRUS_COUNTY'                                 ,
vendor_code = '8U' => 'OHIO_STARK_COUNTY_ALLIANCE_MUNICIPAL_COURT'            ,
vendor_code = '8V' => 'OHIO_COLUMBIANA_COUNTY_EASTLIVERPOOL_MUNICIPAL_COURT'  ,
vendor_code = '8W' => 'OHIO_CUYAHOGA_COUNTY_LAKEWOOD_MUNICIPAL_COURT'         ,
vendor_code = '8X' => 'OHIO_JEFFERSON_COUNTY_STEUBENVILLE'                    ,
vendor_code = '8Y' => 'OHIO_MONTGOMERY_COUNTY_COMMON_PLEAS_COURT'             ,
vendor_code = '8Z' => 'OHIO_PAULDING_COUNTY'                                  ,
vendor_code = '9A' => 'OHIO_TRUMBULL_COUNTY_WARREN_MUNICIPAL_COURT'           ,
vendor_code = '9B' => 'OHIO_CUYAHOGA_COUNTY_LYNDHURST_MUNICIPAL_COURT'        ,
vendor_code = '9C' => 'OHIO_GEAUGA_COUNTY_COMMON_PLEAS_COURT'                 ,
vendor_code = '9D' => 'OHIO_MERCER_COUNTY_COMMON_PLEAS_COURT'                 ,
// vendor_code = '9E' => 'OHIO_GREENE_COUNTY_FAIRBORN_MUNICIPAL_COURT'           ,
vendor_code = '9F' => 'OHIO_JEFFERSON_COMMON_PLEAS_COURT'                     ,
vendor_code = '9G' => 'OHIO_LAWRENCE_COUNTY_COMMON_PLEAS_COURT'               ,
vendor_code = '9H' => 'OHIO_LICKING_COUNTY_MUNICIPAL_COURT'                   ,
// vendor_code = '9I' => 'OHIO_MARION_COUNTY_MUNICIPAL_COURT'                    ,
vendor_code = '9J' => 'OHIO_MEDINA_COUNTY_WADSWORTH_MUNICIPAL_COURT'          ,
vendor_code = '9K' => 'OHIO_MEIGS_COUNTY_MUNICIPAL_COURT'                     ,
vendor_code = '9L' => 'FLORIDA_ST_LUCIE_COUNTY_CIRCUIT_COURT'                 ,
vendor_code = '9M' => 'OHIO_ASHTABULA_COMMON_PLEAS_COURT'                     ,
vendor_code = '9N' => 'OHIO_DARKE_COUNTY_MUNICIPAL_COURT'                     ,
vendor_code = '9O' => 'OHIO_FRANKLIN_COUNTY_COMMON_PLEAS'                     ,
vendor_code = '9P' => 'OHIO_SCIOTO_COUNTY_PORTSMOUTH_MUNICIPAL_COURT'         ,
vendor_code = '9Q' => 'OHIO_SENECA_COUNTY_COMMON_PLEAS_COURT'                 ,	
vendor_code = '9R' => 'OHIO_STARK_COUNTY_MASSILLON_MUNICIPAL_COURT'           ,
vendor_code = '9S' => 'OHIO_STARK_COUNTY_CANTON_MUNICIPAL_COURT'              , 
vendor_code = '9T' => 'OHIO_OTTAWA_COUNTY_COMMON_PLEAS_COURT'                 ,
vendor_code = '9U' => 'OHIO_UNION_COUNTY_COMMON_PLEAS_COURT'                  ,
vendor_code = '9V' => 'OHIO_WYANDOT_COUNTY_COMMON_PLEAS_COURT'                ,
vendor_code = '9W' => 'TEXAS_KAUFMAN_COUNTY'                                  ,
vendor_code = '9X' => 'TEXAS_RANDALL_COUNTY'                                  ,

vendor_code = '9Y'  => 'CALIFORNIA_EL_DORADO_COUNTY_SUPERIOR_COURT'           ,
vendor_code = '9Z'  => 'FLORIDA_MANATEE_COUNTY'                               ,
vendor_code = '10A' => 'OHIO_VINTON_COUNTY_COMMON_PLEAS_COURT'                ,
vendor_code = '10B' => 'TEXAS_AUSTIN_COUNTY_MUNICIPAL_COURT'                  ,
vendor_code = '10C' => 'TEXAS_DALLAS_JUSTICE_OF_THE_PEACE_TRAFFIC'            ,
vendor_code = '10D' => 'UTAH_WHITE_COLLAR_CRIME_OFFENDER_REGISTRY'            ,
vendor_code = '10E' => 'MONTANA_VIOLENT_OFFENDER_REGISTRY        '            ,
vendor_code = '10F' => 'NORTH_DAKOTA_OFFENDERS_AGAINST_CHILDREN  '            ,
vendor_code = '10G' => 'GEORGIA_PAROLE_RELEASED_INMATES'                      ,
 //************************CRIMWISE*******************************/
 vendor_code = 'W0001' => 'ILLINOIS_ADMINISTRATOR_OF_THE_COURTS                        ',
 vendor_code = 'W0002' => 'MINNESOTA_ADMINISTRATOR_OF_THE_COURTS                       ',
 vendor_code = 'W0003' => 'VIRGINIA_ADMINISTRATOR_OF_THE_COURTS_CIRCUIT_COURTS_WEBSITE ',
 vendor_code = 'W0004' => 'VIRGINIA_ADMINISTRATOR_OF_THE_COURTS_DISTRICT_COURTS_WEBSITE',          
					            
 //COUNTY Crimwise                                                               
 vendor_code = 'W0005' => 'CALIFORNIA_AMADOR_COUNTY                            ',
 vendor_code = 'W0006' => 'CALIFORNIA_COLUSA_COUNTY                            ',
 vendor_code = 'W0007' => 'CALIFORNIA_EL_DORADO_COUNTY                         ',
 vendor_code = 'W0008' => 'CALIFORNIA_HUMBOLDT_COUNTY                          ',
 vendor_code = 'W0009' => 'CALIFORNIA_IMPERIAL_COUNTY                          ',
 vendor_code = 'W0010' => 'CALIFORNIA_KERN_COUNTY                              ',
 vendor_code = 'W0011' => 'CALIFORNIA_LAKE_COUNTY                              ',
 vendor_code = 'W0012' => 'CALIFORNIA_LAKE_COUNTY_SUPERIOR_COURT               ',
 vendor_code = 'W0013' => 'CALIFORNIA_LASSEN_COUNTY                            ',
 vendor_code = 'W0014' => 'CALIFORNIA_MADERA_COUNTY                            ',
 vendor_code = 'W0015' => 'CALIFORNIA_MARIN_COUNTY_WEBSITE                     ',
 vendor_code = 'W0016' => 'CALIFORNIA_MENDOCINO_COUNTY                         ',
 vendor_code = 'W0017' => 'CALIFORNIA_MONTEREY_COUNTY                          ',
 vendor_code = 'W0018' => 'CALIFORNIA_NAPA_COUNTY                              ',
 vendor_code = 'W0019' => 'CALIFORNIA_PLACER_COUNTY                            ',
 vendor_code = 'W0020' => 'CALIFORNIA_SAN_BENITO_COUNTY                        ',
 vendor_code = 'W0021' => 'CALIFORNIA_SAN_JOAQUIN_COUNTY                       ',
 vendor_code = 'W0022' => 'CALIFORNIA_SUTTER_COUNTY                            ',
 vendor_code = 'W0023' => 'CALIFORNIA_TULARE_COUNTY_WEBSITE                    ',
 vendor_code = 'W0024' => 'CALIFORNIA_TUOLUMNE_COUNTY                          ',
 vendor_code = 'W0025' => 'CALIFORNIA_YOLO_COUNTY                              ',
 vendor_code = 'W0026' => 'INDIANA_LAKE_COUNTY                                 ',            
 vendor_code = 'W0027' => 'NORTH_CAROLINA_MECKLENBURG_COUNTY                   ',            
 vendor_code = 'W0028' => 'OHIO_ERIE_COUNTY_HURON_MUNICIPAL_COURT              ',            
 vendor_code = 'W0029' => 'OHIO_FAIRFIELD_COUNTY_COMMON_PLEAS_COURT            ',            
 vendor_code = 'W0030' => 'OHIO_GUERNSEY_COUNTY_COMMON_PLEAS_COURT             ',            
 vendor_code = 'W0031' => 'OHIO_HARRISON_COUNTY_MUNICIPAL_COURT                ',            
 vendor_code = 'W0032' => 'OHIO_LOGAN_COUNTY_COMMON_PLEAS_COURT                ',            
 vendor_code = 'W0033' => 'OHIO_LUCAS_COUNTY                                   ',
 vendor_code = 'W0034' => 'OHIO_MARION_COUNTY_MUNICIPAL_COURT                  ',
 vendor_code = 'W0035' => 'OHIO_MERCER_COUNTY_CELINA_MUNICIPAL_COURT           ',
 vendor_code = 'W0036' => 'OHIO_SENECA_COUNTY_FOSTORIA_MUNICIPAL_COURT         ',   
 vendor_code = 'W0037' => 'OHIO_WOOD_COUNTY_PERRYSBURG_MUNICIPAL_COURT         ',
 vendor_code = 'W0038' => 'TEXAS_HOCKLEY_COUNTY                                ',
 vendor_code = 'W0039' => 'TEXAS_KAUFMAN_COUNTY_DISTRICT_COURT                 ',
 vendor_code = 'W0040' => 'FLORIDA_POLK_COUNTY_TRAFFIC                         ',
 vendor_code = 'W0041' => 'FLORIDA_HIGHLANDS_COUNTY_TRAFFIC                    ',
 //Arrest Crimwise    
 vendor_code = 'W0042' => 'CALIFORNIA_YUBA_COUNTY_BOOKINGS                     ',
 vendor_code = 'W0043' => 'CALIFORNIA_GLENN_COUNTY_BOOKINGS                    ',
 vendor_code = 'W0044' => 'CALIFORNIA_CALAVERAS_COUNTY_BOOKINGS                ',
 vendor_code = 'W0045' => 'CALIFORNIA_NEVADA_COUNTY_BOOKINGS                   ',
 vendor_code = 'W0046' => 'CALIFORNIA_SOLANO_COUNTY_JAIL                       ',
 vendor_code = 'W0047' => 'FLORIDA_MANATEE_COUNTY_SHERIFFS_OFFICE              ',
 vendor_code = 'W0048' => 'NORTH_CAROLINA_CHATHAM_COUNTY_SHERIFF               ',
 vendor_code = 'W0049' => 'FLORIDA_PASCO_SHERIFFS_OFFICE                       ',
 vendor_code = 'W0050' => 'FLORIDA_MARION_COUNTY_SHERIFFS_OFFICE               ',
 vendor_code = 'W0051' => 'COLORADO_BOULDER_COUNTY_SHERIFFS_OFFICE             ',
 vendor_code = 'W0052' => 'TENNESSEE_KNOX_COUNTY_ARRESTS                       ',
 vendor_code = 'W0053' => 'TEXAS_BROWN_COUNTY_ARRESTS                          ',
 vendor_code = 'W0054' => 'CALIFORNIA_GLENDALE_POLICE_DEPARTMENT               ',
 vendor_code = 'W0055' => 'IOWA_WATERLOO_POLICE_DEPARTMENT                     ',
 vendor_code = 'W0056' => 'NEW_HAMPSHIRE_NASHUA_POLICE_DEPARTMENT              ',
 vendor_code = 'W0057' => 'NORTH_CAROLINA_MOORE_COUNTY_DETENTION_CENTER        ',
 vendor_code = 'W0058' => 'TENNESSEE_ROANE_COUNTY_ARRESTS                      ',
 vendor_code = 'W0059' => 'FLORIDA_OKEECHOBEE_COUNTY_SHERIFFS_OFFICE           ',
 vendor_code = 'W0060' => 'NORTH_CAROLINA_CHEROKEE_COUNTY_SHERIFF              ',
 vendor_code = 'W0061' => 'NORTH_CAROLINA_PENDER_COUNTY_CURRENT_INMATES_LIST   ',
 vendor_code = 'W0062' => 'NORTH_CAROLINA_ANSON_COUNTY_SHERIFF                 ',
 vendor_code = 'W0063' => 'LOUISIANA_SHREVEPORT_POLICE_DEPARTMENT              ',
 vendor_code = 'W0064' => 'FLORIDA_HENDRY_COUNTY_SHERIFFS_OFFICE               ',
 vendor_code = 'W0065' => 'FLORIDA_OKALOOSA_COUNTY_SHERIFFS_OFFICE             ',
 vendor_code = 'W0066' => 'CALIFORNIA_NEVADA_COUNTY_SHERIFFS_OFFICE            ',
 vendor_code = 'W0067' => 'IOWA_IOWA_CITY_POLICE_DEPARTMENT                    ',
 vendor_code = 'W0068' => 'FLORIDA_GLADES_COUNTY_SHERIFFS_OFFICE               ',
 vendor_code = 'W0069' => 'TEXAS_KAUFMAN_COUNTY_SHERIFFS_DEPARTMENT            ',
 vendor_code = 'W0070' => 'NORTH_CAROLINA_TRANSYLVANIA_COUNTY_DETENTION_CENTER ',
 vendor_code = 'W0071' => 'CONNECTICUT_HARTFORD_POLICE_DEPARTMENT              ',
 vendor_code = 'W0072' => 'MASSACHUSETTS_SPRINGFIELD_POLICE                    ',
 vendor_code = 'W0073' => 'OREGON_BENTON_COUNTY_SHERIFF                        ',
 vendor_code = 'W0074' => 'MASSACHUSETTS_BROCKTON                              ',
 vendor_code = 'W0075' => 'IOWA_BURLINGTON_POLICE_DEPARTMENT                   ',
 vendor_code = 'W0076' => 'IOWA_SIOUX_COUNTY_SHERIFFS_OFFICE                   ',
 vendor_code = 'W0077' => 'TENNESSEE_HAMILTON_COUNTY_ARRESTS                   ', 
 vendor_code = 'W0078' => 'MINNESOTA_CARVER_COUNTY_JAIL                        ',   
 vendor_code = 'W0079' => 'FLORIDA_COLUMBIA_COUNTY_SHERIFFS_OFFICE             ',
 vendor_code = 'W0080' => 'FLORIDA_FLAGLER_COUNTY_SHERIFFS_OFFICE              ',
 vendor_code = 'W0081' => 'NORTH_CAROLINA_HARNETT_COUNTY_SHERIFF               ',
 vendor_code = 'W0082' => 'FLORIDA_JACKSON_COUNTY_SHERIFFS_OFFICE              ',
 vendor_code = 'W0083' => 'MASSACHUSETTS_TAUNTON_POLICE_DEPARTMENT             ',
 vendor_code = 'W0084' => 'NORTH_CAROLINA_GASTON_COUNTY_SHERIFFS_OFFICE        ',
 vendor_code = 'W0085' => 'TENNESSEE_WASHINGTON_COUNTY_SHERIFFS_OFFICE         ',
 vendor_code = 'W0086' => 'TENNESSEE_STEWART_COUNTY_ARRESTS                    ',
 vendor_code = 'W0087' => 'LOUISIANA_OPELOUSAS_POLICE                          ',
 vendor_code = 'W0088' => 'CALIFORNIA_SANTA_CLARA_POLICE_DEPARTMENT            ',
 vendor_code = 'W0089' => 'MASSACHUSETTS_HOLYOKE_POLICE_DEPARTMENT             ',
 vendor_code = 'W0090' => 'NORTH_CAROLINA_CONCORD_POLICE_DEPARTMENT            ',
 vendor_code = 'W0091' => 'CALIFORNIA_GLENN_COUNTY_ARRESTS                     ',
 vendor_code = 'W0092' => 'LOUISIANA_ST_LANDRY_PARISH_SHERIFF                  ',
 vendor_code = 'W0093' => 'NORTH_CAROLINA_WAKE_FOREST_POLICE_DEPARTMENT        ',
 vendor_code = 'W0094' => 'NORTH_CAROLINA_PITT_COUNTY_SHERIFFS_OFFICE          ',
 vendor_code = 'W0095' => 'FLORIDA_BRADFORD_COUNTY_SHERIFFS_OFFICE             ',
 vendor_code = 'W0096' => 'MASSACHUSETTS_WEYMOUTH_POLICE_DEPARTMENT            ',
 vendor_code = 'W0097' => 'NEW_HAMPSHIRE_KEENE_POLICE_DEPARTMENT               ',
 vendor_code = 'W0098' => 'MASSACHUSETTS_CAMBRIDGE                             ', 
 vendor_code = 'W0099' => 'MAINE_WELLS_POLICE_DEPARTMENT                       ', 
 vendor_code = 'W0100' => 'MASSACHUSETTS_CARVER_POLICE_DEPARTMENT              ',
  //Batch2.2
 vendor_code = 'W0101' => 'ALABAMA_BALDWIN_COUNTY_CORRECTIONS_CENTER       ',
 vendor_code = 'W0102' => 'CALIFORNIA_KINGS_COUNTY_BOOKINGS                ',
 vendor_code = 'W0103' => 'CALIFORNIA_LAKE_COUNTY_BOOKINGS                 ',
 vendor_code = 'W0104' => 'CALIFORNIA_MARIPOSA_COUNTY_BOOKINGS             ',
 vendor_code = 'W0105' => 'CALIFORNIA_ORANGE_COUNTY_SHERIFF                ',
 vendor_code = 'W0106' => 'CALIFORNIA_SONOMA_COUNTY_BOOKINGS               ',
 vendor_code = 'W0107' => 'CALIFORNIA_SUTTER_COUNTY_BOOKINGS               ',
 vendor_code = 'W0108' => 'CALIFORNIA_YOLO_COUNTY_BOOKINGS                 ',
 vendor_code = 'W0109' => 'MAINE_BIDDEFORD_POLICE_DEPARTMENT               ',
 vendor_code = 'W0110' => 'MASSACHUSETTS_AMHERST_POLICE                    ',
 vendor_code = 'W0111' => 'MASSACHUSETTS_BREWSTER_POLICE                   ',
 vendor_code = 'W0112' => 'MAINE_SCARBOROUGH_POLICE_DEPARTMENT             ',
 vendor_code = 'W0113' => 'CALIFORNIA_HUMBOLDT_COUNTY_BOOKINGS             ',
 vendor_code = 'W0114' => 'CALIFORNIA_IRVINE_POLICE_DEPARTMENT             ',
 vendor_code = 'W0115' => 'CALIFORNIA_NAPA_COUNTY_BOOKINGS                 ',
 vendor_code = 'W0116' => 'CALIFORNIA_SAN_JOAQUIN_COUNTY_BOOKINGS          ',
 vendor_code = 'W0117' => 'CALIFORNIA_SOLANO_COUNTY_BOOKINGS               ',
 vendor_code = 'W0118' => 'COLORADO_GARFIELD_COUNTY_SHERIFF                ',
 vendor_code = 'W0119' => 'FLORIDA_BAKER_COUNTY_SHERIFFS_OFFICE            ',
 vendor_code = 'W0120' => 'FLORIDA_BAY_COUNTY_JAIL                         ',
 vendor_code = 'W0121' => 'FLORIDA_WALTON_COUNTY_DOC                       ',
 vendor_code = 'W0122' => 'IOWA_CEDAR_FALLS_POLICE_DEPARTMENT              ',
 vendor_code = 'W0123' => 'IOWA_DYERSVILLE_POLICE_DEPARTMENT               ',
 vendor_code = 'W0124' => 'KANSAS_JOHNSON_COUNTY_SHERIFFS_OFFICE           ',
 vendor_code = 'W0125' => 'LOUISIANA_JEFFERSON_PARISH_SHERIFF              ',
 vendor_code = 'W0126' => 'LOUISIANA_MANDEVILLE_POLICE                     ',
 vendor_code = 'W0127' => 'LOUISIANA_ST_TAMMANY_PARISH_SHERIFF             ',
 vendor_code = 'W0128' => 'MAINE_CUMBERLAND_COUNTY_SHERIFFS_OFFICE         ',
 vendor_code = 'W0129' => 'MAINE_GORHAM_POLICE_DEPARTMENT                  ',
 vendor_code = 'W0130' => 'MARYLAND_FREDERICK_COUNTY_SHERIFF               ',
 vendor_code = 'W0131' => 'MASSACHUSETTS_CHICOPEE_POLICE                   ',
 vendor_code = 'W0132' => 'MASSACHUSETTS_DUXBURY                           ',
 vendor_code = 'W0133' => 'MASSACHUSETTS_EAST_LONGMEADOW                   ',
 vendor_code = 'W0134' => 'MASSACHUSETTS_EVERETT                           ',
 vendor_code = 'W0135' => 'MASSACHUSETTS_FRANKLIN_POLICE                   ',
 vendor_code = 'W0136' => 'MASSACHUSETTS_HALIFAX_POLICE_DEPARTMENT         ',
 vendor_code = 'W0137' => 'MASSACHUSETTS_HAMPDEN_POLICE_DEPARTMENT         ',
 vendor_code = 'W0138' => 'MASSACHUSETTS_MARION_POLICE_DEPARTMENT          ',
 vendor_code = 'W0139' => 'MASSACHUSETTS_MELROSE_POLICE_DEPARTMENT         ',
 vendor_code = 'W0140' => 'MASSACHUSETTS_NANTUCKET_POLICE_DEPARTMENT       ',
 vendor_code = 'W0141' => 'MASSACHUSETTS_ROCHESTER                         ',
 vendor_code = 'W0142' => 'MASSACHUSETTS_SALEM_POLICE                      ',
 vendor_code = 'W0143' => 'MASSACHUSETTS_SWANSEA_POLICE_DEPARTMENT         ',
 vendor_code = 'W0144' => 'MASSACHUSETTS_TOWN_OF_SHREWSBURY                ',
 vendor_code = 'W0145' => 'NEW_HAMPSHIRE_HANOVER_POLICE_DEPARTMENT         ',
 vendor_code = 'W0146' => 'NEW_HAMPSHIRE_MANCHESTER_POLICE_DEPARTMENT      ',
 vendor_code = 'W0147' => 'TENNESSEE_HARDEMAN_COUNTY_ARRESTS               ',
 vendor_code = 'W0148' => 'CALIFORNIA_TULARE_COUNTY                        ',
 vendor_code = 'W0149' => 'OHIO_GREENE_COUNTY_FAIRBORN_MUNICIPAL_COURT     ',
 vendor_code = 'W0150' => 'OHIO_WARREN_COUNTY_LEBANON_MUNICIPAL_COURT      ',   
 
 vendor_code = 'W0151' =>'ARIZONA_MARICOPA_WEBSITE                         ',//??
 vendor_code = 'W0152' =>'ARIZONA_PHOENIX                                  ',
 vendor_code = 'W0153' =>'OHIO_ERIE_COUNTY_SANDUSKY_MUNICIPAL_COURT        ',
 vendor_code = 'W0154' =>'TEXAS_CHAMBERS_COUNTY_DISTRICT_COURT             ',
 vendor_code = 'W0155' =>'CALIFORNIA_SAN_LUIS_OBISPO_COUNTY_WEBSITE        ',
 vendor_code = 'W0156' =>'CALIFORNIA_SISKIYOU_COUNTY                       ',
 vendor_code = 'W0157' =>'CALIFORNIA_VENTURA_COUNTY_WEBSITE                ',
 // vendor_code = 'W0158' =>'OHIO_LAKE_COUNTY_PAINSVILLE_MUNICIPAL_COURT      ',
 vendor_code = 'W0159' =>'OHIO_TUSCARAWAS_COUNTY_MUNICIPAL_COURT           ',
 vendor_code = 'W0160' =>'TEXAS_JOHNSON_COUNTY_DISTRICT_COURT              ',
 //arrest             
 vendor_code = 'W0161' =>'ALABAMA_JEFFERSON_COUNTY_SHERIFFS_OFFICE         ',
 vendor_code = 'W0162' =>'ARIZONA_MARICOPA_SHERIFFS_OFFICE                 ',
 vendor_code = 'W0163' =>'LOUISIANA_SHREVEPORT_ARRESTS                     ',
 vendor_code = 'W0164' =>'CONNECTICUT_HARTFORD_COUNTY_ARRESTS              ',  
 vendor_code = 'W0165' =>'MASSACHUSETTS_SPRINGFIELD_ARRESTS                ',
 vendor_code = 'W0166' =>'MASSACHUSETTS_LYNN_ARRESTS                       ',//??
 vendor_code = 'W0167' =>'MASSACHUSETTS_NEW_BEDFORD_ARRESTS                ',
 vendor_code = 'W0168' =>'MASSACHUSETTS_QUINCY_ARRESTS                     ',
 vendor_code = 'W0169' =>'MASSACHUSETTS_HOLYOKE_ARRESTS                    ',
 vendor_code = 'W0170' =>'MASSACHUSETTS_BARNSTABLE_COUNTY_ARRESTS          ',
 vendor_code = 'W0171' =>'CALIFORNIA_SAN_BERNARDINO_POLICE_DEPARTMENT      ',
 vendor_code = 'W0172' =>'COLORADO_WELD_COUNTY_SHERIFF                     ',
 vendor_code = 'W0173' =>'FLORIDA_BREVARD_COUNTY_SHERIFFS_OFFICE           ',
 vendor_code = 'W0174' =>'FLORIDA_CHARLOTTE_COUNTY_SHERIFF                 ',
 vendor_code = 'W0175' =>'FLORIDA_HILLSBOROUGH_COUNTY_SHERIFFS_OFFICE      ',
 vendor_code = 'W0176' =>'FLORIDA_INDIAN_RIVER_COUNTY_SHERIFFS_OFFICE      ',
 vendor_code = 'W0177' =>'FLORIDA_LAKE_COUNTY_SHERIFFS_OFFICE              ',
 vendor_code = 'W0178' =>'FLORIDA_MONROE_COUNTY_SHERIFFS_OFFICE            ',
 vendor_code = 'W0179' =>'FLORIDA_PALM_BEACH_COUNTY_SHERIFFS_OFFICE        ',
 vendor_code = 'W0180' =>'FLORIDA_PUTNAM_COUNTY_SHERIFFS_OFFICE            ',
 vendor_code = 'W0181' =>'FLORIDA_VOLUSIA_COUNTY_CORRECTIONS               ',
 vendor_code = 'W0182' =>'GEORGIA_CHATHAM_COUNTY_SHERIFFS_OFFICE           ',
 vendor_code = 'W0183' =>'GEORGIA_GWINNETT_COUNTY_DETENTION_CENTER         ',
 vendor_code = 'W0184' =>'MASSACHUSETTS_WALTHAM_ARRESTS                    ',
 vendor_code = 'W0185' =>'MICHIGAN_KENT_COUNTY_SHERIFFS_DEPARTMENT         ',
 vendor_code = 'W0186' =>'NEW_MEXICO_BERNALILLO_MDC                        ',
 vendor_code = 'W0187' =>'NEW_YORK_FULTON_POLICE_DEPARTMENT                ',
 vendor_code = 'W0188' =>'NORTH_CAROLINA_GUILFORD_COUNTY_SHERIFFS_OFFICE   ',
 vendor_code = 'W0189' =>'NORTH_CAROLINA_MECKLENBURG_COUNTY_SHERIFF        ',
 vendor_code = 'W0190' =>'OREGON_WASHINGTON_COUNTY_SHERIFF                 ',
 vendor_code = 'W0191' =>'SOUTH_CAROLINA_YORK_COUNTY_SHERIFF               ',
 vendor_code = 'W0192' =>'TENNESSEE_SHELBY_COUNTY_SHERIFFS_OFFICE          ',
 vendor_code = 'W0193' =>'TEXAS_POTTER_COUNTY_SHERIFFS_OFFICE              ',
 vendor_code = 'W0194' =>'UTAH_IRON_COUNTY_SHERIFFS_OFFICE                 ',
 
 vendor_code = 'W0195' =>'VIRGINIA_ARLINGTON_COUNTY_ARRESTS                ' ,                                   
 vendor_code = 'W0196' =>'NORTH_CAROLINA_ROWAN_COUNTY_SHERIFFS_OFFICE      ' , 
 vendor_code = 'W0197' =>'MASSACHUSETTS_ATTLEBORO_ARRESTS                  ' , 
 vendor_code = 'W0198' =>'MASSACHUSETTS_SALEM_ARRESTS                      ' , 
 vendor_code = 'W0199' =>'MASSACHUSETTS_PLYMOUTH_COUNTY_ARRESTS            ' , 
 vendor_code = 'W0200' =>'MASSACHUSETTS_EVERETT_ARRESTS                    ' , 
 vendor_code = 'W0201' =>'FLORIDA_ALACHUA_COUNTY_SHERIFFS_OFFICE           ' , 
 vendor_code = 'W0202' =>'MASSACHUSETTS_PEABODY_ARRESTS                    ' , 
 vendor_code = 'W0203' =>'MASSACHUSETTS_FALMOUTH_ARRESTS                   ' , 
 vendor_code = 'W0204' =>'MASSACHUSETTS_CAMBRIDGE_POLICE_DEPARTMENT        ' , 
 vendor_code = 'W0205' =>'MASSACHUSETTS_FRAMINGHAM_ARRESTS                 ' , 
 vendor_code = 'W0206' =>'CALIFORNIA_ANAHEIM_ARRESTS                       ' , 
 vendor_code = 'W0207' =>'MASSACHUSETTS_BROOKLINE_ARRESTS                  ' , 
 vendor_code = 'W0208' =>'MASSACHUSETTS_NATICK_ARRESTS                     ' , 
 vendor_code = 'W0209' =>'FLORIDA_COLLIER_COUNTY_SHERIFFS_OFFICE           ' , 
 vendor_code = 'W0210' =>'MASSACHUSETTS_WEYMOUTH_ARRESTS                   ' , 
 vendor_code = 'W0211' =>'MASSACHUSETTS_BROCKTON_POLICE_DEPARTMENT         ' , 
 vendor_code = 'W0212' =>'MASSACHUSETTS_WAREHAM_ARRESTS                    ' , 
 vendor_code = 'W0213' =>'MASSACHUSETTS_GLOUCESTER_ARRESTS                 ' , 
 vendor_code = 'W0214' =>'FLORIDA_SARASOTA_COUNTY_SHERIFFS_OFFICE          ' , 
 vendor_code = 'W0215' =>'NORTH_CAROLINA_RUTHERFORD_COUNTY_DETENTION_CENTER' , 
 vendor_code = 'W0216' =>'MASSACHUSETTS_SAUGUS_ARRESTS                     ' , 
 vendor_code = 'W0217' =>'MASSACHUSETTS_TAUNTON_ARRESTS                    ' , 
 vendor_code = 'W0218' =>'MASSACHUSETTS_WHITMAN_ARRESTS                    ' , 
 vendor_code = 'W0219' =>'MASSACHUSETTS_FRANKLIN_ARRESTS                   ' , 
 vendor_code = 'W0220' =>'MASSACHUSETTS_ABINGTON_ARRESTS                   ' , 
 vendor_code = 'W0221' =>'MINNESOTA_BELTRAMI_COUNTY_SHERIFF                ' , 
 vendor_code = 'W0222' =>'MASSACHUSETTS_TOWN_OF_BILLERICA_POLICE_DEPARTMENT' , 
 vendor_code = 'W0223' =>'MASSACHUSETTS_SWANSEA_ARRESTS                    ' , 
 vendor_code = 'W0224' =>'MASSACHUSETTS_HANOVER_ARRESTS                    ' , 
 vendor_code = 'W0225' =>'NORTH_CAROLINA_GOLDSBORO_ARRESTS                 ' , 
 vendor_code = 'W0226' =>'MASSACHUSETTS_HINGHAM_ARRESTS                    ' , 
 vendor_code = 'W0227' =>'MASSACHUSETTS_HARWICH_ARRESTS                    ' , 
 vendor_code = 'W0228' =>'MASSACHUSETTS_SANDWICH_ARRESTS                   ' , 
 vendor_code = 'W0229' =>'FLORIDA_LEVY_COUNTY_SHERIFFS_OFFICE              ' , 
 vendor_code = 'W0230' =>'MASSACHUSETTS_HULL_ARRESTS                       ' , 
 vendor_code = 'W0231' =>'MASSACHUSETTS_PEMBROKE_ARRESTS                   ' , 
 vendor_code = 'W0232' =>'MASSACHUSETTS_WEBSTER_ARRESTS                    ' , 
 vendor_code = 'W0233' =>'MASSACHUSETTS_EAST_BRIDGEWATER_ARRESTS           ' , 
 vendor_code = 'W0234' =>'MASSACHUSETTS_STOUGHTON_ARRESTS                  ' , 
 vendor_code = 'W0235' =>'MASSACHUSETTS_EAST_LONGMEADOW_ARRESTS            ' , 
 vendor_code = 'W0236' =>'MASSACHUSETTS_IPSWICH_ARRESTS                    ' , 
 vendor_code = 'W0237' =>'MASSACHUSETTS_ROCKLAND_ARRESTS                   ' , 
 vendor_code = 'W0238' =>'FLORIDA_PINELLAS_COUNTY_SHERIFFS_OFFICE          ' , 
 vendor_code = 'W0239' =>'FLORIDA_HIGHLANDS_COUNTY_SHERIFFS_OFFICE         ' , 
 vendor_code = 'W0240' =>'MASSACHUSETTS_MELROSE_ARRESTS                    ' , 
 vendor_code = 'W0241' =>'CALIFORNIA_TULARE_COUNTY_BOOKINGS                ' , 
 vendor_code = 'W0242' =>'MASSACHUSETTS_CARVER_ARRESTS                     ' , 
 vendor_code = 'W0243' =>'CALIFORNIA_DOWNEY_ARRESTS                        ' ,
 vendor_code = 'W0244' =>'MASSACHUSETTS_BELCHERTOWN_ARRESTS                ' ,
 vendor_code = 'W0245' =>'MASSACHUSETTS_MIDDLETON_ARRESTS                  ' ,
 vendor_code = 'W0246' =>'ILLINOIS_ROCKFORD_ARRESTS                        ' ,
 vendor_code = 'W0247' =>'MASSACHUSETTS_CANTON_POLICE_DEPARTMENT           ' ,
 vendor_code = 'W0248' =>'MASSACHUSETTS_DEDHAM_ARRESTS                     ' ,
 vendor_code = 'W0249' =>'MASSACHUSETTS_MARBLEHEAD_ARRESTS                 ' ,
 vendor_code = 'W0250' =>'MASSACHUSETTS_NORWELL_ARRESTS                    ' ,
 vendor_code = 'W0251' =>'TEXAS_COLLIN_COUNTY_DISTRICT_COURT               ' ,
 vendor_code = 'W0252' =>'OHIO_AUGLAIZE_COUNTY_MUNICIPAL_COURT             ' ,                
 vendor_code = 'W0253' =>'FLORIDA_ESCAMBIA_COUNTY                          ' ,
 vendor_code = 'W0254' =>'TEXAS_FORT_BEND_COUNTY_DISTRICT_COURT            ' ,                                    
 vendor_code = 'W0255' =>'OHIO_PUTNAM_COUNTY_COMMON_PLEAS_COURT            ' ,
 vendor_code = 'W0256' =>'ARIZONA_MESA                                     ' ,
 vendor_code = 'W0257' =>'OHIO_JEFFERSON_COUNTY_DILLONVALE_MUNICIPAL_COURT ' ,
 vendor_code = 'W0258' =>'OHIO_MORGAN_COUNTY_MUNICIPAL_COURT               ' ,
 vendor_code = 'W0259' =>'OHIO_LICKING_COUNTY_COMMON_PLEAS_COURT           ' ,
 vendor_code = 'W0260' =>'ARIZONA_GLENDALE                                 ' ,
 vendor_code = 'W0261' =>'ARIZONA_TEMPE                                    ' ,
 vendor_code = 'W0262' =>'ARIZONA_SCOTTSDALE                               ' ,
 vendor_code = 'W0263' =>'ARIZONA_CHANDLER                                 ' ,
 vendor_code = 'W0264' =>'ARIZONA_GILBERT                                  ' ,
 vendor_code = 'W0265' =>'ARIZONA_PEORIA                                   ' ,
 vendor_code = 'W0266' =>'CALIFORNIA_PLACER_COUNTY_TRAFFIC                 ' ,
 vendor_code = 'W0267' =>'ARIZONA_DEPARTMENT_OF_PUBLIC_SAFETY              ' ,
 vendor_code = 'W0268' =>'TEXAS_DEPARTMENT_OF_CRIMINAL_JUSTICE_INMATES     ' ,

 vendor_code = 'W0269' =>'CALIFORNIA_MENDOCINO_COUNTY_BOOKINGS          ' ,
 vendor_code = 'W0270' =>'CALIFORNIA_TEHAMA_COUNTY_BOOKINGS             ' ,
 vendor_code = 'W0271' =>'FLORIDA_CITRUS_COUNTY_SHERIFFS_OFFICE         ' ,
 vendor_code = 'W0272' =>'FLORIDA_DIXIE_COUNTY_SHERIFFS_OFFICE          ' ,
 vendor_code = 'W0273' =>'FLORIDA_LEE_COUNTY_SHERIFFS_OFFICE            ' ,
 vendor_code = 'W0274' =>'FLORIDA_ST_JOHNS_COUNTY_SHERIFFS_OFFICE       ' ,
 vendor_code = 'W0275' =>'FLORIDA_ST_LUCIE_COUNTY_SHERIFFS_OFFICE       ' ,
 vendor_code = 'W0276' =>'LOUISIANA_SLIDELL_POLICE                      ' ,
 vendor_code = 'W0277' =>'MASSACHUSETTS_BOURNE_ARRESTS                  ' ,
 vendor_code = 'W0278' =>'MASSACHUSETTS_BRIDGEWATER_ARRESTS             ' ,
 vendor_code = 'W0279' =>'MASSACHUSETTS_CHICOPEE_ARRESTS                ' ,
 vendor_code = 'W0280' =>'MASSACHUSETTS_COHASSET_ARRESTS                ' ,
 vendor_code = 'W0281' =>'MASSACHUSETTS_DALTON_ARRESTS                  ' ,
 vendor_code = 'W0282' =>'MASSACHUSETTS_DENNIS_ARRESTS                  ' ,
 vendor_code = 'W0283' =>'MASSACHUSETTS_DUXBURY_ARRESTS                 ' ,
 vendor_code = 'W0284' =>'MASSACHUSETTS_FITCHBURG_ARRESTS               ' ,
 vendor_code = 'W0285' =>'MASSACHUSETTS_FOXBORO_ARRESTS                 ' ,
 vendor_code = 'W0286' =>'MASSACHUSETTS_GARDNER_ARRESTS                 ' ,
 vendor_code = 'W0287' =>'MASSACHUSETTS_LEOMINSTER_ARRESTS              ' ,
 vendor_code = 'W0288' =>'MASSACHUSETTS_LONGMEADOW_ARRESTS              ' ,
 vendor_code = 'W0289' =>'MASSACHUSETTS_MASHPEE_ARRESTS                 ' ,
 // vendor_code = 'W0290' =>'MASSACHUSETTS_MELROSE_POLICE_DEPARTMENT       ' ,
 vendor_code = 'W0291' =>'MASSACHUSETTS_MIDDLETON_POLICE_DEPARTMENT     ' ,
 vendor_code = 'W0292' =>'MASSACHUSETTS_MILFORD_ARRESTS                 ' ,
 vendor_code = 'W0293' =>'MASSACHUSETTS_NORTH_ATTLEBORO_ARRESTS         ' ,
 vendor_code = 'W0294' =>'MASSACHUSETTS_NORTHAMPTON_ARRESTS             ' ,
 vendor_code = 'W0295' =>'MASSACHUSETTS_ORLEANS_ARRESTS                 ' ,
 vendor_code = 'W0296' =>'MASSACHUSETTS_PALMER_ARRESTS                  ' ,
 vendor_code = 'W0297' =>'MASSACHUSETTS_PLYMPTON_ARRESTS                ' ,
 vendor_code = 'W0298' =>'MASSACHUSETTS_ROCHESTER_ARRESTS               ' ,
 vendor_code = 'W0299' =>'MASSACHUSETTS_SOUTHWICK_ARRESTS               ' ,
 vendor_code = 'W0300' =>'MASSACHUSETTS_TEWKSBURY_POLICE                ' , 
 vendor_code = 'W0301' =>'MASSACHUSETTS_TRURO_ARRESTS                   ' ,
 vendor_code = 'W0302' =>'MASSACHUSETTS_WAYLAND_ARRESTS                 ' ,
 vendor_code = 'W0303' =>'MASSACHUSETTS_WEST_BRIDGEWATER_ARRESTS        ' ,
 vendor_code = 'W0304' =>'MASSACHUSETTS_WESTFIELD_ARRESTS               ' ,
 vendor_code = 'W0305' =>'MASSACHUSETTS_WRETNAM_ARRESTS                 ' ,
 vendor_code = 'W0306' =>'MASSACHUSETTS_WRENTHAM_ARRESTS                ' , 
 vendor_code = 'W0307' =>'MASSACHUSETTS_YARMOUTH_ARRESTS                ' ,
 vendor_code = 'W0308' =>'MINNESOTA_BROWN_COUNTY_SHERIFF                ' ,
 vendor_code = 'W0309' =>'MONTANA_YELLOWSTONE_COUNTY_DETENTION          ' ,
 vendor_code = 'W0310' =>'FLORIDA_OSCEOLA_COUNTY_CORRECTIONS            ' ,
//County                                                                   
 vendor_code = 'W0311' =>'ARIZONA_AVONDALE                              ' ,
 vendor_code = 'W0312' =>'ARIZONA_BUCKEYE                               ' ,
 vendor_code = 'W0313' =>'ARIZONA_EL_MIRAGE                             ' ,
 vendor_code = 'W0314' =>'ARIZONA_GOODYEAR                              ' ,
 vendor_code = 'W0315' =>'ARIZONA_SURPRISE                              ' ,
 vendor_code = 'W0316' =>'ARIZONA_TOLLESON                              ' ,
 vendor_code = 'W0317' =>'ARIZONA_WICKENBURG                            ' ,
 vendor_code = 'W0318' =>'OHIO_CHAMPAIGN_COUNTY_MUNICIPAL_COURT         ' ,
 vendor_code = 'W0319' =>'OHIO_SENECA_COUNTY_TIFFIN_MUNICIPAL_COURT     ' ,
 //AOC                                                                     
 vendor_code = 'W0320' =>'KANSAS_OFFENDER_REGISTRY                      ' ,
 
 
 //************************LN Sources****************************/
 vendor_code = '3N' => 'LOUSIANA - EAST BATON ROUGE',
 vendor_code = '3O' => 'LOUISIANA - JEFFERSON COUNTY ',
 vendor_code = '4D' => 'OHIO BROWN COMMON PLEAS',
 // vendor_code = '3J' => 'OHIO PICKAWAY COUNTY',
 // vendor_code = '3Y' => 'TENNESSEE RUTHERFORD ',
 vendor_code = '3K' => 'TEXAS GRAYSON COUNTY',
 // vendor_code = '3L' => 'TEXAS LAMAR COUNTY',
 // vendor_code = '2K' => 'OHIO RICHLAND COUNTY',
 // vendor_code = '2L' => 'OHIO WAYNE COUNTY',
 vendor_code = '90' => 'ARIZONA MOHAVE CRIMINAL COURT',
 // vendor_code = '64' => 'CALIFORNIA MENDOCINO COUNTY',
 // vendor_code = '55' => 'CALIFORNIA SACRAMENTO COUNTY',
 vendor_code = 'B7' => 'CALIFORNIA SAN JOAQUIN ARREST',
 vendor_code = 'A3' => 'CALIFORNIA SANTA MONICA COUNTY ARRESTS',
 vendor_code = 'B8' => 'CALIFORNIA SOLANO COUNTY ARRESTS',
 vendor_code = '73' => 'CALIFORNIA STANISLAUS COUNTY',
 // vendor_code = '1J' => 'COLORADO DENVER CRIMINAL COURT',
 vendor_code = 'AT' => 'FLORIDA DADE COUNTY ARRESTS',
 // vendor_code = '75' => 'FLORIDA INDIAN RIVER COUNTY',
 vendor_code = '63' => 'FLORIDA LAKE TRAFFIC',
 vendor_code = '1B' => 'FLORIDA MANATTE COUNTY',
 // vendor_code = '42' => 'FLORIDA PASCO COUNTY',
 // vendor_code = '43' => 'FLORIDA PASCO COUNTY TRAFFIC',
 vendor_code = 'A4' => 'FLORIDA SARASOTA COUNTY ARRESTS',
 vendor_code = 'D4' => 'MICHIGAN OAKLAND COUNTY ARRESTS',
 // vendor_code = '93' => 'MISSISSIPPI HARRISON COUNTY',
 // vendor_code = 'NC' => 'NORTH CAROLINA DEPARTMENT OF CORRECTIONS',
 // vendor_code = '1R' => 'OHIO HAMILTON COUNTY',
 // vendor_code = '2H' => 'OHIO HANCOCK COUNTY',
 // vendor_code = '2V' => 'OHIO HARDIN COUNTY',
 // vendor_code = '1L' => 'OHIO LAKE COUNTY',
 // vendor_code = '2O' => 'OHIO MAHONING COUNTY',
 // vendor_code = '1N' => 'OHIO MEDINA COUNTY',
 vendor_code = '2Z' => 'OHIO NOBLE COUNTY',
 // vendor_code = '1M' => 'OHIO SANDUSKY COUNTY',
 // vendor_code = '2W' => 'OHIO ADAMS COUNTY',
 // vendor_code = '1A' => 'OHIO AUGLAIZE COUNTY',
 // vendor_code = '1E' => 'OHIO CHAMPAIGN COUNTY',
 // vendor_code = '1I' => 'OHIO FAIRFIELD COUNTY',
 vendor_code = '91' => 'OHIO MONROE COUNTY',
 // vendor_code = '89' => 'OHIO PUTNAM COUNTY',
 vendor_code = '1S' => 'OKLAHOMA ADAIR COUNTY',
 vendor_code = '1T' => 'OKLAHOMA CANADIAN COUNTY',
 vendor_code = '1U' => 'OKLAHOMA CLEVELAND COUNTY',
 vendor_code = '1V' => 'OKLAHOMA COMANCHE COUNTY',
 vendor_code = '1X' => 'OKLAHOMA ELISS COUNTY',
 vendor_code = '1W' => 'OKLAHOMA GARFIELD COUNTY',
 vendor_code = '1Z' => 'OKLAHOMA LOGAN COUNTY',
 vendor_code = '2A' => 'OKLAHOMA CRIMINAL COURT',
 vendor_code = '2B' => 'OKLAHOMA PAYNE COUNTY',
 vendor_code = '2C' => 'OKLAHOMA PUSHMATAHA COUNTY',
 vendor_code = '2F' => 'OKLAHOMA ROGER MILLS COUNTY',
 vendor_code = '2D' => 'OKLAHOMA ROGERS COUNTY',
 vendor_code = '2E' => 'OKLAHOMA TULSA COUNTYÂ  ',
 // vendor_code = 'OR' => 'OREGON DEPARTMENT OF CORRECTIONS',
 // vendor_code = '2Q' => 'SOUTH CAROLINA GREENVILLE COUNTY',
 // vendor_code = '2X' => 'SOUTH CAROLINA YORK COUNTY',
 // vendor_code = '2U' => 'TENNESSEE HAMILTON COUNTY',
 vendor_code = '2Y' => 'TENNESSEE METHAMPHETAMINE COUNTY',
 // vendor_code = '3R' => 'TENNESSEE RUTHERFORD ',
 // vendor_code = '98' => 'TEXAS WALLER COUNTY',
 vendor_code = '77' => 'TEXAS COMAL COUNTY',
 // vendor_code = '78' => 'TEXAS LAMAR COUNTY',
 vendor_code = 'AP' => 'TEXAS LUBBOCK COUNTY ARRESTS',
 vendor_code = '79' => 'TEXAS PARKER COUNTY',
 vendor_code = '80' => 'TEXAS TOM GREEN COUNTY',
 // vendor_code = '47' => 'TEXAS TRAVIS COUNTY',
 // vendor_code = '97' => 'TEXAS WILLIAMSON COUNTY',
 vendor_code = 'WA' => 'WASHINGTON DEPARTMENT OF CORRECTIONS',
 // vendor_code = '03' => 'WASHINGTON COURTS OF LIMITED JURISDICTION CRIMINAL INDEX',
 vendor_code = 'A7' => 'WASHINGTON OKANOGAN COUNTY ARRESTS',
 // vendor_code = '02' => 'WASHINGTON SCOMIS',
 '');
 
 return sourcename;
end;

end;

