import business_header,VersionControl;

export Send_Emails(	 

	 string		pversion
	,boolean	pShouldUpdateRoxiePage	= true

) :=
function
	
	send_email := VersionControl.fCheckRoxiePackage(	 
						 business_header.Email_Notificaton_Lists.Roxie
						,'GovdataKeys'
						,	keynames(pversion).dAll_filenames
						,pversion
						,
						,pShouldUpdateRoxiePage
            ,'N'
						);
								
	return Send_Email;

end;