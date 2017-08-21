#workunit('name','Property Delta build');

import dops,header,std,ut,tools; 

ECL1 := 
'#option(\'multiplePersistInstances\',FALSE);\n'
+'#OPTION(\'AllowedClusters\',\'thor400_20,thor400_44,thor400_60\');\n'
+'#workunit(\'protect\', \'true\');\n'
+'#workunit(\'name\', \'property.build '+(STRING8)Std.Date.Today()+' .DELTA\');\n'
+'LN_PropertyV2_Fast.proc0_build_all(\''+(STRING8)Std.Date.Today()+'\',true,\'Sudhir.Kasavajjala@lexisnexis.com Robert.Berger@lexisnexis.com\');\n' ;

//** Get WU List
getwulist := workunitservices.WorkunitList ( lowwuid := '',jobname := 'property.build*delta' ); 
getnew 		:= topn( sort ( getwulist,-wuid),1,-wuid );

validate_statecount := count(getnew ( state = 'completed'));

//** Verify if the previous Job did deployed to cert
cert_version 		:= dops.GetBuildVersion('LNPropertyV2FullKeys','B','N','C');
prep_build_ok		:= if(FileServices.FileExists('~thor::property_prep_being_written_by_build'),false,true);
build_version 	:= (string) tools.fun_GetFilenameVersion ('~thor_data400::key::property_fast::qa::assessor.fid');

good_to_process_a_new_build :=  build_version = cert_version and prep_build_ok;

//** Verify to see if we have new files to process

new_updates_check := FileServices.GetSuperFileSubCount('~thor_data::in::ln_propertyv2::raw::bk::assessment')+ FileServices.GetSuperFileSubCount('~thor_data::in::ln_propertyv2::raw::bk::deed') + FileServices.GetSuperFileSubCount('~thor_data::in::ln_propertyv2::raw::bk::mortgage');

statusemail := FileServices.sendemail('sudhir.kasavajjala@lexisnexis.com Robert.Berger@lexisnexis.com','Property Job Update' +(STRING8)Std.Date.Today(), 'Property build is on hold due to : 1 previous WU not in completed state or '+'\n'+' 2: Last build was not  deployed to cert .Please view '+getnew[1].wuid);

LaunchDelta := header.fSubmitNewWorkunit(ECL1, 'thor400_60')  ;    

if ( validate_statecount = 1 and good_to_process_a_new_build and new_updates_check > 0,Sequential(LaunchDelta) ,Sequential('Property build is on hold ',statusemail)  ) : when(cron ('00 03 * * *'));

