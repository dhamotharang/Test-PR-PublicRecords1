IMPORT BIPv2, iesp, DueDiligence;

EXPORT reportBusOperatingInformation(DATASET(DueDiligence.layouts.Busn_Internal) BusnData, 
													 boolean DebugMode = FALSE
											     ) := FUNCTION
//****************************Begining of Bureau Reporting ***************************************************************************
		// ------                                                                                            ------
		// ------  In the getBusHeader the bureaus reporting information on this  business is collected.     ------
		// ------  The bureauReporting is a nested DATASET within the Business Internal layout - the BusnData ------
		// ------  so don't be confused by the LEFT.bureauReporting - this data will come in on the RIGHT    ------
		// ------  convert this into a flat/simple dataset before populating the report                      ------
		// ------                                                                                            ------
		
	 ListOfBusSources := NORMALIZE(BusnData, LEFT.bureauReporting, TRANSFORM(DueDiligence.LayoutsInternalReport.ListOfBusSourceLayout,
                             /*  start by extracting the child dataset from the Parent  */  																														
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
	 DATASET(iesp.duediligencebusinessreport.t_DDRReportingSources) ReportingBureausChild;
	END;
	
	// ------                                                                        ------
 // ------ populate the ChildDataset  with the list of Reporting Bureaus         ------
 // ------ by building a DATASET we can INSERT the entire ChiledDATASET          ------
 // ------ as a 'WHOLE' into the DATASET defined within the PARENT               ------
	// ------                                                                       ------
	iesp.duediligencebusinessreport.t_DDRReportingSources  FormatTheListOfRepBur(ListOfBusSources le, Integer bureauCount) := TRANSFORM, 
	                              SKIP(bureauCount > iesp.constants.DDRAttributesConst.MaxReportingBureaus)
																															SELF.SourceName                       := le.source;                      
																															SELF.SourceType                       := le.sourceType;
																															SELF.FirstReported.Year               := (unsigned4)((STRING)le.firstreported)[1..4];  //YYYY
																															SELF.FirstReported.Month              := (unsigned2)((STRING)le.firstreported)[5..6];  //MM
																															SELF.FirstReported.Day                := (unsigned2)((STRING)le.firstreported)[7..8];  //DD
																															SELF.LastReported.Year                := (unsigned4)((STRING)le.lastreported)[1..4];
																															SELF.LastReported.Month               := (unsigned2)((STRING)le.lastreported)[5..6];
																															SELF.LastReported.Day                 := (unsigned2)((STRING)le.lastreported)[7..8]; 
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
												     SELF.BusinessReport.BusinessAttributeDetails.Operating.BusinessInformation.NumberOfBureauReporting       := le.creditSrcCnt; 
									
														   //***                                                                                          ReportingBureaus is the NESTED CHILD DATASET  
																 SELF.BusinessReport.BusinessAttributeDetails.Operating.BusinessInformation.ReportingBureaus     := le.BusinessReport.BusinessAttributeDetails.Operating.BusinessInformation.ReportingBureaus  + ri.ReportingBureausChild;
																	SELF := le;
				  											END; 
																	
	 /* perform the DENORMALIZE (join) by Seq #                                        */   															 															
	UpdateBureauSourcesInReport := DENORMALIZE(BusnData, BusReportBureauDataset,
	                                            LEFT.seq = RIGHT.seq, 
											                                 CreateNestedData(Left, Right, Counter));  
	//**********************************End of Credit Bureau Reporting Sources*********************************************************************	
	
	//****************************Begining of Non-Credit Bureau Sources ***************************************************************************
		// ------                                                                                            ------
		// ------  In the getBusHeader the business Shell reporting information on this  business is collected. ---
		// ------  The Bus Shell data is a nested DATASET within the Business Internal layout - the BusnData ------
		// ------  so don't be confused by the LEFT.sourcesReporting - this data will come in on the RIGHT    ------
		// ------  convert this into a flat/simple dataset before populating the report                      ------
		// ------                                                                                            ------
		
	 ListOfBusShellSources := NORMALIZE(UpdateBureauSourcesInReport, LEFT.sourcesReporting, TRANSFORM(DueDiligence.LayoutsInternalReport.ListOfBusSourceLayout,
	                            /*  start by extracting the child dataset from the Parent  */ 
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
	BusinessShellChildDatasetLayout    := RECORD
	 unsigned2                      seq;                                           //*  This is the seqence number of the parent   
	 DATASET(iesp.duediligencebusinessreport.t_DDRReportingSources) BusShellSourceChild;
	END;
	
	// ------                                                                        ------
 // ------ populate the ChildDataset  with the list of Reporting Bureaus         ------
 // ------ by building a DATASET we can INSERT the entire ChiledDATASET          ------
 // ------ as a 'WHOLE' into the DATASET defined within the PARENT               ------
	// ------                                                                       ------
	iesp.duediligencebusinessreport.t_DDRReportingSources  FormatTheListOfBusShellSource(ListOfBusSources le, Integer BSSourceCount) := TRANSFORM, SKIP(BSSourceCount > iesp.constants.DDRAttributesConst.MaxReportingSources)
																															SELF.SourceName                       := le.source;                      
																															SELF.SourceType                       := le.sourceType;
																															SELF.FirstReported.Year               := (unsigned4)((STRING)le.firstreported)[1..4];  //YYYY
																															SELF.FirstReported.Month              := (unsigned2)((STRING)le.firstreported)[5..6];  //MM
																															SELF.FirstReported.Day                := (unsigned2)((STRING)le.firstreported)[7..8];  //DD
																															SELF.LastReported.Year                := (unsigned4)((STRING)le.lastreported)[1..4];
																															SELF.LastReported.Month               := (unsigned2)((STRING)le.lastreported)[5..6];
																															SELF.LastReported.Day                 := (unsigned2)((STRING)le.lastreported)[7..8]; 
			                            SELF                                  := [];
				                     END;  
	 

	BusShellSourceDataset  :=   
	PROJECT(ListOfBusShellSources,                                  //*** Using this input dataset - these sources will get moved to the reporting section 
			TRANSFORM(BusinessShellChildDatasetLayout,                    //*** format the data according to this layout.
				SELF.seq                    := LEFT.seq,                     //*** This is the sequence number of the Inquired Business (or the Parent)
				SELF.BusShellSourceChild   := PROJECT(LEFT, FormatTheListOfBusShellSource(LEFT, COUNTER)))); 
				       

 // ------                                                                        ------
 // ------ define the TRANSFORM used by the DENORMALIZE FUNCTION                  ------
 // ------ that is bringing the parent (BusnData) on the LEFT and the newly       ------
 // ------ created child dataset on the RIGHT.                                    ------
	// ------                                                                        ------
	  DueDiligence.Layouts.Busn_Internal CreateNestedBSData(UpdateBureauSourcesInReport le, BusShellSourceDataset ri, Integer BRBCount) := TRANSFORM
												     SELF.BusinessReport.BusinessAttributeDetails.Operating.BusinessInformation.NumberOfSourcesReporting       := le.nonCreditSrcCnt; 
									
														   //***                                                                                          ReportingBureaus is the NESTED CHILD DATASET  
																 SELF.BusinessReport.BusinessAttributeDetails.Operating.BusinessInformation.ReportingSources     := le.BusinessReport.BusinessAttributeDetails.Operating.BusinessInformation.ReportingSources  + ri.BusShellSourceChild;
																	SELF := le;
				  											END; 
																	
	 /* perform the DENORMALIZE (join) by Seq #                                        */   															 															
	UpdateBOTHSourcesInReport := DENORMALIZE(UpdateBureauSourcesInReport, BusShellSourceDataset,
	                                            LEFT.seq = RIGHT.seq, 
											                                 CreateNestedBSData(Left, Right, Counter));  	
		
	
	//**********************************End of NON-Credit Sources Reporting**********************************************************************************************************************	
			
	
  //retrieve all names associated with the fein
  assocNames := NORMALIZE(BusnData, LEFT.namesAssocWithFein, TRANSFORM({DueDiligence.LayoutsInternal.InternalBIPIDsLayout, DueDiligence.Layouts.Name, UNSIGNED4 dateLastSeen},
                                                                        SELF.ultID := LEFT.Busn_info.BIP_IDS.UltID.LinkID;
                                                                        SELF.orgID := LEFT.Busn_info.BIP_IDS.orgID.LinkID;
                                                                        SELF.seleID := LEFT.Busn_info.BIP_IDS.seleID.LinkID;
                                                                        SELF := RIGHT;
                                                                        SELF := LEFT;
                                                                        SELF := [];));
	
	sortGroupAssocNames := GROUP(SORT(assocNames, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), -dateLastSeen), seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()));
  
  //limit the number of associated names for a given fein
  DueDiligence.LayoutsInternalReport.BusOpInfoAssociatedNamesByFein getMaxAssociatedNamesByFein(sortGroupAssocNames sgan, INTEGER nameCount) := TRANSFORM, SKIP(nameCount > iesp.constants.DDRAttributesConst.MaxSSNAssociations)
    SELF.name := PROJECT(sgan, TRANSFORM(iesp.share.t_Name,
                                          SELF.first := LEFT.firstName;
                                          SELF.middle := LEFT.middleName;
                                          SELF.last := LEFT.lastName;
                                          SELF.suffix := LEFT.suffix;
                                          SELF := [];));
    SELF := sgan;
    SELF := [];
  END;
  
  limitedNames := SORT(PROJECT(sortGroupAssocNames, getMaxAssociatedNamesByFein(LEFT, COUNTER)), seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()));
  
  rollNames := ROLLUP(limitedNames,
                      #EXPAND(DueDiligence.Constants.mac_JOINLinkids_Results()), 
                      TRANSFORM(RECORDOF(LEFT),
                                SELF.name := LEFT.name + RIGHT.name;
                                SELF := LEFT));
  
  addAssociatedNames := JOIN(UpdateBOTHSourcesInReport, rollNames,
                             #EXPAND(DueDiligence.Constants.mac_JOINLinkids_BusInternal()), 
                             TRANSFORM(RECORDOF(LEFT),
                                        SELF.BusinessReport.BusinessAttributeDetails.Operating.BusinessInformation.FEIN := LEFT.busn_info.fein;
                                        SELF.BusinessReport.BusinessAttributeDetails.Operating.BusinessInformation.FEINIsSSN := LEFT.feinIsSSN;
                                        SELF.BusinessReport.BusinessAttributeDetails.Operating.BusinessInformation.SSNAssociatedWith := RIGHT.name;
                                        SELF.BusinessReport.BusinessAttributeDetails.Operating.BusinessInformation.OperatesOutOfAHomeOffice := LEFT.busIsSOHO;
                                        SELF := LEFT;),
                             LEFT OUTER);

  
  
  //***This section is for Operating Information  ***//
	AddOperInformationToReport   :=  addAssociatedNames;  

																													
													 
	// ********************
	//   DEBUGGING OUTPUTS
	// *********************

	    IF(DebugMode,      OUTPUT(ListOfBusSources,                NAMED('ListOfBusSources')));								 
	    IF(DebugMode,      OUTPUT(BusReportBureauDataset,          NAMED('BusReportBureauDataset')));								 
   	 IF(DebugMode,      OUTPUT(CHOOSEN(UpdateBOTHSourcesInReport, 100),     NAMED('UpdateBOTHSourcesInReport')));												 

  // OUTPUT(assocNames, NAMED('assocNames'));
  // OUTPUT(sortGroupAssocNames, NAMED('sortGroupAssocNames'));
  // OUTPUT(limitedNames, NAMED('limitedNames'));
  // OUTPUT(rollNames, NAMED('rollNames'));
  // OUTPUT(addAssociatedNames, NAMED('addAssociatedNames'));

	RETURN AddOperInformationToReport;
END;