import versioncontrol, _control;

export Build_All(

	 string		pversion
	,string		pGroupName							= _dataset().groupname																		
	,boolean	pIsTesting							= false
	,boolean	pOverwrite							= false																															

) :=
module

	export full_build := sequential(
		 Create_Supers
		,Build_Base(pversion).all
		,Build_Keys(pversion).all
		,Build_Strata(pversion,pOverwrite,,,pIsTesting)
		,Promote(pversion).Built2QA
		,QA_Records
	) : success(Send_Email(pversion).roxie), failure(send_email(pversion).buildfailure);
	
	export All :=
	if(VersionControl.IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping POEsFromEmails.Build_All')
	);

end;