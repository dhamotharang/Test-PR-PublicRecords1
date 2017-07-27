import doxie, VersionControl;

export Keys(

	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false

) :=
module

	shared Base					:= Files().Base.Built;
	shared dproj				:= project(base, transform(layouts.keybuild, self := left));
	
	shared FilterBdids	:= dproj(bdid	!= 0);
	shared FilterDids		:= dproj(did	!= 0);
	
	versioncontrol.macBuildKeyVersions(FilterBdids	,{bdid}	  ,{FilterBdids	}	,keynames(pversion,pUseOtherEnvironment).Bdid		,Bdid  );
	versioncontrol.macBuildKeyVersions(FilterDids		,{did	}	  ,{FilterDids	}	,keynames(pversion,pUseOtherEnvironment).Did		,Did	 );
	

end;