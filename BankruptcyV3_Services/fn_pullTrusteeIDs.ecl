IMPORT ut,doxie,bankruptcyv3,suppress, bankruptcyv3_services;

inrec := {RECORDOF(bankruptcyv3.key_bankruptcyv3_main_full()),BOOLEAN isDeepDive,
  BOOLEAN SuppressT};

EXPORT fn_pullTrusteeIds(DATASET(inrec) full_layout, STRING32 appType) := 
FUNCTION

  //add a seq num
  rec := RECORD(inrec)
    UNSIGNED4 seq;
  END;
  ut.MAC_Sequence_Records_NewRec(full_layout, rec, seq, pseqP)

  //strip out the restricted trusties
  // pull for did, app_ssn, tmsid (based on the 2 booleans in this call to Mac_PullIDs_tmsid.
  // true = use the 'app_ssn' pull
  // false = do NOT use the 'ssn' pull
  Suppress.MAC_pullIDs_tmsid(pseqP, pseq3P,TRUE,FALSE,appType,'BK')

  // add in suppress boolean
  setSuppressed := JOIN(pseqP, pseq3P,
    LEFT.seq = RIGHT.seq,
    TRANSFORM(inrec,
      SELF.suppressT := IF (RIGHT.seq = 0, TRUE, FALSE);
      SELF := LEFT), 
    LEFT OUTER);
                      
  // output(setSuppressed, named('setSuppressedV3TRUST'));
  RETURN setSuppressed;
  
END;
