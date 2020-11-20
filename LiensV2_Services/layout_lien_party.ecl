EXPORT layout_lien_party := RECORD
  STRING120 orig_name;
  DATASET(liensv2_services.layout_lien_party_parsed) parsed_parties{MAXCOUNT(10)};
  DATASET(liensv2_services.layout_lien_party_address) addresses{MAXCOUNT(10)};
  UNSIGNED8 persistent_record_id := 0;
END;
