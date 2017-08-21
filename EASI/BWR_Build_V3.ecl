SEQUENTIAL(
	Easi.Build_EASI_Base_v3,
	Easi.EASI_BuildKeys_V3
);

ds00 := EASI.Files09.File_data00;
ds10 := EASI.Files09.File_data10;
ds15 := EASI.Files09.File_data15;

OUTPUT(CHOOSEN(SORT(ds10,GEOLINK),1000),NAMED('DAT10'));
OUTPUT(CHOOSEN(EASI.Key_Easi_Current_Yr, 1000), named('KEY10'));

OUTPUT(CHOOSEN(SORT(ds00,GEOLINK),1000),NAMED('DAT00'));
OUTPUT(CHOOSEN(EASI.Key_Easi_Current_Census, 1000), named('KEY00'));

OUTPUT(CHOOSEN(SORT(ds15,GEOLINK),1000),NAMED('DAT15'));
OUTPUT(CHOOSEN(EASI.Key_Easi_five_yr_projection, 1000), named('KEY15'));


OUTPUT(COUNT(EASI.Key_Easi_Current_Yr), named('N10'));
OUTPUT(COUNT(EASI.Key_Easi_Current_Census), named('N00'));
OUTPUT(COUNT(EASI.Key_Easi_five_yr_projection), named('N15'));