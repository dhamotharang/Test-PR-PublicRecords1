import std,ut;

string  version		 		:= workunit :stored('version'  );
string  emailList  		:= ''       :stored('emailList');
string  dataset_name	:= workunit :stored('dataset_name');
string  job_name			:= ''       :stored('job_name');
string	wuid					:= workunit	:stored('wuid');


EXPORT BuildStart(boolean skipEmail = false) := function
TempSuperFile:='~thor_data400::'+dataset_name+'::BuildLog::Temp';

new_entry:=dataset([{dataset_name,version,'Build_Start',std.str.filter(Std.Date.SecondsToString(Std.Date.CurrentSeconds(TRUE), '%F%H%M%S%u')[1..16],'0123456789'),job_name,wuid}],BuildLogger.Layouts.layout_log);
old_entries:=dataset(TempSuperFile,BuildLogger.Layouts.layout_log,thor,opt);
LogForPreviousRun:=TempSuperFile+'_Pre_'+wuid;
publish_old:=sequential(output(old_entries,,LogForPreviousRun,thor,overwrite),
										nothor(global(sequential(STD.File.StartSuperFileTransaction(),
										STD.File.ClearSuperFile(TempSuperFile,true),
										STD.File.FinishSuperFileTransaction()))),
										nothor(global(sequential(STD.File.StartSuperFileTransaction(),
										STD.File.AddSuperFile(TempSuperFile,LogForPreviousRun),
										STD.File.FinishSuperFileTransaction()))));

publish:=sequential(if(emailList <>'' AND NOT skipEmail, fileservices.sendEmail(emailList,
																			dataset_name+' v'+version+': Build Start','See: '+wuid+ ' / '+TempSuperFile)),
																			output(new_entry,,TempSuperFile+'::BuildStart',thor,overwrite),
																			nothor(global(sequential(STD.File.StartSuperFileTransaction(),
																			STD.File.AddSuperFile(TempSuperFile,TempSuperFile+'::BuildStart'),
																			STD.File.FinishSuperFileTransaction()))));
										

return sequential(if(NOT STD.File.SuperFileExists(TempSuperFile),sequential(STD.File.StartSuperFileTransaction(),
																																 STD.File.CreateSuperFile(TempSuperFile),
																																 STD.File.FinishSuperFileTransaction())),
									if(STD.File.GetSuperFileSubCount(TempSuperFile)>0,publish_old),publish);
end;