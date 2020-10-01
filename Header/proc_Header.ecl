import header, ut, Strata,std;

export proc_header(string versionBuild, string operatorEmailList, string extraNotifyEmailList) := module
    #stored ('version'  , versionBuild);  
    shared today := (STRING8)Std.Date.Today();
    
    fn:=nothor(fileservices.SuperFileContents('~thor_data400::in::hdr_raw',1)[1].name);
    sub:=stringlib.stringfind(fn,today[1..2],1);

    eq_first_monthly_file:=nothor(std.file.GetSuperFileSubName('~thor_data400::in::quickhdr_raw',1));
    eq_monthly_version:=regexfind('2[0-9]{3}[0-1][0-9]',eq_first_monthly_file,0):independent;
    quick_header_month_version:=header.Sourcedata_month.v_version[1..6];
    check_eq_monthly_file_version:=assert(eq_monthly_version=quick_header_month_version,'ASSERT:EQ Monthly file-version mismatch',FAIL);

    EXPORT run_ingest(boolean incremental=FALSE)
       := sequential(
            if(versionBuild = '',fail('Build Version is empty'))
           ,if(~incremental and versionBuild[5..6]<>fn[sub+4..sub+5],fail('Current month Equifax missing'))
           //,check_eq_monthly_file_version
           ,Header.Inputs_Sequence(incremental,versionBuild)
           ,Header.Inputs_List
           ,if(~incremental,header.build_source_key(versionBuild))
           ,Header.build_header_raw(versionBuild,incremental)
           ,header.proc_linking_attribute_property
           ,if(~incremental, header.Out_Base_Dev_Stats_Header_Relatives(versionBuild, operatorEmailList).ingest_report)
           ,if(exists(file_header_raw(src='')),fail('Blank source codes found - please review header_raw'))
        )
        :success(header.msg(versionBuild + if(incremental,' Incremental',' Monthly') + ' Header Ingest Completed',operatorEmailList).good)
        ,failure(header.msg(versionBuild + if(incremental,' Incremental',' Monthly') + ' Header Ingest Failed',operatorEmailList).bad)
        ;
    
    sf_name := '~thor_data400::out::header_sync';
    update_status(unsigned2 new_status) := Header.LogBuildStatus(sf_name,versionBuild,new_status).Write;

    status := Header.LogBuildStatus(sf_name, versionBuild).GetLatestVersionCompletedStatus:INDEPENDENT;

    fn:=nothor(fileservices.SuperFileContents('~thor_data400::base::header_raw',1)[1].name);
    sub:=stringlib.stringfind(fn,today[1..2],1);

    step1 := header.build_header_raw_syncd;
    step2 := header.Proc_SetTNT(versionBuild);
    step3 := header.Proc_Regression_Test;
    step4 := header.Proc_BuildStats;
    step5 := Strata.modOrbitAdaptersForPersonHdrBld.fnGetCrossSourceAction(dataset(workunit('STATS'),ut.layout_stats_extend), versionBuild);

    EXPORT run_Header_Sync := sequential(    
             if(versionBuild = '',fail('Build Version is empty'))
            ,if(versionBuild<>fn[sub..sub+7],fail('Header_raw does not match version'))
            ,if(status<1,sequential(step1,update_status(1)))
            ,if(status<2,sequential(step2,update_status(2)))
            ,if(status<3,sequential(step3,update_status(3)))
            ,if(status<4,sequential(step4,update_status(4)))
            ,if(status<5,sequential(step5,update_status(5)))
//In order to keep consistency across all builds and 
//reserving status to add future steps, the end status is set as 9
            ,if(status<9,update_status(9))
            // ,notify('Build_XADL','*')
            )
            :success(header.msg(versionBuild + ' Header Sync;Rollup & Stats Completed',operatorEmailList).good)
            ,failure(header.msg(versionBuild + ' Header Sync;Rollup & Stats Failed',operatorEmailList).bad)
    ;

end;