
IMPORT Address, BIPV2, Business_Risk_BIP, LN_PropertyV2, MDR, DueDiligence, UT, iesp, Census_Data;

EXPORT reportBusExecCriminal(DATASET(DueDiligence.layouts.Busn_Internal) InputBusnCriminal, 
                             DATASET(DueDiligence.LayoutsInternal.RelatedParty) InputBusinessExecutivesCriminalOffense,
                             boolean DebugMode = FALSE) := FUNCTION

	
 //*** add logic here to shorten the list of offenses that are added to the report ****//	
	 BEOCriminalOffensesInternal := NORMALIZE(InputBusnCriminal, LEFT.execs.partyOffenses, TRANSFORM(DueDiligence.LayoutsInternalReport.BEOCriminalReportingOFOffenses,
                             /*  start by getting all of the criminal offenses from the Parent (RIGHT) */  																														
																												 SELF.seq                  := LEFT.seq;
																													SELF.ultID                := LEFT.Busn_info.BIP_IDS.UltID.LinkID;
																													SELF.orgID                := LEFT.Busn_info.BIP_IDS.OrgID.LinkID;
																													SELF.seleID               := LEFT.Busn_info.BIP_IDS.SeleID.LinkID;
																													SELF.ReportOfOffenses     := RIGHT;
																												
																												//	SELF                     := LEFT;            //***Populate all of the fields from party nested DATASET
																													SELF                     := [];)); 
	  
	 													
	// ------                                                                       ------
 // ------ define the ChildDataset                                               ------
	// ------                                                                       ------
	BusExecCriminalChildDatasetLayout    := RECORD
	 unsigned2                      seq;                                      //*  This is the seqence number of the parent  
	 DATASET(iesp.duediligenceshared.t_DDRLegalEventCriminal) BusExecCriminalChild;
	END;
	 
	// ------                                                                       ------
  // ------ populate the ChildDataset  with the list of OFFENSES                  ------
  // ------ by building a DATASET we can INSERT the entire ChiledDATASET          ------
  // ------ as a 'WHOLE' into the DATASET defined within the PARENT               ------
	// ------                                                                       ------
	iesp.duediligenceshared.t_DDRLegalEventCriminal  FormatTheListOfOffenses(BEOCriminalOffensesInternal le, Integer OffenseSeq) := TRANSFORM
	                                                             /*  pick up the Name and address for this DID  */  
																															                              //SELF.seq                      := le.ReportOfOffenses.seq;  
																							                                      SELF.CaseNumber               := le.ReportOfOffenses.caseNum;    
																							                                      SELF.OffenseScore             := le.ReportOfOffenses.offenseScore;
																																										                   SELF.OffenseScoreDescription  := 'ZZZNEED MAPPINGA';
																																						                       SELF.OffenseLevel             := le.ReportOfOffenses.criminalOffenderLevel;
																																						                       SELF.OffenseLevelDescription  := 'ZZZNEED MAPPINGB';
                                                             SELF.Conviction               := le.ReportOfOffenses.convictionFlag;
                                                             SELF.TrafficRelated           := le.ReportOfOffenses.trafficFlag;
                                                             SELF.CourtType                := le.ReportOfOffenses.courtType;
                                                             SELF.CaseTypeDescription      := le.ReportOfOffenses.caseTypeDesc; 
                                                             SELF.ArrestLevelDescription   := 'ZZZNEED MAPPINGC';
                                                             SELF.CourtStatute             := le.ReportOfOffenses.courtStatute;
                                                             SELF.CourtStatuteDescription  := le.ReportOfOffenses.courtStatuteDesc; 
                                                             SELF.Charge                   := le.ReportOfOffenses.Charge;
                                                             SELF.NumberOfCounts           := '0';  
                                                             SELF.DispositionDescription1  := 'XXX';
                                                             SELF.DispositionDescription2  := 'XXXXXXX';
                                                             SELF.ProbationSentence        := 'XXX XXX'; 
                                                             SELF.Incarceration            := IF(le.ReportOfOffenses.Ever_incarc_offenders = 'Y', TRUE, FALSE);  
                                                                                                 //le.ReportOfOffenses.Ever_incarc_offenses  = 'Y'  OR
                                                                                                 //le.ReportOfOffenses.Ever_incarc_punishments 'Y', TRUE, FALSE);  
                                                             SELF.CurrentIncarceration     := IF(le.ReportOfOffenses.Curr_incarc_offenders = 'Y', TRUE, FALSE); 
                                                                                                 //le.ReportOfOffenses.Curr_incarc_offenses  = 'Y'  OR
                                                                                                 //le.ReportOfOffenses.Curr_incarc_punishments 'Y', TRUE, FALSE);
                                                             SELF.CurrentParole            := FALSE;
                                                             SELF.CurrentProbation         := FALSE;
                                                             SELF.EarliestOffenseDate.Year := (Integer)le.ReportOfOffenses.earliestOffenseDate[1..4];
                                                             SELF.EarliestOffenseDate.Month := (Integer)le.ReportOfOffenses.earliestOffenseDate[5..6];
                                                             SELF.EarliestOffenseDate.Day  := (Integer)le.ReportOfOffenses.earliestOffenseDate[7..8];

                                                             SELF.OffenseDate.Year         := (Integer)le.ReportOfOffenses.offenseDate[1..4];
                                                             SELF.OffenseDate.Month        := (Integer)le.ReportOfOffenses.offenseDate[5..6];
                                                             SELF.OffenseDate.Day          := (Integer)le.ReportOfOffenses.offenseDate[7..8];

																																																	            //SELF.CaseNumber      := execs.partyoffenses
			                                                          SELF                := [];
																							                                   END;  
	 
	  
BusExecCriminalChildDataset  :=   
	PROJECT(BEOCriminalOffensesInternal,                                  //***Using this input dataset  
			TRANSFORM(BusExecCriminalChildDatasetLayout,                        //***format the data according to this layout.
				SELF.seq                    := LEFT.seq,                           //***This is the sequence number of the Inquired Business (or the Parent)
				SELF.BusExecCriminalChild   := PROJECT(LEFT, FormatTheListOfOffenses(LEFT, COUNTER)))); 
				       
			
		
		
		
			
			
	
	 /*  define the TRANSFORM used by the DENORMALIZE FUNCTION                        */  
	  DueDiligence.Layouts.Busn_Internal CreateNestedData(InputBusnCriminal le, BusExecCriminalChildDataset ri, Integer BLCount) := TRANSFORM
       SELF.BusinessReport.BusinessAttributeDetails.Legal.LegalSummary.NumberOfEvictions                 := le.Business.evictionsCnt;
       SELF.BusinessReport.BusinessAttributeDetails.Legal.LegalSummary.NumberOfJudgmentsLiens            := le.Business.liensUnreleasedCnt;
       //SELF.BusinessReport.BusinessAttributeDetails.Legal.LegalSummary.NumberOfFelonyConvictions         := le.Business.ConvictedFelonyCount4F_Ever;
       //SELF.BusinessReport.BusinessAttributeDetails.Legal.LegalSummary.NumberOfFelonyNonConvictions      := le.Business.NonConvictedFelonyCount3F_EVER;
       //SELF.BusinessReport.BusinessAttributeDetails.Legal.LegalSummary.NumberOfMisdemeanorConvictions    := le.Business.ConvictedMisdemeanorCount4M_Ever;  
       //SELF.BusinessReport.BusinessAttributeDetails.Legal.LegalSummary.NumberOfMisdemeanorNonConcivtions := le.Business.NonConvictedMisdemeanorCount3M_EVER;  
       //SELF.BusinessReport.BusinessAttributeDetails.Legal.LegalSummary.NumberOfTrafficConvictions        := le.Business.ConvictedTraffic2T_Ever;   
       //SELF.BusinessReport.BusinessAttributeDetails.Legal.LegalSummary.NumberOfTrafficNonConvictions     := 0;    //***we did not collect this information ***// 
       //SELF.BusinessReport.BusinessAttributeDetails.Legal.LegalSummary.NumberOfInfractionConvictions     := le.Business.ConvictedInfractions2I_Ever;   
       SELF.BusinessReport.BusinessAttributeDetails.Legal.LegalSummary.NumberOfInfractionNonConvictions  := 0;    //***
       //SELF.BusinessReport.BusinessAttributeDetails.Legal.LegalSummary.NumberOfUnknownConvictions        := le.Business.ConvictedUnknownCount4U_Ever; 
       //SELF.BusinessReport.BusinessAttributeDetails.Legal.LegalSummary.NumberOfUnknownNonConvictions     := le.Business.NonConvictedUnknownCount3U_EVER;  

       SELF.BusinessReport.BusinessAttributeDetails.Legal.PossibleLegalEvents     := le.BusinessReport.BusinessAttributeDetails.Legal.PossibleLegalEvents  + ri.BusExecCriminalChild;
       SELF := le;
  END; 
																	
	 /* perform the DENORMALIZE (join) by Seq #                                        */   															 															
	UpdateBusnExecsCriminalWithReport := DENORMALIZE(InputBusnCriminal, BusExecCriminalChildDataset,
	                                            LEFT.seq = RIGHT.seq, 
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
	