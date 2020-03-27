import tools, _control, ut, std, SICCodes;

export BWR_Create_SicCode_Lookup_Table(
	 string															      pversion
	,string															      pDirectory	 = '/data/temp/boneill/training/' + pversion
	,string															      pServerIP		 = _control.IPAddress.bctlpedata11
	,string															      pFilename		 = 'DNB_DMI_sic_8_digit_codes.csv'
  ,string															      pGroupName	 = STD.System.Thorlib.Group( )	  		
	,boolean														      pIsTesting	 = false
	,boolean														      pOverwrite 	 = false																												
	,dataset(SICCodes.Layouts.Sprayed_Input	) pSprayedFile = Files().Input.using                  
	,dataset(SICCodes.Layouts.SICLookup )     pLookupFile  = Files().SICLookup.qa
) :=
function

	full_build :=
	sequential(
		SICCodes.Create_Supers,
		SICCodes.Spray(pversion,pServerIP,pDirectory,pFilename,pGroupName,pIsTesting,pOverwrite),
		SICCodes.Build_Lookup_SicCodes(pversion,pIsTesting,pSprayedFile,pLookupFile),
		SICCodes.Promote().Inputfiles.using2used,
		SICCodes.Promote().Buildfiles.Built2QA
	) 
	: success(SICCodes.Send_Emails(pversion,,FALSE).buildsuccess), 
	    failure(SICCodes.send_emails(pversion,,FALSE).buildfailure)
			;
	
	return
		if(tools.fun_IsValidVersion(pversion)
			,
			full_build
			,output('No Valid version parameter passed, skipping Create SIC Lookup Table')
		)
		;

end;