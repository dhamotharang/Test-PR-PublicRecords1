//Header Ingest Controller submit jobs that needs to be recovered only.

IMPORT _control, std, header;

#workunit('name', 'PersonHeader: _CRON_Header_Ingest_Controller');
EVERY_2_HR_ON_SUN_MON_TUE := '0 */2 * * 0,1,2';

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

sf_name := '~thor_data400::out::header_ingest_status_' + if(isMonthly, 'mon', 'inc');
ver    := Header.LogBuildStatus(sf_name).Read[1].version;
status := Header.LogBuildStatus(sf_name).Read[1].status;
run := if(status <> 0, true, false);

ecl:=    'IMPORT header;\n'
       + '#WORKUNIT(\'name\',\'PersonHeader: Monitor Header Ingest Scheduler\');\n'
       + if(run, 'notify(\'Build_Header_Ingest\',\'*\');\n', 'output(\'NO Ingest Build to be Recovered\');\n')
        ;

_control.fSubmitNewWorkunit(ecl,'hthor_eclcc'):WHEN( CRON(EVERY_2_HR_ON_SUN_MON_TUE));