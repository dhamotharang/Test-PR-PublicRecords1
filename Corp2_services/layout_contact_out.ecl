export layout_contact_out := RECORD
	string12 did := '';	
	layout_parties;
	dataset(layout_names) names {maxcount(10)};
	dataset(layout_titles) title_descriptions {maxcount(10)};
	dataset(layout_addresses) addresses {maxcount(10)};
end;