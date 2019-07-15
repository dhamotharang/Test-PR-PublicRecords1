//Kick off the entire build
import versioncontrol,_control, Orbit3; 


export Build_All(
	
	 string														pversion
	,string														pDirectory			= '/data/prod_data_build_10/production_data/business_headers/one_click_data/data/'
	,string														pServerIP				= _control.IPAddress.bctlpedata10
	,string														pFilename				= '*csv'
	,string														pGroupName			= _dataset().groupname																		
	,boolean													pIsTesting			= false
	,boolean													pOverwrite			= false													
	,dataset(Layouts.Input.Sprayed	)	pSprayedFile		= Files().input.using
	,dataset(Layouts.Base						)	pBaseFile				= Files().base.qa										

) :=
function

	spray_files := 
	if(			pDirectory					!= ''
			and _Flags.ExistSprayed  = false
				,fSprayFiles(
					 pversion
					,pDirectory
					,pServerIP 
					,pFilename
					,pGroupName
					,//pIsTesting
					,pOverwrite

				)
	);

	full_build :=
	sequential(
		 create_supers
		,spray_files
		,Build_Base		(pversion,pIsTesting,pSprayedFile,pBaseFile	).All
		,Build_Keys		(pversion																		).all
		,Build_Strata	(pversion																		)
		,Promote().buildfiles.Built2QA
		,Orbit3.proc_Orbit3_CreateBuild_AddItem('One Click Data',pversion,'N'); 
	) : success(Send_Email(pversion,,not pIsTesting).Roxie), failure(send_email(pversion,,not pIsTesting).buildfailure);

	return
	if(VersionControl.IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping One_Click_Data.Build_All')
	);

end;