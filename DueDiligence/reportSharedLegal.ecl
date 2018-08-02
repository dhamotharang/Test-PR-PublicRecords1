IMPORT BIPv2, DueDiligence, iesp, Suppress;


EXPORT reportSharedLegal := MODULE

  EXPORT getDDRLegalEventCriminalWithMasking(DATASET(DueDiligence.LayoutsInternalReport.FlatListOfIndividualsWithCriminalLayout) listOfIndAndOffenses, STRING6 ssnMasking) := FUNCTION
     
      Suppress.MAC_Mask(listOfIndAndOffenses, maskSSNInListOfIndividuals, ssn, '', TRUE, FALSE,,,,ssnMasking);
     
      sortMaskedList := SORT(maskSSNInListOfIndividuals, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did, -crimData.source, -crimData.offenseDDFirstReportedActivity, crimData.caseNumber);
      groupMaskedList := GROUP(sortMaskedList, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did);
      
      
      DueDiligence.LayoutsInternalReport.ReportingOfIndvCriminalChildDatasetLayout limitOffenses(groupMaskedList le, INTEGER offenseCount) := TRANSFORM, 
                                                                                                SKIP(offenseCount > iesp.constants.DDRAttributesConst.MaxLegalEvents)
          SELF.seq                    := le.seq;
          SELF.ultID                  := le.ultID;
          SELF.orgID                  := le.orgID;
          SELF.seleID                 := le.seleID;
          SELF.did                    := le.did;
          SELF.Name.Full              := le.fullName;
          SELF.Name.First             := le.firstName;
          SELF.Name.Last              := le.lastName;
          SELF.Name.Middle            := le.middleName;
          SELF.Name.Suffix            := le.suffix;
          SELF.Address.StreetNumber   := le.prim_range;
          SELF.Address.StreetPreDirection := le.predir;
          SELF.Address.StreetName     := le.prim_name;
          SELF.Address.StreetSuffix   := le.addr_suffix;
          SELF.Address.StreetPostDirection := le.postdir;
          SELF.Address.UnitDesignation := le.unit_desig;
          SELF.Address.UnitNumber      := le.sec_range;    
          SELF.Address.StreetAddress1  := le.streetAddress1;
          SELF.Address.StreetAddress2  := le.streetAddress2;
          SELF.Address.City            := le.city;
          SELF.Address.State           := le.state;
          SELF.Address.Zip5            := le.zip5;
          SELF.Address.Zip4            := le.zip4;
          SELF.Address.County          := le.county;      
          SELF.Address.PostalCode      := le.zip5 + le.zip4;                             
          SELF.Address.StateCityZip    := TRIM(le.state) + TRIM(le.city) + TRIM(le.zip5);
          SELF.lexid                   := (STRING)le.did;
          SELF.ExecTitle               := le.mostRecentTitle;
          SELF.SSN                     := le.ssn;
          SELF.DOB                     := iesp.ECL2ESP.toDate(le.DOB);
          SELF.criminalChildDS := PROJECT(le.crimData, TRANSFORM(iesp.duediligenceshared.t_DDRLegalStateCriminal,
          
                                                           //top level data
                                                           SELF.State := LEFT.state;
                                                           SELF.Source := LEFT.source;
                                                           SELF.CaseNumber := LEFT.caseNumber;
                                                           SELF.OffenseStatute := LEFT.offenseStatute;
                                                           SELF.OffenseDDFirstReported := iesp.ECL2ESP.toDatestring8(LEFT.offenseDDFirstReportedActivity);
                                                           SELF.OffenseDDLastReportedActivity := iesp.ECL2ESP.toDate(LEFT.offenseDDLastReportedActivity);
                                                           // SELF.OffenseDDMostRecentCourtDispDate := iesp.ECL2ESP.toDate(LEFT.offenseDDLastCourtDispDate);
                                                           SELF.OffenseDDLegalEventTypeMapped := DueDiligence.translateExpression.expressionTextByEnum(LEFT.offenseDDLegalEventTypeCode);
                                                           SELF.OffenseCharge := LEFT.offenseCharge;
                                                           SELF.OffenseDDChargeLevelCalculated := DueDiligence.translateCodeToText.OffenseLevelText(LEFT.offenseDDChargeLevelCalculated);
                                                           SELF.OffenseChargeLevelReported := LEFT.offenseChargeLevelReported;
                                                           SELF.OffenseConviction := DueDiligence.translateCodeToText.YesNoUnknownText(LEFT.offenseConviction);
                                                           SELF.OffenseIncarcerationProbationParole := LEFT.offenseIncarcerationProbationParole;
                                                           SELF.OffenseTrafficRelated := DueDiligence.translateCodeToText.YesNoUnknownText(LEFT.offenseTrafficRelated);
              
                                                           // additional details
                                                           SELF.County := LEFT.county;
                                                           SELF.CountyCourt := LEFT.countyCourt;
                                                           SELF.City := LEFT.city;
                                                           SELF.Agency := LEFT.agency;
                                                           SELF.Race := LEFT.race;
                                                           SELF.Sex := DueDiligence.translateCodeToText.GenderText(LEFT.sex);
                                                           SELF.HairColor := LEFT.hairColor;
                                                           SELF.EyeColor := LEFT.eyeColor;
                                                           SELF.Height := LEFT.height;
                                                           SELF.Weight := LEFT.weight;
                                                           
                                                           //sort the sources as if there is more than our dataset can handle, we value certain data more so than others
                                                           sortedSources := SORT(LEFT.sources, -source);
                                                           
                                                           // sources
                                                           SELF.Sources := PROJECT(sortedSources[1..iesp.Constants.DDRAttributesConst.MaxLegalSources], 
                                                                                   TRANSFORM(iesp.duediligenceshared.t_DDRLegalSourceInfo,
                                                                                              SELF.OffenseCharge := LEFT.offenseCharge;
                                                                                              SELF.OffenseConviction := DueDiligence.translateCodeToText.YesNoUnknownText(LEFT.offenseConviction);
                                                                                              SELF.OffenseChargeLevelCalculated := DueDiligence.translateCodeToText.OffenseLevelText(LEFT.offenseChargeLevelCalculated);
                                                                                              SELF.OffenseChargeLevelReported := LEFT.offenseChargeLevelReported;
                                                                                              SELF.Source := LEFT.source;
                                                                                              SELF.CourtDisposition1 := LEFT.courtDisposition1;
                                                                                              SELF.CourtDisposition2 := LEFT.courtDisposition2;
                                                                                              SELF.OffenseReportedDate := iesp.ECL2ESP.toDate(LEFT.offenseReportedDate);
                                                                                              SELF.OffenseArrestDate := iesp.ECL2ESP.toDate(LEFT.offenseArrestDate);
                                                                                              SELF.OffenseCourtDispDate := iesp.ECL2ESP.toDate(LEFT.offenseCourtDispDate);
                                                                                              SELF.OffenseAppealDate := iesp.ECL2ESP.toDate(LEFT.offenseAppealDate);
                                                                                              SELF.OffenseSentenceDate := iesp.ECL2ESP.toDate(LEFT.offenseSentenceDate);
                                                                                              SELF.OffenseSentenceStartDate := iesp.ECL2ESP.toDate(LEFT.offenseSentenceStartDate);
                                                                                              SELF.DOCConvictionOverrideDate := iesp.ECL2ESP.toDate(LEFT.DOCConvictionOverrideDate);
                                                                                              SELF.DOCScheduledReleaseDate := iesp.ECL2ESP.toDate(LEFT.DOCScheduledReleaseDate);
                                                                                              SELF.DOCActualReleaseDate := iesp.ECL2ESP.toDate(LEFT.DOCActualReleaseDate);
                                                                                              SELF.DOCInmateStatus := LEFT.DOCInmateStatus;
                                                                                              SELF.DOCParoleStatus := LEFT.DOCParoleStatus;
                                                                                              SELF.OffenseMaxTerm := LEFT.offenseMaxTerm;
                                                                                              SELF.PartyNames := PROJECT(LEFT.partyNames[1..iesp.Constants.DDRAttributesConst.MaxLegalPartyNames], 
                                                                                                                         TRANSFORM(iesp.share.t_StringArrayItem,
                                                                                                                                   SELF.value := LEFT.name;));));));
          SELF := [];      
      END;
     
     
      limitedReportRecords := UNGROUP(PROJECT(groupMaskedList, limitOffenses(LEFT, COUNTER)));
     
          
      //perform the ROLLUP by LINKID And DID
      sortCrimOffense := SORT(limitedReportRecords, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did);
      rollupCriminalOffense := ROLLUP(sortCrimOffense,
                                       #EXPAND(DueDiligence.Constants.mac_JOINLinkids_Results()) AND
                                       LEFT.did = RIGHT.did,
                                       TRANSFORM(RECORDOF(LEFT),
                                                 SELF.criminalChildDS := LEFT.criminalChildDS + RIGHT.criminalChildDS,
                                                 SELF := LEFT));







      // OUTPUT(sortMaskedList, NAMED('sortMaskedList'));
      // OUTPUT(limitedReportRecords, NAMED('limitedReportRecords'));
      // OUTPUT(rollupCriminalOffense, NAMED('rollupCriminalOffense'));


      RETURN rollupCriminalOffense;                                         
  END;

END;