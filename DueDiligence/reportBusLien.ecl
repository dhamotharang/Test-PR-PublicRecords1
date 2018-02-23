IMPORT Address, BIPV2, Business_Risk_BIP, LN_PropertyV2, MDR, DueDiligence, UT, iesp, Census_Data;

EXPORT reportBusLien(DATASET(DueDiligence.layouts.Busn_Internal) UpdateBusnLiens, 
											   DATASET(DueDiligence.LayoutsInternal.layout_liens_judgments_categorized) BusinessLiens_unreleased,
											   boolean DebugMode = FALSE) := FUNCTION

	 
	 													
	// ------                                                                       ------
  // ------ define the ChildDataset                                               ------
	// ------                                                                       ------
	BusLiensChildDatasetLayout    := RECORD
	  unsigned2 seq;                                                        //*  This is the seqence number of the parent  
	  DATASET(iesp.duediligenceshared.t_DDRLiensJudgmentsEvictions) BusLiensChild;
	END;
	 
	// ------                                                                       ------
  // ------ populate the ChildDataset                                             ------
  // ------ by building a DATASET we can INSERT the entire ChiledDATASET          ------
  // ------ as a 'WHOLE' into the DATASET defined within the PARENT               ------
	// ------                                                                       ------
	iesp.duediligenceshared.t_DDRLiensJudgmentsEvictions   FormatTheListOfLIENS(RECORDOF(BusinessLiens_unreleased) le, Integer LienSeq) := TRANSFORM 
        SELF.FilingType     := le.filing_type_desc;  
        SELF.FilingAmount   := (integer)le.amount;
        //SELF.FilingDate     := le.orig_filing_date;
        // SELF.FilingNumber   := 'ZZZFILINGNUMBER';
        // SELF.FilingJurisdiction  := 'ZZ'; 
        //SELF.ReleaseDate    := le.release_date;
        SELF.Eviction       := IF(le.eviction = 'Y', true, false); 
        // SELF.Agency         := 'ZZZZAGENCY';
        SELF.AgencyState    := le.agency_state; 
                
        SELF                := [];
  END;  
	 
	  
	BusLiensChildDataset  :=   
		PROJECT(BusinessLiens_unreleased,
			TRANSFORM(BusLiensChildDatasetLayout,
				SELF.seq             := LEFT.liensJudgment.seq,          //***This is the sequence number of the Inquired Business (or the Parent)
				SELF.BusLiensChild   := PROJECT(LEFT, FormatTheListOfLIENS(LEFT, COUNTER)))); 
				       
				                                         
	
	 /*  define the TRANSFORM used by the DENORMALIZE FUNCTION                        */  
	  DueDiligence.Layouts.Busn_Internal CreateNestedData(UpdateBusnLiens le, BusLiensChildDataset ri, Integer BLCount) := TRANSFORM
         SELF.BusinessReport.BusinessAttributeDetails.Legal.LegalSummary.NumberOfJudgmentsLiens  := BLCount,
         //SELF.BusinessReport.BusinessAttributeDetails.EconomicAttributeDataDetails.PropertyOwnerShip.TaxAssessedValue      := le.PropTaxValue,
         SELF.BusinessReport.BusinessAttributeDetails.Legal.PossibleLiensJudgmentsEvictions := le.BusinessReport.BusinessAttributeDetails.Legal.PossibleLiensJudgmentsEvictions  + ri.BusLiensChild;
         SELF := le;
   END; 
																	
	 /* perform the DENORMALIZE (join) by Seq #                                        */   															 															
	 UpdateBusnLIENSWithReport := DENORMALIZE(UpdateBusnLiens, BusLiensChildDataset,
	                                             LEFT.seq = RIGHT.seq, 
												                       CreateNestedData(Left, Right, Counter));  
		
	
	// ********************
	//   DEBUGGING OUTPUTS
	// *********************
	 
	  IF(DebugMode,     OUTPUT(COUNT  (UpdateBusnLiens),         NAMED('HowManyUpdateBusnLiens')));
	 
	  IF(DebugMode,     OUTPUT(CHOOSEN(BusLiensChildDataset, 100),  NAMED('BusLiensChildDataset')));
	 
	 
		Return UpdateBusnLIENSWithReport;
		
	END;   
	