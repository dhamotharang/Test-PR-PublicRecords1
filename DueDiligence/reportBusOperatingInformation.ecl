IMPORT iesp, DueDiligence;

EXPORT reportBusOperatingInformation(DATASET(DueDiligence.layouts.Busn_Internal) BusnData, 
													 boolean DebugMode = FALSE
											     ) := FUNCTION
//****************************Begining of Bureau Reporting ***************************************************************************
		// ------                                                                                            ------
		// ------  bureauReporting is a nested DATASET within the Business Internal layout - the BusnData    ------
		// ------  so don't be confused by the LEFT.bureauReporting - this data will come in on the RIGHT    ------
		// ------  convert this into a flat/simple dataset before populating the report                      ------
		// ------                                                                                            ------
		
	 ListOfBusSources := NORMALIZE(BusnData, LEFT.bureauReporting, TRANSFORM(DueDiligence.LayoutsInternalReport.ListOfBusSourceLayout,
                             /*  start by getting all of the operating locations from the Parent  */  																														
																												 SELF.seq                       := LEFT.seq;
																													SELF.ultID                     := LEFT.Busn_info.BIP_IDS.UltID.LinkID;
																													SELF.orgID                     := LEFT.Busn_info.BIP_IDS.OrgID.LinkID;
																													SELF.seleID                    := LEFT.Busn_info.BIP_IDS.SeleID.LinkID;
																													/*  now get the rest of the data from child dataset */   
																													SELF                           := RIGHT;
																													SELF                           := [];)); 
																													
	// ------                                                                       ------
 // ------ define the ChildDataset                                               ------
	// ------                                                                       ------
	ReportingBureausChildDatasetLayout    := RECORD
	 unsigned2                      seq;                                           //*  This is the seqence number of the parent   
	 DATASET(iesp.duediligencereport.t_DDRReportingSources) ReportingBureausChild;
	END;
	
	// ------                                                                        ------
 // ------ populate the ChildDataset  with the list of Reporting Bureaus         ------
 // ------ by building a DATASET we can INSERT the entire ChiledDATASET          ------
 // ------ as a 'WHOLE' into the DATASET defined within the PARENT               ------
	// ------                                                                       ------
	iesp.duediligencereport.t_DDRReportingSources  FormatTheListOfRepBur(ListOfBusSources le, Integer bureauCount) := TRANSFORM, SKIP(bureauCount > iesp.constants.DDRAttributesConst.MaxReportingBureaus)
																															SELF.SourceName                       := le.source;                      
																															SELF.SourceType                       := le.sourceType;
																															SELF.FirstReported.Year               := (unsigned4)le.firstreported[1..4];  //YYYY
																															SELF.FirstReported.Month              := (unsigned2)le.firstreported[5..6];  //MM
																															SELF.FirstReported.Day                := (unsigned2)le.firstreported[7..8];  //DD
																															SELF.LastReported.Year                := (unsigned4)le.lastreported[1..4];
																															SELF.LastReported.Month               := (unsigned2)le.lastreported[5..6];
																															SELF.LastReported.Day                 := (unsigned2)le.lastreported[7..8]; 
			                            SELF                                  := [];
				                     END;  
	 

	BusReportBureauDataset  :=   
	PROJECT(ListOfBusSources,                                       //*** Using this input dataset - these sources will get moved to the reporting section 
			TRANSFORM(ReportingBureausChildDatasetLayout,                 //*** format the data according to this layout.
				SELF.seq                    := LEFT.seq,                     //*** This is the sequence number of the Inquired Business (or the Parent)
				SELF.ReportingBureausChild   := PROJECT(LEFT, FormatTheListOfRepBur(LEFT, COUNTER)))); 
				       

 // ------                                                                        ------
 // ------ define the TRANSFORM used by the DENORMALIZE FUNCTION                  ------
 // ------ that is bringing the parent (BusnData) on the LEFT and the newly       ------
 // ------ created child dataset on the RIGHT.                                    ------
	// ------                                                                        ------
	  DueDiligence.Layouts.Busn_Internal CreateNestedData(BusnData le, BusReportBureauDataset ri, Integer BRBCount) := TRANSFORM
												     SELF.BusinessReport.BusinessAttributeDetails.OperatingAttributeDataDetails.BusinessInformation.NumberOfBureauReporting       := le.creditSrcCnt; 
									
														   //***                                                                                          ReportingBureaus is the NESTED CHILD DATASET  
																 SELF.BusinessReport.BusinessAttributeDetails.OperatingAttributeDataDetails.BusinessInformation.ReportingBureaus     := le.BusinessReport.BusinessAttributeDetails.OperatingAttributeDataDetails.BusinessInformation.ReportingBureaus  + ri.ReportingBureausChild;
																	SELF := le;
				  											END; 
																	
	 /* perform the DENORMALIZE (join) by Seq #                                        */   															 															
	UpdateReportingSourcesInReport := DENORMALIZE(BusnData, BusReportBureauDataset,
	                                            LEFT.seq = RIGHT.seq, 
											                                 CreateNestedData(Left, Right, Counter));  
	//**********************************End of Bureau Reporting**********************************************************************************************************************	
			
		
 //***This section is for Operating Information  ***//
	AddOperInformationToReport   :=  UpdateReportingSourcesInReport;  

																													
													 
	// ********************
	//   DEBUGGING OUTPUTS
	// *********************

	    IF(DebugMode,      OUTPUT(ListOfBusSources,                NAMED('ListOfBusSources')));								 
	    IF(DebugMode,      OUTPUT(BusReportBureauDataset,          NAMED('BusReportBureauDataset')));								 
   	 IF(DebugMode,      OUTPUT(CHOOSEN(UpdateReportingSourcesInReport, 100),     NAMED('UpdateReportingSourcesInReport')));												 

	RETURN AddOperInformationToReport;
END;