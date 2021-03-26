/*2017-05-24T18:45:57Z (Srilatha Katukuri)
ECH-4987 - Production bug Fix - to account for Suppressed TF reports

*/
/*2016-11-22T21:12:32Z (Srilatha Katukuri)
Bug DF-17970 - Drop in Supplemental records
*/
/*2016-06-10T06:03:31Z (Srilatha Katukuri)
DFF-16695 Final Check in
*/
/*2016-06-07T19:54:14Z (Srilatha Katukuri)
DFF- 16695 - Coplogic DataIngestion2
*/
/*2016-03-04T02:36:53Z (Srilatha Katukuri)
Ã¢â‚¬â€œ Bug: 201048  -- fixed the page count issue for supplemetal reports
*/
/*2015-10-13T00:45:04Z (Srilatha Katukuri)
#181860 - accesing agency QC file
*/
/*2015-08-28T16:26:54Z (Srilatha Katukuri)
#181860 PRUS
*/
/*2015-08-28T16:24:57Z (Srilatha Katukuri)
#187626 
*/
/*2015-08-14T19:24:32Z (Srilatha Katukuri)
#181860 PRUS
*/
/*2015-08-07T23:48:43Z (Srilatha Katukuri)
#181860 - PRUS
*/
/*2015-05-15T19:55:59Z (Srilatha Katukuri)
Bug# 180852 - PIR 4710 Coplogic Data ingestion
*/
 
IMPORT STD; 
  agency := Infiles.dAgency;
  tpersn := DEDUP(Infiles.tpersn, ALL, LOCAL);  
  tvehicl := DEDUP(Infiles.tvehicl, ALL, LOCAL);  
  tIncident := IncidentsAfterSuppression;
  
  //keep all incidents and flag updated or duplicate version of reports
  dincident_EA :=  DEDUP(SORT(DISTRIBUTE(
                                        tincident(work_type_id not in ['2','3']), HASH32(agency_id, contrib_source))
                             ,incident_id,Sent_to_HPCC_DateTime,creation_date,report_id, LOCAL)
                        ,incident_id, RIGHT, LOCAL
                        );
  dincidentCombined := dincident_EA;
  
  //------------------------------------------------------------------------------------------------------------------              
  tincident trecs0(tincident L, agency R) := TRANSFORM
    agency_source_matching := L.agency_id = R.agency_id AND L.Contrib_Source = R.Source_Id;
    SELF.agency_name := IF(agency_source_matching, R.Agency_Name, L.Agency_Name);
    IsAgencyActive := Functions.IsActiveDate(mod_Utilities.SysDate, R.Source_Start_Date, R.Source_Termination_Date);
    SELF.is_terminated_agency := IF(agency_source_matching, ~IsAgencyActive, TRUE); 
    SELF := L;
  END;  
  jrecs0 := DISTRIBUTE(JOIN(dincidentCombined,agency,
                            LEFT.agency_id = RIGHT.agency_id AND 
                            LEFT.contrib_source = RIGHT.source_id,
                            trecs0(LEFT,RIGHT), LOOKUP), HASH32(incident_id));
                            
  filtered_jrecs0 := jrecs0(is_terminated_agency = FALSE);
  
  //------------------------------------------------------------------------------------------------------------------                
  Layout_Infiles_Fixed.cmbnd  trecs1(filtered_jrecs0 L, tvehicl R) := TRANSFORM
    SELF.incident_id := L.incident_id;
    SELF.creation_date := L.creation_date;
    SELF.Avoidance_Maneuver2 := R.Avoidance_Maneuver2;
    SELF.Avoidance_Maneuver3 := R.Avoidance_Maneuver3;
    SELF.Avoidance_Maneuver4 := R.Avoidance_Maneuver4;
    SELF.Damaged_Areas_Severity1 := R.Damaged_Areas_Severity1 ;
    SELF.Damaged_Areas_Severity2 := R.Damaged_Areas_Severity2;
    SELF.Vehicle_Outside_City_Indicator := R.Vehicle_Outside_City_Indicator ;
    SELF.Vehicle_Outside_City_Distance_Miles := R.Vehicle_Outside_City_Distance_Miles;
    SELF.Vehicle_Outside_City_Direction := R.Vehicle_Outside_City_Direction;
    SELF.Vehicle_Crash_Cityplace := R.Vehicle_Crash_Cityplace;
    SELF.Insurance_Company_Standardized := R.Insurance_Company_Standardized;
    SELF.number_of_lanes := IF(l.number_of_lanes NOT IN ['','NULL'], l.number_of_lanes, r.number_of_lanes); 
    SELF.divided_highway := IF(l.divided_highway NOT IN ['','NULL'], l.divided_highway, r.divided_highway);
    SELF.speed_limit_posted := IF(l.speed_limit_posted  NOT IN ['','NULL'], l.speed_limit_posted , r.speed_limit_posted );
    SELF := R;
    SELF := L;
    SELF := [];
  END;  
  jrecs1 := JOIN(filtered_jrecs0,  
                 SORT(DEDUP(SORT(DISTRIBUTE(tvehicl(incident_id <> ''), HASH32(incident_id))
                          ,vin,incident_id,unit_number,creation_date, LOCAL)
                          ,vin,incident_id,unit_number,RIGHT, LOCAL)
                          ,incident_id, LOCAL),
                          LEFT.incident_id = RIGHT.incident_id,
                          trecs1(LEFT,RIGHT),LEFT OUTER, LOCAL
                );  
                        
  d_person := DEDUP(
                    SORT(
                         DISTRIBUTE(tpersn(incident_id<>''), HASH32(incident_id)),
                          incident_id,vehicle_unit_number,last_name,first_name,date_of_birth,address,city,state,zip_code,home_phone, MAP(REGEXFIND('DRIVER|VEHICLE DRIVER|VEHICLEDRIVER' , person_type) => 3
                                                                                                                                        ,REGEXFIND('OWNER|VEHICLE OWNER|VEHICLEOWNER' , person_type) => 2,1),creation_date, LOCAL)
                         ,incident_id,vehicle_unit_number,last_name,first_name,date_of_birth,address,city,state,zip_code, RIGHT, LOCAL); 
                         
  //------------------------------------------------------------------------------------------------------------------
  Layout_Infiles_Fixed.cmbnd  trecs2(jrecs1 L, tpersn R) := TRANSFORM    
    SELF.incident_id := L.incident_id;
    SELF.creation_date := L.creation_date;
    SELF.law_enforcement_suspects_alcohol_use1 := R.law_enforcement_suspects_alcohol_use1;
    SELF.law_enforcement_suspects_drug_use1 := R.law_enforcement_suspects_drug_use1 ;
    SELF.First_Aid_By := L.First_Aid_By; 
    SELF.Person_First_Aid_Party_Type := l.Person_First_Aid_Party_Type ; 
    SELF.Person_First_Aid_Party_Type_Description := l.Person_First_Aid_Party_Type_Description;
    SELF.Insurance_Expiration_Date := l.Insurance_Expiration_Date;
    SELF.Insurance_Policy_Number := l.Insurance_Policy_Number;
    SELF.Insurance_Company := l.Insurance_Company;
    SELF.Insurance_Company_Phone_Number := l.Insurance_Company_Phone_Number ; 
    SELF.Insurance_Effective_Date := l.Insurance_Effective_Date;
    SELF.Proof_of_Insurance := l.Proof_of_Insurance; 
    SELF.Insurance_Expired := l.Insurance_Expired; 
    SELF.Insurance_Exempt := l.Insurance_Exempt; 
    SELF.Insurance_Type := l.Insurance_Type; 
    SELF.Insurance_Company_Code := l.Insurance_Company_Code; 
    SELF := R;
    SELF := L;
    SELF := [];
  END;
  jrecs2 := JOIN(jrecs1(Unit_Number <> '0' AND Unit_Number <> ''), d_person,
                 LEFT.incident_id = RIGHT.incident_id AND 
                 LEFT.Unit_Number = RIGHT.vehicle_Unit_Number ,
                 trecs2(LEFT, RIGHT), LEFT OUTER, LOCAL);
								 
  jrecsOthers := jrecs1(Unit_Number = '0' OR Unit_Number = '');    
  
  // get person records by only incident_id when no vehcile records found 
  jrecsOthersPerson := JOIN(jrecsOthers, d_person,
                            LEFT.incident_id = RIGHT.incident_id , 
                            trecs2(LEFT,RIGHT),LEFT OUTER, LOCAL);  
  
  //get person record that have 0 vehicle or if one or more recs in same incident have veh//like witness , property owner etc..
  Jperson := JOIN(filtered_jrecs0, d_person( vehicle_Unit_Number in ['','0','NUL','NULL']),
                  LEFT.incident_id = RIGHT.incident_id ,
                  TRANSFORM(Layout_Infiles_Fixed.cmbnd, SELF := LEFT, SELF:= RIGHT, SELF:=[]), LOCAL);
  allrecs := DEDUP(SORT(DISTRIBUTE(jrecs2 + jrecsOthersPerson + Jperson, HASH32(incident_id)), RECORD, LOCAL), RECORD, LOCAL) ;          
  
  // Suppress DE Reports with Flag value 0 in agency file.
  suppressAgencies := DISTRIBUTED(Infiles.agency(drivers_exchange_flag ='0'), HASH32(agency_id));
  uSuppressAgencies := DEDUP(SORT(suppressAgencies, Agency_id, LOCAL), Agency_id, LOCAL);
  
  updtdAllrecs:= JOIN(allrecs, uSuppressAgencies,
                      TRIM(LEFT.agency_id,LEFT,RIGHT) = TRIM(RIGHT.agency_id,LEFT,RIGHT) AND 
                      TRIM(LEFT.report_type_id,LEFT,RIGHT) = 'DE',
                      MANY LOOKUP, LEFT ONLY);            
  // Supress reports
  allrecs0 := updtdAllrecs(~(TRIM(case_identifier,LEFT,RIGHT) IN  Suppress_Id AND source_id in ['EA', 'TF'])); 
  allrecsSupressed1 := allrecs0(TRIM(report_id,LEFT,RIGHT) NOT IN Suppress_report_d);
  
  allrecsSupressed  := JOIN(allrecsSupressed1 (incident_id NOT IN supress_incident_id), Files_eCrash.DS_BASE_ECRASH_DELETES, 
                           TRIM(LEFT.case_identifier,LEFT,RIGHT) = TRIM(RIGHT.case_identifier,LEFT,RIGHT) AND 
                           TRIM(LEFT.State_Report_Number,LEFT,RIGHT) = TRIM(RIGHT.State_Report_Number,LEFT,RIGHT) AND 
                           TRIM(LEFT.Source_ID ,LEFT,RIGHT) = TRIM(RIGHT.Source_ID ,LEFT,RIGHT)AND 
                           TRIM(LEFT.Loss_State_Abbr,LEFT,RIGHT) = TRIM(RIGHT.Loss_State_Abbr,LEFT,RIGHT) AND 
                           STD.Str.FilterOut(TRIM(RIGHT.Crash_Date,LEFT,RIGHT),'-') = STD.Str.FilterOut(TRIM(RIGHT.Crash_Date,LEFT,RIGHT),'-') AND 
                           TRIM(LEFT.Agency_ID,LEFT,RIGHT) = TRIM(RIGHT.Agency_ID,LEFT,RIGHT) AND 
                           TRIM(LEFT.Work_Type_ID ,LEFT,RIGHT) = TRIM(RIGHT.Work_Type_ID,LEFT,RIGHT) /*AND 
                           TRIM(LEFT.report_Type_ID ,LEFT,RIGHT) = TRIM(RIGHT.report_Type_ID,LEFT,RIGHT)*/, MANY LOOKUP , LEFT ONLY ); 
  
  
  tref0 := PROJECT(allrecsSupressed, TRANSFORM(FLAccidents_Ecrash.Layouts.slim_layout,
    SELF.loss_street := STD.Str.CleanSpaces(IF(TRIM(LEFT.loss_street,LEFT,RIGHT) ='NULL', '', TRIM(LEFT.loss_street,LEFT,RIGHT)));
    SELF.loss_cross_street := STD.Str.CleanSpaces(IF(TRIM(LEFT.loss_cross_street,LEFT,RIGHT) ='NULL', '', TRIM(LEFT.loss_cross_street,LEFT,RIGHT)));
    SELF.hash_key := STD.Str.CleanSpaces(IF(TRIM(LEFT.hash_key,LEFT,RIGHT) ='NULL', '', TRIM(LEFT.hash_key,LEFT,RIGHT)));
    SELF.last_name := STD.Str.CleanSpaces(IF(TRIM(LEFT.last_name,LEFT,RIGHT) ='NULL', '', TRIM(LEFT.last_name,LEFT,RIGHT)));
    SELF.first_name := STD.Str.CleanSpaces(IF(TRIM(LEFT.first_name,LEFT,RIGHT) ='NULL', '', TRIM(LEFT.first_name,LEFT,RIGHT)));
    SELF.middle_name := STD.Str.CleanSpaces(IF(TRIM(LEFT.middle_name,LEFT,RIGHT) ='NULL', '', TRIM(LEFT.middle_name,LEFT,RIGHT)));
    SELF.address := STD.Str.CleanSpaces(IF(TRIM(LEFT.address ,LEFT,RIGHT) ='NULL', '', TRIM(LEFT.address,LEFT,RIGHT)));
    SELF.city := STD.Str.CleanSpaces(IF(TRIM(LEFT.city,LEFT,RIGHT) ='NULL', '', TRIM(LEFT.city,LEFT,RIGHT)));
    SELF.state := STD.Str.CleanSpaces(IF(TRIM(LEFT.state,LEFT,RIGHT) ='NU', '', TRIM(LEFT.state,LEFT,RIGHT)));
    SELF.zip_code := STD.Str.CleanSpaces(IF(TRIM(LEFT.zip_code,LEFT,RIGHT) ='NULL', '', TRIM(LEFT.zip_code,LEFT,RIGHT)));
    SELF.Drivers_License_Number := STD.Str.CleanSpaces(IF(TRIM(LEFT.Drivers_License_Number,LEFT,RIGHT) ='NULL', '', TRIM(LEFT.Drivers_License_Number,LEFT,RIGHT)));
    SELF.License_Plate := STD.Str.CleanSpaces(IF(TRIM(LEFT.License_Plate,LEFT,RIGHT) ='NULL', '', TRIM(LEFT.License_Plate,LEFT,RIGHT)));
    SELF.vin := STD.Str.CleanSpaces(IF(TRIM(LEFT.vin ,LEFT,RIGHT) ='NULL', '', TRIM(LEFT.vin,LEFT,RIGHT))); 
    SELF.Make := STD.Str.CleanSpaces(IF(TRIM(LEFT.Make,LEFT,RIGHT) ='NULL', '', TRIM(LEFT.Make,LEFT,RIGHT)));
    SELF.Model_Yr := STD.Str.CleanSpaces(IF(TRIM(LEFT.Model_Yr,LEFT,RIGHT) ='NULL', '', TRIM(LEFT.Model_Yr,LEFT,RIGHT)));
    SELF.Model := STD.Str.CleanSpaces(IF(TRIM(LEFT.Model,LEFT,RIGHT) ='NULL', '', TRIM(LEFT.Model,LEFT,RIGHT)));    
    // Map TF rules in EA AND use same logic  overwriting case_id AND crash date  
    SELF.case_identifier := IF(LEFT.source_id in ['TF','TM'],LEFT.state_report_number, LEFT.case_identifier);
    SELF.crash_date := IF(LEFT.source_id in ['TF','TM'],'',STD.Str.FilterOut(TRIM(LEFT.crash_date,LEFT,RIGHT),'-'));
    SELF.source_id := IF(LEFT.source_id in ['TF','TM'],'TF','EA');
    // should match with payload key 
    SELF.report_code := LEFT.source_id;
    SELF.accident_date := STD.Str.FilterOut(TRIM(LEFT.crash_date,LEFT,RIGHT),'-');
     t_accident_nbr := IF(LEFT.source_id in ['TF','TM'],LEFT.state_report_number, LEFT.case_identifier);
     t_scrub := STD.Str.Filter(t_accident_nbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
    SELF.accident_nbr := IF(t_scrub in ['UNK', 'UNKNOWN'], 'UNK'+LEFT.incident_id,t_scrub);  
    SELF.orig_accnbr := t_accident_nbr; 
    SELF.addl_report_number := IF(LEFT.source_id in ['TF','TM'],LEFT.case_identifier,LEFT.state_report_number);
    SELF.orig_case_identifier := IF(TRIM(LEFT.case_identifier,LEFT,RIGHT) = 'NULL', '',  LEFT.case_identifier); 
    SELF.orig_state_report_number := IF(TRIM(LEFT.state_report_number,LEFT,RIGHT) = 'NULL', '',  LEFT.state_report_number);
    SELF.Page_Count :=  LEFT.Page_Count;  
    SELF := LEFT )):PERSIST('~thor_data400::ecrash_incident_combined');
		
    tref := tref0 : INDEPENDENT;
		
  // Filter out TM's IF TM came in accidently after TF.. All the TM's after TF are invalid.  
    IyetekFull := DISTRIBUTE(tref (report_code = 'TF'), HASH32(State_Report_Number));
    IyetekMeta := DISTRIBUTE(tref (report_code = 'TM'), HASH32(state_report_number));
  
    jdropMetadata := JOIN( IyetekMeta,IyetekFull, LEFT.state_report_number = RIGHT.State_Report_Number AND 
                                          LEFT.ORI_Number = RIGHT.ORI_Number AND 
                                          LEFT.loss_state_abbr = RIGHT.loss_state_abbr AND 
                                          LEFT.report_type_id  = RIGHT.report_type_id AND 
                                          //LEFT.creation_date >= RIGHT.creation_date,
                                          LEFT.Sent_to_HPCC_DateTime >= RIGHT.Sent_to_HPCC_DateTime,
                                          TRANSFORM({IyetekMeta}, SELF := LEFT),LEFT ONLY  , LOCAL) + tref(report_code <>'TM');
                                          
    t_sort := SORT(jdropMetadata,case_identifier,agency_id,loss_state_abbr,report_type_id,crash_date,source_id,-creation_date,-Sent_to_HPCC_DateTime,incident_id,last_name , first_name, middle_name, address,city,state,zip_code,
                   Drivers_License_Number,License_Plate,vin,Make,Model_Yr,Model,hash_key,loss_street,loss_cross_street);
  
  t_sort t(t_sort L, t_sort R) := TRANSFORM  
    SELF.last_name := l.last_name  + r.last_name  ; 
    SELF.first_name := l.first_name + r.first_name ; 
    SELF.middle_name := l.middle_name + r.middle_name ; 
    SELF.address := l.address + r.address; 
    SELF.city := l.city + r.city ;
    SELF.state := l.state + r.state ; 
    SELF.zip_code := l.zip_code + r.zip_code ; 
    SELF.Drivers_License_Number := l.Drivers_License_Number + r.Drivers_License_Number ;
    SELF.License_Plate := l.License_Plate + r.License_Plate; 
    SELF.vin := l.vin + r.vin ;
    SELF.Make := l.make + r.make; 
    SELF.Model_Yr := l.Model_Yr + r.Model_Yr; 
    SELF.Model := l.Model + r.Model; 
    SELF := l;
  END;  
  troll := ROLLUP(t_sort, LEFT.incident_id = RIGHT.incident_id, t(LEFT, RIGHT));
  
  grp_coplogic := GROUP(SORT(troll(TRIM(vendor_code, LEFT,RIGHT) = 'COPLOGIC'),
                             case_identifier,agency_id,loss_state_abbr,crash_date,Supplemental_report
                             ),
                        case_identifier,agency_id,loss_state_abbr,crash_date
                        );
  
  grp_coplogic coplogic(grp_coplogic l, grp_coplogic r) := TRANSFORM                                        
    Suppmental_flag := MAP(l.incident_id = '' => '',
                           TRIM(r.Supplemental_Report, LEFT, RIGHT) = '1' => 'U',
                           TRIM(r.Supplemental_Report, LEFT, RIGHT) in ['0',''] => 'D', 
                          'D');                                      
    SELF.U_D_flag := Suppmental_flag;                              
    SELF.changed_hashkey := Suppmental_flag;
    SELF.changed_data_lev1 := Suppmental_flag;
    SELF := r;
  END;
  ds_coplogic := ITERATE(grp_coplogic,coplogic(LEFT,RIGHT));
  
  grp := GROUP(SORT(troll(TRIM(vendor_code, LEFT,RIGHT) <> 'COPLOGIC'),
                    case_identifier,agency_id,loss_state_abbr,report_type_id,crash_date,source_id
                   ),
              case_identifier,agency_id,loss_state_abbr,report_type_id,crash_date,source_id
              );
  
  // set a flag if Dupe or update 
  grp aflag(grp l, grp r) := TRANSFORM  
    tchanged_hashkey := IF(l.hash_key <> r.hash_key ,'Y','N'); 
    tchanged_data_lev1 := IF((l.loss_street <>  r.loss_street OR
                              l.loss_cross_street <>  r.loss_cross_street OR
                              l.last_name <>  r.last_name OR 
                              l.first_name <>  r.first_name OR          
                              l.middle_name <>  r.middle_name OR         
                              l.address <> r.address OR      
                              l.city <> r.city OR      
                              l.state <> r.state OR        
                              l.zip_code <> r.zip_code OR          
                              l.Drivers_License_Number <> r.Drivers_License_Number OR
                              l.License_Plate <> r.License_Plate OR
                              l.vin <> r.vin OR 
                              l.Make <> r.Make OR 
                              l.Model_Yr <> r.Model_Yr OR         
                              l.Model <> r.Model ), 'Y', 'N');  
    SELF.U_D_flag := IF( l.incident_id = '' , '', IF(tchanged_hashkey= 'Y' AND tchanged_data_lev1 ='Y' ,'U' , 'D')); 
    SELF.changed_hashkey := tchanged_hashkey;
    SELF.changed_data_lev1 := tchanged_data_lev1;
    SELF := r;
  END;
  ds_other := ITERATE(grp,aflag(LEFT,RIGHT));
  //compare_add := ds_coplogic + ds_other;
    
    //Coplogic Reports
  tincident_c  := SORT(DISTRIBUTE(PROJECT(ds_coplogic,TRANSFORM(FLAccidents_Ecrash.Layouts.ReportVersionNested,                           
                            SELF.hash_ :=   DATASET([{LEFT.Creation_Date,LEFT.Incident_ID,LEFT.Report_ID,LEFT.Hash_Key,LEFT.U_D_flag,LEFT.Sent_to_HPCC_DateTime,LEFT.report_code,LEFT.page_count,LEFT.Supplemental_report, LEFT.report_type_id}],{FLAccidents_Ecrash.Layouts.l_hash});
                            SELF.super_report_id := LEFT.Report_ID;
                            SELF:= LEFT)), HASH32(case_identifier)), case_identifier,agency_id,loss_state_abbr,crash_date,source_id, -Sent_to_HPCC_DateTime,-creation_date, LOCAL);                      
  
  tincident_c tmakechildren_c(tincident_c L, tincident_c R) := TRANSFORM  
    SELF.hash_ :=  L.hash_&R.hash_;
    //SELF.super_report_ID :=  IF((INTEGER)L.super_Report_ID < (INTEGER)R.super_Report_ID,l.super_Report_ID,r.super_Report_ID);
    SELF.super_report_ID :=  IF(L.U_D_Flag = '',l.super_Report_ID,r.super_Report_ID);
    SELF := L;
  END;
  //Non Coplogic reports
  tincident_other  := SORT(DISTRIBUTE(PROJECT(ds_other,TRANSFORM(FLAccidents_Ecrash.Layouts.ReportVersionNested,
                            SELF.hash_ :=   DATASET([{LEFT.Creation_Date,LEFT.Incident_ID,LEFT.Report_ID,LEFT.Hash_Key,LEFT.U_D_flag,LEFT.Sent_to_HPCC_DateTime,LEFT.report_code,LEFT.page_count,LEFT.Supplemental_report, LEFT.report_type_id}],{FLAccidents_Ecrash.Layouts.l_hash});
                            SELF.super_report_id := LEFT.Report_ID;
                            SELF:= LEFT)) , HASH32(case_identifier)), case_identifier,agency_id,loss_state_abbr,report_type_id,crash_date,source_id, -Sent_to_HPCC_DateTime,-creation_date, LOCAL);                      
  
  tincident_other tmakechildren_other(tincident_other L, tincident_other R) := TRANSFORM
    SELF.hash_ :=  L.hash_&R.hash_;
    SELF.super_report_ID := IF((INTEGER)L.super_Report_ID < (INTEGER)R.super_Report_ID,l.super_Report_ID,r.super_Report_ID);
    SELF := L;
  END;
  drollup_report_versionkey_c := ROLLUP(tincident_c,case_identifier+agency_id+loss_state_abbr+crash_date+source_id, tmakechildren_c(LEFT, RIGHT), LOCAL):PERSIST('~thor_data400::EA_report_version_Coplogic');
	
  drollup_report_versionkey_other := ROLLUP(tincident_other,case_identifier+agency_id+loss_state_abbr+report_type_id+crash_date+source_id, tmakechildren_other(LEFT, RIGHT), LOCAL):PERSIST('~thor_data400::EA_report_version');
        
  // Add Coplogic and other reports
  cmbnd_drollup_report_versionkey := drollup_report_versionkey_c + drollup_report_versionkey_other;
	
  //Normalize hashes
  hashTable := TABLE(cmbnd_drollup_report_versionkey, 
                     {INTEGER hashCount := COUNT(hash_), 
                     cmbnd_drollup_report_versionkey});
  
  FLAccidents_Ecrash.Layouts.ReportVersion gethash(hashTable l, INTEGER c):= TRANSFORM      
    SELF := l.hash_[c];
    SELF.super_report_id := l.super_report_id;
    SELF.jurisdiction := IF(STD.Str.ToUpperCase(TRIM(L.agency_name,LEFT,RIGHT))='NULL','',STD.Str.ToUpperCase(L.agency_name));
    SELF.orig_accnbr := IF(STD.Str.ToUpperCase(TRIM(L.orig_accnbr,LEFT,RIGHT))='NULL','',STD.Str.ToUpperCase(L.orig_accnbr));
    SELF.addl_report_number := IF(STD.Str.ToUpperCase(TRIM(L.addl_report_number,LEFT,RIGHT))='NULL','',STD.Str.ToUpperCase(L.addl_report_number));
    SELF.jurisdiction_state := IF(STD.Str.ToUpperCase(TRIM(L.loss_state_abbr,LEFT,RIGHT))='NULL','',STD.Str.ToUpperCase(L.loss_state_abbr));
    SELF.work_type_id := IF(STD.Str.ToUpperCase(TRIM(L.work_type_id,LEFT,RIGHT))='NULL','',STD.Str.ToUpperCase(L.work_type_id));
    SELF.agency_ori := IF(STD.Str.ToUpperCase(TRIM(L.ori_number,LEFT,RIGHT))='NULL','',STD.Str.ToUpperCase(L.ori_number));
    SELF.super_report_id_orig := l.super_report_id;
    SELF:= l;
    SELF:= [];
  END;  
  hash_key :=  NORMALIZE(hashTable, LEFT.hashCount, gethash(LEFT, COUNTER)) ;

  // assign new super id accross the sources
  get_new := GROUP(SORT(hash_key,orig_case_identifier,orig_state_report_number,jurisdiction,jurisdiction_state,report_type_id,accident_date,super_report_id,-Sent_to_HPCC_DateTime,-creation_date  ),orig_case_identifier,orig_state_report_number,jurisdiction,jurisdiction_state,report_type_id,accident_date);
  get_new tflag(get_new l, get_new r) := TRANSFORM  
    SELF.super_report_id := IF((INTEGER)l.super_report_id  <> 0 AND (INTEGER)l.super_report_id < (INTEGER)r.super_report_id,l.super_report_id,r.super_report_id);
    SELF := r;
  END;
EXPORT Map_eCrashAccidents_To_SupplementalBase := ITERATE(get_new,tflag(LEFT,RIGHT));
  