export valid_counts(string var1) := module

cur := dataset('persist::watchdog_joined',Watchdog.Layout_Best_Marketing_Flag,flat);



cur1 := project(cur,transform(watchdog.Layout_Best,self := left));


prev := map ( var1 = 'glb' => watchdog.File_Best,
           var1 = 'nonglb' => Watchdog.File_Best_nonglb,
					 var1 = 'glb_nonen' => Watchdog.File_Best_nonExperian,
					 var1 = 'nonglb_noneq' => Watchdog.File_Best_nonglb_nonEquifax,
					 var1 = 'nonglb_nonutility' => Watchdog.File_Best_nonglb_nonutility,
					 var1 = 'nonutility' => Watchdog.File_Best_nonutility,
					 var1 = 'glb_nonen_noneq' => Watchdog.File_Best_nonEquifax_nonExperian,
					 var1 = 'glb_noneq' => Watchdog.File_Best_nonEquifax,
					 var1 = 'marketing' => Watchdog.File_Best_marketing,
					 var1 = 'marketing_noneq' => Watchdog.File_Best_marketing_nonEquifax);
					 
stat1RecFmt := RECORD
	run_date := cur1.run_date;
	SSN := COUNT(GROUP,cur1.SSN != '');
	Lname := COUNT(GROUP,cur1.lname != ''); 
	Fname := COUNT(GROUP,cur1.fname != ''); 
	Mname := COUNT(GROUP,cur1.mname != '');
	NmSuffix := COUNT(GROUP,cur1.name_suffix != '');
	Phone := COUNT(GROUP, cur1.phone != '');
	Prim_Range := COUNT(GROUP, cur1.prim_range != '');
	Predir := COUNT(GROUP, cur1.predir != '');
	Prim_name := COUNT(GROUP,cur1.prim_name != '');
	Suffix := COUNT(GROUP,cur1.suffix != '');
	Postdir := COUNT(GROUP,cur1.postdir != '');
	Unit_Desig := COUNT(GROUP,cur1.unit_desig != '');
	Sec_Range := COUNT(GROUP,cur1.sec_range != '');
	City_Name := COUNT(GROUP,cur1.city_name != '');
    State := COUNT(GROUP,cur1.st != '');
	Zip := COUNT(GROUP,cur1.zip != '');
	Zip4 := COUNT(GROUP,cur1.zip4 != '');
	DOB := COUNT(GROUP,cur1.dob != 0);
	DOD := COUNT(GROUP,cur1.dod != '');
	Prpt_Deed_ID := COUNT(GROUP,cur1.Prpty_Deed_ID != '');
	BK_CC_CaseNo := COUNT(GROUP,cur1.Bkrupt_CrtCode_CaseNo != '');
	Main_Count := COUNT(GROUP,cur1.main_count != 0);
	Search_Count := COUNT(GROUP,cur1.search_count != 0);
	VehicleNum := COUNT(GROUP,cur1.Vehicle_vehnum != '');
	DL_number := count(group,cur1.dl_number != '');
	Bdid := count(group,cur1.bdid != '');
END;

b := TABLE(cur1,stat1RecFmt,run_date,FEW);

stat3RecFmt := RECORD
	run_date := prev.run_date;
	SSN := COUNT(GROUP,prev.SSN != '');
	Lname := COUNT(GROUP,prev.lname != ''); 
	Fname := COUNT(GROUP,prev.fname != ''); 
	Mname := COUNT(GROUP,prev.mname != '');
	NmSuffix := COUNT(GROUP,prev.name_suffix != '');
	Phone := COUNT(GROUP, prev.phone != '');
	Prim_Range := COUNT(GROUP, prev.prim_range != '');
	Predir := COUNT(GROUP, prev.predir != '');
	Prim_name := COUNT(GROUP,prev.prim_name != '');
	Suffix := COUNT(GROUP,prev.suffix != '');
	Postdir := COUNT(GROUP,prev.postdir != '');
	Unit_Desig := COUNT(GROUP,prev.unit_desig != '');
	Sec_Range := COUNT(GROUP,prev.sec_range != '');
	City_Name := COUNT(GROUP,prev.city_name != '');
    State := COUNT(GROUP,prev.st != '');
	Zip := COUNT(GROUP,prev.zip != '');
	Zip4 := COUNT(GROUP,prev.zip4 != '');
	DOB := COUNT(GROUP,prev.dob != 0);
	DOD := COUNT(GROUP,prev.dod != '');
	Prpt_Deed_ID := COUNT(GROUP,prev.Prpty_Deed_ID != '');
	BK_CC_CaseNo := COUNT(GROUP,prev.Bkrupt_CrtCode_CaseNo != '');
	Main_Count := COUNT(GROUP,prev.main_count != 0);
	Search_Count := COUNT(GROUP,prev.search_count != 0);
	VehicleNum := COUNT(GROUP,prev.Vehicle_vehnum != '');
	DL_number := count(group,prev.dl_number != '');
	Bdid := count(group,prev.bdid != '');
END;


a := TABLE(prev,stat3RecFmt,run_date,FEW);

dappn :=  {( b[1].SSN - a[1].SSN) , 
              ( b[1].Phone - a[1].Phone),
                       (b[1].lname - a[1].lname) , 
											 ( b[1].fname - a[1].fname) , 
											 ( b[1].mname - a[1].mname) , 
											 ( b[1].NmSuffix - a[1].NmSuffix) , 
											 ( b[1].Prim_Range - a[1].Prim_Range) , 
											 ( b[1].Predir - a[1].Predir) , 
											 ( b[1].Prim_name - a[1].Prim_name) , 
											 ( b[1].Suffix - a[1].Suffix) , 
											 ( b[1].Postdir - a[1].Postdir) , 
											 ( b[1].Unit_Desig - a[1].Unit_Desig) , 
											 ( b[1].Sec_Range - a[1].Sec_Range) , 
											 ( b[1].City_Name - a[1].City_Name) , 
											 ( b[1].State - a[1].State) , 
											 ( b[1].Zip - a[1].Zip) , 
											 ( b[1].DOB - a[1].DOB) , 
											 ( b[1].DOD - a[1].DOD) } ;
											 
r := { string ssndiff_curr_minus_prev,string phonediff_curr_minus_prev,string lnamediff_curr_minus_prev,string fnamediff_curr_minus_prev, string mnamediff_curr_minus_prev, string NmSuffixdiff_curr_minus_prev , string Prim_Rangdiff_curr_minus_prev ,string Predirdiff_curr_minus_prev , string Prim_namediff_curr_minus_prev ,string Suffixdiff_curr_minus_prev ,string Postdir ,string Unit_Desig ,string Sec_Range ,string City_Name ,string State ,string Zip ,string DOBdiff_curr_minus_prev ,string DODdiff_curr_minus_prev };

setds := dataset( [dappn],r);
											 											 
drop_list := output(choosen(setds,all) ,,'~thor_data400::watchdog::stats'+var1,
											 CSV ( 
											 HEADING(SINGLE)
      ,SEPARATOR(','), TERMINATOR('\n')
			                    ),overwrite);
											 
											 
export out_all := Sequential(drop_list,if ( ((b[1].SSN/count(cur)) - (a[1].SSN/count(prev)))  < -1, Output( 'LNAME COUNTS DROP BY > 1% '),Output('VALID SSN COUNT')),                                                
if ( ((b[1].lname/count(cur)) - (a[1].lname/count(prev)))  < -1, Output( 'LNAME COUNTS DROP BY > 1% '),Output('VALID LNAME COUNT')) ,                                      
if ( (( b[1].fname/count(cur)) - (a[1].fname/count(prev))) < -1 , Output( 'FNAME COUNTS DROP BY > 1% '),Output('VALID FNAME COUNT')) ,                                
if ( ( (b[1].mname/count(cur)) - (a[1].mname/count(prev))) < -1 , Output( 'MNAME COUNTS DROP BY > 1% '),Output('VALID MNAME COUNT')) ,                                    
if ( (( b[1].NmSuffix/count(cur)) - (a[1].NmSuffix/count(prev))) < -1 , Output( 'NAME SUFFIX COUNTS DROP BY > 1% '),Output('VALID NAME SUFFIX COUNT')) ,               
if ( ( (b[1].Phone/count(cur)) -  (a[1].Phone/count(prev))) < -1 , Output( 'Phone COUNTS DROP BY > 1% '),Output('VALID Phone COUNT')) ,                                    
if ( ( (b[1].Prim_Range/count(cur)) - (a[1].Prim_Range/count(prev))) < -1 , Output( 'Prim_Range COUNTS DROP BY > 1% '),Output('VALID Prim_Range COUNT')) ,           
 if ( ( (b[1].Predir/count(cur))  - (a[1].Predir/count(prev))) < -1 , Output( 'Predir COUNTS DROP BY > 1% '),Output('VALID Predir COUNT')) ,                             
   if ( (( b[1].Prim_name/count(cur))  - (a[1].Prim_name/count(prev))) < -1 , Output( 'Prim_name COUNTS DROP BY > 1% '),Output('VALID Prim_name COUNT')) ,             
 if ( (( b[1].Suffix/count(cur))  - (a[1].Suffix/count(prev))) < -1 , Output( 'Suffix COUNTS DROP BY > 1% '),Output('VALID Suffix COUNT')) ,                             
   if ( (( b[1].Postdir/count(cur))  - (a[1].Postdir/count(prev))) < -1 , Output( 'Postdir COUNTS DROP BY > 1% '),Output('VALID Postdir COUNT')) ,                      
   if ( (( b[1].Unit_Desig/count(cur))  - (a[1].Unit_Desig /count(prev))) < -1 , Output( 'Unit_Desig COUNTS DROP BY > 1% '),Output('VALID Unit_Desig COUNT')) ,       
if ( ( (b[1].Sec_Range/count(cur))  - (a[1].Sec_Range/count(prev))) < -1 , Output( 'Sec_Range COUNTS DROP BY > 1% '),Output('VALID Sec_Range COUNT') ),                
if ( ( (b[1].City_Name/count(cur))  - (a[1].City_Name/count(prev))) < -1 , Output( 'FNAME COUNTS DROP BY > 1% '),Output('VALID FNAME COUNT')) ,                       
if ( ( (b[1].State/count(cur))  - (a[1].State/count(prev))) < -1 , Output( 'State COUNTS DROP BY > 1% '),Output('VALID State COUNT')) ,                                   
if ( ( (b[1].Zip/count(cur))  - (a[1].Zip/count(prev))) < -1 , Output( 'Zip COUNTS DROP BY > 1% '),Output('VALID Zip COUNT') ),                                             
if ( ( (b[1].Zip4/count(cur)) - (a[1].Zip4/count(prev))) < -1 , Output( 'Zip4 COUNTS DROP BY > 1% '),Output('VALID Zip4 COUNT')) ,                                          
if ( ( (b[1].DOB/count(cur)) - (a[1].DOB/count(prev))) < -1 , Output( 'DOB COUNTS DROP BY > 1% '),Output('VALID DOB COUNT')) ,                                              
if ( ( (b[1].DOD/count(cur)) - (a[1].DOD/count(prev))) < -1 , Output( 'DOD COUNTS DROP BY > 1% '),Output('VALID DOD COUNT')) ,                                               
if ( ( (b[1].Prpt_Deed_ID/count(cur)) - (a[1].Prpt_Deed_ID/count(prev))) < -1 , Output( 'Prpt_Deed_ID COUNTS DROP BY > 1% '),Output('VALID FNAME COUNT')) ,        
if ( ( (b[1].BK_CC_CaseNo/count(cur))  - (a[1].BK_CC_CaseNo/count(prev))) < -1 , Output( 'BK_CC_CaseNo COUNTS DROP BY > 1% '),Output('VALID FNAME COUNT') ),       
if ( ( (b[1].Main_Count/count(cur)) - (a[1].Main_Count/count(prev))) < -1 , Output( 'Main_Count COUNTS DROP BY > 1% '),Output('VALID Main_Count FNAME COUNT') ),           
if ( (( b[1].Search_Count/count(cur))  - (a[1].Search_Count/count(prev))) < -1 , Output( 'Search_Count COUNTS DROP BY > 1% '),Output('VALID Search_Count COUNT')) ,
if ( (( b[1].VehicleNum/count(cur))  - (a[1].VehicleNum/count(prev))) < -1 , Output( 'VehicleNum COUNTS DROP BY > 1% '),Output('VALID VehicleNum COUNT') ),           
if ( (( b[1].DL_number/count(cur)) - (a[1].DL_number/count(prev))) < -1 , Output( 'DL_number COUNTS DROP BY > 1% '),Output('VALID DL_number COUNT') ),                
 if ( ( (b[1].Bdid/count(cur))  - (a[1].Bdid/count(prev))) < -1 , Output( 'Bdid COUNTS DROP BY > 1% '),Output('VALID Bdid COUNT') ));                                       


end;