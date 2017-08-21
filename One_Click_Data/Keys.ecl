import doxie, VersionControl;

export Keys(

	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false

) :=
module

	shared Base					:= Files(pversion).Base.Built;
	shared dkeybuild		:= project(base, transform(layouts.keybuild	,self := left));

	shared FilterBdids	:= dkeybuild(bdid	!= 0);
	shared FilterDids		:= dkeybuild(did	!= 0);
		
	versioncontrol.macBuildKeyVersions(FilterBdids	,{bdid}	  ,{FilterBdids	}	,keynames(pversion,pUseOtherEnvironment).Bdid		,Bdid  );
	versioncontrol.macBuildKeyVersions(FilterDids		,{did	}	  ,{FilterDids	}	,keynames(pversion,pUseOtherEnvironment).Did		,Did	 );

end;