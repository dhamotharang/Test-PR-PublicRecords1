import std,ut;

string  version		 		:= workunit :stored('version'  );
string  emailList  		:= ''       :stored('emailList');
string  dataset_name	:= workunit :stored('dataset_name');
string  job_name			:= ''       :stored('job_name');
string	wuid					:= workunit	:stored('wuid');

EXPORT CustomTag(string custom_tag,boolean skipEmail = false) := function
TempSuperFile:='~thor_data400::'+dataset_name+'::BuildLog::Temp';
log_File:='~thor_data400::'+dataset_name+'::BuildLog::Temp::'+custom_tag;
new_entry		:= dataset([{dataset_name,version,custom_tag,std.str.filter(Std.Date.SecondsToString(Std.Date.CurrentSeconds(TRUE), '%F%H%M%S%u')[1..16],'0123456789'),job_name,wuid}],BuildLogger.Layouts.layout_log);
publish:=sequential(if(emailList <>'' AND NOT skipEmail, fileservices.sendEmail(emailList,
																			dataset_name+' v'+version+': '+custom_tag,'See: '+wuid+ ' / '+log_File)),
																			output(new_entry,,log_File,thor,overwrite),
																			nothor(global(sequential(STD.File.StartSuperFileTransaction(),
																			STD.File.AddSuperFile(TempSuperFile,log_File),
																			STD.File.FinishSuperFileTransaction()))));

return publish;
end;