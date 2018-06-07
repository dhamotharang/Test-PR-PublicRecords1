IMPORT doxie, FFD;

EXPORT fn_identify_consumer (DATASET(LiensV2_Services.layout_lien_rollup) out_recs, STRING rdid):= FUNCTION

  first_party_dids := PROJECT(out_recs, 
                          TRANSFORM(doxie.layout_references, 
                                    first_party := NORMALIZE(left.debtors, LEFT.parsed_parties,
                                                                                TRANSFORM(RIGHT))[1];
                                    self.did := (UNSIGNED)first_party.did) )(did>0);

  dsDIDs := IF(EXISTS(first_party_dids), first_party_dids,  DATASET([{(UNSIGNED) rdid}], doxie.layout_references));

  matched_party_lexid := dsDIDs[1].did;
  // in case if results contain data for more than one matched LexId and no resolved LexId based on input there will be no Consumer data populated
  search_lexId := IF(matched_party_lexid > 0 AND ~EXISTS(dsDIDs(did <> matched_party_lexid)), matched_party_lexid, 0);
                        
  consumer := FFD.MAC.PrepareConsumerRecord(search_lexId, FALSE);

  RETURN consumer;
END;