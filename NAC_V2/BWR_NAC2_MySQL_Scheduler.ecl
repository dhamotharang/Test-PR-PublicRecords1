

IMPORT NAC_V2, std, _Control;

envVars :=
 '#WORKUNIT(\'protect\',true);\n'
+'#WORKUNIT(\'priority\',\'high\');\n'
+'#WORKUNIT(\'priority\',11);\n'
+'#OPTION(\'AllowedClusters\',\'thor400_44_sla_eclcc,thor400_44_eclcc\');\n'
+'#OPTION(\'AllowAutoQueueSwitch\',\'1\');\n'
+'wuname := \'NAC2 MySQL Insert Scheduler\';\n'
+'#WORKUNIT(\'name\', wuname);\n';

ThorName := 'thor400_44_sla_eclcc';		// for prod

lECL1 :=
envVars
+'SEQUENTIAL(NAC_V2.MOD_NAC2_MySQL.NCF2_load, NAC_V2.MOD_NAC2_MySQL.MSH2_load, NAC_V2.MOD_NAC2_MySQL.MSX2_load);\n';

 every_day_8pm := '0 0 20 * * ?';

 _Control.fSubmitNewWorkunit(lECL1, ThorName) : WHEN(CRON(every_day_8pm));
 

