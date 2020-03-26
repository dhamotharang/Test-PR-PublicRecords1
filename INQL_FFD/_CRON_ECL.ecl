import wk_ut,_Control,std;

EXPORT _CRON_ECL(string pProcessName = '', boolean isFCRA = false, boolean pDaily = true, string pVersion='')  := Module

shared version 											:= if(pVersion='',(string8)std.date.today(),pVersion):INDEPENDENT;
shared fcra_nonfcra_groupname				:= INQL_FFD._Constants.GROUPNAME;
shared fcra_nonfcra 								:= if(pProcessName='',' ',if(isFCRA, ' FCRA ',' NONFCRA '));
shared period            						:= if(pDaily, 'DAILY ','WEEKLY ');

Export WU_NAME				      				:= 'HIST INQL' + fcra_nonfcra + period + pProcessName;
Export WU_VERSION 									:= WU_NAME + ' ' + version;
Export SCHEDULER_NAME 							:= WU_NAME + ' SCHEDULER';
Export EVENT_NAME     							:= WU_NAME + ' EVENT';

sDaily                 							:= if(pDaily, 'true','false');
sFCRA                  							:= if(isFCRA, 'true','false');

FILES_SCRUB_ECL            	  			:= 'Scrubs_Inquiry_History.proc_generate_report();\n';
BASE_BUILD_ECL              				:= 'INQL_FFD.Build_all(\'' + version + '\',' + sFCRA + ');\n';

PROCESS_ECL 												:= Case(pProcessName, 
																						'FILES SCRUB' 		=> FILES_SCRUB_ECL,	
																						'BASE BUILD' 			=> BASE_BUILD_ECL,'');

Export WU := 
'import std, PromoteSupers, wk_ut;\n'
+'#WORKUNIT(\'name\',\'' + WU_VERSION + '\');\n'
+'#option(\'maxCsvRowSizeMb\', 90);\n'
+'do := sequential(\n'
+ PROCESS_ECL
+');\n'
+'dont:=output(\''+ WU_NAME + ' is already RUNNING\');\n'
+'active_workunit := INQL_FFD._Functions.Get_Active_WU(\'' + WU_NAME + '\');\n'
+'_process := if(active_workunit = false,do,dont);\n'
+'_process;';


end;
