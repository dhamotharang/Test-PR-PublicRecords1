﻿IMPORT BIPV2, Business_Risk_BIP, FAA, MDR, Risk_Indicators, Riskwise, UT, Watercraft, STD;

EXPORT getBusWatercraft(DATASET(DueDiligence.layouts.Busn_Internal) BusnData, 
											 Business_Risk_BIP.LIB_Business_Shell_LIBIN Options,
											 BIPV2.mod_sources.iParams linkingOptions,
											 BOOLEAN includeReportData,
											 boolean DebugMode = FALSE
											 ) := FUNCTION
										 
  // ------                                                                                    ------
  // ------ Watercraft Records                                                                 ------
	// ------                                                                                    ------
	WatercraftRaw := Watercraft.Key_LinkIds.kFetch2(DueDiligence.CommonBusiness.GetLinkIDs(BusnData),
																						 Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
																							0,                                                                     /*ScoreThreshold --> 0 = Give me everything*/
																							linkingOptions,
																							Business_Risk_BIP.Constants.Limit_Default,
																							Options.KeepLargeBusinesses);
																							
  // ------                                                                                    ------	
	// ------ Add our sequence number to the Raw Watercraft records found for this Business      ------
	// ------                                                                                    ------
	WatercraftRaw_with_seq := DueDiligence.CommonBusiness.AppendSeq(WatercraftRaw, BusnData, TRUE);
	
	//Clean dates used in logic and/or attribute levels here so all comparisions flow through consistently
	watercraftCleanDates := DueDiligence.Common.CleanDatasetDateFields(WatercraftRaw_with_seq, 'date_first_seen, date_vendor_first_reported');
	
  // ------                                                                                    ------	
	// ------ When this query runs in ARCHIVE MODE the History date on the input contains a date ------
	// ------ Use this function drop public records that are out of scope for this transaction   ------
	// ------ If the History date is all 9's essentially no records will be dropped - also known ------
	// ------ as CURRENT MODE.                                                                   ------
	// ------                                                                                    ------
	WatercraftRecords := DueDiligence.Common.FilterRecords(watercraftCleanDates, date_first_seen, date_vendor_first_reported);
	
  // ------                                                                                    ------	
	// ------  Get the details about the watercraft from the NON_FCRA version of the watercraft_wid  --
  // ------                                                                                    ------
	Watercraftdetails := watercraft.key_watercraft_wid(false);	

  watercraftSlim := join(WatercraftRecords, Watercraftdetails,
												 right.watercraft_key      = left.watercraft_key and
												 right.state_origin        = left.state_origin   and     
												 right.sequence_key        = left.sequence_key,		 
												 TRANSFORM(DueDiligence.LayoutsInternalReport.BusWatercraftSlimLayout,
																	 SELF.watercraftKey := RIGHT.watercraft_key;
																	 SELF.sequenceKey := RIGHT.sequence_key;
																	 SELF.stateOrigin := RIGHT.state_origin; 
																	 SELF.seq := LEFT.seq;
																	 SELF.ultid := LEFT.ultid;
																	 SELF.orgid := LEFT.orgid;
																	 SELF.seleid := LEFT.seleid;

																	 SELF.watercraftCount := 1;
																	 SELF.year := RIGHT.model_year;
																	 SELF.model := RIGHT.watercraft_model_description;
																	 SELF.make := RIGHT.watercraft_make_description;
																	 SELF.vesselType := RIGHT.vehicle_type_description;
																	 SELF.propulsion := RIGHT.propulsion_description;   

																	 vesselLength := (UNSIGNED2)RIGHT.watercraft_length; 
																	 SELF.vesselTotalLength := vesselLength;
																	 SELF.vesselLengthFeet := vesselLength DIV 12;
																	 SELF.vesselLengthInches := vesselLength % 12;
																																
																	 SELF.vin := RIGHT.registration_number;
																	 SELF.titleState := RIGHT.title_state;
																	 SELF.titleDate := RIGHT.title_issue_date;
																	 SELF.registrationState := RIGHT.st_registration;
																	 SELF.registrationDate := RIGHT.registration_date;
																	 
																	 SELF := RIGHT; 
																	 SELF := [];), 
												 atmost(right.watercraft_key     = left.watercraft_key and 
												        right.state_origin       = left.state_origin   and 
																right.sequence_key       = left.sequence_key,
												        riskwise.max_atmost));
	
	slimSort := SORT(Watercraftslim, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), stateOrigin, watercraftKey, -sequenceKey);
	waterRoll := ROLLUP(slimSort,
												LEFT.seq = RIGHT.seq AND
												LEFT.ultID = RIGHT.ultID AND
												LEFT.orgID = RIGHT.orgID AND
												LEFT.seleID = RIGHT.seleID AND
												LEFT.watercraftKey = RIGHT.watercraftKey AND
												LEFT.stateOrigin = RIGHT.stateOrigin,
												TRANSFORM(RECORDOF(LEFT),
																	boat := IF(LEFT.vesselTotalLength > RIGHT.vesselTotalLength, LEFT, RIGHT);
																	SELF.vesselLengthFeet := boat.vesselLengthFeet;
																	SELF.vesselLengthInches := boat.vesselLengthInches;
																	SELF.vesselTotalLength := boat.vesselTotalLength;
																	SELF.titleState := IF(LEFT.titleState = DueDiligence.Constants.EMPTY, RIGHT.titleState, LEFT.titleState);
																	SELF.titleDate := IF(LEFT.titleDate = DueDiligence.Constants.EMPTY, RIGHT.titleDate, LEFT.titleDate); 
																	SELF.registrationState := IF(LEFT.registrationState = DueDiligence.Constants.EMPTY, RIGHT.registrationState, LEFT.registrationState);
																	SELF.registrationDate := IF(LEFT.registrationDate = DueDiligence.Constants.EMPTY, RIGHT.registrationDate, LEFT.registrationDate);
																	SELF.propulsion := IF(LEFT.propulsion = DueDiligence.Constants.Empty, RIGHT.propulsion, LEFT.propulsion);
																	SELF.vin := IF(LEFT.vin = DueDiligence.Constants.Empty, RIGHT.vin, LEFT.vin);
																	SELF := LEFT;));	

	Watercraft_unique := SORT(waterRoll, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()));
 
	Summary_BusWater := ROLLUP(Watercraft_unique,
											 LEFT.seq = RIGHT.seq AND
											 LEFT.ultid   = RIGHT.ultid AND
											 LEFT.orgid   = RIGHT.orgid AND
											 LEFT.seleid  = RIGHT.seleid,
											TRANSFORM(DueDiligence.LayoutsInternalReport.BusWatercraftSlimLayout,
											          SELF.watercraftCount    :=  LEFT.watercraftCount + RIGHT.watercraftCount;  
																SELF.vesselLengthInches  :=  MAX(LEFT.vesselLengthInches, RIGHT.vesselLengthInches),
																SELF                    :=  LEFT));  
																
											 
	// ------                                                                                    ------
  // ------ add the watercraft records to Busn_Internal layout.                                ------
	// ------                                                                                    ------
	Update_BusnWatercraft := JOIN(BusnData, Summary_BusWater,
												LEFT.seq = RIGHT.seq AND
												LEFT.Busn_info.BIP_IDS.UltID.LinkID  = RIGHT.ultID AND
												LEFT.Busn_info.BIP_IDS.OrgID.LinkID  = RIGHT.orgID AND
												LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.seleID,												
												TRANSFORM(DueDiligence.Layouts.Busn_Internal, 
																	SELF.WatercraftCount  := RIGHT.watercraftCount,
																	SELF.Watercraftlength := RIGHT.vesselTotalLength / 12,                //convert inches to feet. 
																	SELF := LEFT),
																	LEFT OUTER);

 

	addReport := IF(includeReportData, DueDiligence.reportBusWatercraft(Update_BusnWatercraft, Watercraft_unique), Update_BusnWatercraft);

 
	// ********************
	//   DEBUGGING OUTPUTS
	// *********************
  IF(DebugMode,     OUTPUT(CHOOSEN(WatercraftRaw_with_seq, 100),  NAMED('Sample_WatercraftRaw_Step1_All')));
	IF(DebugMode,     OUTPUT(COUNT(WatercraftRaw_with_seq),         NAMED('HowManyWatercraftStep1')));
	
	IF(DebugMode,     OUTPUT(CHOOSEN(WatercraftRecords, 100),       NAMED('Sample_WatercraftRaw_Step2_drop_records_outside_the_history_date')));
	IF(DebugMode,     OUTPUT(COUNT(WatercraftRecords),              NAMED('HowManyWatercraftStep2')));
	 
	IF(DebugMode,     OUTPUT(CHOOSEN(WatercraftSlim, 100),          NAMED('Sample_WatercraftSlim_Step3_get_details')));
	IF(DebugMode,     OUTPUT(COUNT(WatercraftSlim),                 NAMED('HowManyWatercraftStep3')));
	
	IF(DebugMode,     OUTPUT(CHOOSEN(Watercraft_unique, 100),       NAMED('Sample_WatercraftSlim_Step4_drop_duplicates')));
	IF(DebugMode,     OUTPUT(COUNT(Watercraft_unique),              NAMED('HowManyWatercraftStep4')));
	 
	IF(DebugMode,      OUTPUT(Summary_BusWater, NAMED('Summary_Watercraft')));                         
 
	// OUTPUT(BusnData, NAMED('BusnData'));
	// OUTPUT(WatercraftRaw_with_seq, NAMED('WatercraftRaw_with_seq'));
	// OUTPUT(WatercraftRecords, NAMED('WatercraftRecords'));
	// OUTPUT(waterSort, NAMED('waterSort'));
	// OUTPUT(waterDedup, NAMED('waterDedup'));													
	// OUTPUT(Watercraftslim, NAMED('Watercraftslim'));
	// OUTPUT(slimSort, NAMED('slimSort'));
	// OUTPUT(waterRoll, NAMED('waterRoll'));
	
	// OUTPUT(Watercraft_unique, NAMED('Watercraft_unique'));
	// OUTPUT(Summary_BusWater, NAMED('Summary_BusWater'));
	// OUTPUT(Update_BusnWatercraft, NAMED('Update_BusnWatercraft'));
	// OUTPUT(addReport, NAMED('addReport'));

	// OUTPUT(watercraftSlim, NAMED('watercraftSlim'));
	// OUTPUT(watercraftDetailsCleanDate, NAMED('watercraftDetailsCleanDate'));
 
	RETURN addReport;
END;