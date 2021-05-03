IMPORT lib_fileservices,data_services,STD;

EXPORT GrowthCheck(STRING in_datagroup) := MODULE
	SHARED Stats_Layout	:= RECORD
		STRING datagroup;
		STRING CurrVersion;
		STRING PrevVersion;
		STRING CurrCount;
		STRING PrevCount;
		STRING DelTaResults;
		STRING DelTaPassed;
	END;

	DeltaAlerts := EXISTS(DATASET( '~thor_data400::DeltaStats::OrphanFileStats::' + in_datagroup, Stats_Layout, thor)(DelTaPassed = 'N'));
	EXPORT StatsAlerts := DeltaAlerts;		

	EXPORT BuildStats(STRING filedate, DATASET(overrides.File_Override_Orphans.orphan_rec) orphans_ds_new) := 
	FUNCTION
		orphans_ds_old := SORT(TABLE(overrides.File_Override_Orphans.orphan_file, {datagroup,	 CountGroup	:= COUNT(GROUP)},datagroup, few),datagroup); 

		/*
			// TO TEST GROWTH CHECK
			//GONG 
			test_ds := DATASET([{Constants.GONG, '4137842', '1676950167', '1226426523'}, 
								{Constants.GONG, '4137843', '1676950168', '1226426524'}
							], Overrides.File_Override_Orphans.orphan_rec);

			orphans_ds_new_test := IF(COUNT(orphans_ds_new) < 1,  test_ds, orphans_ds_new); 
		*/
		
		statsout_raw := PROJECT(orphans_ds_new, TRANSFORM(Stats_Layout, 
													SELF.datagroup := in_datagroup,		
													SELF.CurrVersion := filedate, 
													SELF.CurrCount := (STRING) COUNT(orphans_ds_new),
													SELF := []));
																							
		statsout_new:= DEDUP(SORT(statsout_raw,currversion));																						

		sc := NOTHOR(fileservices.superfilecontents(data_services.foreign_prod + 'thor_data400::lookup::override::orphans'))[1].name;
		findex 	:= stringlib.stringfind(sc, '::', 3)+2;
		lindex 	:= stringlib.stringfind(sc, '::', 4)-1;	
		father_filedate := sc[findex..lindex];
		
		stats_old_ds := orphans_ds_old(datagroup = in_datagroup);
		statsout_old := IF (COUNT(stats_old_ds) > 0, PROJECT(stats_old_ds,	
														TRANSFORM(Stats_Layout,
															SELF.datagroup := in_datagroup,		
															SELF.PrevVersion := father_filedate,
															SELF.PrevCount := (STRING) LEFT.CountGroup,
															SELF := [])),
													DATASET([{in_datagroup, father_filedate, '', '0', '0', '', ''}], Stats_Layout));
			
		// get threshold for datagroup
		threshold_count := overrides.Constants.GetStatsThreshold(in_datagroup);
		
		//scale count and also take into account new orphans from new datagroup
		statsout_new tCalculateDelTaStats(statsout_new L ,statsout_old R) := TRANSFORM
			SELF.DelTaResults := L.CurrCount;
			SELF.CurrVersion := L.CurrVersion;
			SELF.PrevVersion := R.PrevVersion;
			SELF.PrevCount := R.PrevCount;
			SELF.DelTaPassed := IF((UNSIGNED)L.CurrCount <= (UNSIGNED) threshold_count, 'Y', 'N');
			SELF := L;
		END;
								
		NewDeltaStat := JOIN(statsout_new, statsout_old, LEFT.datagroup = RIGHT.datagroup, tCalculateDelTaStats(LEFT, RIGHT));
		
		StatsFile_Father 	:= '~thor_data400::DeltaStats::OrphanFileStats::' + in_datagroup;
		StatsFile_Child 	:= StatsFile_Father + '::' + WORKUNIT;
		
		Publish := OUTPUT(NewDeltaStat,, StatsFile_Child, THOR, COMPRESSED, OVERWRITE);		
		boolean fileExists 	:= std.File.SuperFileExists(StatsFile_Father);
		Create_StatsFile 	:= IF(~fileExists, std.File.CreateSuperFile(StatsFile_Father));
		
		AddFile := SEQUENTIAL(STD.FILE.StartSuperFileTransaction(),
							STD.FILE.ClearSuperFile(StatsFile_Father),
							STD.FILE.AddSuperFile(StatsFile_Father,  StatsFile_Child),
							STD.File.FinishSuperFileTransaction());
		
		Create_Stats := SEQUENTIAL(Create_StatsFile, Publish, AddFile);	
		RETURN Create_Stats;
	END;	
END;
	
