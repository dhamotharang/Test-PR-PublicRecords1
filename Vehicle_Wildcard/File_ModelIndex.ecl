import doxie_build, doxie_files, doxie;

export File_ModelIndex :=
dataset('~thor_data400::WC_Vehicle::ModelBase_' + doxie_build.buildstate, 
		{Layout_ModelIndex, unsigned8 __filepos { virtual(fileposition)}}, THOR);