﻿import wk_ut,_Control,std;

EXPORT _CRON_ECL(string pProcessName = '', boolean isFCRA = false, boolean pDaily = true, string pVersion='')  := Module

shared version 										:= if(pVersion='',(string8)std.date.today(),pVersion):INDEPENDENT;
shared fcra_nonfcra_groupname			:= if(isFCRA, INQL_v2._Constants.FCRA_THOR, INQL_v2._Constants.NONFCRA_THOR);
shared fcra_nonfcra 							:= if(pProcessName='PRODR3 EXTRACT',' ',if(isFCRA, ' FCRA ',' NONFCRA '));
shared period            					:= if(pDaily, 'DAILY ','WEEKLY ');

Export WU_NAME				      			:= 'INQL' + fcra_nonfcra + period + pProcessName;
Export WU_VERSION 								:= WU_NAME + ' ' + version;
Export SCHEDULER_NAME 						:= WU_NAME + ' SCHEDULER';
Export EVENT_NAME     						:= WU_NAME + ' EVENT';


sDaily                 						:= if(pDaily, 'true','false');
sFCRA                  						:= if(isFCRA, 'true','false');

notify_prodr3_fcra          := '\'notify(\\\'INQL FCRA DAILY BATCHR3 BUILD EVENT\\\', \\\'*\\\')\'';
notify_prodr3_nonfcra       := '\'notify(\\\'INQL NONFCRA DAILY BATCHR3 BUILD EVENT\\\', \\\'*\\\')\'';
PRODR3_EXTRACT_ECL       		:= 'INQL_v2.proc_ProdR3Monitoring.SuperMove,\n'+
							 	'INQL_v2.proc_ProdR3Monitoring.Separate_R3_Records,\n'+
								'wk_ut.CreateWuid('+notify_prodr3_nonfcra+',INQL_V2._Constants.NONFCRA_THOR, INQL_V2._Constants.NON_FCRA_ESP),\n'+
								'wk_ut.CreateWuid('+notify_prodr3_fcra+',INQL_V2._Constants.FCRA_THOR, INQL_V2._Constants.FCRA_ESP)\n';				

BATCHR3_BUILD_ECL           	:= 'Inquiry_Acclogs.FN_FileMoves.R3Monitoring(' + sFCRA + ');\n';     
FILES_SPRAY_ECL             	:= if (isFCRA, 'INQL_v2.fspray_fcra_daily_files._spray;\n', 'INQL_v2.fspray_nonfcra_daily_files._spray;\n');
FILES_SCRUB_ECL            		:= 'INQL_V2.proc_FilesScrub('+ sFCRA + ');\n';
BASE_BUILD_ECL              	:= 'INQL_V2.proc_BuildBases(,' + sFCRA + ',' + sDaily + ');\n';
BASE_PREP_ECL   							:= 'INQL_V2.proc_BuildBases_prep(' + sFCRA + ').daily;\n';
BASE_POST_ECL   							:= 'INQL_V2.proc_BuildBases_post(' + sFCRA + ');\n';
BASE_DIDVILLE_BUILD_ECL     	:= 'INQL_V2.proc_BuildBases(,' + sFCRA + ',' + sDaily + ', true);\n';
BASE_DIDVILLE_SLIM_BUILD_ECL  := 'Inquiry_AccLogs.fnMapBaseAppendsJennyNew(,,true).Do_Appends;\n';
KEYS_BUILD_ECL 								:= 'INQL_V2.proc_BuildKeys(,'+ sFCRA + ',' + sDaily + ',true);\n';
STATS_REPORTS_ECL      				:= if(isFCRA,'Inquiry_AccLogs._SCH_FCRAComprehensiveStats;\n'
                                  				,'Inquiry_AccLogs._SCH_NonFCRAComprehensiveStats;\n');
FILES_CONSOLIDATE_ECL         := INQL_v2.proc_FilesConsolidate(isFCRA).ecl;
FIDO_REPORT_ECL               := 'do:=SEQUENTIAL(\nINQL_V2.FIDO_Change_Report.SendFIDOchangesRep;\n);\n';

PROCESS_ECL 				:= Case(pProcessName, 
														'PRODR3 EXTRACT' 						=> PRODR3_EXTRACT_ECL, 			
														'BATCHR3 BUILD' 						=> BATCHR3_BUILD_ECL, 			
														'FILES SPRAY' 							=> FILES_SPRAY_ECL, 
														'FILES SCRUB' 							=> FILES_SCRUB_ECL,	
														'BASE PREP' 								=> BASE_PREP_ECL, 
														'BASE POST' 								=> BASE_POST_ECL, 																		
														'BASE BUILD' 								=> BASE_BUILD_ECL,
														'BASE DIDVILLE BUILD' 			=> BASE_DIDVILLE_BUILD_ECL,
														'BASE DIDVILLE SLIM BUILD' 	=> BASE_DIDVILLE_SLIM_BUILD_ECL,														
														'KEYS BUILD' 								=> KEYS_BUILD_ECL,
														'STATS REPORTS' 						=> STATS_REPORTS_ECL,
														'FILES CONSOLIDATE'         => FILES_CONSOLIDATE_ECL,
														'FIDO CHANGE REPORT'        => FIDO_REPORT_ECL,'');

DO_SEQUENTIAL_ECL   := Case(pProcessName,
                            'FILES CONSOLIDATE'         => PROCESS_ECL,
														'FIDO CHANGE REPORT'        => PROCESS_ECL,
														'DO:= SEQUENTIAL(\n'+PROCESS_ECL+');\n');

Export WU := 
'import std, PromoteSupers, wk_ut;\n'
+'#WORKUNIT(\'name\',\'' + WU_VERSION + '\');\n'
+'#option(\'maxCsvRowSizeMb\', 90);\n'
+ DO_SEQUENTIAL_ECL
+'dont:=output(\''+ WU_NAME + ' is already RUNNING\');\n'
+'active_workunit := INQL_v2.GetActiveWU(\'' + WU_NAME + '\');\n'
+'_process := if(active_workunit = false,do,dont);\n'
+'_process;';


end;
