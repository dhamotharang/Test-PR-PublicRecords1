import tools, _control, ut, std, NAICSCodes;

export BWR_Create_NAICSCode_Lookup_Table(
	 string															        pversion
	,string															        pDirectory	 = '/data/temp/boneill/training/' + pversion
	,string															        pServerIP		 = _control.IPAddress.bctlpedata11
	,string															        pFilename		 = 'NAICS2017.csv'
  ,string															        pGroupName	 = STD.System.Thorlib.Group( )	  		
	,boolean														        pIsTesting	 = false
	,boolean														        pOverwrite 	 = false																												
	,dataset(NAICSCodes.Layouts.Sprayed_Input	) pSprayedFile = Files().Input.using                  
	,dataset(NAICSCodes.Layouts.NAICSLookup )   pLookupFile  = Files().NAICSLookup.qa
) :=
function

	full_build :=
	sequential(
		NAICSCodes.Create_Supers,
		NAICSCodes.Spray(pversion,pServerIP,pDirectory,pFilename,pGroupName,pIsTesting,pOverwrite),
		NAICSCodes.Build_Lookup_NAICSCodes(pversion,pIsTesting,pSprayedFile,pLookupFile),
		NAICSCodes.Promote().Inputfiles.using2used,
		NAICSCodes.Promote().Buildfiles.Built2QA
	) 
	: success(Send_Emails(pversion,,TRUE).buildsuccess), 
	    failure(send_emails(pversion,,TRUE).buildfailure)
			;
	
	return
		if(tools.fun_IsValidVersion(pversion)
			,
			full_build
			,output('No Valid version parameter passed, skipping Create NAICS Lookup Table')
		)
		;

end;