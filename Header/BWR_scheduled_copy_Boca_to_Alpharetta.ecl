// SCHEDULE TO RUN IN ALPHARETTA !!!
// SCHEDULE TO RUN IN ALPHARETTA !!!
// SCHEDULE TO RUN IN ALPHARETTA !!!
// SCHEDULE TO RUN IN ALPHARETTA !!!
// SCHEDULE TO RUN IN ALPHARETTA !!!
// SCHEDULE TO RUN IN ALPHARETTA !!!

IMPORT UT,STD;
#workunit('name','Header.BWR_scheduled_copy_Boca_to_Alpharetta');

emailList          :=   'gabriel.marcan@lexisnexisrisk.com'
                     + ',debendra.kumar@lexisnexisrisk.com'
                     + ',Cody.Fouts@lexisnexisrisk.com'
                        ;

updateSuperInNewFileFound(STRING super,STRING file_pattern):= FUNCTION

  		// Setup time stamp
        dt:=Std.Date.Today();
        tm:=STD.Date.CurrentTime();
        datetime := dt[1..4]+'-'+dt[5..6]+'-'+dt[7..8]+' '+tm[1..2]+':'+tm[3..4]+':'+tm[5..6];
  
        // get current file in super
        qa_logical_file:=STD.File.SuperFileContents(super)[1].name;

        // find date in logical
        qa_logical_date:=REGEXFIND('\\d{8}[a-z]?',qa_logical_file,0);
        

        // look for files with same pattern
        matches:=STD.File.LogicalFileList(file_pattern);

        // find the highest (latest) date
        vers:=project(matches,TRANSFORM({string ver},SELF.ver:=REGEXFIND('\\d{8}[a-z]?',LEFT.name,0)));
        latest_version_available:=max(vers,ver);
        latest_available_filename:=matches(REGEXFIND(latest_version_available,name))[1].name;
		supers_updated:=latest_version_available>qa_logical_date;
        // compare with version in super
        RETURN WHEN(supers_updated,ORDERED(
            STD.File.CreateSuperFile(super,,TRUE),
                IF(supers_updated,ORDERED(
                                              // if found is greater than in super - update with latest found
                                              STD.File.StartSuperFileTransaction(),
                                              STD.File.RemoveOwnedSubFiles(super,TRUE),
                                              STD.File.ClearSuperFile     (super     ),
                                              STD.File.AddSuperFile       (super,'~'+latest_available_filename  ),
                                              STD.File.FinishSuperFileTransaction(),
                  							  OUTPUT(dataset([{super,qa_logical_file,latest_version_available,datetime}],
                                                    {string super, string in_qa, STRING best_available, string datetime}),
                                                    NAMED('update_log'),extend)
                						    )
                ),
                OUTPUT(dataset([{super,qa_logical_file,latest_version_available,supers_updated}],
                                {string super, string in_qa, STRING best_available, boolean superUpdated}),
                                NAMED('update_report'),overwrite)
         ));

END;

dsDateUpdate:=dataset([{(string8)Std.Date.Today()}],{STRING8 last_daily_run});

sendEmail(STRING ds):=STD.System.Email.SendEmail(emailList,
                                                 'SUCCESS! '+ds+' files from Boca updated in Alpharetta',
                                                 'See Alpha prod:'+WORKUNIT);
checkFilesForUpdates := 

ORDERED(
            IF(
            updateSuperInNewFileFound('~thor_data400::BASE::HHID'                              ,'thor_data400::base::hhid_*'                               )
         OR updateSuperInNewFileFound('~thor_data400::key::did_hhid_qa'                        ,'thor_data400::key::header::hhid::*::did.ver'              )
         OR updateSuperInNewFileFound('~thor_data400::key::hhid_did_qa'                        ,'thor_data400::key::header::hhid::*::hhid.ver'             )
         OR updateSuperInNewFileFound('~thor_data400::key::hhid_qa'                            ,'thor_data400::key::header::*::hhid'                       )
         OR updateSuperInNewFileFound('~thor_data400::base::hss_household'                     ,'thor400*::base::hss_household_*'                          )
         OR updateSuperInNewFileFound('~thor_data400::key::hdr_city_name.st.percent_chance_qa' ,'thor_data400::key::header::*::city_name.st.percent_chance')
            ,SendEmail('PersonHeader HHID')),

            IF(
            updateSuperInNewFileFound('~thor_data400::key::watchdog_QA'              ,'thor_data400::key::watchdog::*::univesal'     )
         OR updateSuperInNewFileFound('~thor_data400::key::header.minors_hash_QA'    ,'thor_data400::key::header::*::minors_hash'    )
         OR updateSuperInNewFileFound('~thor_data400::key::did_death_masterv2_ssa_QA','thor_data400::key::death_masterv2_ssa::*::did')
           ,SendEmail('Watchdog and related')),

            output(dsDateUpdate,,'~thor_data400::flag::boca_header::monitor_check',compressed,overwrite);

            );

checkFilesForUpdates : when(cron('9 * * * *')); // every hour at 9 minutes past the hour
         
// SCHEDULE TO RUN IN ALPHARETTA !!!
// SCHEDULE TO RUN IN ALPHARETTA !!!
// SCHEDULE TO RUN IN ALPHARETTA !!!
// SCHEDULE TO RUN IN ALPHARETTA !!!
// SCHEDULE TO RUN IN ALPHARETTA !!!
// SCHEDULE TO RUN IN ALPHARETTA !!!