import corrections;

export Layout_DOCSearch := record, maxlength(350000)
	corrections.layout_offender;
	dataset(doxie.Layout_AKA) akas;
	dataset(doxie.Layout_Offense_seq) doc_Offenses;
	dataset(doxie.layout_sub_court_offense) court_offenses;
	dataset(doxie.Layout_Parole) Paroles;
	dataset(doxie.Layout_PrisonTerm) PrisonTerms;
	dataset(doxie.Layout_SubActivity) Activities;
end;