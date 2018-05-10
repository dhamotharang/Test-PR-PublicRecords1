IMPORT PRTE2_WaterCraft_Ins;

EXPORT Files := MODULE
	MainFiles := PRTE2_WaterCraft_Ins.Files;
	
	EXPORT Spray_Prefix		:= MainFiles.Spray_Prefix;
	EXPORT dataprep_Prefix	:= '~prte::dataprep::prct::WaterCraft';
	SHARED Colon := '::';
	EXPORT NewCraftRawSuffix := 'new_craft_raw_data';

	EXPORT SprayCraftRawName	:= Spray_Prefix+colon+NewCraftRawSuffix+'_'+Workunit;
	EXPORT SprayCraftRawDS	:= DATASET(SprayCraftRawName,Layouts.NewRawLayout,
	                                   CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n','\r\n']), QUOTE('"')));	


	EXPORT NewCraftRawName	:= dataprep_Prefix+colon+NewCraftRawSuffix;
	EXPORT NewCraftRawDS		:= DATASET(NewCraftRawName,Layouts.NewRawLayout,THOR);

END;