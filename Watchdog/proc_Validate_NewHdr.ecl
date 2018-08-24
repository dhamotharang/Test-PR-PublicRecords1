import ut,dops;
EXPORT proc_Validate_NewHdr := module

//changed so that wdoghdr which is the version only uses the date portion. [1..8]

curkey := nothor(FileServices.GetSuperfilesubname ('~thor_data400::key::header_qa',1)) ;

 shared curkeydate := curkey[StringLib.StringFind( curkey,'::',3)+2..StringLib.StringFind( curkey,'::',4)-1];
 

shared hdrprod_version 		:= dops.GetBuildVersion('PersonHeaderKeys','B','N','P');




shared wdoghdr := nothor(FileServices.GetSuperfilesubname ('~thor_data400::base::header_prod',1));

shared fcrahdr := nothor(FileServices.GetSuperfilesubname ('~thor_data400::base::file_fcra_header_building_prod',1));

shared ihdrkey := nothor(FileServices.GetSuperfilesubname ('~thor400_66::key::insuranceheader_xlink::qa::did::refs::name',1));



 shared wdogdate := wdoghdr[StringLib.StringFind( wdoghdr,'_',2)+1..];
 
 shared fcrahdrdate :=regexfind('[0-9]{8}',fcrahdr,0);
 
 shared  ihdrdate := regexfind('[0-9]{8}',ihdrkey,0);
 
 shared wdogcert_version 		:= dops.GetBuildVersion('WatchdogKeys','B','N','C');

 shared wdogprod_version 		:= dops.GetBuildVersion('WatchdogKeys','B','N','P');
														

 
 export  out := map ( curkeydate[1..8] <> wdogdate[1..8] => true,
                          curkeydate[1..8] = wdogdate[1..8]  and curkeydate[1..8] <> hdrprod_version[1..8] => true,
                            false ) ;
	shared cmpinputs := if ( out = true /*and wdogdate = fcrahdrdate*/ and wdogdate[1..8] = 	ihdrdate, Output('ALL_INPUT_VERSIONS_ARE_IN_SYNC'), fail('INPUT_FILES_OUT_OF_SYNC'));											

	ds := dataset('~thor_data400::watchdog::header_version',{string wtype,string hdr_version,boolean ishdrnew,string issubmitted,string iscompleted},thor,opt);
shared check_submitted := if ( out = true , count( ds( hdr_version = wdogdate and issubmitted = 'Y' and ishdrnew = true)),
                                    count( ds( hdr_version = ut.GetDate and issubmitted = 'Y' and ishdrnew = false))
											 );
											 
shared death_master_fcheck := if(ut.DaysApart((string) ut.GetDate,(STRING) ut.fGetFilenameVersion('~thor_data400::base::did_death_masterv2')) < 7,true,false);
														
	export newhdr := if ( out = true  and death_master_fcheck = true and check_submitted = 0   , Sequential( cmpinputs,Watchdog.set_watchdog_version(wdogdate,true).out,notify('Watchdog build with New Header can progress','*')),
	                                                      Output('Either it is old header or already submitted')
																												
									);
									
									
	export oldhdr := if ( out = false and death_master_fcheck = true and check_submitted = 0 and wdogcert_version = wdogprod_version , Sequential( Watchdog.set_watchdog_version(wdogdate,false).out,notify('Watchdog build can progress','*')),
	                                                      Output('Either it is old header or already submitted')
																												
									);
									
	

end;





