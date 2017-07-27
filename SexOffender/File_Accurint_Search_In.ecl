import doxie_build;

so_search_new_rec := record
	layout_Accurint_SearchFile;
	string2 eol_chars;
end;

export File_Accurint_Search_In := dataset('~thor_data400::in::so_accurint_search' + doxie_build.buildstate,
                                          so_search_new_rec,flat);