import	_control, PRTE_CSV;

EXPORT Proc_Build_Deltabase_Gateway_Keys(string pIndexVersion):= function

//Deltabase Gateway Historic Results Key
	rKeyDeltabaseGateway_Historic_Results := record
		PRTE_CSV.DeltabaseGateway.rthor_data400_key_deltabasegateway_historic_results;
	end;
	
	dKeyDeltabaseGateway_Historic_Results		:= project(PRTE_CSV.DeltabaseGateway.dthor_data400_key_deltabasegateway_historic_results, rKeyDeltabaseGateway_Historic_Results);
	kKeyDeltabaseGateway_Historic_Results		:=	index(dKeyDeltabaseGateway_Historic_Results, {submitted_phonenumber, transaction_id, batch_job_id, sequence_number}, {dKeyDeltabaseGateway_Historic_Results}, '~prte::key::' + pIndexVersion + '::deltabase_gateway::historic_results');
	
	return	sequential(
																build(kKeyDeltabaseGateway_Historic_Results, update),
																					PRTE.UpdateVersion('DeltaGtwyHistKeys',	//	Package name
																					pIndexVersion,																										//	Package version
																					_control.MyInfo.EmailAddressNormal,					//	Who to email with specifics
																					'B',																			//	B = Boca, A = Alpharetta
																					'N',																			//	N = Non-FCRA, F = FCRA
																					'N'																				//	N = Do not also include boolean, Y = Include boolean, too
																					)
										 );

end;