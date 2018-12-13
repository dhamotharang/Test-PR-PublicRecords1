IMPORT _control;

//UTC is 5 hours ahead, so UTC: 15:01 = EST: 10:01
DAILY_AT_10AM_2PM_AND_5PM := '01 15,19,23 * * *';

ecl:=
        'IMPORT header;\n'+
        '#WORKUNIT(\'name\',\'Monitor Header IKB Scheduler\');\n'+
        'notify(\'IKB FCRA Build Scheduler\',\'*\');\n'
        ;


_control.fSubmitNewWorkunit(ecl,'hthor_eclcc'):WHEN( CRON(DAILY_AT_10AM_2PM_AND_5PM));