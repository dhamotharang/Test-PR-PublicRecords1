import versioncontrol;
export Build_All(string pversion) :=
module


	Build_State(pversion,CA,'CA',Build_CA);
	Build_State(pversion,OH,'OH',Build_OH);
	Build_State(pversion,PA,'PA',Build_PA);
	Build_State(pversion,TX,'TX',Build_TX);

	export full_build :=
	sequential(
		 Build_CA.All
		,Build_OH.All
  	,Build_PA.All
		,Build_TX.All
	) : success(send_email(pversion).buildsuccess), failure(send_email(pversion).buildfailure);

	export All :=
	if(VersionControl.IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping build')
	);

end;