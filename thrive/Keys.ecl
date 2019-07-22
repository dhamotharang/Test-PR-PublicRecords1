import doxie, tools, ut;

export Keys(

	 string		pversion							= ''
	,boolean pUseProd = false

) :=
module

	shared Base					:= project(Files(pversion,pUseProd).Base.Built,transform(thrive.layouts.baseOld, self := left;));
	shared FilterBdids	:= Base(bdid	!= 0);
	shared FilterDids		:= Base(did		!= 0);
	
		tools.mac_FilesIndex('FilterBdids	,{bdid}	  ,{FilterBdids	}'	,keynames(pversion,pUseProd).Bdid		,Bdid  );
		tools.mac_FilesIndex('FilterDids		,{did	}	  ,{FilterDids	}'	,keynames(pversion,pUseProd).Did		,Did	 );
		tools.mac_FilesIndex('FilterDids		,{did	}	  ,{FilterDids	}'	,keynames(pversion,pUseProd).Did_fcra,Did_fcra	 );
end;
