import doxie, tools;

export Keys(

	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false

) :=
module

	shared Base					:= project(Files(pversion).Base.Built, layouts.keybuild);

	shared FilterBdids	:= Base(bdid	!= 0);
	shared FilterDids		:= Base(did		!= 0);
	
	tools.mac_FilesIndex('FilterBdids	,{bdid}	  ,{FilterBdids	}'	,keynames(pversion,pUseOtherEnvironment).Bdid	,Bdid  );
	tools.mac_FilesIndex('FilterDids	,{did	}	  ,{FilterDids	}'	,keynames(pversion,pUseOtherEnvironment).Did	,Did	 );

end;