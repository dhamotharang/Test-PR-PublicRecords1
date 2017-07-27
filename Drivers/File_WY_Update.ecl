lWYUpdateBaseName := (Drivers.Cluster + 'in::drvlic_wy_update_');

export File_WY_Update
 :=	dataset(lWYUpdateBaseName + '20040713',Drivers.Layout_WY_Full,flat)
 +	dataset(lWYUpdateBaseName + '20040803',Drivers.Layout_WY_Full,flat)
 +	dataset(lWYUpdateBaseName + '20040930',Drivers.Layout_WY_Full,flat)
 +	dataset(lWYUpdateBaseName + '20041101',Drivers.Layout_WY_Full,flat)
 +	dataset(lWYUpdateBaseName + '20041201',Drivers.Layout_WY_Full,flat)
 +	dataset(lWYUpdateBaseName + '20050105',Drivers.Layout_WY_Full,flat)
 +	dataset(lWYUpdateBaseName + '20050208',Drivers.Layout_WY_Full,flat)
 +	dataset(lWYUpdateBaseName + '20050308',Drivers.Layout_WY_Full,flat)
 +	dataset(lWYUpdateBaseName + '20050408',Drivers.Layout_WY_Full,flat)
 +	dataset(lWYUpdateBaseName + '20050504',Drivers.Layout_WY_Full,flat)
 +	dataset(lWYUpdateBaseName + '20050607',Drivers.Layout_WY_Full,flat)
 +	dataset(lWYUpdateBaseName + '20050705',Drivers.Layout_WY_Full,flat)
 +	dataset(lWYUpdateBaseName + '20050824',Drivers.Layout_WY_Full,flat)
 ;