IMPORT BIPV2, Business_Risk_BIP, FAA, MDR, Risk_Indicators, Riskwise, UT, Watercraft;

EXPORT getBusWatercraft(DATASET(DueDiligence.layouts.Busn_Internal) BusnData, 
											 Business_Risk_BIP.LIB_Business_Shell_LIBIN Options,
											 BIPV2.mod_sources.iParams linkingOptions,
											 BOOLEAN includeReportData,
											 boolean DebugMode = FALSE
											 ) := FUNCTION
										 
  // ------                                                                                    ------
  // ------ Watercraft Records                                                                 ------
	// ------                                                                                    ------
	WatercraftRaw := Watercraft.Key_LinkIds.kFetch2(DueDiligence.Common.GetLinkIDs(BusnData),
																						 Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
																							0,                                                                     /*ScoreThreshold --> 0 = Give me everything*/
																							linkingOptions,
																							Business_Risk_BIP.Constants.Limit_Default,
																							Options.KeepLargeBusinesses);
																							
  // ------                                                                                    ------	
	// ------ Add our sequence number to the Raw Watercraft records found for this Business      ------
	// ------                                                                                    ------
	WatercraftRaw_with_seq := DueDiligence.Common.AppendSeq(WatercraftRaw, BusnData, TRUE);
	
  // ------                                                                                    ------	
	// ------ When this query runs in ARCHIVE MODE the History date on the input contains a date ------
	// ------ Use this function drop public records that are out of scope for this transaction   ------
	// ------ If the History date is all 9's essentially no records will be dropped - also known ------
	// ------ as CURRENT MODE.                                                                   ------
	// ------                                                                                    ------
	WatercraftRecords := DueDiligence.Common.FilterRecords(WatercraftRaw_with_seq, date_first_seen, date_vendor_first_reported);
	
  // ------                                                                                    ------	
	// ------  Get the details about the watercraft from the NON_FCRA version of the watercraft_wid  --
  // ------                                                                                    ------
	Watercraftdetails := watercraft.key_watercraft_wid(false);	

	
	DueDiligence.LayoutsInternalReport.BusWatercraftSlimLayout  getWCDetails(WatercraftRecords le, Watercraftdetails ri) := TRANSFORM
	   SELF.watercraftKey := le.watercraft_key;
	   SELF.sequenceKey := le.sequence_key;
		 SELF.stateOrigin := le.state_origin; 
		 SELF.seq := le.seq;
	   SELF.ultid := le.ultid;
	   SELF.orgid := le.orgid;
	   SELF.seleid := le.seleid;

	   SELF.watercraftCount := 1;
		 SELF.year := ri.model_year;
		 SELF.model := ri.watercraft_model_description;
		 SELF.make := ri.watercraft_make_description;
		 SELF.vesselType := ri.vehicle_type_description;
		 SELF.propulsion := ri.propulsion_description;   

		 vesselLength := (UNSIGNED2)ri.watercraft_length; 
     SELF.vesselTotalLength := vesselLength;
		 SELF.vesselLengthFeet := vesselLength DIV 12;
		 SELF.vesselLengthInches := vesselLength % 12;
																	
		 SELF.vin := ri.registration_number;
		 SELF.titleState := ri.title_state;
		 SELF.titleDate := ri.title_issue_date;
		 SELF.registrationState := ri.st_registration;
		 SELF.registrationDate := ri.registration_date;
		 
		 SELF := ri;
	   
	   SELF := [];
   END;


  Watercraftslim :=  join(WatercraftRecords, Watercraftdetails,
												       right.watercraft_key      = left.watercraft_key and
												       right.state_origin        = left.state_origin   and     
												       right.sequence_key        = left.sequence_key,		 
												 getWCDetails(left,right), 
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
																	SELF.titleState := IF(LEFT.titleState = DueDiligence.Constants.Empty, RIGHT.titleState, LEFT.titleState);
																	SELF.titleDate := IF(LEFT.titleDate = DueDiligence.Constants.Empty, RIGHT.titleDate, LEFT.titleDate);
																	SELF.registrationState := IF(LEFT.registrationState = DueDiligence.Constants.Empty, RIGHT.registrationState, LEFT.registrationState);
																	SELF.registrationDate := IF(LEFT.registrationDate = DueDiligence.Constants.Empty, RIGHT.registrationDate, LEFT.registrationDate);
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
																	SELF.Watercraftlength := RIGHT.vesselLengthInches / 12,                //convert inches to feet. 
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
 
	RETURN addReport;
END;