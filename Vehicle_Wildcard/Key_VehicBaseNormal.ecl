import minibuild;

export Key_VehicBaseNormal := index(File_VehicBaseNormal, 
									{Layout_BaseFile, __filepos}, 
									'~thor_data400::key::veh_normalized_' + minibuild.buildstate  + Matrix_Wildcard.WC_version);