//Kick off the entire build
import versioncontrol,_control, Orbit3, Scrubs, Scrubs_One_Click_Data ; 


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
					,pIsTesting
					,pOverwrite

				)
	);
	
RunScrubs  :=scrubs.ScrubsPlus('One_Click_Data', 'Scrubs_One_Click_Data', 'Scrubs_One_Click_Data_Raw', 'raw', pversion, One_Click_Data.Email_Notification_Lists.Stats, false);

full_build :=
	sequential(
		 create_supers
		,spray_files
		,RunScrubs
    ,if(Scrubs.mac_ScrubsFailureTest('Scrubs_One_Click_Data', pversion)
   			,sequential( Build_Base		(pversion,pIsTesting,pSprayedFile,pBaseFile	).All
									  ,Build_Keys		(pversion																		).all
										,Build_Strata	(pversion																		)
										,Promote().buildfiles.Built2QA
										,Promote().Inputfiles.using2used
										,Orbit3.proc_Orbit3_CreateBuild_AddItem('One Click Data',pversion,'N'); 
									 ) 	
   			,fail('Raw data scrubs failed.  Build processing stopped.  Resolve scrubs issues before you run again.')
   		 )): success(Send_Email(pversion,,not pIsTesting).Roxie), failure(send_email(pversion,,not pIsTesting).buildfailure);

	return
	if(VersionControl.IsValidVersion(pversion)
		 ,full_build
		 ,output('No Valid version parameter passed, skipping One_Click_Data.Build_All')
	  );

end;