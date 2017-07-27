party_raw := uccv2_services.layout_ucc_party_raw;
party_parsed := uccv2_services.layout_ucc_party_parsed_src;
party_address := uccv2_services.layout_ucc_party_address_src;

export layout_ucc_party_src := record
  party_raw.orig_name;
	dataset(party_parsed)  parsed_parties{maxcount(25)};
	dataset(party_address) addresses{maxcount(25)};
end;
