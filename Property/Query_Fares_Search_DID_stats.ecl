// Query to create a crosstab with counts by State
// Fares_Search property file

#workunit('name','Property Search DID Stats');

// Project Deeds File  to Slim Records

h := DATASET(property.Filename_Fares_DID_Out, property.Layout_prop_out, THOR);

Layout_Slim := RECORD
	h.st;
	h.did;
END;

Fares_slim_search := table(h,Layout_Slim);

// Crosstab to count occurrences of each unique county code
Layout_DID_Stat := RECORD
	Fares_slim_search.st;
	reccnt := COUNT(GROUP);
END;


DID_Stat := TABLE(Fares_slim_search((integer)did>0), Layout_DID_Stat, st, FEW);
DID_Stat2 := TABLE(Fares_slim_search, Layout_DID_Stat, st, FEW);

table1 := DID_stat(reccnt>100);
table2 := DID_stat2(reccnt>100);


Layout_counts := RECORD
   string2 state;
   integer4 did_cnt;
   integer4 all_recs;
   integer4 pct;
end;
   

Layout_counts GetCounts(Layout_DID_Stat L, Layout_DID_Stat R) := TRANSFORM
	SELF.state := L.st;
	SELF.did_cnt := L.reccnt;
	SELF.all_recs := R.reccnt;
	SELF.pct := (L.reccnt*100)/R.reccnt;
END;

output_table := JOIN(table1,table2, LEFT.st = RIGHT.st, GetCounts(LEFT, RIGHT));

OUTPUT(CHOOSEN(output_table,ALL));
