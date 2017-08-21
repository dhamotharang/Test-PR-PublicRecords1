Layout_In := record
	string lien_desc;
end;

export File_Lien_Type_Lookup := dataset('~thor_400::lookup::marketing_best_lien_type_table',Layout_In,
															csv(heading(0),
															separator(''),
															quote('"')));