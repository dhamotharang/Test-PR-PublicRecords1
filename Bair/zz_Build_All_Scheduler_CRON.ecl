import Bair, ut,wk_ut,std;

bair_build_name_version   := Bair.Orbit_Update.BairBuildReadyToGo():independent;
bair_build_name           := STD.STr.SplitWords(bair_build_name_version,' ')[1];
bair_build_version        := STD.STr.SplitWords(bair_build_name_version,' ')[2];
bair_reprocess_flag       := STD.STr.SplitWords(bair_build_name_version,' ')[3];

//run_bair_build    := if(bair_build_version !='','true','false');
bair_build_to_run    			:= if(bair_build_version !='','true','false');

agency_build_name_version := Bair.Orbit_Update.AgencyBuildReadyToGo():independent;
agency_build_name         := STD.STr.SplitWords(agency_build_name_version,' ')[1];
agency_build_version      := STD.STr.SplitWords(agency_build_name_version,' ')[2];
ag_wuname := 'Bair DELTA Build All - AGENCIES '+agency_build_version+'*?';
dag := sort(nothor(WorkunitServices.WorkunitList('',NAMED jobname:=ag_wuname))(wuid <> thorlib.wuid()), -wuid);
agency_build_wu_exist := exists(dag);
agency_build_to_run       := if(bair_build_to_run = 'false' and agency_build_name_version !='' and agency_build_wu_exist = false,'true','false');

build_to_run              := if(bair_build_to_run = 'true' or agency_build_to_run = 'true', 'true', 'false');

valid_state := ['blocked','running','wait','submitted','compiling','compiled'];
prep_wuname := 'Bair Importer - Importing*?';
d := sort(nothor(WorkunitServices.WorkunitList('',NAMED jobname:=prep_wuname))(wuid <> thorlib.wuid() and state in valid_state), -wuid);
d_wu := d[1].wuid;
active_workunit_prep :=  exists(d);

// run_bair_build            := if(bair_build_to_run and active_workunit_prep = false,'true','false');
// run_agency_build          := if(agency_build_to_run and active_workunit_prep = false,'true','false');

// run_build                 := if(run_agency_build ='true' or run_bair_build = 'true', 'true', 'false');

run_build                 := if(build_to_run = 'true' and active_workunit_prep = false,'true','false');

build_name         				:= if(bair_build_to_run='true',bair_build_name, agency_build_name);
build_version       			:= if(bair_build_to_run='true',bair_build_version, agency_build_version);
scheduler_type            := if(bair_build_to_run='true','BAIR','AGENCIES');

scheduler_title           := if(run_build = 'true' , ' - ' + scheduler_type + ' ' +  build_version + ' ' + bair_reprocess_flag,' - NO BUILD'); 

ECL:=
'#option(\'hdCompressorType\', \'NONE\');\n'
+'#option(\'maxCsvRowSizeMb\', 90);\n'

+'STRING pDate 						:= ut.GetDate:INDEPENDENT;\n'
+'STRING pTime 						:= ut.GetTimeStamp():INDEPENDENT;\n'
+'STRING pVersion 				:= pDate + \'_\' + pTime;\n'
+'tVersion := \'t\' + pVersion;\n'

+'pUseProd 	:= false;\n'

+'sentinel_Flag             := if(\'' + build_to_run + '\'=\'true\', Bair_importer.Sentinel_Flag.fn_SetBairSentinelFlag(TRUE,tVersion,TRUE));\n'
+'sentinel_Flag;\n'

+'wuname := \'Bair DELTA Build All\'+\'' + scheduler_title + '\';\n'
+'#WORKUNIT(\'name\', wuname);\n'

+'IsUpdates 								:= if(regexfind(\'w|W\',\''+ build_version + '\') = true, false, true);\n'
+'building                  := if (\'' + run_build + '\' = \'true\', \n'
+'																	Sequential(Bair.Orbit_Update.SetOrbitForBuildAll(\''+build_name+'\',\''+build_version+'\',\''+bair_reprocess_flag+'\')\n'
+'																						,Bair.Build_All(\''+ build_name + ' ' + agency_build_version + '\',\''+build_version + '\', pUseProd,IsUpdates);\n'
+'																						),\n'
+'													        output(\'nothing\')\n'
+'															   );\n'
+'building;\n'
;

sthor := if(run_build='true','thor40','hthor');
#WORKUNIT('protect',true);
#WORKUNIT('name', 'Bair Build All Scheduler');

wk_ut.CreateWuid(ECL,sthor,Bair._Constant.cronIP) : when('Bair Build All Scheduler')
														 ,FAILURE(fileservices.sendemail('fernando.incarnacao@lexisnexis.com;debendra.kumar@lexisnexis.com;jose.bello@lexisnexis.com;'
														         ,'Bair Build All Scheduler'
																		 ,'Build All Scheduler failure\n'
																		 +'Build All Scheduler \n'
																		 +'See '+workunit+'\n\n'
																		 +FAILMESSAGE
																		 ));			