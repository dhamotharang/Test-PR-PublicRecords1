import std,ut,_control;

string  version		 		:= workunit :stored('version'  );
string  emailList  		:= ''       :stored('emailList');
string  dataset_name	:= workunit :stored('dataset_name');
string  job_name			:= ''       :stored('job_name');
string	wuid					:= workunit	:stored('wuid');
string  KeyName				:= ''				:stored('KeyName');

EXPORT BuildEnd(boolean skipEmail = false) := function
TempSuperFile:='~thor_data400::'+dataset_name+'::BuildLog::Temp';
SuperFile:='~thor_data400::datasets::buildlogs';
Super_Log_File:='~thor_data400::'+dataset_name+'::BuildLog';
log_File:='~thor_data400::'+dataset_name+'::BuildLog::Temp::Build_End';

new_entry		:= dataset([{dataset_name,version,'Build_End',std.str.filter(Std.Date.SecondsToString(Std.Date.CurrentSeconds(TRUE), '%F%H%M%S%u'),'0123456789'),job_name,wuid}],BuildLogger.Layouts.layout_log);
PublishLastEntry:=sequential(output(new_entry,,log_File,thor,overwrite),
														 nothor(global(sequential(STD.File.StartSuperFileTransaction(),
															STD.File.AddSuperFile(TempSuperFile,log_File),
															STD.File.FinishSuperFileTransaction())))
														 );
SuperFile_Entries	:=	dataset(Super_Log_File,BuildLogger.Layouts.layout_log,thor,opt);
EmailPeople	:=	if(emailList <>'' AND NOT skipEmail, fileservices.sendEmail(emailList,
																			dataset_name+' v'+version+': Build End','See: '+wuid+ ' / '+log_File));
																			
MergeWithFullFile:=_control.fSubmitNewWorkunit(
									 'SuperFile_Entries	:=	dataset(\''+Super_Log_File+'\',BuildLogger.Layouts.layout_log,thor,opt);\r\n'+
									 'TempSuperFile:=dataset(\''+TempSuperFile+'\',BuildLogger.Layouts.layout_log,thor,opt);\r\n'+
									 'ordered(BuildLogger.CreateFullEntry(TempSuperFile,\''+KeyName+'\'),\r\n'+
									 'output(SuperFile_Entries+TempSuperFile,,\''+Super_Log_File+'_temp\',thor,overwrite),\r\n'+
									 'sequential(STD.File.StartSuperFileTransaction(),\r\n'+
									 'STD.File.RemoveSuperFile(\''+SuperFile+'\',\''+Super_Log_File+'\',true),\r\n'+
									 'STD.File.FinishSuperFileTransaction());\r\n'+
										'nothor(global(sequential(fileservices.deleteLogicalFile(\''+Super_Log_File+'\'),\r\n'+
										'fileservices.renameLogicalFile(\''+Super_Log_File+'_temp\',\''+Super_Log_File+'\'),\r\n'+
										'STD.File.StartSuperFileTransaction(),\r\n'+
										'STD.File.AddSuperFile(\''+SuperFile+'\',\''+Super_Log_File+'\'),\r\n'+
										'STD.File.FinishSuperFileTransaction()))),\r\n'+
										'sequential(STD.File.StartSuperFileTransaction(),\r\n'+
										'STD.File.ClearSuperFile(\''+TempSuperFile+'\',true),\r\n'+
										'STD.File.FinishSuperFileTransaction()));\r\n'
									 ,std.system.job.target());




publish:=sequential(PublishLastEntry,
										EmailPeople,
										MergeWithFullFile);
										


return publish;
end;