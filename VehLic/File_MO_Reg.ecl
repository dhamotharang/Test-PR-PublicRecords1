// Now using SuperFiles
export File_MO_Reg
 :=	dataset(VehLic.File_In_Cluster + 'in::vehreg_mo_reg_full',	VehLic.Layout_MO_Reg,flat)
 +	dataset(VehLic.File_In_Cluster + 'in::vehreg_mo_reg_update',VehLic.Layout_MO_Reg,flat)
 ;