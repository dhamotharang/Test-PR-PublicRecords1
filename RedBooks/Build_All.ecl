import versioncontrol;
export Build_All(string pversion,string pDirectory) :=
module
 
 export full_build := Build_Combined(pVersion,pDirectory)
	
	 : success(send_email(pversion).buildsuccess), failure(send_email(pversion).buildfailure);

	export All :=
	if(VersionControl.IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping build')
	);

end;