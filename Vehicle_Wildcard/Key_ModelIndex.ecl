Import Data_Services, doxie_build, doxie_files, doxie;

export Key_ModelIndex :=
index(File_ModelIndex, Layout_KeyModelIndex, 
		Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::WC_Vehicle::KeyModelIndex_' + doxie_build.buildstate +'_'+ doxie.Version_SuperKey);