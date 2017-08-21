//EXPORT BWR_Property_Full_Build := '';
// THIS DEFINITION CONTAINS BWR CODE. Please COPY code out and it in a NEW Builder Window Runnable IF the monitor is not running

#workunit('name','Property Full build');

import dops,header,std,ut; 

ECL1 := 
'#option(\'multiplePersistInstances\',FALSE);\n'
+'#OPTION(\'AllowedClusters\',\'thor400_20,thor400_44,thor400_60\');\n'
+'#workunit(\'protect\', \'true\');\n'
+'#workunit(\'name\', \'property.build '+(STRING8)Std.Date.Today()+' .FULL\');\n'
+'LN_PropertyV2_Fast.proc0_build_all(\''+(STRING8)Std.Date.Today()+'\',false,\'Sudhir.Kasavajjala@lexisnexisrisk.com Robert.Berger@lexisnexisrisk.com\');\n' ;

//** Verify if the previous Job did deployed to cert
cert_version 				:= dops.GetBuildVersion('LNPropertyV2FullKeys','B','N','C');

build_version_delta := (string) ut.fGetFilenameVersion ('~thor_data400::key::property_fast::qa::assessor.fid');
build_version_full  := (string) ut.fGetFilenameVersion ('~thor_data400::key::ln_propertyv2::qa::assessor.fid');

//**GET WU LIST
getwulist 					:= workunitservices.WorkunitList ( lowwuid := '',jobname := 'property.build*' );

getnew 							:= topn( sort ( getwulist,-wuid),1,-wuid );

isdelta 						:= regexfind('DELTA',getnew[1].job);

isdeltastate 				:= regexfind('complete',getnew[1].state);

build_version 			:= if ( isdelta , build_version_delta ,build_version_full );

last_build_deployed_to_cert :=  build_version = cert_version;

isprevwucomplete 		:= count(getnew ( state = 'completed'));

isdeltarunning 			:= isdelta and  not(isdeltastate);

//**EMAIL NOTIFICATION

sendemail(string keyword) := function

return FileServices.sendemail('sudhir.kasavajjala@lexisnexisrisk.com Robert.Berger@lexisnexisrisk.com','Property Job Update' +(STRING8)Std.Date.Today(),'Property Job on hold due to '+keyword+'.Please view '+getnew[1].wuid);

end;
//**********************

//Launch CRON and EVENTS
LaunchFull := header.fSubmitNewWorkunit(ECL1, 'thor400_60')  ;  

Launchcron :=  if ( isdeltarunning ,
												      Sequential(output(dataset([{(STRING8)Std.Date.Today()}],{string8 filedate}),,'~thor::property_full_waiting_for_property_delta'),
															           sendemail('Last_Deltabuild_running')
																				 ),
													     Sequential(LaunchFull)
                      );
											
LaunchEvent :=  
                        Sequential( std.system.debug.sleep(600000),
												            sendemail('Last_WU_Failed_or_lastsuccessful_build_was_not_in_cert'),
		
																					Sequential(LaunchFull)
                                         );
              
 
 Launchcron : when(event('Build_FCRA_Header','*'));//(cron ('00 01 21 * *')); Changed trigger to run full only after header is built
 LaunchEvent : when(event ('Property_full_build_waiting_for_delta','*'));