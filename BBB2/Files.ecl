import versioncontrol;

export Files(

	 string		pversion = ''
	,boolean	pUseProd = false

) :=
module

	export Input :=
	module

		versioncontrol.macInputFileVersions(Filenames(pversion,pUseProd).Input.Member		,Layouts_Files.Input.Member		,Member		,'listings/listing');
		versioncontrol.macInputFileVersions(Filenames(pversion,pUseProd).Input.NonMember,Layouts_Files.Input.NonMember,NonMember,'listings/listing');

	end;
	
	export Base :=
	module

		versioncontrol.macBuildFileVersions(Filenames(pversion,pUseProd).Base.Member		,Layouts_Files.Base.Member_BIP		 ,Member		);
		versioncontrol.macBuildFileVersions(Filenames(pversion,pUseProd).Base.NonMember	,Layouts_Files.Base.NonMember_BIP ,NonMember);
		
	end;

end;