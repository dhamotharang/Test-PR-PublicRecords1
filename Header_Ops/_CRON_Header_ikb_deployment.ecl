// This cron job runs ahead of package releases and updates dops and orbit based on the current state of the thor and roxie versions.
// see header.proc_deploy_ikb for more information

IMPORT _control;

//UTC is 5 hours ahead, so UTC: 17:01 = EST: 12:01
DAILY_AT_NOON := '01 17 * * *';

ecl:=
        'IMPORT header;\n'+
        '#WORKUNIT(\'name\',\'Header IKB Deployment\');\n'+
        'emailList:=\'gabriel.marcan@lexisnexisrisk.com,Debendra.Kumar@lexisnexisrisk.com\';\n'+
        'rpt_qa_email_list:=\'BocaRoxiePackageTeam@lexisnexis.com,Isabel.Ma@lexisnexisrisk.com\';\n'+
        'header.proc_deploy_ikb(emailList,rpt_qa_email_list)';


_control.fSubmitNewWorkunit(ecl,'hthor_eclcc'):WHEN( CRON(DAILY_AT_NOON));  


