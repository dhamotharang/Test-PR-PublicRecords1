EXPORT ConfigureAlerts(PackageNameIn,KeyNickNameIn,NumRecsThresholdMinIn='',NumRecsThresholdMaxIn='',UniqueThresholdMinIn='',UniqueThresholdMaxIn='',PIDThresholdMaxIn='',AddedThresholdMinIn='',AddedThresholdMaxIn='',ModifiedThresholdMinIn='',ModifiedThresholdMaxIn='',RemovedThresholdMinIn='',RemovedThresholdMaxIn='',PersistThresholdMaxIn='',emailListIn='',Option):= functionmacro
	
	loadfile:=dataset('~thor_data400::DeltaStats::AlertConfigurations',DOPSGrowthCheck.layouts.Configuration_Layout,thor,opt);
	NewRec:=dataset([{PackageNameIn,KeyNickNameIn,NumRecsThresholdMinIn,NumRecsThresholdMaxIn,UniqueThresholdMinIn,UniqueThresholdMaxIn,PIDThresholdMaxIn,AddedThresholdMinIn,AddedThresholdMaxIn,ModifiedThresholdMinIn,ModifiedThresholdMaxIn,RemovedThresholdMinIn,RemovedThresholdMaxIn,PersistThresholdMaxIn,emailListIn}],DOPSGrowthCheck.layouts.Configuration_Layout);
	#IF(STD.Str.ToUpperCase(Option)='ADD')
		FinalSet:=if(exists(loadfile(PackageName=PackageNameIn and KeyNickName=KeyNickNameIn)),loadfile,loadfile+newrec);
	#ELSEIF(STD.Str.ToUpperCase(Option)='REMOVE')
		FinalSet:=loadfile(PackageName!=PackageNameIn and KeyNickName!=KeyNickNameIn);
	#ELSEIF(STD.Str.ToUpperCase(Option)='MODIFY')
		TempSet:=loadfile(PackageName!=PackageNameIn and KeyNickName!=KeyNickNameIn);
		FinalSet:=TempSet+NewRec;
	#ELSE
		FinalSet:=loadfile;
	#END
	
	CreateNewfile:=output(FinalSet,,'~thor_data400::DeltaStats::AlertConfigurations::'+workunit,thor,compressed);

	ClearFiles:=nothor(global(sequential(STD.File.StartSuperFileTransaction(),
										STD.File.ClearSuperFile('~thor_data400::DeltaStats::AlertConfigurations',false),
										STD.File.FinishSuperFileTransaction())));
										
	return sequential(
										CreateNewfile,
										ClearFiles,
										nothor(global(sequential(
										STD.File.StartSuperFileTransaction(),
										STD.File.AddSuperFile('~thor_data400::DeltaStats::AlertConfigurations','~thor_data400::DeltaStats::AlertConfigurations::'+workunit),
										STD.File.FinishSuperFileTransaction()))));
	
endmacro;