import corrections;

export Layout_DOCSearch_Raw := record, maxlength(350000)
	unsigned4	seq;
	corrections.layout_offender;
	dataset(doxie.Layout_AKA) akas;
	dataset(doxie.Layout_Offense_Seq) doc_offenses;
	dataset(Corrections.layout_CourtOffenses) Court_offenses;
	dataset(corrections.Layout_CrimPunishment) paroles;
	dataset(corrections.Layout_CrimPunishment) prisonTerms;
	dataset(corrections.Layout_Activity) activities;
end;