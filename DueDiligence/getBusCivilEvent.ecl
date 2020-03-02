IMPORT Business_Risk_BIP, doxie, DueDiligence, LiensV2;

/*
	Following Keys being used:
			LiensV2.Key_LinkIds.kFetch2
*/

EXPORT getBusCivilEvent(DATASET(DueDiligence.layouts.Busn_Internal) inData,
                        Business_Risk_BIP.LIB_Business_Shell_LIBIN options,
                        doxie.IDataAccess mod_access) := FUNCTION



    businessLiensRaw := LiensV2.Key_LinkIds.kFetch2(DueDiligence.CommonBusiness.GetLinkIDs(inData),
                                                    Business_Risk_BIP.Common.SetLinkSearchLevel(options.LinkSearchLevel),
                                                    0, /*ScoreThreshold --> 0 = Give me everything*/
                                                    Business_Risk_BIP.Constants.Limit_Default,
                                                    options.KeepLargeBusinesses);
                                                    
                                                    
    //add our sequence number to the Raw  records found for this Business
    businessLiensWithSeq := DueDiligence.CommonBusiness.AppendSeq(businessLiensRaw, inData, TRUE);
  
  
    //convert business data
    slimData := PROJECT(businessLiensWithSeq, TRANSFORM(DueDiligence.LayoutsInternal.SharedSlimLiens,
                                                        SELF.seq := LEFT.seq;
                                                        SELF.ultID := LEFT.ultID;
                                                        SELF.orgID := LEFT.orgID;
                                                        SELF.seleID := LEFT.seleID;
                                                        SELF.historyDate := LEFT.historyDate;
                                                        SELF.rmsid := LEFT.rmsid;
                                                        SELF.tmsid := LEFT.tmsid;
                                                        SELF := [];));
                                                          

    businessDetails := DueDiligence.getSharedLiensJudgementsEvictions(slimData, mod_access);
    
    
    updateBusLiens := JOIN(inData, businessDetails,
                          #EXPAND(DueDiligence.Constants.mac_JOINLinkids_BusInternal()),												
                          TRANSFORM(DueDiligence.Layouts.Busn_Internal,
                                    
                                    SELF.liensUnreleasedCntInThePastNYR := RIGHT.totalUnreleasedLiensPast3Yrs;
                                    SELF.liensUnreleasedCntOVNYR := RIGHT.totalUnreleasedLiensOver3Yrs;
                                    SELF.evictionsCntInThePastNYR := RIGHT.totalEvictionsPast3Yrs;
                                    SELF.evictionsCntOVNYR := RIGHT.totalEvictionsOver3Yrs;
                                    
                                    SELF.busLJEDetails := RIGHT.lje;
                                    
                                    SELF := LEFT),
                          LEFT OUTER,
                          ATMOST(1));







    // OUTPUT(businessLiensRaw, NAMED('businessLiensRaw'));
    // OUTPUT(businessLiensWithSeq, NAMED('businessLiensWithSeq'));
    // OUTPUT(slimData, NAMED('slimData'));
    // OUTPUT(businessDetails, NAMED('businessDetails'));
    // OUTPUT(updateBusLiens, NAMED('updateBusLiens'));



    RETURN updateBusLiens;
END;