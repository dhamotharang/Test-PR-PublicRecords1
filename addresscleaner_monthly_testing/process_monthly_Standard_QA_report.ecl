import addresscleaner_monthly_testing;

#workunit('protect',true);
#workunit('name','Yogurt:Standard AddressCleaner Process QA Data ' +  addresscleaner_monthly_testing.version);
#OPTION('multiplePersistInstances',FALSE);

inRec :=RECORD
string   line1;    
string   line2;     
string   prange;    // 0    
string   ppre;      // 1
string   pstreet;   // 2
string   psuffix;   // 3  
string   ppost;     // 4
string   punit;     // 5
string   papt;      // 6
string   pcity;     // 7
string   pvanity;   // 8
string   pstate;    // 9
string   pzip5;     // 10
string   pzip4;     // 11
string   pcart;     // 12
string   psort;     // 13
string   plot;      // 14
string   porder;    // 15
string   pdpbc;     // 16
string   pchk;      // 17
string   ptype;     // 18
string   pcounty;   // 19
string   pstatus;   // 20
string   perror;    // 21
string   plat;      // 22
string   plong;     // 23
string   pmsa;      // 24
string   pblock;    // 25
string   pmatch;    // 26
string   crange;    
string   cpre;      
string   cstreet;   
string   csuffix;   
string   cpost;     
string   cunit;     
string   capt;      
string   ccity;     
string   cvanity ;  
string   cstate;    
string   czip5;     
string   czip4;     
string   ccart;     
string   csort;     
string   clot;      
string   corder;    
string   cdpbc;     
string   cchk;      
string   ctype;     
string   ccounty;   
string   cstatus;   
string   cerror;    
string   clat;      
string   clong;     
string   cmsa;      
string   cblock;    
string   cmatch;    
END;	

d := DATASET('~thor400_data::addresscleaner::monthly::processed',inRec,flat);							

d1 := d(perror[1] = 'E' and cerror[1] =  'E');
OUTPUT(distribute(choosen(d1,1000)),all,NAMED('Failed_Both'));
d2 := d(perror[1] = 'E' and cerror[1] = 'S');
output(distribute(choosen(d2,1000)),all,NAMED('Failed_Prod'));
d3 := d(perror[1] = 'S' and cerror[1] = 'E');
output(distribute(choosen(d3,1000)),all,NAMED('Failed_Cert'));
d4 := d(perror[1] = 'S' and cerror[1] = 'S');
output(distribute(choosen(d4,1000)),all,NAMED('Passed_Both'));
output('***** All individual results are below *****');
// output('########  Totals   ########');
// output(count(d),NAMED('Records_Processed'));
// output(count(d1),NAMED('Failed_by_Both'));
// output(count(d2),NAMED('Failed_Production'));
// output(count(d3),NAMED('Failed_Certification'));
// output(count(d4),NAMED('Matched_by_Both'));


            
t:=table(d,{
Records_Processed:=count(group)
,Records_Failed_Both:=sum(group,if(perror[1] = 'E' and cerror[1] =  'E',1,0))
,Records_Failed_Prod:=sum(group,if(perror[1] = 'E' and cerror[1] = 'S',1,0))
,Records_Failed_Cert:=sum(group,if(perror[1] = 'S' and cerror[1] = 'E',1,0))
,Records_Match_Both:=sum(group,if(perror[1] = 'S' and cerror[1] = 'S',1,0))

,Missing_Elements := sum(group,if((perror[1] = 'S' and cerror[1] = 'S'  or
                                  perror[1] = 'E' and cerror[1] = 'S' or 
																	perror[1] = 'S' and cerror[1] = 'E' or
																	perror[1] = 'E' and cerror[1] = 'E'),0,1))
																
																 
,City_State_Zip_Changed:=sum(group,if(perror[1] = 'S' and cerror[1] = 'S' and
                         		TRIM(pcity,LEFT,RIGHT) <> TRIM(ccity,LEFT,RIGHT)	  						or
														TRIM(pstate,LEFT,RIGHT) <> TRIM(cstate,LEFT,RIGHT)             or
														TRIM(pzip5,LEFT,RIGHT) <> TRIM(czip5,LEFT,RIGHT),1,0))
														
,Street_Address_Changed:=sum(group,if(perror[1] = 'S' and cerror[1] = 'S' and
                            TRIM(prange,LEFT,RIGHT) <> TRIM(crange,LEFT,RIGHT)  or
														TRIM(ppre,LEFT,RIGHT)   <> TRIM(cpre,LEFT,RIGHT)    or
														TRIM(pstreet,LEFT,RIGHT) <> TRIM(cstreet,LEFT,RIGHT) or
														TRIM(psuffix,LEFT,RIGHT) <> TRIM(csuffix,LEFT,RIGHT) or
														TRIM(ppost,LEFT,RIGHT)  <> TRIM(cpost,LEFT,RIGHT),1,0))
														
,Apartments_Changed:=sum(group,if(perror[1] = 'S' and cerror[1] = 'S' and
                     TRIM(papt,LEFT,RIGHT) <> TRIM(capt,LEFT,RIGHT),1,0))

										 
,Other_Elements_Changed:=sum(group,if(perror[1] = 'S' and cerror[1] = 'S' and
                         		TRIM(pcity,LEFT,RIGHT) = TRIM(ccity,LEFT,RIGHT)	  						and
														TRIM(pstate,LEFT,RIGHT) = TRIM(cstate,LEFT,RIGHT)             and
														TRIM(pzip5,LEFT,RIGHT) = TRIM(czip5,LEFT,RIGHT)               and
                            TRIM(prange,LEFT,RIGHT) = TRIM(crange,LEFT,RIGHT)  and
														TRIM(ppre,LEFT,RIGHT)   = TRIM(cpre,LEFT,RIGHT)    and
														TRIM(pstreet,LEFT,RIGHT) = TRIM(cstreet,LEFT,RIGHT) and
														TRIM(psuffix,LEFT,RIGHT) = TRIM(csuffix,LEFT,RIGHT) and
														TRIM(ppost,LEFT,RIGHT)  = TRIM(cpost,LEFT,RIGHT) and
                            TRIM(papt,LEFT,RIGHT) <> TRIM(capt,LEFT,RIGHT) and														
                            TRIM(pblock,LEFT,RIGHT) <> TRIM(cblock,LEFT,RIGHT),1,0))										 

,GeoBlocks_Changed:=sum(group,if(perror[1] = 'S' and cerror[1] = 'S' and
                         TRIM(pblock,LEFT,RIGHT) <> TRIM(cblock,LEFT,RIGHT),1,0))

},'',few);
t;

