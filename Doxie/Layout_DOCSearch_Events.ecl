import corrections,doxie_build;


export Layout_DOCSearch_Events := record, maxlength(350000)
	unsigned4	seq := 0;
	string60	offender_key;
	string1	data_type;
	string25	case_type_desc;
	dataset(doxie.Layout_Offense_Seq) DOC_offenses;
	dataset(Corrections.layout_CourtOffenses) Court_offenses;
	dataset(corrections.Layout_CrimPunishment) paroles;
	dataset(corrections.Layout_CrimPunishment) prisonTerms;
	dataset(corrections.Layout_Activity) activities;
end;