IMPORT BIPV2, Business_Risk_BIP, BusinessInstantID20_Services, DueDiligence, STD, MDR;


EXPORT getBusHeader(DATASET(DueDiligence.Layouts.Busn_Internal) inData,
                    Business_Risk_BIP.LIB_Business_Shell_LIBIN options,
                    BIPV2.mod_sources.iParams linkingOptions,
                    BOOLEAN includeAllBusinessData,
                    BOOLEAN includeReportData) := FUNCTION
	
  
  
    //add linked businesses
    linkedBus := DueDiligence.Common.getLinkedBusinesses(inData);
    
    allBusinesses := inData + linkedBus;	

    busHeaderFilt := DueDiligence.getBusHeaderImpl.getFilteredData(inData, options, linkingOptions);
    
    //if we are processing from a business perspective, we want all data
    //if we are processing from a person perspective, we only need certain information about the business
    regBusDataOptions := MODULE(DueDiligence.DataInterface.iHeader)
                                EXPORT BOOLEAN includeFirstLastSeen := FALSE;
                                EXPORT BOOLEAN includeAllSources := FALSE;
                                EXPORT BOOLEAN includeCreditSources := FALSE;
                                EXPORT BOOLEAN includeShellSources := FALSE;		
                                EXPORT BOOLEAN includeFirstSeenFromNonCreditSources := FALSE;
                                EXPORT BOOLEAN includeOperatingLocataions := FALSE;
                                EXPORT BOOLEAN includeBusinessStructure := TRUE;
                                EXPORT BOOLEAN includeSICNAICS := TRUE;
                                EXPORT BOOLEAN includeFirstSeenCleanedInputAddress := FALSE;
                                EXPORT BOOLEAN includeFEIN := FALSE;
                                EXPORT BOOLEAN includeIncorporatedWithLooseLaws := FALSE;
                                EXPORT BOOLEAN includeUniquePowIDsForASeleID := TRUE;
                                EXPORT BOOLEAN includeIfFoundInHeaderData := FALSE;
                                EXPORT BOOLEAN includeAll := includeAllBusinessData;
                         END;
  
    
    //if requesting header first and last seen dates
    addBusHdrDtSeen := IF(regBusDataOptions.includeAll OR regBusDataOptions.includeFirstLastSeen, DueDiligence.getBusHeaderImpl.getFirstLastSeen(inData, busHeaderFilt), inData);
    
    //if requesting all sources
    addHdrSrcCnt := IF(regBusDataOptions.includeAll OR regBusDataOptions.includeAllSources, DueDiligence.getBusHeaderImpl.getAllSources(addBusHdrDtSeen, busHeaderFilt), addBusHdrDtSeen);
    
    //if requesting credit sources
    addCreditSrcCnt := IF(regBusDataOptions.includeAll OR regBusDataOptions.includeCreditSources, DueDiligence.getBusHeaderImpl.getCreditSources(addHdrSrcCnt, busHeaderFilt), addHdrSrcCnt);
    
    //if requesting the first seen date from non credit sources
    addNonCreditFirstSeen := IF(regBusDataOptions.includeAll OR regBusDataOptions.includeFirstSeenFromNonCreditSources, DueDiligence.getBusHeaderImpl.getNonCreditFirstSeenDate(addCreditSrcCnt, busHeaderFilt), addCreditSrcCnt);
    
    //if requesting shell sources
    addShellSrcCnt := IF(regBusDataOptions.includeAll OR regBusDataOptions.includeShellSources, DueDiligence.getBusHeaderImpl.getShellSources(addNonCreditFirstSeen, busHeaderFilt), addNonCreditFirstSeen);

    //if requesting operating locations
    addHdrAddrCount := IF(regBusDataOptions.includeAll OR regBusDataOptions.includeOperatingLocataions, DueDiligence.getBusHeaderImpl.getOperatingLocations(addShellSrcCnt, busHeaderFilt), addShellSrcCnt);
      
    //if requesting structure
    addStructure := IF(regBusDataOptions.includeAll OR regBusDataOptions.includeBusinessStructure, DueDiligence.getBusHeaderImpl.getStructure(addHdrAddrCount, busHeaderFilt), addHdrAddrCount);
      
    //if requesting SIC/NAICs
    addSicNaic := IF(regBusDataOptions.includeAll OR regBusDataOptions.includeSICNAICS, DueDiligence.getBusHeaderImpl.getSICNAICS(addStructure, busHeaderFilt), addStructure);
      
    //if requesting first seen cleaned input address
    addAddrFirstSeen := IF(regBusDataOptions.includeAll OR regBusDataOptions.includeFirstSeenCleanedInputAddress, DueDiligence.getBusHeaderImpl.getFirstSeenCleanedInputAddress(addSicNaic, busHeaderFilt), addSicNaic);
      
    //if requesting FEIN
    addNoFein := IF(regBusDataOptions.includeAll OR regBusDataOptions.includeFEIN, DueDiligence.getBusHeaderImpl.getFEIN(addAddrFirstSeen, busHeaderFilt), addAddrFirstSeen);
      
    //if requesting incorporated in a state with loose laws
    addIncLooseLaws := IF(regBusDataOptions.includeAll OR regBusDataOptions.includeIncorporatedWithLooseLaws, DueDiligence.getBusHeaderImpl.getIncoprorationWithLooseLaws(addNoFein, busHeaderFilt), addNoFein);
      
    //if requesting unique POWIDs
    addUniquePows := IF(regBusDataOptions.includeAll OR regBusDataOptions.includeUniquePowIDsForASeleID, DueDiligence.getBusHeaderImpl.getUniquePowIDs(addIncLooseLaws, busHeaderFilt), addIncLooseLaws);
  
    //if requesting if exists in header
    addNotFound := IF(regBusDataOptions.includeAll OR regBusDataOptions.includeIfFoundInHeaderData, DueDiligence.getBusHeaderImpl.getExistsInHeader(addUniquePows, busHeaderFilt), addUniquePows);
  

    //If report is requested retrieve data for report only                    
    addAdditionalHeaderReportData := IF(includeReportData, DueDiligence.getBusHeaderReportData(busHeaderFilt, addNotFound, options, linkingOptions), addNotFound);                      
                      

																		




    // OUTPUT(busHeaderFilt, NAMED('busHeaderFilt'));
    // OUTPUT(addBusHdrDtSeen, NAMED('addBusHdrDtSeen'));
    // OUTPUT(addHdrSrcCnt, NAMED('addHdrSrcCnt'));
    // OUTPUT(addCreditSrcCnt, NAMED('addCreditSrcCnt'));
    // OUTPUT(addNonCreditFirstSeen, NAMED('addNonCreditFirstSeen'));	
    // OUTPUT(addShellSrcCnt, NAMED('addShellSrcCnt'));
    // OUTPUT(addHdrAddrCount, NAMED('addHdrAddrCount'));
    // OUTPUT(addStructure, NAMED('addStructure'));
    // OUTPUT(addSicNaic, NAMED('addSicNaic'));
    // OUTPUT(addAddrFirstSeen, NAMED('addAddrFirstSeen'));
    // OUTPUT(addNoFein, NAMED('addNoFein'));
    // OUTPUT(addIncLooseLaws, NAMED('addIncLooseLaws'));														
    // OUTPUT(addUniquePows, NAMED('addUniquePows'));	
    // OUTPUT(addNotFound, NAMED('addNotFound'));	
    // OUTPUT(addAdditionalHeaderReportData, NAMED('addAdditionalHeaderReportData'));	
    
 
    
    RETURN addAdditionalHeaderReportData;										
											
END;