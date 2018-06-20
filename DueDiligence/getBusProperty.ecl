﻿IMPORT Address, BIPV2, Business_Risk_BIP, LN_PropertyV2, MDR, DueDiligence, SALT28, iesp, STD;

EXPORT getBusProperty(DATASET(DueDiligence.layouts.Busn_Internal) BusnData, 
											 Business_Risk_BIP.LIB_Business_Shell_LIBIN Options,
											 BIPV2.mod_sources.iParams linkingOptions,
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
	propertyCleanDates := DueDiligence.Common.CleanDatasetDateFields(PropertyRaw_with_seq, 'dt_first_seen, dt_vendor_first_reported, dt_last_seen, dt_vendor_last_reported');


  // ------                                                                                    ------	
  // ------ When this query runs in ARCHIVE MODE the History date on the input contains a date ------
	// ------ Use this function drop property records that are out of scope for this transaction ------
	// ------ If the History date is all 9's essentially no records will be dropped - also known ------
	// ------ as CURRENT MODE.                                                                   ------
	// ------                                                                                    ------
	Property_Filtered := DueDiligence.Common.FilterRecords(propertyCleanDates, dt_first_seen, dt_vendor_first_reported); 

  //we need to project the first and last seen dates with vendor if they are not populated so we do not lose records....
  formatProperty := PROJECT(Property_Filtered, TRANSFORM(DueDiligence.LayoutsInternal.PropertySlimLayout,
                                                                  SELF.sourceCode := LEFT.source_code;
                                                                  SELF.LNFaresId := LEFT.ln_fares_id;
                                                                  SELF.dateFirstSeen := IF(LEFT.dt_first_seen > 0, LEFT.dt_first_seen, LEFT.dt_vendor_first_reported);
                                                                  SELF.dateLastSeen := IF(LEFT.dt_last_seen > 0, LEFT.dt_last_seen, LEFT.dt_vendor_last_reported);
                                                                  SELF.historyDate := IF(LEFT.historyDate = DueDiligence.Constants.date8Nines, STD.Date.Today(), LEFT.historyDate); 
                                                                  SELF.ownerName := LEFT.cname;
                                                                  SELF := LEFT;
                                                                  SELF := [];));
                                                                
  //remove all duplicate values
  propertyDeduped := DEDUP(formatProperty, ALL);    
  
  
  propDetails := DueDiligence.getSharedProperty(propertyDeduped);
  
  //convert the data to what will be used for the business report
  reportProp := PROJECT(propDetails, TRANSFORM({DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout, INTEGER8 totalPropertySumAssedValue, 
                                                                    UNSIGNED2 soldCnt, UNSIGNED2 ownCnt, DATASET(DueDiligence.Layouts.BusPropertyDataLayout) propReport},
                                                
                                                SELF.totalPropertySumAssedValue := LEFT.totalSumAssessedValue;
                                                SELF.soldCnt := LEFT.soldPropCnt;
                                                SELF.ownCnt := LEFT.ownPropCnt;
                                                SELF.propReport := PROJECT(LEFT.ownedProps, TRANSFORM(DueDiligence.Layouts.BusPropertyDataLayout,
                                                                                                      SELF.prim_range := LEFT.prim_range;
                                                                                                      SELF.predir := LEFT.predir;
                                                                                                      SELF.prim_name := LEFT.prim_name;
                                                                                                      SELF.addr_suffix := LEFT.suffix;
                                                                                                      SELF.postdir := LEFT.postdir;
                                                                                                      SELF.unit_desig := LEFT.unit_desig;
                                                                                                      SELF.sec_range := LEFT.sec_range;
                                                                                                      SELF.city := LEFT.p_city_name;
                                                                                                      SELF.state := LEFT.st;
                                                                                                      SELF.zip5 := LEFT.zip;
                                                                                                      SELF.zip4 := LEFT.zip4;
                                                                                                      SELF.county := LEFT.county;
                                                                                                      SELF.geo_blk := LEFT.geo_blk;
                                                                                                      SELF.addressType := LEFT.addressType;
                                                                                                      SELF.purchaseDate := LEFT.purchaseDate;
                                                                                                      SELF.purchasePrice := LEFT.purchasePrice;
                                                                                                      SELF.lengthOfOwnership := LEFT.lengthOfOwnership;
                                                                                                      SELF.assessedYear := LEFT.assessedYear;
                                                                                                      SELF.assessedValue := LEFT.assessedTotalValue;
                                                                                                      SELF.ownerName := LEFT.ownerName;
                                                                                                      SELF := [];));
                                                SELF := LEFT;));
  
 
 
	UpdateBusnOwnedProperty := JOIN(BusnData, reportProp,
                                  LEFT.seq = RIGHT.seq AND
                                  LEFT.Busn_info.BIP_IDS.UltID.LinkID  = RIGHT.ultID AND
                                  LEFT.Busn_info.BIP_IDS.OrgID.LinkID  = RIGHT.orgID AND
                                  LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.seleID,												
                                  TRANSFORM(DueDiligence.Layouts.Busn_Internal, 
                                            SELF.CurrPropOwnedCount := RIGHT.ownCnt;
                                            SELF.PropTaxValue       := RIGHT.totalPropertySumAssedValue;
                                            SELF.CountSoldProp      := RIGHT.soldCnt;
                                            SELF.properties         := RIGHT.propReport;
                                            SELF := LEFT),
                                  LEFT OUTER);

	
	// ********************
	//   DEBUGGING OUTPUTS
	// *********************
	 IF(DebugMode,     OUTPUT(CHOOSEN(BusnKeys, 10),              NAMED('Sample_BusnKeys_for_Property')));    	   	 
	 IF(DebugMode,     OUTPUT(CHOOSEN(PropertyRaw_with_seq, 10),  NAMED('Sample_PropertyStep1_ALL')));
	 IF(DebugMode,     OUTPUT(COUNT  (PropertyRaw_with_seq),       NAMED('HowManyPropertyStep1')));
	 IF(DebugMode,     OUTPUT(CHOOSEN(Property_Filtered, 100),     NAMED('Sample_Property_Filtered_Step2')));
	 IF(DebugMode,     OUTPUT(COUNT  (Property_Filtered),          NAMED('HowManyPropertyAfterFilter')));


   
   // OUTPUT(PropertyRaw_with_seq, NAMED('PropertyRaw_with_seq'));
   // OUTPUT(propertyCleanDates, NAMED('propertyCleanDates'));
   // OUTPUT(Property_Filtered, NAMED('Property_Filtered'));
   
   // OUTPUT(formatProperty, NAMED('formatProperty'));
   // OUTPUT(propertyDeduped, NAMED('propertyDeduped'));
   // OUTPUT(propDetails, NAMED('propDetails'));
   // OUTPUT(reportProp, NAMED('reportProp'));
   // OUTPUT(UpdateBusnOwnedProperty, NAMED('UpdateBusnOwnedProperty'));



	RETURN UpdateBusnOwnedProperty;

END; 