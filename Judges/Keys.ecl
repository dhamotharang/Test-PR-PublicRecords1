import doxie, tools,autokeyb2;
export Keys(
	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false
) :=
module
	shared Base					:= Files(pversion).Base.Built;
	shared dkeybuild		:= project(Base, transform(layouts.keybuild, self := left));
	shared dbidkeybuild	:= project(Base, transform(layouts.keybuild,
	                                               self.bdid := left.bid, self := left));
	shared FilterBdids	:= dkeybuild(bdid	!= 0);
	shared FilterBids		:= dbidkeybuild(bdid != 0);
	shared FilterDids		:= dkeybuild(did	!= 0);
	
	tools.mac_FilesIndex('FilterBdids	,{bdid}	,{FilterBdids	}'	,keynames(pversion,pUseOtherEnvironment).Bdid			,Bdid 		);
	tools.mac_FilesIndex('FilterBids	,{bdid}	,{FilterBids	}'	,keynames(pversion,pUseOtherEnvironment).Bid			,Bid 			);
	tools.mac_FilesIndex('FilterDids	,{did	}	,{FilterDids	}'	,keynames(pversion,pUseOtherEnvironment).Did			,Did	 		);
	
end;
