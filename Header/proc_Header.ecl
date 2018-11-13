import header, ut, Strata,std;

export proc_header(string operatorEmailList, string extraNotifyEmailList) := module

    #stored ('buildname', 'PersonHeader'   ); 
    #stored ('emailList', operatorEmailList   );
    
    shared today := (STRING8)Std.Date.Today();
    
    fn:=nothor(fileservices.SuperFileContents('~thor_data400::in::hdr_raw',1)[1].name);
    sub:=stringlib.stringfind(fn,today[1..2],1);

    eq_first_monthly_file:=nothor(std.file.GetSuperFileSubName('~thor_data400::in::quickhdr_raw',1));
    eq_monthly_version:=regexfind('2[0-9]{3}[0-1][0-9]',eq_first_monthly_file,0):independent;
    quick_header_month_version:=header.Sourcedata_month.v_version[1..6];
    check_eq_monthly_file_version:=assert(eq_monthly_version=quick_header_month_version,'ASSERT:EQ Monthly file-version mismatch',FAIL);


    SHARED INGEST(boolean incremental=FALSE,string versionBuild)
       := sequential(
            #stored ('version'  , versionBuild); 
            #WORKUNIT('name', versionBuild + ' Header Ingest');
            header.LogBuild.single('Started :'+ versionBuild + ' Header Ingest')           
           ,if(~incremental and versionBuild[5..6]<>fn[sub+4..sub+5],fail('Current month Equifax missing'))
           ,check_eq_monthly_file_version
           ,Header.Inputs_Sequence(incremental,versionBuild)
           ,Header.Inputs_List
           ,if(~incremental,header.build_source_key())
           ,Header.build_header_raw(versionBuild,incremental)
           ,if(exists(file_header_raw(src='')),fail('Blank source codes found - please review header_raw'))
           ,header.LogBuild.single('Completed :'+ versionBuild + ' Header Ingest')
        )
        :success(header.msg(if(incremental,'Incremental:','') + versionBuild + ' Header Ingest Completed',operatorEmailList).good)
        ,failure(header.msg(if(incremental,'Incremental:','') + versionBuild + ' Header Ingest Failed',operatorEmailList).bad)
        ;
          
    export run_ingest(boolean is_monthly = false, string versionBuild) := ingest(is_monthly, versionBuild);
    
    #stored ('buildname', 'PersonHeader'   ); 
    #stored ('version'  , header.version_build); 
    
    // step:='Yogurt:'+Header.version_build+' Header Sync;Rollup & Stats';
    step:=Header.version_build+' Header Sync;Rollup & Stats';
    #WORKUNIT('name', step);
    cmpltd:=step+' completed';
    failed:=step+' failed';
    fn:=nothor(fileservices.SuperFileContents('~thor_data400::base::header_raw',1)[1].name);
    sub:=stringlib.stringfind(fn,today[1..2],1);
    export STEP2 := sequential(
            header.LogBuild.single('Started :'+step)
            ,if(Header.version_build<>fn[sub..sub+7],fail('Header_raw does not match version'))
            ,Header.build_header_raw_syncd
            ,header.Proc_SetTNT
            ,header.Proc_Regression_Test
            ,header.Proc_BuildStats
            ,Strata.modOrbitAdaptersForPersonHdrBld.fnGetCrossSourceAction(dataset(workunit('STATS'),ut.layout_stats_extend), Header.version_build)
            // ,notify('Build_XADL','*')
            ,header.LogBuild.single('Completed :'+step)
            )
            :success(header.msg(cmpltd,operatorEmailList).good)
            ,failure(header.msg(failed,operatorEmailList).bad)
    ;
        
end;