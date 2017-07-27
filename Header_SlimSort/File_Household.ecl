boolean var1 := true : stored('production');
EXPORT File_Household := DATASET(
	'~thor_data400::base::HSS_Household' + if(var1,'_Prod',''),
	header_slimsort.layout_household,
	flat);