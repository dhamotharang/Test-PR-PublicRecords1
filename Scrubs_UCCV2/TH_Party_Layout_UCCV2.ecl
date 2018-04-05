IMPORT Scrubs_UCCV2, uccv2;

th_party_layout := RECORD, maxLength(32767)
  UCCV2.Layout_UCC_Common.Layout_Party_with_AID -[source_rec_id,
                                                  dotid,
                                                  dotscore,
                                                  dotweight,
                                                  empid,
                                                  empscore,
                                                  empweight,
                                                  powid,
                                                  powscore,
                                                  powweight,
                                                  proxid,
                                                  proxscore,
                                                  proxweight,
                                                  seleid,
                                                  selescore,
                                                  seleweight,
                                                  orgid,
                                                  orgscore,
                                                  orgweight,
                                                  ultid,
                                                  ultscore,
                                                  ultweight,
                                                  prep_addr_line1,
                                                  prep_addr_last_line,
                                                  rawaid,
                                                  aceaid,
                                                  persistent_record_id]
END;

EXPORT TH_Party_Layout_UCCV2 := th_party_layout;