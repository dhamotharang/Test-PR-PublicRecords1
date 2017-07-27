import GlobalWatchLists;

export Layout_Base_Results :=
MODULE

shared p := GlobalWatchLists.Layout_GlobalWatchLists;

export Layout_keys := RECORD
	real score;
	p.pty_key;
	p.first_name;
	p.last_name;
	p.cname;
	p.country;
	Layout_batch_in.search_type;
END;

export SearchResultRecordGeneric := record
	unsigned4 key;
	real8 score;
end;

export parent := RECORD
	Layout_batch_in;
	STRING20 pty_key;
	STRING1 record_type := '';
	DATASET(SearchResultRecordGeneric) keys {MAXCOUNT(500)};
	DATASET(Layout_keys) pty_keys {MAXCOUNT(500)};
END;

END;