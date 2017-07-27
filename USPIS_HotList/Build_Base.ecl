import VersionControl;

export Build_Base(

	string		pversion
	,boolean	pOverwrite = true
) :=
module

	export dBase		:= Add_AID.fall(Files().Input.using);

	VersionControl.macBuildNewLogicalFile(Filenames(pversion).Base.new		,dBase		,Build_Base		,pOverwrite := pOverwrite);

	export full_build :=
		 sequential(
			 Promote().Sprayed2Using
			,Build_Base	
			,Promote(pversion).New2Built
		);
		
	export All :=
	if(VersionControl.IsValidVersion(pversion)
		,parallel(full_build)		
		,output('No Valid version parameter passed, skipping USPIS_HotList.Build_Base atribute')
	);
		
end;