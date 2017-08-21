#workunit('name','Property Full build');
import tools,std,dops,header;
 
ECL1 := 

'#option(\'multiplePersistInstances\',FALSE);\n'
+'#OPTION(\'AllowedClusters\',\'thor400_20,thor400_44,thor400_92,thor400_60\');\n'
+'#workunit(\'name\', \'property.build '+(STRING8)Std.Date.Today()+' .FULL\');\n'
+'LN_PropertyV2_Fast.proc0_build_all(\''+(STRING8)Std.Date.Today()+'\',false,\'Robert.Berger@lexisnexis.com  Sudhir.Kasavajjala@lexisnexis.com\');\n' ;


//**Get WU List
getwulist := workunitservices.WorkunitList ( lowwuid := '',jobname := 'property.build*' );

getnew := topn( sort ( getwulist,-wuid),1,-wuid );

validate_statecount := count(getnew ( state = 'completed'));

//** Verify if the previous Job did deployed to cert
cert_version 		:= dops.GetBuildVersion('LNPropertyV2FullKeys','B','N','C');

build_version_delta := (string) tools.fun_GetFilenameVersion ('~thor_data400::key::property_fast::qa::assessor.fid');
build_version_full := (string) tools.fun_GetFilenameVersion ('~thor_data400::key::ln_propertyv2::qa::assessor.fid');

getjobname := regexfind('DELTA',getnew[1].job);

build_version := if ( getjobname , build_version_delta ,build_version_full );

good_to_process_a_new_build :=  build_version = cert_version;

statusemail := FileServices.sendemail('sudhir.kasavajjala@lexisnexis.com','Property Job Update' +(STRING8)Std.Date.Today(), 'Property Job on hold due to previous job failure.Please view '+getnew[1].wuid);

ECL2 := header.fSubmitNewWorkunit(ECL1, 'thor400_60')  ;    

if ( validate_statecount = 1 and good_to_process_a_new_build ,Sequential(ECL2) ,Sequential('Property build is on hold due to previous WU not in completed state',statusemail)  ) : when(cron ('00 01 20 * *'));