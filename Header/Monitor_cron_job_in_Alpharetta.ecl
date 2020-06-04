IMPORT STD,ut;

EXPORT Monitor_cron_job_in_Alpharetta := MODULE

eList          :=   'gabriel.marcan@lexisnexisrisk.com'
                 //+ ',debendra.kumar@lexisnexisrisk.com'
                 ;

dsDateUpdate:=DATASET(ut.foreign_aprod+'thor_data400::flag::boca_header::monitor_check',{STRING8 last_daily_run},thor);

EXPORT check:=
    IF( ut.DaysApart( (string8)Std.Date.Today() ,dsDateUpdate[1].last_daily_run ) > 1 , PARALLEL(
    STD.System.Email.sendemail(eList,'CRON IN ALPHA DOWN','Job did not update flag file for more than 24 hours. please check\n\n'+
                                                          'Deploy: Header\\BWR_scheduled_copy_Boca_to_Alpharetta.ecl if needed\n\n'+
                                                          'See Job: '+workunit),
    OUTPUT('Cron job in Alpharetta down')),
    OUTPUT('Cron job in Alpharetta ok'));
EXPORT MAIN := check;
END;