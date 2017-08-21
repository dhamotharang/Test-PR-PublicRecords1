import ut, Data_Services ;
EXPORT fn_Validate := module

inputNFR := Score_Logs.Files.NonFCRA_Logs_Riskwise;
inputNFC 	:= Score_Logs.Files.NonFCRA_Logs_Custom ;
inputNFA := Score_Logs.Files.NonFCRA_Logs_Accurint;
inputFR 		:= Score_Logs.Files.FCRA_Logs_Riskwise;

//Check the counts
pRiskwiseCnts 														:=   nothor(FileServices.GetSuperFileSubCount('~thor_data400::in::riskwise_acclogs_sl')) ;
pCustomCnts 															:=  nothor(FileServices.GetSuperFileSubCount( '~thor_data400::in::custom_acclogs_sl')) ;
pAccurintCnts 														:=  nothor(FileServices.GetSuperFileSubCount('~thor_data400::in::accurint_acclogs_sl')) ; 
pFCRARiskwiseCnts 								:=  nothor(FileServices.GetSuperFileSubCount( '~thor_data400::in::fcra_riskwise_acclogs_sl')) ;
pIntermediateLogsCnts 						:=  nothor(FileServices.GetSuperFileSubCount('~thor_data400::in::score_tracking::log_mbs_intermediate'))  ;
ptransactionLogsCnts 								:=  nothor(FileServices.GetSuperFileSubCount('~thor_data400::in::score_tracking::log_mbs_transaction_online'))  ;
pIntermediateFCRALogsCnts :=  nothor(FileServices.GetSuperFileSubCount('~thor_data400::in::score_tracking::log_mbs_fcra_intermediate'))  ;
ptransactionFCRALogsCnts 		:=  nothor(FileServices.GetSuperFileSubCount('~thor_data400::in::score_tracking::log_mbs_fcra_transaction_online'))  ;

pValid_AllFiles := map (  pRiskwiseCnts = 0  => FAIL('Thor Abort due to  Riswise Superfile File Empty'),
																	pCustomCnts = 0 => FAIL('Thor Abort due to  Custom Super File Empty'),
																	pAccurintCnts = 0 => FAIL('Thor Abort due to  Accurint Super File Empty'),
																	pFCRARiskwiseCnts = 0  => FAIL('Thor Abort due to  FCRA Riswise Super File Empty'),
																	pIntermediateLogsCnts = 0 => FAIL('Thor Abort due to  Intermediate NonFCRA Logs Super File Empty'),
																	ptransactionLogsCnts = 0 => FAIL('Thor Abort due to  Transaction NonFCRA Logs Super File Empty'),
																	pIntermediateFCRALogsCnts = 0 => FAIL('Thor Abort due to  Intermediate FCRA Logs Super File Empty'),
																	ptransactionFCRALogsCnts = 0 => FAIL('Thor Abort due to  Transaction FCRA Logs Super File Empty'),
																 
																 Output('All Counts Valid'));




						 
dFileCounts := 	map (  count(inputNFR) = 0  =>  FAIL ( 'RISKWISE FILE COUNT IS 0' ),
															count(inputNFC) = 0  =>  FAIL ( 'CUSTOM FILE COUNT IS 0' ),
															count(inputNFA) = 0  =>  FAIL ( 'ACCURINT FILE COUNT IS 0' ),
															Output('ALL UPDATE FILE COUNTS ARE VALID'));

export dall := Sequential( pValid_AllFiles ,dFileCounts );
end; 
                           
