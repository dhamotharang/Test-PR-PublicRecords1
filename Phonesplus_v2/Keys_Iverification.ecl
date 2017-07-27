import doxie, tools;

export Keys_Iverification(

	 string		pversion							= ''
	,boolean pUseProd = false

) :=
module

	shared Base					:= File_Iverification.base(current_rec);

	shared FilterDids	:= Base(did	!= 0);
  shared Filterphones	:= Base(phone	!= '');
	  tools.mac_FilesIndex('Filterphones		,{phone	}	  ,{Filterphones	}'	,keynames_iverification(pversion,pUseProd).phone		,phone	 );	  
		tools.mac_FilesIndex('FilterDids		,{did, phone	}	  ,{FilterDids}'	,keynames_iverification(pversion,pUseProd).did_phone		,did_phone	 );
		
end;
