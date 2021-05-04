IMPORT STD;
	
// #############################################################################################
//                      MBS eCrash Agency 
// #############################################################################################  
  dAgency := Infiles.dAgency;

// #############################################################################################
//                      EA Coplogic, TF, TM
// #############################################################################################  
  SuppressIncidents := IncidentsAfterSuppression(Source_id IN ['EA','TM','TF']):INDEPENDENT;
  dIncidentCombinedEcrash := DISTRIBUTE(SuppressIncidents(~(work_type_id IN ['2','3'])), HASH32(agency_id, source_id));
	
// #############################################################################################
//                      EA CRU
// ############################################################################################# 
  dIncidentCRU := DISTRIBUTE(SuppressIncidents(work_type_id IN ['2','3']), HASH32(agency_id));
	
// #############################################################################################
//                  Join MBS Agency & Incident
// #############################################################################################            
  Layout_Infiles_Fixed.incident tIncAgency(dIncidentCombinedEcrash L, dAgency R) := TRANSFORM
     agency_source_matching := L.agency_id = R.agency_id AND L.Contrib_Source = R.Source_Id;
    SELF.agency_name := IF(agency_source_matching, R.Agency_Name, '');
     IsAgencyActive := Functions.IsActiveDate(mod_Utilities.SysDate, R.Source_Start_Date, R.Source_Termination_Date);
    SELF.is_terminated_agency := IF(agency_source_matching, ~IsAgencyActive, TRUE);
    SELF.allow_Sale_Of_Component_Data := FALSE;
    SELF := L;
    SELF := [];
  END;
  jIncEcrash_Agency := JOIN(dIncidentCombinedEcrash, dAgency, 
                            LEFT.agency_id = RIGHT.agency_id AND 
                            LEFT.contrib_source = RIGHT.source_id, 
                            tIncAgency(LEFT, RIGHT), LOOKUP);  
	
// #############################################################################################
//                  Join MBS Agency & Incident CRU
// ############################################################################################# 
  Layout_Infiles_Fixed.incident tCruIncAgency(dIncidentCRU L, dAgency R) := TRANSFORM
    SELF.agency_name := IF(L.agency_id = R.agency_id, R.Agency_Name, '');
    SELF := L;
    SELF := [];
  END;
  jIncCru_Agency := JOIN(dIncidentCRU, dAgency, 
                         LEFT.agency_id = RIGHT.agency_id, 
                         tCruIncAgency(LEFT, RIGHT), LEFT OUTER, LOOKUP);

// #############################################################################################
//                Filter out terminated records (PRRecon - 49)
// #############################################################################################
  Incidents := jIncEcrash_Agency(is_terminated_agency = FALSE) + jIncCru_Agency;

// #############################################################################################
//  Suppress the DE records basing on the drivers_exchange_flag in the agency file. 
// ############################################################################################# 
  suppressAgencies := DISTRIBUTED(Infiles.agency(drivers_exchange_flag ='0'), HASH32(agency_id));
  uSuppressAgencies := DEDUP(SORT(suppressAgencies, Agency_id, LOCAL), Agency_id, LOCAL);

  Incidents_DE_Suppression := JOIN(Incidents, uSuppressAgencies,
                                   TRIM(LEFT.agency_id, LEFT, RIGHT) = TRIM(RIGHT.agency_id, LEFT, RIGHT) AND 
                                   TRIM(LEFT.report_type_id, LEFT, RIGHT) = 'DE',
                                   MANY LOOKUP, LEFT ONLY );  
              
  Layout_VehIncidents.SlimIncidents tCleanIncidents(Incidents_DE_Suppression L) := TRANSFORM
     acc_nbr := IF(L.source_id IN ['TM','TF'], STD.Str.ToUpperCase(L.State_Report_number), STD.Str.ToUpperCase(L.Case_identIFier));
     t_scrub := STD.Str.Filter(acc_nbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
     t_accident_nbr := IF(t_scrub IN ['UNK', 'UNKNOWN'], 'UNK'+ l.incident_id, t_scrub); 
     t_jurisdiction_state := IF(L.case_identifier = '11030001','GA', L.Loss_state_Abbr);
     t_jurisdiction := IF(L.incident_id[1..9]='188188188' ,'LN Test PD', TRIM(L.agency_name, LEFT, RIGHT));
     accidentdate := STD.Str.FilterOut(TRIM(L.crash_date, LEFT, RIGHT),'-');
     t_accident_date := IF(L.incident_id[1..9] ='188188188','20100901', accidentdate);
     t_Sent_to_HPCC_DateTime := STD.Str.FilterOut(TRIM(L.Sent_to_HPCC_DateTime, LEFT, RIGHT),'-');
     t_jurisdiction_nbr := IF(L.incident_id[1..9]='188188188','1536035', L.AGENCY_ID);
    SELF.vehicle_incident_id := L.incident_id;
    SELF.accident_nbr := t_accident_nbr;
    SELF.Sent_to_HPCC_DateTime := t_Sent_to_HPCC_DateTime;
    SELF.accident_date := t_accident_date;
    SELF.report_code := L.Source_id;
    SELF.jurisdiction_state := t_jurisdiction_state;
    SELF.jurisdiction_nbr := t_jurisdiction_nbr;
    SELF.jurisdiction := t_jurisdiction;
    SELF.vehicle_incident_id_latest := '';
    SELF := L;
    SELF := [];
  END;
  CleanIncidents := PROJECT(Incidents_DE_Suppression, tCleanIncidents(LEFT)):INDEPENDENT;	

// #############################################################################################
//   Drop any TM's that came after TF's
// #############################################################################################
  TMReports := DISTRIBUTE(CleanIncidents(report_code = 'TM'), HASH32(accident_nbr));
  TFReports := DISTRIBUTE(CleanIncidents(report_code = 'TF'), HASH32(accident_nbr));
  Jn_TM_Reports := JOIN(TMReports, TFReports, 
                        LEFT.accident_nbr = RIGHT.accident_nbr AND 
                        LEFT.ORI_Number = RIGHT.ORI_Number AND 
                        TRIM(LEFT.jurisdiction_state,  LEFT, RIGHT) = TRIM(RIGHT.jurisdiction_state,  LEFT, RIGHT) AND 
                        TRIM(LEFT.report_type_id,  LEFT, RIGHT)  = TRIM(RIGHT.report_type_id,  LEFT, RIGHT) AND 
                        LEFT.Sent_to_HPCC_DateTime >= RIGHT.Sent_to_HPCC_DateTime,
                        TRANSFORM(LEFT), LEFT ONLY, LOCAL) ;  
												
  EAReports := CleanIncidents(report_code = 'EA');
	
  IncidentsAfterTMTF := EAReports + Jn_TM_Reports + TFReports:INDEPENDENT;

// #############################################################################################
//                     Join Insurance CRU Meow Key & eCrash Incidents
// #############################################################################################
  iMeowKey := INDEX(DATASET([], Layout_VehIncidents.MeowLayout), {idfield}, {Layout_VehIncidents.MeowLayout -{idfield}},
	                  '~foreign::'+ Constants.alpha_ip + '::thor_data400::key::ecrash_cru::qa::idfield::meow');       
  fMewoKeyEcrash := PULL(iMeowKey(report_code IN ['EA','TM','TF'])); 
	dMeowKey := DISTRIBUTE(fMewoKeyEcrash, HASH32(vehicle_incident_id));
	sMeowKey := SORT(dMeowKey, vehicle_incident_id, LOCAL);
	uMeowKey := DEDUP(sMeowKey, vehicle_incident_id, LOCAL);
    
  dMeowKeyByAccnbr := DISTRIBUTE(uMeowKey, HASH32(l_accnbr)):INDEPENDENT;
	
  Layout_VehIncidents.SlimIncidents tIncMeowTMTF(IncidentsAfterTMTF L, dMeowKeyByAccnbr R) := TRANSFORM
    SELF.vehicle_incident_id_latest :=  R.vehicle_incident_id; 
    SELF := L;
  END;

  TMTFIncidents := IncidentsAfterTMTF(report_code IN ['TM', 'TF']);
  NonTMTFIncidents := IncidentsAfterTMTF(report_code NOT IN ['TM', 'TF']);
  TMTFMeow := dMeowKeyByAccnbr(report_code IN ['TM', 'TF']);
  NonTMTFMeow := dMeowKeyByAccnbr(report_code NOT IN ['TM', 'TF']);      
  
	jInc_MeowTMTF := JOIN(TMTFIncidents, TMTFMeow,
                        TRIM(LEFT.accident_nbr, LEFT, RIGHT) = TRIM(RIGHT.l_accnbr, LEFT, RIGHT) AND 
                        TRIM(LEFT.jurisdiction_state, LEFT, RIGHT) = TRIM(RIGHT.jurisdiction_state, LEFT, RIGHT) AND
                        TRIM(LEFT.jurisdiction_nbr, LEFT, RIGHT) = TRIM(RIGHT.jurisdiction_nbr, LEFT, RIGHT) AND
                        TRIM(LEFT.report_code, LEFT, RIGHT) = TRIM(RIGHT.report_code, LEFT, RIGHT) AND 
                        TRIM(LEFT.report_type_id, LEFT, RIGHT) = TRIM(RIGHT.report_type_id, LEFT, RIGHT),
                        tIncMeowTMTF(LEFT, RIGHT), LEFT OUTER, LOCAL):INDEPENDENT;

  MatchedTMTF := jInc_MeowTMTF(TRIM(vehicle_incident_id_latest, LEFT, RIGHT) <> '');
  NonMatchingTMTF := jInc_MeowTMTF(TRIM(vehicle_incident_id_latest, LEFT, RIGHT) = '');
  NonMatchingTM := NonMatchingTMTF(report_code IN ['TM']);
  NonMatchingTF := jInc_MeowTMTF(report_code IN ['TF']);

  Layout_VehIncidents.SlimIncidents tNonMatchTMTF(NonMatchingTM L, NonMatchingTF R) := TRANSFORM
    SELF.vehicle_incident_id_latest := R.vehicle_incident_id; 
    SELF := L;
  END;
  jNonMatchTM_NonMatchTF := JOIN(NonMatchingTM, NonMatchingTF, 
                                 TRIM(LEFT.accident_nbr, LEFT, RIGHT) = TRIM(RIGHT.accident_nbr, LEFT, RIGHT) AND 
                                 TRIM(LEFT.ORI_Number, LEFT, RIGHT) = TRIM(RIGHT.ORI_Number, LEFT, RIGHT) AND 
                                 TRIM(LEFT.jurisdiction_state, LEFT, RIGHT) = TRIM(RIGHT.jurisdiction_state, LEFT, RIGHT) AND
                                 TRIM(LEFT.report_type_id, LEFT, RIGHT) = TRIM(RIGHT.report_type_id, LEFT, RIGHT), 
                                 tNonMatchTMTF(LEFT, RIGHT), LEFT OUTER, LOCAL);
  MatchedIncidentsTMTF := jNonMatchTM_NonMatchTF(TRIM(vehicle_incident_id_latest, LEFT, RIGHT) <> '');

  jInc_MeowNonTMTF := JOIN(NonTMTFIncidents, NonTMTFMeow,
                            TRIM(LEFT.accident_nbr, LEFT, RIGHT) = TRIM(RIGHT.l_accnbr, LEFT, RIGHT) AND 
                            (INTEGER)LEFT.accident_date = (INTEGER)RIGHT.accident_date AND
                            TRIM(LEFT.jurisdiction_state, LEFT, RIGHT) = TRIM(RIGHT.jurisdiction_state, LEFT, RIGHT) AND
                            TRIM(LEFT.report_code, LEFT, RIGHT) = TRIM(RIGHT.report_code, LEFT, RIGHT) AND 
                            TRIM(LEFT.report_type_id, LEFT, RIGHT) = TRIM(RIGHT.report_type_id, LEFT, RIGHT),
                            tIncMeowTMTF(LEFT, RIGHT), LEFT OUTER, LOCAL):INDEPENDENT;
                                        
  MatchedInicdentOthers := jInc_MeowNonTMTF(TRIM(vehicle_incident_id_latest, LEFT, RIGHT) <> '');                                        
  dsJnEmptyIncidentId := jInc_MeowNonTMTF(TRIM(vehicle_incident_id_latest, LEFT, RIGHT) = '');
                      
  CruIncidents := jInc_MeowNonTMTF(Work_Type_ID IN ['2','3'] AND TRIM(vehicle_incident_id_latest, LEFT, RIGHT) = '');
  NonCruIncidents := jInc_MeowNonTMTF(Work_Type_ID NOT IN ['2','3'] AND TRIM(vehicle_incident_id_latest, LEFT, RIGHT) = '');

  jIncCru_NonTMTFMeow := JOIN(CruIncidents, NonTMTFMeow,
                              TRIM(LEFT.accident_nbr, LEFT, RIGHT) = TRIM(RIGHT.l_accnbr, LEFT, RIGHT) AND 
                              TRIM(LEFT.jurisdiction_state, LEFT, RIGHT) = TRIM(RIGHT.jurisdiction_state, LEFT, RIGHT) AND
                              TRIM(LEFT.report_code, LEFT, RIGHT) = TRIM(RIGHT.report_code, LEFT, RIGHT) AND
                              TRIM(LEFT.jurisdiction_nbr, LEFT, RIGHT) = TRIM(RIGHT.jurisdiction_nbr, LEFT, RIGHT) AND
                              TRIM(LEFT.cru_order_id  , LEFT, RIGHT) = TRIM(RIGHT.cru_order_id, LEFT, RIGHT) AND 
                              TRIM(LEFT.report_type_id, LEFT, RIGHT) = TRIM(RIGHT.report_type_id, LEFT, RIGHT),
                              tIncMeowTMTF(LEFT, RIGHT), LEFT OUTER, LOCAL):INDEPENDENT;
                            
  MatchedIncidentsCru := jIncCru_NonTMTFMeow(TRIM(vehicle_incident_id_latest, LEFT, RIGHT) <> ''); 
	
	fIncCru_NonTMTFMeow := jIncCru_NonTMTFMeow(TRIM(vehicle_incident_id_latest, LEFT, RIGHT) = '');
	fNonMatchTM_NonMatchTF := jNonMatchTM_NonMatchTF(TRIM(vehicle_incident_id_latest, LEFT, RIGHT) = '');
	fNonMatchingTMTF := NonMatchingTMTF(report_code NOT IN ['TM']);
  FinalNonMatchingIncidents := fIncCru_NonTMTFMeow +
	                             NonCruIncidents + 
															 fNonMatchTM_NonMatchTF + 
															 fNonMatchingTMTF :PERSIST('~thor_data400::ecrash::persist::FinalNonMatchinginIncidents');
  fFinalNonMatchingIncidents := FinalNonMatchingIncidents(report_code IN ['EA'] AND work_type_id IN ['0','1','2','3']);
	
  Layout_VehIncidents.SlimIncidents tFinalNonMatchInc(fFinalNonMatchingIncidents L, dMeowKeyByAccnbr R) := TRANSFORM
    SELF.vehicle_incident_id_latest := R.vehicle_incident_id; 
    SELF := L;
  END;
  jFinalNonMatchingIncidents := JOIN(fFinalNonMatchingIncidents, NonTMTFMeow,
                                     TRIM(LEFT.accident_date, LEFT, RIGHT) = TRIM(RIGHT.accident_date, LEFT, RIGHT) AND 
                                     TRIM(LEFT.jurisdiction_state, LEFT, RIGHT) = TRIM(RIGHT.jurisdiction_state, LEFT, RIGHT) AND
                                     TRIM(LEFT.report_code, LEFT, RIGHT) = TRIM(RIGHT.report_code, LEFT, RIGHT) AND
                                     TRIM(LEFT.report_type_id, LEFT, RIGHT) = TRIM(RIGHT.report_type_id, LEFT, RIGHT) AND
                                     TRIM(LEFT.crash_city, LEFT, RIGHT) = TRIM(RIGHT.vehicle_incident_city, LEFT, RIGHT) AND
                                     TRIM(LEFT.loss_street, LEFT, RIGHT) = TRIM(RIGHT.accident_street, LEFT, RIGHT) AND
                                     TRIM(LEFT.loss_cross_street, LEFT, RIGHT) = TRIM(RIGHT.accident_cross_street, LEFT, RIGHT) AND
                                     (LEFT.report_code NOT IN ['TM','TF'] OR TRIM(LEFT.ori_number, LEFT, RIGHT) = TRIM(RIGHT.agency_ori, LEFT, RIGHT)), 
                                     tFinalNonMatchInc( LEFT, RIGHT), LEFT OUTER);
                                    
  FinalMatchedIncidents := jFinalNonMatchingIncidents(TRIM(vehicle_incident_id_latest, LEFT, RIGHT) <> '');

  MatchedIncidents := MatchedTMTF + MatchedIncidentsTMTF + MatchedInicdentOthers + MatchedIncidentsCru + FinalMatchedIncidents;
	dMatchedIncidents := DISTRIBUTE(MatchedIncidents, HASH32(vehicle_incident_id));
	sMatchedIncidents := SORT(dMatchedIncidents, vehicle_incident_id, LOCAL);
	uMatchedIncidents := DEDUP(sMatchedIncidents, vehicle_incident_id, LOCAL);
	
EXPORT Map_eCrashAccidents_To_CRUVehicleIncidentsBase := uMatchedIncidents;
