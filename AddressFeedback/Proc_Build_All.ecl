Import Lib_FileServices, STRATA, PromoteSupers, Roxiekeybuild, _control, dops, scrubs, scrubs_addressfeedback;
Export Proc_Build_All(String InFileName, String Filedate) := Function
#workunit('name','Yogurt: AddressFeedback Build - ' + filedate);
#workunit('priority','high');
// mailTarget := 'skasavajjala@seisint.com;qualityassurance@seisint.com;jfreibaum@seisint.com';
fspray := AddressFeedback.fSprayInFile(InFileName, Filedate);
PromoteSupers.MAC_SF_BuildProcess(AddressFeedback.Proc_Build_Base, '~thor_data400::base::AddressFeedback', AddressFeedbackBase, 3, false, true);
filename := FileServices.GetSuperFileSubName('~thor_data400::base::AddressFeedback',1,true);


build_base := AddressFeedbackBase : success(
									sequential(
										output('Build for base file successful'),
										fileServices.StartSuperFileTransaction(),
										fileServices.ClearSuperFile('~thor_data400::base::AddressFeedback',true),
										fileServices.AddSuperFile('~thor_data400::base::AddressFeedback',filename),
										fileServices.FinishSuperFileTransaction()
							                   )),
									failure(output('Build for base file FAILED'));

build_keys := AddressFeedback.Proc_Build_AddressFeedback_keys(filedate) : 
							success(output('Roxie key build successful')),
							failure(output('roxie key build FAILED'));
build_stats 	:= AddressFeedback.Out_Base_Stats_Population(filedate);
build_qa_sample := AddressFeedback.Out_qa_samples;

run_Scrubs		:= Scrubs_AddressFeedback.fn_RunScrubs(filedate);
dops_update 	:= If(scrubs.mac_ScrubsFailureTest('scrubs_addressfeedback',filedate),dops.updateversion('AddressFeedbackKeys',Filedate,'kevin.reeder@lexisnexis.com',,'N'),OUTPUT('Scrubs failed due to rejection warnings',NAMED('Scrubs_Failure')));

//////** Delete Sprayed File 
Delete_Files(STRING pInFileName) := FUNCTION
removefile := FileServices.DeleteExternalFile(_control.IPAddress.bctlpedata10,'/data/hds_2/address_feedback/online/'+pInFileName);


RETURN removefile;
END;
// idops_update 	:= RoxieKeyBuild.updateversion('AddressFeedbackKeys',Filedate,'jfreibaum@seisint.com',,'N',,,'A');
// ORBITi 				:= AddressFeedback.Proc_OrbitI_CreateBuild(Filedate,'nonfcra');

Build_All := 	Sequential(
											fspray
											,build_base		
											,parallel(build_keys, build_stats)
											,build_qa_sample
											,run_scrubs
											,dops_update
											// idops_update,
											// ORBITi,*/
                       ,Delete_Files(InFileName) //deletes the txt file from online directory on linux box
											);

Return Build_All;
End;