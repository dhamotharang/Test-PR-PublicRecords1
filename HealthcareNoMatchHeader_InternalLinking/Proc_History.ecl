IMPORT  STD, HealthcareNoMatchHeader_Ingest;
EXPORT  Proc_History( 
    STRING	pSrc            = ''
    , STRING  pVersion      = (STRING)STD.Date.Today()
  ) :=  FUNCTION
                           
    dCRK        :=  HealthcareNoMatchHeader_Ingest.Files(pSrc).CRK;
    dCRKFather  :=  HealthcareNoMatchHeader_Ingest.Files(pSrc).CRK_Father;
    dHistoryOld :=  HealthcareNoMatchHeader_Ingest.Files(pSrc).History;
    pTimestamp  :=  (STRING)STD.Date.CurrentDate()+(STRING)STD.Date.CurrentTime(); 
    
    HealthcareNoMatchHeader_InternalLinking.Layout_History  tHistory(dCRK pNew, dCRKFather pOld)  :=  TRANSFORM
      SELF.rid              :=  pNew.rid;
      SELF.nomatchId_before :=  pOld.nomatch_id;
      SELF.nomatchId_after  :=  pNew.nomatch_id;
      SELF.lexid_before     :=  pOld.lexid;
      SELF.lexid_after      :=  pNew.lexid;
      SELF.crk_before       :=  pOld.crk;
      SELF.crk_after        :=  pNew.crk;
      SELF.change_timestamp :=  (UNSIGNED8)pTimestamp;
      SELF.event_id         :=  pVersion;
    END;
    
    dHistoryNew :=  JOIN(
                      DISTRIBUTE(dCRK,HASH(rid)),
                      DISTRIBUTE(dCRKFather,HASH(rid)),
                        LEFT.rid  = RIGHT.rid AND
                        (
                          LEFT.nomatch_id <>  RIGHT.nomatch_id OR
                          LEFT.lexid      <>  RIGHT.lexid OR
                          LEFT.crk        <>  RIGHT.crk
                        ),
                      tHistory(LEFT,RIGHT),
                      LOCAL
                    );
    
    RETURN  dHistoryNew + dHistoryOld;
END;
