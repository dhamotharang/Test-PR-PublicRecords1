import ffd;
party_raw := uccv2_services.layout_ucc_party_raw;
party_parsed := uccv2_services.layout_ucc_party_parsed;
party_address := uccv2_services.layout_ucc_party_address;

export layout_ucc_party := record
  party_raw.orig_name;
	dataset(party_parsed)  parsed_parties{maxcount(25)};
	dataset(party_address) addresses{maxcount(25)};
	FFD.Layouts.CommonRawRecordElements;
end;
