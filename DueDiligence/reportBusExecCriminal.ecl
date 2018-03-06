
IMPORT Address, BIPV2, Business_Risk_BIP, LN_PropertyV2, MDR, DueDiligence, UT, iesp, Census_Data;

EXPORT reportBusExecCriminal(DATASET(DueDiligence.layouts.Busn_Internal) InputBusnCriminal, 
                             DATASET(DueDiligence.LayoutsInternal.RelatedParty) InputBusinessExecutivesCriminalOffense,
                             boolean DebugMode = FALSE) := FUNCTION

  
 //*** add logic here to SORT the list of offenses that are added to the report so that only the oldest ones are truncated  ****//	
	 BEOCriminalOffensesInternal := NORMALIZE(InputBusnCriminal, LEFT.execs.partyOffenses, TRANSFORM(DueDiligence.LayoutsInternalReport.BEOCriminalReportingOFOffenses,
                             /*  start by getting all of the criminal offenses from the Parent (RIGHT) */  																														
																												SELF.seq                  := LEFT.seq;
																												SELF.ultID                := LEFT.Busn_info.BIP_IDS.UltID.LinkID;
																												SELF.orgID                := LEFT.Busn_info.BIP_IDS.OrgID.LinkID;
																												SELF.seleID               := LEFT.Busn_info.BIP_IDS.SeleID.LinkID;
																												SELF.ReportOfOffenses     := RIGHT;
																												SELF                      := [];));
                                                        												
	// ------                                                                       ------
  // ------ populate the ChildDataset  with the list of OFFENSES                  ------
  // ------ by building a DATASET we can INSERT the entire ChiledDATASET          ------
  // ------ as a 'WHOLE' into the DATASET defined within the PARENT               ------
	// ------                                                                       ------
	iesp.duediligenceshared.t_DDRLegalEventCriminal  FormatTheListOfOffenses(BEOCriminalOffensesInternal le, Integer OffenseCount) := TRANSFORM,
	                                                 SKIP(OffenseCount > iesp.constants.DDRAttributesConst.MaxLegalEvents)         
																							     SELF.CaseNumber               := le.ReportOfOffenses.caseNum;    
																							     SELF.OffenseScore             := le.ReportOfOffenses.offenseScore;
																								   SELF.OffenseScoreDescription  := DueDiligence.Common.getOffenseScoreDescription(le.ReportOfOffenses.offenseScore);  
																									 SELF.OffenseLevel             := le.ReportOfOffenses.criminalOffenderLevel;
																									 SELF.OffenseLevelDescription  := DueDiligence.Common.getOffenseLevelDescription(le.ReportOfOffenses.criminalOffenderLevel);
                                                   SELF.Conviction               := le.ReportOfOffenses.convictionFlag;
                                                   SELF.TrafficRelated           := le.ReportOfOffenses.trafficFlag;
                                                   SELF.CourtType                := le.ReportOfOffenses.courtType;
                                                   SELF.CaseTypeDescription      := le.ReportOfOffenses.caseTypeDesc; 
                                                   SELF.ArrestLevelDescription   := le.ReportOfOffenses.arr_off_lev_mapped;
                                                   SELF.CourtStatute             := le.ReportOfOffenses.courtStatute;
                                                   SELF.CourtStatuteDescription  := le.ReportOfOffenses.courtStatuteDesc; 
                                                   SELF.Charge                   := le.ReportOfOffenses.Charge;
                                                   SELF.NumberOfCounts           := le.ReportOfOffenses.num_of_counts;  
                                                   SELF.DispositionDescription1  := le.ReportOfOffenses.courtDispDesc1;
                                                   SELF.DispositionDescription2  := le.ReportOfOffenses.courtDispDesc2;
                                                   SELF.ProbationSentence        := le.ReportOfOffenses.sent_probation; 
                                                   SELF.Incarceration            := MAP(
                                                                                        le.ReportOfOffenses.Ever_incarc_offenders =   'Y'  => TRUE, 
                                                                                        le.ReportOfOffenses.Ever_incarc_offenses  =   'Y'  => TRUE,
                                                                                        le.ReportOfOffenses.Ever_incarc_punishments = 'Y'  => TRUE, 
                                                                                                                                              FALSE);  
                                                   SELF.CurrentIncarceration     := MAP(
                                                                                        le.ReportOfOffenses.Curr_incarc_offenders = 'Y'    => TRUE,
                                                                                        le.ReportOfOffenses.Curr_incarc_offenses  = 'Y'    => TRUE,
                                                                                        le.ReportOfOffenses.Curr_incarc_punishments = 'Y'  => TRUE, 
                                                                                                                                              FALSE);
                                                   SELF.CurrentParole            := IF(le.ReportOfOffenses.Curr_parole_flag = 'Y', TRUE, FALSE);
                                                   SELF.CurrentProbation         := FALSE;
                                                   SELF.EarliestOffenseDate.Year := (Integer)le.ReportOfOffenses.earliestOffenseDate[1..4];
                                                   SELF.EarliestOffenseDate.Month := (Integer)le.ReportOfOffenses.earliestOffenseDate[5..6];
                                                   SELF.EarliestOffenseDate.Day  := (Integer)le.ReportOfOffenses.earliestOffenseDate[7..8];

                                                   SELF.OffenseDate.Year         := (Integer)le.ReportOfOffenses.offenseDate[1..4];
                                                   SELF.OffenseDate.Month        := (Integer)le.ReportOfOffenses.offenseDate[5..6];
                                                   SELF.OffenseDate.Day          := (Integer)le.ReportOfOffenses.offenseDate[7..8];
			                                             SELF                          := [];
																               END;  
	 
	  
BusExecCriminalChildDataset  :=   
	PROJECT(BEOCriminalOffensesInternal,                                                        //***Using this input dataset  
			TRANSFORM(DueDiligence.LayoutsInternalReport.ReportingofBEOCriminalChildDatasetLayout,  //***format the data according to this layout.
				#EXPAND (DueDiligence.Constants.mac_TRANSFORMLinkids())                               //***This is the sequence number and LINKID of the Inquired Business (or the Parent)
				SELF.BusExecCriminalChild   := PROJECT(LEFT, FormatTheListOfOffenses(LEFT, COUNTER)))); 
				       
			
			
			
	
	 /*  define the TRANSFORM used by the DENORMALIZE FUNCTION                        */  
	  DueDiligence.Layouts.Busn_Internal CreateNestedData(InputBusnCriminal le, BusExecCriminalChildDataset ri, Integer BLCount) := TRANSFORM
       SELF.BusinessReport.BusinessAttributeDetails.Legal.LegalSummary.NumberOfEvictions                 := le.Business.evictionsCnt;
       SELF.BusinessReport.BusinessAttributeDetails.Legal.LegalSummary.NumberOfJudgmentsLiens            := le.Business.liensUnreleasedCnt;
       SELF.BusinessReport.BusinessAttributeDetails.Legal.LegalSummary.NumberOfFelonyConvictions         := le.BusFelonyConviction_4F;
       SELF.BusinessReport.BusinessAttributeDetails.Legal.LegalSummary.NumberOfFelonyNonConvictions      := le.BusFelonyNonConviction_3F;
       SELF.BusinessReport.BusinessAttributeDetails.Legal.LegalSummary.NumberOfMisdemeanorConvictions    := le.BusMisdemeanorConviction_4M;  
       SELF.BusinessReport.BusinessAttributeDetails.Legal.LegalSummary.NumberOfMisdemeanorNonConcivtions := le.BusMisdemeanorNonConviction_3M;  
       SELF.BusinessReport.BusinessAttributeDetails.Legal.LegalSummary.NumberOfTrafficConvictions        := le.BusTrafficConvictions_2T;
       SELF.BusinessReport.BusinessAttributeDetails.Legal.LegalSummary.NumberOfUnknownConvictions        := le.BusUnknownConviction_4U; 
       SELF.BusinessReport.BusinessAttributeDetails.Legal.LegalSummary.NumberOfUnknownNonConvictions     := le.BusUnknownNonConviction_3U; 
       //*** need to add logic in the getIndCriminal ***  They were not used in the attribute so they were overlooked ***
       SELF.BusinessReport.BusinessAttributeDetails.Legal.LegalSummary.NumberOfTrafficNonConvictions     := 0;    //***we did not collect this information ***// 
       SELF.BusinessReport.BusinessAttributeDetails.Legal.LegalSummary.NumberOfInfractionConvictions     := 0;    //***we did not collect this information   
       SELF.BusinessReport.BusinessAttributeDetails.Legal.LegalSummary.NumberOfInfractionNonConvictions  := 0;    //***we did not collec this information
     

       SELF.BusinessReport.BusinessAttributeDetails.Legal.PossibleLegalEvents     := le.BusinessReport.BusinessAttributeDetails.Legal.PossibleLegalEvents  + ri.BusExecCriminalChild;
       SELF := le;
  END; 
																	
	 /* perform the DENORMALIZE (join) by Seq #                                        */   															 															
	UpdateBusnExecsCriminalWithReport := DENORMALIZE(InputBusnCriminal, BusExecCriminalChildDataset,
	                                            #EXPAND (DueDiligence.Constants.mac_JOINLinkids_BusInternal()), 
											                                 CreateNestedData(Left, Right, Counter));  
		
	
	// ********************
	//   DEBUGGING OUTPUTS
	// *********************
	 
	  IF(DebugMode,     OUTPUT(CHOOSEN(InputBusnCriminal,                      100),  NAMED('InputBusnCriminal')));
	  IF(DebugMode,     OUTPUT(CHOOSEN(BEOCriminalOffensesInternal,            100),  NAMED('BEOCriminalOffensesInternal')));
	  IF(DebugMode,     OUTPUT(CHOOSEN(InputBusinessExecutivesCriminalOffense, 100),  NAMED('InputBusinessExecutivesCriminalOffense')));
	  IF(DebugMode,     OUTPUT(CHOOSEN(BusExecCriminalChildDataset,            100),  NAMED('BusExecCriminalChildDataset')));
	 
	 
		Return UpdateBusnExecsCriminalWithReport;
		
	END;   
	