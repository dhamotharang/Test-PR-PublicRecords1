import doxie, VersionControl,autokeyb2;

export Keys(

	 string		pversion									= ''
	,boolean	pUseOtherEnvironment			= false
	,boolean	pFileUseOtherEnvironment	= false

) :=
module

	shared Base					:= Files(pversion,pFileUseOtherEnvironment).Base.Built;
	shared dSourceHier	:= File_Source_Hierarchy;

	shared dkeybuild		:= project(Base, transform(layouts.keybuild, self := left));
	
	shared FilterBdids	:= dkeybuild(bdid	!= 0);
	shared FilterDids		:= dkeybuild(did	!= 0);
	
	versioncontrol.macBuildKeyVersions(FilterBdids	,{bdid}	  						,{FilterBdids	}	,keynames(pversion,pUseOtherEnvironment).Bdid							,Bdid 						);
	versioncontrol.macBuildKeyVersions(FilterDids		,{did	}	  						,{FilterDids	}	,keynames(pversion,pUseOtherEnvironment).Did							,Did	 						);
	versioncontrol.macBuildKeyVersions(dkeybuild		,{unsigned6 FakeID	}	,{dkeybuild		}	,keynames(pversion,pUseOtherEnvironment).Payload					,Payload					);	//autokey payload key
	versioncontrol.macBuildKeyVersions(dSourceHier	,{source}	 						,{dSourceHier	}	,keynames(pversion,pUseOtherEnvironment).Source_Hierarchy	,Source_Hierarchy	);
	
end;