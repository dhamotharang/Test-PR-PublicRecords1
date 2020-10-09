IMPORT BIPV2_Best, Business_Risk_BIP, DueDiligence;


EXPORT getIndustryBest(DATASET(DueDiligence.v3Layouts.Internal.BusinessTemp) inData,
                       DueDiligence.DDInterface.iDDRegulatoryCompliance regulatoryAccess) := FUNCTION



    options := DueDiligence.v3Common.DDBusiness.GetBusinessShellOptions(regulatoryAccess);


    //retrieve the additional best data
    bestDataRaw := BIPV2_Best.Key_LinkIds.kFetch2(DueDiligence.v3Common.DDBusiness.GetKfetch2LinkIDs(inData),
                                                   Business_Risk_BIP.Common.SetLinkSearchLevel(options.LinkSearchLevel),,,,
                                                   DueDiligence.Constants.MAX_10000)(proxid = 0);


    addBestIndustryCodes := JOIN(inData, bestDataRaw,
                                  LEFT.seq = RIGHT.uniqueID AND
                                  LEFT.inquiredBusiness.ultID = RIGHT.ultID AND
                                  LEFT.inquiredBusiness.orgID = RIGHT.orgID AND
                                  LEFT.inquiredBusiness.seleID = RIGHT.seleID,
                                  TRANSFORM(DueDiligence.v3Layouts.Internal.BusinessTemp,
                                            SELF.bestData.sicCode := RIGHT.sic_code[1].company_sic_code1;
                                            SELF.bestData.naicsCode := RIGHT.naics_code[1].company_naics_code1;
                                            SELF := LEFT;),
                                  LEFT OUTER,
                                  ATMOST(1));



    // OUTPUT(bestDataRaw, NAMED('bestDataRaw'));
    // OUTPUT(addBestIndustryCodes, NAMED('addBestIndustryCodes'));

    RETURN addBestIndustryCodes;
END;