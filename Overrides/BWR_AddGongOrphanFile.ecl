import std;

   in_datagroup := 'gong';	
	 
	 StatsFile_Father := '~thor_data400::DeltaStats::OrphanFileStats::' + in_datagroup;
	StatsFile_Child := StatsFile_Father + '::' + WORKUNIT;
	
	
	//Publish := IF(~fileservices.fileexists(StatsFile_Child), fileservices.createsuperfile(StatsFile_Child));
	 
	
	ds := DATASET([{Constants.GONG ,	 FALSE}, {Constants.PAW ,	 FALSE}], Overrides.File_Override_Orphans.orphan_skip_datagroup_rec);
	OUTPUT(ds,, StatsFile_Child, THOR, COMPRESSED, OVERWRITE);
	
	boolean fileExists := std.File.SuperFileExists(StatsFile_Father);

	output(fileExists, named('father_file_exists'));	
	
	Create_StatsFile := IF(~fileExists, std.File.CreateSuperFile(StatsFile_Father));
	

	//Publish := IF(~std.File.SuperFileExists('~thor_data400::DeltaStats::OrphanFileStats::' + in_datagroup  + '::' + WORKUNIT),
	//							std.File.CreateSuperFile('~thor_data400::DeltaStats::OrphanFileStats::' + in_datagroup  + '::' + WORKUNIT));

	AddFile := SEQUENTIAL(STD.FILE.StartSuperFileTransaction(),
                      STD.FILE.AddSuperFile(StatsFile_Father,  StatsFile_Child),
                  STD.File.FinishSuperFileTransaction());
	
	BuildStats := SEQUENTIAL(Create_StatsFile, AddFile);	
	
	BuildStats;
	