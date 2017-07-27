lIDBaseName := '~thor_data400::in::VehReg_ID_Full_';

export File_ID_Full
 := dataset(VehLic.File_In_Cluster + 'in::vehreg_id_full',VehLic.Layout_ID_Full,flat)
 ;