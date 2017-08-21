import _Control;

CurFull := dataset(bair.Superfile_List().FullBuiltVers, bair.layouts.rBuiltVers, flat);
version := CurFull[1].ver;

ECL:=
 '#option(\'hdCompressorType\', \'NONE\');\n'
+'#option(\'maxCsvRowSizeMb\', 90);\n'
+'#stored(\'did_add_force\',\'thor\');\n'
+'#stored(\'cluster\',\'bair-qa\');\n'
+'wuname := \'Bair COMPOSITE Full Build and Deploy: ' + version + '\';\n'
+'#WORKUNIT(\'name\', wuname);\n'
+'seq := sequential(Bair_composite.Build_All(\'' + version + '\',false, false),\n'
+'									Bair.UpdateBuildSegments(3, false, false),\n'
+'									Bair.UpdateBuildSegments(4, false, false),\n'
+'									Bair.post_BuiltVers(\'' + version + '\').PSFull,\n'
+'									Bair.proc_pkgDelpoy(\'bair-qa\',\'' + version + '\', false, false).PSKeys,\n'
+'									Bair.proc_pkgDelpoy(\'bair-prod\',\'' + version + '\', true, false).PSKeys,\n'
+'								 )'
+'								 : success(Bair.Send_Email(\'' + version + '\', false, false).CompositeBuildSuccess)\n'
+'								  ,failure(Bair.send_email(\'' + version + '\', false, false).CompositeBuildFailure)\n'
+'								;\n'
+'seq;\n'
;

ESP:=if(_Control.ThisEnvironment.ThisDaliIp = _Control.IPAddress.bair_DR_dali, _Control.IPAddress.bair_DR_ESP, _Control.IPAddress.bair_prod_ESP);
THOR:='thor40';
import wk_ut;
#WORKUNIT('protect',true);
#WORKUNIT('name', 'Bair Composite Full Build Scheduler');
wk_ut.CreateWuid(ECL,THOR,ESP) : WHEN('bld_and_deploy_compositekeys_full')
														,FAILURE(fileservices.sendemail('fernando.incarnacao@lexisnexis.com;debendra.kumar@lexisnexis.com;jose.bello@lexisnexis.com;'
																		,'Bair Composite Full Build Schedule'
																		,'Bair Composite Full Build Schedule failure\n'
																		+'Bair Composite Full Build Schedule failure\n'
																		+'See '+workunit+'\n\n'
																		+FAILMESSAGE
																		));