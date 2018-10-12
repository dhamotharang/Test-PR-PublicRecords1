IMPORT BIPv2, DueDiligence, Risk_Indicators, STD;

EXPORT getSharedAircraft(DATASET(DueDiligence.LayoutsInternal.AircraftSlimLayout) inAircraft) := FUNCTION


  STATUS_FLAG_ACTIVE := 'A';

  //retrieve the build date of the faa data to use with archive mode logic 
	faa_build_date := Risk_Indicators.get_Build_date('faa_build_version');
  
  
	

	//If we are in archive mode, and the archive date is greater than the build date,  
	//change the archive date to be the build date
  tempData := PROJECT(inAircraft, TRANSFORM(DueDiligence.LayoutsInternal.AircraftSlimLayout,
                                            SELF.historyDate := IF(LEFT.historyDate > (UNSIGNED)faa_build_date AND
                                                                   LEFT.historyDate <> DueDiligence.Constants.date8Nines, (UNSIGNED)faa_build_date, LEFT.historyDate);
                                            SELF := LEFT));
                                            
  //Clean dates used in logic and/or attribute levels here so all comparisions flow through consistently
	aircraftDateClean := DueDiligence.Common.CleanDatasetDateFields(tempData, 'dateFirstSeen, dateLastSeen');
  
  aircraftFiltered := DueDiligence.Common.FilterRecordsSingleDate(aircraftDateClean, dateFirstSeen);
  
  
  //remove duplicate rows
  sortAircraft := SORT(aircraftFiltered, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did, tailNumber, dateFirstSeen);
  
  rollAircraft := ROLLUP(sortAircraft,
                          LEFT.seq = RIGHT.seq AND
                          LEFT.did = RIGHT.did AND
                          LEFT.tailNumber = RIGHT.tailNumber,
                          TRANSFORM(RECORDOF(LEFT),
                                    SELF.dateFirstSeen := IF(LEFT.dateFirstSeen = 0, RIGHT.dateFirstSeen, LEFT.dateFirstSeen);
                                    SELF.dateLastSeen := MAX(LEFT.dateFirstSeen, RIGHT.dateFirstSeen);
                                    SELF.statusFlag := RIGHT.statusFlag;
                                    
                                    SELF.year := DueDiligence.Common.firstPopulatedString(year);
                                    SELF.make := DueDiligence.Common.firstPopulatedString(make);
                                    SELF.model := DueDiligence.Common.firstPopulatedString(model);
                                    SELF.vin := DueDiligence.Common.firstPopulatedString(vin);
                                    SELF.registrationDate := DueDiligence.Common.firstPopulatedString(registrationDate);
                                    SELF.manufactureModelCode :=  DueDiligence.Common.firstPopulatedString(manufactureModelCode);
                                    
                                    SELF := LEFT;));
  
  
  //filter aircraft based on the mode (ie current or archive mode)
  archiveModeAircraft := rollAircraft(historyDate <> DueDiligence.Constants.date8Nines);
  currentModeAircraft := rollAircraft(historyDate = DueDiligence.Constants.date8Nines);
  
  
  //filter only current aircraft
  archiveFilter := archiveModeAircraft((historydate BETWEEN dateFirstSeen AND dateLastSeen) OR
                                        (dateLastSeen < historyDate AND statusFlag = STATUS_FLAG_ACTIVE));
  
  currentFilter := currentModeAircraft(statusFlag = STATUS_FLAG_ACTIVE);
  
  
  
  //put all aircraft together to rollup per entity
  allAircraft := archiveFilter + currentFilter;
  
  //make sure limits are enforced for child dataset
  sortGroupAllAircraft := GROUP(SORT(allAircraft, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did, -dateFirstSeen, -dateLastSeen, -registrationDate, tailNumber), seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did);
  limitAllAircraft := DueDiligence.Common.GetMaxRecords(sortGroupAllAircraft, DueDiligence.Constants.MAX_AIRCRAFT);
  
  projectAircraft := PROJECT(limitAllAircraft, TRANSFORM({DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout, DATASET(DueDiligence.Layouts.AircraftDataLayout) aircraft},
                                                          SELF.aircraft := DATASET([TRANSFORM(DueDiligence.Layouts.AircraftDataLayout,
                                                                                              SELF := LEFT;)]);
                                                          SELF := LEFT;));
  
  sortAllAircraft := SORT(projectAircraft, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did);

  rollAllAircraft := ROLLUP(sortAllAircraft,
                            #EXPAND(DueDiligence.Constants.mac_JOINLinkids_Results()) AND
                            LEFT.did = RIGHT.did,
                            TRANSFORM(RECORDOF(LEFT),
                                      SELF.aircraft := LEFT.aircraft + RIGHT.aircraft;
                                      SELF := LEFT;));
  
  
  
  // OUTPUT(tempData, NAMED('tempData'));
  // OUTPUT(aircraftDateClean, NAMED('aircraftDateClean'));
  // OUTPUT(aircraftFiltered, NAMED('aircraftFiltered'));
  // OUTPUT(sortAircraft, NAMED('sortAircraft'));
  // OUTPUT(rollAircraft, NAMED('rollAircraft'));
  // OUTPUT(archiveModeAircraft, NAMED('archiveModeAircraft'));
  // OUTPUT(currentModeAircraft, NAMED('currentModeAircraft'));
  // OUTPUT(archiveFilter, NAMED('archiveFilter'));
  // OUTPUT(currentFilter, NAMED('currentFilter'));
  // OUTPUT(limitAllAircraft, NAMED('limitAllAircraft'));
  // OUTPUT(projectAircraft, NAMED('projectAircraft'));
  // OUTPUT(sortAllAircraft, NAMED('sortAllAircraft'));
  // OUTPUT(rollAllAircraft, NAMED('rollAllAircraft'));
  
  
  RETURN rollAllAircraft;
END;