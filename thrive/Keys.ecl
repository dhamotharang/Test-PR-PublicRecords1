import doxie, tools, ut, vault, _control;

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

#IF(_Control.Environment.onVault) // when running on vault cluster, we need to use the file pointer instead of the roxie key in boca
		export did_fcra := vault.thrive.keys().Did_fcra;
#ELSE
		tools.mac_FilesIndex('FilterDids		,{did	}	  ,{FilterDids	}'	,keynames(pversion,pUseProd).Did_fcra,Did_fcra	 );
#END;		
		
end;
