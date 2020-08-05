IMPORT ffd;
party_raw := uccv2_services.layout_ucc_party_raw;
party_parsed := uccv2_services.layout_ucc_party_parsed;
party_address := uccv2_services.layout_ucc_party_address;

EXPORT layout_ucc_party := RECORD
  party_raw.orig_name;
  DATASET(party_parsed) parsed_parties{MAXCOUNT(25)};
  DATASET(party_address) addresses{MAXCOUNT(25)};
  FFD.Layouts.CommonRawRecordElements;
END;
