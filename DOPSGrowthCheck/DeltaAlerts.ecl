import std;
EXPORT DeltaAlerts(string SpecPackageName, string SpecKeyNickname, string SpecVersion, decimal6_3 AddedThresholdMin, decimal6_3 AddedThresholdMax, decimal6_3 ModifiedThresholdMin, decimal6_3 ModifiedThresholdMax, decimal6_3 RemovedThresholdMin, decimal6_3 RemovedThresholdMax, string emailList, boolean publish=true):= function;

	oldrecsPlus:=dataset('~thor_data400::DeltaStats::FullDeltaStats::full',DOPSGrowthCheck.layouts.Full_Delta_Stat_Layout,thor,__compressed__,opt);

	newrecsPlus:=dataset('~thor_data400::DeltaStats::FullDeltaStats::using',DOPSGrowthCheck.layouts.Full_Delta_Stat_Layout,thor,__compressed__,opt);
	
	CombinedRecs := oldrecsPlus + newrecsPlus;

	SpecificInstances:=CombinedRecs(PackageName=SpecPackageName and KeyNickName=SpecKeyNickname and CurrVersion=SpecVersion and field='Total');
		
	AddedAlerts:=if(exists(SpecificInstances(Stat_Name='Delta_Added')),if((real)SpecificInstances(Stat_Name='Delta_Added')[1].results_percent <= AddedThresholdMax and (real)SpecificInstances(Stat_Name='Delta_Added')[1].results_percent >= AddedThresholdMin,false,true),false);
	ModifiedAlerts:=if(exists(SpecificInstances(Stat_Name='Delta_Modified')),if((real)SpecificInstances(Stat_Name='Delta_Modified')[1].results_percent <= ModifiedThresholdMax and (real)SpecificInstances(Stat_Name='Delta_Modified')[1].results_percent >= ModifiedThresholdMin,false,true),false);
	RemovedAlerts:=if(exists(SpecificInstances(Stat_Name='Delta_Removed')),if((real)SpecificInstances(Stat_Name='Delta_Removed')[1].results_percent <= RemovedThresholdMax and (real)SpecificInstances(Stat_Name='Delta_Removed')[1].results_percent >= RemovedThresholdMin,false,true),false);
	
	AddAddedAlerts:=if(AddedAlerts,'Number of Records Growth: '+ SpecificInstances(Stat_Name='Delta_Added')[1].results_percent + 'Min Threshold: ' + AddedThresholdMin + 'Max Threshold: ' + AddedThresholdMax + '\n','');
	AddModifiedAlerts:=if(ModifiedAlerts,AddAddedAlerts + 'UniqueDID Growth: '+ SpecificInstances(Stat_Name='Delta_Modified')[1].results_percent + 'Min Threshold: ' + ModifiedThresholdMin + 'Max Threshold: ' + ModifiedThresholdMax + '\n',AddAddedAlerts);	
	AddRemovedAlerts:=if(RemovedAlerts,AddModifiedAlerts + 'UniqueProxID Growth: '+ SpecificInstances(Stat_Name='Delta_Removed')[1].results_percent + 'Min Threshold: ' + RemovedThresholdMin + 'Max Threshold: ' + RemovedThresholdMax + '\n',AddModifiedAlerts);
	
	NewHistoryRec:=dataset([{SpecPackageName,SpecKeyNickname,SpecVersion,AddedAlerts,ModifiedAlerts,RemovedAlerts}],DOPSGrowthCheck.layouts.DeltaStatAlerts);
	
	ToPublish:=output(NewHistoryRec,,'~thor_data400::DeltaStats::DeltaStatsAlerts::using::'+workunit+SpecKeyNickname,thor,compressed,overwrite);
	AddFile:=sequential(STD.FILE.StartSuperFileTransaction(),
                      STD.FILE.AddSuperFile('~thor_data400::DeltaStats::DeltaStatsAlerts::using','~thor_data400::DeltaStats::DeltaStatsAlerts::using::'+workunit+SpecKeyNickname),
                      STD.File.FinishSuperFileTransaction()
                     );
	ToNotPublish:=output(AddRemovedAlerts);
	
	FinalHistory:=if(Publish,sequential(ToPublish,AddFile),ToNotPublish);
	FinalHistory;
	return AddRemovedAlerts;
end;

