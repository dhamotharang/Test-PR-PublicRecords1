// Process to build the PhonesFeedback files
import Lib_FileServices, STRATA, PromoteSupers, dops,Scrubs_PhonesFeedback, ut, std,tools;
export BWR_Build_PhonesFeedback(string filedate,string onlinefilename) := function
#workunit('name','Yogurt: PhonesFeedback Daily Build - ' + filedate);
#workunit('priority','high');

version := filedate;

mailTarget := 'skasavajjala@seisint.com;qualityassurance@seisint.com,kevin.reeder@lexisnexis.com';

send_mail (string pSubject, string pBody) := lib_fileservices.FileServices.sendemail(mailTarget, pSubject, pBody);

BuildType			:=	If (ut.Weekday((integer)(STRING8)Std.Date.Today()) = 'MONDAY', 
												'F',
												'D'
											);
											
GetBase		:=	phonesFeedback.proc_build_base(buildType) : independent;
NonFcra		:=	GetBase;

tools.mac_WriteFile(phonesFeedback.Cluster + 'base::PhonesFeedback_fcra_'+version	,GetBase	,PhonesFeedbackBase_fcra	,pShouldExport := false);
tools.mac_WriteFile(phonesFeedback.Cluster + 'base::PhonesFeedback_'+version	,NonFcra	,PhonesFeedbackBase	,pShouldExport := false);

build_base  := sequential(
														PhonesFeedbackBase_fcra,
														PhonesFeedbackBase,
														fileServices.StartSuperFileTransaction(),
														If (BuildType = 'F',
																	sequential(
																			fileServices.PromoteSuperFileList(['~thor_data400::base::phonesfeedback','~thor_data400::base::phonesfeedback_father'],phonesFeedback.Cluster + 'base::PhonesFeedback_'+version);
																			fileServices.PromoteSuperFileList(['~thor_data400::base::phonesfeedback_fcra','~thor_data400::base::phonesfeedback_fcra_father'],phonesFeedback.Cluster + 'base::PhonesFeedback_fcra_'+version);
																						),
																		sequential(				
																			fileServices.AddSuperFile('~thor_data400::base::phonesfeedback_fcra',phonesFeedback.Cluster + 'base::PhonesFeedback_fcra_'+version),
																			fileServices.AddSuperFile('~thor_data400::base::phonesfeedback',phonesFeedback.Cluster + 'base::PhonesFeedback_'+version)
																							)),
														fileServices.FinishSuperFileTransaction()
													)	: success(output('Build for base file successful'))	,																																																
									            failure(output('Build for base file FAILED'));
									
build_keys  := phonesFeedback.proc_build_phonesFeedback_keys(version,BuildType) : 
										success(output('Roxie key build successful')),
										failure(output('roxie key build FAILED'));

build_stats 	:= phonesFeedback.Out_Base_Stats_Population(version);
build_samples := PhonesFeedback.Out_qa_samples(version);
dops_update 	:= dops.updateversion('PhoneFeedbackKeys',version,'kevin.reeder@lexisnexis.com;Harry.Gist@lexisnexis.com',,'N',,l_updateflag:=BuildType);

build_all 		:=
sequential (	
							fSprayFilesOnline(version,onlinefilename),
							build_base,
							build_keys,
							build_stats,
							build_samples,
							dops_update,
							Scrubs_PhonesFeedback.fn_RunScrubs(filedate,''),
							send_mail('PhonesFeedback Build Completed',
							version + ' PhonesFeedback build for base file, keys, and stats completed successfully'));
							
return build_all;
end;