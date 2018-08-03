IMPORT BIPV2, Business_Risk_BIP, DueDiligence, STD, Watercraft;

EXPORT getBusWatercraft(DATASET(DueDiligence.layouts.Busn_Internal) BusnData, 
											 Business_Risk_BIP.LIB_Business_Shell_LIBIN Options,
											 BIPV2.mod_sources.iParams linkingOptions) := FUNCTION
										 

	watercraftRaw := Watercraft.Key_LinkIds.kFetch2(DueDiligence.CommonBusiness.GetLinkIDs(BusnData),
                                                  Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
                                                  0,        //ScoreThreshold --> 0 = Give me everything
                                                  linkingOptions,
                                                  Business_Risk_BIP.Constants.Limit_Default,
                                                  Options.KeepLargeBusinesses);
																							

	//Add our sequence number to the Raw Watercraft records found for this Business
	watercraftRaw_with_seq := DueDiligence.CommonBusiness.AppendSeq(watercraftRaw, BusnData, TRUE);
  
  tempSlimWatercraft := PROJECT(watercraftRaw_with_seq, TRANSFORM({DueDiligence.LayoutsInternal.WatercraftSlimLayout, UNSIGNED4 dateFirstSeen},
                                                               SELF.watercraftKey := LEFT.watercraft_key;
                                                               SELF.sequenceKey := LEFT.sequence_key;
                                                               SELF.stateOrigin := LEFT.state_origin; 
                                                               
                                                               SELF.seq := LEFT.seq;
                                                               SELF.ultid := LEFT.ultid;
                                                               SELF.orgid := LEFT.orgid;
                                                               SELF.seleid := LEFT.seleid;
                                                               SELF.historyDate := LEFT.historyDate;
                                                               
                                                               SELF.dateFirstSeen := (UNSIGNED4)IF(LEFT.date_first_seen = DueDiligence.Constants.EMPTY, LEFT.date_vendor_first_reported, LEFT.date_first_seen);
                                                               SELF := [];));
	
	//Clean dates used in logic and/or attribute levels here so all comparisions flow through consistently
	watercraftCleanDates := DueDiligence.Common.CleanDatasetDateFields(tempSlimWatercraft, 'dateFirstSeen');
	
  //Filter records based on when we first seen the data
	filteredWatercraft := DueDiligence.Common.FilterRecordsSingleDate(watercraftCleanDates, dateFirstSeen);
  
  slimWatercraft := PROJECT(filteredWatercraft, TRANSFORM(DueDiligence.LayoutsInternal.WatercraftSlimLayout, SELF := LEFT;));
  
  //Get the details about the watercraft
  watercraftDetails := DueDiligence.getSharedWatercraft(slimWatercraft);  
  
  addWaterCraft := JOIN(BusnData, watercraftDetails,
                        #EXPAND(DueDiligence.Constants.mac_JOINLinkids_BusInternal()),												
                        TRANSFORM(DueDiligence.Layouts.Busn_Internal, 
                                  SELF.watercraftCount := RIGHT.totalWatercraft;
                                  SELF.watercraftLength := RIGHT.maxWatercraftLength;
                                  SELF.busWatercraft := RIGHT.allwatercraft;
                                  SELF := LEFT),
                        LEFT OUTER);
  
  

 
	//********************
	// DEBUGGING OUTPUTS
	//*********************
	// OUTPUT(WatercraftRaw_with_seq, NAMED('WatercraftRaw_with_seq'));
	// OUTPUT(tempSlimWatercraft, NAMED('tempSlimWatercraft'));
	// OUTPUT(watercraftCleanDates, NAMED('watercraftCleanDates'));
	// OUTPUT(filteredWatercraft, NAMED('filteredWatercraft'));
	// OUTPUT(slimWatercraft, NAMED('slimWatercraft'));
	// OUTPUT(watercraftDetails, NAMED('watercraftDetails'));
	// OUTPUT(addWaterCraft, NAMED('addWaterCraft'));
  

 
	RETURN addWaterCraft;
END;