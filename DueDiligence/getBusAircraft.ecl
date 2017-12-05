IMPORT BIPV2, Business_Risk_BIP, FAA, MDR, Risk_Indicators, STD, UT, Watercraft;

EXPORT getBusAircraft(DATASET(DueDiligence.layouts.Busn_Internal) BusnData, 
											     Business_Risk_BIP.LIB_Business_Shell_LIBIN Options,
													 boolean DebugMode = FALSE
											     ) := FUNCTION
	// ------                                                                                     ------
	// ------ Notes:                                                                             ------  
	// ------    There are no restrictions on aircraft data so no DRM flags are being sent intot this function
	// ------    BIPV2.mod_sources.iParams linkingOptions                                        ------
	// ------                                                                                    ------


  // ------                                                                                    ------
	// ------ retrieve the build date of the faa data to use with archive move logic             ------
	// ------                                                                                    ------
	faa_build_date := Risk_Indicators.get_Build_date('faa_build_version');
	
	// ------                                                                                    ------
	// ------ If we are in archive mode, and the archive date is greater than the build date,    ------ 
	// ------ change the archive date to be the build date                                       ------
	// ------                                                                                    ------
	tempBusnData := PROJECT(BusnData, TRANSFORM(DueDiligence.layouts.Busn_Internal,
																								SELF.historyDate := IF(LEFT.historyDate > (UNSIGNED)faa_build_date AND
																																				LEFT.historyDate <> DueDiligence.Constants.date8Nines, (UNSIGNED)faa_build_date, LEFT.historyDate);
																								SELF := LEFT));


  // ------                                                                                    ------
	// ------ FAA - Aircraft Records                                                             ------
	// ------                                                                                    ------
	AircraftRaw := FAA.Key_Aircraft_LinkIDs.kFetch2(DueDiligence.Common.GetLinkIDs(BusnData),
																						 Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
																							0, /*ScoreThreshold --> 0 = Give me everything*/
																							Business_Risk_BIP.Constants.Limit_Default,
																							Options.KeepLargeBusinesses);
																							
  // ------                                                                                    ------	
	// ------ Add our sequence number to the avaiation records found for this Business           ------
	// ------                                                                                    ------
	AircraftRaw_with_seq := DueDiligence.Common.AppendSeq(AircraftRaw, tempBusnData, TRUE);
	
	// ------                                                                                    ------
	// ------ When this query runs in ARCHIVE MODE the History date on the input contains a date ------
	// ------ Use this function drop property records that are out of scope for this transaction ------
	// ------ If the History date is all 9's essentially no records will be dropped - also known ------
	// ------ as CURRENT MODE.                                                                   ------
	// ------                                                                                    ------
	Aircraft_Filtered := DueDiligence.Common.FilterRecordsSingleDate(AircraftRaw_with_seq, date_first_seen);
	
	Aircraft_Sorted  :=  sort(Aircraft_Filtered, ultid, orgid, seleid, n_number, current_flag, date_first_seen);
  
	recordof(Aircraft_Filtered) rolluptheaircraft_process(Aircraft_Sorted le, Aircraft_Sorted ri)  := TRANSFORM
	                                                            self.seq      := ri.seq;
																															self.ultid    := ri.ultid;
																															self.orgid    := ri.orgid;
																															self.seleid   := ri.seleid; 
																															self.n_number := ri.n_number;
																															/*  get the earliest date_first_seen   */  
																															SELF.date_first_seen  := IF((UNSIGNED)le.date_first_seen = 0, MAX(le.date_first_seen, ri.date_first_seen), MIN(le.date_first_seen, ri.date_first_seen));
																															/*  get the latest date_last_seen      */
																															self.date_last_seen   := MAX(le.date_last_seen, ri.date_last_seen);
																															SELF := le;
	                                                            END;
	
	// ------                                                                                    ------
  // ------ For archive mode:  Produce a list of unique aircraft for this business.            ------ 
	// ------ The n_number is the unique identifier for an aircraft.                             ------
	// ------ Do not include the transactions that are running in CURRENT mode (hist date = 9's) ------
	// ------                                                                                    ------
	Aircraft_archive := rollup(Aircraft_Sorted(historydate <> DueDiligence.Constants.date8Nines), rolluptheaircraft_process(left, right), ultid, orgid, seleid, n_number);	
	
  // ------                                                                                    ------  
	// ------ For archive mode:  Count the number aircraft that we think are owned on            ------
	// ------ a specific date in the past.                                                       ------
	// ------                                                                                    ------
  Summary_BusAir_archive_mode := table(Aircraft_archive, {seq, ultid, orgid, seleid, name, historydate, OwnAirCnt := count(group, ((UNSIGNED)historydate BETWEEN (UNSIGNED)date_first_seen and (UNSIGNED)date_last_seen) OR
																																																											((UNSIGNED)date_last_seen < (UNSIGNED)historyDate AND current_flag = 'A'))}, seq, ultid, orgid, seleid);
	// ------                                                                                    ------
  // ------ For Current mode:                                                                  ------ 	
	// ------ Use the current flag to select the 'active' record from list of aircraft records   ------
	// ------ This is how duplicate records are removed for aircraft                             ------
	// ------                                                                                    ------
	Aircraft_current_sort := SORT(Aircraft_Filtered(historydate = DueDiligence.Constants.date8Nines), seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), n_number, current_flag);
	Aircraft_current_dedup := DEDUP(Aircraft_current_sort, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), n_number);
	Aircraft_Current  := Aircraft_current_dedup(current_flag = 'A');  
  
	Summary_BusAir_current_mode := table(Aircraft_Current, {seq, ultid, orgid, seleid, name, historydate, OwnAirCnt := count(group)}, seq, ultid, orgid, seleid);
	
	Summary  := Summary_BusAir_current_mode + Summary_BusAir_archive_mode;
	
  // ------                                                                                    ------
  // ------ add the aircraft count to Busn_Internal layout.                                    ------
	// ------                                                                                    ------
	Update_BusnAircraft := JOIN(BusnData, Summary,
												LEFT.seq = RIGHT.seq AND
												LEFT.Busn_info.BIP_IDS.UltID.LinkID  = RIGHT.ultID AND
												LEFT.Busn_info.BIP_IDS.OrgID.LinkID  = RIGHT.orgID AND
												LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.seleID,												
												TRANSFORM(DueDiligence.Layouts.Busn_Internal, 
																	SELF.AircraftCount := RIGHT.OwnAirCnt,
																	SELF := LEFT),
																	LEFT OUTER);
 
 
	// ********************
	//   DEBUGGING OUTPUTS
	// *********************

	 IF(DebugMode,      OUTPUT(faa_build_date,                          NAMED('faa_build_date')));
	 IF(DebugMode,      OUTPUT(CHOOSEN(tempBusnData, 100),              NAMED('tempBusnData')));
	
	 IF(DebugMode,     OUTPUT(CHOOSEN(AircraftRaw_with_seq, 100),       NAMED('Sample_Aircraft_step1_includes_all_records')));
	 IF(DebugMode,     OUTPUT(COUNT  (AircraftRaw_with_seq),            NAMED('HowManyAircraftStep1')));
	 
	 IF(DebugMode,     OUTPUT(CHOOSEN(Aircraft_Filtered, 100),          NAMED('Sample_Aircraft_step2_drop_records_outside_the_history_date')));
	 IF(DebugMode,     OUTPUT(COUNT  (Aircraft_Filtered),               NAMED('HowManyAircraftStep2')));
	 
	 IF(DebugMode,     OUTPUT(CHOOSEN(Aircraft_Sorted, 100),            NAMED('Sample_Aircraft_step3_Sorted')));
	 IF(DebugMode,     OUTPUT(COUNT (Aircraft_Sorted),                  NAMED('HowManyAircraftStep3')));
	 
	 IF(DebugMode,     OUTPUT(CHOOSEN(Aircraft_Archive, 100),           NAMED('Sample_Aircraft_step4_records_archive_mode')));
	 IF(DebugMode,     OUTPUT(COUNT (Aircraft_Archive),                 NAMED('HowManyAircraftStep4')));
	 IF(DebugMode,     OUTPUT(CHOOSEN(Summary_BusAir_archive_mode, 100), NAMED('Summary_BusAir_archive_mode')));
	 
	 IF(DebugMode,     OUTPUT(CHOOSEN(Aircraft_current_sort, 100),      NAMED('Aircraft_current_sort')));
	 IF(DebugMode,     OUTPUT(CHOOSEN(Aircraft_current_dedup, 100),     NAMED('Aircraft_current_dedup')));
	 IF(DebugMode,     OUTPUT(CHOOSEN(Aircraft_Current, 100),           NAMED('Aircraft_Current')));
	 IF(DebugMode,     OUTPUT(CHOOSEN(Summary_BusAir_current_mode, 100), NAMED('Summary_BusAir_current_mode')));
	 
	 IF(DebugMode,     OUTPUT(Summary,                                  NAMED('Summary')));
	
	
	RETURN Update_BusnAircraft;
END;