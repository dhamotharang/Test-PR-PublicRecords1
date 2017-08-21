import ut,wk_ut;
//Version := ut.GetDate;
Version := '20150928';

ECL:=

'wuname := \'Orbit_Build_All\';\n'
+ '#WORKUNIT(\'name\', wuname);\n'

+'valid_state := [\'blocked\',\'running\',\'wait\'];\n'
+'d := sort(nothor(WorkunitServices.WorkunitList(\'\',,,wuname,\'\'))(wuid <> thorlib.wuid() and job = wuname and state in valid_state), -wuid);\n'
+'d_wu := d[1].wuid;\n'
+'active_workunit :=  exists(d);\n'
+'if(active_workunit = false, bair.Orbit_Module_Builts.Build_All(\''+Version+'\'));\n'
;

 
#WORKUNIT('protect',true);
#WORKUNIT('name', 'Bair Contributory Build catch-up');
wk_ut.CreateWuid(ECL,'thor40','10.240.32.15') : when(cron('0 * * * *'))
														,FAILURE(fileservices.sendemail('oscar.barrientos@lexisnexis.com'
																		,'Bair Contributory Build schedule failure'
																		,'schedule failure\n'
																		+'schedule failure\n'
																		+'See '+workunit+'\n\n'
																		+FAILMESSAGE
																		));						
