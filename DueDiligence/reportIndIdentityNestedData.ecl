IMPORT DueDiligence, iesp, STD, ut;


EXPORT reportIndIdentityNestedData(DATASET(DueDiligence.Layouts.Indv_Internal) inData) := FUNCTION


    //get the akas for an inquired
    normAKAs := NORMALIZE(inData, LEFT.akas, TRANSFORM(DueDiligence.LayoutsInternalReport.IdentityNestedData,
                                                       SELF.seq := LEFT.seq;
                                                       SELF.inquiredDID := LEFT.inquiredDID;
                                                       
                                                       espName := iesp.ECL2ESP.SetName(RIGHT.firstName, RIGHT.middleName, RIGHT.lastName, RIGHT.suffix, DueDiligence.Constants.EMPTY);
                                                       SELF.aka := RIGHT;
                                                       SELF.espAKAs := DATASET([TRANSFORM(iesp.share.t_Name, SELF := espName;)]);
                                                       
                                                       SELF.dob := 0;
                                                       SELF.espDOBAge := DATASET([], iesp.duediligencepersonreport.t_DDRPersonDOBAge);));
                                                       
                                                       
    //get the dobs for an inquired
    normDOBs := NORMALIZE(inData, LEFT.dobOnFile, TRANSFORM(DueDiligence.LayoutsInternalReport.IdentityNestedData,
                                                             SELF.seq := LEFT.seq;
                                                             SELF.inquiredDID := LEFT.inquiredDID;
                                                             
                                                             SELF.aka := DATASET([], DueDiligence.Layouts.Name)[1];
                                                             SELF.espAKAs := DATASET([], iesp.share.t_Name);
                                                             
                                                             SELF.dob := (UNSIGNED4)RIGHT.dob;

                                                             validDOB := DueDiligence.CommonDate.IsValidDate((UNSIGNED4)RIGHT.dob);
                                                             validHistDate := STD.Date.IsValidDate(LEFT.historyDate);
                                                             age := IF(validDOB AND validHistDate, ut.Age((UNSIGNED4)RIGHT.dob, LEFT.historyDate), 0);
                                                             
                                                             SELF.espDOBAge := DATASET([TRANSFORM(iesp.duediligencepersonreport.t_DDRPersonDOBAge,
                                                                                                  SELF.DOB := iesp.ECL2ESP.toDatestring8(RIGHT.dob);
                                                                                                  SELF.Age := age;)]);));
                                                                                                  
                                                                                                  
    allNormData := normAKAs + normDOBs;
    rollNorms := ROLLUP(SORT(allNormData, seq, inquiredDID, aka.lastName, aka.firstName, aka.middleName, aka.suffix, dob),
                        LEFT.seq = RIGHT.seq AND
                        LEFT.inquiredDID = RIGHT.inquiredDID,
                        TRANSFORM(DueDiligence.LayoutsInternalReport.IdentityNestedData,
                                  SELF.espAKAs := LEFT.espAKAs + RIGHT.espAKAs;
                                  SELF.espDOBAge := LEFT.espDOBAge + RIGHT.espDOBAge;
                                  SELF := LEFT;));
                                  
    limitData := PROJECT(rollNorms, TRANSFORM(DueDiligence.LayoutsInternalReport.IdentityNestedData,
                                              SELF.espAKAs := CHOOSEN(LEFT.espAKAs, iesp.constants.DDRAttributesConst.MaxReportedAKAs);
                                              SELF.espDOBAge := CHOOSEN(SORT(LEFT.espDOBAge, -dob), iesp.constants.DDRAttributesConst.MaxReportedDOBs);
                                              SELF := LEFT;));
                                                       
                                                       
                                                       
                                                       
    // OUTPUT(normAKAs, NAMED('normAKAs'));
    // OUTPUT(normDOBs, NAMED('normDOBs'));
    // OUTPUT(allNormData, NAMED('allNormData'));
    // OUTPUT(rollNorms, NAMED('rollNorms'));
    // OUTPUT(limitData, NAMED('limitData'));


    RETURN limitData;
END;