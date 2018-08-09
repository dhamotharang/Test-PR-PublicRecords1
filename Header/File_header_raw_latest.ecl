IMPORT data_services,versionControl,_control,ut,std;
// This attribute is used to determine the latest header raw for subsequent builds (monthy of incremental)
// Refer to Header.build_header_raw to see how it is being updated.


EXPORT File_header_raw_latest := module
        
        shared lc := data_services.Data_location.prefix('header');
        export fileName := lc+'thor_data400::base::header_raw::latest_built';

        latest_inc_dt := versionControl.fGetFilenameVersion(lc+'thor_data400::base::header_raw_incremental');
        latest_ful_dt := versionControl.fGetFilenameVersion(lc+'thor_data400::base::header_raw');      
        latest_raw_dt := versionControl.fGetFilenameVersion(fileName);

        raw_hdr_ver_info:='Latest Incremental='+latest_inc_dt+', Latest Monthly='+latest_ful_dt+' |Therefore latest to use='+latest_raw_dt;
        filedate_is_latest := when((latest_raw_dt >= latest_inc_dt AND 
                               latest_raw_dt >= latest_ful_dt)
                               ,output(raw_hdr_ver_info,named('raw_vers'))
                               ,before);

        one_week_ago  := ut.date_math((STRING8)Std.Date.Today(),-7 );
        two_weeks_ago := ut.date_math((STRING8)Std.Date.Today(),-14);

        file_age_less_than_2_weeks := when((latest_raw_dt>((unsigned)two_weeks_ago)),
                                           if(latest_raw_dt<((unsigned)one_week_ago-1),
                                              fileservices.sendemail(_control.MyInfo.EmailAddressNotify,
                         'WARNING: Latest header raw ('+latest_raw_dt+') > 1 week.',workunit))
                                          ,before):global;
                                    
        // Force to true to temporary bypass a fail (BUT MAKE SURE YOU HAVE THE RIGHT VERSIONS IN PLACE)
        is_latest_header_raw_best := filedate_is_latest AND file_age_less_than_2_weeks;
       
        export File := when(
                            dataset(fileName ,header.Layout_Header,thor),if(not(is_latest_header_raw_best),
                             STD.System.Email.SendEmail(_control.MyInfo.EmailAddressNotify,
                               '** CRITICAL ** HEADER_RAW', 'Lasted is older than 2 week. VERIFY!!\r\n\r\n'+raw_hdr_ver_info+'\r\n\r\n'+workunit))
                            ,before);
end; 