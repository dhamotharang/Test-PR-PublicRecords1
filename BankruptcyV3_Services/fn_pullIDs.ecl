IMPORT bankruptcyv3_services,suppress,ut;

inrec := bankruptcyv3_services.Layout_key_bankruptcyv3_search_full_bip_plus_case_numbers;

EXPORT fn_pullIDs(DATASET(inrec) parties, BOOLEAN pull_indiv = FALSE, STRING32 AppType) :=
FUNCTION

  outrec := bankruptcyv3_services.layouts.layout_tmsid_ext;

  //add a seq num
  rec := RECORD(inrec)
    UNSIGNED4 seq;
  END;

  ut.MAC_Sequence_Records_NewRec(parties, rec, seq, pseq)

  //strip out the restricted parties
  Suppress.MAC_pullIDs_tmsid(pseq, pseq3,TRUE, FALSE, AppType,'BK')

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
  clean_indiv := JOIN(pseq, dropped,
    LEFT.seq = RIGHT.seq,
    TRANSFORM(inrec, SELF := LEFT, SELF := []),
    LEFT only);

  // output(pseq, named('pseq'), EXTEND);
  // output(pseq3, named('pseq3'), EXTEND);
  // output(dropped, named('dropped'), EXTEND);
  // output(clean, named('clean'), EXTEND);
          
  RETURN IF(pull_indiv,clean_indiv,clean_tmsid);
  
END;
