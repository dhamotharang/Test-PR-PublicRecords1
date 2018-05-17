IMPORT PRTE2_WaterCraft_Ins,PRTE2_Common;

EXPORT Files := MODULE
	SHARED Add_Foreign_prod 	:= PRTE2_Common.Constants.Add_Foreign_prod;

	MainFiles := PRTE2_WaterCraft_Ins.Files;
	
	EXPORT Spray_Prefix		:= MainFiles.Spray_Prefix;
	EXPORT dataprep_Prefix	:= '~prte::dataprep::prct::WaterCraft';
	SHARED Colon := '::';
	EXPORT NewCraftRawSuffix := 'new_craft_raw_data';
	EXPORT ProdBaseMainCopy := 'craft_gather_from_main';

	EXPORT SprayCraftRawName	:= Spray_Prefix+colon+NewCraftRawSuffix+'_'+Workunit;
	EXPORT SprayCraftRawDS	:= DATASET(SprayCraftRawName,Layouts.NewRawLayout,
	                                   CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n','\r\n']), QUOTE('"')));	


	EXPORT NewCraftRawName	:= dataprep_Prefix+colon+NewCraftRawSuffix;
	EXPORT NewCraftRawDS		:= DATASET(NewCraftRawName,Layouts.NewRawLayout,THOR);

	EXPORT LIVEProdMainName	:= Add_Foreign_prod('thor_data400::base::watercraft_main');
	EXPORT LIVEProdMainReadOnly := DATASET(LIVEProdMainName,Layouts.ProdBaseMainLayout,THOR);

	EXPORT ProdGatherMainName	:= dataprep_Prefix+colon+ProdBaseMainCopy;
	EXPORT ProdGatherMainDS		:= DATASET(ProdGatherMainName,Layouts.GatheredBaseMainLayout,THOR);

END;