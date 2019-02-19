IMPORT _control;

#workunit('name', 'PersonHeader: _CRON_Header_IKB_Controller');
//UTC is 5 hours ahead, so UTC: 15:01 = EST: 10:01
DAILY_AT_10AM_2PM_5PM_11PM := '01 4,15,19,23 * * *';

ecl:=
        'IMPORT header;\n'+
        '#WORKUNIT(\'name\',\'PersonHeader: Monitor Header IKB Scheduler\');\n'+
        'notify(\'Build_Incremental_Keys\',\'*\');\n'
        ;


_control.fSubmitNewWorkunit(ecl,'hthor_eclcc'):WHEN( CRON(DAILY_AT_10AM_2PM_5PM_11PM));