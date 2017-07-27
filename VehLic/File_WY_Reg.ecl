// Now using SuperFiles
export File_WY_Reg
 :=	dataset(VehLic.File_In_Cluster + 'in::vehreg_wy_reg_full',	VehLic.Layout_WY_Reg,flat)
 +	dataset(VehLic.File_In_Cluster + 'in::vehreg_wy_reg_update',VehLic.Layout_WY_Reg,flat)
 ;