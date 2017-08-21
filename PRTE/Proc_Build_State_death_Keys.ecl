import	_control, PRTE_CSV;

export Proc_Build_State_death_Keys (string pIndexVersion)	:=

function 

  rkey__did_statedeath_master_:=
	record
		PRTE_CSV.Did_Statedeath_Master.rthor_data400__key__did_statedeath_master_;
	end;
	
    dkey__did_statedeath_master		:= 	project(PRTE_CSV.Did_Statedeath_Master.dthor_data400__key__did_statedeath_master_, rkey__did_statedeath_master_);
	kkey__did_statedeath_master		:=	index(dkey__did_statedeath_master,{l_did},{dkey__did_statedeath_master}, '~prte::key::state_death_master::' + pIndexVersion + '::did');
return	sequential(
                   build(kkey__did_statedeath_master			, update), 
				   
				   PRTE.UpdateVersion('StatedeathKeys',										//	Package name
																				 pIndexVersion,												//	Package version
																				 _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
																				 'B',																	//	B = Boca, A = Alpharetta
																				 'N',																	//	N = Non-FCRA, F = FCRA
																				 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
																				)
										 );

end;