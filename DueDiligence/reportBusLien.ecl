IMPORT Address, BIPV2, Business_Risk_BIP, LN_PropertyV2, MDR, DueDiligence, UT, iesp, Census_Data;

EXPORT reportBusLien(DATASET(DueDiligence.layouts.Busn_Internal) UpdateBusnLiens, 
											   DATASET(DueDiligence.LayoutsInternal.layout_liens_judgments_categorized) BusinessLiens_unreleased,
											   boolean DebugMode = FALSE) := FUNCTION


	// ------                                                                       ------
  // ------ populate the ChildDataset                                             ------
  // ------ by building a DATASET we can INSERT the entire ChiledDATASET          ------
  // ------ as a 'WHOLE' into the DATASET defined within the PARENT               ------
	// ------                                                                       ------
	iesp.duediligenceshared.t_DDRLiensJudgmentsEvictions   FormatTheListOfLIENS(RECORDOF(BusinessLiens_unreleased) le, Integer LienCount) := TRANSFORM, 
    SKIP(LienCount > iesp.constants.DDRAttributesConst.MaxLienJudgementsEvictions)
        SELF.FilingType          := le.filing_type_desc;  
        SELF.FilingAmount        := (integer)le.amount;
        SELF.FilingDate.Year     := (unsigned4)le.orig_filing_date[1..4];     //** YYYY
		    SELF.FilingDate.Month    := (unsigned2)le.orig_filing_date[5..6];     //** MM
			  SELF.FilingDate.Day      := (unsigned2)le.orig_filing_date[7..8];     //** DD
        SELF.FilingNumber        := le.filing_number;
        SELF.FilingJurisdiction  := le.filing_jurisdiction;   
        SELF.ReleaseDate.Year    := (unsigned4)le.release_date[1..4];     //** YYYY
		    SELF.ReleaseDate.Month   := (unsigned2)le.release_date[5..6];     //** MM
			  SELF.ReleaseDate.Day     := (unsigned2)le.release_date[7..8];     //** DD
        SELF.Eviction            := IF(le.eviction = 'Y', true, false); 
        SELF.Agency              := le.agency;
        SELF.AgencyCounty        := le.agency_county;  
        SELF.AgencyState         := le.agency_state;         
        SELF                     := [];
  END;  
	 
	  
	BusLiensChildDataset  :=   
		PROJECT(BusinessLiens_unreleased,
			TRANSFORM(DueDiligence.LayoutsInternalReport.BusLiensChildDatasetLayout,
				SELF.seq             := LEFT.liensJudgment.seq,          //***This is the sequence number of the Inquired Business (or the Parent)
        SELF.ultid           := LEFT.liensJudgment.ultid; 
				SELF.orgid           := LEFT.liensJudgment.orgid; 
				SELF.seleid          := LEFT.liensJudgment.seleid;
				SELF.proxid          := LEFT.liensJudgment.proxid;
				SELF.powid           := LEFT.liensJudgment.powid; 
				SELF.BusLiensChild   := PROJECT(LEFT, FormatTheListOfLIENS(LEFT, COUNTER)))); 
				       
				                                         
	
	 /*  define the TRANSFORM used by the DENORMALIZE FUNCTION                        */  
	  DueDiligence.Layouts.Busn_Internal CreateNestedData(UpdateBusnLiens le, BusLiensChildDataset ri, Integer BLCount) := TRANSFORM
         SELF.BusinessReport.BusinessAttributeDetails.Legal.LegalSummary.NumberOfJudgmentsLiens  := BLCount,
         SELF.BusinessReport.BusinessAttributeDetails.Legal.PossibleLiensJudgmentsEvictions := le.BusinessReport.BusinessAttributeDetails.Legal.PossibleLiensJudgmentsEvictions  + ri.BusLiensChild;
         SELF := le;
   END; 
																	
	 /* perform the DENORMALIZE (join) by Seq #                                        */   															 															
	 UpdateBusnLIENSWithReport := DENORMALIZE(UpdateBusnLiens, BusLiensChildDataset,
	                                             #EXPAND (DueDiligence.Constants.mac_JOINLinkids_BusInternal()),  
												                       CreateNestedData(Left, Right, Counter));  
		
	
  //****Add Debtor and creditors to the report
  
  
  
  
	// ********************
	//   DEBUGGING OUTPUTS
	// *********************
	 
	  IF(DebugMode,     OUTPUT(COUNT  (UpdateBusnLiens),         NAMED('HowManyUpdateBusnLiens')));
	 
	  IF(DebugMode,     OUTPUT(CHOOSEN(BusLiensChildDataset, 100),  NAMED('BusLiensChildDataset')));
	 
	 
		Return UpdateBusnLIENSWithReport;
		
	END;   
	