
IMPORT Address, BIPV2, Business_Risk_BIP, LN_PropertyV2, MDR, DueDiligence, SALT28, iesp;

EXPORT getBusProperty(DATASET(DueDiligence.layouts.Busn_Internal) BusnData, 
											 Business_Risk_BIP.LIB_Business_Shell_LIBIN Options,
											 BIPV2.mod_sources.iParams linkingOptions,
											 //ReportIsRequested = TRUE,  
											 boolean DebugMode = FALSE
											 ) := FUNCTION

  // ------                                                                            ------
	// ------ Get the LinkIDs for this Business                                          ------
	// ------                                                                            ------
	BusnKeys    := DueDiligence.Common.GetLinkIDs(BusnData);
	
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
	DueDiligence.Common.AppendSeq(PropertyRaw, BusnData, PropertyRaw_with_seq);

  // ------                                                                                    ------	
  // ------ When this query runs in ARCHIVE MODE the History date on the input contains a date ------
	// ------ Use this function drop property records that are out of scope for this transaction ------
	// ------ If the History date is all 9's essentially no records will be dropped - also known ------
	// ------ as CURRENT MODE.                                                                   ------
	// ------                                                                                    ------
	Property_Filtered := DueDiligence.Common.FilterRecords(PropertyRaw_with_seq, dt_first_seen, dt_vendor_first_reported); 
	
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
  
	// ------                                                                                    ------
	// ----- Summarize the results to get the Current owned Property Count for this business     ------
	// ------                                                                                    ------
	Summary_Current_Prop := table(Property_currently_owned, {seq, ultid, orgid, seleid, cname, HistoryDate, OwnPropCnt := count(group)}, seq, ultid, orgid, seleid);
	
  // ------                                                                                    ------	
	// ----- Add the property count to Busn_Internal layout                                      ------
	// ------                                                                                    ------
	UpdateBusnProperty := JOIN(BusnData, Summary_Current_Prop,
												LEFT.seq = RIGHT.seq AND
												LEFT.Busn_info.BIP_IDS.UltID.LinkID  = RIGHT.ultID AND
												LEFT.Busn_info.BIP_IDS.OrgID.LinkID  = RIGHT.orgID AND
												LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.seleID,												
												TRANSFORM(DueDiligence.Layouts.Busn_Internal, 
																	SELF.CurrPropOwnedCount := RIGHT.OwnPropCnt,
																	SELF := LEFT),
																	LEFT OUTER);

   // ------                                                                                    ------   
	 // ------ Start building the sections of the report that are available at this point         ------ 
	 // ------ Note next release the report will be optional                                      ------
	 // ------                                                                                    ------
	 
	 // ------                                                                                    ------
	 // ------ Limit the number of property for each business listed in the report                ------ 
	 // ------                                                                                    ------
	 PropertyCurrentlyOwnedButLimited   := dedup(sort(Property_currently_owned,  seleid), seleid, KEEP(iesp.constants.DDRAttributesConst.MaxAssets)); 

	 
	// ------                                                                                    ------
  // ------ create the ChildDataset of Property                                                ------
	// ------                                                                                    ------
	PropertyChildDatasetLayout    := RECORD
	  unsigned2                      seq;                                                        //*  This is the seqence number of the parent  
	  DATASET(iesp.duediligencereport.t_DDRProperty) PropChild;
	END;
	 
	PropertyChildDataset  :=   
		PROJECT(PropertyCurrentlyOwnedButLimited,
			TRANSFORM(PropertyChildDatasetLayout,
				SELF.seq             := LEFT.seq,
				SELF.PropChild       := PROJECT (LEFT, TRANSFORM (iesp.duediligencereport.t_DDRProperty,  
				       
				                                         SELF.Address.StreetNumber          := LEFT.prim_range;
																								 SELF.Address.StreetPreDirection    := LEFT.predir; 
				                                         SELF.Address.StreetName            := LEFT.prim_name;
																								 SELF.Address.StreetSuffix          := LEFT.suffix;
																								 SELF.Address.StreetPostDirection   := LEFT.postdir;
																								 SELF.Address.UnitDesignation       := LEFT.unit_desig;
																								 SELF.Address.UnitNumber            := LEFT.sec_range;
																								 SELF.Address.City                  := LEFT.p_city_name;
																								 SELF.Address.State                 := LEFT.st;
																								 SELF.Address.Zip5                  := LEFT.zip; 
				                                         SELF                               := []))));  
	
	 /*  define the TRANSFORM used by the DENORMALIZE FUNCTION                        */  
	  DueDiligence.Layouts.Busn_Internal CreateNestedData(UpdateBusnProperty le, PropertyChildDataset ri, Integer PropCount) := TRANSFORM
												          SELF.BusinessReport.BusinessAttributeDetails.EconomicAttributeDataDetails.PropertyOwnerShip.PropertyCurrentCount  := le.CurrPropOwnedCount,
																	SELF.BusinessReport.BusinessAttributeDetails.EconomicAttributeDataDetails.PropertyOwnerShip.Properties := le.BusinessReport.BusinessAttributeDetails.EconomicAttributeDataDetails.PropertyOwnerShip.Properties + ri.PropChild;
																	SELF := le;
																	END; 
																	
	 /* perform the DENORMALIZE (join) by Seq #                                        */   															 															
	 UpdateBusnPropertyWithReport := DENORMALIZE(UpdateBusnProperty, PropertyChildDataset,
	                                             LEFT.seq = RIGHT.seq, 
												                       CreateNestedData(Left, Right, Counter));  
																							
	// ********************
	//   DEBUGGING OUTPUTS
	// *********************
	 
	 IF(DebugMode,     OUTPUT(CHOOSEN(BusnKeys, 100),              NAMED('Sample_BusnKeys_for_Property')));    	   	 
	
	 IF(DebugMode,     OUTPUT(CHOOSEN(PropertyRaw_with_seq, 100),  NAMED('Sample_PropertyStep1_ALL')));
	 IF(DebugMode,     OUTPUT(COUNT  (PropertyRaw_with_seq),       NAMED('HowManyPropertyStep1')));
	 
	 IF(DebugMode,     OUTPUT(CHOOSEN(Property_Filtered, 100),     NAMED('Sample_Property_Filtered_Step2')));
	 IF(DebugMode,     OUTPUT(COUNT  (Property_Filtered),          NAMED('HowManyPropertyStep2')));
	 
	 IF(DebugMode,     OUTPUT(CHOOSEN(Property_owned_at_some_point, 100),    NAMED('Sample_Property_owned_Step3')));
	 IF(DebugMode,     OUTPUT(COUNT  (Property_owned_at_some_point),         NAMED('HowManyPropertyStep3')));
	 
	 IF(DebugMode,     OUTPUT(CHOOSEN(Property_sold, 50),          NAMED('Sample_Property_sold_Step4')));
	 IF(DebugMode,     OUTPUT(COUNT  (Property_sold),              NAMED('HowManyPropertyStep4')));
	 
	 IF(DebugMode,     OUTPUT(CHOOSEN(Property_currently_owned, 50),     NAMED('Sample_Property_currently_owned_Step5')));
	 IF(DebugMode,     OUTPUT(COUNT  (Property_currently_owned),         NAMED('HowManyPropertyStep5')));
	 
	 IF(DebugMode,     OUTPUT(CHOOSEN(Summary_Current_Prop, 100),  NAMED('Summary_Property')));
	 
	 IF(DebugMode,     OUTPUT(CHOOSEN(PropertyChildDataset, 100),  NAMED('PropertyChildDataset')));
	 
	 IF(DebugMode,     OUTPUT(CHOOSEN(UpdateBusnPropertyWithReport, 100),  NAMED('UpdateBusnPropertyWithReport')));  
	
	RETURN UpdateBusnPropertyWithReport;

END; 