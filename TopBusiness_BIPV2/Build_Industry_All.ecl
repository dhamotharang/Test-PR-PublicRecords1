IMPORT BIPV2,TOOLS;

EXPORT Build_Industry_All(

	 string															            pversion   
	,dataset(Layouts.rec_industry_combined_layout	) pInFile			= BIPV2.Industry_sources
  ,boolean                                        pPromote2QA = true
) :=
function

	full_build := sequential(
									 Build_Industry_base    (pversion, pInFile).full_base
									,proc_build_Industry_key(pversion         ).full_build
									,if(pPromote2QA = true  ,Promote(pversion).Built2QA)
								) : success(Send_Email(pversion).buildsuccess), failure(send_email(pversion).buildfailure);

	return
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping TopBusiness_BIPV2.Build_Industry_All')
	);
end;