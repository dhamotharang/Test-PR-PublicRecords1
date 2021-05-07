IMPORT DueDiligence, liensv2;


/*
	Following Keys being used:
			liensv2.key_liens_DID
*/
EXPORT getLienJundgementEviction(DATASET(DueDiligence.v3Layouts.InternalPerson.SlimPersonDetails) inData,
                                     DueDiligence.DDInterface.iDDRegulatoryCompliance regulatoryAccess) := FUNCTION


    indivLienKeys := JOIN(inData, liensv2.key_liens_DID,
                          KEYED(LEFT.inquiredDID = RIGHT.did),
                          TRANSFORM(DueDiligence.v3Layouts.InternalShared.LiensJudgementsEvictions,
                                    SELF.did := LEFT.inquiredDID;
                                    SELF.historyDate := LEFT.historyDate;
                                    SELF.rmsid := RIGHT.rmsid;
                                    SELF.tmsid := RIGHT.tmsid;
                                    SELF := [];),
                          KEEP(DueDiligence.Constants.MAX_500),
                          ATMOST(KEYED(LEFT.inquiredDID = RIGHT.did), DueDiligence.Constants.MAX_1000));



    civilEventDetails := DueDiligence.v3SharedData.getLiensJudgementsEvictions(indivLienKeys, regulatoryAccess);





    // OUTPUT(indivLienKeys, NAMED('indivLienKeys'));
    // OUTPUT(civilEventDetails, NAMED('civilEventDetails'));

    RETURN civilEventDetails;
END;
