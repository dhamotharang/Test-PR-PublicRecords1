﻿import ut,dops,header,std;
#workunit('name','Start Watchdog build with New Header');
 
ECL1(string wtype,string build_type) := 

'#stored (\'watchtype\', \''+wtype+'\' );\n'
+'#option(\'multiplePersistInstances\',FALSE);\n'
+'#workunit(\'protect\', \'true\');\n'
+'#workunit(\'priority\', \'high\');\n'
+'#workunit (\'priority\',12);\n'
+'#workunit(\'name\', \'Watchdog '+wtype+' Base Build '+ut.GetDate+ '\');\n'
+'Sequential(Watchdog.BWR_Run_Watchdog(\''+build_type+'\'),Watchdog.UpdateWdogHdrFile(\''+wtype+'\',true), notify(\'Watchdog build with New Header can progress\',\'*\'));\n' ;



ECL3 := 

'#option(\'multiplePersistInstances\',FALSE);\n'
+'#workunit(\'protect\', \'true\');\n'
+'#workunit(\'name\', \'Watchdog key Build '+ut.GetDate+ '\');\n'
+'#workunit(\'priority\', \'high\');\n'
+'Sequential(Watchdog.Proc_build_Keys , Watchdog.Proc_build_FCRA_keys , notify(\'Watchdog Marketing build can progress\',\'*\'));\n' ;

//**Get WU List


getwulist := nothor(workunitservices.WorkunitList ( lowwuid := '',jobname := 'Watchdog*' ,username := 'skasavajjala_prod'));

getnew := topn( sort ( getwulist,-wuid),1,-wuid );

string8 build_date :=(string) Watchdog.proc_get_wdogdate(true).fdate : independent;

validate_statecount := count(getnew ( state = 'running' ));

//** Verify if the previous Job did deployed to cert
cert_version 		:= dops.GetBuildVersion('WatchdogKeys','B','N','C');

build_version := (string) nothor(ut.fGetFilenameVersion ('~thor_data400::key::watchdog_best.did_qa'));


good_to_process_a_new_build :=  build_version = cert_version;

header_version := (string) nothor(ut.fGetFilenameVersion ('~thor_data400::base::header_prod'));

statusemail := FileServices.sendemail('sudhir.kasavajjala@lexisnexis.com,michael.gould@lexisnexis.com','Watchdog Job Update' +ut.GetDate, 'Watchdog build is on hold due to : 1 previous WU not in completed state or '+'\n'+' 2: Last build was not  deployed to cert .Please view '+getnew[1].wuid);

ds := dataset('~thor_data400::watchdog::newheader_version',{string wtype,string hdr_version,boolean ishdrnew,string issubmitted,string iscompleted},thor,opt);


LaunchJobs := map(    count(ds(wtype = 'glb' and hdr_version = build_date and ishdrnew = true and issubmitted = 'Y' and iscompleted = 'Y' )) = 1 => Sequential(header.fSubmitNewWorkunit(ECL1('nonglb','nonfcra'), 'thor400_66_eclcc')),
                     count(ds(wtype = 'nonglb' and hdr_version = build_date and ishdrnew = true and issubmitted = 'Y' and iscompleted = 'Y' )) = 1 => Sequential(header.fSubmitNewWorkunit(ECL1('glb_nonen','nonfcra'), 'thor400_66_eclcc')) ,
										 count(ds(wtype = 'glb_nonen' and hdr_version = build_date and ishdrnew = true and issubmitted = 'Y' and iscompleted = 'Y')) = 1 => Sequential(header.fSubmitNewWorkunit(ECL1('glb_noneq','nonfcra'), 'thor400_66_eclcc')) ,
                     count(ds(wtype = 'glb_noneq' and hdr_version = build_date and ishdrnew = true and issubmitted = 'Y' and iscompleted = 'Y')) = 1 => Sequential(header.fSubmitNewWorkunit(ECL1('glb_nonen_noneq','nonfcra'), 'thor400_66_eclcc')) ,
                     count(ds(wtype = 'glb_nonen_noneq' and hdr_version = build_date and ishdrnew = true and issubmitted = 'Y' and iscompleted = 'Y')) = 1 => Sequential(header.fSubmitNewWorkunit(ECL1('nonglb_nonutility','nonfcra'), 'thor400_66_eclcc')) ,
                     count(ds(wtype = 'nonglb_nonutility' and hdr_version = build_date and ishdrnew = true and issubmitted = 'Y' and iscompleted = 'Y')) = 1 => Sequential(header.fSubmitNewWorkunit(ECL1('nonutility','nonfcra'), 'thor400_66_eclcc')) ,
                     count(ds(wtype = 'nonutility' and hdr_version = build_date and ishdrnew = true and issubmitted = 'Y' and iscompleted = 'Y')) = 1 => Sequential(header.fSubmitNewWorkunit(ECL1('nonglb_noneq','nonfcra'), 'thor400_66_eclcc')) ,
                     count(ds(wtype = 'nonglb_noneq' and hdr_version = build_date and ishdrnew = true and issubmitted = 'Y' and iscompleted = 'Y')) = 1 => Sequential(header.fSubmitNewWorkunit(ECL1('fcra_best_nonEN','fcra_best_append'), 'thor400_66_eclcc')) ,
										 count(ds(wtype = 'fcra_best_nonEN' and hdr_version = build_date and ishdrnew = true and issubmitted = 'Y' and iscompleted = 'Y')) = 1 => Sequential(header.fSubmitNewWorkunit(ECL1('fcra_best_nonEQ','fcra_best_append'), 'thor400_66_eclcc')) ,
										 count(ds(wtype = 'fcra_best_nonEQ' and hdr_version = build_date and ishdrnew = true and issubmitted = 'Y' and iscompleted = 'Y')) = 1 => Sequential(header.fSubmitNewWorkunit(ECL1('supplemental','nonfcra'), 'thor400_66_eclcc')) ,
                     count(ds(wtype = 'supplemental' and hdr_version = build_date and ishdrnew = true and issubmitted = 'Y' and iscompleted = 'Y')) = 1 => Sequential(header.fSubmitNewWorkunit(ECL3, 'thor400_66_eclcc')) ,
                     count(ds(wtype = 'fcra_best_nonEQ' and hdr_version = build_date and ishdrnew = true and issubmitted = 'N' and iscompleted = 'N')) = 1  => Sequential(header.fSubmitNewWorkunit(ECL1('glb','nonfcra'), 'thor400_66_eclcc')) ,
										 
										 Output('No Job scheduled')
                     );
												

Sequential( std.system.debug.sleep(300000), if ( validate_statecount = 0 and good_to_process_a_new_build ,Sequential(LaunchJobs) ,Sequential('Watchdog build is on hold ',statusemail)  )) : when(event ('Watchdog build with New Header can progress','*'));



