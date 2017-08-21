import scrubs, data_services;

EXPORT SeverityCheck(string pProfileName, string pVersion) := function

	RuleStorageFileName:='~thor_data400::Scrubs::'+pProfileName+'::ProfileStorage';

	OrbitStats:=data_services.foreign_prod + 'thor_data400::'+pProfileName+'::OrbitReports';
	
	LoadRuleFile:=dataset(RuleStorageFileName,scrubs.Layouts.ProfileRule_Rec,thor,opt);
	LoadStatsFile:=dataset(OrbitStats,Scrubs.Layouts.OrbitLogLayout,thor,opt);
	LatestOrbitStats:=LoadStatsFile(version=pVersion);
	
	GrabSevereRules:=if(exists(LoadRuleFile(Severity='1')),true,false);
	
	SevereOnly:=LoadRuleFile(Severity='1');
	
	GrabFailedSevereResults:=join(LatestOrbitStats,SevereOnly,left.ruledesc=right.Name,
																transform({String sourcecode,String ruledesc, Decimal5_2 pcntFailed, Decimal5_2 PassPercentage, String RejectWarning},
																					 Self.pcntFailed:=(decimal5_2)((((Real)Left.rulecnt)/((Real)Left.recordstotal))*100);
																					 Self.PassPercentage:=Right.PassPercentageTop;
																					 Self:=Left;));
																					 
	CheckReject:=if(exists(GrabFailedSevereResults(RejectWarning='Y')),true,false);
	
	output(GrabFailedSevereResults(RejectWarning='Y'),named(pProfileName+'_'+pVersion+'_'+'SevereAlerts'));
																					 
	return GrabSevereRules and CheckReject;
	
end;