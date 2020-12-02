import wk_ut,_Control,std;

EXPORT _CRON_ECL(string pProcessName = '',boolean pUseProd = false, boolean pDaily = true, string pVersion='')  := Module

shared version 										:= if(pVersion='',(string8)std.date.today(),pVersion);
shared groupname		             	:= if(pUseProd, IDA._Constants(version,pUseProd).PROD_THOR, IDA._Constants(version,pUseProd).DATALAND_THOR);
shared period            					:= if(pDaily, 'DAILY ','QUARTERLY LEXID REAPPEND ');

Export WU_NAME				      			:= 'IDA ' + period + 'BUILD';
Export WU_VERSION 								:= WU_NAME + ' ' + version;
Export SCHEDULER_NAME 						:= WU_NAME + ' SCHEDULER';
Export EVENT_NAME     						:= WU_NAME + ' EVENT';


sDaily                 						:= if(pDaily, 'true','false');
sUseProd                          := if(pUseProd,'TRUE','FALSE');

IDA_BASE_REAPPEND_ECL             := 'do:=SEQUENTIAL(\nIDA._BWR_Did_Reappend(\''+version+'\','+sUseProd+')\n);\n';
IDA_DAILY_SPRAY_ECL               := 'do:=SEQUENTIAL(\nIDA._BWR_Build(\''+version+'\','+sUseProd+')\n);\n';


PROCESS_ECL 				:= Case(pProcessName, 
														'IDA BUILD'        => IDA_DAILY_SPRAY_ECL,
														'IDA REAPPEND'     => IDA_BASE_REAPPEND_ECL,'');

DO_SEQUENTIAL_ECL   := Case(pProcessName,
														'IDA BUILD'         => PROCESS_ECL,
														'IDA REAPPEND'      => PROCESS_ECL,
														'DO:= SEQUENTIAL(\n'+PROCESS_ECL+');\n');

Export WU := 
'import std, PromoteSupers, wk_ut;\n'
+'#WORKUNIT(\'name\',\'' + WU_VERSION + '\');\n'
+'#option(\'maxCsvRowSizeMb\', 90);\n'
+ DO_SEQUENTIAL_ECL
+'dont:=output(\''+ WU_NAME + ' is already RUNNING\');\n'
+'active_workunit := IDA.GetActiveWU(\'' + WU_NAME + '\');\n'
+'_process := if(active_workunit = false,do,dont);\n'
+'_process;';


end;