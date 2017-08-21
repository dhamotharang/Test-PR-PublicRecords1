import _Control;

CurDelta 		:= dataset(bair.Superfile_List().DeltaBuiltVers,bair.layouts.rBuiltVers, flat);
version 		:= CurDelta[1].ver;
buildName 	:= CurDelta[1].buildName;

ECL:=
 '#option(\'hdCompressorType\', \'NONE\');\n'
+'#OPTION(\'multiplePersistInstances\',FALSE);\n'
+'#option(\'maxCsvRowSizeMb\', 90);\n'
+'#stored(\'cluster\',\'bair-qa\');\n'
+'wuname := \'Bair COMPOSITE Delta Build and Deploy: ' + version + '\';\n'
+'#WORKUNIT(\'name\', wuname);\n'
+'seq := sequential(Bair_composite.Build_All(\'' + version + '\',false, true),\n'
+'									Bair.UpdateBuildSegments(3, false, true),\n'
+'									Bair.UpdateBuildSegments(4, false, true),\n'
+'									Bair.proc_pkgDelpoy(\'bair-qa\',\'' + version + '\', false, true).PSKeys,\n'
+'									Bair.proc_pkgDelpoy(\'bair-prod\',\'' + version + '\', true, true).PSKeys,\n'
+'									Bair.Orbit_Update. UpdateSplitBuildOrbitStatus (\'' + buildName + '\',\'' + version + '\', \'Built\',\'COMPOSITE\'),\n'
+'								 )'
+'								 : success(Bair.Send_Email(\'' + version + '\', false, true).CompositeBuildSuccess)\n'
+'								  ,failure(Bair.send_email(\'' + version + '\', true, true).CompositeBuildFailure)\n'
+'								;\n'
+'seq;\n'
;

ESP:=if(_Control.ThisEnvironment.ThisDaliIp = _Control.IPAddress.bair_DR_dali, _Control.IPAddress.bair_DR_ESP, _Control.IPAddress.bair_prod_ESP);
THOR:='thor40';
import wk_ut;
#WORKUNIT('protect',true);
#WORKUNIT('name', 'Bair Composite Delta Build Scheduler');
wk_ut.CreateWuid(ECL,THOR,ESP) : WHEN('bld_and_deploy_compositekeys_delta')
														,FAILURE(fileservices.sendemail('fernando.incarnacao@lexisnexis.com;debendra.kumar@lexisnexis.com;jose.bello@lexisnexis.com;'
																		,'Bair Composite Delta Build Schedule'
																		,'Bair Composite Delta Build Schedule failure\n'
																		+'Bair Composite Delta Build Schedule failure\n'
																		+'See '+workunit+'\n\n'
																		+FAILMESSAGE
																		));