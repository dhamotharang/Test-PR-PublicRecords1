//EXPORT BWR_Property_Delta_build := '';
// THIS DEFINITION CONTAINS BWR CODE. Please COPY code out and it in a NEW Builder Window Runnable IF the monitor is not running
//** DF-11862 - To allow continuous delta, it does not check for full build, only if it's writting prep file, which cannot happen at the same time.

#workunit('name','Property Delta build');

import dops,header,std,tools; 

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

//** Verify if both current delta and previous full Jobs were deployed to cert, and if prep is not being writen by full build
cert_version 		:= dops.GetBuildVersion('LNPropertyV2FullKeys','B','N','C');
delta_version 	:= (string) tools.fun_GetFilenameVersion ('~thor_data400::key::property_fast::qa::assessor.fid');
full_version 		:= (string) tools.fun_GetFilenameVersion ('~thor_data400::key::ln_propertyv2::qa::assessor.fid');
dops_fhistory		:= dops.GetReleaseHistory('B', 'N', 'LNPropertyV2Keys')(updateflag[1]='F');

full_in_cert		:= (set(sort(dops_fhistory,-certversion), certversion)[1])=full_version;
delta_in_cert		:= delta_version=cert_version;
prep_build_ok		:= if(FileServices.FileExists('~thor::property_prep_being_written_by_build'),false,true);
good_to_process_a_new_build :=  full_in_cert and delta_in_cert and prep_build_ok;

statusemail := FileServices.sendemail('sudhir.kasavajjala@lexisnexis.com Robert.Berger@lexisnexis.com','Property Job Update' +(STRING8)Std.Date.Today(), 'Property build is on hold due to : 1 previous WU not in completed state or '+'\n'+' 2: Last build was not  deployed to cert .Please view '+getnew[1].wuid);

LaunchDelta := header.fSubmitNewWorkunit(ECL1, 'thor400_60')  ;    

if ( validate_statecount = 1 and good_to_process_a_new_build ,Sequential(LaunchDelta) ,Sequential('Property build is on hold ',statusemail)  ) : when(cron ('00 02 * * *'));


