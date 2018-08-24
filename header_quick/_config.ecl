IMPORT _control,std,ut;
EXPORT _config := MODULE

    EXPORT data_location := _control.IPAddress.bctlpedata10;
    EXPORT sprayIP(string sourceIP) := map(
                                            sourceIP = 'bctlpedata10' => data_location,
                                            sourceIP
                                    );    
    
    EXPORT sourcePath          := '/data/data_lib_2_hus2/efx_hdrs/in/';
    EXPORT monthly_files       := 'MONTHLY_HEADER_*.DAT';
    EXPORT weekly_files        := 'WEEKLY_HEADER_*.DAT';
    SHARED v_version_file_name       := '~thor_data400::flag::version::equifax_monthly';
    SHARED v_eq_as_of_date_file_name := '~thor_data400::flag::version::equifax_weekly';
    
    // Get version values
    EXPORT get_v_version := dataset(v_version_file_name,{string v_version},thor)[1].v_version;
    EXPORT get_v_eq_as_of_date := dataset(v_eq_as_of_date_file_name,{string v_eq_as_of_date},thor)[1].v_eq_as_of_date;
    
    
    SHARED fst_monthly_file:=FileServices.remotedirectory(sprayIP(data_location),sourcePath,monthly_files,false)[1].name;
    SHARED fst_weekly_file:=FileServices.remotedirectory(sprayIP(data_location),sourcePath,weekly_files,false)[1].name;
    
    SHARED newEquifaxMothlyHeaderDate := regexreplace('MONTHLY_HEADER_[C|E|S|W]_(.*).DAT',fst_monthly_file,'\\1');
    SHARED curEquifaxWeeklyHeaderDate := regexreplace('WEEKLY_HEADER_(.*).DAT',fst_weekly_file,'\\1');
    
    // We always add 7 days (sunday to sunday)
    SHARED newEquifaxWeeklyHeaderDate := ut.date_add('7D',get_v_eq_as_of_date);
    
    EXPORT isNewEquifaxMonthlyFile(string sourceIP) := (count(FileServices.remotedirectory(sprayIP(sourceIP),sourcePath,monthly_files,false)(size != 0 )) = 4);
    EXPORT isNewEquifaxWeeklyFile( string sourceIP) := (count(FileServices.remotedirectory(sprayIP(sourceIP),sourcePath,weekly_files ,false)(size != 0 )) = 1)
                                                       AND curEquifaxWeeklyHeaderDate>get_v_eq_as_of_date;
    
    
    // v_version
    EXPORT set_v_version := if(isNewEquifaxMonthlyFile(data_location),
                                 sequential(
                                     output(dataset([{newEquifaxMothlyHeaderDate}],{string v_version}),,v_version_file_name+'_'+workunit),
                                     std.file.startsuperfiletransaction(),
                                     std.file.createsuperfile(v_version_file_name,,true),
                                     std.file.clearsuperfile(v_version_file_name,true),
                                     std.file.addsuperfile(v_version_file_name,v_version_file_name+'_'+workunit),
                                     std.file.finishsuperfiletransaction()
                                 ),
                                 output('NO NEW MONTHLY FILE. FLAG FILE WAS LEFT UNCHANGED'));
                                 
    // v_eq_as_of_date
    
    EXPORT set_v_eq_as_of_date := if(isNewEquifaxWeeklyFile(data_location),
                                    sequential(
                                         output(dataset([{newEquifaxWeeklyHeaderDate}],{string v_eq_as_of_date}),,v_eq_as_of_date_file_name+'_'+workunit),
                                         std.file.startsuperfiletransaction(),
                                         std.file.createsuperfile(v_eq_as_of_date_file_name,,true),
                                         std.file.clearsuperfile(v_eq_as_of_date_file_name,true),
                                         std.file.addsuperfile(v_eq_as_of_date_file_name,v_eq_as_of_date_file_name+'_'+workunit),
                                         std.file.finishsuperfiletransaction()
                                     ),
                                     output('NO NEW WEEKLY FILE. FLAG FILE WAS LEFT UNCHANGED'));

END;