import std;
EXPORT CalculateStatsAlerts(string SpecPackageName, string SpecKeyNickname, string SpecVersion, decimal6_3 NumRecsThresholdMin, decimal6_3 NumRecsThresholdMax, decimal6_3 UniqueThresholdMin, decimal6_3 UniqueThresholdMax, decimal6_3 PIDThresholdMax, boolean publish=true):= function;

	oldrecsPlus:=dataset('~thor_data400::DeltaStats::IndividualFileStats::full',DOPSGrowthCheck.layouts.Stats_Layout,thor,__compressed__,opt);

	newrecsPlus:=dataset('~thor_data400::DeltaStats::IndividualFileStats::using',DOPSGrowthCheck.layouts.Stats_Layout,thor,__compressed__,opt);
	
	CombinedRecs := oldrecsPlus + newrecsPlus;

	SpecificInstances:=CombinedRecs(PackageName=SpecPackageName and KeyNickName=SpecKeyNickname and CurrVersion=SpecVersion and RecType='D');
	SpecificInstancesPersist:=CombinedRecs(PackageName=SpecPackageName and KeyNickName=SpecKeyNickname and CurrVersion=SpecVersion and RecType='B');
	
	NumRecsAlerts:=if(exists(SpecificInstances(Stat_Name='NumRecs' and Results='')),false,if((real)SpecificInstances(Stat_Name='NumRecs')[1].results <= NumRecsThresholdMax and (real)SpecificInstances(Stat_Name='NumRecs')[1].results >= NumRecsThresholdMin,false,true));
	UniqueDIDAlerts:=if(exists(SpecificInstances(Stat_Name='UniqueDID' and Results='')),false,if((real)SpecificInstances(Stat_Name='UniqueDID')[1].results <= UniqueThresholdMax and (real)SpecificInstances(Stat_Name='UniqueDID')[1].results >= UniqueThresholdMin,false,true));
	UniqueProxIDAlerts:=if(exists(SpecificInstances(Stat_Name='UniqueProxID' and Results='')),false,if((real)SpecificInstances(Stat_Name='UniqueProxID')[1].results <= UniqueThresholdMax and (real)SpecificInstances(Stat_Name='UniqueProxID')[1].results >= UniqueThresholdMin,false,true));
	UniqueSeleIDAlerts:=if(exists(SpecificInstances(Stat_Name='UniqueSeleID' and Results='')),false,if((real)SpecificInstances(Stat_Name='UniqueSeleID')[1].results <= UniqueThresholdMax and (real)SpecificInstances(Stat_Name='UniqueDID')[1].results >= UniqueThresholdMin,false,true));
	UniquePersistentRecIDAlerts:=if(exists(SpecificInstancesPersist(Stat_Name='UniquePersistentRecID' and Results='')),false,if((((((real)SpecificInstancesPersist(Stat_Name='NumRecs')[1].results)-((real)SpecificInstancesPersist(Stat_Name='UniquePersistentRecID')[1].results))/((real)SpecificInstancesPersist(Stat_Name='NumRecs')[1].results))*100) <= PIDThresholdMax,false,true));
	UniqueEmailAlerts:=if(exists(SpecificInstances(Stat_Name='UniqueEmail' and Results='')),false,if((real)SpecificInstances(Stat_Name='UniqueEmail')[1].results <= UniqueThresholdMax and (real)SpecificInstances(Stat_Name='UniqueEmail')[1].results >= UniqueThresholdMin,false,true));
	UniquePhoneAlerts:=if(exists(SpecificInstances(Stat_Name='UniquePhone' and Results='')),false,if((real)SpecificInstances(Stat_Name='UniquePhone')[1].results <= UniqueThresholdMax and (real)SpecificInstances(Stat_Name='UniquePhone')[1].results >= UniqueThresholdMin,false,true));
	UniqueSSNAlerts:=if(exists(SpecificInstances(Stat_Name='UniqueSSN' and Results='')),false,if((real)SpecificInstances(Stat_Name='UniqueSSN')[1].results <= UniqueThresholdMax and (real)SpecificInstances(Stat_Name='UniqueSSN')[1].results >= UniqueThresholdMin,false,true));
	UniqueFEINAlerts:=if(exists(SpecificInstances(Stat_Name='UniqueFEIN' and Results='')),false,if((real)SpecificInstances(Stat_Name='UniqueFEIN')[1].results <= UniqueThresholdMax and (real)SpecificInstances(Stat_Name='UniqueFEIN')[1].results >= UniqueThresholdMin,false,true));
	
	
	AddNumAlerts:=if(NumRecsAlerts,'Number of Records Growth: '+ SpecificInstances(Stat_Name='NumRecs')[1].results + 'Min Threshold: ' + NumRecsThresholdMin + 'Max Threshold: ' + NumRecsThresholdMax + '\n','');
	AddUniqueDIDAlerts:=if(UniqueDIDAlerts,AddNumAlerts + 'UniqueDID Growth: '+ SpecificInstances(Stat_Name='UniqueDID')[1].results + 'Min Threshold: ' + UniqueThresholdMin + 'Max Threshold: ' + UniqueThresholdMax + '\n',AddNumAlerts);	
	AddUniqueProxIDAlerts:=if(UniqueProxIDAlerts,AddUniqueDIDAlerts + 'UniqueProxID Growth: '+ SpecificInstances(Stat_Name='UniqueProxID')[1].results + 'Min Threshold: ' + UniqueThresholdMin + 'Max Threshold: ' + UniqueThresholdMax + '\n',AddUniqueDIDAlerts);
	AddUniqueSeleIDAlerts:=if(UniqueSeleIDAlerts,AddUniqueProxIDAlerts + 'UniqueSeleID Growth: '+ SpecificInstances(Stat_Name='UniqueSeleID')[1].results + 'Min Threshold: ' + UniqueThresholdMin + 'Max Threshold: ' + UniqueThresholdMax + '\n',AddUniqueProxIDAlerts);
	AddUniquePersistentRecIDAlerts:=if(UniquePersistentRecIDAlerts,AddUniqueSeleIDAlerts + 'UniquePersistentRecID Difference From NumRecs: '+ (string)(((((real)SpecificInstancesPersist(Stat_Name='NumRecs')[1].results)-((real)SpecificInstancesPersist(Stat_Name='UniquePersistentRecID')[1].results))/((real)SpecificInstancesPersist(Stat_Name='NumRecs')[1].results))*100) + 'Max Threshold: ' + PIDThresholdMax + '\n',AddUniqueSeleIDAlerts);
	AddUniqueEmailAlerts:=if(UniqueEmailAlerts,AddUniquePersistentRecIDAlerts + 'UniqueEmail Growth: '+ SpecificInstances(Stat_Name='UniqueEmail')[1].results + 'Min Threshold: ' + UniqueThresholdMin + 'Max Threshold: ' + UniqueThresholdMax + '\n',AddUniquePersistentRecIDAlerts);
	AddUniquePhoneAlerts:=if(UniquePhoneAlerts,AddUniqueEmailAlerts + 'UniquePhone Growth: '+ SpecificInstances(Stat_Name='UniquePhone')[1].results + 'Min Threshold: ' + UniqueThresholdMin + 'Max Threshold: ' + UniqueThresholdMax + '\n',AddUniqueEmailAlerts);
	AddUniqueSSNAlerts:=if(UniqueSSNAlerts,AddUniquePhoneAlerts + 'UniqueSSN Growth: '+ SpecificInstances(Stat_Name='UniqueSSN')[1].results + 'Min Threshold: ' + UniqueThresholdMin + 'Max Threshold: ' + UniqueThresholdMax + '\n',AddUniquePhoneAlerts);
	AddUniqueFEINAlerts:=if(UniqueFEINAlerts,AddUniqueSSNAlerts + 'UniqueFEIN Growth: '+ SpecificInstances(Stat_Name='UniqueFEIN')[1].results + 'Min Threshold: ' + UniqueThresholdMin + 'Max Threshold: ' + UniqueThresholdMax + '\n',AddUniqueSSNAlerts);
	
	
	NewHistoryRec:=dataset([{SpecPackageName,SpecKeyNickname,SpecVersion,
														NumRecsAlerts,SpecificInstances(Stat_Name='NumRecs')[1].results,
														UniqueDIDAlerts,SpecificInstances(Stat_Name='UniqueDID')[1].results,
														UniqueProxIDAlerts,SpecificInstances(Stat_Name='UniqueProxID')[1].results,
														UniqueSeleIDAlerts,SpecificInstances(Stat_Name='UniqueSeleID')[1].results,
														UniquePersistentRecIDAlerts,(string)(((((real)SpecificInstancesPersist(Stat_Name='NumRecs')[1].results)-((real)SpecificInstancesPersist(Stat_Name='UniquePersistentRecID')[1].results))/((real)SpecificInstancesPersist(Stat_Name='NumRecs')[1].results))*100),
														UniqueEmailAlerts,SpecificInstances(Stat_Name='UniqueEmail')[1].results,
														UniquePhoneAlerts,SpecificInstances(Stat_Name='UniquePhone')[1].results,
														UniqueSSNAlerts,SpecificInstances(Stat_Name='UniqueSSN')[1].results,
														UniqueFEINAlerts,SpecificInstances(Stat_Name='UniqueFEIN')[1].results,
														NumRecsThresholdMin,NumRecsThresholdMax,UniqueThresholdMin,UniqueThresholdMax,PIDThresholdMax
														}],DOPSGrowthCheck.layouts.CalculateStatAlerts);
	
	ToPublish:=output(NewHistoryRec,,'~thor_data400::DeltaStats::CalculateStatsAlerts::using::'+workunit+SpecKeyNickname,thor,compressed,overwrite);
	AddFile:=sequential(STD.FILE.StartSuperFileTransaction(),
                      STD.FILE.AddSuperFile('~thor_data400::DeltaStats::CalculateStatsAlerts::using','~thor_data400::DeltaStats::CalculateStatsAlerts::using::'+workunit+SpecKeyNickname),
                      STD.File.FinishSuperFileTransaction()
                     );
	ToNotPublish:=sequential(output(AddUniqueFEINAlerts),output(NewHistoryRec));
	FinalHistory:=if(Publish,sequential(ToPublish,AddFile),ToNotPublish);
	FinalHistory;
	return AddUniqueFEINAlerts;
	
end;