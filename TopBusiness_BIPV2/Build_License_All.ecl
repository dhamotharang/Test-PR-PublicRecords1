IMPORT BIPV2,TOOLS;

EXPORT Build_License_All(

	 string															            pversion
	,dataset(Layouts.rec_license_combined_layout	)	pInFile			= BIPV2.License_sources
  ,boolean                                        pPromote2QA = true
) :=
function

	full_build := sequential(
									 Build_License_base     (pversion, pInFile).full_base
                  ,proc_build_License_key (pversion         ).full_build
									,if(pPromote2QA = true  ,Promote(pversion).Built2QA)
								) : success(Send_Email(pversion).buildsuccess), failure(send_email(pversion).buildfailure);

	return
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping TopBusiness_BIPV2.Build_License_All')
	);
  
end;