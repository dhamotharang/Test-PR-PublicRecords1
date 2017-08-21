import ut,STD;
EXPORT proc_get_wdogdate(boolean ishdrnew) := module

set_wdog_sfile := if ( ishdrnew = true, '~thor_data400::watchdog::newheader_version','~thor_data400::watchdog::header_version');

ds := nothor(FileServices.SuperFileContents (set_wdog_sfile ));

ds2 :=  topn(sort(ds,-name),1,-name);

map ( ishdrnew = true => if ( nothor(ut.fGetFilenameVersion ( '~'+ds2[1].name))[1..6] <> ut.getDateOffset(-30)[1..6] ,FAIL('CURRENT_NEWHEADER_VERSION_FILE_NOT_IN_SUPER :'+set_wdog_sfile)),
                        if ( ut.DaysApart((STRING8)nothor(ut.fGetFilenameVersion ( '~'+ds2[1].name)) ,(STRING8)STD.Date.Today()) > 7 ,FAIL('CURRENT_OLDHEADER_VERSION_FILE_NOT_IN_SUPER :'+set_wdog_sfile)));


export fdate :=  nothor(ut.fGetFilenameVersion ( '~'+ds2[1].name)) ;

end;