IMPORT DueDiligence, iesp;


EXPORT getInputBest(DATASET(DueDiligence.v3Layouts.DDInput.BusinessSearch) rawInput,
                    DATASET(DueDiligence.v3Layouts.Internal.BusinessTemp) inData,
                    DATASET(DueDiligence.v3Layouts.InternalBusiness.BusinessResults) busReport) := FUNCTION



    addInput := JOIN(rawInput, busReport,
                     LEFT.seq = RIGHT.seq,
                     TRANSFORM(DueDiligence.v3Layouts.InternalBusiness.BusinessResults,
                     
                                addr := iesp.ECL2ESP.SetAddress(LEFT.rawData.prim_name, LEFT.rawData.prim_range, LEFT.rawData.predir,
                                                                LEFT.rawData.postdir, LEFT.rawData.addr_suffix, LEFT.rawData.unit_desig,
                                                                LEFT.rawData.sec_range, LEFT.rawData.city, LEFT.rawData.state, LEFT.rawData.zip,
                                                                LEFT.rawData.zip4, LEFT.rawData.county, DueDiligence.Constants.EMPTY, LEFT.rawData.streetAddress1);
                               
                                inputEcho := DATASET([TRANSFORM(iesp.duediligenceshared.t_DDRAttributesBusiness,
                                                                SELF.lexID := (STRING)LEFT.rawData.seleID;
                                                                SELF.phone := LEFT.rawData.phone;
                                                                SELF.companyName := LEFT.rawData.companyName;
                                                                SELF.fein := LEFT.rawData.fein;
                                                                SELF.address := addr;
                                                                SELF := [];)])[1];

                               SELF.report.inputEcho.business := inputEcho;
                               SELF.report.businessReport.businessInformation.inputAddress := addr;
                               SELF.report.businessReport.businessInformation.inputFEIN := LEFT.rawData.fein;
                               
                               SELF := RIGHT;),
                     RIGHT OUTER);
                     
                     
    addBest := JOIN(inData, addInput,
                    LEFT.seq = RIGHT.seq,
                    TRANSFORM(DueDiligence.v3Layouts.InternalBusiness.BusinessResults,
                              
                              addr := iesp.ECL2ESP.SetAddress(LEFT.bestData.prim_name, LEFT.bestData.prim_range, LEFT.bestData.predir,
                                                                LEFT.bestData.postdir, LEFT.bestData.addr_suffix, LEFT.bestData.unit_desig,
                                                                LEFT.bestData.sec_range, LEFT.bestData.city, LEFT.bestData.state, LEFT.bestData.zip,
                                                                LEFT.bestData.zip4, LEFT.bestData.county, DueDiligence.Constants.EMPTY, LEFT.bestData.streetAddress1);
                                                                
                                                                
                              SELF.report.businessReport.businessInformation.bestAddress := addr;
                              SELF.report.businessReport.businessInformation.name := LEFT.bestData.companyName;
                              SELF.report.businessReport.businessInformation.phone := LEFT.bestData.phone;
                              SELF.report.businessReport.businessInformation.lexID := (STRING)LEFT.inquiredBusiness.seleID;
                              SELF.report.businessReport.businessInformation.bestFEIN := LEFT.bestData.fein;
                              
                              SELF.report.businessID := (STRING)LEFT.inquiredBusiness.seleID;
                              SELF.report.businessLexIDMatch := LEFT.lexIDScore;
                                                            
                              SELF := RIGHT;),
                    RIGHT OUTER);
                    

     
     
     
    // OUTPUT(addInput, NAMED('addInput'));
    // OUTPUT(addBest, NAMED('addBest'));
    // OUTPUT(normBEOs, NAMED('normBEOs'));
    // OUTPUT(rollBEOs, NAMED('rollBEOs'));
    // OUTPUT(addTempBEOs, NAMED('addTempBEOs'));

    RETURN addBest;
END;