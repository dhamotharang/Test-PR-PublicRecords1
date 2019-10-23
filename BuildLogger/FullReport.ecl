import data_services, dops, std, ut, _control;
	
	MoveToUsed:=STD.File.PromoteSuperFileList(['~thor_data400::datasets::fullbuildlogs::temp','~thor_data400::datasets::fullbuildlogs::using']);
	
	oldrecs:=BuildLogger.File_Full_Logs;

	newrecs:=BuildLogger.File_Using_Logs;
	
	CompleteRecs:=oldrecs(cert_start <> '' and cert_end <> '')+ newrecs(cert_start <> '' and cert_end <> '');
	
	IncompleteRecs:=oldrecs(cert_start = '' or cert_end = '') + newrecs(cert_start = '' or cert_end = '');
	
	BuildLogger.Layouts.Process_Record tFillInDOPS (BuildLogger.Layouts.Process_Record L):= transform
		DOPSInfo:=dops.GetReleaseHistory('B', 'N', L.packageName);
		DOPSVersion:=DOPSInfo(certversion=L.version or prodversion=L.version);
		
		EndInSecs:=if(L.Build_Start='' or L.Build_End='',-1,timelib.SecondsFromParts((integer2)(L.Build_End[1..4]),(unsigned1)(L.Build_End[5..6]),(unsigned1)(L.Build_End[7..8]),(unsigned1)(L.Build_End[9..10]),(unsigned1)(L.Build_End[11..12]),(unsigned1)(L.Build_End[13..14]),true));
		StartInSecs:=if(L.Build_Start='' or L.Build_End='',-1,timelib.SecondsFromParts((integer2)(L.Build_Start[1..4]),(unsigned1)(L.Build_Start[5..6]),(unsigned1)(L.Build_Start[7..8]),(unsigned1)(L.Build_Start[9..10]),(unsigned1)(L.Build_Start[11..12]),(unsigned1)(L.Build_Start[13..14]),true));
		TotalSeconds:=if(L.Build_Start='' or L.Build_End='',-1,EndInSecs-StartInSecs);
		hours:=if(TotalSeconds=-1,-1,totalseconds DIV 3600);
		mins:=if(TotalSeconds=-1,-1,(totalseconds%3600) DIV 60);
		secs:=if(TotalSeconds=-1,-1,(totalseconds%3600)%60);
		
		Self.Cert_Start:=if(EXISTS(DOPSVersion),if(DOPSVersion[1].certwhenupdated='NA','NA',BuildLogger.fn_dategmt(DOPSVersion[1].certwhenupdated)),'');
		Self.Cert_End:=if(EXISTS(DOPSVersion),if(DOPSVersion[1].prodwhenupdated='NA','NA',BuildLogger.fn_dategmt(DOPSVersion[1].prodwhenupdated)),'');
		self.BuildType:=if(EXISTS(DOPSVersion),if(DOPSVersion[1].updateflag='F','Full','Delta'),'');
		self.Processing_Days:=if(L.Build_Start='' or L.Build_End='','N/A',(string)ut.BusDaysApart((Std.Date.Date_t)L.Build_Start[1..8],(Std.Date.Date_t)L.Build_End[1..8]));
		self.Build_Hours_Mins_Secs:=if(TotalSeconds=-1,'N/A',(string)hours+':'+(string)mins+':'+(string)secs);
		Self:=L;
		Self:=[];
	end;
	
	Fillin:= project(IncompleteRecs,tFillInDOPS(left));
	
	Filled:=Fillin(cert_start <> '' and cert_end <> '');
	UnFilled:=Fillin(cert_start = '' or cert_end = '');
	
	BuildLogger.Layouts.Process_Record tCalculateDays(BuildLogger.Layouts.Process_Record L):= transform
		
		self.Deployment_Days:=if(L.Cert_Start='NA' or L.Build_End='','NA',(string)ut.BusDaysApart((Std.Date.Date_t)L.Build_End[1..8],(Std.Date.Date_t)L.Cert_Start));
		self.Days_QA:=if(L.Cert_End='NA','NA',
								if(L.Cert_Start='NA',(string)ut.BusDaysApart((Std.Date.Date_t)L.Build_End[1..8],(Std.Date.Date_t)L.Cert_End),
																				if(L.Cert_Start>L.Cert_End,'0',(string)ut.BusDaysApart((Std.Date.Date_t)L.Cert_Start,(Std.Date.Date_t)L.Cert_End))));
		Self:=L;
		Self:=[];
	end;
	
	NewCalculated:=project(Filled,tCalculateDays(Left));
	
	FullFile:=CompleteRecs+UnFilled+NewCalculated;
	
	SuperFile:='~thor_data400::datasets::fullbuildlogs';
	Super_Log_File:='~thor_data400::datasets::FullLog::'+workunit;

IndividLog:=dataset(Super_Log_File,BuildLogger.Layouts.Process_Record,thor,opt);
Newlog:=output(FullFile,,Super_Log_File,thor,overwrite);
clearusing:=SEQUENTIAL(
STD.File.StartSuperFileTransaction(),
STD.File.ClearSuperFile('~thor_data400::datasets::fullbuildlogs::using',true),
STD.File.FinishSuperFileTransaction()
);

 EXPORT FullReport:= 	sequential( MoveToUsed,
												Newlog,
												nothor(global(sequential(
												STD.File.StartSuperFileTransaction(),
												STD.File.ClearSuperFile(SuperFile,true),
												STD.File.AddSuperFile(SuperFile,Super_Log_File),
												STD.File.FinishSuperFileTransaction()))),
												clearusing
												);

	

