//Kick off the entire build
import versioncontrol,_control; 

export Build_All(
	
	 string														pversion
	,string														pDirectory			= '/prod_data_build_13/eval_data/jprichard/'
	,string														pServerIP				= _control.IPAddress.edata10
	,string														pFilename				= '*d00'
	,string														pGroupName			= _dataset().groupname																		
	,boolean													pIsTesting			= false
	,boolean													pOverwrite			= false													
	,dataset(Layouts.Input.Sprayed	)	pSprayedFile		= Files().input.using

) :=
module

	export spray_files := if(pDirectory != ''
	and not(			
								_Flags.ExistSprayed 
	
	)
		,fSprayFiles(
			 pversion
			,pDirectory
			,pServerIP 
			,pFilename
			,pGroupName
			,pIsTesting
			,pOverwrite

		));

	export full_build :=
	sequential(
		 create_supers()
		,spray_files
		,Build_Base(pversion,pIsTesting,pSprayedFile).All
		,Promote().Built2QA

	) : success(Send_Email(pversion,,not pIsTesting).buildsuccess), failure(send_email(pversion,,not pIsTesting).buildfailure);

	export All :=
	if(VersionControl.IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping lbentley_test.Build_All')
	);

end;