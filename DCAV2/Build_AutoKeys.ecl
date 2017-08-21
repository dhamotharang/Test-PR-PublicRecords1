import autokeyb2;
export Build_AutoKeys(
	 string																		pversion
	,string																		pKeyDatasetName		= 'DCA'
	,dataset(layouts.base.autokeybuild_bdid	)	pFileAutokeyBdid	= File_Autokey().Bdid

) :=
module

	shared fns						:= keynames(pversion,,pKeyDatasetName);
	shared ak_keyname 		:= fns.lsuperautoTmplt; // @version@
	shared ak_logical 		:= fns.autokeyroot.logical;

	shared cnst       		:= _Constants();
	shared ak_skipSet 		:= cnst.ak_skipSet;
	shared ak_typeStr 		:= cnst.ak_typeStr;
	
	export Regular :=
	module
		AutoKeyB2.MAC_Build(pFileAutokeyBdid,blank,blank,blank,
												blank,
												zero,
												zero,
												blank_prim_name, blank_prim_range, blank_st, blank_city, blank_zip5, blank_sec_range, 
												zero,
												zero,zero,zero,
												zero,zero,zero,
												zero,zero,zero,
												zero,
												zero,
												company_name,
												zero,
												company_phone,
												Bus_addr.prim_name,Bus_addr.prim_range,Bus_addr.st,Bus_addr.p_city_name,Bus_addr.zip5,Bus_addr.sec_range,
												bdid,
												ak_keyname,
												ak_logical,
												build_dca_autokeys,false,
												ak_skipSet,true,ak_typeStr,
												true,,,bdid,false) ;

		export buildit := build_dca_autokeys;
		
	end;

	export all :=	
	sequential(
		 regular.buildit
		,Promote(pversion).buildfiles.New2Built
	);

end;