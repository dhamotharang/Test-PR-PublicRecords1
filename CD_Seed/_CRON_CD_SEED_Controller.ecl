IMPORT _control;

file_list := FileServices.RemoteDirectory(_Constants.ServerIP, _Constants.LandingDir + 'ready/', '*.csv'):independent;
run       := exists(file_list);
version   := if(run, regexfind('[0-8]{8}', file_list[1].name, 0), '');  //'protectedconsumers20181017.csv'

#workunit('name', '_CRON_CD_SEED_Controller');
//UTC is 5 hours ahead, so UTC: 17:01 = EST: 12:01
DAILY_AT_NOON := '01 17 * * *';

ECL:=
        '#WORKUNIT(\'name\',\'' + version + ' CD_SEED Build\');\n'
       + if(run, 'CD_Seed.Build_All(\''+ version + '\');\n','output(\'No SEED FILE received\');\n')
        ;

_control.fSubmitNewWorkunit(ecl,'hthor_eclcc'):WHEN(CRON(DAILY_AT_NOON))
                               ,SUCCESS(fileservices.sendemail(Email_Notification_Lists.BuildSuccess
                                ,'CD_SEED BUILD TRIGGERED FROM ' + workunit
                                ,ECL
                               ));