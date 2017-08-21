import versioncontrol;
export Build_All(string pversion) :=
module


	Build_State(pversion,NJ,'NJ','',Build_NJ);
	

	export full_build :=
	sequential(
		         Build_NJ.All
	 	        ) : success(send_email(pversion).buildsuccess), failure(send_email(pversion).buildfailure);

	export All :=
	if(VersionControl.IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping build')
	);

end;