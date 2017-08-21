import ut, business_header, versioncontrol, _control;

export Proc_Build_ACA(

	 string		pversion
	,string		pServerIP								= _control.IPAddress.edata10
	,string		pDirectory							= '/prod_data_build_10/production_data/business_headers/aca/'
	,string		pFilename								= 'aca*csv'
	,boolean	pOverwrite							= false
	,boolean	pShouldUpdateRoxiePage	= false

) :=
function

	spray_files := if(pDirectory != '' and pServerIP != '' and pFilename != ''
	,fSprayFiles(
		 pServerIP	
		,pDirectory	
		,pFilename	
		,pversion
		,,
		,pOverwrite
	));
	
	VersionControl.macBuildNewLogicalKeyWithName(aca.key_aca_addr	,keynames(pversion).Address.New	,BuildACAkey	);

	do_all :=
	sequential(
		 spray_files
		,BuildACAkey
		,promote(pversion).new2built
		,promote(pversion).built2qa
	) : success(Send_Emails(pversion,,pShouldUpdateRoxiePage).Roxie) , failure(Send_Emails(pversion).BuildFailure);

	return
	if(VersionControl.IsValidVersion(pversion)
		,do_all
		,output('No Valid version parameter passed, skipping ACA.Proc_Build_ACA')
	);

end;