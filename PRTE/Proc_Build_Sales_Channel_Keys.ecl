import prte_csv,_control;

export Proc_Build_Sales_Channel_Keys(string pIndexVersion)	:=
function

	rkey_bdid		:= PRTE_CSV.Sales_Channel.rkey_bdid	;
	rkey_did	  := PRTE_CSV.Sales_Channel.rkey_bdid	;

	dkey_bdid 	:= project(PRTE_CSV.Sales_Channel.dkey_bdid	,rkey_bdid		);
	dkey_did  	:= project(PRTE_CSV.Sales_Channel.dkey_did  ,rkey_did			);

	kkey_bdid		:= index(dkey_bdid	,{bdid}	,{dkey_bdid	}	,'~prte::key::saleschannel::' + pIndexVersion + '::bdid'	);
	kkey_did 		:= index(dkey_did   ,{bdid}	,{dkey_did  }	,'~prte::key::saleschannel::' + pIndexVersion + '::did'		);

	return 
	sequential(
		parallel(
			 build(kkey_bdid			,update)
			,build(kkey_did   		,update)
		)
		,PRTE.UpdateVersion(
				'SalesChannelKeys'													//	Package name
			 ,pIndexVersion												//	Package version
			 ,_control.MyInfo.EmailAddressNormal	//	Who to email with specifics
			 ,'N'																	//  auto_pkg (optional) -- don't use it
			 ,'N'																	//	N = Non-FCRA, F = FCRA
			 ,'N'                                 //	N = Do not also include boolean, Y = Include boolean, too
		)
	);

end;