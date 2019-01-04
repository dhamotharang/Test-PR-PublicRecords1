
import buildlogger, _control, std;

EXPORT CreateFullEntry (dataset(BuildLogger.Layouts.layout_log) new_raw,string PackageName)	:= function

	dataset_name	:=	new_raw[1].dataset_name;
	SortedList	:=	sort(new_raw,wuid);
	GroupedList	:=	group(SortedList,wuid);

	BuildLogger.Layouts.Report_Record tCombine(BuildLogger.Layouts.layout_log L,Dataset(BuildLogger.Layouts.layout_log) R) := transform
																			Self.Build_Start	:=	if(exists(R(tag='Build_Start')),R(tag='Build_Start')[1].date_time,'');
																			Self.Build_End		:=	if(exists(R(tag='Build_End')),R(tag='Build_End')[1].date_time,'');
																			Self.Prep_Start		:=	if(exists(R(tag='Prep_Start')),R(tag='Prep_Start')[1].date_time,'');
																			Self.Prep_End			:=	if(exists(R(tag='Prep_End')),R(tag='Prep_End')[1].date_time,'');
																			Self.Base_Start		:=	if(exists(R(tag='Base_Start')),R(tag='Base_Start')[1].date_time,'');
																			Self.Base_End			:=	if(exists(R(tag='Base_End')),R(tag='Base_End')[1].date_time,'');
																			Self.Key_Start		:=	if(exists(R(tag='Key_Start')),R(tag='Key_Start')[1].date_time,'');
																			Self.Key_End			:=	if(exists(R(tag='Key_End')),R(tag='Key_End')[1].date_time,'');
																			Self.Post_Start		:=	if(exists(R(tag='Post_Start')),R(tag='Post_Start')[1].date_time,'');
																			Self.Post_End			:=	if(exists(R(tag='Post_End')),R(tag='Post_End')[1].date_time,'');
																			Self.Build_Status	:=	if(Self.Build_End = '','Build_Incomplete','Build_Completed');
																			Self:=L;
																			end;

CombinedRecords := rollup(GroupedList,GROUP,tCombine(left,ROWS(left)));

SecondSort:=sort(combinedRecords,version);
SecondGroup:=group(SecondSort,version);

BuildLogger.Layouts.Process_Record tCreateRecord(CombinedRecords L, Dataset(BuildLogger.Layouts.Report_Record)R):= transform
	self.dataset_name:=L.dataset_name;
	self.version:=L.version;
	self.PackageName:=PackageName;
	self.Build_Start:=min(R,Build_Start);
	self.Build_End:=if(max(R,Build_End)='','',max(R,Build_End));
	self.Cert_Start:=if(Self.Build_End='','NA','');
	self.Cert_End:=if(Self.Build_End='','NA','');
	self.Processing_Days:=if(Self.Build_End='','NA','');
	self.Build_Hours_Mins_Secs:=if(Self.Build_End='','NA','');
	self.Deployment_Days:=if(Self.Build_End='','NA','');
	self.Days_QA:=if(Self.Build_End='','NA','');
	Self.BuildType:=if(Self.Build_End='','NA','');
	self:=[];
end;

NewEntries := rollup(SecondGroup,GROUP,tCreateRecord(left,ROWS(left)));

SuperFile:='~thor_data400::datasets::fullbuildlogs::temp';
Super_Log_File:='~thor_data400::datasets::fullbuildlogs::temp'+workunit;

IndividLog:=dataset(SuperFile,BuildLogger.Layouts.Process_Record,thor,opt);
Newlog:=output(IndividLog+NewEntries,,Super_Log_File,thor,overwrite);

return 	sequential(
						Newlog,
						nothor(global(sequential(
						STD.File.StartSuperFileTransaction(),
						STD.File.ClearSuperFile(SuperFile,true),
						STD.File.AddSuperFile(SuperFile,Super_Log_File),
						STD.File.FinishSuperFileTransaction()))));


end;