IMPORT BatchShare, UtilFile;

EXPORT Raw := MODULE

  EXPORT byDIDs(DATASET(UtilFile_Services.Layouts.batch_work) ds_work_recs,
    BatchShare.IParam.BatchParams in_mod,
    BOOLEAN isFCRA=FALSE) := FUNCTION

    // get util records by did
    ds_key_did:=JOIN(ds_work_recs,UtilFile.Key_Did,
      KEYED(LEFT.did=RIGHT.s_did) AND
      (isFCRA OR (in_mod.isValidGLB() AND NOT in_mod.isUtility())),
      TRANSFORM(UtilFile_Services.Layouts.utilRec,
        SELF.acctno:=LEFT.acctno,
        SELF.did:=LEFT.did,
        SELF:=RIGHT),
      LIMIT(UtilFile_Services.Constants.MAX_DID_RECS,SKIP));

    // get daily util records by did
    ds_daily_did:=JOIN(ds_work_recs,UtilFile.Key_Util_Daily_Did,
      KEYED(LEFT.did=RIGHT.s_did) AND
      (isFCRA OR (in_mod.isValidGLB() AND NOT in_mod.isUtility())),
      TRANSFORM(UtilFile_Services.Layouts.utilRec,
        SELF.acctno:=LEFT.acctno,
        SELF.did:=LEFT.did,
        SELF:=RIGHT),
      LIMIT(UtilFile_Services.Constants.MAX_DID_RECS,SKIP));

    RETURN ds_key_did+ds_daily_did;
  END;

END;
