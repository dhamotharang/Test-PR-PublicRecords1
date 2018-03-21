IMPORT DueDiligence,  iesp;

EXPORT reportBusSOSFilings(DATASET(DueDiligence.layouts.Busn_Internal) BusnData, 
											                DATASET(DueDiligence.LayoutsInternalReport.BusCorpFilingsSlimLayout) BusSOSFilingsSlim
											                       ) := FUNCTION
		
		
	// ------ Should these records be sorted/deduped at the full 	
		
	// ------                                                                        ------
 // ------ populate the ChildDataset  with the list of Reporting Bureaus         ------
 // ------ by building a DATASET we can INSERT the entire ChiledDATASET          ------
 // ------ as a 'WHOLE' into the DATASET defined within the PARENT               ------
	// ------                                                                       ------
	iesp.duediligencebusinessreport.t_DDRSOSFiling  FormatTheListOfSOSFilings(BusSOSFilingsSlim le, Integer FilingCount) := TRANSFORM, 
	                              SKIP(FilingCount > iesp.constants.DDRAttributesConst.MaxSOSFilingStatuses)
																															SELF.BusinessName                     := le.BusinessName;                      
																															SELF.FilingType                       := le.FilingType;
																															SELF.SOSFilingStatus                  := le.FilingStatus;
																															SELF.FilingNumber                     := le.FilingNumber;
																															SELF.SOSIncorporationState            := le.IncorporationState; 
																															SELF.FilingDate.Year                  := (unsigned4)((STRING)le.FilingDate)[1..4];     //** YYYY
																														 SELF.FilingDate.Month                 := (unsigned2)((STRING)le.FilingDate)[5..6];     //** MM
																															SELF.FilingDate.Day                   := (unsigned2)((STRING)le.FilingDate)[7..8];     //** DD
																															SELF.SOSLastUpdated.Year              := (unsigned4)((STRING)le.LastSeenDate)[1..4];   //** YYYY
																															SELF.SOSLastUpdated.Month             := (unsigned2)((STRING)le.LastSeenDate)[5..6];   //** MM
																															SELF.SOSLastUpdated.Day               := (unsigned2)((STRING)le.LastSeenDate)[7..8];   //** DD 
			                            SELF                                  := [];
				                     END;  
	 

	BusSOSFilingDataset  :=   
	PROJECT(BusSOSFilingsSlim,                                                               //*** Using this input dataset - these sources will get moved to the reporting section 
			TRANSFORM(DueDiligence.LayoutsInternalReport.ReportingOfSOSFilingsChildLayout,       //*** format the data according to this layout.
				#EXPAND (DueDiligence.Constants.mac_TRANSFORMLinkids())                            //***This is the sequence number and LINKID of the Inquired Business (or the Parent)
				SELF.BusSOSFilingsChild  := PROJECT(LEFT, FormatTheListOfSOSFilings(LEFT, COUNTER)))); 
				       
		
	// ------                                                                        ------
 // ------ define the TRANSFORM used by the DENORMALIZE FUNCTION                  ------
 // ------ that is bringing the parent (BusnData) on the LEFT and the newly       ------
 // ------ created child dataset on the RIGHT.                                    ------
	// ------                                                                        ------
	  DueDiligence.Layouts.Busn_Internal CreateNestedData(BusnData le, BusSOSFilingDataset ri, Integer SOSCount) := TRANSFORM
														   //***                                                                                          SOSFilingStatuses is the NESTED CHILD DATASET  
																 SELF.BusinessReport.BusinessAttributeDetails.Operating.BusinessInformation.SOSFilingStatuses     := le.BusinessReport.BusinessAttributeDetails.Operating.BusinessInformation.SOSFilingStatuses  + ri.BusSOSFilingsChild;
																	SELF := le;
				  											END; 
																	
	 /* perform the DENORMALIZE (join) by Seq #                                        */   															 															
	UpdateSOSFilingsInReport := DENORMALIZE(BusnData, BusSOSFilingDataset,
	                                             #EXPAND (DueDiligence.Constants.mac_JOINLinkids_BusInternal()),
											                                 CreateNestedData(Left, Right, Counter));  
	//**********************************End of SOS Filings Section *************************************************************************		
		
		
	
		
		
	//	OUTPUT(BusSOSFilingsSlim,   NAMED('BusSOSFilingsSlim'));
	 // OUTPUT(BusSOSFilingDataset, NAMED('BusSOSFilingDataset'));
	 //OUTPUT(UpdateSOSFilingsInReport, NAMED('UpdateSOSFilingsInReport'));
																
		
		Return UpdateSOSFilingsInReport;
		
	END;   
	