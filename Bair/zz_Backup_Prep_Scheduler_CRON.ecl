import Bair, ut,wk_ut,std;

lastBuiltFileNameInProcess := '~thor_data400::out::bair::backup::last_prep_manifest_inprogress';
versionToBackupD := dataset(lastBuiltFileNameInProcess,Bair._Constant.manifest_layout, THOR,OPT);
pVersion  := STD.Str.RemoveSuffix(versionToBackupD[1].version,' ');

ECL:=
'#stored(\'cluster\',\'bair-dr\');\n'
+'#stored(\'did_add_force\',\'thor\');\n'
+'#option(\'hdCompressorType\', \'NONE\');\n'
+'#OPTION(\'multiplePersistInstances\',FALSE);\n'
+'#option(\'maxCsvRowSizeMb\', 90);\n'

+'wuname := \'Bair Backup Prep - '+pVersion+'\';\n'
+'#WORKUNIT(\'name\', wuname);\n'
+'Bair.Backup_Prep.CopyUpdatePrepDR();\n'
;

#WORKUNIT('protect',true);
#WORKUNIT('name', 'Bair Backup Prep Scheduler');
wk_ut.CreateWuid(ECL,'hthor','10.240.160.19') : when('Bair Backup Prep Scheduler')
														 ,FAILURE(fileservices.sendemail('fernando.incarnacao@lexisnexis.com;debendra.kumar@lexisnexis.com;jose.bello@lexisnexis.com;'
														         ,'Bair Backup Prep Scheduler'
																		 ,'Bair Backup Prep Scheduler failure\n'
																		 +'Bair Backup Prep Scheduler \n'
																		 +'See '+workunit+'\n\n'
																		 +FAILMESSAGE
																		 ));		