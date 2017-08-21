import doxie, tools;

export Keys(

	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false

) :=
module

	shared Base					:= Files(pversion).Base.Built;
	shared dkeybuild		:= project(base, transform(layouts.keybuild	,self := left));

	shared FilterBdids	:= dkeybuild(bdid	!= 0);
	shared FilterDids		:= dkeybuild(did	!= 0);
	
	export Bdid     := tools.macf_FilesIndex('FilterBdids	  ,{bdid}	  ,{FilterBdids	}'	  ,keynames(pversion,pUseOtherEnvironment).Bdid	    );
	export Did	    := tools.macf_FilesIndex('FilterDids		,{did	}	  ,{FilterDids	}'	  ,keynames(pversion,pUseOtherEnvironment).Did	    );

end;