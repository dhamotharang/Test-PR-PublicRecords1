// Process to build the American Student List Files.
import Lib_FileServices, STRATA, ut;

mailTarget := 'julianne.franzer@lexisnexis.com';

send_mail (string pSubject, string pBody) := lib_fileservices.FileServices.sendemail(mailTarget, pSubject, pBody);

ut.MAC_SF_BuildProcess(American_student_list.Cleaned_american_student_DID,'~thor_data400::base::american_student_list',a);

build_base  := a : success(output('base files built successfully')), failure(output('build of base files failed'));

//build_base  := output(choosen(American_student_list.Cleaned_american_student_DID,100)) : success(output('base files built successfully')), failure(output('build of base files failed'));

build_keys  := American_student_list.Proc_build_keys : success(output('roxie key build completed')), failure(output('roxie key build failed'));

sequential(
			build_base
			,parallel(build_keys
            ,American_student_list.Out_Base_Stats_Population)
            ,send_mail('American Student List Build',' - building base file, keys & stats completed successfully '));