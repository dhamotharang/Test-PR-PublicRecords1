// layout for search key with derived fields
export layout_teaser_search := record(layout_teaser)
		string20 pfname := '';
		string1 minit := '';
		string6 dph_lname := '';
		unsigned2 yob := 0;
end;
