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
  Agency := Infiles.agency;
  dAgency := Infiles.dAgency;
  tIncident := IncidentsAfterSuppression;  
  uVehicl := Infiles.uVehicl;  
  uPerson := Infiles.uPerson;
  
// ###########################################################################
// Keep all incidents and flag updated or duplicate version of reports
// ###########################################################################
  dIncident_EA := DISTRIBUTE(tincident(work_type_id NOT IN ['2','3']), HASH32(agency_id, contrib_source));
  sIncident_EA := SORT(dIncident_EA, incident_id,Sent_to_HPCC_DateTime,creation_date,report_id, LOCAL);
  uIncident_EA := DEDUP(sIncident_EA, incident_id, RIGHT, LOCAL);
	
// #############################################################################################
//                  Join MBS Agency & Incident
// #############################################################################################
  Layout_Infiles_Fixed.incident tIncAgency(uIncident_EA L, dAgency R) := TRANSFORM
    agency_source_matching := L.agency_id = R.agency_id AND L.Contrib_Source = R.Source_Id;
    SELF.agency_name := IF(agency_source_matching, R.Agency_Name, L.Agency_Name);
    IsAgencyActive := Functions.IsActiveDate(mod_Utilities.SysDate, R.Source_Start_Date, R.Source_Termination_Date);
    SELF.is_terminated_agency := IF(agency_source_matching, ~IsAgencyActive, TRUE); 
    SELF := L;
  END;
  jIncEcrash_Agency := JOIN(uIncident_EA, dAgency,
                            LEFT.agency_id = RIGHT.agency_id AND 
                            LEFT.contrib_source = RIGHT.source_id,
                            tIncAgency(LEFT, RIGHT), LOOKUP);

  dInc_Agency := DISTRIBUTE(jIncEcrash_Agency, HASH32(incident_id));

// #############################################################################################
//                Filter out terminated records (PRRecon - 49)
// #############################################################################################
  Inc_Agency := dInc_Agency(is_terminated_agency = FALSE);

// #############################################################################################
//                  Join Combined Agency Incident with Vehicle
// #############################################################################################
  Layout_Infiles_Fixed.cmbnd  tIncAgencyVeh(Inc_Agency L, uVehicl R) := TRANSFORM
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
  jIncAgency_Veh := JOIN(Inc_Agency, uVehicl,
                         LEFT.incident_id = RIGHT.incident_id,
                         tIncAgencyVeh(LEFT, RIGHT), LEFT OUTER, LOCAL); 

// #############################################################################################
//                  Join Combined Agency Incident Vehicle with Person
// #############################################################################################
  Layout_Infiles_Fixed.cmbnd  tIncAgencyVehPerson(jIncAgency_Veh L, uPerson R) := TRANSFORM    
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
  jIncAgencyVeh_Person := JOIN(jIncAgency_Veh(Unit_Number <> '0' AND Unit_Number <> ''), uPerson,
                               LEFT.incident_id = RIGHT.incident_id AND 
                               LEFT.Unit_Number = RIGHT.vehicle_Unit_Number ,
                               tIncAgencyVehPerson(LEFT, RIGHT), LEFT OUTER, LOCAL);

  // get person records by only incident_id when no vehcile records found 
  jIncAgencyVeh_OtherPerson := JOIN(jIncAgency_Veh(Unit_Number = '0' OR Unit_Number = ''), uPerson,
                                    LEFT.incident_id = RIGHT.incident_id, 
                                    tIncAgencyVehPerson(LEFT, RIGHT), LEFT OUTER, LOCAL);  
  
  //get person record that have 0 vehicle or if one or more recs in same incident have veh//like witness , property owner etc..
  jIncAgency_Person := JOIN(Inc_Agency, uPerson(vehicle_Unit_Number IN ['','0','NUL']),
                            LEFT.incident_id = RIGHT.incident_id ,
                            TRANSFORM(Layout_Infiles_Fixed.cmbnd, SELF := LEFT, SELF := RIGHT, SELF := []), LOCAL);

  IncAgencyVehPerson := DEDUP(SORT(DISTRIBUTE(jIncAgencyVeh_Person + jIncAgencyVeh_OtherPerson + jIncAgency_Person, HASH32(incident_id)), RECORD, LOCAL), RECORD, LOCAL);

// #############################################################################################
//      Suppress DE Reports with Flag value 0 in agency file
// #############################################################################################
  suppressAgencies := DISTRIBUTED(Agency(drivers_exchange_flag ='0'), HASH32(agency_id));
  uSuppressAgencies := DEDUP(SORT(suppressAgencies, Agency_id, LOCAL), Agency_id, LOCAL);

// #############################################################################################
//   Combined eCrash Recs after filtering out suppress Agencies & transforming to Slim layout
// #############################################################################################
  jEcrashAll_SuppressAgency := JOIN(IncAgencyVehPerson, uSuppressAgencies,
                                    TRIM(LEFT.agency_id,LEFT,RIGHT) = TRIM(RIGHT.agency_id,LEFT,RIGHT) AND 
                                    TRIM(LEFT.report_type_id, LEFT, RIGHT) = 'DE',
                                    MANY LOOKUP, LEFT ONLY);

  Layouts.slim_layout teCrashSlim(jEcrashAll_SuppressAgency L ) := TRANSFORM
    SELF.state := STD.Str.CleanSpaces(IF(TRIM(L.state, LEFT, RIGHT) = 'NU', '', TRIM(L.state,LEFT,RIGHT)));
    // Map TF rules in EA AND use same logic  overwriting case_id AND crash date  
    SELF.case_identifier := IF(L.source_id IN ['TF','TM'], L.state_report_number, L.case_identifier);
    SELF.crash_date := IF(L.source_id IN ['TF','TM'], '', STD.Str.FilterOut(TRIM(L.crash_date, LEFT, RIGHT), '-'));
    SELF.source_id := IF(L.source_id IN ['TF','TM'], 'TF', 'EA');
    // should match with payload key 
    SELF.report_code := L.source_id;
    SELF.accident_date := STD.Str.FilterOut(TRIM(L.crash_date,LEFT,RIGHT),'-');
     t_accident_nbr := IF(L.source_id IN ['TF','TM'], L.state_report_number, L.case_identifier);
     t_scrub := STD.Str.Filter(t_accident_nbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
    SELF.accident_nbr := IF(t_scrub IN ['UNK', 'UNKNOWN'], 'UNK' + L.incident_id, t_scrub);  
    SELF.orig_accnbr := t_accident_nbr; 
    SELF.addl_report_number := IF(L.source_id IN ['TF','TM'], L.case_identifier, L.state_report_number);
    SELF.orig_case_identifier := IF(TRIM(L.case_identifier, LEFT, RIGHT) = 'NULL', '',  L.case_identifier); 
    SELF.orig_state_report_number := IF(TRIM(L.state_report_number,LEFT,RIGHT) = 'NULL', '',  L.state_report_number);
    SELF.Page_Count :=  L.Page_Count;  
    SELF := L;
  END;
  eCrashCombined := PROJECT(jEcrashAll_SuppressAgency, teCrashSlim(LEFT)):PERSIST('~thor_data400::ecrash_incident_combined');
	
// #############################################################################################
// Filter out TM's IF TM came in accidently after TF.. All the TM's after TF are invalid.
// #############################################################################################
  IyetekFull := DISTRIBUTE(eCrashCombined (report_code = 'TF'), HASH32(State_Report_Number));
  IyetekMeta := DISTRIBUTE(eCrashCombined (report_code = 'TM'), HASH32(state_report_number));
  
  jTM_TF := JOIN(IyetekMeta, IyetekFull, 
                 LEFT.state_report_number = RIGHT.State_Report_Number AND 
                 LEFT.ORI_Number = RIGHT.ORI_Number AND 
                 LEFT.loss_state_abbr = RIGHT.loss_state_abbr AND 
                 LEFT.report_type_id  = RIGHT.report_type_id AND 
                 //LEFT.creation_date >= RIGHT.creation_date,
                 LEFT.Sent_to_HPCC_DateTime >= RIGHT.Sent_to_HPCC_DateTime,
                 TRANSFORM({IyetekMeta}, SELF := LEFT), LEFT ONLY, LOCAL);

  eCrashNotTM := eCrashCombined(report_code <> 'TM');
  DropMetadata := jTM_TF + eCrashNotTM;
  sDropMetadata := SORT(DropMetadata,
                        case_identifier, agency_id, loss_state_abbr, report_type_id, crash_date, source_id,-creation_date, 
                        -Sent_to_HPCC_DateTime, incident_id, last_name, first_name,  middle_name, address, city, state, zip_code,
                        Drivers_License_Number, License_Plate, vin, Make, Model_Yr, Model, hash_key, loss_street, loss_cross_street);
  
  Layouts.slim_layout tTFRecs(sDropMetadata L, sDropMetadata R) := TRANSFORM  
    SELF.last_name := L.last_name + R.last_name; 
    SELF.first_name := L.first_name + R.first_name;
    SELF.middle_name := L.middle_name + R.middle_name; 
    SELF.address := L.address + R.address; 
    SELF.city := L.city + R.city;
    SELF.state := L.state + R.state; 
    SELF.zip_code := L.zip_code + R.zip_code; 
    SELF.Drivers_License_Number := L.Drivers_License_Number + R.Drivers_License_Number;
    SELF.License_Plate := L.License_Plate + R.License_Plate; 
    SELF.vin := L.vin + R.vin;
    SELF.Make := L.make + R.make; 
    SELF.Model_Yr := L.Model_Yr + R.Model_Yr; 
    SELF.Model := L.Model + R.Model; 
    SELF := L;
  END;  
  rDropMetadata := ROLLUP(sDropMetadata, LEFT.incident_id = RIGHT.incident_id, tTFRecs(LEFT, RIGHT));

// #############################################################################################
//  Coplogic Reports
// #############################################################################################
  sCoplogic := SORT(rDropMetadata(TRIM(vendor_code, LEFT, RIGHT) = 'COPLOGIC'),
                    case_identifier,agency_id,loss_state_abbr,crash_date,Supplemental_report);
  gCoplogic := GROUP(sCoplogic, case_identifier, agency_id, loss_state_abbr, crash_date);
  
  Layouts.slim_layout tFlagCoplogic(gCoplogic L, gCoplogic R) := TRANSFORM                                        
    Suppmental_flag := MAP(L.incident_id = '' => '',
                           TRIM(R.Supplemental_Report, LEFT, RIGHT) = '1' => 'U',
                           TRIM(R.Supplemental_Report, LEFT, RIGHT) in ['0',''] => 'D', 
                          'D');                                      
    SELF.U_D_flag := Suppmental_flag;                              
    SELF.changed_hashkey := Suppmental_flag;
    SELF.changed_data_lev1 := Suppmental_flag;
    SELF := R;
  END;
  dsCoplogic := ITERATE(gCoplogic, tFlagCoplogic(LEFT, RIGHT));

  Layouts.ReportVersionNested tCoplogic2RptLay (dsCoplogic L ) := TRANSFORM 
    SELF.hash_ := DATASET([{L.Creation_Date, L.Incident_ID, L.Report_ID, L.Hash_Key, L.U_D_flag, L.Sent_to_HPCC_DateTime, L.report_code, L.page_count, L.Supplemental_report, L.report_type_id}], 
                          {Layouts.l_hash});
    SELF.super_report_id := L.Report_ID;
    SELF := L;
  END;
  pIncCoplogic := PROJECT(dsCoplogic, tCoplogic2RptLay(LEFT));
  dIncCoplogic := DISTRIBUTE(pIncCoplogic, HASH32(case_identifier));
  sIncCoplogic := SORT(dIncCoplogic, case_identifier, agency_id, loss_state_abbr, crash_date, source_id, -Sent_to_HPCC_DateTime, -creation_date, LOCAL);
  
  Layouts.ReportVersionNested tmakechildren_c(sIncCoplogic L, sIncCoplogic R) := TRANSFORM  
    SELF.hash_ :=  L.hash_&R.hash_;
    //SELF.super_report_ID :=  IF((INTEGER)L.super_Report_ID < (INTEGER)R.super_Report_ID,L.super_Report_ID,R.super_Report_ID);
    SELF.super_report_ID :=  IF(L.U_D_Flag = '', L.super_Report_ID, R.super_Report_ID);
    SELF := L;
  END;
  rIncCoplogic := ROLLUP(sIncCoplogic, case_identifier+agency_id + loss_state_abbr + crash_date + source_id, 
                         tmakechildren_c(LEFT, RIGHT), LOCAL):PERSIST('~thor_data400::EA_report_version_Coplogic');

// #############################################################################################
// Non Coplogic Reports
// #############################################################################################  
  sNonCoplogic := SORT(rDropMetadata(TRIM(vendor_code, LEFT, RIGHT) <> 'COPLOGIC'),
                       case_identifier, agency_id, loss_state_abbr, report_type_id, crash_date, source_id);
  gNonCoplogic := GROUP(sNonCoplogic, case_identifier, agency_id, loss_state_abbr, report_type_id, crash_date, source_id);
  
  // set a flag if Dupe or update 
  Layouts.slim_layout tFlagNonCoplogic(gNonCoplogic l, gNonCoplogic r) := TRANSFORM  
    tchanged_hashkey := IF(L.hash_key <> R.hash_key,'Y','N'); 
    tchanged_data_lev1 := IF((L.loss_street <>  R.loss_street OR
                              L.loss_cross_street <>  R.loss_cross_street OR
                              L.last_name <>  R.last_name OR 
                              L.first_name <>  R.first_name OR          
                              L.middle_name <>  R.middle_name OR         
                              L.address <> R.address OR      
                              L.city <> R.city OR      
                              L.state <> R.state OR        
                              L.zip_code <> R.zip_code OR          
                              L.Drivers_License_Number <> R.Drivers_License_Number OR
                              L.License_Plate <> R.License_Plate OR
                              L.vin <> R.vin OR 
                              L.Make <> R.Make OR 
                              L.Model_Yr <> R.Model_Yr OR         
                              L.Model <> R.Model ), 'Y', 'N');  
    SELF.U_D_flag := IF( L.incident_id = '' , '', IF(tchanged_hashkey = 'Y' AND tchanged_data_lev1 = 'Y' ,'U' , 'D')); 
    SELF.changed_hashkey := tchanged_hashkey;
    SELF.changed_data_lev1 := tchanged_data_lev1;
    SELF := r;
  END;
  dsNonCoplogic := ITERATE(gNonCoplogic, tFlagNonCoplogic(LEFT,RIGHT));
  
  Layouts.ReportVersionNested tNonCoplogic2RptLay (dsNonCoplogic L ) := TRANSFORM 
    SELF.hash_ := DATASET([{L.Creation_Date, L.Incident_ID, L.Report_ID, L.Hash_Key, L.U_D_flag, L.Sent_to_HPCC_DateTime, L.report_code, L.page_count, L.Supplemental_report, L.report_type_id}],
                          {Layouts.l_hash});
    SELF.super_report_id := L.Report_ID;
    SELF := L;
  END;
  pIncNonCoplogic := PROJECT(dsNonCoplogic, tNonCoplogic2RptLay(LEFT));
  dIncNonCoplogic := DISTRIBUTE(pIncNonCoplogic, HASH32(case_identifier));
  sIncNonCoplogic := SORT(dIncNonCoplogic, case_identifier, agency_id, loss_state_abbr, report_type_id, crash_date, source_id, -Sent_to_HPCC_DateTime, -creation_date, LOCAL);

  Layouts.ReportVersionNested tmakechildren_other(sIncNonCoplogic L, sIncNonCoplogic R) := TRANSFORM
    SELF.hash_ :=  L.hash_&R.hash_;
    SELF.super_report_ID := IF((INTEGER)L.super_Report_ID < (INTEGER)R.super_Report_ID, L.super_Report_ID, R.super_Report_ID);
    SELF := L;
  END;
  rIncNonCoplogic := ROLLUP(sIncNonCoplogic, case_identifier + agency_id + loss_state_abbr + report_type_id + crash_date + source_id, 
                            tmakechildren_other(LEFT, RIGHT), LOCAL):PERSIST('~thor_data400::EA_report_version');

// #############################################################################################
// Combined Coplogic & NonCoplogic reports
// ############################################################################################# 
  CombinedIncidentsAll := rIncCoplogic + rIncNonCoplogic;  
  //Normalize hashes
  Incidents_HashTable := TABLE(CombinedIncidentsAll, {INTEGER hashCount := COUNT(hash_), CombinedIncidentsAll});
  
  Layouts.ReportVersion tGetHash(Incidents_HashTable L, INTEGER C):= TRANSFORM      
    SELF := L.hash_[C];
    SELF.super_report_id := L.super_report_id;
    SELF.jurisdiction := IF(STD.Str.ToUpperCase(TRIM(L.agency_name, LEFT, RIGHT))= 'NULL', '',STD.Str.ToUpperCase(L.agency_name));
    SELF.orig_accnbr := IF(STD.Str.ToUpperCase(TRIM(L.orig_accnbr, LEFT, RIGHT))= 'NULL', '', STD.Str.ToUpperCase(L.orig_accnbr));
    SELF.addl_report_number := IF(STD.Str.ToUpperCase(TRIM(L.addl_report_number, LEFT, RIGHT))='NULL', '', STD.Str.ToUpperCase(L.addl_report_number));
    SELF.jurisdiction_state := IF(STD.Str.ToUpperCase(TRIM(L.loss_state_abbr, LEFT, RIGHT))= 'NULL', '', STD.Str.ToUpperCase(L.loss_state_abbr));
    SELF.work_type_id := IF(STD.Str.ToUpperCase(TRIM(L.work_type_id, LEFT, RIGHT))='NULL', '', STD.Str.ToUpperCase(L.work_type_id));
    SELF.agency_ori := IF(STD.Str.ToUpperCase(TRIM(L.ori_number, LEFT, RIGHT))='NULL', '', STD.Str.ToUpperCase(L.ori_number));
    SELF.super_report_id_orig := L.super_report_id;
    SELF := L;
    SELF := [];
  END;  
  IncidentsWithHashKey := NORMALIZE(Incidents_HashTable, LEFT.hashCount, tGetHash(LEFT, COUNTER));

// #############################################################################################
// Assign new super id across the sources
// ############################################################################################# 
  sIncidentsWithHashKey := SORT(IncidentsWithHashKey, orig_case_identifier, orig_state_report_number, jurisdiction, jurisdiction_state, report_type_id, accident_date, super_report_id,-Sent_to_HPCC_DateTime,-creation_date);
  gIncidentsWithHashKey := GROUP(sIncidentsWithHashKey, orig_case_identifier, orig_state_report_number, jurisdiction, jurisdiction_state, report_type_id, accident_date);
  
	Layouts.ReportVersion tGetNewSuperID(gIncidentsWithHashKey L, gIncidentsWithHashKey R) := TRANSFORM  
    SELF.super_report_id := IF((INTEGER)L.super_report_id  <> 0 AND (INTEGER)L.super_report_id < (INTEGER)R.super_report_id,
		                           L.super_report_id,
															 R.super_report_id);
    SELF := R;
  END;
EXPORT Map_eCrashAccidents_To_SupplementalBase := ITERATE(gIncidentsWithHashKey, tGetNewSuperID(LEFT, RIGHT));
