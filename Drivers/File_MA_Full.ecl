lMAFullBaseName := (Drivers.Cluster + 'in::drvlic_ma_full_');

export File_MA_Full
 := dataset(lMAFullBaseName + '200309',drivers.Layout_MA_Full,flat)
 + dataset(lMAFullBaseName + '200310',drivers.Layout_MA_Full,flat)
 + dataset(lMAFullBaseName + '200311',drivers.Layout_MA_Full,flat)
 + dataset(lMAFullBaseName + '200312',drivers.Layout_MA_Full,flat)
 + dataset(lMAFullBaseName + '200401',drivers.Layout_MA_Full,flat)
 + dataset(lMAFullBaseName + '200403',drivers.Layout_MA_Full,flat)
 + dataset(lMAFullBaseName + '200404',drivers.Layout_MA_Full,flat)
 + dataset(lMAFullBaseName + '200405',drivers.Layout_MA_Full,flat)
 + dataset(lMAFullBaseName + '200406',drivers.Layout_MA_Full,flat)
 + dataset(lMAFullBaseName + '200408',drivers.Layout_MA_Full,flat)
 + dataset(lMAFullBaseName + '200409',drivers.Layout_MA_Full,flat)
 ;