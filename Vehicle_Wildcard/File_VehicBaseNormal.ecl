export File_VehicBaseNormal := 
dataset('~thor_data400::base::veh_normalized_' + matrix_wildcard.WC_version, 
	{Matrix_Wildcard.Layout_BaseFile, unsigned8 __filepos { virtual(fileposition)}}, THOR);