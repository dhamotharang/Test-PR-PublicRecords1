﻿
IMPORT Address, BIPV2, Business_Risk_BIP, LN_PropertyV2, MDR, DueDiligence, UT, iesp, Census_Data, Suppress;

EXPORT reportBusExecCriminal(DATASET(DueDiligence.layouts.Busn_Internal) InputBusnCriminal, 
                             string6 DD_SSNMask,
                             boolean DebugMode = FALSE) := FUNCTION

  
 //*** add logic here to SORT the list of Executives that are added to the report so that only the oldest ones are truncated  ****//	
	 ListOfExecutives := NORMALIZE(InputBusnCriminal, LEFT.execs, TRANSFORM(DueDiligence.LayoutsInternalReport.BEOCriminalReportingOFOffenses,
                             /*  start by getting all of the Executive Names from the (RIGHT) */  																														
																												SELF.seq                  := LEFT.seq;
																												SELF.ultID                := LEFT.Busn_info.BIP_IDS.UltID.LinkID;
																												SELF.orgID                := LEFT.Busn_info.BIP_IDS.OrgID.LinkID;
																												SELF.seleID               := LEFT.Busn_info.BIP_IDS.SeleID.LinkID;
                                                        SELF.numberOfCriminalEvents := COUNT(RIGHT.PartyOffenses);
																												SELF                      := RIGHT;
																												SELF                      := [];));
                                                        
 // -------                                                                       ------
 // ------- Drop the executives that do not have any criminal activity            ------
 // -------                                                                       ------
   FilterdBEOResults    := ListOfExecutives (numberOfCriminalEvents > 0); 
  
  //****Normalize the PartyOffenses within FilterdBEOResults ***//
  
   ListOfExecutivesTitle := NORMALIZE(FilterdBEOResults, LEFT.positions, TRANSFORM(DueDiligence.LayoutsInternalReport.BEOPositionLayout,
                                                        /*  then get all of the titles held by this executive   */  																														
																												SELF.seq                    := LEFT.seq;                //*** This is the sequence number of the Inquired Business (or the Parent)
				                                                SELF.ultid                  := LEFT.ultid;  
				                                                SELF.orgid                  := LEFT.orgid;  
				                                                SELF.seleid                 := LEFT.seleid;  
                                                        SELF.did                    := LEFT.did; 
																												SELF                        := RIGHT;
																												SELF                        := [];));
                                                        
  // ------                                                                         ------
  // ------      SORT and DEDUP(ROLLUP) the executives, looking for the most        ------
  // ------     recent title held by this executive                                 ------
  // ------                                                                         ------
  
  LatestExecutiveTitles := SORT(ListOfExecutivesTitle, seq, ultid, orgid, seleid, did, -lastSeen);                             															 															
	DedupExecutiveTitles := ROLLUP(LatestExecutiveTitles,
                                  #EXPAND (DueDiligence.Constants.mac_JOINLinkids_Results()) AND
                                  LEFT.did = RIGHT.did,
                                  TRANSFORM(RECORDOF(LEFT),
                                            SELF    := LEFT));
  
  // ------                                                                         ------
  // ------      Add the latest title next to the executive Name                    ------
  // ------     And carry the offenses forward                                      ------
  // ------                                                                         ------
   ExecutivesWithTitles := JOIN(FilterdBEOResults, DedupExecutiveTitles,
                            #EXPAND(DueDiligence.Constants.mac_JOINLinkids_Results()) AND
                            LEFT.did = RIGHT.did,
                            TRANSFORM(RECORDOF(LEFT),
                                      //*** pick up the Title from the RIGHT ***//
                                      SELF.mostRecentTitle   :=     RIGHT.Title,
                                      //*** carry the rest of the data from the LEFT forward  ****//
                                      SELF := LEFT;));
                                                        
  
  //*** add logic here to SORT the list of offenses that are added to the report so that only the oldest ones are truncated  ****//	
	 ListOfExecutivesAndOffenses := NORMALIZE(ExecutivesWithTitles, LEFT.partyOffenses, TRANSFORM(DueDiligence.LayoutsInternalReport.FlatListOfBEOWithCriminalLayout,
                             /*  start by getting all of the Executive Names from the (RIGHT) */  																														
																												SELF.seq                    := LEFT.seq;                //*** This is the sequence number of the Inquired Business (or the Parent)
				                                                SELF.ultid                  := LEFT.ultid;  
				                                                SELF.orgid                  := LEFT.orgid;  
				                                                SELF.seleid                 := LEFT.seleid;  
                                                        SELF.did                    := LEFT.did; 
																												SELF                        := RIGHT;  //***get the party offenses from the RIGHT
                                                        SELF                        := LEFT;   //***get name and address from the LEFT
																												SELF                        := [];)); 
  
  // ------                                                                                                   ------
  // ------ pass the input file and the name of the output file, and name of the ssn field and the name of the -----
  // ------ dl_field(driver's license field) in this case is '' and the boolean flags for isassn and isadl     -----
  // ------                                                                                                   ------
  Suppress.MAC_Mask(ListOfExecutivesAndOffenses, MaskSSNInThisListOfExecutives, ssn, '', true, false,,,,DD_SSNMask);
	// ------                                                                       ------
  // ------ populate the ChildDataset  with the list of OFFENSES                  ------
  // ------ by building a DATASET we can INSERT the entire ChiledDATASET          ------
  // ------ as a 'WHOLE' into the DATASET defined within the PARENT               ------
	// ------                                                                       ------
	iesp.duediligenceshared.t_DDRLegalEventCriminal  FormatTheListOfOffenses(MaskSSNInThisListOfExecutives le, Integer OffenseCount) := TRANSFORM,
	                                        SKIP(OffenseCount > iesp.constants.DDRAttributesConst.MaxLegalEvents)         
         SELF.CaseNumber               := le.caseNum;    
         SELF.OffenseScore             := le.offenseScore;
         SELF.OffenseScoreDescription  := DueDiligence.Common.getOffenseScoreDescription(le.offenseScore);  
         SELF.OffenseLevel             := le.criminalOffenderLevel;
         SELF.OffenseLevelDescription  := DueDiligence.Common.getOffenseLevelDescription(le.criminalOffenderLevel);
         SELF.Conviction               := le.convictionFlag;
         SELF.TrafficRelated           := le.trafficFlag;
         SELF.CourtType                := le.courtType;
         SELF.CaseTypeDescription      := le.caseTypeDesc; 
         SELF.ArrestLevelDescription   := le.arr_off_lev_mapped;
         SELF.CourtStatute             := le.courtStatute;
         SELF.CourtStatuteDescription  := le.courtStatuteDesc; 
         SELF.Charge                   := le.Charge;
         SELF.NumberOfCounts           := le.num_of_counts;  
         SELF.DispositionDescription1  := le.courtDispDesc1;
         SELF.DispositionDescription2  := le.courtDispDesc2;
         SELF.ProbationSentence        := le.sent_probation; 
         SELF.Incarceration            := MAP(
                                              le.Ever_incarc_offenders =   'Y'  => TRUE, 
                                              le.Ever_incarc_offenses  =   'Y'  => TRUE,
                                              le.Ever_incarc_punishments = 'Y'  => TRUE, 
                                                                                   FALSE);  
         SELF.CurrentIncarceration     := MAP(
                                              le.Curr_incarc_offenders = 'Y'    => TRUE,
                                              le.Curr_incarc_offenses  = 'Y'    => TRUE,
                                              le.Curr_incarc_punishments = 'Y'  => TRUE, 
                                                                                   FALSE);
         SELF.CurrentParole            := IF(le.Curr_parole_flag = 'Y', TRUE, FALSE);
         SELF.CurrentProbation         := FALSE;
         SELF.EarliestOffenseDate.Year := (Integer)le.earliestOffenseDate[1..4];
         SELF.EarliestOffenseDate.Month := (Integer)le.earliestOffenseDate[5..6];
         SELF.EarliestOffenseDate.Day  := (Integer)le.earliestOffenseDate[7..8];

         SELF.OffenseDate.Year         := (Integer)le.offenseDate[1..4];
         SELF.OffenseDate.Month        := (Integer)le.offenseDate[5..6];
         SELF.OffenseDate.Day          := (Integer)le.offenseDate[7..8];
         SELF                          := [];
	END;  
	 
	  
  BusExecCriminalChildDataset  :=   
	  PROJECT(MaskSSNInThisListOfExecutives,                                                        //***Using this input dataset  
			  TRANSFORM(DueDiligence.LayoutsInternalReport.ReportingofBEOCriminalChildDatasetLayout,  //***format the data according to this layout.
				  #EXPAND (DueDiligence.Constants.mac_TRANSFORMLinkids())                               //***This is the sequence number and LINKID of the Inquired Business (or the Parent)
          SELF.did                    := LEFT.did,
          SELF.Name.Full              := LEFT.fullName,
          SELF.Name.First             := LEFT.firstName,
          SELF.Name.Last              := LEFT.lastName,
          SELF.Name.Middle            := LEFT.middleName,
          SELF.Name.Suffix            := LEFT.suffix,
          SELF.Name.Prefix            := '',
          SELF.Address.StreetNumber   := LEFT.prim_range,
          SELF.Address.StreetPreDirection := LEFT.predir,
          SELF.Address.StreetName     := LEFT.prim_name,
          SELF.Address.StreetSuffix   := LEFT.addr_suffix,
          SELF.Address.StreetPostDirection := LEFT.postdir,
          SELF.Address.UnitDesignation := LEFT.unit_desig,
          SELF.Address.UnitNumber      := LEFT.sec_range,                   //***Does sec_range map to Unit Number?????
          SELF.Address.StreetAddress1  := LEFT.streetAddress1,
          SELF.Address.StreetAddress2  := LEFT.streetAddress2,
          SELF.Address.City            := LEFT.city,
          SELF.Address.State           := LEFT.state,
          SELF.Address.Zip5            := LEFT.zip5,
          SELF.Address.Zip4            := LEFT.zip4,
          SELF.Address.County          := LEFT.county,                     //***This is the 3 digit FIPS code - convert this to CountyName 
          SELF.Address.PostalCode      := LEFT.zip5 + LEFT.zip4,                             
          SELF.Address.StateCityZip    := '',                              //***Fix this in SPRINT10
          SELF.lexid                  := (string)LEFT.did,
          SELF.ExecTitle              := LEFT.mostRecentTitle,
          SELF.SSN                    := LEFT.ssn,                         //***Add SSN MASKING in SPRINT10
          SELF.DOB.Year                  := (unsigned4)LEFT.DOB[1..4],     //** YYYY
					SELF.DOB.Month                 := (unsigned2)LEFT.DOB[5..6],     //** MM
					SELF.DOB.Day                   := (unsigned2)LEFT.DOB[7..8],     //** DD
          SELF.BusExecCriminalChild   := PROJECT(LEFT, FormatTheListOfOffenses(LEFT, COUNTER)))); 
				       
    																
	//perform the ROLLUP by LINKID And DID
  sortCrimOffense := SORT(BusExecCriminalChildDataset, seq, ultid, orgid, seleid, did);
	RollupCriminalOffense := ROLLUP(sortCrimOffense,
                                  #EXPAND(DueDiligence.Constants.mac_JOINLinkids_Results()) AND
                                  LEFT.did = RIGHT.did,
											            TRANSFORM(RECORDOF (LEFT),
                                            SELF.BusExecCriminalChild  := LEFT.BusExecCriminalChild  + RIGHT.BusExecCriminalChild,
                                            SELF                       := LEFT));
                                    
  BEOExecutiveCriminalEvents  := PROJECT(RollupCriminalOffense,
                                        // *  Create a dataset of Executives and a child dataset of offenses for this BEO  //
                                        TRANSFORM({DATASET(iesp.duediligencebusinessreport.t_DDRBusinessExecutiveCriminalEvents) CriminalActivity, UNSIGNED4 seq, UNSIGNED6 ultID, UNSIGNED6 orgID, UNSIGNED6 seleID},
                                                  // *  Create a dataset of criminal activity that can be in moved as entire block to the report *//   
                                                  SELF.CriminalActivity  := DATASET([TRANSFORM(iesp.duediligencebusinessreport.t_DDRBusinessExecutiveCriminalEvents,
                                                              /* First move the DataSet of Criminal Offenses for this Executive */ 
                                                                 SELF.CriminalEvents         := LEFT.BusExecCriminalChild,
                                                              /* Now move the Name and Address of each Executive with criminal history */
                                                                 SELF.ExecutiveOfficer.Name.First             := LEFT.Name.First,
                                                                 SELF.ExecutiveOfficer.Name.Full              := LEFT.Name.Full,
                                                                 SELF.ExecutiveOfficer.Name.Middle            := LEFT.Name.Middle,
                                                                 SELF.ExecutiveOfficer.Name.Last              := LEFT.Name.Last,
                                                                 SELF.ExecutiveOfficer.Name.Suffix            := LEFT.Name.Suffix,
                                                                 SELF.ExecutiveOfficer.Address.StreetNumber      := LEFT.Address.StreetNumber,
                                                                 SELF.ExecutiveOfficer.Address.StreetPreDirection := LEFT.Address.StreetPreDirection,
                                                                 SELF.ExecutiveOfficer.Address.StreetName     := LEFT.Address.StreetName,
                                                                 SELF.ExecutiveOfficer.Address.StreetSuffix   := LEFT.Address.StreetSuffix,
                                                                 SELF.ExecutiveOfficer.Address.StreetPostDirection := LEFT.Address.StreetPostDirection,
                                                                 SELF.ExecutiveOfficer.Address.UnitDesignation := LEFT.Address.UnitDesignation,
                                                                 SELF.ExecutiveOfficer.Address.UnitNumber     := LEFT.Address.UnitNumber, 
                                                                 SELF.ExecutiveOfficer.Address.StreetAddress1 := LEFT.Address.StreetAddress1,
                                                                 SELF.ExecutiveOfficer.Address.StreetAddress2 := LEFT.Address.StreetAddress2,
                                                                 SELF.ExecutiveOfficer.Address.City           := LEFT.Address.City,
                                                                 SELF.ExecutiveOfficer.Address.State          := LEFT.Address.State,
                                                                 SELF.ExecutiveOfficer.Address.Zip5           := LEFT.Address.Zip5,
                                                                 SELF.ExecutiveOfficer.Address.Zip4           := LEFT.Address.Zip4,
                                                                 SELF.ExecutiveOfficer.Address.PostalCode     := LEFT.Address.PostalCode,
                                                                 SELF.ExecutiveOfficer.SSN                    := LEFT.SSN,
                                                                 SELF.ExecutiveOfficer.DOB.Year               := LEFT.DOB.Year,
                                                                 SELF.ExecutiveOfficer.DOB.Month              := LEFT.DOB.Month,
                                                                 SELF.ExecutiveOfficer.DOB.Day                := LEFT.DOB.Day,
                                                                 SELF.ExecTitle                               := LEFT.ExecTitle,
                                                                 SELF                                         := LEFT, 
                                                                 SELF                                         := [])]),
                                                  /* continue to populate the LINK IDs */  
                                                  SELF                        := LEFT;
                                                  SELF                        := []));  
			

																	
	/* perform the DENORMALIZE (join) by Link ID                                 */   															 															
	UpdateBusnExecsCriminalWithReport := DENORMALIZE(InputBusnCriminal, BEOExecutiveCriminalEvents,
                                                    #EXPAND(DueDiligence.Constants.mac_JOINLinkids_BusInternal()), 
                                                    TRANSFORM(DueDiligence.Layouts.Busn_Internal,
                                                               SELF.BusinessReport.BusinessAttributeDetails.Legal.LegalSummary.NumberOfEvictions                 := LEFT.Business.evictionsCnt;
                                                               SELF.BusinessReport.BusinessAttributeDetails.Legal.LegalSummary.NumberOfJudgmentsLiens            := LEFT.Business.liensUnreleasedCnt;
                                                               SELF.BusinessReport.BusinessAttributeDetails.Legal.LegalSummary.NumberOfFelonyConvictions         := LEFT.BusFelonyConviction_4F;
                                                               SELF.BusinessReport.BusinessAttributeDetails.Legal.LegalSummary.NumberOfFelonyNonConvictions      := LEFT.BusFelonyNonConviction_3F;
                                                               SELF.BusinessReport.BusinessAttributeDetails.Legal.LegalSummary.NumberOfMisdemeanorConvictions    := LEFT.BusMisdemeanorConviction_4M;  
                                                               SELF.BusinessReport.BusinessAttributeDetails.Legal.LegalSummary.NumberOfMisdemeanorNonConcivtions := LEFT.BusMisdemeanorNonConviction_3M;
                                                               SELF.BusinessReport.BusinessAttributeDetails.Legal.LegalSummary.NumberOfUnknownConvictions        := LEFT.BusUnknownConviction_4U; 
                                                               SELF.BusinessReport.BusinessAttributeDetails.Legal.LegalSummary.NumberOfUnknownNonConvictions     := LEFT.BusUnknownNonConviction_3U;
                                                                 
                                                               SELF.BusinessReport.BusinessAttributeDetails.Legal.LegalSummary.NumberOfTrafficConvictions        := LEFT.BusTrafficConviction_2T;
                                                               SELF.BusinessReport.BusinessAttributeDetails.Legal.LegalSummary.NumberOfTrafficNonConvictions     := LEFT.BusTrafficNonConviction_1T;
                                                               SELF.BusinessReport.BusinessAttributeDetails.Legal.LegalSummary.NumberOfInfractionConvictions     := LEFT.BusInfractionConviction_2I; 
                                                               SELF.BusinessReport.BusinessAttributeDetails.Legal.LegalSummary.NumberOfInfractionNonConvictions  := LEFT.BusInfractionNonConviction_1I;
                                                             
                                                               //*** This is now moving the Criminal Activity which is a DATASET of Executive and each Executive contains a DATASET of criminal offenses  **//
                                                               SELF.BusinessReport.BusinessAttributeDetails.Legal.PossibleLegalEvents      := LEFT.BusinessReport.BusinessAttributeDetails.Legal.PossibleLegalEvents  + RIGHT.CriminalActivity;
                                                               
                                                               SELF := LEFT;));  
		
	
	// ********************
	//   DEBUGGING OUTPUTS
	// *********************
	 
	  IF(DebugMode,     OUTPUT(CHOOSEN(InputBusnCriminal,                      100),  NAMED('InputBusnCriminal')));
	  IF(DebugMode,     OUTPUT(CHOOSEN(ListOfExecutives,                      100),  NAMED('ListOfExecutives')));
	  IF(DebugMode,     OUTPUT(CHOOSEN(FilterdBEOResults,                      100),  NAMED('FilterdBEOResults')));
	  IF(DebugMode,     OUTPUT(CHOOSEN(ListOfExecutivesTitle,                  100),  NAMED('ListOfExecutivesTitle')));
	  IF(DebugMode,     OUTPUT(CHOOSEN(DedupExecutiveTitles,                   100),  NAMED('DedupExecutiveTitles')));
	  IF(DebugMode,     OUTPUT(CHOOSEN(ExecutivesWithTitles,                   100),  NAMED('ExecutivesWithTitles')));
	  IF(DebugMode,     OUTPUT(CHOOSEN(ListOfExecutivesAndOffenses,             100),  NAMED('ListOfExecutivesAndOffenses')));
	  IF(DebugMode,     OUTPUT(CHOOSEN(MaskSSNInThisListOfExecutives,           100),  NAMED('MaskSSNInThisListOfExecutives')));
	  IF(DebugMode,     OUTPUT(CHOOSEN(BusExecCriminalChildDataset,             100),  NAMED('BusExecCriminalChildDataset')));
	  IF(DebugMode,     OUTPUT(CHOOSEN(RollupCriminalOffense,                   100),  NAMED('RollupCriminalOffense')));
	  IF(DebugMode,     OUTPUT(CHOOSEN(BEOExecutiveCriminalEvents,              100),  NAMED('BEOExecutiveCriminalEvents')));
	  IF(DebugMode,     OUTPUT(CHOOSEN(UpdateBusnExecsCriminalWithReport,       100),  NAMED('UpdateBusnExecsCriminalWithReport')));

	 
		Return UpdateBusnExecsCriminalWithReport;
		
	END;   
	