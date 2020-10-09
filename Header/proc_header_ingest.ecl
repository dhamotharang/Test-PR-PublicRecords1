import header, ut, Strata,std;

export proc_header_ingest(boolean incremental=FALSE, string versionBuild) := MODULE
    #stored ('version'  , versionBuild);  
    today := (STRING8)Std.Date.Today();

	operatorEmailList := Header.email_list.BocaDevelopersEx;
    
    fn:=nothor(fileservices.SuperFileContents('~thor_data400::in::hdr_raw',1)[1].name);
    sub:=stringlib.stringfind(fn,today[1..2],1);

    eq_first_monthly_file:=nothor(std.file.GetSuperFileSubName('~thor_data400::in::quickhdr_raw',1));
    eq_monthly_version:=regexfind('2[0-9]{3}[0-1][0-9]',eq_first_monthly_file,0):independent;
    quick_header_month_version:=header.Sourcedata_month.v_version[1..6];
    check_eq_monthly_file_version:=assert(eq_monthly_version=quick_header_month_version,'ASSERT:EQ Monthly file-version mismatch',FAIL);

    ingest_status_fn := 'headeringest_' + if(incremental,'inc','mon');

    step1 := check_eq_monthly_file_version;
    step2 := Header.Inputs_Sequence(incremental,versionBuild);
    step3 := Header.Inputs_List;
    step4 := header.build_source_key(versionBuild);
    step5 := Header.build_header_raw(versionBuild,incremental);
    step6 := header.proc_linking_attribute_property;
    step7 := header.Out_Base_Dev_Stats_Header_Relatives(versionBuild, operatorEmailList).ingest_report;

    EXPORT run := sequential(
            if(versionBuild = '',fail('Build Version is empty'))
           //,if(~incremental and versionBuild[5..6]<>fn[sub+4..sub+5],fail('Current month Equifax missing'))
           //,Header.mac_runIfNotCompleted (ingest_status_fn,versionBuild, step1, 110)
           ,Header.mac_runIfNotCompleted (ingest_status_fn,versionBuild, step2, 120)
           ,Header.mac_runIfNotCompleted (ingest_status_fn,versionBuild, step3, 130)
           ,if(~incremental,Header.mac_runIfNotCompleted (ingest_status_fn,versionBuild, step4, 140))
           ,Header.mac_runIfNotCompleted (ingest_status_fn,versionBuild, step5, 150)
           ,Header.mac_runIfNotCompleted (ingest_status_fn,versionBuild, step6, 160)
           ,if(~incremental, Header.mac_runIfNotCompleted (ingest_status_fn,versionBuild, step7, 170))
           ,if(exists(file_header_raw(src='')),fail('Blank source codes found - please review header_raw'))
        )
        :success(header.msg(versionBuild + if(incremental,' Incremental',' Monthly') + ' Header Ingest Completed',operatorEmailList).good)
        ,failure(header.msg(versionBuild + if(incremental,' Incremental',' Monthly') + ' Header Ingest Failed',operatorEmailList).bad)
        ;

END;