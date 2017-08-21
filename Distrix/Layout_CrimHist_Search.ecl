import crim;

export Layout_CrimHist_Search := record, maxlength(200000)
	string8	process_date;
	Crim.Layout_Crim_Common;
	dataset(distrix.layout_appends_seq) appends;
	dataset(distrix.layout_arrests_seq) arrests;
	dataset(distrix.layout_identity_seq) identity;
	dataset(distrix.layout_events_seq) events;
	dataset(distrix.layout_judicials_seq) judicials;
end;
