import doxie, tools;

export Keys_Scoring(

	 string		pversion							= ''
	,boolean pUseProd = false

) :=
module

	shared Base					:= Phonesplus_v2.File_Scoring.base;

	shared FilterAddress	:= Base(trim(prim_name + prim_range, all) != '' and (unsigned)zip5 > 0);
  shared Filterphone	:= Base(cellphone	!= '');
	  tools.mac_FilesIndex('FilterAddress		,{prim_name, zip5, prim_range, sec_range,predir, addr_suffix}	  ,{FilterAddress	}'	,keynames_scoring(pversion,pUseProd).address		,address);	  
		tools.mac_FilesIndex('FilterPhone		,{cellphone	}	  ,{FilterPhone}'	,keynames_scoring(pversion,pUseProd).phone		,phone	 );
		
end;
