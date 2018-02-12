IMPORT DueDiligence,  iesp;

EXPORT reportBusSOSFilings(DATASET(DueDiligence.layouts.Busn_Internal) BusnData, 
											                DATASET(DueDiligence.LayoutsInternalReport.BusCorpFilingsSlimLayout) BusSOSFilingsSlim
											                       ) := FUNCTION
		
		
		
		
	// ------                                                                        ------
 // ------ populate the ChildDataset  with the list of Reporting Bureaus         ------
 // ------ by building a DATASET we can INSERT the entire ChiledDATASET          ------
 // ------ as a 'WHOLE' into the DATASET defined within the PARENT               ------
	// ------                                                                       ------
	iesp.duediligencereport.t_DDRSOSFiling  FormatTheListOfSOSFilings(BusSOSFilingsSlim le, Integer FilingCount) := TRANSFORM, 
	                              SKIP(FilingCount > iesp.constants.DDRAttributesConst.MaxSOSFilingStatuses)
																															SELF.BusinessName                     := le.BusinessName;                      
																															SELF.FilingType                       := le.FilingType;
																															SELF.SOSFilingStatus                  := le.FilingStatus;
																															SELF.FilingNumber                     := le.FilingNumber;
																															SELF.SOSIncorporationState            := le.IncorporationState; 
																															SELF.FilingDate.Year                  := (unsigned4)le.FilingDate[1..4];  //YYYY
																														 SELF.FilingDate.Month                 := (unsigned2)le.FilingDate[5..6];  //MM
																															SELF.FilingDate.Day                   := (unsigned2)le.FilingDate[7..8];  //DD
																															//SELF.FilingDate.Year                  := (unsigned4)le.FilingDate[1..4];
																															// SELF.LastReported.Month               := (unsigned2)le.lastreported[5..6];
																															// SELF.LastReported.Day                 := (unsigned2)le.lastreported[7..8]; 
																															//                                    
			                            SELF                                  := [];
				                     END;  
	 

	BusSOSFilingDataset  :=   
	PROJECT(BusSOSFilingsSlim,                                                                       //*** Using this input dataset - these sources will get moved to the reporting section 
			TRANSFORM(DueDiligence.LayoutsInternalReport.ReportingOfSOSFilingsChildLayout,                 //*** format the data according to this layout.
				SELF.seq                    := LEFT.seq;                                                     //*** This is the sequence number of the Inquired Business (or the Parent)
				SELF.ultid                  := LEFT.ultid;
				SELF.orgid                  := LEFT.orgid;
				SELF.seleid                 := LEFT.seleid;
				SELF.proxid                 := LEFT.proxid;
				SELF.powid                  := LEFT.powid;
				SELF.BusSOSFilingsChild  := PROJECT(LEFT, FormatTheListOfSOSFilings(LEFT, COUNTER)))); 
				       
		
	// ------                                                                        ------
 // ------ define the TRANSFORM used by the DENORMALIZE FUNCTION                  ------
 // ------ that is bringing the parent (BusnData) on the LEFT and the newly       ------
 // ------ created child dataset on the RIGHT.                                    ------
	// ------                                                                        ------
	  DueDiligence.Layouts.Busn_Internal CreateNestedData(BusnData le, BusSOSFilingDataset ri, Integer SOSCount) := TRANSFORM
														   //***                                                                                          SOSFilingStatuses is the NESTED CHILD DATASET  
																 SELF.BusinessReport.BusinessAttributeDetails.OperatingAttributeDataDetails.BusinessInformation.SOSFilingStatuses     := le.BusinessReport.BusinessAttributeDetails.OperatingAttributeDataDetails.BusinessInformation.SOSFilingStatuses  + ri.BusSOSFilingsChild;
																	SELF := le;
				  											END; 
																	
	 /* perform the DENORMALIZE (join) by Seq #                                        */   															 															
	UpdateSOSFilingsInReport := DENORMALIZE(BusnData, BusSOSFilingDataset,
	                                             #EXPAND (DueDiligence.Constants.mac_JOINLinkids_BusInternal()),
											                                 CreateNestedData(Left, Right, Counter));  
	//**********************************End of SOS Filings Section *************************************************************************		
		
		
	
		
		
	//	OUTPUT(BusSOSFilingsSlim,   NAMED('BusSOSFilingsSlim'));
	 OUTPUT(BusSOSFilingDataset, NAMED('BusSOSFilingDataset'));
	 //OUTPUT(UpdateSOSFilingsInReport, NAMED('UpdateSOSFilingsInReport'));
																
		
		Return UpdateSOSFilingsInReport;
		
	END;   
	