IMPORT DueDiligence, iesp, MDR;


EXPORT reportIndIdentitySources(DATASET(DueDiligence.Layouts.Indv_Internal) inData) := FUNCTION



    SOURCE_ID := ENUM(AIRCRAFT = 1, BANKRUPTCY, BUREAU, DRIVERS_LICENSE, LIENS, PROF_LICENSE, PROPERTY, STUDENT_DATA, UTILITY, VEHICLE, VOTER, WATERCRAFT, OTHER);
    
    SourceDSLayout := RECORD
      UNSIGNED sourceID;
      STRING sourceCategoryText;
    END;
    
    
    sourceDS := DATASET([
                          {SOURCE_ID.AIRCRAFT,            'Aircraft'},
                          {SOURCE_ID.BANKRUPTCY,          'Bankruptcy Records'},
                          {SOURCE_ID.BUREAU,              'Bureau'},
                          {SOURCE_ID.DRIVERS_LICENSE,     'Driver Licenses'},
                          {SOURCE_ID.LIENS,               'Liens and Judgments'},
                          {SOURCE_ID.PROF_LICENSE,        'Professional Licenses'},
                          {SOURCE_ID.PROPERTY,            'Property'},
                          {SOURCE_ID.STUDENT_DATA,        'Student Data'},
                          {SOURCE_ID.UTILITY,             'Utility'},
                          {SOURCE_ID.VEHICLE,             'Motor Vehicle Registrations'},
                          {SOURCE_ID.VOTER,               'Voter Registrations'},
                          {SOURCE_ID.WATERCRAFT,          'WaterCraft Registrations'},
                          {SOURCE_ID.OTHER,               'Other'}], SourceDSLayout);

    dctByID := DICTIONARY(sourceDS, {sourceID => sourceDS});	
    
    
    n := 0;
    
    fn_rollAndConvert(DATASET(DueDiligence.LayoutsInternalReport.IdentitySources) sourceData, BOOLEAN isInputSources) := FUNCTION
        
        //roll data to get first/last seen for a given category
        rollSources := ROLLUP(sourceData,
                              LEFT.seq = RIGHT.seq AND
                              LEFT.inquiredDID = RIGHT.inquiredDID AND
                              LEFT.sourceCategory = RIGHT.sourceCategory,
                              TRANSFORM(DueDiligence.LayoutsInternalReport.IdentitySources,
                                        SELF.sourceCategoryCount := LEFT.sourceCategoryCount + RIGHT.sourceCategoryCount;
                                        SELF.sourceFirstSeen := IF(LEFT.sourceFirstSeen = 0, RIGHT.sourceFirstSeen, LEFT.sourceFirstSeen);
                                        SELF.sourceLastSeen := MAX(LEFT.sourceLastSeen, RIGHT.sourceLastSeen);
                                        SELF := LEFT;));
                                                                                      
        convertSources := PROJECT(rollSources, TRANSFORM(DueDiligence.LayoutsInternalReport.IdentitySources,

                                                          source := DATASET([TRANSFORM(iesp.duediligencepersonreport.t_DDRPersonSources,
                                                                                        SELF.SourceName := LEFT.sourceCategory;
                                                                                        SELF.NumberOfTimesSeen := LEFT.sourceCategoryCount;)]);
        
                                                          SELF.espInputSourceDetails := IF(isInputSources, source, DATASET([], iesp.duediligencepersonreport.t_DDRPersonSources));
                                                          SELF.espBestSourceDetails := IF(isInputSources = FALSE, source, DATASET([], iesp.duediligencepersonreport.t_DDRPersonSources)); 
                                                          
                                                          id := LEFT.sourceID;
                                                          sourceCount := LEFT.sourceCategoryCount;
                                                          firstSeen := iesp.ECL2ESP.toDate(LEFT.sourceFirstSeen);
                                                          lastSeen := iesp.ECL2ESP.toDate(LEFT.sourceLastSeen);
                                                          
                                                          allSrc := PROJECT(sourceDS, TRANSFORM(iesp.duediligencepersonreport.t_DDRPersonLexIDSourcesReporting,
                                                                                                SELF.SourceCategory := LEFT.sourceCategoryText;
                                                                                                SELF.TimesReported := IF(LEFT.sourceID = id, sourceCount, 0);
                                                                                                SELF.FirstReported := IF(LEFT.sourceID = id, firstSeen, DATASET([], iesp.share.t_Date)[1]);
                                                                                                SELF.LastReported := IF(LEFT.sourceID = id, lastSeen, DATASET([], iesp.share.t_Date)[1]);));
                                                                                                      
                                                          SELF.espSourceDetailsWithDates := allSrc;
                                                          
                                                          SELF := LEFT;));
        RETURN convertSources;
    END;


    fn_getRawSources(fieldName, isInputSources) := FUNCTIONMACRO
        normSources := NORMALIZE(inData, LEFT.fieldName.sourceInfo, TRANSFORM(DueDiligence.LayoutsInternalReport.IdentitySources,
                                                                               SELF.seq := LEFT.seq;
                                                                               SELF.inquiredDID := LEFT.inquiredDID;
                                                                               
                                                                               src := RIGHT.source;
                                                                               
                                                                               SELF.source := RIGHT.source;
                                                                               SELF.sourceCount := RIGHT.sourceCount;
                                                                               SELF.sourceFirstSeen := RIGHT.sourceFirstSeen;
                                                                               SELF.sourceLastSeen := RIGHT.sourceLastSeen;
                                                                               
                                                                               id := MAP(src IN MDR.sourceTools.set_credit_header_bureau => SOURCE_ID.BUREAU,
                                                                                          src IN MDR.sourceTools.set_LnPropertyV2 => SOURCE_ID.PROPERTY,
                                                                                          src IN DueDiligence.Constants.SOURCE_IDENTITY_SOURCES_UTILITY => SOURCE_ID.UTILITY,
                                                                                          src IN MDR.sourceTools.set_Voters_v2 => SOURCE_ID.VOTER,
                                                                                          src IN MDR.sourceTools.set_FAA => SOURCE_ID.AIRCRAFT,
                                                                                          src IN MDR.sourceTools.set_Bk => SOURCE_ID.BANKRUPTCY,
                                                                                          src IN MDR.sourceTools.set_WC => SOURCE_ID.WATERCRAFT,
                                                                                          src IN MDR.sourceTools.set_Vehicles => SOURCE_ID.VEHICLE,
                                                                                          src IN MDR.sourceTools.set_DL => SOURCE_ID.DRIVERS_LICENSE,
                                                                                          src IN MDR.sourceTools.set_Liens => SOURCE_ID.LIENS,
                                                                                          src IN MDR.sourceTools.set_Professional_License => SOURCE_ID.PROF_LICENSE,
                                                                                          src IN MDR.sourceTools.set_American_Students_List => SOURCE_ID.STUDENT_DATA,
                                                                                          src IN MDR.sourceTools.set_OKC_Students_List => SOURCE_ID.STUDENT_DATA,
                                                                                          SOURCE_ID.OTHER);
                                                                                                          
                                                                               sourceDetails := dctByID[id];
                                                                               
                                                                               SELF.sourceID := sourceDetails.sourceID;
                                                                               SELF.sourceCategory := sourceDetails.sourceCategoryText;
                                                                               SELF.sourceCategoryCount := RIGHT.sourceCount;
                                                                               SELF.espInputSourceDetails := DATASET([], iesp.duediligencepersonreport.t_DDRPersonSources);
                                                                               SELF.espBestSourceDetails := DATASET([], iesp.duediligencepersonreport.t_DDRPersonSources);
                                                                               SELF.espSourceDetailsWithDates := DATASET([], iesp.duediligencepersonreport.t_DDRPersonLexIDSourcesReporting);));
                           
                           
        sortSources := SORT(normSources, seq, inquiredDID, sourceID, sourceFirstSeen, sourceLastSeen);
        
        rollAndConvert := fn_rollAndConvert(sortSources, isInputSources);

        
        RETURN rollAndConvert;
    ENDMACRO;
    
    
    


    inputSources := fn_getRawSources(inputSSNDetails, TRUE);
    bestSources := fn_getRawSources(bestSSNDetails, FALSE);
    
    
    allSources := SORT(inputSources + bestSources, seq, inquiredDID, sourceID, sourceFirstSeen, sourceLastSeen);
    
    rollInputBestSourcesByInquired := ROLLUP(allSources,
                                              LEFT.seq = RIGHT.seq AND
                                              LEFT.inquiredDID = RIGHT.inquiredDID,
                                              TRANSFORM(DueDiligence.LayoutsInternalReport.IdentitySources,
                                                        SELF.espInputSourceDetails := LEFT.espInputSourceDetails + RIGHT.espInputSourceDetails;
                                                        SELF.espBestSourceDetails := LEFT.espBestSourceDetails + RIGHT.espBestSourceDetails;
                                                        SELF := LEFT;));
    
    

    //take both input and best sources and roll the data to display source reporting section
    rollByAllSources := fn_rollAndConvert(allSources, FALSE);
    
    rollAllSourcesByInquired := ROLLUP(allSources,
                                      LEFT.seq = RIGHT.seq AND
                                      LEFT.inquiredDID = RIGHT.inquiredDID,
                                      TRANSFORM(DueDiligence.LayoutsInternalReport.IdentitySources,
                                      
                                                leftESPSourceDets := LEFT.espSourceDetailsWithDates;
                                                rightESPSourceDets := RIGHT.espSourceDetailsWithDates;
                                                
                                                allSrc := PROJECT(sourceDS, TRANSFORM(iesp.duediligencepersonreport.t_DDRPersonLexIDSourcesReporting,
                                                                                      SELF.SourceCategory := LEFT.sourceCategoryText;
                                                                                      
                                                                                      SELF.TimesReported := leftESPSourceDets[COUNTER].TimesReported + rightESPSourceDets[COUNTER].TimesReported;
                                                                                      
                                                                                      leftFirstSeen := (UNSIGNED4)iesp.ECL2ESP.t_DateToString8(leftESPSourceDets[COUNTER].FirstReported);
                                                                                      rightFirstSeen := (UNSIGNED4)iesp.ECL2ESP.t_DateToString8(rightESPSourceDets[COUNTER].FirstReported);
                                                                                      
                                                                                      firstSeen := IF(leftFirstSeen = 0, rightFirstSeen, leftFirstSeen);
                                                                                      
                                                                                      leftLastSeen := (UNSIGNED4)iesp.ECL2ESP.t_DateToString8(leftESPSourceDets[COUNTER].LastReported);
                                                                                      rightLastSeen := (UNSIGNED4)iesp.ECL2ESP.t_DateToString8(rightESPSourceDets[COUNTER].LastReported);
                                                                                      
                                                                                      lastSeen := MAX(leftLastSeen, rightLastSeen);
                                                                                                                
                                                                                      SELF.FirstReported := iesp.ECL2ESP.toDate(firstSeen);
                                                                                      SELF.LastReported := iesp.ECL2ESP.toDate(lastSeen);));

                                                
                                                SELF.espSourceDetailsWithDates := allSrc;
                                                SELF := LEFT;));
                                                
    
    //combine the best/input sources with that of all(both input and best)
    combineSources := JOIN(rollInputBestSourcesByInquired, rollAllSourcesByInquired,
                            LEFT.seq = RIGHT.seq AND
                            LEFT.inquiredDID = RIGHT.inquiredDID,
                            TRANSFORM(DueDiligence.LayoutsInternalReport.IdentitySources,
                                      SELF.espInputSourceDetails := CHOOSEN(LEFT.espInputSourceDetails, iesp.constants.DDRAttributesConst.MaxReportingSources);
                                      SELF.espBestSourceDetails := CHOOSEN(LEFT.espBestSourceDetails, iesp.constants.DDRAttributesConst.MaxReportingSources);
                                      SELF.espSourceDetailsWithDates := CHOOSEN(RIGHT.espSourceDetailsWithDates, iesp.constants.DDRAttributesConst.MaxReportingSources);
                                      SELF.sourceCategoryCount := COUNT(RIGHT.espSourceDetailsWithDates(TimesReported > 0)); 
                                      SELF := LEFT;));
                            






    // OUTPUT(inputSources, NAMED('inputSources'));
    // OUTPUT(bestSources, NAMED('bestSources'));
    // OUTPUT(allSources, NAMED('allSources'));
    // OUTPUT(rollInputBestSourcesByInquired, NAMED('rollInputBestSourcesByInquired'));
    // OUTPUT(rollByAllSources, NAMED('rollByAllSources'));
    // OUTPUT(rollAllSourcesByInquired, NAMED('rollAllSourcesByInquired'));
    // OUTPUT(combineSources, NAMED('combineSources'));


    RETURN combineSources;
END;