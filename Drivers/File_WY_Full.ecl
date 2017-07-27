lWYFullBaseName := (Drivers.cluster + 'in::drvlic_wy_full_');

export File_WY_Full
 :=	dataset(lWYFullBaseName + '20040920',Drivers.Layout_WY_Full,flat)
 ;