IMPORT ut,doxie,suppress;

inrec := RECORDOF(uccv2_services.layout_ucc_party_raw);

EXPORT fn_pullIDs(DATASET(inrec) parties, STRING32 appType) :=
FUNCTION

outrec := UCCv2_services.layout_tmsid;

//add a seq num
rec := RECORD(inrec)
  UNSIGNED4 seq;
END;

ut.MAC_Sequence_Records_NewRec(parties, rec, seq, pseq)

//strip out the restricted parties
Suppress.MAC_pullIDs_tmsid(pseq, pseq3,FALSE,TRUE,appType,'UCC')

//see which ones we dropped
dropped := JOIN(pseq, pseq3,
        LEFT.seq = RIGHT.seq,
        TRANSFORM(rec, SELF := LEFT),
        LEFT only);
        
//if dropped, removing matching ids
clean := JOIN(pseq, dropped,
        LEFT.tmsid = RIGHT.tmsid,
        TRANSFORM(outrec, SELF := LEFT),
        LEFT only);
        
RETURN DEDUP (SORT (clean, TMSID), TMSID);
  
END;
