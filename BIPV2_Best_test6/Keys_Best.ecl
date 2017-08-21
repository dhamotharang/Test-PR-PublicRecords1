import tools;
EXPORT Keys_Best (

	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false

) :=
module

    shared Base := Files(pversion).Base.Built;
		shared dkeybuild		:= project(Base, transform(layouts.key, self := left, self := []));
		tools.mac_FilesIndex('dkeybuild	,{proxid}	  ,{dkeybuild}'	,keynames(pversion,pUseOtherEnvironment).LinkIds, proxid);
end;

