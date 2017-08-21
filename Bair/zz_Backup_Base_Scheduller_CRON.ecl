import Bair, ut,wk_ut,std;

lastBuiltFileNameInProcess := '~thor_data400::out::bair::backup::last_base_manifest_inprogress';
versionToBackupD := dataset(lastBuiltFileNameInProcess,Bair._Constant.manifest_layout, THOR,OPT);
pVersion  := STD.Str.RemoveSuffix(versionToBackupD[1].version,' ');

ECL:=
'#stored(\'cluster\',\'bair-dr\');\n'
+'#stored(\'did_add_force\',\'thor\');\n'
+'#option(\'hdCompressorType\', \'NONE\');\n'
+'#OPTION(\'multiplePersistInstances\',FALSE);\n'
+'#option(\'maxCsvRowSizeMb\', 90);\n'

+'wuname := \'Bair Backup Base - '+pVersion+'\';\n'
+'#WORKUNIT(\'name\', wuname);\n'
+'Bair.Backup_base.CopyUpdateBaseDR();\n'
;

#WORKUNIT('protect',true);
#WORKUNIT('name', 'Bair Backup Base Scheduler');
wk_ut.CreateWuid(ECL,'hthor',Bair._Constant.cronIP) : when('Bair Backup Base Scheduler')
														 ,FAILURE(fileservices.sendemail('fernando.incarnacao@lexisnexis.com;debendra.kumar@lexisnexis.com;jose.bello@lexisnexis.com;'
														         ,'Bair Backup Base Scheduler'
																		 ,'Bair Backup Base Scheduler failure\n'
																		 +'Bair Backup Base Scheduler \n'
																		 +'See '+workunit+'\n\n'
																		 +FAILMESSAGE
																		 ));		