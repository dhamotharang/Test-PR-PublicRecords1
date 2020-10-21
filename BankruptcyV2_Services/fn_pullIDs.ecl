IMPORT ut,doxie,bankruptcyv3,suppress;

inrec := RECORDOF(bankruptcyv3.key_bankruptcyV3_search_full_bip());

EXPORT fn_pullIDs(DATASET(inrec) parties, BOOLEAN pull_indiv = FALSE, STRING32 appType) :=
FUNCTION

  //add a seq num
  rec := RECORD(inrec)
    UNSIGNED4 seq;
  END;

  ut.MAC_Sequence_Records_NewRec(parties, rec, seq, pseq)

  //strip out the restricted parties
  Suppress.MAC_pullIDs_tmsid(pseq,pseq3,TRUE,FALSE,appType,'BK')

  //see which ones we dropped
  dropped := JOIN(pseq, pseq3,
    LEFT.seq = RIGHT.seq,
    TRANSFORM(rec, SELF := LEFT),
    LEFT only);
          
  //if dropped, removing matching ids
  clean_tmsid := JOIN(pseq, dropped,
    LEFT.tmsid = RIGHT.tmsid,
    TRANSFORM(inrec, SELF := LEFT, SELF := []),
    LEFT only);
          
  clean_indv := JOIN(pseq, dropped,
    LEFT.seq = RIGHT.seq,
    TRANSFORM(inrec, SELF := LEFT, SELF := []),
    LEFT ONLY);

  RETURN IF(pull_indiv,clean_indv,clean_tmsid);
  
END;
