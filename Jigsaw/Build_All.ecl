//Kick off the entire build
import tools,_control; 

export Build_All(
	
	 string														pversion
	,string														pDirectory					= '/hds_2/jigsaw/'
	,string														pServerIP						= _control.IPAddress.edata12
	,string														pFilename						= '*live*csv'
	,string														pFilename2					= '*dead*csv'
	,string														pFilename3					= '*delete*csv'
	,string														pGroupName					= _dataset().groupname																		
	,boolean													pIsTesting					= false
	,boolean													pOverwrite					= false													
	,dataset(Layouts.Input.Sprayed	)	pLiveSprayedFile		= Files().input.live.using
	,dataset(Layouts.Input.Sprayed	)	pDeadSprayedFile		= Files().input.dead.using
	,dataset(Layouts.Input.Sprayed	)	pLockedSprayedFile	= Files().input.deletedremove.using
	,dataset(Layouts.Base						)	pBaseFile						= Files().base.qa										

) :=
module

	export spray_files := if(pDirectory != ''
	and not(			
								_Flags.ExistJigsawLiveSprayed  
						and	_Flags.ExistJigsawDeadSprayed  
						and _Flags.ExistJigsawLockedSprayed
	
	)
		,fSprayFiles(
			 pversion
			,pDirectory
			,pServerIP 
			,pFilename
			,pFilename2
			,pFilename3
			,pGroupName
			,pIsTesting
			,pOverwrite

		));

	export full_build :=
	sequential(
		 create_supers
		,spray_files
		,Build_Base(pversion,pIsTesting,pLiveSprayedFile,pDeadSprayedFile,pLockedSprayedFile,pBaseFile).All
		,Build_Keys(pversion).all
		,Promote().buildfiles.Built2QA
		,if(not pIsTesting	,Strata_Population_Stats(pversion).Business_headers.all)
		,if(not pIsTesting	,Strata_Population_Stats(pversion).Business_Contacts.all)
		,QA_Records

	) : success(Send_Email(pversion,,not pIsTesting).Roxie), failure(send_email(pversion,,not pIsTesting).buildfailure);

	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping Jigsaw.Build_All')
	);

end;