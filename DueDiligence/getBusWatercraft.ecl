IMPORT BIPV2, Business_Risk_BIP, FAA, MDR, Risk_Indicators, Riskwise, UT, Watercraft;

EXPORT getBusWatercraft(DATASET(DueDiligence.layouts.Busn_Internal) BusnData, 
											 Business_Risk_BIP.LIB_Business_Shell_LIBIN Options,
											 BIPV2.mod_sources.iParams linkingOptions,
											 boolean DebugMode = FALSE
											 ) := FUNCTION
 //----------------- Watercraft tmp layouts --------------
 watercraft_slim_layout := RECORD
   unsigned6 ultid;
	 unsigned6 orgid;
   unsigned6 seleid;
	 string30  sl_companyName;   
   string30  watercraft_key;
	 string2   state_origin;
   string30  sequence_key;
	 unsigned4 historydate;
	 string15  history_flag;
	 unsigned4 sl_watercraftCount  := 0;
	 unsigned2 sl_watercraft_length;                   //in inches
	 string30  sl_watercraft_model_description; 
 END;											 
											 
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
	DueDiligence.Common.AppendSeq(WatercraftRaw, BusnData, WatercraftRaw_with_seq);
	
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
	
	watercraft_slim_layout  getWCDetails(WatercraftRecords le, Watercraftdetails ri) := TRANSFORM
	   SELF.watercraft_key         := le.watercraft_key;
	   self.sequence_key           := le.sequence_key;
	   self.ultid                  := le.ultid;
	   self.orgid                  := le.orgid;
	   self.seleid                 := le.seleid;
	   self.sl_companyName         := le.orig_name; 
	   self.history_flag           := ri.history_flag;
	   self.sl_watercraftCount     := 1;
	   self.state_origin           := le.state_origin; 
     self.sl_watercraft_length   := (unsigned2)ri.watercraft_length; 
	   self.sl_watercraft_model_description := ri.watercraft_model_description;
	   self := [];
   END;


  Watercraftslim :=  join(WatercraftRecords, watercraft.key_watercraft_wid(false),
												       right.watercraft_key      = left.watercraft_key and
												       right.state_origin        = left.state_origin   and     
												       right.sequence_key        = left.sequence_key,		 
												 getWCDetails(left,right), 
												 atmost(right.watercraft_key     = left.watercraft_key and 
												        right.state_origin       = left.state_origin   and 
																right.sequence_key       = left.sequence_key,
												        riskwise.max_atmost));
																
	Watercraft_unique :=  dedup(sort(Watercraftslim, ultid, orgid, seleid, watercraft_key),
	                                                  ultid, orgid, seleid, watercraft_key);  
	 
	Summary_BusWater := rollup(Watercraft_unique,
											 LEFT.ultid   = RIGHT.ultid AND
											 LEFT.orgid   = RIGHT.orgid AND
											 LEFT.seleid  = RIGHT.seleid,			
											TRANSFORM(watercraft_slim_layout,
											          SELF.sl_watercraftCount    :=  LEFT.sl_watercraftCount + 1;  
																SELF.sl_watercraft_length  :=  IF(LEFT.sl_watercraft_length >= RIGHT.sl_watercraft_length, LEFT.sl_watercraft_length, RIGHT.sl_watercraft_length),
																SELF                    :=  LEFT));   
																
											 
	// ------                                                                                    ------
  // ------ add the watercraft records to Busn_Internal layout.                                ------
	// ------                                                                                    ------
	Update_BusnWatercraft := JOIN(BusnData, Summary_BusWater,
												//LEFT.seq = RIGHT.seq AND
												LEFT.Busn_info.BIP_IDS.UltID.LinkID  = RIGHT.ultID AND
												LEFT.Busn_info.BIP_IDS.OrgID.LinkID  = RIGHT.orgID AND
												LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.seleID,												
												TRANSFORM(DueDiligence.Layouts.Busn_Internal, 
																	SELF.WatercraftCount  := RIGHT.sl_watercraftCount,
																	SELF.Watercraftlength := RIGHT.sl_watercraft_length / 12,                //convert inches to feet. 
																	SELF := LEFT),
																	LEFT OUTER);
 	 
	 
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
   
	RETURN Update_BusnWatercraft;
END;