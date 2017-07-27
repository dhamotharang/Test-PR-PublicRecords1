import doxie_build, doxie_files, doxie;

export File_NameIndex := 
dataset('~thor_data400::WC_Vehicle::NameBase_' + doxie_build.buildstate, 
		{Layout_NameIndex, unsigned8 __filepos { virtual(fileposition)}}, THOR);