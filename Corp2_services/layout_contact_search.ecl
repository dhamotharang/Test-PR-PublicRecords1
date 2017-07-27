export layout_contact_search := record
	string12 did := '';	
	layout_search_parties;
	dataset(layout_search_title) title_description {maxcount(10)};
	dataset(layout_search_names) names {maxcount(10)};
	dataset(layout_search_addresses) addresses {maxcount(10)};
end;