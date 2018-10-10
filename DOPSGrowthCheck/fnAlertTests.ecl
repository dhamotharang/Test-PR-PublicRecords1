EXPORT fnAlertTests(string PackageName,string KeyNickName,string version, decimal6_3 NumRecsThresholdMin, decimal6_3 NumRecsThresholdMax, decimal6_3 UniqueThresholdMin, decimal6_3 UniqueThresholdMax, decimal6_3 PIDThresholdMax,decimal6_3 AddedThresholdMin, decimal6_3 AddedThresholdMax, decimal6_3 ModifiedThresholdMin, decimal6_3 ModifiedThresholdMax, decimal6_3 RemovedThresholdMin, decimal6_3 RemovedThresholdMax,decimal6_3 PersistThresholdMax,string emailList) := function

	CalcAlerts:=DopsGrowthCheck.CalculateStatsAlerts(PackageName,KeyNickName,version,NumRecsThresholdMin,NumRecsThresholdMax,UniqueThresholdMin,UniqueThresholdMax,PIDThresholdMax);
	DeltaAlertsCollect:=DopsGrowthCheck.DeltaAlerts(PackageName,KeyNickName,version,AddedThresholdMin,AddedThresholdMax,ModifiedThresholdMin,ModifiedThresholdMax,RemovedThresholdMin,RemovedThresholdMax);
	PersistAlerts:=DopsGrowthCheck.PersistenceAlert(PackageName,KeyNickName,version,PersistThresholdMax);
	
	EmailReport:=if(emailList <>'' , fileservices.sendEmail(emailList,
																			'DopsAlertReport for Package:'+PackageName+' and file:'+KeyNickName,
																			'The following Alerts were generated:\n'+
																			CalcAlerts+'\n'+
																			DeltaAlertsCollect+'\n'+
																			PersistAlerts+'\n'+
																			'Please rollback cert submission if necessary\n'));
																			
	return EmailReport;
	
	

end;