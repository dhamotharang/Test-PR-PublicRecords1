import prte_csv,_control;

export Proc_Build_POESFROMUTILITIES_KEYS(string pIndexVersion)	:=
function
                                                                                                                                                                                                                                                                                                                          
	rkeythor_data400__key__PFU__bdid	:= PRTE_CSV.POESFROMUTILITIES.rthor_data400__key__PFU__bdid											;
	rkeythor_data400__key__PFU__did		:= PRTE_CSV.POESFROMUTILITIES.rthor_data400__key__PFU__did											;

	dkeythor_data400__key__PFU__bdid 	:= project(PRTE_CSV.POESFROMUTILITIES.dthor_data400__key__PFU__bdid ,rkeythor_data400__key__PFU__bdid	);
	dkeythor_data400__key__PFU__did 	:= project(PRTE_CSV.POESFROMUTILITIES.dthor_data400__key__PFU__did 	,rkeythor_data400__key__PFU__did	);

	kkeythor_data400__key__PFU__bdid 	:= index(dkeythor_data400__key__PFU__bdid , {bdid}, {dkeythor_data400__key__PFU__bdid }, '~prte::key::poesfromutilities::' + pIndexVersion + '::bdid'	);
	kkeythor_data400__key__PFU__did 	:= index(dkeythor_data400__key__PFU__did 	, {did}	, {dkeythor_data400__key__PFU__did 	}, '~prte::key::poesfromutilities::' + pIndexVersion + '::did'	);

	return 
	sequential(
		parallel(
			 build(kkeythor_data400__key__PFU__bdid 											,update)
			,build(kkeythor_data400__key__PFU__did 												,update)
		)
		,PRTE.UpdateVersion(
				'POEsFromUtilitiesKeys'													//	Package name
			 ,pIndexVersion												//	Package version
			 ,_control.MyInfo.EmailAddressNormal	//	Who to email with specifics
			 ,'N'																	//  auto_pkg (optional) -- don't use it
			 ,'N'																	//	N = Non-FCRA, F = FCRA
			 ,'N'                                 //	N = Do not also include boolean, Y = Include boolean, too
		)
	);

end;