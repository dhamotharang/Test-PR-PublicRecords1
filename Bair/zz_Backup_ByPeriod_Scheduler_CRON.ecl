import Bair, ut,wk_ut,std;

period_manifest_fileName    := '~thor_data400::out::bair::backup::last_byperiod_manifest_inprogress';
manifestList         	 			:= dataset(period_manifest_filename, Bair._Constant.manifest_layout, thor) : GLOBAL(FEW);
pVersion  									:= STD.Str.RemoveSuffix(manifestList[1].version,' ');

ECL:=
'#stored(\'cluster\',\'bair-dr\');\n'
+'#stored(\'did_add_force\',\'thor\');\n'
+'#option(\'hdCompressorType\', \'NONE\');\n'
+'#OPTION(\'multiplePersistInstances\',FALSE);\n'
+'#option(\'maxCsvRowSizeMb\', 90);\n'

+'wuname := \'Bair Backup ByPeriod - '+pVersion+'\';\n'
+'#WORKUNIT(\'name\', wuname);\n'
+'Bair.Backup_ByPeriod.CopyUpdateByPeriodDR();\n'
;
ECL;
#WORKUNIT('protect',true);
#WORKUNIT('name', 'Bair Backup ByPeriod Scheduler');
wk_ut.CreateWuid(ECL,'hthor',Bair._Constant.cronIP) : when('Bair Backup ByPeriod Scheduler')
														 ,FAILURE(fileservices.sendemail('fernando.incarnacao@lexisnexis.com;debendra.kumar@lexisnexis.com;jose.bello@lexisnexis.com;'
														         ,'Bair Backup ByPeriod Scheduler'
																		 ,'Bair Backup ByPeriod Scheduler failure\n'
																		 +'Bair Backup ByPeriod Scheduler \n'
																		 +'See '+workunit+'\n\n'
																		 +FAILMESSAGE
																		 ));		