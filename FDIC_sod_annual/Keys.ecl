import doxie, tools,autokeyb2;

export Keys(

	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false

) :=
module

	shared Base					:= Files(pversion).Base.Built;
	//make full payload
	shared dkeybuild		:= project(Base, transform(layouts.keybuild, self := left));
	//use 1 dkeybuild for all
	shared FilterBdids	:= dkeybuild(bdid	!= 0);
	shared FilterCert		:= dkeybuild(rawfields.FDICCertificateNumber != 0);
	shared FilterOTS		:= dkeybuild(rawfields.OTSNumber != 0);
	
	//full payload
	tools.mac_FilesIndex('FilterBdids	,{bdid}	,{FilterBdids	}'	,keynames(pversion,pUseOtherEnvironment).Bdid			,Bdid 		);
	//full payload
	tools.mac_FilesIndex('FilterCert	,{rawfields.FDICCertificateNumber}	,{FilterCert }'	,keynames(pversion,pUseOtherEnvironment).cert			,cert	 		);
  //specify fields in LayoutOTS...	
	tools.mac_FilesIndex('FilterOTS	,{rawfields.OTSnumber},{FilterOTS }'	,keynames(pversion,pUseOtherEnvironment).ots			,ots	 		);

end;