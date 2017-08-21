import versioncontrol, _control;

export Build_All(

	 string		pversion
	,string		pCorp_key		= ''
	,string		pServerIP		= _control.IPAddress.edata10
	,string		pDirectory	= '/prod_data_build_13/eval_data/commercial_fraud/'
	,string		pFilename		= 'appl_info_1m.d00'																
	,string		pGroupName	= _dataset().groupname																		
	,boolean	pIsTesting	= false
	,boolean	pOverwrite	= false																															

) :=
module

	export spray_files := if(pDirectory != '', fSprayFiles(
		 pServerIP
		,pDirectory 
		,pFilename
		,pversion
		,pGroupName
		,pIsTesting
		,pOverwrite

	));
	
	shared dAll_filenames := filenames().dAll_filenames;

	export full_build := sequential(
		 versioncontrol.mUtilities.createsupers(dAll_filenames)
		,spray_files
		,Build_Files(pversion).all
		,Promote().Built2QA
		,if(pCorp_key != '',fTesting(pversion,pCorp_key))
		,output(count(Files().input.dell.sprayed)	,named('count_Dell_input_File'))
		,output(count(Files().dell_out_append.qa)	,named('count_Dell_output_File'))
		,output(''	,named('_'))
		,output('Output Samples'	,named('__'))
		,output(Query_Samples())
		,output(''	,named('___'))
		,output('Stats Follow'	,named('____'))
		,Stats(pversion)
		,output(''	,named('_____'))
		,output('Output Persists Follow'	,named('______'))
		,output(persists())

	) : success(Send_Emails(pversion).buildsuccess), failure(send_emails(pversion).buildfailure);
	
	export All :=
	if(VersionControl.IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping Commercial_Fraud.Build_All')
	);

end;