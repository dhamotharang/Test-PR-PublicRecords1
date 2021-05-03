﻿//Header Ingest Controller submit jobs that needs to be recovered only.

IMPORT _control, std, header;

#workunit('name', 'PersonHeader: _CRON_Header_Ingest_Controller');
EVERY_2_HR_ON_SUN_TO_THU := '0 */2 * * 0,1,2,3,4';

wuname := '*Header Ingest*';
valid_state := ['','unknown','submitted', 'compiling','compiled','blocked','running','wait'];
d := sort(nothor(WorkunitServices.WorkunitList('',NAMED jobname:=wuname))(wuid <> thorlib.wuid() and state in valid_state), -wuid):independent;
active_workunit :=  exists(d);

today := (STRING8)Std.Date.Today() : independent;

file_version(string super) := function        
  sub:=stringlib.stringfind(super, today[1..2],1);
  return super[sub+4..sub+5];        
end;

in_raw         := nothor(fileservices.SuperFileContents('~thor_data400::in::hdr_raw',1)[1].name); // ( thor_data400::in::quickhdr_raw )
monthly_ingest := nothor(fileservices.SuperFileContents('~thor_data400::base::header_raw',1)[1].name);

the_eq_file_for_this_month_is_available := today[5..6] = file_version(in_raw);
the_full_ingest_for_this_month_is_completed := today[5..6] = file_version(monthly_ingest);
isMonthly := the_eq_file_for_this_month_is_available AND not(the_full_ingest_for_this_month_is_completed);

sf_name:='~thor_data400::base::build_status::headeringest_'+if(isMonthly, 'mon', 'inc')+'_';
ver    := Header.LogBuildStatus(sf_name).GetLatest.versionName;
status := Header.LogBuildStatus(sf_name).GetLatest.versionStatus;

run := if(status <> 900, true, false);

ecl:=    'IMPORT header;\n'
       + '#WORKUNIT(\'name\',\'PersonHeader: Monitor Header Ingest Scheduler\');\n'
       + if(active_workunit,'fileservices.sendemail(Header.email_list.BocaDevelopers,\'Monitoring Header Ingest\',\'Header Ingest is RUNNING Right now\');\n',if(run, 'notify(\'Build_Header_Ingest\',\'*\');\n', 'output(\'NO Ingest Build to be Recovered\');\n'))
        ;

_control.fSubmitNewWorkunit(ecl,'hthor_eclcc'):WHEN( CRON(EVERY_2_HR_ON_SUN_TO_THU));