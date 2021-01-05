import wk_ut,_Control,std;

EXPORT _CRON_ECL(string pProcessName = '',boolean pUseProd = false, boolean pDaily = true, string pVersion='')  := Module

// EXPORT version 								:= if(pversion='',IDA._Constants(pUseProd).filesdate,pversion);
EXPORT version 								:= if(pDaily,IDA._Constants(pUseProd).filesdate,IDA._Constants(pUseProd).monthlyversion);
EXPORT groupname		                	:= if(pUseProd, IDA._Constants(pUseProd).PROD_THOR, IDA._Constants(pUseProd).DATALAND_THOR);
EXPORT period            					:= if(pDaily, 'DAILY ','MONTHLY REAPPEND ');

Export WU_NAME				      			:= 'IDA ' + period + 'BUILD';
Export WU_VERSION 							:= WU_NAME + ' ' + version;
Export SCHEDULER_NAME 						:= WU_NAME + ' SCHEDULER';
Export EVENT_NAME     						:= WU_NAME + ' EVENT';


sDaily                 						:= if(pDaily, 'true','false');
sUseProd                                    := if(pUseProd,'TRUE','FALSE');

IDA_BASE_REAPPEND_ECL                       := 'do:=SEQUENTIAL(\nIDA._BWR_Consolidate_And_Did_Reappend(\''+version+'\','+sUseProd+')\n);\n';
IDA_DAILY_SPRAY_ECL                         := 'do:=SEQUENTIAL(\nIDA._BWR_Build(\''+version+'\','+sUseProd+')\n);\n';


PROCESS_ECL 				                := Case(pProcessName, 
														'IDA BUILD'        => IDA_DAILY_SPRAY_ECL,
														'IDA REAPPEND'     => IDA_BASE_REAPPEND_ECL,'');

DO_SEQUENTIAL_ECL                           := Case(pProcessName,
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