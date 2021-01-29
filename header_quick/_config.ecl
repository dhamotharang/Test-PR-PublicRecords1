IMPORT _control,std,ut;

EXPORT _config (
	STRING sourceIP   = _control.IPAddress.bctlpedata10,
	STRING sourcePath = '/data/data_lib_2_hus2/efx_hdrs/in/'
) := MODULE

    EXPORT data_location := _control.IPAddress.bctlpedata10;
    EXPORT sprayIP(string sourceIP) := map(
    	sourceIP = 'bctlpedata10' => data_location,
        sourceIP
    );    
    
    EXPORT monthly_files       := 'MONTHLY_HEADER_*.DAT';
    EXPORT weekly_files        := 'WEEKLY_HEADER_*.DAT';
    SHARED v_version_file_name       := '~thor_data400::flag::version::equifax_monthly';
    SHARED v_eq_as_of_date_file_name := '~thor_data400::flag::version::equifax_weekly';
    
    // Get version values
    EXPORT get_v_version := dataset(v_version_file_name,{string v_version},thor)[1].v_version;
    EXPORT get_v_eq_as_of_date := dataset(v_eq_as_of_date_file_name,{string v_eq_as_of_date},thor)[1].v_eq_as_of_date;
    
	SHARED fst_monthly_file:=STD.File.RemoteDirectory(sourceIP,sourcePath,monthly_files,false)[1].name;
    SHARED fst_weekly_file:=STD.File.RemoteDirectory(sourceIP,sourcePath,weekly_files,false)[1].name;
    
    SHARED newEquifaxMothlyHeaderDate := regexreplace('MONTHLY_HEADER_[C|E|S|W]_(.*).DAT',fst_monthly_file,'\\1');
    SHARED curEquifaxWeeklyHeaderDate := regexreplace('WEEKLY_HEADER_(.*).DAT',fst_weekly_file,'\\1');
    
    // We always add 7 days (sunday to sunday)
    SHARED newEquifaxWeeklyHeaderDate := regexfind('2[0-9]{7}',fst_weekly_file,0);
    
    EXPORT isNewEquifaxMonthlyFile(string sourceIP) := (count(STD.File.RemoteDirectory(sourceIP,sourcePath,monthly_files,false)(size != 0 )) = 23);
    EXPORT isNewEquifaxWeeklyFile(string sourceIP) := (count(STD.File.RemoteDirectory(sourceIP,sourcePath,weekly_files ,false)(size != 0 )) = 1)
                                                       AND curEquifaxWeeklyHeaderDate>get_v_eq_as_of_date;
    
    
    // v_version
    EXPORT set_v_version(STRING overwriteDate='') := if(isNewEquifaxMonthlyFile(sourceIP) OR overwriteDate<>'',
                                 sequential(
                                     output(dataset([{if(overwriteDate='',newEquifaxMothlyHeaderDate,overwriteDate)}],{string v_version}),,v_version_file_name+'_'+workunit),
                                     std.file.startsuperfiletransaction(),
                                     std.   file.createsuperfile(v_version_file_name,,true),
                                     std.file.clearsuperfile(v_version_file_name,true),
                                     std.file.addsuperfile(v_version_file_name,v_version_file_name+'_'+workunit),
                                     std.file.finishsuperfiletransaction()
                                 ),
                                 output('NO NEW MONTHLY FILE. FLAG FILE WAS LEFT UNCHANGED'));
                                 
    // v_eq_as_of_date
    verifyFileDate(string newWeeklyFileDate):= IF( ut.DaysApart(newWeeklyFileDate,(STRING8)Std.Date.Today() )>10, FAIL('NEW WEEKLY FILE DATE IS MORE THAN 10 DAYS APART FROM RUN DATE'));
    EXPORT set_v_eq_as_of_date(STRING overwriteDate='') := if(isNewEquifaxWeeklyFile(sourceIP) OR overwriteDate<>'',
                                    sequential(
                                         verifyFileDate(IF(overwriteDate='',newEquifaxWeeklyHeaderDate,overwriteDate)),
                                         output(dataset([{if(overwriteDate='',newEquifaxWeeklyHeaderDate,overwriteDate)}],{string v_eq_as_of_date}),,v_eq_as_of_date_file_name+'_'+workunit),
                                         std.file.startsuperfiletransaction(),
                                         std.file.createsuperfile(v_eq_as_of_date_file_name,,true),
                                         std.file.clearsuperfile(v_eq_as_of_date_file_name,true),
                                         std.file.addsuperfile(v_eq_as_of_date_file_name,v_eq_as_of_date_file_name+'_'+workunit),
                                         std.file.finishsuperfiletransaction()
                                     ),
                                     output('NO NEW WEEKLY FILE. FLAG FILE WAS LEFT UNCHANGED'));

END;
