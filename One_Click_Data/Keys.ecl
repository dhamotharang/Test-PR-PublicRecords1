import doxie, VersionControl;

export Keys(

	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false

) :=
module

	shared Base					:= project(Files(pversion).Base.Built, transform(layouts.keybuild, self := left));

	shared FilterBdids	:= Base(bdid	!= 0);
	shared FilterDids		:= Base(did		!= 0);
	
	versioncontrol.macBuildKeyVersions(FilterBdids	,{bdid}	  ,{FilterBdids	}	,keynames(pversion,pUseOtherEnvironment).Bdid		,Bdid  );
	versioncontrol.macBuildKeyVersions(FilterDids		,{did	}	  ,{FilterDids	}	,keynames(pversion,pUseOtherEnvironment).Did		,Did	 );

end;