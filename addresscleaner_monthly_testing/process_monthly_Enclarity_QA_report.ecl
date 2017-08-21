import addresscleaner_monthly_testing;

#workunit('protect',true);
#workunit('name','Enclarity AddressCleaner Process QA Data ' +  addresscleaner_monthly_testing.version);
//#option ('activitiesPerCpp', 50);
//#option('AllowedClusters','thor400_30,thor400_20,thor400_92');
#OPTION('multiplePersistInstances',FALSE);
//#option('AllowAutoSwitchQueue','1');

inRec :=RECORD
string line1; 
string line2;     
string prange;
string ppre;
string pprim_name;
string psuffix;
string ppost;
string punit;
string psec_range;
string pcity;
string pvanity;
string pstate;
string pzip5;
string pzip4;
string pcart;
string psort;
string plot;
string porder;
string pdpbc;
string pchk;
string ptype;
string pfips_state;
string pfips_county;
string prural_rt_no;
string ppobox;
string psec_addr;
string prdi;
string paddr1_remainder;
string paddr1_extra1;
string paddr1_extra2;
string paddr1_extra3;
string paddr1_extra4;
string paddr1_extra5;
string paddr1_extra6;
string paddr1_extra7;
string paddr1_extra8;
string paddr1_extra9;
string paddr1_extra10;
string paddr2;
string paddr2_unit_no;
string paddr2_non_postal;
string paddr2_postal_type;
string pnon_postal_unit;
string pnon_postal_unit_nbr;
string prural_box_nbr;
string plat;
string plong;
string pmsa;
string pblock;
string pmatch;
string perror;
string crange;
string cpre;
string cprim_name;
string csuffix;
string cpost;
string cunit;
string csec_range;
string ccity;
string cvanity;
string cstate;
string czip5;
string czip4;
string ccart;
string csort;
string clot;
string corder;
string cdpbc;
string cchk;
string ctype;
string cfips_state;
string cfips_county;
string crural_rt_no;
string cpobox;
string csec_addr;
string crdi;
string caddr1_remainder;
string caddr1_extra1;
string caddr1_extra2;
string caddr1_extra3;
string caddr1_extra4;
string caddr1_extra5;
string caddr1_extra6;
string caddr1_extra7;
string caddr1_extra8;
string caddr1_extra9;
string caddr1_extra10;
string caddr2;
string caddr2_unit_no;
string caddr2_non_postal;
string caddr2_postal_type;
string cnon_postal_unit;
string cnon_postal_unit_nbr;
string crural_box_nbr;
string clat;
string clong;
string cmsa;
string cblock;
string cmatch;
string cerror;
END;	
	
d := DATASET('~thor400_data::addresscleaner::enclarity::monthly::processed',inRec,flat);							

d1 := d(perror[1] = 'E' and cerror[1] =  'E');
OUTPUT(distribute(choosen(d1,1000)),all,NAMED('Failed_Both'));
d2 := d(perror[1] = 'E' and cerror[1] = 'S');
output(distribute(choosen(d2,1000)),all,NAMED('Failed_Prod'));
d3 := d(perror[1] = 'S' and cerror[1] = 'E');
output(distribute(choosen(d3,1000)),all,NAMED('Failed_Cert'));
d4 := d(perror[1] = 'S' and cerror[1] = 'S');
output(distribute(choosen(d4,1000)),all,NAMED('Passed_Both'));
d5 := d(perror[1] = '' or cerror[1] = '');
output(distribute(choosen(d5,100)),all,NAMED('Passed_Both'));

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
,Records_Empty:=sum(group,if(perror[1] = '' or cerror[1] ='',1,0))

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
														TRIM(pprim_name,LEFT,RIGHT) <> TRIM(cprim_name,LEFT,RIGHT) or
														TRIM(psuffix,LEFT,RIGHT) <> TRIM(csuffix,LEFT,RIGHT) or
														TRIM(ppost,LEFT,RIGHT)  <> TRIM(cpost,LEFT,RIGHT),1,0))
														
,Apartments_Changed:=sum(group,if(perror[1] = 'S' and cerror[1] = 'S' and
                     TRIM(punit,LEFT,RIGHT) <> TRIM(cunit,LEFT,RIGHT),1,0))

										 
,Other_Elements_Changed:=sum(group,if(perror[1] = 'S' and cerror[1] = 'S' and
                         		TRIM(pcity,LEFT,RIGHT) = TRIM(ccity,LEFT,RIGHT)	  						and
														TRIM(pstate,LEFT,RIGHT) = TRIM(cstate,LEFT,RIGHT)             and
														TRIM(pzip5,LEFT,RIGHT) = TRIM(czip5,LEFT,RIGHT)         and
                            TRIM(prange,LEFT,RIGHT) = TRIM(crange,LEFT,RIGHT)  and
														TRIM(ppre,LEFT,RIGHT)   = TRIM(cpre,LEFT,RIGHT)    and
														TRIM(psuffix,LEFT,RIGHT) = TRIM(csuffix,LEFT,RIGHT) and
														TRIM(ppost,LEFT,RIGHT)  = TRIM(cpost,LEFT,RIGHT) and
                            TRIM(psec_range,LEFT,RIGHT) <> TRIM(csec_range,LEFT,RIGHT) and														
                            TRIM(pblock,LEFT,RIGHT) <> TRIM(cblock,LEFT,RIGHT),1,0))										 

,GeoBlocks_Changed:=sum(group,if(perror[1] = 'S' and cerror[1] = 'S' and
                         TRIM(pblock,LEFT,RIGHT) <> TRIM(cblock,LEFT,RIGHT),1,0))

},'',few);
t;

