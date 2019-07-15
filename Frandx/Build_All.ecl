import tools, _control, ut, std, Scrubs, Scrubs_Frandx;

export Build_All(

	 string															pversion
	,string															pDirectory			= '/data/data_build_1/frandx/in/'+ pversion
 ,string															pServerIP				= _control.IPAddress.bctlpedata11
	,string															pFilename				= '*txt'
	,string															pGroupName			= _dataset().groupname																		
	,boolean														pIsTesting			= false
	,boolean														pOverwrite			= false																															
	,dataset(Layouts.Input.Sprayed	)		pSprayedFile		= Files().Input.using
	,dataset(Layouts.Base						)		pBaseFile				= Files().base.qa	
) :=
function

	full_build :=
	sequential(
		 Create_Supers
		,Spray					(pversion,pServerIP,pDirectory,pFilename,pGroupName,pIsTesting,pOverwrite)
		,Build_Base			(pversion,pIsTesting,pSprayedFile,pBaseFile	)
		,Scrubs.ScrubsPlus('Frandx','Scrubs_Frandx','Scrubs_Frandx_Base', 'Base', pversion,Email_Notification_Lists(pIsTesting).BuildFailure,false)
		,Build_Keys			(pversion																		).all
		,Build_Strata		(pversion	,pOverwrite,,,	pIsTesting				)
		,Promote().Inputfiles.using2used
		,Promote().Buildfiles.Built2QA
		,QA_Records()
		
	) : success(Send_Emails(pversion,,not pIsTesting).Roxie), failure(send_emails(pversion,,not pIsTesting).buildfailure);
	
	return
		if(tools.fun_IsValidVersion(pversion),
				if(count(pSprayedFile(stringlib.stringfind(frn_start_date,'/',1) = 0 and frn_start_date<>'')) = 0,
						full_build,
						output('Invalid frn_start_Date field. Please contact data development. Skipping the Frandx Build.')
					),
				output('No Valid version parameter passed, skipping Frandx.Build_All')
			 );

end;