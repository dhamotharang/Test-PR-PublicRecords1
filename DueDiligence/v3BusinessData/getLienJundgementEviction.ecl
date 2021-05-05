IMPORT Business_Risk_BIP, DueDiligence, LiensV2;


/*
	Following Keys being used:
			LiensV2.Key_LinkIds.kFetch2
*/
EXPORT getLienJundgementEviction(DATASET(DueDiligence.v3Layouts.Internal.BusinessTemp) inData,
                                 DueDiligence.DDInterface.iDDRegulatoryCompliance regulatoryAccess) := FUNCTION


    options := DueDiligence.v3Common.DDBusiness.GetBusinessShellOptions(regulatoryAccess);


    businessLiensRaw := LiensV2.Key_LinkIds.kFetch2(DueDiligence.v3Common.DDBusiness.GetKfetch2LinkIDs(inData),
                                                    Business_Risk_BIP.Common.SetLinkSearchLevel(options.LinkSearchLevel),
                                                    0, /*ScoreThreshold --> 0 = Give me everything*/
                                                    Business_Risk_BIP.Constants.Limit_Default,
                                                    options.KeepLargeBusinesses);


    //add our sequence number to the Raw  records found for this Business
    businessLiensWithSeq := DueDiligence.v3Common.DDBusiness.AppendSeq(businessLiensRaw, inData, TRUE);


    //convert business data
    slimData := PROJECT(businessLiensWithSeq, TRANSFORM(DueDiligence.v3Layouts.InternalShared.LiensJudgementsEvictions,
                                                        SELF.ultID := LEFT.ultID;
                                                        SELF.orgID := LEFT.orgID;
                                                        SELF.seleID := LEFT.seleID;
                                                        SELF.historyDate := LEFT.historyDate;
                                                        SELF.rmsid := LEFT.rmsid;
                                                        SELF.tmsid := LEFT.tmsid;
                                                        SELF := [];));


    businessDetails := DueDiligence.v3SharedData.getLiensJudgementsEvictions(slimData, regulatoryAccess);





    // OUTPUT(businessLiensRaw, NAMED('businessLiensRaw'));
    // OUTPUT(businessLiensWithSeq, NAMED('businessLiensWithSeq'));
    // OUTPUT(slimData, NAMED('slimData'));
    // OUTPUT(businessDetails, NAMED('businessDetails'));


    RETURN businessDetails;
END;
