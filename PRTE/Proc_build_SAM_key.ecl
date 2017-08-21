import	_control, SAM;

EXPORT Proc_build_SAM_key(string pIndexVersion) := function

#workunit('name','SAM PRTE')

df := dataset([],SAM.layout_bip_linkid);

		return sequential(buildindex(index(df,{ultid,orgid,seleid,proxid,powid,empid,dotid},{df},'keyname')
													,'~prte::key::SAM::' + pIndexVersion + '::linkids',update)
						  																	 ,
						PRTE.UpdateVersion('SAMKEYS',			       	//	Package name
						  							pIndexVersion,											//	Package version
							  						_control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
														 'B',																//	B = Boca, A = Alpharetta
														 'N',																//	N = Non-FCRA, F = FCRA
														 'N'));															//	N = Do not also include boolean, Y = Include boolean, too



 end;