EXPORT files := module

	EXPORT file_base := DATASET('~PRTE::BASE::gsa', Layouts.layout_Base, FLAT );

	EXPORT file_base_old := PROJECT(file_base, Layouts.Layout_Base_Old);

	EXPORT gsa_in := DATASET('~PRTE::IN::gsa', Layouts.layout_in, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')) );

	EXPORT File_Keybuild := PROJECT(file_base, Layouts.layout_Keybuild);

	EXPORT file_lnpid := dedup(sort(project(file_base,{unsigned8 gsa_id,unsigned8 lnpid}),lnpid,gsa_id),lnpid,gsa_id);

	EXPORT autokey_file := project(file_base,Layouts.layout_AutoKeys );

END;