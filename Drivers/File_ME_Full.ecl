lMEUpdateBaseName := (Drivers.Cluster + 'in::drvlic_me_update_');

export File_ME_Full
 := dataset(Drivers.cluster + 'in::drvlic_me_full_200306',drivers.Layout_ME_Full,flat)
 +	dataset(lMEUpdateBaseName + '200307',drivers.Layout_ME_Full,flat)
 +	dataset(lMEUpdateBaseName + '200308',drivers.Layout_ME_Full,flat)
 +	dataset(lMEUpdateBaseName + '200309',drivers.Layout_ME_Full,flat)
 +	dataset(lMEUpdateBaseName + '200310',drivers.Layout_ME_Full,flat)
 +	dataset(lMEUpdateBaseName + '200311',drivers.Layout_ME_Full,flat)
 +	dataset(lMEUpdateBaseName + '200312',drivers.Layout_ME_Full,flat)
 +	dataset(lMEUpdateBaseName + '200401',drivers.Layout_ME_Full,flat)
 +	dataset(lMEUpdateBaseName + '200402',drivers.Layout_ME_Full,flat)
 +	dataset(lMEUpdateBaseName + '200403',drivers.Layout_ME_Full,flat)
 +	dataset(lMEUpdateBaseName + '200404',drivers.Layout_ME_Full,flat)
 +	dataset(lMEUpdateBaseName + '200405',drivers.Layout_ME_Full,flat)
 +	dataset(lMEUpdateBaseName + '200406',drivers.Layout_ME_Full,flat)
 +	dataset(lMEUpdateBaseName + '200407',drivers.Layout_ME_Full,flat)
 +	dataset(lMEUpdateBaseName + '200408',drivers.Layout_ME_Full,flat)
 +	dataset(lMEUpdateBaseName + '200410',drivers.Layout_ME_Full,flat)
 +	dataset(lMEUpdateBaseName + '200411',drivers.Layout_ME_Full,flat)
 +	dataset(lMEUpdateBaseName + '200412',drivers.Layout_ME_Full,flat)
 +	dataset(lMEUpdateBaseName + '200501',drivers.Layout_ME_Full,flat)
 +	dataset(lMEUpdateBaseName + '200502',drivers.Layout_ME_Full,flat)
 +	dataset(lMEUpdateBaseName + '200503',drivers.Layout_ME_Full,flat)
 +	dataset(lMEUpdateBaseName + '200504',drivers.Layout_ME_Full,flat)
 +	dataset(lMEUpdateBaseName + '200505',drivers.Layout_ME_Full,flat)
 +	dataset(lMEUpdateBaseName + '200506',drivers.Layout_ME_Full,flat)
 +	dataset(lMEUpdateBaseName + '200507',drivers.Layout_ME_Full,flat)
 ;