import _Control;

CurDelta 		:= dataset(bair.Superfile_List().DeltaBuiltVers, bair.layouts.rBuiltVers, flat);
version 		:= CurDelta[1].ver;
buildName 	:= CurDelta[1].buildName;

ECL:=
 '#option(\'hdCompressorType\', \'NONE\');\n'
+'#option(\'maxCsvRowSizeMb\', 90);\n'
+'#stored(\'cluster\',\'bair-qa\');\n'

+'wuname := \'Bair BOOLEAN Delta Build and Deploy: ' + version + '\';\n'
+'#WORKUNIT(\'name\', wuname);\n'
+'seq := sequential(bair_boolean.proc_build_boolean_keys(\'' + version + '\', true),\n'
+'									Bair.UpdateBuildSegments(5, false, true),\n'
+'									Bair.proc_pkgDelpoy(\'bair-qa\',\'' + version + '\', false, true).NonPSKeys,\n'
+'									Bair.proc_pkgDelpoy(\'bair-prod\',\'' + version + '\', true, true).NonPSKeys,\n'
+'									Bair.Orbit_Update. UpdateSplitBuildOrbitStatus (\'' + buildName + '\',\'' + version + '\', \'Built\'),\n'
+'								 )'
+'								 : success(Bair.Send_Email(\'' + version + '\', false, true).BooleanBuildSuccess)\n'
+'								  ,failure(Bair.send_email(\'' + version + '\', false, true).BooleanBuildFailure)\n'
+'								;\n'
+'seq;\n'
;

ESP:=if(_Control.ThisEnvironment.ThisDaliIp = _Control.IPAddress.bair_DR_dali, _Control.IPAddress.bair_DR_ESP, _Control.IPAddress.bair_prod_ESP);
THOR:='thor40';
import wk_ut;
#WORKUNIT('protect',true);
#WORKUNIT('name', 'Bair Boolean Delta Build Scheduler');
wk_ut.CreateWuid(ECL,THOR,ESP) : WHEN('bld_and_deploy_booleankeys_delta')
														,FAILURE(fileservices.sendemail('fernando.incarnacao@lexisnexis.com;debendra.kumar@lexisnexis.com;jose.bello@lexisnexis.com;'
																		,'Bair Boolean Delta Build Schedule'
																		,'Bair Boolean Delta Build Schedule failure\n'
																		+'Bair Boolean Delta Build Schedule failure\n'
																		+'See '+workunit+'\n\n'
																		+FAILMESSAGE
																		));