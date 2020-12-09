IMPORT ut,doxie,suppress;

inrec := liensv2_services.layout_lien_party_raw;

EXPORT fn_pullIDs(GROUPED DATASET(inrec) parties, STRING32 appType) :=
FUNCTION

  outrec := liensv2_services.layout_rmsid;

  //add a seq num
  rec := RECORD
    inrec;
    UNSIGNED4 seq;
  END;

  ugparties := UNGROUP(parties);
  ut.MAC_Sequence_Records_NewRec(ugparties, rec, seq, pseq)

  //strip out the restricted parties
  Suppress.MAC_pullIDs_tmsid(GROUP(sorted(pseq, acctno), acctno), pseq3,FALSE,TRUE,appType,'LIENS')

  //see which ones we dropped
  dropped := JOIN(pseq, pseq3,
    LEFT.seq = RIGHT.seq,
    TRANSFORM(rec, SELF := LEFT),
    LEFT only);
          
  //if dropped, removing matching ids
  clean := JOIN(pseq, dropped,
    LEFT.tmsid = RIGHT.tmsid AND
    LEFT.rmsid = RIGHT.rmsid,
    TRANSFORM(outrec, SELF := LEFT),
    LEFT only);
          
  RETURN clean;
  
END;
