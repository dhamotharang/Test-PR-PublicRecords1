import tools;
EXPORT Keys_Best (

	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false

) :=
module

    shared Base       := Files(pversion).Base.Built;
		shared dkeybuild  := project(Base, transform(layouts.key, self := left, self := []));
		export proxid     := tools.macf_FilesIndex('dkeybuild	,{proxid}	  ,{dkeybuild}'	,keynames(pversion,pUseOtherEnvironment).ProxID);
end;

