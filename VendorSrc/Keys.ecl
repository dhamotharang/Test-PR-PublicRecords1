import doxie, tools;

export Keys(

	 string		pversion							= ''
	,boolean pUseProd = false

) :=
module

	shared Base					:= Files(pversion,pUseProd).Base.Built;

	shared FilterDids		:= Base(did		!= 0);
	
	tools.mac_FilesIndex('FilterDids		,{did	}	  ,{FilterDids	}'	,keynames(pversion,pUseProd).Did		,Did	 );
	
end;
