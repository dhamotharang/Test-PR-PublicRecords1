// Code for job is maintained in Header_AVB._BWR_Check_for_new_Header_raw_CRON
import _Control,header;

elist:=

        'gabriel.marcan@lexisnexisrisk.com'
        +',Cody.Fouts@lexisnexisrisk.com'
        +',Gavin.Witz@lexisnexisrisk.com'
        +',Ayeesha.Kayttala@lexisnexisrisk.com'
        +',jose.bello@lexisnexisrisk.com'
        +',aleida.lima@lexisnexisrisk.com'
        +',manish.shah@lexisnexisrisk.com'
        +',michael.gould@lexisnexisrisk.com'
				+',heather.sherrington@lexisnexis.com'
				;

envVars :=
 '#WORKUNIT(\'priority\',\'high\');\n'
+'wuname := \'Create Raw Header Stats: \'+header.version_build;\n'
+'#WORKUNIT(\'name\', wuname);\n'
+'#OPTION(\'AllowedClusters\',\'thor400_66 ,thor400_44\');\n\n'
+'elistDev:=\''+elist+'\';\n\n';
;

lECL1 :=
envVars
+'send_email(string msg):=fileservices.sendemail(\n'
+'																					elistDEV\n'
+'																					,\'Raw Header Stats\'\n'
+'																					,msg\n'
+'																					+\'Build wuid \'+workunit\n'
+'																					+FAILMESSAGE\n'
+'																					);\n\n'
+'stats:= Header_AVB.Stat(false,\''+header.version_build+'\').build_file(elistDev)\n'
+'	: success(send_email(\'Completed, a new header_raw is ready for transfer to Alpharetta\\n\\n\'))\n'
+'	, failure(send_email(\'failed\\n\\n\'))\n'
+'	;\n'
+'sequential(stats, _control.fSubmitNewWorkunit(\'Relative_AVB.BWR_proc_BuildData\',\'thor400_66\'))'
+'	;\n'
+'// This process detects a new header_raw and creates new stats\n'
+'// The new stats file version is used in Alpharetta to detect/trigger\n'
+'// whether a new header_raw needs to be copyed to Alpharetta\n'
+'// Estimated THOR time: 20Min\n'
;


#WORKUNIT('protect',true);
ThorName:=if(_Control.ThisEnvironment.Name='Dataland','thor40_241_7','thor400_66');

#WORKUNIT('name','PersonHeader: Create Raw Header Stats - on NOTIFY');
_Control.fSubmitNewWorkunit(lECL1, ThorName ) : WHEN('Create_Raw_Header_Stats')
																								,FAILURE(fileservices.sendemail(elist
																												,'Boca Header AVB Stats schedule failure'
																												,'Boca Header AVB Stats schedule failure\n'
																												+'Boca Header AVB Stats schedule failure\n'
																												+'See '+workunit+'\n\n'
																												+FAILMESSAGE
																												));
