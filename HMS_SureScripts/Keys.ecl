import doxie, tools;

export Keys(

	 string		pversion							= ''
	,boolean pUseProd = false

) :=
module
	shared Base				:= Files(pversion,pUseProd).Base.Built;

	shared FilterDids		:= Base(did		!= 0);
	shared Filterlnpid			:= Base((string)lnpid <> '');
	
	tools.mac_FilesIndex('FilterDids		,{did	}	  ,{FilterDids}'	,keynames(pversion,pUseProd).Did		,Did	 );
	tools.mac_FilesIndex('base		,{lnpid	}, {Filterlnpid}'	,keynames(pversion,pUseProd).lnpid		,lnpid	 );
	
end;
