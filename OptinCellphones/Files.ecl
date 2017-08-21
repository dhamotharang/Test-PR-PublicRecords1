import ut;
export files := module

	export File_in := dataset(/*ut.foreign_prod+*/Superfile_List.source_file,Layouts.Layout_in,CSV(MAXLENGTH(7740), QUOTE('"')));
	export File_in2 := dataset(/*ut.foreign_prod+*/Superfile_List.source_file2,Layouts.Layout_in2,THOR);
	export File_Name_Cache := dataset(Superfile_List.Cache_Name_File,Layouts.Layout_Clean_Cache,THOR);
	export File_Base := dataset(Superfile_List.base_file,Layouts.Layout_out,THOR);

END;