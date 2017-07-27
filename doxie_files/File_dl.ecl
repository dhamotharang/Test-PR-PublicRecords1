import drivers,doxie_build;

rec :=
RECORD
	doxie_files.Layout_Drivers;
END;

export File_dl := dataset('~thor_data400::base::DLSearch_'+doxie_build.buildstate, rec, flat);