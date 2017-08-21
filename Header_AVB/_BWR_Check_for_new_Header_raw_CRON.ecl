// Header_AVB._BWR_Check_for_new_Header_raw_CRON

elist:=
				 'jose.bello@lexisnexis.com'
				+',gabriel.marcan@lexisnexis.com'
				+',aleida.lima@lexisnexis.com'
				+',manish.shah@lexisnexis.com'
				+',steve.stockton@lexisnexis.com'
				+',Cody.Fouts@lexisnexis.com'
				+',michel.gould@lexisnexis.com'
				+',heather.sherrington@lexisnexis.com'
				;

envVars :=
 '#WORKUNIT(\'priority\',\'high\');\n'
+'wuname := \'Create Raw Header Stats\';\n'
+'#WORKUNIT(\'name\', wuname);\n'
+'#OPTION(\'AllowedClusters\',\'thor400_60 ,thor400_30 ,thor400_20\');\n\n'
+'elistDev:=\n'
+'				 \'jose.bello@lexisnexis.com\'\n'
+'				 +\',gabriel.marcan@lexisnexis.com\'\n'
+'         +\',michael.gould@lexisnexis.com\'\n'
+'         +\',manish.shah@lexisnexis.com\'\n'
+'         +\',aleida.lima@lexisnexis.com\'\n'
+'         +\',Cody.Fouts@lexisnexis.com\'\n'
+'         +\',steven.stockton@lexisnexis.com\'\n'
+'         +\',Gavin.Witz@lexisnexis.com\'\n'
+'         +\',heather.sherrington@lexisnexis.com\'\n'
+'				;\n\n'
;

lECL1 :=
envVars
+'email(string msg):=fileservices.sendemail(\n'
+'																					elistDEV\n'
+'																					,\'Raw Header Stats\'\n'
+'																					,msg\n'
+'																					+\'Build wuid \'+workunit\n'
+'																					+FAILMESSAGE\n'
+'																					);\n\n'
+'header_avb.Stat.build_file\n'
+'	: success(email(\'Completed, a new header_raw is ready for transfer to Alpharetta\\n\\n\'))\n'
+'	, failure(email(\'failed\\n\\n\'))\n'
+'	;\n'
+'// This process detects a new header_raw and creates new stats\n'
+'// The new stats file version is used in Alpharetta to detect/trigger\n'
+'// whether a new header_raw needs to be copyed to Alpharetta\n'
+'// Estimated THOR time: 20Min\n'
;

import _Control;
#WORKUNIT('protect',true);
ThorName:=if(_Control.ThisEnvironment.Name='Dataland','thor40_241_7','thor400_60');

// daily_at_8PM:='0 22 * * *';
// #WORKUNIT('name','Create Raw Header Stats - on SCHEDULE');
// _Control.fSubmitNewWorkunit(lECL1, ThorName ) : WHEN(CRON(daily_at_8PM))
																								// ,FAILURE(fileservices.sendemail(elist
																												// ,'Boca Header AVB Stats schedule failure'
																												// ,'Boca Header AVB Stats schedule failure\n'
																												// +'Boca Header AVB Stats schedule failure\n'
																												// +'See '+workunit+'\n\n'
																												// +FAILMESSAGE
																												// ));

#WORKUNIT('name','PersonHeader: Create Raw Header Stats - on NOTIFY');
_Control.fSubmitNewWorkunit(lECL1, ThorName ) : WHEN('Create_Raw_Header_Stats')
																								,FAILURE(fileservices.sendemail(elist
																												,'Boca Header AVB Stats schedule failure'
																												,'Boca Header AVB Stats schedule failure\n'
																												+'Boca Header AVB Stats schedule failure\n'
																												+'See '+workunit+'\n\n'
																												+FAILMESSAGE
																												));