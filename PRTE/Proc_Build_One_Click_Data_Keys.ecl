IMPORT prte_csv,_control;

EXPORT Proc_Build_One_Click_Data_Keys (string pIndexVersion)	:=
FUNCTION


  rkeythor_data400__key__one_click_data__bdid		 	:= PRTE_CSV.ONE_CLICK_DATA.rthor_data400__key__one_click_data__bdid				;
	rkeythor_data400__key__one_click_data__did	    := PRTE_CSV.ONE_CLICK_DATA.rthor_data400__key__one_click_data__did		;
  rkeythor_data400__key__one_click_data__linkids	:= PRTE_CSV.ONE_CLICK_DATA.rthor_data400__key__one_click_data__linkids		;
	
	dkeythor_data400__key__one_click_data__bdid 		:= PROJECT(PRTE_CSV.ONE_CLICK_DATA.dthor_data400__key__one_click_data__bdid 		,rkeythor_data400__key__one_click_data__bdid		);
	dkeythor_data400__key__one_click_data__did  	  := PROJECT(PRTE_CSV.ONE_CLICK_DATA.dthor_data400__key__one_click_data__did 			,rkeythor_data400__key__one_click_data__did	    );
  dkeythor_data400__key__one_click_data__linkids 	:= PROJECT(PRTE_CSV.ONE_CLICK_DATA.dthor_data400__key__one_click_data__linkids 	,rkeythor_data400__key__one_click_data__linkids	);

  kkeythor_data400__key__one_click_data__bdid 		:= INDEX(dkeythor_data400__key__one_click_data__bdid 		, {bdid}, {dkeythor_data400__key__one_click_data__bdid 		}, '~prte::key::one_click_data::' + pIndexVersion + '::bdid'		);
	kkeythor_data400__key__one_click_data__did   	  := INDEX(dkeythor_data400__key__one_click_data__did     , {did}, {dkeythor_data400__key__one_click_data__did  }, '~prte::key::one_click_data::' + pIndexVersion + '::did');
  kkeythor_data400__key__one_click_data__linkids 	:= INDEX(dkeythor_data400__key__one_click_data__linkids , {ultid,orgid,seleid,proxid,powid,empid,dotid}, {dkeythor_data400__key__one_click_data__linkids 		}, '~prte::key::one_click_data::' + pIndexVersion + '::linkids'	 );

  RETURN 
	sequential(
		parallel(
			 build(kkeythor_data400__key__one_click_data__bdid 			,update)
			,build(kkeythor_data400__key__one_click_data__did    		,update)
			,build(kkeythor_data400__key__one_click_data__linkids		,update)
		)
		,PRTE.UpdateVersion(
				'OneClickDataKeys'									//	Package name
			 ,pIndexVersion												//	Package version
			 ,_control.MyInfo.EmailAddressNormal	//	Who to email with specifics
			 ,'N'																	//  auto_pkg (optional) -- don't use it
			 ,'N'																	//	N = Non-FCRA, F = FCRA
			 ,'N'                                 //	N = Do not also include boolean, Y = Include boolean, too
		)
	);
END;