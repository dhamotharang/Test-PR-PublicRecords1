import tools, _control, ut, std, VotersV2, _Validate;

export Proc_Build_OptOut(STRING pVersion
) :=
function

	build_file :=
		sequential(
			 VotersV2.fSpray_OptOut  (pVersion)
			,output(VotersV2.Clean_OptOut  (pversion),,VotersV2.cluster + 'in::Voters::OptOut::cleaned::'+pVersion,overwrite,__compressed__)
			,sequential(FileServices.StartSuperFileTransaction(),
									FileServices.AddSuperFile(VotersV2.cluster + 'in::Voters::OptOut::superfile'
																					 ,VotersV2.cluster + 'in::Voters::OptOut::cleaned::'+pVersion),
									FileServices.FinishSuperFileTransaction()) 		
							);
	
	return
		if(tools.fun_IsValidVersion(pVersion),
			 build_file,
			 output('No Valid version parameter passed, skipping VotersV2.Proc_Build_OptOut')
			);

end;

