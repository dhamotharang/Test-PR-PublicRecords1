lKYFullBaseName := (Drivers.Cluster + 'in::drvlic_KY_full_');

export File_KY_Full
 :=	dataset(lKYFullBaseName + '20041222',Drivers.Layout_KY_Full,flat)
 ;