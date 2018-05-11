IMPORT DueDiligence, iesp;

EXPORT reportBusLien(DATASET(DueDiligence.layouts.Busn_Internal) UpdateBusnLiens, 
											   DATASET(DueDiligence.LayoutsInternal.layout_liens_judgments_categorized) BusinessLiens,
											   boolean DebugMode = FALSE) := FUNCTION


   // -----                                                                                     ----- 
	 // ------ Limit the number of records for each business listed in the report                 ------
	 // ------ Start by sorting them in seleid sequence and getting the records  with the         ------
	 // ------ most recent filed and largest dollar amount                                        ------
	 // ------ Note:  think about changing this to ROLLUP  so that we can be more thoughtful      ------
	 // ------                                                                                    ------
	 BusinessLiensButLimted   := dedup(sort(BusinessLiens,  seleid, -orig_filing_date, -amount), seleid,  
                                                    KEEP(iesp.constants.DDRAttributesConst.MaxLienJudgementsEvictions)); 


  UdateBusinessLiensForReporting   := DueDiligence.reportBusLienDebtorCreditor(BusinessLiensButLimted, debugmode);
			
 
 /* perform the DENORMALIZE (join) by Link ID                                 */   															 															
	UpdateBusWithLiensAndItsDebtors := DENORMALIZE(UpdateBusnLiens, UdateBusinessLiensForReporting,
                                                    #EXPAND(DueDiligence.Constants.mac_JOINLinkids_BusInternal()), 
                                                    TRANSFORM(DueDiligence.Layouts.Busn_Internal,
                                                               //SELF.BusinessReport.BusinessAttributeDetails.Legal.LegalSummary.NumberOfInfractionNonConvictions  := LEFT.BusInfractionNonConviction_1I;
                                                               //*** This is now moving the  **//
                                                               SELF.BusinessReport.BusinessAttributeDetails.Legal.PossibleLiensJudgmentsEvictions      := LEFT.BusinessReport.BusinessAttributeDetails.Legal.PossibleLiensJudgmentsEvictions  + RIGHT.LIENACTIVITY;
                                                               
                                                               SELF := LEFT;));  
                                                               
    
		
 // ********************
	//   DEBUGGING OUTPUTS
	// *********************
	 
	  //IF(DebugMode,     OUTPUT(COUNT  (UpdateBusnLiens),         NAMED('HowManyUpdateBusnLiens')));
	  IF(DebugMode,     OUTPUT(CHOOSEN(BusinessLiens, 100),  NAMED('UnreleasedBusinessLiensin')));
	  // IF(DebugMode,     OUTPUT(CHOOSEN(liensPartyDEBTORS, 100),  NAMED('liensPartyDEBTORSout')));
    // IF(DebugMode,     OUTPUT(CHOOSEN(SortLiensWithDEBTORS, 100),  NAMED('SortLiensWithDEBTORSout')));
	  // IF(DebugMode,     OUTPUT(CHOOSEN(DedupLiensWithDEBTORS, 100),  NAMED('DedupLiensWithDEBTORSout')));
	  // IF(DebugMode,     OUTPUT(CHOOSEN(DebtorChildDataset, 100),  NAMED('DebtorChildDatasetout')));
	  // IF(DebugMode,     OUTPUT(CHOOSEN(SortDebtorChildDataset, 100),  NAMED('SortDebtorChildDatasetout')));
	  // IF(DebugMode,     OUTPUT(CHOOSEN(RollupDebtorChildDataset, 100),  NAMED('RollupDebtorChildDatasetout')));
	  // IF(DebugMode,     OUTPUT(CHOOSEN(BusWithLiensAndItsDebtors, 100),  NAMED('BusWithLiensAndItsDebtorsout')));
	 // IF(DebugMode,     OUTPUT(CHOOSEN(savedforreporting, 100),  NAMED('savedforreporting')));
	  
	  //IF(DebugMode,     OUTPUT(CHOOSEN(BusLiensChildDataset, 100),  NAMED('BusLiensChildDataset')));
	 
	 
		Return UpdateBusWithLiensAndItsDebtors;
		//Return UpdateBusnLiens;
		
	END;   
  
	