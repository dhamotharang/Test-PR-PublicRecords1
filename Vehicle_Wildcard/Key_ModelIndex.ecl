import doxie_build,  doxie,data_services;

export Key_ModelIndex :=
index(File_ModelIndex, Layout_KeyModelIndex, 
		data_services.data_location.prefix('Vehicle') + 'thor_data400::WC_Vehicle::KeyModelIndex_' + doxie_build.buildstate +'_'+ doxie.Version_SuperKey);