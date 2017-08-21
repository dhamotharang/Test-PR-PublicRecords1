import doxie, tools, versioncontrol;

export Keys(

	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false

) :=
module

	shared Base					:= Files().Base.Built;
	shared dproj				:= project(base, transform(layouts.keybuild, self := left));
	
	shared FilterBdids	:= dproj(bdid	!= 0);
	shared FilterDids		:= dproj(did	!= 0);

	export Bdid    := tools.macf_FilesIndex('FilterBdids	,{bdid}	  ,{FilterBdids	  }'	,keynames(pversion,pUseOtherEnvironment).Bdid		  );
	export Did	   := tools.macf_FilesIndex('FilterDids		,{did	}	  ,{FilterDids	  }'	,keynames(pversion,pUseOtherEnvironment).Did		  );	
	VersionControl.macBuildNewLogicalKeyWithName(key_spoke_linkids.key									,keynames(pversion,pUseOtherEnvironment).LinkIDs.New, LinkID);
	export LinkIDs := LinkID;
end;