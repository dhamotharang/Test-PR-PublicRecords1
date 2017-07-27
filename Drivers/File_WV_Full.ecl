lWVFullBaseName := (Drivers.cluster + 'in::drvlic_wv_full_');

export File_WV_Full
 := dataset(lWVFullBaseName + '200306',drivers.Layout_WV_Full,flat)
 +	dataset(lWVFullBaseName + '200309',drivers.Layout_WV_Full,flat)
 +	dataset(lWVFullBaseName + '200312',drivers.Layout_WV_Full,flat)
 +	dataset(lWVFullBaseName + '200404',drivers.Layout_WV_Full,flat)
 +	dataset(lWVFullBaseName + '200406',drivers.Layout_WV_Full,flat)
 +	dataset(lWVFullBaseName + '200410',drivers.Layout_WV_Full,flat)
 +	dataset(lWVFullBaseName + '200501',drivers.Layout_WV_Full,flat)
 +	dataset(lWVFullBaseName + '200504',drivers.Layout_WV_Full,flat)
 +	dataset(lWVFullBaseName + '200507',drivers.Layout_WV_Full,flat)
 ;