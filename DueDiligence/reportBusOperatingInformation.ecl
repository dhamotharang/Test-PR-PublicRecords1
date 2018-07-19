IMPORT BIPv2, iesp, DueDiligence;

EXPORT reportBusOperatingInformation(DATASET(DueDiligence.layouts.Busn_Internal) BusnData) := FUNCTION
                                             
  
	//all reporting sources
	allReportingSources := DueDiligence.CommonBusiness.GetMaxSources(BusnData, iesp.constants.DDRAttributesConst.MaxReportingSources);
  
  addAllReportingSources := JOIN(BusnData, allReportingSources,
                              #EXPAND(DueDiligence.Constants.mac_JOINLinkids_BusInternal()), 
                              TRANSFORM(RECORDOF(LEFT),
                                        SELF.BusinessReport.BusinessAttributeDetails.Operating.BusinessInformation.NumberOfSourcesReporting := COUNT(LEFT.sourcesReporting);
                                        SELF.BusinessReport.BusinessAttributeDetails.Operating.BusinessInformation.ReportingSources := RIGHT.sources;
                                        SELF := LEFT;),
                              LEFT OUTER);	                                             
	
	
  //retrieve all names associated with the fein
  assocNames := NORMALIZE(BusnData, LEFT.namesAssocWithFein, TRANSFORM({DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout, DueDiligence.Layouts.Name, UNSIGNED4 dateLastSeen},
                                                                        SELF.seq := LEFT.seq;
                                                                        SELF.ultID := LEFT.Busn_info.BIP_IDS.UltID.LinkID;
                                                                        SELF.orgID := LEFT.Busn_info.BIP_IDS.orgID.LinkID;
                                                                        SELF.seleID := LEFT.Busn_info.BIP_IDS.seleID.LinkID;
                                                                        SELF := RIGHT;
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
  
  limitedNames := SORT(UNGROUP(PROJECT(sortGroupAssocNames, getMaxAssociatedNamesByFein(LEFT, COUNTER))), seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()));
  
  rollNames := ROLLUP(limitedNames,
                      #EXPAND(DueDiligence.Constants.mac_JOINLinkids_Results()), 
                      TRANSFORM(RECORDOF(LEFT),
                                SELF.name := LEFT.name + RIGHT.name;
                                SELF := LEFT));
  
  addAssociatedNames := JOIN(addAllReportingSources, rollNames,
                             #EXPAND(DueDiligence.Constants.mac_JOINLinkids_BusInternal()), 
                             TRANSFORM(RECORDOF(LEFT),
                                                        /*  IF TIN/FEIN is EXPERIAN RESTRICTED  then use the MASKED FEIN */ 
                                                        /*  EXPERIAN is letting us know this FEIN may be an SSN - so it must be masked
																										    /*  Expecting online request to have the SSN_MASK of '' and take care of masking in Evolution */
                                                        /*  Expecting API request to have the SSN_MASK of ALL, NONE, FIRST5, LAST4 or '' based on customer's setting in MBS */  
                                        SELF.BusinessReport.BusinessAttributeDetails.Operating.BusinessInformation.FEIN := IF(LEFT.FEINSourceContainsE5 = true, LEFT.FEIN_Masked_For_Report, LEFT.busn_info.fein);
                                        SELF.BusinessReport.BusinessAttributeDetails.Operating.BusinessInformation.FEINIsSSN := LEFT.feinIsSSN;
                                        SELF.BusinessReport.BusinessAttributeDetails.Operating.BusinessInformation.SSNAssociatedWith := RIGHT.name;
                                        SELF.BusinessReport.BusinessAttributeDetails.Operating.BusinessInformation.OperatesOutOfAHomeOffice := LEFT.busIsSOHO;
                                        SELF := LEFT;),
                             LEFT OUTER);
                             
                             
                             
  //retrieve all the doing business as variations (DBAs)
  dbaNames := NORMALIZE(BusnData, LEFT.companyDBA, TRANSFORM({DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout, STRING companyName, UNSIGNED4 dateLastSeen},
                                                              SELF.seq := LEFT.seq;
                                                              SELF.ultID := LEFT.Busn_info.BIP_IDS.UltID.LinkID;
                                                              SELF.orgID := LEFT.Busn_info.BIP_IDS.orgID.LinkID;
                                                              SELF.seleID := LEFT.Busn_info.BIP_IDS.seleID.LinkID;
                                                              SELF.companyName := RIGHT.Name;
                                                              SELF.dateLastSeen := RIGHT.LinkCount; //using this field to hold date last seen
                                                              SELF := [];));

  
  //get max DBAs to return
  sortDBANames := GROUP(SORT(dbaNames, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), -dateLastSeen), seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()));
  
  DueDiligence.LayoutsInternalReport.BusOpInfoDBANames getMaxDBAs(sortDBANames sdban, INTEGER dbaCount) := TRANSFORM, SKIP(dbaCount > iesp.constants.DDRAttributesConst.MaxBusinesses)
    SELF.businessNames := PROJECT(sdban, TRANSFORM(iesp.duediligencebusinessreport.t_DDRComponentsOfBusiness,
                                                      SELF.name := LEFT.companyName;
                                                      SELF := [];));
                                                      
    SELF := sdban;
    SELF := [];
  END;
  
  maxDBANames := SORT(PROJECT(sortDBANames, getMaxDBAs(LEFT, COUNTER)), seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()));
  
  rollDBANames := ROLLUP(maxDBANames,
                          #EXPAND(DueDiligence.Constants.mac_JOINLinkids_Results()), 
                          TRANSFORM(RECORDOF(LEFT),
                                    SELF.businessNames := LEFT.businessNames + RIGHT.businessNames;
                                    SELF := LEFT));
  
  addDBANames := JOIN(addAssociatedNames, rollDBANames,
                       #EXPAND(DueDiligence.Constants.mac_JOINLinkids_BusInternal()), 
                       TRANSFORM(RECORDOF(LEFT),
                                  SELF.BusinessReport.BusinessAttributeDetails.Operating.BusinessInformation.BusinessNameVariations := RIGHT.businessNames;
                                  SELF := LEFT;),
                       LEFT OUTER);
  
  
  
  //add 'loose' data to the report
  addMiscInfo := PROJECT(addDBANames, TRANSFORM(RECORDOF(LEFT),
                                                SELF.BusinessReport.BusinessAttributeDetails.Operating.BusinessInformation.ParentCompany := LEFT.parentCompanyName;
                                                SELF.BusinessReport.BusinessAttributeDetails.Operating.BusinessInformation.StructureType := IF(LEFT.hdBusnType = DueDiligence.Constants.EMPTY, LEFT.adrBusnType, LEFT.hdBusnType);
                                                SELF := LEFT;));
  
  
  
  //***This section is for Operating Information  ***//
	AddOperInformationToReport   :=  addMiscInfo;  

																													
													 
	// ********************
	//   DEBUGGING OUTPUTS
	// *********************
  // OUTPUT(allReportingSources, NAMED('allReportingSources'));
  
  // OUTPUT(assocNames, NAMED('assocNames'));
  // OUTPUT(sortGroupAssocNames, NAMED('sortGroupAssocNames'));
  // OUTPUT(limitedNames, NAMED('limitedNames'));
  // OUTPUT(rollNames, NAMED('rollNames'));
  // OUTPUT(addAssociatedNames, NAMED('addAssociatedNames'));
  
  // OUTPUT(dbaNames, NAMED('dbaNames'));
  // OUTPUT(maxDBANames, NAMED('maxDBANames'));
  // OUTPUT(rollDBANames, NAMED('rollDBANames'));
  // OUTPUT(addDBANames, NAMED('addDBANames'));
  
  // OUTPUT(addMiscInfo, NAMED('addMiscInfo'));

	RETURN AddOperInformationToReport;
END;