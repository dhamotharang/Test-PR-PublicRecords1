IMPORT Business_Risk, BIPV2, Business_Risk_BIP, DueDiligence, Corp2, business_header, STD, UT;


EXPORT getBusSOSDetail(DATASET(DueDiligence.Layouts.Busn_Internal) inData,
												Business_Risk_BIP.LIB_Business_Shell_LIBIN options,
												BOOLEAN includeAllBusinessData,
												BOOLEAN includeReportData) := FUNCTION



    //add linked businesses
    linkedBus := DueDiligence.Common.getLinkedBusinesses(inData);
    allBusinesses := inData + linkedBus;
    
    corpFilingsFilt := DueDiligence.getBusSOSDetailImpl.getFilteredData(allBusinesses, options);
    
    //if we are processing from a business perspective, we want all data
    //if we are processing from a person perspective, we only need certain information about the business
    sosDataOptions := MODULE(DueDiligence.DataInterface.iSOS)
                                EXPORT BOOLEAN includeIncorporationDate := FALSE;
                                EXPORT BOOLEAN includeCorporateFilingDate := FALSE;
                                EXPORT BOOLEAN includeOperatingLocataions := FALSE;
                                EXPORT BOOLEAN includeSICNAICS := TRUE;
                                EXPORT BOOLEAN includeFilingStatuses := FALSE;
                                EXPORT BOOLEAN includeIncorporatedWithLooseLaws := FALSE;
                                EXPORT BOOLEAN includeRegisteredAgents := TRUE;
                                EXPORT BOOLEAN includeAll := includeAllBusinessData;
                         END;
    
    //if requesting incorporation date
    addIncDate := IF(sosDataOptions.includeAll OR sosDataOptions.includeIncorporationDate, DueDiligence.getBusSOSDetailImpl.getIncorporationDate(inData, corpFilingsFilt), inData);

    //if requesting filing date
    addEverFiled := IF(sosDataOptions.includeAll OR sosDataOptions.includeCorporateFilingDate, DueDiligence.getBusSOSDetailImpl.getFilingDate(addIncDate, corpFilingsFilt), addIncDate);
    
    //if requesting operating locations
    addBusnLocCnt := IF(sosDataOptions.includeAll OR sosDataOptions.includeOperatingLocataions, DueDiligence.getBusSOSDetailImpl.getOperatingLocations(addEverFiled, corpFilingsFilt), addEverFiled);
    
    //if requesting SIC/NAICS
    addCorpSicNaic := IF(sosDataOptions.includeAll OR sosDataOptions.includeSICNAICS, DueDiligence.getBusSOSDetailImpl.getSICNAICS(addBusnLocCnt, corpFilingsFilt), addBusnLocCnt);
    
    //if requesting filing statuses
    addSosStatusDates := IF(sosDataOptions.includeAll OR sosDataOptions.includeFilingStatuses, DueDiligence.getBusSOSDetailImpl.getFilingStatuses(addCorpSicNaic, corpFilingsFilt), addCorpSicNaic);
    
    //if requesting incorporations with loose laws
    addIncLooseLaws := IF(sosDataOptions.includeAll OR sosDataOptions.includeIncorporatedWithLooseLaws, DueDiligence.getBusSOSDetailImpl.getIncoprorationWithLooseLaws(addSosStatusDates, corpFilingsFilt), addSosStatusDates);
    
    //if requesting incorporations with loose laws
    addAgents := IF(sosDataOptions.includeAll OR sosDataOptions.includeRegisteredAgents, DueDiligence.getBusSOSDetailImpl.getRegisteredAgents(addIncLooseLaws, corpFilingsFilt), addIncLooseLaws);
    



    // ------ START BUILDING SECTIONS of the REPORT  - pass a slimmed down version of the corpFilingsFilt
    busSOSFilingsSlim   := PROJECT(corpFilingsFilt, TRANSFORM(DueDiligence.LayoutsInternalReport.BusCorpFilingsSlimLayout,
                                                                                                                         
                                                             tempActiveFilingStatus := DueDiligence.CommonBusiness.GetSOSStatuses(LEFT);
                                                             
                                                             SELF.isActive            := tempActiveFilingStatus = DueDiligence.Constants.CORP_STATUS_ACTIVE;                             
                                                             SELF.BusinessName        := LEFT.corp_legal_name;
                                                             SELF.FilingStatus        := MAP(tempActiveFilingStatus = DueDiligence.Constants.CORP_STATUS_ACTIVE => DueDiligence.Constants.TEXT_CORP_STATUS_ACTIVE,
                                                                                              tempActiveFilingStatus = DueDiligence.Constants.CORP_STATUS_INACTIVE => DueDiligence.Constants.TEXT_CORP_STATUS_INACTIVE,
                                                                                              tempActiveFilingStatus = DueDiligence.Constants.CORP_STATUS_DISSOLVED => DueDiligence.Constants.TEXT_CORP_STATUS_DISSOLVED,
                                                                                              tempActiveFilingStatus = DueDiligence.Constants.CORP_STATUS_REINSTATE => DueDiligence.Constants.TEXT_CORP_STATUS_REINSTATE,
                                                                                              tempActiveFilingStatus = DueDiligence.Constants.CORP_STATUS_SUSPEND => DueDiligence.Constants.TEXT_CORP_STATUS_SUSPEND,
                                                                                              DueDiligence.Constants.TEXT_COPR_STATUS_OTHER); 
                                                             SELF.FilingDate          := LEFT.corp_filing_date;   //*** Zeros if the business was not file with Sec. Of State (SOS).
                                                             SELF.IncorporationDate   := (INTEGER)LEFT.corp_inc_date;
                                                             SELF.LastSeenDate        := IF(LEFT.dt_last_seen > 0, LEFT.dt_last_seen, LEFT.dt_vendor_last_reported);      //**** This dt_last_seen has been cleaned
                                                             SELF.CorpKey             := LEFT.corp_key;
                                                            
                                                            
                                                            
                                                             SELF.FilingNumber        := LEFT.corp_sos_charter_nbr;
                                                             SELF.FilingType          := LEFT.corp_filing_desc;
                                                             SELF.IncorporationState  := LEFT.corp_inc_state;
                                                             SELF.OrgStructure        := LEFT.corp_orig_org_structure_desc;
                                                             
                                                             SELF                     := LEFT;
                                                             SELF                     := [];));   
 
    
    
    
    updateBusnSOSWithReport  := IF(includeReportData, DueDiligence.reportBusSOSFilings(addAgents, busSOSFilingsSlim), addAgents); 
	
	


    // OUTPUT(corpFilingsFilt, NAMED('corpFilingsFilt'));
    // OUTPUT(addIncDate, NAMED('addIncDate'));
    // OUTPUT(addEverFiled, NAMED('addEverFiled'));
    // OUTPUT(addBusnLocCnt, NAMED('addBusnLocCnt'));
    // OUTPUT(addCorpSicNaic, NAMED('addCorpSicNaic'));
    // OUTPUT(addSosStatusDates, NAMED('addSosStatusDates'));
    // OUTPUT(addIncLooseLaws, NAMED('addIncLooseLaws'));
    // OUTPUT(addAgents, NAMED('addAgentsSOS'));
    // OUTPUT(updateBusnSOSWithReport, NAMED('updateBusnSOSWithReport'));	
    
      
    RETURN updateBusnSOSWithReport;
END;