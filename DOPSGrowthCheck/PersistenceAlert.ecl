
import std;
EXPORT PersistenceAlert(string SpecPackageName, string SpecKeyNickname, string SpecVersion, decimal6_3 PersistThresholdMax, boolean publish=true):= function;

	oldrecsPlus:=dataset('~thor_data400::DeltaStats::PersistenceCheck::full',DOPSGrowthCheck.layouts.PersistLayout,thor,__compressed__,opt);

	newrecsPlus:=dataset('~thor_data400::DeltaStats::PersistenceCheck::using',DOPSGrowthCheck.layouts.PersistLayout,thor,__compressed__,opt);
	
	CombinedRecs := oldrecsPlus + newrecsPlus;

	SpecificInstances:=CombinedRecs(PackageName=SpecPackageName and KeyNickName=SpecKeyNickname and CurrVersion=SpecVersion);
		
	PersistAlerts:=if(exists(SpecificInstances(diff='persistent_record_id')),if(((((real)SpecificInstances(diff='persistent_record_id')[1].NumRecsChanged)/((real)SpecificInstances(diff='')[1].NumRecsChanged+(real)SpecificInstances(diff='persistent_record_id')[1].NumRecsChanged))*100) <= PersistThresholdMax,false,true),false);
	
	AddPersistAlerts:=if(PersistAlerts,'Percent not persistent: '+ ((((real)SpecificInstances(diff='persistent_record_id')[1].NumRecsChanged)/((real)SpecificInstances(diff='')[1].NumRecsChanged+(real)SpecificInstances(diff='persistent_record_id')[1].NumRecsChanged))*100) + 'Max Threshold: ' + PersistThresholdMax + '\n','');
	
	NewHistoryRec:=dataset([{SpecPackageName,SpecKeyNickname,SpecVersion,PersistAlerts}],DOPSGrowthCheck.layouts.PersistStatAlerts);
	
	ToPublish:=output(NewHistoryRec,,'~thor_data400::DeltaStats::PersistenceStatsAlerts::using::'+workunit+SpecKeyNickname,thor,compressed,overwrite);
	AddFile:=sequential(STD.FILE.StartSuperFileTransaction(),
                      STD.FILE.AddSuperFile('~thor_data400::DeltaStats::PersistenceStatsAlerts::using','~thor_data400::DeltaStats::PersistenceStatsAlerts::using::'+workunit+SpecKeyNickname),
                      STD.File.FinishSuperFileTransaction()
                     );
	ToNotPublish:=output(AddPersistAlerts);
	
	FinalHistory:=if(Publish,sequential(ToPublish,AddFile),ToNotPublish);
	FinalHistory;
	return AddPersistAlerts;
end;

