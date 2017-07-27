import ut ;
EXPORT fn_Validate := module

inputNFR := Score_Logs.Files.NonFCRA_Logs_Riskwise;
inputNFC 	:= Score_Logs.Files.NonFCRA_Logs_Custom ;
inputNFA := Score_Logs.Files.NonFCRA_Logs_Accurint;
inputFR 		:= Score_Logs.Files.FCRA_Logs_Riskwise;

//Check the counts
pRiskwiseCnts 														:=   nothor(FileServices.GetSuperFileSubCount(ut.foreign_logs + 'thor100_21::in::riskwise_acclogs_sl')) +
                                               nothor(FileServices.GetSuperFileSubCount(ut.foreign_logs + 'thor100_21::in::riskwise_acclogs_sl_preprocess'))      ;
pCustomCnts 															:=  nothor(FileServices.GetSuperFileSubCount(ut.foreign_logs + 'thor100_21::in::custom_acclogs_sl')) +
                                              nothor(FileServices.GetSuperFileSubCount(ut.foreign_logs + 'thor100_21::in::custom_acclogs_sl_preprocess'))           ;
pAccurintCnts 														:=  nothor(FileServices.GetSuperFileSubCount(ut.foreign_logs + 'thor100_21::in::accurint_acclogs_sl')) + 
                                               nothor(FileServices.GetSuperFileSubCount(ut.foreign_logs + 'thor100_21::in::accurint_acclogs_sl_preprocess'))  ;
pFCRARiskwiseCnts 								:=  nothor(FileServices.GetSuperFileSubCount(ut.foreign_fcra_logs + 'thor10_231::in::riskwise_acclogs_sl')) + 
                                       nothor(FileServices.GetSuperFileSubCount(ut.foreign_fcra_logs + 'thor10_231::in::riskwise_acclogs_sl_preprocess'))   ;
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

//Check if yesterday file is present in Superfile
dRiskIn :=  nothor(FileServices.SuperfileContents(ut.foreign_logs + 'thor100_21::in::riskwise_acclogs_sl'))  + 
             nothor(FileServices.SuperfileContents(ut.foreign_logs + 'thor100_21::in::riskwise_acclogs_sl_preprocess'))      ( regexfind(ut.getDate,name,0 ) <> '' );
dCustIn  := nothor(FileServices.SuperfileContents(ut.foreign_logs + 'thor100_21::in::custom_acclogs_sl'))  +
            nothor(FileServices.SuperfileContents(ut.foreign_logs + 'thor100_21::in::custom_acclogs_sl_preprocess'))    ( regexfind(ut.getDate,name,0 ) <> '' );
dAccIn  :=  nothor(FileServices.SuperfileContents(ut.foreign_logs + 'thor100_21::in::accurint_acclogs_sl')) +
             nothor(FileServices.SuperfileContents(ut.foreign_logs + 'thor100_21::in::accurint_acclogs_sl_preprocess'))  ( regexfind(ut.getDate,name,0 ) <> '' );
dRiskInFCRA :=  nothor(FileServices.SuperfileContents(ut.foreign_fcra_logs + 'thor10_231::in::riskwise_acclogs_sl')) +
                 nothor(FileServices.SuperfileContents(ut.foreign_fcra_logs + 'thor10_231::in::riskwise_acclogs_sl_preprocess'))   ( regexfind(ut.getDate,name,0 ) <> '' );


dFileExist :=  		map ( dRiskIn[1].name = '' => FAIL ( 'RISKWISE UPDATE FILE MISSING' ),
			                  dCustIn[1].name = '' => FAIL ( 'CUSTOM UPDATE FILE MISSING' ),
												dAccIn[1].name = '' =>  FAIL ( 'ACCURINT UPDATE FILE MISSING' ),
												dRiskInFCRA[1].name = '' => FAIL('FCRA RISKWISE UPDATE FILE MISSING'),
										Output('ALL UPDATE FILES EXIST'));
						 
dFileCounts := 	map (  count(inputNFR) = 0  =>  FAIL ( 'RISKWISE FILE COUNT IS 0' ),
															count(inputNFC) = 0  =>  FAIL ( 'CUSTOM FILE COUNT IS 0' ),
															count(inputNFA) = 0  =>  FAIL ( 'ACCURINT FILE COUNT IS 0' ),
															Output('ALL UPDATE FILE COUNTS ARE VALID'));
/*
// Run on Monday
fn_getfilevs ( string datein ,string keyword ) := function
dInMonday :=  nothor(FileServices.SuperfileContents(ut.foreign_logs + 'thor100_21::in::'+keyword+'_acclogs_sl')) ( name in [ regexreplace('~',ut.foreign_logs + 'thor100_21::in::'+datein+'::'+keyword+'_acclog_sl','')]);
dValidfile 		:= if ( count(dInMonday) = 0 and FileServices.FileExists (ut.foreign_logs + 'thor100_21::in::'+datein+'::'+keyword+'_acclog_sl') = false , FAIL ( 'ONE OF '+keyword+'UPDATE FILE MISSING ON MONDAY' ));
return   dValidfile;                                                                                                                     
end;

InquiryLogfcheck := Sequential ( fn_getfilevs(ut.getDateOffset(-1),'riskwise'),
                                 fn_getfilevs(ut.getDateOffset(-2),'riskwise'),
                                 fn_getfilevs(ut.getDate,'riskwise'),
																				fn_getfilevs(ut.getDateOffset(-1),'accurint'),
                                 fn_getfilevs(ut.getDateOffset(-2),'accurint'),
                                 fn_getfilevs(ut.getDate,'accurint'),
																				fn_getfilevs(ut.getDateOffset(-1),'custom'),
                                 fn_getfilevs(ut.getDateOffset(-2),'custom'),
                                 fn_getfilevs(ut.getDate,'custom'));
/*
dFileCntsMonday :=  map ( count(dRiskInMonday) <> 3 => FAIL ( 'ONE OF RISKWISE UPDATE FILE MISSING ON MONDAY' ),
																					count(dCustInMonday) <> 3 => FAIL ( 'ONE OF CUSTOM UPDATE FILE MISSING ON MONDAY' ),
																					count(dAccInMonday) <> 3 =>  FAIL ( 'ONE OF ACCURINT UPDATE FILE MISSING ON MONDAY' ),Output('ALL UPDATE FILES EXIST ON MONDAY') );*/

dCheckAll := Sequential ( dFileExist,dFileCounts);
export dall := Sequential( pValid_AllFiles ,dCheckAll );
end; 
                           
