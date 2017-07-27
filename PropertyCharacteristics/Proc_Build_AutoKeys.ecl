import AutoKeyB2; 

export	Proc_Build_AutoKeys(string	pVersion)	:=	function
	ak_dataset	:=	AK_Constants.ak_dataset;
	ak_keyname	:=	AK_Constants.ak_keyname;
	ak_logical	:=	AK_Constants.ak_logical(pVersion);
	ak_skipSet	:=	AK_Constants.ak_skipSet;
	ak_typeStr	:=	AK_Constants.ak_typeStr;

	AutoKeyB2.MAC_Build(	ak_dataset,
												blank,blank,blank,
												blank,
												zero,
												blank,
												prim_name,prim_range,st,v_city_name,zip,sec_range,
												zero,
												zero,zero,zero,
												zero,zero,zero,
												zero,zero,zero,
												zero,
												zero,
												blank,blank,blank,
												blank,blank,blank,blank,blank,blank,
												zero1,
												ak_keyname,
												ak_logical,
												outaction,false,
												ak_skipSet,true,ak_typeStr,
												true,,,zero
											)

	AutoKeyB2.MAC_AcceptSK_to_QA(ak_keyname,mymove,,ak_skipSet)

	retval	:=	sequential(outaction,mymove);

	return retval;
end;