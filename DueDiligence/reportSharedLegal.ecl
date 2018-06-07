IMPORT BIPv2, DueDiligence, iesp, Suppress;


EXPORT reportSharedLegal := MODULE

  EXPORT getDDRLegalEventCriminalWithMasking(DATASET(DueDiligence.LayoutsInternalReport.FlatListOfIndividualsWithCriminalLayout) listOfIndAndOffenses, STRING6 ssnMasking) := FUNCTION
     
      Suppress.MAC_Mask(listOfIndAndOffenses, maskSSNInListOfIndividuals, ssn, '', TRUE, FALSE,,,,ssnMasking);
     
      sortMaskedList := SORT(maskSSNInListOfIndividuals, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did, -earliestOffenseDate, offensescore);
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
          SELF.criminalChildDS   := PROJECT(le, TRANSFORM(iesp.duediligenceshared.t_DDRLegalEventCriminal,
                                                           //offense details
                                                           SELF.CaseNumber               := LEFT.caseNum; 
                                                           SELF.CourtType                := LEFT.courtType;
                                                           SELF.CaseTypeDescription      := LEFT.caseTypeDesc;  //to be removed at later date replaced with CaseType
                                                           SELF.CaseType                 := LEFT.caseTypeDesc; 
                                                           SELF.ArrestLevelDescription   := LEFT.arrestLevel;  //to be removed at later date replaced with ArrestLevel
                                                           SELF.ArrestLevel              := LEFT.arrestLevel;
                                                           SELF.OffenseScore             := LEFT.offenseScore;  //??? Is this or OffenseScoreDescription displayed on web and are both needed??
                                                           SELF.OffenseScoreDescription  := DueDiligence.translateCodeToText.OffenseScoreText(LEFT.offenseScore);  //??? Is this or OffenseScore displayed on web and are both needed??
                                                           SELF.OffenseLevel             := LEFT.criminalOffenderLevel; //??? Is this or OffenseLevelDescription displayed on web and are both needed??
                                                           SELF.OffenseLevelDescription  := DueDiligence.translateCodeToText.OffenseLevelText(LEFT.criminalOffenderLevel); //??? Is this or OffenseLevel displayed on web and are both needed??
                                                           temp_answer                   := DueDiligence.DictionaryValues_LegalEvents.ReportLegalEventTypeDesc[LEFT.legalEventTypeCode];  
                                                           SELF.LegalEventType           := temp_answer.LegalEventTypeDescription;
                                                           SELF.NumberOfCounts           := LEFT.num_of_counts;
                                                           SELF.Conviction               := LEFT.convictionFlag;
                                                           SELF.Charge                   := LEFT.Charge;
                                                           SELF.DispositionDescription1  := LEFT.courtDispDesc1;
                                                           SELF.DispositionDescription2  := LEFT.courtDispDesc2;
                                                           SELF.FederalOrState           := DueDiligence.translateCodeToText.LegalStateFederalText(LEFT.stateFederalData);
                                                           SELF.TrafficRelated           := LEFT.trafficFlag;   //to be removed at later date 
                                                           SELF.TrafficRelatedOffense    := LEFT.trafficFlag = DueDiligence.Constants.YES;
                                                           SELF.CourtStatute             := LEFT.courtStatute;
                                                           SELF.CourtStatuteDescription  := LEFT.courtStatuteDesc; 
                                                           
                                                           //offense dates
                                                           SELF.EarliestOffenseDate  := iesp.ECL2ESP.toDatestring8(LEFT.earliestOffenseDate);
                                                           SELF.OffenseDate          := iesp.ECL2ESP.toDatestring8(LEFT.offenseDate);
                                                           SELF.ArrestDate           := iesp.ECL2ESP.toDatestring8(LEFT.arrestDate);
                                                           SELF.CourtDispositionDate := iesp.ECL2ESP.toDatestring8(LEFT.courtDispDate);
                                                           SELF.SentenceDate         := iesp.ECL2ESP.toDatestring8(LEFT.sentenceDate);
                                                           SELF.AppealDate           := iesp.ECL2ESP.toDatestring8(LEFT.appealDate);
                                                           SELF.IncarcerationDate    := iesp.ECL2ESP.toDatestring8(LEFT.incarcerationDate);
                                                           SELF.IncarcerationReleaseDate := iesp.ECL2ESP.toDatestring8(LEFT.incarcerationReleaseDate);
                                                           
                                                           //offense locations
                                                           SELF.OffenseState := LEFT.offenseState;
                                                           SELF.OffenseCounty := LEFT.offenseCounty;
                                                           SELF.CourtCounty := LEFT.courtCounty;
                                                           SELF.OffenseCity := LEFT.offenseCity;
                                                           SELF.Agency := LEFT.agency;
                                                           
                                                           //person details
                                                           SELF.Race := LEFT.race;
                                                           SELF.Sex := DueDiligence.translateCodeToText.GenderText(LEFT.sex);
                                                           SELF.HairColor := LEFT.hairColor;
                                                           SELF.EyeColor := LEFT.eyeColor;
                                                           SELF.Height := LEFT.height;
                                                           SELF.Weight := LEFT.weight;
                                                           SELF.Citizenship := LEFT.citizenship;
                                                           
                                                           //other details
                                                           SELF.Incarceration :=  LEFT.Ever_incarc_offenders = DueDiligence.Constants.YES OR 
                                                                                  LEFT.Ever_incarc_offenses  = DueDiligence.Constants.YES OR
                                                                                  LEFT.Ever_incarc_punishments = DueDiligence.Constants.YES;   
                                                                                      
                                                           SELF.CurrentIncarceration := LEFT.Curr_incarc_offenders = DueDiligence.Constants.YES OR
                                                                                        LEFT.Curr_incarc_offenses  = DueDiligence.Constants.YES OR
                                                                                        LEFT.Curr_incarc_punishments = DueDiligence.Constants.YES; 
                                                                                                                                     
                                                           SELF.CurrentParole            := LEFT.Curr_parole_flag = DueDiligence.Constants.YES;  
                                                           SELF.CurrentProbation         := LEFT.currentProbation = DueDiligence.Constants.YES; 
                                                           SELF.ProbationSentence        := LEFT.probationSentence; 

                                                           SELF                          := [];));
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


      RETURN rollupCriminalOffense;                                         
  END;

END;