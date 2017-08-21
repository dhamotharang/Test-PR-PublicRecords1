import _Control;

CurFull 		:= dataset(bair.Superfile_List().FullBuiltVers, bair.layouts.rBuiltVers, flat);
version 		:= CurFull[1].ver;

ECL:=
 '#option(\'hdCompressorType\', \'NONE\');\n'
+'#option(\'maxCsvRowSizeMb\', 90);\n'
+'#stored(\'cluster\',\'bair-qa\');\n'

+'wuname := \'Bair BOOLEAN Full Build and Deploy: ' + version + '\';\n'
+'#WORKUNIT(\'name\', wuname);\n'
+'seq := sequential(bair_boolean.proc_build_boolean_keys(\'' + version + '\', false),\n'
+'									Bair.UpdateBuildSegments(5, false, false),\n'
+'									Bair.post_BuiltVers(\'' + version + '\').NonPSFull,\n'
+'									Bair.proc_pkgDelpoy(\'bair-qa\',\'' + version + '\', false, false).NonPSKeys,\n'
+'									Bair.proc_pkgDelpoy(\'bair-prod\',\'' + version + '\', true, false).NonPSKeys,\n'
+'								 )'
+'								 : success(Bair.Send_Email(\'' + version + '\', false, false).BooleanBuildSuccess)\n'
+'								  ,failure(Bair.send_email(\'' + version + '\', false, false).BooleanBuildFailure)\n'
+'								;\n'
+'seq;\n'
;

ESP:=if(_Control.ThisEnvironment.ThisDaliIp = _Control.IPAddress.bair_DR_dali, _Control.IPAddress.bair_DR_ESP, _Control.IPAddress.bair_prod_ESP);
THOR:='thor40';
import wk_ut;
#WORKUNIT('protect',true);
#WORKUNIT('name', 'Bair Boolean Full Build Scheduler');
wk_ut.CreateWuid(ECL,THOR,ESP) : WHEN('bld_and_deploy_booleankeys_full')
														,FAILURE(fileservices.sendemail('fernando.incarnacao@lexisnexis.com;debendra.kumar@lexisnexis.com;jose.bello@lexisnexis.com;'
																		,'Bair Boolean Full Build Schedule'
																		,'Bair Boolean Full Build Schedule failure\n'
																		+'Bair Boolean Full Build Schedule failure\n'
																		+'See '+workunit+'\n\n'
																		+FAILMESSAGE
																		));