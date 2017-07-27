dMoxieFile := Watercraft.File_Base_Main_Dev;

rStatRecord
 :=
  record
	dMoxieFile.source_code;
	dMoxieFile.state_origin;
	Total 		:= count(group);
  end
 ;

dStatsTable 	:= table(dMoxieFile,rStatRecord,Source_Code,State_Origin,few);
dStatsSorted	:= sort(dStatsTable,Source_Code,State_Origin);

export Out_Main_Base_Dev_Stats := output(dStatsSorted,all,named('Main_Statistics'));
