import dops,header,std,_control;
#workunit('name','Start Watchdog Marketing build');
 
ECL1 := 

'#option(\'multiplePersistInstances\',FALSE);\n'
+'#workunit(\'protect\', \'true\');\n'
+'#workunit(\'name\', \'Watchdog Marketing  Build '+(STRING8)Std.Date.Today()+ '\');\n'
+'#workunit(\'priority\', \'high\');\n'
+'Sequential(Watchdog.proc_build_marketing_noneq,Watchdog.proc_build_marketing);\n' ;



//**Get WU List


getwulist := workunitservices.WorkunitList ( lowwuid := '',jobname := 'Watchdog key*' ,username := 'mgould_prod');

getnew := topn( sort ( getwulist,-wuid),1,-wuid );


validate_statecount := count(getnew ( state = 'completed' ));

statusemail := FileServices.sendemail('michael.gould@lexisnexisrisk.com,sudhir.kasavajjala@lexisnexis.com','Watchdog Job Update' +(STRING8)Std.Date.Today(), 'Watchdog Marketing build is on hold due to : 1 previous WU not in completed state or '+'\n'+' 2: Last build was not  deployed to cert .Please view '+getnew[1].wuid);


LaunchJobs := Sequential(_control.fSubmitNewWorkunit(ECL1, _Control.Config.GroupName('36')));
												

Sequential( std.system.debug.sleep(300000), if ( validate_statecount = 1  ,Sequential(LaunchJobs) ,Sequential('Watchdog Marketing build is on hold ',statusemail)  )) : when(event ('Watchdog Marketing build can progress','*'));



