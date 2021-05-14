import header, ut, Strata,std;

EXPORT proc_Header(string versionBuild) := MODULE

    #stored ('version'  , versionBuild); 
    operatorEmailList := Header.email_list.BocaDevelopersEx;
    today := (STRING8)Std.Date.Today();

    fn:=nothor(fileservices.SuperFileContents('~thor_data400::base::header_raw',1)[1].name);
    sub:=stringlib.stringfind(fn,today[1..2],1);

    step1 := header.build_header_raw_syncd;
    step2 := header.Proc_SetTNT(versionBuild);
    step3 := header.Proc_Regression_Test;
    step4 := header.Proc_BuildStats;
    step5 := Strata.modOrbitAdaptersForPersonHdrBld.fnGetCrossSourceAction(dataset(workunit('STATS'),ut.layout_stats_extend), versionBuild);
    step6 := output('Header Sync completed');

    EXPORT run := sequential(    
             if(versionBuild = '',fail('Build Version is empty'))
            ,if(versionBuild<>fn[sub..sub+7],fail('Header_raw does not match version'))
            ,Header.mac_runIfNotCompleted ('headersync',versionBuild, step1, 100)
            ,Header.mac_runIfNotCompleted ('headersync',versionBuild, step2, 200)
            ,Header.mac_runIfNotCompleted ('headersync',versionBuild, step3, 300)
            ,Header.mac_runIfNotCompleted ('headersync',versionBuild, step4, 400)
            ,Header.mac_runIfNotCompleted ('headersync',versionBuild, step5, 500)
//In order to keep consistency across all builds and 
//reserving status to add future steps, the end status is set as 9
            ,Header.mac_runIfNotCompleted ('headersync',versionBuild, step6, 900)
            )
            :success(header.msg(versionBuild + ' Header Sync;Rollup & Stats Completed',operatorEmailList).good)
            ,failure(header.msg(versionBuild + ' Header Sync;Rollup & Stats Failed',operatorEmailList).bad)
    ;

END;