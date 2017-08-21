import ut;
EXPORT set_watchdog_version(string newhdr_version = '',boolean isheadernew = false) := module

 wdog_hr_rec := record
string wtype;
string hdr_version;
boolean ishdrnew;
string issubmitted;
string iscompleted;
end;

  hdr_date := if ( isheadernew = true ,newhdr_version[1..8] , ut.GetDate);

 watchdog_hdr_version :=  dataset([{'glb',hdr_date,isheadernew,'N','N'},
                           {'nonglb',hdr_date,isheadernew,'N','N'},
													 {'glb_nonen',hdr_date,isheadernew,'N','N'},
													 {'glb_noneq',hdr_date,isheadernew,'N','N'},
													 {'glb_nonen_noneq',hdr_date,isheadernew,'N','N'},
													 {'nonglb_nonutility',hdr_date,isheadernew,'N','N'},
													 {'nonutility',hdr_date,isheadernew,'N','N'},
													 {'nonglb_noneq',hdr_date,isheadernew,'N','N'},
													 {'supplemental',hdr_date,isheadernew,'N','N'},
													 {'fcra_best_nonEN',hdr_date,isheadernew,'N','N'},
													 {'fcra_best_nonEQ',hdr_date,isheadernew,'N','N'}

                          ],wdog_hr_rec);

ds := dataset('~thor_data400::watchdog::header_version',wdog_hr_rec,thor,opt);

set_superfile := if ( isheadernew = true, '~thor_data400::watchdog::newheader_version','~thor_data400::watchdog::header_version');

 set_watchdog_hdr := output(watchdog_hdr_version,,set_superfile+'_'+hdr_date,overwrite);

                                   

superfile_trans := Sequential ( FileServices.StartSuperfiletransaction(),
                                //FileServices.ClearSuperfile('~thor_data400::watchdog::header_version'),
                            FileServices.AddSuperfile(set_superfile ,set_superfile+'_'+hdr_date),
														                       
																FileServices.FinishSuperfiletransaction()
																
																);
																
																
export out :=  Sequential( set_watchdog_hdr,superfile_trans);
end;
