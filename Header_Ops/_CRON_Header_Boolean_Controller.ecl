IMPORT _control, std, header;

#workunit('name', 'PersonHeader: _CRON_Header_Boolean_Controller');
EVERY_2_HR := '0 */2 * * *';

wuname := '*Header Boolean*';
valid_state := ['','unknown','submitted', 'compiling','compiled','blocked','running','wait'];
d := sort(nothor(WorkunitServices.WorkunitList('',NAMED jobname:=wuname))(wuid <> thorlib.wuid() and state in valid_state), -wuid):independent;
active_workunit :=  exists(d);

today := (STRING8)Std.Date.Today() : independent;

file_version(string super) := function        
  sub:=stringlib.stringfind(super, today[1..2],1);
  return super[sub+4..sub+5];        
end;


sf_name := '~thor_data400::out::header_post_move_status';
status := Header.LogBuildStatus(sf_name).Read[1].status;
run := if(status <> 0, true, false);

ecl:=    'IMPORT header;\n'
       + '#WORKUNIT(\'name\',\'PersonHeader: Monitor Header Boolean Scheduler\');\n'
       + if(active_workunit,'fileservices.sendemail(Header.email_list.BocaDevelopers,\'Monitoring Header Boolean\',\'Header Boolean is RUNNING Right now\');\n',if(run, 'notify(\'Build_Header_Boolean\',\'*\');\n', 'output(\'NO Boolean Build to be Recovered\');\n'))
        ;

_control.fSubmitNewWorkunit(ecl,'hthor_eclcc'):WHEN( CRON(EVERY_2_HR));