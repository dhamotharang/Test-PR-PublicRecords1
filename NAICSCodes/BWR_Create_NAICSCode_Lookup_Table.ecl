import tools, _control, ut, std, NAICSCodes;

export BWR_Create_NAICSCode_Lookup_Table(
	 string															        pversion
	,string															        pDirectory	       = '/data/temp/boneill/training/' +pversion
	,string															        pServerIP		       = _control.IPAddress.bctlpedata11
	,string															        pFilename		       = 'NAICS2017Codes.csv'
	,string															        pDnbDmiFilename    = 'naics_code_dnb_dmi.csv'
  ,string															        pGroupName	       = STD.System.Thorlib.Group( )	  		
	,boolean														        pIsTesting	       = false
	,boolean														        pOverwrite 	       = false
	,dataset(Layouts.Sprayed_Input)             pSprayedFile       = Files().Input.NAICS.using
	,dataset(Layouts.Sprayed_Input_DnbDmI)      pSprayedDnbDmiFile = Files().Input.DnbDmi.using
) :=
function

	full_build :=
	sequential(
		Create_Supers,		
		Spray(pversion,pServerIP,pDirectory,pFilename,pDnbDmiFileName,pGroupName,pIsTesting,pOverwrite),
		Build_Lookup_NAICSCodes(pversion,pIsTesting,pSprayedFile,pSprayedDnbDmiFile),
		Promote().Inputfiles.using2used,
		Promote().Buildfiles.Built2QA
	) 
	: success(Send_Emails(pversion,,TRUE).buildsuccess), 
	    failure(send_emails(pversion,,TRUE).buildfailure)
			;
	
	return
		if(tools.fun_IsValidVersion(pversion),
			full_build
			,output('No Valid version parameter passed, skipping Create NAICS Lookup Table')
		)
		;

end;