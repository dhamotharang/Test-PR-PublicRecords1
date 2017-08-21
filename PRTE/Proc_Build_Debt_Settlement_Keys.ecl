import prte_csv,_control;

export Proc_Build_Debt_Settlement_Keys(string pIndexVersion) :=
function
	rkeyDebt_Settlement__autokey__addressb2				:= PRTE_CSV.Debt_Settlement.rkey_debt_settlement__autokey__addressb2	;
	rkeyDebt_Settlement__autokey__citystnameb2		:= PRTE_CSV.Debt_Settlement.rkey_debt_settlement__autokey__citystnameb2	;
	rkeyDebt_Settlement__autokey__nameb2					:= PRTE_CSV.Debt_Settlement.rkey_debt_settlement__autokey__nameb2	;
	rkeyDebt_Settlement__autokey__namewords2			:= PRTE_CSV.Debt_Settlement.rkey_debt_settlement__autokey__namewords2	;
	rkeyDebt_Settlement__autokey__payload					:= PRTE_CSV.Debt_Settlement.rkey_debt_settlement__autokey__payload	;
	rkeyDebt_Settlement__autokey__phoneb2					:= PRTE_CSV.Debt_Settlement.rkey_debt_settlement__autokey__phoneb2	;
	rkeyDebt_Settlement__autokey__stnameb2				:= PRTE_CSV.Debt_Settlement.rkey_debt_settlement__autokey__stnameb2	;
	rkeyDebt_Settlement__autokey__zipb2						:= PRTE_CSV.Debt_Settlement.rkey_debt_settlement__autokey__zipb2	;
	rkeyDebt_Settlement__bdid											:= PRTE_CSV.Debt_Settlement.rkey_debt_settlement__bdid	;

	dkeyDebt_Settlement__autokey__addressb2 		:= project(PRTE_CSV.Debt_Settlement.dkey_debt_settlement__autokey__addressb2	,rkeyDebt_Settlement__autokey__addressb2		);
	dkeyDebt_Settlement__autokey__citystnameb2 	:= project(PRTE_CSV.Debt_Settlement.dkey_debt_settlement__autokey__citystnameb2	,rkeyDebt_Settlement__autokey__citystnameb2		);
	dkeyDebt_Settlement__autokey__nameb2 				:= project(PRTE_CSV.Debt_Settlement.dkey_debt_settlement__autokey__nameb2	,rkeyDebt_Settlement__autokey__nameb2		);
	dkeyDebt_Settlement__autokey__namewords2	 	:= project(PRTE_CSV.Debt_Settlement.dkey_debt_settlement__autokey__namewords2	,rkeyDebt_Settlement__autokey__namewords2		);
	dkeyDebt_Settlement__autokey__payload			 	:= project(PRTE_CSV.Debt_Settlement.dkey_debt_settlement__autokey__payload	,rkeyDebt_Settlement__autokey__payload		);
	dkeyDebt_Settlement__autokey__phoneb2			 	:= project(PRTE_CSV.Debt_Settlement.dkey_debt_settlement__autokey__phoneb2	,rkeyDebt_Settlement__autokey__phoneb2		);
	dkeyDebt_Settlement__autokey__stnameb2		 	:= project(PRTE_CSV.Debt_Settlement.dkey_debt_settlement__autokey__stnameb2	,rkeyDebt_Settlement__autokey__stnameb2		);
	dkeyDebt_Settlement__autokey__zipb2				 	:= project(PRTE_CSV.Debt_Settlement.dkey_debt_settlement__autokey__zipb2	,rkeyDebt_Settlement__autokey__zipb2		);
	dkeyDebt_Settlement__bdid									 	:= project(PRTE_CSV.Debt_Settlement.dkey_debt_settlement__bdid	,rkeyDebt_Settlement__bdid		);

	kkeyDebt_Settlement__autokey__addressb2				:= index(dkeyDebt_Settlement__autokey__addressb2 ,{prim_name,prim_range,st,city_code,zip,sec_range,cname_indic,cname_sec,bdid}	,{dkeyDebt_Settlement__autokey__addressb2}	,'~prte::key::debt_settlement::' + pIndexVersion + '::autokey::addressb2'	);
	kkeyDebt_Settlement__autokey__citystnameb2		:= index(dkeyDebt_Settlement__autokey__citystnameb2 ,{city_code,st,cname_indic,cname_sec,bdid}	,{dkeyDebt_Settlement__autokey__citystnameb2}	,'~prte::key::debt_settlement::' + pIndexVersion + '::autokey::citystnameb2'	);
	kkeyDebt_Settlement__autokey__nameb2					:= index(dkeyDebt_Settlement__autokey__nameb2 ,{cname_indic,cname_sec,bdid}	,{dkeyDebt_Settlement__autokey__nameb2}	,'~prte::key::debt_settlement::' + pIndexVersion + '::autokey::nameb2'	);
	kkeyDebt_Settlement__autokey__namewords2			:= index(dkeyDebt_Settlement__autokey__namewords2 ,{word,state,seq,bdid}	,{dkeyDebt_Settlement__autokey__namewords2}	,'~prte::key::debt_settlement::' + pIndexVersion + '::autokey::namewords2'	);
	kkeyDebt_Settlement__autokey__payload					:= index(dkeyDebt_Settlement__autokey__payload ,{fakeid}	,{dkeyDebt_Settlement__autokey__payload}	,'~prte::key::debt_settlement::' + pIndexVersion + '::autokey::payload'	);
	kkeyDebt_Settlement__autokey__phoneb2					:= index(dkeyDebt_Settlement__autokey__phoneb2 ,{p7,p3,cname_indic,cname_sec,st,bdid}	,{dkeyDebt_Settlement__autokey__phoneb2}	,'~prte::key::debt_settlement::' + pIndexVersion + '::autokey::phoneb2'	);
	kkeyDebt_Settlement__autokey__stnameb2				:= index(dkeyDebt_Settlement__autokey__stnameb2 ,{st,cname_indic,cname_sec,bdid}	,{dkeyDebt_Settlement__autokey__stnameb2}	,'~prte::key::debt_settlement::' + pIndexVersion + '::autokey::stnameb2'	);
	kkeyDebt_Settlement__autokey__zipb2						:= index(dkeyDebt_Settlement__autokey__zipb2 ,{zip,cname_indic,cname_sec,bdid}	,{dkeyDebt_Settlement__autokey__zipb2}	,'~prte::key::debt_settlement::' + pIndexVersion + '::autokey::zipb2'	);
	kkeyDebt_Settlement__bdid											:= index(dkeyDebt_Settlement__bdid ,{bdid}	,{dkeyDebt_Settlement__bdid}	,'~prte::key::debt_settlement::' + pIndexVersion + '::bdid'	);
	
	return 
	sequential(
		parallel(
			  build(kkeyDebt_Settlement__autokey__addressb2					,update)
			 ,build(kkeyDebt_Settlement__autokey__citystnameb2			,update)
			 ,build(kkeyDebt_Settlement__autokey__nameb2						,update)
			 ,build(kkeyDebt_Settlement__autokey__namewords2				,update)
			 ,build(kkeyDebt_Settlement__autokey__payload						,update)
			 ,build(kkeyDebt_Settlement__autokey__phoneb2						,update)
			 ,build(kkeyDebt_Settlement__autokey__stnameb2					,update)
			 ,build(kkeyDebt_Settlement__autokey__zipb2							,update)
			 ,build(kkeyDebt_Settlement__bdid												,update)
		)
		,PRTE.UpdateVersion(
				'Debt_SettlementKeys'								//	Package name
			 ,pIndexVersion												//	Package version
			 ,_control.MyInfo.EmailAddressNormal	//	Who to email with specifics
			 ,'N'																	//  auto_pkg (optional) -- don't use it
			 ,'N'																	//	N = Non-FCRA, F = FCRA
			 ,'N'                                 //	N = Do not also include boolean, Y = Include boolean, too
		)
	);

end;