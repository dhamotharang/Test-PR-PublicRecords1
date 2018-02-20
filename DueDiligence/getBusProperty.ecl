IMPORT Address, BIPV2, Business_Risk_BIP, LN_PropertyV2, MDR, DueDiligence, SALT28, iesp, STD;

EXPORT getBusProperty(DATASET(DueDiligence.layouts.Busn_Internal) BusnData, 
											 Business_Risk_BIP.LIB_Business_Shell_LIBIN Options,
											 BIPV2.mod_sources.iParams linkingOptions,
											 boolean ReportIsRequested,  
											 boolean DebugMode = FALSE
											 ) := FUNCTION

  // ------                                                                             ------
	// ------ Get the LinkIDs for this Business                                          ------
	// ------                                                                            ------
	BusnKeys    := DueDiligence.CommonBusiness.GetLinkIDs(BusnData);
	
  // ------                                                                            ------	
	// ------ Property Data - Using Business IDs                                         ------
	// ------                                                                            ------
	PropertyRaw := LN_PropertyV2.Key_LinkIds.kFetch2(BusnKeys,     
																						 Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
																							0,                                                                    /*ScoreThreshold --> 0 = Give me everything*/
																							linkingOptions,
																							Business_Risk_BIP.Constants.Limit_Property,      
																							Options.KeepLargeBusinesses);
	
	// ------                                                                             ------
	// ------ Add our sequence number to the Raw Property records found for this Business ------
	// ------                                                                             ------
	PropertyRaw_with_seq := DueDiligence.CommonBusiness.AppendSeq(PropertyRaw, BusnData, TRUE);
	
	//Clean dates used in logic and/or attribute levels here so all comparisions flow through consistently
	propertyCleanDates := DueDiligence.Common.CleanDatasetDateFields(PropertyRaw_with_seq, 'dt_first_seen, dt_vendor_first_reported');


  // ------                                                                                    ------	
  // ------ When this query runs in ARCHIVE MODE the History date on the input contains a date ------
	// ------ Use this function drop property records that are out of scope for this transaction ------
	// ------ If the History date is all 9's essentially no records will be dropped - also known ------
	// ------ as CURRENT MODE.                                                                   ------
	// ------                                                                                    ------
	Property_Filtered := DueDiligence.Common.FilterRecords(propertyCleanDates, dt_first_seen, dt_vendor_first_reported); 
	
	// ------                                                                                    ------
	// ------ select property records that were OWNED at some point by this business             ------
	// ------ and get rid of duplicate addresses                                                 ------
	// ------                                                                                    ------
  Property_owned_at_some_point  := dedup(sort(Property_Filtered(Source_Code = DueDiligence.Constants.Owned_Property_code),  seleid, prim_range, prim_name[1..8]), seleid, prim_range, prim_name[1..8]);	
	
	// ------                                                                                    ------
  // ------ select property records that were SOLD at some point by this business              ------
	// ------ and get rid of duplicate addresses                                                 ------
	// ------                                                                                    ------
	Property_sold                 := dedup(sort(Property_Filtered(Source_Code = DueDiligence.Constants.Sold_Property_code),  seleid, prim_range, prim_name[1..8]), seleid, prim_range, prim_name[1..8]);   
	
  // ------                                                                                    ------
	// ------ select property records that are Currenty OWNED                                    ------
	// ------ (that is if the records on right (SOLD) cancell out the records on the left        ------ 
	// ------                                                                                    ------
	Property_currently_owned := join(Property_owned_at_some_point, Property_sold,
	                       left.seq    = right.seq  and
																       	left.ultid  = right.ultid  and
																	       left.orgid  = right.orgid  and
	                       left.seleid = right.seleid and
										              left.prim_range = right.prim_range and
										              left.prim_name = right.prim_name and
										              left.suffix = right.suffix and
										              left.postdir = right.postdir and
										              left.st = right.st and
										              left.p_city_name = right.p_city_name and
										              left.zip = right.zip,
										                 transform(recordof(left), 
																		          self := left),
										                          left only);
  
	
		
 // ----- Get the assessed value and other details for each property in the list --------
 // ----- LN_PropertyV2.key_assessor_fid                                         --------	
 PropertyAssessmentFidNonFCRA	:= LN_PropertyV2.key_assessor_fid();
		
		
 DueDiligence.LayoutsInternal.PropertySlimLayout  FormatPropertySlim(Property_currently_owned LE, PropertyAssessmentFidNonFCRA RI, Integer calcSeq) := TRANSFORM
																			SELF.PropertyReportData.seq    := LE.Seq,
																			SELF.PropertyReportData.ultID  := LE.ultID,
																			SELF.PropertyReportData.orgID  := LE.orgID,
																			SELF.PropertyReportData.seleID := LE.seleID,
																			SELF.PropertyReportData.proxID := LE.proxID,
																			SELF.PropertyReportData.powID  := LE.powID,
																			//SELF.propertySeq               := calcSeq +1,
																			SELF.LNFaresId                 := RI.ln_fares_id,
										         SELF.TaxAssdValue              := (INTEGER)RI.assessed_total_value,
															    SELF.TaxAmount                 := (INTEGER)RI.tax_amount, 
																			SELF.TaxYear                   := RI.tax_year,  
															    SELF.OwnerOccupied             := RI.owner_occupied,
																			SELF.PurchasePrice             := (INTEGER)RI.sales_price,
																			SELF.AssesseeName              := RI.assessee_name,
																			SELF.SaleDate                  := RI.sale_date,
																			SELF.LengthOfOwnership         := DueDiligence.Common.DaysApartWithZeroEmptyDate(RI.sale_date, (STRING)LE.historydate)/30,        //store the value in months. 
																			SELF.BusinessType              := RI.county_land_use_description,
																			SELF.County                    := LE.County,
																			SELF.geo_blk                   := LE.geo_blk;
																			SELF.CountyName                := RI.county_name,
																			/*  populate the remaining fields from the left  */  
										         SELF                           := LE,
														     SELF                           :=  [];
									   END;     
																
		BusPropertyOwnedWithDetails  := join(Property_currently_owned, PropertyAssessmentFidNonFCRA,
		                                    /*   WHERE    */  
		                                      Keyed(left.ln_fares_id = right.ln_fares_id),
																					                 /*   USING THIS TRANSFORM to build the output  */  
																				                   FormatPropertySlim(LEFT, RIGHT, COUNTER), LEFT OUTER,
																													            ATMOST(keyed(LEFT.LN_fares_id=RIGHT.ln_fares_id), 100));
	
	
	// ------                                                                                    ------
	// ----- Summarize the results to get the Current owned Property Count for this business     ------
	// ------                                                                                    ------
	Summary_Current_Prop := table(BusPropertyOwnedWithDetails,
	                               /* columns in the table */  
	                              {PropertyReportData.seq, 
																PropertyReportData.ultid, 
																PropertyReportData.orgid, 
																PropertyReportData.seleid, 
																cname, 
																HistoryDate, 
																TotalAssessedValue := SUM(GROUP, TaxAssdValue), 
																OwnPropCnt := count(group)},
																/* Grouped by */  
																PropertyReportData.seq, PropertyReportData.ultid, PropertyReportData.orgid, PropertyReportData.seleid);
	
 // ------                                                                                    ------
	// ----- Summarize the results to get the SOLD Property Count for this business              ------
	// ------                                                                                    ------
	Summary_SOLD_Prop := table(Property_sold, 
	                              {seq, ultid, orgid, seleid, cname, HistoryDate, 
																SOLDPropCnt := count(group)}, 
																seq, ultid, orgid, seleid);	
		
	
 // ------                                                                                    ------	
	// ----- Add the property count to Busn_Internal layout                                      ------
	// ------                                                                                    ------
	UpdateBusnOwnedProperty := JOIN(BusnData, Summary_Current_Prop,
												LEFT.seq = RIGHT.seq AND
												LEFT.Busn_info.BIP_IDS.UltID.LinkID  = RIGHT.ultID AND
												LEFT.Busn_info.BIP_IDS.OrgID.LinkID  = RIGHT.orgID AND
												LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.seleID,												
												TRANSFORM(DueDiligence.Layouts.Busn_Internal, 
																	SELF.CurrPropOwnedCount := RIGHT.OwnPropCnt,
																	SELF.PropTaxValue       := RIGHT.TotalAssessedValue,
																	SELF := LEFT),
																	LEFT OUTER);


 // ------                                                                                    ------	
	// ----- Add the property SOLD count to Busn_Internal layout                                ------
	// ------                                                                                    ------
	UpdateBusnPropertyForAttributeLogic := JOIN(UpdateBusnOwnedProperty, Summary_SOLD_Prop,
												LEFT.seq = RIGHT.seq AND
												LEFT.Busn_info.BIP_IDS.UltID.LinkID  = RIGHT.ultID AND
												LEFT.Busn_info.BIP_IDS.OrgID.LinkID  = RIGHT.orgID AND
												LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.seleID,												
												TRANSFORM(DueDiligence.Layouts.Busn_Internal, 
																	SELF.CountSoldProp      := RIGHT.SOLDPropCnt,
																	SELF.CountOwnProp       := LEFT.CurrPropOwnedCount + RIGHT.SOLDPropCnt,
																	SELF := LEFT),
																	LEFT OUTER);

  // ------                                                                                    ------   
	 // ------ START BUILDING SECTIONS of the REPORT                                              ------ 
	 // ------                                                                                    ------ 
	 // ------ Limit the number of property for each business listed in the report                ------
	 // ------ Start by sorting them in seleid sequence and getting the property with the         ------
	 // ------ highest property value at the top                                                  ------
	 // ------ Note:  think about changing this to ROLLUP  so that we can be more thoughtful      ------
	 // ------                                                                                    ------
	 //PropertyCurrentlyOwnedButLimited   := dedup(sort(BusPropertyOwnedWithDetails,  PropertyReportData.seleid, -TaxAssdValue), PropertyReportData.seleid,  KEEP(iesp.constants.DDRAttributesConst.MaxProperties)); 
  
	 UpdateBusnPropertyWithReport  := IF(ReportIsRequested, 
	                                     DueDiligence.reportBusProperty(UpdateBusnPropertyForAttributeLogic, BusPropertyOwnedWithDetails, DebugMode),   
																			             /* ELSE */ 
																			                   UpdateBusnPropertyForAttributeLogic); 
	
	// ********************
	//   DEBUGGING OUTPUTS
	// *********************
	 
	 IF(DebugMode,     OUTPUT(CHOOSEN(BusnKeys, 10),              NAMED('Sample_BusnKeys_for_Property')));    	   	 
	
	 IF(DebugMode,     OUTPUT(CHOOSEN(PropertyRaw_with_seq, 10),  NAMED('Sample_PropertyStep1_ALL')));
	 IF(DebugMode,     OUTPUT(COUNT  (PropertyRaw_with_seq),       NAMED('HowManyPropertyStep1')));
	 
	 //IF(DebugMode,     OUTPUT(CHOOSEN(Property_Filtered, 100),     NAMED('Sample_Property_Filtered_Step2')));
	 IF(DebugMode,     OUTPUT(COUNT  (Property_Filtered),          NAMED('HowManyPropertyAfterFilter')));
	 
	 IF(DebugMode,     OUTPUT(CHOOSEN(Property_owned_at_some_point, 10),    NAMED('Sample_Property_owned')));
	 IF(DebugMode,     OUTPUT(COUNT  (Property_owned_at_some_point),         NAMED('HowManyProperty_owned')));
	 
	 IF(DebugMode,     OUTPUT(CHOOSEN(Property_sold, 10),          NAMED('Sample_Property_sold')));
	 IF(DebugMode,     OUTPUT(COUNT  (Property_sold),              NAMED('HowManyProperty_sold')));
	 
	 IF(DebugMode,     OUTPUT(CHOOSEN(Property_currently_owned, 10),     NAMED('Sample_Property_currently_owned')));
	 IF(DebugMode,     OUTPUT(COUNT  (Property_currently_owned),         NAMED('HowManyProperty_currently_owned')));
	 
  IF(DebugMode,     OUTPUT(CHOOSEN(BusPropertyOwnedWithDetails, 10),     NAMED('Sample_BusPropertyOwnedWithDetails')));
	 IF(DebugMode,     OUTPUT(COUNT  (BusPropertyOwnedWithDetails),          NAMED('HowManyBusPropertyOwnedWithDetails')));	 
	 
	 IF(DebugMode,     OUTPUT(CHOOSEN(Summary_Current_Prop, 50),  NAMED('Summary_Property')));
	 
	 IF(DebugMode,     OUTPUT(CHOOSEN(UpdateBusnPropertyWithReport, 10),  NAMED('UpdateBusnPropertyWithReport')));  
	
	RETURN UpdateBusnPropertyWithReport;

END; 