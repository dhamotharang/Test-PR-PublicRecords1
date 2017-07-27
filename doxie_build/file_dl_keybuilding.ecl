import drivers,doxie_files;

rec :=
RECORD
	doxie_files.Layout_Drivers;
END;

export file_dl_keybuilding := dataset('~thor_data400::base::DLSearch_' +  doxie_build.buildstate + '_BUILDING', rec, flat);