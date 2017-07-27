// Now using SuperFiles
export File_WY_Ttl
 :=	dataset(VehLic.File_In_Cluster + 'in::vehreg_wy_ttl_full',	VehLic.Layout_WY_Ttl,flat)
 +	dataset(VehLic.File_In_Cluster + 'in::vehreg_wy_ttl_update',VehLic.Layout_WY_Ttl,flat)
 ;