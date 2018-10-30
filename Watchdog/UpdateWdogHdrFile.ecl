import ut,std;
EXPORT UpdateWdogHdrFile(string watchdogtype ,boolean ishdrnew) := function

string8 build_date := (string) Watchdog.proc_get_wdogdate(ishdrnew).fdate : independent;



wdog_hr_rec := record
string wtype;
string hdr_version;
boolean ishdrnew;
string issubmitted;
string iscompleted;
end;

header_version := (string) nothor(ut.fGetFilenameVersion ('~thor_data400::base::header_prod'));

set_wdog_lfile := if ( ishdrnew = true, '~thor_data400::watchdog::newheader_version_'+build_date ,'~thor_data400::watchdog::header_version_'+build_date);
set_wdog_sfile := if ( ishdrnew = true, '~thor_data400::watchdog::newheader_version' ,'~thor_data400::watchdog::header_version');
set_wdog_tempfile := if ( ishdrnew = true, '~thor_data400::watchdog::newheader_version_temp' ,'~thor_data400::watchdog::header_version_temp');

ds := dataset(set_wdog_lfile,wdog_hr_rec,thor,opt);

wdog_hr_rec updatefile( ds l) := transform

self.issubmitted := if ( l.wtype = watchdogtype , 'Y','N');
self.iscompleted := if ( l.wtype = watchdogtype , 'Y','N');
self := l;
end;

ds1 := project(ds,updatefile(left));
// changed - went back to the original setup.
return Sequential(output(ds1,,set_wdog_lfile+'_'+watchdogtype+'_'+build_date,overwrite),
               FileServices.StartSuperfiletransaction(),
							  FileServices.RemoveSuperfile(set_wdog_sfile,set_wdog_lfile),
								FileServices.FinishSuperfiletransaction(),
<<<<<<< Updated upstream
=======
								
                output(ds1,,set_wdog_lfile+'_'+watchdogtype+'_'+build_date,overwrite),
>>>>>>> Stashed changes
								output(ds1,,set_wdog_tempfile+'_'+build_date,overwrite),
                FileServices.Renamelogicalfile(set_wdog_lfile,set_wdog_lfile+watchdogtype+'_old'+build_date),
//   					  FileServices.Renamelogicalfile(set_wdog_tempfile+'_'+watchdogtype+'_'+build_date,set_wdog_lfile),
							  FileServices.Renamelogicalfile(set_wdog_tempfile+'_'+build_date,set_wdog_lfile),
                FileServices.StartSuperfiletransaction(),
								FileServices.AddSuperfile( set_wdog_sfile, set_wdog_lfile),
								FileServices.Renamelogicalfile(set_wdog_lfile,set_wdog_lfile+watchdogtype+'_old'),
								FileServices.FinishSuperfiletransaction()
					 );
end;
