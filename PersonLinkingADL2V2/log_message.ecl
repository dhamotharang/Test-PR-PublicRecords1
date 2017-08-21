import lib_workunitservices, personlinkingADL2V2;
export log_message (string jobname):= function

notificationlist:='wenhong.ma@lexisnexis.com; charles.morton@lexisnexis.com';
	
valid_state := [//'blocked','compiled','submitted','running', 
                'completed'];

//workunit list
d := sort(WorkunitServices.WorkunitList('',,,'',jobname)(wuid <> thorlib.wuid() and state in valid_state), -wuid);

workunit_list := output(d, named('workunit_list'));

complete_workunit := count(d) > 0;

//capture total thor time
wuid_input := d[1].wuid; 

wu_timing := lib_WORKUNITSERVICES.WorkunitServices.WorkunitTimings(trim(wuid_input));

timing  := ((sum(wu_timing,duration)/1000)/60)/60;
 
total_thor_time := output(timing, named('total_thor_time'));

//capture timestamp

wu_timestamp := lib_WORKUNITSERVICES.WorkunitServices.WorkunitTimeStamps(trim(wuid_input));
 
timestamp := output(wu_timestamp, named('wu_timestamp'));

//send notification
build_success := fileservices.sendemail(notificationlist,jobname + ' succeeded',
												'the stats are in PROD_WUID:' + workunit);	
												
build_failure := fileservices.sendemail(notificationlist,jobname + ' fail',
												'PROD_WUID:' + workunit);												
action := if(~complete_workunit, build_failure, sequential(workunit_list, total_thor_time, timestamp, build_success));

return action;

end;





