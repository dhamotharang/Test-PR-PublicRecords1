party_raw := uccv2_services.layout_ucc_party_raw;
party_parsed := uccv2_services.layout_ucc_party_parsed_src;
party_address := uccv2_services.layout_ucc_party_address_src;

EXPORT layout_ucc_party_src := RECORD
  party_raw.orig_name;
  DATASET(party_parsed) parsed_parties{MAXCOUNT(25)};
  DATASET(party_address) addresses{MAXCOUNT(25)};
END;
