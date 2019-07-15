// Process to build the PhonesFeedback files
import Lib_FileServices, STRATA, PromoteSupers, dops,Scrubs_PhonesFeedback;
export BWR_Build_PhonesFeedback(string filedate,string onlinefilename) := function
#workunit('name','Yogurt: PhonesFeedback Daily Build - ' + filedate);
#workunit('priority','high');

version := filedate;

mailTarget := 'skasavajjala@seisint.com;qualityassurance@seisint.com,kevin.reeder@lexisnexis.com';

send_mail (string pSubject, string pBody) := lib_fileservices.FileServices.sendemail(mailTarget, pSubject, pBody);

PromoteSupers.MAC_SF_BuildProcess(phonesFeedback.proc_build_base,phonesFeedback.Cluster + 'base::PhonesFeedback_fcra',PhonesFeedbackBase,3,false,true);

// create an fcra-named base and then copy to regular base
filename := FileServices.GetSuperFileSubName('~thor_data400::base::phonesfeedback_fcra',1,true);
filenameNew := regexreplace('_fcra',filename,'');
copyFcraLogical := phonesfeedback.File_PhonesFeedback_Base_fcra;

concat_file := 	sequential( fConcatIn ( filedate,'customer') , fConcatIn ( filedate,'online') ) : 
                          success(output('Concatenated both customer and online files success')),
                          failure(output('Customer and Online files concatenate failed')) ;
													
promoteraw2hist := Sequential(													
													fileServices.StartSuperFileTransaction(),
													//commented due to locks happening on superfile
													//fileServices.AddSuperFile('~thor_data400::in::phonesfeedback_fcra::customer::hist','~thor_data400::in::phonesfeedback_fcra::sprayed::customer',,true),
													fileServices.ClearSuperFile('~thor_data400::in::phonesfeedback_fcra::sprayed::customer'),
													//fileServices.AddSuperFile('~thor_data400::in::phonesfeedback_fcra::online::hist','~thor_data400::in::phonesfeedback_fcra::sprayed::online',,true),
													fileServices.ClearSuperFile('~thor_data400::in::phonesfeedback_fcra::sprayed::online'),
                          fileServices.FinishSuperFileTransaction()
													                );
 

build_base  := PhonesFeedbackBase : success(output('Build for base file successful'))	,																																																
									                  failure(output('Build for base file FAILED'));
									
promote2base := Sequential(
										output(copyFcraLogical,,filenameNew,__COMPRESSED__,overwrite),
										fileServices.StartSuperFileTransaction(),
										fileServices.RemoveOwnedSubFiles('~thor_data400::base::phonesfeedback',true),
										fileServices.AddSuperFile('~thor_data400::base::phonesfeedback',filenameNew),
										fileServices.FinishSuperFileTransaction()
							                   );

build_keys  := phonesFeedback.proc_build_phonesFeedback_keys(version) : 
							success(output('Roxie key build successful')),
							failure(output('roxie key build FAILED'));

build_stats 	:= phonesFeedback.Out_Base_Stats_Population(version);
build_samples := PhonesFeedback.Out_qa_samples;
dops_update 	:= dops.updateversion('PhoneFeedbackKeys',version,'kevin.reeder@lexisnexis.com;Harry.Gist@lexisnexis.com',,'N');
idops_update 	:= dops.updateversion('PhoneFeedbackKeys',version,'kevin.reeder@lexisnexis.com;Harry.Gist@lexisnexis.com',,'N',,,'A');
ORBITi 				:= PhonesFeedback.Proc_OrbitI_CreateBuild(version,'nonfcra');
 
build_all 		:=
sequential (fSprayFilesOnline(onlinefilename),
       concat_file,
			 promoteraw2hist,
			 build_base,
			 promote2base,
		   parallel(build_keys, build_stats),
			 build_samples,
		   dops_update,
			 Scrubs_PhonesFeedback.fn_RunScrubs(filedate,''),
			 // idops_update,
			 // ORBITi,
       send_mail('PhonesFeedback Build Completed',
			 version + ' PhonesFeedback build for base file, keys, and stats completed successfully'));
return build_all;
end;