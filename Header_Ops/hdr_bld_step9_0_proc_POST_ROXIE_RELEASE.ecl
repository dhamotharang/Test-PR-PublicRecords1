IMPORT $,STD,header;

emailList   :=  ''
              + 'Gabriel.Marcan@lexisnexisrisk.com;'
              +';Debendra.Kumar@lexisnexisrisk.com'
            ;

build_version:= '20191226';// we would like to use header._info.version_base_qa; but #WORKUNIT must be constant at compile time

#WORKUNIT('name',build_version+' Header - Post Roxie Release');

sf_name := Header_ops._Constant.postroxie_build_sf;
status  := Header.LogBuildStatus(sf_name, build_version).GetLatestVersionCompletedStatus:INDEPENDENT;
update_status(unsigned2 new_status) := Header.LogBuildStatus(sf_name,build_version,new_status).Write;
           
step1 := $.fn_report_segmentation(emailList);
step2 := $.fn_report_build_timing_stats(emailList);
step3 := $.suppressions.promote_pre_building_reference_file;

prev_st_sf_name := Header_Ops._Constant.postmove_build_sf;
latest_move    := Header.LogBuildStatus(prev_st_sf_name, '').GetLatest;

version_base_qa   := header._info.version_base_qa;
prod_roxie_version:= header._info.current_prod_roxie_version;

sequential(
    header._config.setup_build,
    if(regexfind('hthor',STD.System.Thorlib.Group()),fail('Workunit must run on non-hthor')),
    if(latest_move.versionName<>version_base_qa     ,fail('Status log is incongruent with header prod base file')),
    if(latest_move.versionName<>build_version       ,fail('Version given in incongruent with latest version moved. Wrong version or timing')),
    if(latest_move.versionStatus<>9                 ,fail('Move process did not complete. Please ensure it completes before running this again')),
    if(latest_move.versionName<>prod_roxie_version  ,fail('Pord Roxie and version being processed are not the same. Too early / late to run this')),
    if(status>=9,output('Nothing to do. All actions already ran for version: '+build_version)),

// We passed all the tests, so we can go ahead and run the reports and post release actions
    if(status<1,sequential(step1,update_status(1))),
    if(status<2,sequential(step2,update_status(2))),
    if(status<3,sequential(step3,update_status(3))),
//In order to keep consistency across all builds and 
//reserving status to add future steps, the end status is set as 9
    if(status<9,update_status(9))
):failure(STD.System.Email.SendEmail(emailList,build_version+ ' Post Roxie Release failed','see: '+header._info.wuidLink +'\n\n'+FAILMESSAGE));

//20191226 W20200204-092432
//20191023 W20191213-113636