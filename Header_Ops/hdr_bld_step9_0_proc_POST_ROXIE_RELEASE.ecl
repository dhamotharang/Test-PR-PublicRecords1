IMPORT $,STD,header;

emailList   :=  ''
              + 'Gabriel.Marcan@lexisnexisrisk.com;'
              +';Debendra.Kumar@lexisnexisrisk.com'
            ;
oldList     := ''
                // +';Jose.Bello@lexisnexisrisk.com'
                // +';Joseph.Lezcano@lexisnexisrisk.com'
                // +';Jennifer.Butts@lexisnexisrisk.com'
                // +';Jessica.Mills@lexisnexisrisk.com'
                ;

build_version:= '20181023';// we would like to use header._info.version_base_qa; but #WORKUNIT must be constant at compile time

#WORKUNIT('name',build_version+' Header - Post Roxie Release');

sf_name := '~thor_data400::out::header_post_roxie_release';
status := Header.LogBuildStatus(sf_name, build_version).GetLatestVersionCompletedStatus:INDEPENDENT;
update_status(unsigned2 new_status) := Header.LogBuildStatus(sf_name,build_version,new_status).Write;
           
step10:=    $.fn_report_segmentation(emailList);
step11:=    $.fn_report_build_timing_stats(emailList+oldList);
step12:=    $.suppressions.promote_pre_building_reference_file;

prev_st_sf_name := '~thor_data400::out::header_post_move_status';
latest_move := Header.LogBuildStatus(prev_st_sf_name, '').GetLatest;
version_base_qa := header._info.version_base_qa;
prod_roxie_version:= header._info.current_prod_roxie_version;

sequential(
            header._config.setup_build,
            if(regexfind('hthor',STD.System.Thorlib.Group()),fail('Workunit must run on non-hthor')),
            if(latest_move.versionName<>version_base_qa     ,fail('Status log is incongruent with header prod base file')),
            if(latest_move.versionName<>build_version       ,fail('Version given in incongruent with latest version moved. Wrong version or timing')),
            if(latest_move.versionStatus<>7                 ,fail('Move process did not complete. Please ensure it completes before running this again')),
            if(latest_move.versionName<>prod_roxie_version  ,fail('Pord Roxie and version being processed are not the same. Too early / late to run this')),
            if(status>=12,output('Nothing to do. All actions already ran for version: '+build_version)),
            
            // We passed all the tests, so we can go ahead and run the reports and post release actions
            if(status<10,step10,update_status(10)),
            if(status<11,step11,update_status(11)),
            if(status<12,step12,update_status(12)),
):failure(STD.System.Email.SendEmail(emailList,build_version+ ' Post Roxie Release failed','see: '+header._info.wuidLink +'\n\n'+FAILMESSAGE))