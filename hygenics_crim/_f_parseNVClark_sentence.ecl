EXPORT _f_parseNVClark_sentence := MODULE

// psent1 := '0,1,12,2537,25.00,0;2542,150.00,0,48,5,PROBATION REINSTATED 01-24-13.,PROBATION REINSTATED AND A CONDITON ADDED 2/21/13     ';

// psent  := regexreplace('MINIMUM',
          // regexreplace('MAXIMUM',
					// regexreplace('MONTHS',
					// regexreplace('YEARS',
                       // psent1,'YRS'),'MNTHS'),'MAX'),'MIN');
                         

// loc1 := stringlib.stringfind(psent,'SENTENCE#',1);
// loc2 := stringlib.stringfind(psent,'SENTENCE#',2);
// loc3 := stringlib.stringfind(psent,'SENTENCE#',3);
// loc4 := stringlib.stringfind(psent,'SENTENCE#',4);
// loc5 := stringlib.stringfind(psent,'SENTENCE#',5);

// sent1 := MAP(loc1<>0 and loc2<>0 =>psent[loc1+15..loc2-1],
             // loc1<>0             =>psent[loc1+15..],
             // '');						 
// sent2 := MAP(loc2<>0 and loc3<>0 =>psent[loc2+15..loc3-1],
             // loc2<>0             =>psent[loc2+15..],
             // '');
// sent3 := MAP(loc3<>0 and loc4<>0 =>psent[loc3+15..loc4-1],
             // loc3<>0             =>psent[loc3+15..],
             // '');
// sent4 := MAP(loc4<>0 and loc5<>0 =>psent[loc4+15..loc5-1],
             // loc4<>0             =>psent[loc4+15..],
             // '');

export string sent_agency(string psent) := function

sent_agency  := MAP(regexfind('(.*) PLACEMENT: ([A-Z]+),(.*)',trim(psent,left)) =>regexreplace('(.*) PLACEMENT: ([A-Z]+),(.*)',trim(psent,left),'$2'),
                    regexfind('(.*) PLACEMENT: ([A-Z]+) (.*)',trim(psent,left)) =>regexreplace('(.*) PLACEMENT: ([A-Z]+) (.*)',trim(psent,left),'$2'),
                    '');
return sent_agency;			
end;	

export string susp_sent(string psent) := function
											
susp_sent    := MAP(regexfind('(.*) SUSPENDED (MIN) ([0-9]+) (MNTHS|YRS|DAYS|WEEKS) TO (MAX) ([0-9]+ [A-Z]+) (.*)',trim(psent,left)) =>regexreplace('(.*) SUSPENDED (MIN) ([0-9]+) (MNTHS|YRS|DAYS|WEEKS) TO (MAX) ([0-9]+ [A-Z]+) (.*)',trim(psent,left),'$2:$3 $5:$6'),
                    ''); 
return susp_sent;			
end;																				

export string comm_serv(string psent) := function

comm_serv    := MAP(regexfind('(.*) FINE AND/OR COMMUNITY SERVICE (MIN) ([0-9]+) (MNTHS|YRS|DAYS|WEEKS|HOURS) TO (MAX) ([0-9]+ [A-Z]+) (.*)',trim(psent,left)) =>regexreplace('(.*) FINE AND/OR COMMUNITY SERVICE (MIN) ([0-9]+) (MNTHS|YRS|DAYS|WEEKS|HOURS) TO (MAX) ([0-9]+ [A-Z]+) (.*)',trim(psent,left),'$2:$3 $5:$6'),
                    regexfind('(.*) COMMUNITY SERVICE (MIN) ([0-9]+) (MNTHS|YRS|DAYS|WEEKS|HOURS) TO (MAX) ([0-9]+ [A-Z]+)[, ]*(.*)',trim(psent,left)) =>regexreplace('(.*) COMMUNITY SERVICE (MIN) ([0-9]+) (MNTHS|YRS|DAYS|WEEKS|HOURS) TO (MAX) ([0-9]+ [A-Z]+)[, ]*(.*)',trim(psent,left),'$2:$3 $5:$6'),
                    ''); 										
return comm_serv;			
end;	

export string Jail(string psent) := function
														
JAil         := MAP(regexfind('(.*)SENTENCE# [0-9]+: (MIN) ([0-9]+) (MNTHS|YRS|DAYS|WEEKS) TO (MAX) ([0-9]+ [A-Z]+) (.*)'                                           ,trim(psent,left)) =>regexreplace('(.*)SENTENCE# [0-9]+: (MIN) ([0-9]+) (MNTHS|YRS|DAYS|WEEKS) TO (MAX) ([0-9]+ [A-Z]+) (.*)'                                           ,trim(psent,left),'$2:$3 $5:$6'),
										regexfind('(.*) SENTENCE MODIFIED TO (MIN) ([0-9]+) (MNTHS|YRS|DAYS|WEEKS) TO (MAX) ([0-9]+ [A-Z]+)[, ](.*)'                       ,trim(psent,left)) =>regexreplace('(.*) SENTENCE MODIFIED TO (MIN) ([0-9]+) (MNTHS|YRS|DAYS|WEEKS) TO (MAX) ([0-9]+ [A-Z]+)[, ](.*)'                       ,trim(psent,left),'MODIFIED TO $2:$3 $5:$6'),
										regexfind('(.*) SENTENCE MODIFIED IN LIEU OF COMM\\. SER\\. (MIN) ([0-9]+) (MNTHS|YRS|DAYS|WEEKS) TO (MAX) ([0-9]+ [A-Z]+)[, ](.*)',trim(psent,left)) =>regexreplace('(.*) SENTENCE MODIFIED IN LIEU OF COMM\\. SER\\. (MIN) ([0-9]+) (MNTHS|YRS|DAYS|WEEKS) TO (MAX) ([0-9]+ [A-Z]+)[, ](.*)',trim(psent,left),'MODIFIED TO $2:$3 $5:$6'),
										regexfind('(.*) SENTENCE MODIFIED IN LIEU OF FINE (MIN) ([0-9]+) (MNTHS|YRS|DAYS|WEEKS) TO (MAX) ([0-9]+ [A-Z]+)[, ](.*)'          ,trim(psent,left)) =>regexreplace('(.*) SENTENCE MODIFIED IN LIEU OF FINE (MIN) ([0-9]+) (MNTHS|YRS|DAYS|WEEKS) TO (MAX) ([0-9]+ [A-Z]+)[, ](.*)'          ,trim(psent,left),'MODIFIED TO $2:$3 $5:$6'),
										regexfind('(.*) SENTENCE AMENDED (MIN) ([0-9]+) (MNTHS|YRS|DAYS|WEEKS) TO (MAX) ([0-9]+ [A-Z]+)[, ](.*)'                           ,trim(psent,left)) =>regexreplace('(.*) SENTENCE AMENDED (MIN) ([0-9]+) (MNTHS|YRS|DAYS|WEEKS) TO (MAX) ([0-9]+ [A-Z]+)[, ](.*)'                           ,trim(psent,left),'AMENDED TO $2:$3 $5:$6'),
										regexfind('(.*) DAY ARREST (MIN) ([0-9]+) (MNTHS|YRS|DAYS|WEEKS) TO (MAX) ([0-9]+ [A-Z]+)[, ](.*)'                                 ,trim(psent,left)) =>regexreplace('(.*) DAY ARREST (MIN) ([0-9]+) (MNTHS|YRS|DAYS|WEEKS) TO (MAX) ([0-9]+ [A-Z]+)[, ](.*)'                                 ,trim(psent,left),'$2:$3 $5:$6'),
										regexfind('(.*) DEFENDANT RE-SENTENCED (MIN) ([0-9]+) (MNTHS|YRS|DAYS|WEEKS) TO (MAX) ([0-9]+ [A-Z]+)[, ](.*)'                     ,trim(psent,left)) =>regexreplace('(.*) DEFENDANT RE-SENTENCED (MIN) ([0-9]+) (MNTHS|YRS|DAYS|WEEKS) TO (MAX) ([0-9]+ [A-Z]+)[, ](.*)'                     ,trim(psent,left),'$2:$3 $5:$6'),
										regexfind('(.*) JAIL TIME OR FINE (MIN) ([0-9]+) (MNTHS|YRS|DAYS|WEEKS) TO (MAX) ([0-9]+ [A-Z]+)[, ](.*)'                          ,trim(psent,left)) =>regexreplace('(.*) JAIL TIME OR FINE (MIN) ([0-9]+) (MNTHS|YRS|DAYS|WEEKS) TO (MAX) ([0-9]+ [A-Z]+)[, ](.*)'                          ,trim(psent,left),'$2:$3 $5:$6'),
 										regexfind('(.*)[ ,-]+([0-9]{1,2}[/-][0-9]+[/-][0-9]{2})[ ]*- PROBATION REINSTATED[ -/]+ADDED CONDITION[\\. ,;]+(.*)'               ,trim(psent,left)) =>regexreplace('(.*)[ ,-]+([0-9]{1,2}[/-][0-9]{1,2}[/-][0-9]{1,2})[ ]*- PROBATION REINSTATED[ -/]+ADDED CONDITION[\\. ,;]+(.*)',trim(psent,left),'$2 PROB REINSTATED ADDED CONDITION'),										                                                                                                                    
										                                                                                                                           

										regexfind('YEARS TO LIFE[, ](.*)'                     ,trim(psent,left)) =>'YEARS TO LIFE',
										regexfind('LIFE WITH POSSIBILITY OF PAROLE[, ](.*)'   ,trim(psent,left)) =>'LIFE W/PAROLE',
										regexfind('LIFE WITHOUT POSSIBILITY OF PAROLE[, ](.*)',trim(psent,left)) =>'LIFE W/O PAROLE',														  
										regexfind('DEATH PENALTY[, ]'                         ,trim(psent,left)) =>'DEATH PENALTY',														  
										regexfind('DAY ARREST[, ]'                            ,trim(psent,left)) =>'DAY ARREST',
										'');
return Jail;			
end;											

export string Fine(string psent) := function
Fine         := MAP(regexfind('(.*) FINE AMOUNT: \\$([0-9.]+)[, ](.*)',trim(psent,left))                          =>regexreplace('(.*) FINE AMOUNT: \\$([0-9.]+)[, ](.*)',trim(psent,left),'$2'),
                    regexfind('(.*) FINE AND/OR COMMUNITY SERVICE AMOUNT: \\$([0-9.]+)[, ](.*)',trim(psent,left)) =>regexreplace('(.*) FINE AND/OR COMMUNITY SERVICE AMOUNT: \\$([0-9.]+)[, ](.*)',trim(psent,left),'$2'),
										regexfind('(.*) JAIL TIME OR FINE AMOUNT: \\$([0-9.]+)[, ](.*)',trim(psent,left))             =>regexreplace('(.*) JAIL TIME OR FINE AMOUNT: \\$([0-9.]+)[, ](.*)',trim(psent,left),'$2'),
										'');
return Fine;			
end;		

// $25.ADM, $150.DNAF, PAY FINE OF $500.00,0,06/08/10 - CONDITION OF REGISTERING AS A SEX OFFENDER IS VACATED,08/12/10 - CONDITIONS CLARIFIED,1,11/02/10 - CREDIT FOR TIME SERVED.,12,2                    


export string Fine_add(string psent) := function
Fine_add       := MAP(regexfind('(.*) FINE OF \\$([0-9\\.]+) (AND|OR) (.*)|WAIVED',trim(psent,left))    => '',
                      regexfind('(.*)[, ]\\$([0-9,\\.]+)[ ]*FINE[;,\\. ](.*)',trim(psent,left))         => regexreplace('(.*)[, ]\\$([0-9,\\.]+)[ ]*FINE[;,\\. ](.*)',trim(psent,left),'$2'),
                      regexfind('^\\$([0-9,\\.]+)[ ]*FINE[;, \\.](.*)',trim(psent,left))                => regexreplace('^\\$([0-9,\\.]+)[ ]*FINE[;,\\. ](.*)',trim(psent,left),'$1'),
                      regexfind('(.*)[, ]FINE \\$([0-9]+[,]*[0-9\\.]+)(,[0-9]+)+(.*)',trim(psent,left)) => regexreplace('(.*)[, ]FINE \\$([0-9]+[,]*[0-9\\.]+)(,[0-9]+)+(.*)',trim(psent,left),'$2'),
                      regexfind('(.*)[, ]FINE \\$([0-9]+[,]*[0-9\\.]+)(,[0-9]+)+[ ]*$',trim(psent,left))=> regexreplace('(.*)[, ]FINE \\$([0-9]+[,]*[0-9\\.]+)(,[0-9]+)+[ ]*$',trim(psent,left),'$2'),
											regexfind('(.*)[, ]FINE \\$([0-9,\\.]+)[-; \\.]+(.*)',trim(psent,left))           => regexreplace('(.*)[, ]FINE \\$([0-9,\\.]+)[-; \\.]+(.*)',trim(psent,left),'$2'),
											regexfind('(.*)[, ]FINE \\$([0-9,\\.]+)[ ]*$',trim(psent,left))                   => regexreplace('(.*)[, ]FINE \\$([0-9,\\.]+)[ ]*$',trim(psent,left),'$2'),

									    regexfind('(.*)[, ]FINE OF \\$([0-9]+[,]*[0-9\\.]+)(,[0-9]+)+(.*)' ,trim(psent,left)) => regexreplace('(.*)[, ]FINE OF \\$([0-9]+[,]*[0-9\\.]+)(,[0-9]+)+(.*)',trim(psent,left),'$2'),
											regexfind('(.*)[, ]FINE OF \\$([0-9]+[,]*[0-9\\.]+)(,[0-9]+)*[ ]*$',trim(psent,left)) => regexreplace('(.*)[, ]FINE OF \\$([0-9]+[,]*[0-9\\.]+)(,[0-9]+)*[ ]*$',trim(psent,left),'$2'),
											regexfind('(.*)[, ]FINE OF \\$([0-9,\\.]+)[ ]*[-; \\.]+(.*)'    ,trim(psent,left))    => regexreplace('(.*)[, ]FINE OF \\$([0-9,\\.]+)[-; \\.]+(.*)',trim(psent,left),'$2'),
										  '');
return Fine_add;			
end;										

export string Restitution(string psent) := function														
Restitution  := MAP(regexfind('(.*) RESTITUTION AMOUNT: \\$([0-9.]+)[, ](.*)',trim(psent,left)) =>regexreplace('(.*) RESTITUTION AMOUNT: \\$([0-9.]+)[, ](.*)',trim(psent,left),'$2'),
										'');
return Restitution;			
end;
											
export string consconc(string psent) := function														
consconc     := MAP(regexfind('CONS/CONC: CONCURRENT' ,trim(psent,left)) =>'CONCURRENT',
                    regexfind('CONS/CONC: CONSECUTIVE',trim(psent,left)) =>'CONSECUTIVE',
										'');		
return consconc;			
end;	

 export string Probation(string psent) := function
Probation    := MAP(regexfind('(.*) PROBATION WITH CONDITIONS (MIN) ([0-9]+) (MNTHS|YRS|DAYS|WEEKS) TO (MAX) ([0-9]+ [A-Z]+)[, ](.*)',trim(psent,left)) =>regexreplace('(.*) PROBATION [WITH CONDITIONS ]*(MIN) ([0-9]+) (MNTHS|YRS|DAYS|WEEKS) TO (MAX) ([0-9]+ [A-Z]+)[, ](.*)',trim(psent,left),'$2:$3 $5:$6'),
                    regexfind('(.*) PROBATION (MIN) ([0-9]+) (MNTHS|YRS|DAYS|WEEKS) TO (MAX) ([0-9]+ [A-Z]+)[, ](.*)'                ,trim(psent,left)) =>regexreplace('(.*) PROBATION (MIN) ([0-9]+) (MNTHS|YRS|DAYS|WEEKS) TO (MAX) ([0-9]+ [A-Z]+)[, ](.*)',trim(psent,left),'$2:$3 $5:$6'),
										regexfind('(.*) PROBATION EXTENDED (MIN) ([0-9]+) (MNTHS|YRS|DAYS|WEEKS) TO (MAX) ([0-9]+ [A-Z]+)[, ](.*)'       ,trim(psent,left)) =>regexreplace('(.*) PROBATION EXTENDED (MIN) ([0-9]+) (MNTHS|YRS|DAYS|WEEKS) TO (MAX) ([0-9]+ [A-Z]+)[, ](.*)',trim(psent,left),'EXTENDED: $2:$3 $5:$6'),
                    regexfind('(.*) PROBATION MODIFIED (MIN) ([0-9]+) (MNTHS|YRS|DAYS|WEEKS) TO (MAX) ([0-9]+ [A-Z]+)[, ](.*)'       ,trim(psent,left)) =>regexreplace('(.*) PROBATION MODIFIED (MIN) ([0-9]+) (MNTHS|YRS|DAYS|WEEKS) TO (MAX) ([0-9]+ [A-Z]+)[, ](.*)',trim(psent,left),'MODIFIED: $2:$3 $5:$6'),
										regexfind('(.*) PROBATION RE-INSTATED (MIN) ([0-9]+) (MNTHS|YRS|DAYS|WEEKS) TO (MAX) ([0-9]+ [A-Z]+)[, ](.*)'    ,trim(psent,left)) =>regexreplace('(.*) PROBATION RE-INSTATED (MIN) ([0-9]+) (MNTHS|YRS|DAYS|WEEKS) TO (MAX) ([0-9]+ [A-Z]+)[, ](.*)',trim(psent,left),'RE-INSTATED: $2:$3 $5:$6'),
										regexfind('(.*) MENTAL HEALTH PROBATION W/CONDITIONS (MIN) ([0-9]+) (MNTHS|YRS|DAYS|WEEKS) TO (MAX) ([0-9]+ [A-Z]+)[, ](.*)',trim(psent,left)) =>regexreplace('(.*) MENTAL HEALTH PROBATION W/CONDITIONS (MIN) ([0-9]+) (MNTHS|YRS|DAYS|WEEKS) TO (MAX) ([0-9]+ [A-Z]+)[, ](.*)',trim(psent,left),'$2:$3 $5:$6'),
										
										//anything after Prob reinstated until and separater
										regexfind('(.*)[ ,-]+([0-9]+[\\./-][0-9]+[\\./-][0-9]{2})[ -]* PROBATION REINSTATED([A-Z -/]+)[\\.,;:]+(.*)'       ,trim(psent,left)) =>regexreplace('(.*)[ ,-]+([0-9]+[\\./-][0-9]+[\\./-][0-9]+)[ -]* PROBATION REINSTATED([A-Z -/]+)[\\.,;:]+(.*)',trim(psent,left),'$2 PROB REINSTATED$3'),										                                                                                                                    
 										regexfind('(.*)[ ,-]+([0-9]+[\\./-][0-9]+[\\./-][0-9]{2})[ -]* PROBATION REINSTATED([A-Z -/]+)[ ]+$'               ,trim(psent,left)) =>regexreplace('(.*)[ ,-]+([0-9]+[\\./-][0-9]+[\\./-][0-9]+)[ -]* PROBATION REINSTATED([A-Z -/]+)[ ]+$',trim(psent,left),'$2 PROB REINSTATED$3'),										                                                                                                                    
										
										regexfind('(.*)[ ,-]+([0-9]+[\\./-][0-9]+[\\./-][0-9]{2})[ -]* PROBATION REINSTATED[ \\.,;:]+(.*)'                    ,trim(psent,left)) =>regexreplace('(.*)[ ,-]+([0-9]+[\\./-][0-9]+[\\./-][0-9]+)[ -]* PROBATION REINSTATED[ \\.,;:]+(.*)',trim(psent,left),'$2 PROB REINSTATED'),										                                                                                                                    
 										regexfind('(.*)[ ,-]+([0-9]+[\\./-][0-9]+[\\./-][0-9]{2})[ -]* PROBATION REINSTATED[ ]+$'                          ,trim(psent,left)) =>regexreplace('(.*)[ ,-]+([0-9]+[\\./-][0-9]+[\\./-][0-9]+)[ -]* PROBATION REINSTATED[ ]+$',trim(psent,left),'$2 PROB REINSTATED'),										                                                                                                                    
 										 
	 							    regexfind('(.*)[ ,-]+PROBATION REINSTATED ([0-9]+[\\./-][0-9]+[\\./-][0-9]{2})([A-Z -/]+)[\\. ,;:][ ]*$'               ,trim(psent,left)) =>regexreplace('(.*)[ ,-]+PROBATION REINSTATED ([0-9]+[\\./-][0-9]+[\\./-][0-9]{2})([A-Z -/]+)[\\. ,;:][ ]*$',trim(psent,left),'$2 PROB REINSTATED$3'),
                    regexfind('(.*)[ ,-]+PROBATION REINSTATED ([0-9]+[\\./-][0-9]+[\\./-][0-9]{2})([A-Z -/]+)[ ]*$'                        ,trim(psent,left)) =>regexreplace('(.*)[ ,-]+PROBATION REINSTATED ([0-9]+[\\./-][0-9]+[\\./-][0-9]{2})([A-Z -/]+)[ ]*$',trim(psent,left),'$2 PROB REINSTATED$3'),
 
	 									regexfind('(.*)[ ,-]+PROBATION REINSTATED ([0-9]+[\\./-][0-9]+[\\./-][0-9]{2})[\\. ,;:][ ]*$'                          ,trim(psent,left)) =>regexreplace('(.*)[ ,-]+PROBATION REINSTATED ([0-9]+[\\./-][0-9]+[\\./-][0-9]{2})[\\. ,;:][ ]*$',trim(psent,left),'$2 PROB REINSTATED'),
                    regexfind('(.*)[ ,-]+PROBATION REINSTATED ([0-9]+[\\./-][0-9]+[\\./-][0-9]{2})[ ]*$'                                   ,trim(psent,left)) =>regexreplace('(.*)[ ,-]+PROBATION REINSTATED ([0-9]+[\\./-][0-9]+[\\./-][0-9]{2})[ ]*$',trim(psent,left),'$2 PROB REINSTATED'),
										
										regexfind('(.*)[ ,-]+([0-9]+[\\./-][0-9]+[\\./-][0-9]{2})[ ]*- PROBATION REINSTATED[\\. ,;]+(.*)'                  ,trim(psent,left)) =>regexreplace('(.*)[ ,-]+([0-9]+[\\./-][0-9]+[\\./-][0-9]+)[ ]*- PROBATION REINSTATED[\\. ,;]+(.*)',trim(psent,left),'$2 PROB REINSTATED'),										                                                                                                                    

										regexfind('PROBATION REINSTATED WITH [ADDED CONDITIONS.]+[, ]',trim(psent,left))    =>'PROBATION REINSTATED WITH ADDED CONDITION',     
                    regexfind('PROBATION WITH CONDITIONS[, ]'  ,trim(psent,left))    =>'PROBATION WITH CONDITIONS',
										regexfind('PROBATION EXTENDED,'            ,trim(psent,left))    =>'PROBATION EXTENDED',
                
										'');	
return Probation;			
end;				
							
export string Probation2(string psent) := function										
Probation2   := MAP(
                    regexfind('(.*) PROBATION REVOKED (MIN) ([0-9]+) (MNTHS|YRS|DAYS|WEEKS) TO (MAX) ([0-9]+ [A-Z]+)[, ](.*)' ,trim(psent,left)) =>regexreplace('(.*) PROBATION REVOKED (MIN) ([0-9]+) (MNTHS|YRS|DAYS|WEEKS) TO (MAX) ([0-9]+ [A-Z]+)[, ](.*)',trim(psent,left),'REVOKED: $2:$3 $5:$6'),
										regexfind('(.*)[ ,-]+([0-9]+[/-][0-9]+[/-][0-9]{2}) - PROBATION REVOKED[ ]*[AND/]+[ ]*SENTENCE MODIFIED[\\. ,;](.*)' ,trim(psent,left)) =>regexreplace('(.*)[ ,-]+([0-9]+[/-][0-9]+[/-][0-9]{2}) - PROBATION REVOKED[ ]*[AND/]+[ ]*SENTENCE MODIFIED[\\. ,;](.*)',trim(psent,left),'$2 PROB REVOKED AND OR SENT MODIFIED'),
										regexfind('(.*)[ ,-]+([0-9]+[/-][0-9]+[/-][0-9]{2}) - PROBATION REVOKED AND MODIFIED[\\. ,;](.*)'                    ,trim(psent,left)) =>regexreplace('(.*)[ ,-]+([0-9]+[/-][0-9]+[/-][0-9]{2}) - PROBATION REVOKED AND MODIFIED[\\. ,;](.*)',trim(psent,left),'$2 PROB REVOKED AND MODIFIED'),										                                                                                                                    
   									regexfind('(.*)[ ,-]+PROBATION REVOKED ([0-9]+[/-][0-9]+[/-][0-9]{2})[\\. ,;][ ]*$'                                  ,trim(psent,left)) =>regexreplace('(.*)[ ,-]+PROBATION REVOKED ([0-9]+[/-][0-9]+[/-][0-9]{2})[\\. ,;][ ]*$',trim(psent,left),'$2 PROB REVOKED'),
                    regexfind('(.*)[ ,-]+PROBATION REVOKED ([0-9]+[/-][0-9]+[/-][0-9]{2})[ ]*$'                                          ,trim(psent,left)) =>regexreplace('(.*)[ ,-]+PROBATION REVOKED ([0-9]+[/-][0-9]+[/-][0-9]{2})[ ]*$',trim(psent,left),'$2 PROB REVOKED'),
                                        
										regexfind('(.*)[ ,-]+([0-9]+[/-][0-9]+[/-][0-9]{2})[ ]*- PROBATION REVOKED WITH A MODIFIED SENTENCE[\\. ,;]+(.*)',trim(psent,left)) =>regexreplace('(.*)[ ,-]+([0-9]+[/-][0-9]+[/-][0-9]{2})[ ]*- PROBATION REVOKED WITH A MODIFIED SENTENCE[\\. ,;]+(.*)',trim(psent,left),'$2 PROB REVOKED'),										                                                                                                                    
										regexfind('(.*)[ ,-]+([0-9]+[/-][0-9]+[/-][0-9]{2})[ ]*- PROBATION REVOKED[/]MODIFIED[\\. ,;]+(.*)'              ,trim(psent,left)) =>regexreplace('(.*)[ ,-]+([0-9]+[/-][0-9]+[/-][0-9]{2})[ ]*- PROBATION REVOKED[/]MODIFIED[\\. ,;]+(.*)',trim(psent,left),'$2 PROB REVOKED'),										                                                                                                                    
										regexfind('(.*)[ ,-]+([0-9]+[/-][0-9]+[/-][0-9]{2})[ ]*- PROBATION REVOKED[\\. ,;]+(.*)'                         ,trim(psent,left)) =>regexreplace('(.*)[ ,-]+([0-9]+[/-][0-9]+[/-][0-9]{2})[ ]*- PROBATION REVOKED[\\. ,;]+(.*)',trim(psent,left),'$2 PROB REVOKED'),										                                                                                                                    

                    regexfind('(.*) INFORMAL PROBATION (MIN) ([0-9]+) (MNTHS|YRS|DAYS|WEEKS) TO (MAX) ([0-9]+ [A-Z]+)[, ](.*)'           ,trim(psent,left)) =>regexreplace('(.*) INFORMAL PROBATION (MIN) ([0-9]+) (MNTHS|YRS|DAYS|WEEKS) TO (MAX) ([0-9]+ [A-Z]+)[, ](.*)',trim(psent,left),'$2:$3 $5:$6'),
										//regexfind('(.*)([0-9]+[/-][0-9]+[/-][0-9]{2}) - PROBATION REVOKED AND SENTENCE MODIFIED,' ,trim(psent,left)) =>regexreplace('(.*)([0-9]+[/-][0-9]+[/-][0-9]{2}) - PROBATION REVOKED AND SENTENCE MODIFIED,',trim(psent,left),'$1 PROBATION REVOKED AND SENTENCE MODIFIED'),
										regexfind('PROBATION REVOKED[;,\\. ]'    ,trim(psent,left))   =>'PROBATION REVOKED',
										regexfind('PROBATION REVOKED[/]SENTENCE MODIFIED[;,\\. ]'    ,trim(psent,left))   =>'PROB REVOKED/ SENT MODIFIED',
										regexfind('PROBATION REVOKED[/]MODIFIED[;,\\. ]'    ,trim(psent,left))   =>'PROBATION REVOKED/MODIFIED',
										regexfind('MENTAL HEALTH PROBATION W/C' ,trim(psent,left))    =>'MENTAL HEALTH PROBATION WITH CONDITIONS',
                    regexfind('INFORMAL PROBATION'          ,trim(psent,left))    =>'INFORMAL PROBATION',
										
										'');	
return Probation2;			
end;			
								
export string additional(string psent) := function
additional   := MAP(regexfind('ADDITIONAL CONDITIONS OF PAROLE & PROB (MIN) ([0-9]+) (MNTHS|YRS|DAYS|WEEKS) TO (MAX) ([0-9]+ [A-Z]+)[, ](.*)',trim(psent,left)) =>regexreplace('ADDITIONAL CONDITIONS OF PAROLE & PROB (MIN) ([0-9]+) (MNTHS|YRS|DAYS|WEEKS) TO (MAX) ([0-9]+ [A-Z]+)[, ](.*)',trim(psent,left),'ADDL CONDI OF PAROLE & PROB $1:$2 $3:$4'),
                    regexfind('SENTENCE VACATED (MIN) ([0-9]+) (MNTHS|YRS|DAYS|WEEKS) TO (MAX) ([0-9]+ [A-Z]+)[, ](.*)'                      ,trim(psent,left)) =>regexreplace('SENTENCE VACATED (MIN) ([0-9]+) (MNTHS|YRS|DAYS|WEEKS) TO (MAX) ([0-9]+ [A-Z]+)[, ](.*)'                      ,trim(psent,left),'SENTENCE VACATED: $1:$2 $3:$4'),
                    regexfind('SUPERVISION FEE FOR PAROLE AND PROBATION[,]'    ,trim(psent,left)) =>'SUPERVISION FEE FOR PAROLE AND PROBATION',														 
										regexfind('SENTENCE MODIFIED IN LIEU OF COMM\\. SER\\.[,]' ,trim(psent,left)) =>'SENTENCE MODIFIED IN LIEU OF COMM. SER.',
										regexfind('SENTENCE MODIFIED IN LIEU OF FINE[,]'           ,trim(psent,left)) =>'SENTENCE MODIFIED IN LIEU OF FINE',
										regexfind('SENTENCE MODIFIED IN LIEU OF RESTITUTION[,]'    ,trim(psent,left)) =>'SENTENCE MODIFIED IN LIEU OF RESTITUTION',
										regexfind('SENTENCE SET ASIDE[,]'    ,trim(psent,left)) =>'SENTENCE SET ASIDE',
										regexfind('SENTENCE SUSPENDED PER'   ,trim(psent,left)) =>'SENTENCE SUSPENDED',
										regexfind('COUNSELING PROGRAM'       ,trim(psent,left)) =>'COUNSELING PROGRAM',
										regexfind('DEFENDANT RE-SENTENCED'   ,trim(psent,left)) =>'DEFENDANT RE-SENTENCED',
                                 
                    regexfind('COMMUNITY SERVICE,|COMMUNITY SERVICE[ ]*$'                    ,trim(psent,left)) =>'COMMUNITY SERVICE',
										regexfind('AFTER JAIL TIME DEFT TO BE DISHONORABLY DISCHARGED|DEFT TO RECEIVE A DISHONORABLE DISCHARGE AT END OF JAIL TIME'          ,trim(psent,left)) =>'DEFT TO BE DISHONORABLY DISC AFTER JAIL',
                    
                    regexfind('DISHONORABLY DISCHARGED,' ,trim(psent,left)) =>'DISHONORABLY DISCHARED',
                    regexfind('DRUG COURT,'              ,trim(psent,left)) =>'DRUG COURT',
                    regexfind('DUI SCHOOL,'              ,trim(psent,left)) =>'DUI SCHOOL',
                    regexfind('HONORABLE DISCHARGE,'     ,trim(psent,left)) =>'HONORABLE DISCHARGE',
										
										
										'');
return additional;			
end;			

								
export string additional2(string psent) := function													
additional2   := MAP(regexfind('HOUSE ARREST OR INTENSIVE SUPERVISION (MIN) ([0-9]+) (MNTHS|YRS|DAYS|WEEKS) TO (MAX) ([0-9]+ [A-Z]+)[, ](.*)',trim(psent,left)) =>regexreplace('HOUSE ARREST OR INTENSIVE SUPERVISION (MIN) ([0-9]+) (MNTHS|YRS|DAYS|WEEKS) TO (MAX) ([0-9]+ [A-Z]+)[, ](.*)',trim(psent,left),'HOUSE ARREST/SUPERVISION $1:$2 $3:$4'),
                    regexfind('LIFETIME SUPERVISION (MIN) ([0-9]+) (MNTHS|YRS|DAYS|WEEKS) TO (MAX) ([0-9]+ [A-Z]+)[, ](.*)',trim(psent,left)) =>regexreplace('LIFETIME SUPERVISION (MIN) ([0-9]+) (MNTHS|YRS|DAYS|WEEKS) TO (MAX) ([0-9]+ [A-Z]+)[, ](.*)',trim(psent,left),'HOUSE ARREST/SUPERVISION $1:$2 $3:$4'),
										regexfind('BOOTCAMP (MIN) ([0-9]+) (MNTHS|YRS|DAYS|WEEKS) TO (MAX) ([0-9]+ [A-Z]+)[, ](.*)'            ,trim(psent,left)) =>regexreplace('BOOTCAMP (MIN) ([0-9]+) (MNTHS|YRS|DAYS|WEEKS) TO (MAX) ([0-9]+ [A-Z]+)[, ](.*)',trim(psent,left),'HOUSE ARREST/SUPERVISION $1:$2 $3:$4'),
                    regexfind('BOOTCAMP'                                       ,trim(psent,left)) =>'BOOTCAMP', 
                    regexfind('HOUSE ARREST OR INTENSIVE SUPERVISION,'         ,trim(psent,left)) =>'HOUSE ARREST OR INTENSIVE SUPERVISION',
										regexfind('LIFETIME SUPERVISION,'                          ,trim(psent,left)) =>'LIFETIME SUPERVISION',
										regexfind('DOMESTIC VIOLENCE FEE AMOUNT: \\$([0-9.]+)[, ]' ,trim(psent,left)) =>regexreplace('DOMESTIC VIOLENCE FEE AMOUNT: \\$([0-9.]+)[, ]',trim(psent,left),'$1'),
										regexfind('DRUG ANALYSIS FEE AMOUNT: \\$([0-9.]+)[, ]'     ,trim(psent,left)) =>regexreplace('DRUG ANALYSIS FEE AMOUNT: \\$([0-9.]+)[, ]',trim(psent,left),'$1'),
										'');	
return additional2;			
end;

export string misc_fee(string psent) := function

misc_fee         := MAP(regexfind('\\$(.*)FEE[,;\\.]',trim(psent,left))  =>regexfind('\\$(.*)FEE[,;\\.]',trim(psent,left),0),	
                        regexfind('\\$(.*)DNAF[,;\\.]',trim(psent,left)) =>regexfind('\\$(.*)DNAF[,;\\.]',trim(psent,left),0),	
                        '');
			
return misc_fee;			
end;	

export string other(string psent) := function
// remfine       := MAP(regexfind('(.*)[, ]\\$([0-9,\\.]+)[ ]*FINE[;,\\. ](.*)',trim(psent,left))            => regexreplace('(.*)[, ]\\$([0-9,\\.]+)[ ]*FINE[;,\\. ](.*)',trim(psent,left),'$1 ,$3'),
                      // regexfind('^\\$([0-9,\\.]+)[ ]*FINE[;, \\.](.*)',trim(psent,left))                  => regexreplace('^\\$([0-9,\\.]+)[ ]*FINE[;,\\. ](.*)',trim(psent,left),'$2'),
                      // regexfind('((.*)[, ])FINE \\$([0-9]+[,]*[0-9\\.]+)(,[0-9]+)+(.*)',trim(psent,left)) => regexreplace('((.*)[, ])FINE \\$([0-9]+[,]*[0-9\\.]+)(,[0-9]+)+(.*)',trim(psent,left),'$1 ,$3'),
                      // regexfind('((.*)[, ])FINE \\$([0-9]+[,]*[0-9\\.]+)(,[0-9]+)+[ ]*$',trim(psent,left))=> regexreplace('((.*)[, ])FINE \\$([0-9]+[,]*[0-9\\.]+)(,[0-9]+)+[ ]*$',trim(psent,left),'$1 ,$3'),
											// regexfind('((.*)[, ])FINE \\$([0-9,\\.]+)[-; \\.]+(.*)',trim(psent,left))           => regexreplace('((.*)[, ])FINE \\$([0-9,\\.]+)[-; \\.]+(.*)',trim(psent,left),'$1 ,$3'),
											// regexfind('((.*)[, ])FINE \\$([0-9,\\.]+)[ ]*$',trim(psent,left))                   => regexreplace('((.*)[, ])FINE \\$([0-9,\\.]+)[ ]*$',trim(psent,left),'$1'),

									    // regexfind('((.*)[, ])PAY [A ]*FINE OF \\$([0-9]+[,]*[0-9\\.]+)(,[0-9]+)+(.*)' ,trim(psent,left)) => regexreplace('((.*)[, ])PAY [A ]*FINE OF \\$([0-9]+[,]*[0-9\\.]+)(,[0-9]+)+(.*)',trim(psent,left),'$1 ,$4'),
											// regexfind('((.*)[, ])PAY [A ]*FINE OF \\$([0-9]+[,]*[0-9\\.]+)(,[0-9]+)*[ ]*$',trim(psent,left)) => regexreplace('((.*)[, ])PAY [A ]*FINE OF \\$([0-9]+[,]*[0-9\\.]+)(,[0-9]+)*[ ]*$',trim(psent,left),'$1'),
											// regexfind('((.*)[, ])PAY [A ]*FINE OF \\$([0-9,\\.]+)[ ]*[-; \\.]+(.*)'    ,trim(psent,left))    => regexreplace('((.*)[, ])PAY [A ]*FINE OF \\$([0-9,\\.]+)[-; \\.]+(.*)',trim(psent,left),'$1 ,$3'),
										 
										 // psent);
										 
										
// remfees       := MAP(regexfind('\\$(.*)FEE[,;\\. ]+',trim(remfine,left))  =>regexreplace('\\$(.*)FEE[,;\\. ]+',trim(remfine,left),''),
                     // regexfind('\\$(.*)DNAF[,;\\. ]+',trim(remfine,left)) =>regexreplace('\\$(.*)DNAF[,;\\. ]+',trim(remfine,left),''),
                     // remfine);
remfees       := misc_fee(psent);
										 
other         := MAP(regexfind('([0-9]+,)+[0-9,\\.;]+[ ]+$',trim(psent,left)) =>regexreplace('([0-9]+,)+[0-9,\\.;]+[ ]+$',trim(psent,left),''),
										 regexfind('([0-9]+,)+[0-9,\\.;]+,',trim(psent,left)) =>regexreplace('([0-9]+,)+[0-9,\\.;]+,',trim(psent,left),''),
                     regexfind('([0-9]+,)+[0-9,\\.;]+,([0-9]+[/-][0-9]+[/-][0-9]{2})',trim(psent,left)) =>regexreplace('([0-9]+,)+[0-9,\\.;]+,([0-9]+[/-][0-9]+[/-][0-9]{2})',trim(psent,left),''),
                     regexfind('(.*),([0-9]+,)+[0-9,\\.;]+[ ]*',trim(psent,left)) =>regexreplace('(.*),([0-9]+,)+[0-9,\\.;]+[ ]*',trim(psent,left),'$1'),
                     ~regexfind('([0-9]+,)+[0-9,\\.;]+,',trim(psent,left)) =>psent,
                    ''); 	
other1 := If(remfees <> '',remfees, trim(stringlib.stringfilterout(other[1..1],',-;')+other[2..],left,right));											
		
otherfinale := MAP(regexfind('([0-9]+,)+[0-9] (.*)',other1) =>	regexreplace('([0-9]+,)+[0-9] (.*)',other1,'$1'),
	                 other1);
return 		otherfinale;
end;	

									
												
// output(sent_agency_rec_cust,named('agency'));			
// output(JAil,named('Jail'));											
// output(susp_sentence,named('susp'));
// output(consconc,named('CC'));
// output(Fine,named('Fine'));
// output(Probation,named('Prob'));
// output(Restitution,named('Restitu'));
// output(additional,named('additional'));

 // output(regexfind('PROBATION WITH CONDITIONS (MIN) ([0-9]+) (MNTHS|YRS|DAYS|WEEKS) TO (MAX) ([0-9]+ [A-Z]+)[, ](.*)',trim(sent2,left)));
end;