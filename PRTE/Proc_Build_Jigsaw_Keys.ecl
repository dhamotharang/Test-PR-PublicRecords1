IMPORT prte_csv,_control;

EXPORT Proc_Build_Jigsaw_Keys (string pIndexVersion)	:=
FUNCTION

	rkeythor_data400__key__jigsaw__bdid		 	:= PRTE_CSV.Jigsaw.rthor_data400__key__jigsaw_bdid;
	rkeythor_data400__key__jigsaw__did	    := PRTE_CSV.Jigsaw.rthor_data400__key__jigsaw_did;
  rkeythor_data400__key__jigsaw__linkids	:= PRTE_CSV.Jigsaw.rthor_data400__key__jigsaw_linkids;
	
	dkeythor_data400__key__jigsaw__bdid 		:= project(PRTE_CSV.Jigsaw.dthor_data400__key__jigsaw__bdid 			,rkeythor_data400__key__jigsaw__bdid		);
	dkeythor_data400__key__jigsaw__did  	  := project(PRTE_CSV.Jigsaw.dthor_data400__key__jigsaw__did 		  	,rkeythor_data400__key__jigsaw__did		  );
  dkeythor_data400__key__jigsaw__linkids 	:= project(PRTE_CSV.Jigsaw.dthor_data400__key__jigsaw__linkids 		,rkeythor_data400__key__jigsaw__linkids	);

	kkeythor_data400__key__jigsaw__bdid 		:= index(dkeythor_data400__key__Jigsaw__bdid 		  , {bdid}, {dkeythor_data400__key__jigsaw__bdid 		}, '~prte::key::jigsaw::' + pIndexVersion + '::bdid'		);
	kkeythor_data400__key__jigsaw__did   	  := index(dkeythor_data400__key__Jigsaw__did       , {did}, {dkeythor_data400__key__jigsaw__did  }, '~prte::key::jigsaw::' + pIndexVersion + '::did');
  kkeythor_data400__key__jigsaw__linkids 	:= index(dkeythor_data400__key__Jigsaw__linkids 	, {ultid,orgid,seleid,proxid,powid,empid,dotid}, {dkeythor_data400__key__jigsaw__linkids 		}, '~prte::key::jigsaw::' + pIndexVersion + '::linkids'	 );

	return 
	sequential(
		parallel(
			 build(kkeythor_data400__key__jigsaw__bdid 		 ,update)
			,build(kkeythor_data400__key__jigsaw__did  		 ,update)
			,build(kkeythor_data400__key__jigsaw__linkids  ,update)
		)
		,PRTE.UpdateVersion(
				'JigsawKeys'												//	Package name
			 ,pIndexVersion												//	Package version
			 ,_control.MyInfo.EmailAddressNormal	//	Who to email with specifics
			 ,'N'																	//  auto_pkg (optional) -- don't use it
			 ,'N'																	//	N = Non-FCRA, F = FCRA
			 ,'N'                                 //	N = Do not also include boolean, Y = Include boolean, too
		)
	);

end;