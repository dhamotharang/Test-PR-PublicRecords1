import wk_ut,_Control,std;

EXPORT _CRON_ECL(string pProcessName = '',boolean pUseProd = false, boolean pDaily = true, string pVersion='')  := Module

EXPORT version 								:= IDA._Constants(pUseProd).filesdate;
EXPORT monthlyversion                       := IDA._Constants(pUseProd).monthlyversion;
EXPORT groupname		                	:= if(pUseProd, IDA._Constants(pUseProd).PROD_THOR, IDA._Constants(pUseProd).DATALAND_THOR);
EXPORT period            					:= if(pDaily, 'DAILY ','MONTHLY ');

Export build                                := if(pDaily,'DAILY BUILD',IF(pProcessName='IDA HEADER FLAG','HEADER FLAG FILE BUILD', 'MONTHLY BUILD'));
Export WU_NAME				      			:= 'IDA ' + build ;
Export WU_VERSION 							:= WU_NAME + ' ' + IF(pProcessName='IDA REAPPEND',monthlyversion, version);
Export SCHEDULER_NAME 						:= WU_NAME + ' SCHEDULER';
Export EVENT_NAME     						:= WU_NAME + ' EVENT';


sDaily                 						:= if(pDaily, 'true','false');
sUseProd                                    := if(pUseProd,'TRUE','FALSE');

IDA_BASE_REAPPEND_ECL                       := 'do:=SEQUENTIAL(\nIDA._BWR_Consolidate_And_Did_Reappend(\''+monthlyversion+'\','+sUseProd+')\n);\n';
IDA_HEADER_FLAG_ECL                         := 'do:=SEQUENTIAL(\nIDA._BWR_BuildHeaderFlagFile(\''+version+'\','+sUseProd+')\n);\n';
IDA_DAILY_SPRAY_ECL                         := 'do:=SEQUENTIAL(\nIDA._BWR_Build(\''+version+'\','+sUseProd+')\n);\n';



PROCESS_ECL 				                := Case(pProcessName, 
														'IDA BUILD'        => IDA_DAILY_SPRAY_ECL,
														'IDA HEADER FLAG'  => IDA_HEADER_FLAG_ECL,
														'IDA REAPPEND'     => IDA_BASE_REAPPEND_ECL,'');

DO_SEQUENTIAL_ECL                           := Case(pProcessName,
														'IDA BUILD'         => PROCESS_ECL,
														'IDA HEADER FLAG'   => PROCESS_ECL,
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