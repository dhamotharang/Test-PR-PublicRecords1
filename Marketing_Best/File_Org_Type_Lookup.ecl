Layout_In := record
	string org_type_desc;
end;

export File_Org_Type_Lookup := dataset('~thor_400::lookup::marketing_best_corp_org_type table',Layout_In,
										csv(heading(0),
										separator(''),
										quote('"')));