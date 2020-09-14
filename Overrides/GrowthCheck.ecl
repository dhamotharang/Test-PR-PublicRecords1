IMPORT lib_fileservices,data_services,STD;

	EXPORT GrowthCheck(STRING filedate, STRING in_datagroup, DATASET(overrides.File_Override_Orphans.orphan_rec) orphans_ds_new) := MODULE
		
	EXPORT Stats_Layout	:= RECORD
				string datagroup;
				string CurrVersion;
				string PrevVersion;
				string CurrCount;
				string PrevCount;
				string DelTaResults;
				string DelTaPassed;
	END;

	orphans_ds_old := SORT(TABLE(overrides.File_Override_Orphans.orphan_file, {datagroup,	 CountGroup	:= COUNT(GROUP)},datagroup, few),datagroup); 
	
	statsout_new := PROJECT(orphans_ds_new, TRANSFORM(Stats_Layout, 
																						SELF.datagroup := in_datagroup,		
																						SELF.CurrVersion := filedate, 
																						SELF.CurrCount := (STRING) COUNT(orphans_ds_new),
																						SELF := []));
																						
	sc := NOTHOR(fileservices.superfilecontents(data_services.foreign_prod + 'thor_data400::lookup::override::orphans'))[1].name;
								findex 	:= stringlib.stringfind(sc, '::', 3)+2;
								lindex 	:= stringlib.stringfind(sc, '::', 4)-1;
		
	father_filedate := sc[findex..lindex];
	
	stats_old_ds := orphans_ds_old(datagroup = in_datagroup);
	statsout_old := PROJECT(stats_old_ds, TRANSFORM(Stats_Layout, 
																						SELF.datagroup := in_datagroup,		
																						SELF.CurrVersion := father_filedate, 
																						SELF.PrevCount := (STRING) COUNT(stats_old_ds),
																						SELF := []));										 

	// get threshold for datagroup
	threshold_count := overrides.Constants.GetStatsThreshold(in_datagroup);

	//scale count and also take into account new orphans from new datagroup
	statsout_new tCalculateDelTaStats(statsout_new L ,statsout_old R) := TRANSFORM
                    SELF.DelTaResults := IF((UNSIGNED)R.PrevCount = 0, (STRING)((REAL)L.CurrCount/100),
										(STRING)((((REAL)L.CurrCount-(REAL)R.PrevCount)/(REAL)R.PrevCount)*100));
                    SELF.CurrVersion := L.CurrVersion;
                    SELF.PrevVersion := R.CurrVersion;
						 SELF.PrevCount := R.PrevCount;
                    SELF.DelTaPassed := IF(SELF.DelTaResults < threshold_count, 'Y', 'N');
                    SELF := L;
                end;
							
	
	NewDeltaStat := JOIN(statsout_new, statsout_old, LEFT.datagroup = RIGHT.datagroup, tCalculateDelTaStats(LEFT, RIGHT));
	
	output(newDeltaStat, named('delta_ds'));		
	
	StatsFile_Father := '~thor_data400::DeltaStats::OrphanFileStats::' + in_datagroup;
	StatsFile_Child := StatsFile_Father + '::' + WORKUNIT;
	
	Publish := OUTPUT(NewDeltaStat,, StatsFile_Child, THOR, COMPRESSED, OVERWRITE);
	
   output(threshold_count, named('before_father_file_create_3'));	
	
	boolean fileExists := std.File.SuperFileExists(StatsFile_Father);
	Create_StatsFile := IF(~fileExists, std.File.CreateSuperFile(StatsFile_Father));
	
	AddFile := SEQUENTIAL(STD.FILE.StartSuperFileTransaction(),
							STD.FILE.ClearSuperFile(StatsFile_Father),
                      STD.FILE.AddSuperFile(StatsFile_Father,  StatsFile_Child),
                  STD.File.FinishSuperFileTransaction());
	
	Create_Stats := SEQUENTIAL(Create_StatsFile, Publish, AddFile);	
	
	EXPORT BuildStats := Create_Stats;
	
	DeltaAlerts := EXISTS(DATASET( '~thor_data400::DeltaStats::OrphanFileStats::' + in_datagroup, Stats_Layout, thor)(DelTaPassed = 'N'));
   
	EXPORT StatsAlerts := DeltaAlerts;
		
END;
	
