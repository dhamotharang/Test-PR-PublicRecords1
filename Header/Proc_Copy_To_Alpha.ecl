IMPORT ut,Data_Services,_control,data_services,STD,DOPS;
EXPORT Proc_Copy_To_Alpha(string pversion='') := MODULE

        aEsp                 := _control.IPAddress.aprod_thor_esp;
        bEsp                 := data_services.foreign_prod;
        aCluster             := 'thor400_112';
        
        l := bEsp;//Data_Services.Data_location.person_header;
        SHARED old_copy_to_alpha(string lfn):= fileservices.RemotePull(

                                'http://'+aEsp+':8010/FileSpray',
                                bEsp+lfn,aCluster,
                                '~'+lfn,
                                /*tmOut*/,/*maxConn*/,/*ovrt*/,/*relct*/,/*asSuper*/,/*frcPsh*/,/*bfrSz*/,/*wrp*/,true) ;

        SHARED copy_to_alpha(dataset(DOPS.Layout_filelist) filesToCopy):=DOPS.CopyFiles(

            _control.IPAddress.prod_thor_esp,    //  string srcesp
            _control.IPAddress.aprod_thor_esp,   // ,string destesp
            _control.IPAddress.prod_thor_dali,   // ,string srcdali
            _control.IPAddress.aprod_thor_dali,  // ,string destdali
            'thor400_112',                       // ,string destcluster
            ,                                    // ,set of string insrccluster = []
            ,                                    // ,string filepattern = ''
            filesToCopy,// ,dataset(dops.Layout_filelist) ds = dataset([],dops.Layout_filelist)
            ,// ,string dstSubNameSuffix = ''
            workunit, //,string uniquearbitrarystring = 'uniquenameforthisjob' // this string will be used in filename
                                                            // to uniquely represent the filename CopyFileList_FileName
            true// ,boolean copywithsoap = false
            // ,boolean usecredentials = false

        ).RUN;

        EXPORT hhid:=ORDERED(

                                 copy_to_alpha(dataset([
                
                    {'thor_data400::base::hhid_'+pversion                                  ,''},
                    {'thor_data400::key::header::hhid::'+pversion+'::did.ver'              ,''},
                    {'thor_data400::key::header::hhid::'+pversion+'::hhid.ver'             ,''},
                    {'thor400_44::base::hss_household_'+pversion                           ,''},
                    {'thor_data400::key::header::'+pversion+'::hhid'                       ,''},
                    {'thor_data400::key::header::'+pversion+'::city_name.st.percent_chance',''}

                    ],DOPS.Layout_filelist)),
                    
                    Header.Monitor_cron_job_in_Alpharetta.check;
                    
        );
        GetLogical(STRING super):=NOTHOR(STD.File.SuperFileContents(super)[1].name);
        
        EXPORT watchdog:= ORDERED(

                                        copy_to_alpha(dataset([
                        
                        {GetLogical('~thor_data400::key::watchdog_QA'              ),''},
                        {GetLogical('~thor_data400::key::header.minors_hash_QA'    ),''},
                        {GetLogical('~thor_data400::key::did_death_masterv2_ssa_QA'),''}
                    
                    ],DOPS.Layout_filelist)),

                    Header.Monitor_cron_job_in_Alpharetta.check;

        );

end;
