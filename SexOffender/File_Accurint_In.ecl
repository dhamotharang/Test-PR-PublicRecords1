import doxie_build; 

so_main_new_rec := record
	layout_accurint_mainfile;
	string2 eol_chars;
end;

export File_Accurint_In := dataset('~thor_data400::in::so_accurint' + doxie_build.buildstate,
                                   so_main_new_rec,flat);