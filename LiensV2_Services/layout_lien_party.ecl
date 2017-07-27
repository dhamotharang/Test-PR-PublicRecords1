export layout_lien_party := record
  string120 orig_name;
	dataset(liensv2_services.layout_lien_party_parsed) parsed_parties{maxcount(10)};
	dataset(liensv2_services.layout_lien_party_address) addresses{maxcount(10)};
	unsigned8 persistent_record_id := 0;
end;