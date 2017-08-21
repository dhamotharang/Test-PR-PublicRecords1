import prte_csv,_control;

export Proc_Build_BBB_Keys(string pIndexVersion)	:=
function

	rkeythor_data400__key__bbb__member__bdid		  	:= PRTE_CSV.BBB.rthor_data400__key__bbb__member__bdid				;
	rkeythor_data400__key__bbb__nonmember__bdid	    := PRTE_CSV.BBB.rthor_data400__key__bbb__nonmember__bdid		;
  rkeythor_data400__key__bbb__member__linkids			:= PRTE_CSV.BBB.rthor_data400__key__bbb__member__linkids		;
	rkeythor_data400__key__bbb__nonmember__linkids	:= PRTE_CSV.BBB.rthor_data400__key__bbb__nonmember__linkids	;
	
	dkeythor_data400__key__bbb__member__bdid 			  := project(PRTE_CSV.BBB.dthor_data400__key__bbb__member__bdid 				,rkeythor_data400__key__bbb__member__bdid				);
	dkeythor_data400__key__bbb__nonmember__bdid  	  := project(PRTE_CSV.BBB.dthor_data400__key__bbb__nonmember__bdid 			,rkeythor_data400__key__bbb__nonmember__bdid		);
  dkeythor_data400__key__bbb__member__linkids 		:= project(PRTE_CSV.BBB.dthor_data400__key__bbb__member__linkids 			,rkeythor_data400__key__bbb__member__linkids		);
	dkeythor_data400__key__bbb__nonmember__linkids  := project(PRTE_CSV.BBB.dthor_data400__key__bbb__nonmember__linkids 	,rkeythor_data400__key__bbb__nonmember__linkids	);

	kkeythor_data400__key__bbb__member__bdid 			  := index(dkeythor_data400__key__bbb__member__bdid 		  , {bdid}, {dkeythor_data400__key__bbb__member__bdid 		}, '~prte::key::bbb::' + pIndexVersion + '::member::bdid'		);
	kkeythor_data400__key__bbb__nonmember__bdid   	:= index(dkeythor_data400__key__bbb__nonmember__bdid    , {bdid}, {dkeythor_data400__key__bbb__nonmember__bdid  }, '~prte::key::bbb::' + pIndexVersion + '::nonmember::bdid');
  kkeythor_data400__key__bbb__member__linkids 		:= index(dkeythor_data400__key__bbb__member__linkids 		, {ultid,orgid,seleid,proxid,powid,empid,dotid}, {dkeythor_data400__key__bbb__member__linkids 		}, '~prte::key::bbb::' + pIndexVersion + '::member::linkids'	 );
	kkeythor_data400__key__bbb__nonmember__linkids 	:= index(dkeythor_data400__key__bbb__nonmember__linkids , {ultid,orgid,seleid,proxid,powid,empid,dotid}, {dkeythor_data400__key__bbb__nonmember__linkids  }, '~prte::key::bbb::' + pIndexVersion + '::nonmember::linkids');

	return 
	sequential(
		parallel(
			 build(kkeythor_data400__key__bbb__member__bdid 				,update)
			,build(kkeythor_data400__key__bbb__nonmember__bdid  		,update)
			,build(kkeythor_data400__key__bbb__member__linkids  		,update)
			,build(kkeythor_data400__key__bbb__nonmember__linkids  		,update)
		)
		,PRTE.UpdateVersion(
				'BBBKeys'													//	Package name
			 ,pIndexVersion												//	Package version
			 ,_control.MyInfo.EmailAddressNormal	//	Who to email with specifics
			 ,'N'																	//  auto_pkg (optional) -- don't use it
			 ,'N'																	//	N = Non-FCRA, F = FCRA
			 ,'N'                                 //	N = Do not also include boolean, Y = Include boolean, too
		)
	);

end;