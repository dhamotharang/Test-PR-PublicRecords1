IMPORT PRTE2_WaterCraft_Ins, PRTE2_WaterCraft_Ins.Utilities;

DS1 := PRTE2_WaterCraft_Ins.Utilities.Files.ProdGatherMainDS;
DS1;
DataIn := DS1;
OUTPUT(COUNT(dataIn));

report0 := RECORD
	recTypeSrc	 := DataIn.st_registration;
	GroupCount := COUNT(GROUP);
END;

RepTable0 := TABLE(DataIn,report0,st_registration);
OUTPUT(SORT(RepTable0,recTypeSrc));

OUTPUT(COUNT(DS1(hull_number='')));
// OUTPUT(DS1(state_origin='UT'));
// OUTPUT(DS1(st_registration='CA'));
// OUTPUT(DS1(st_registration='RI'));
// OUTPUT(DS1(st_registration='PA'));
// OUTPUT(DS1(st_registration='OK'));
// OUTPUT(DS1(st_registration=''));