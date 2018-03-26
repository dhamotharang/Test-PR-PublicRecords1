IMPORT _Control, ut, PRTE, PRTE2, PRTE2_Common;

EXPORT post_processing_actions( string pIndexVersion ) := FUNCTION
		//* ========== CopyMissingKeys, CopyEmptyFiles, and UpdateVersion can only be run in Prod: ========= *//
		string EMAIL_ADDRESS := PRTE2_Common.Email.EmailTargetSuccess;

		PROD_SEQ_STEPS := sequential(
												PRTE.UpdateVersion('EmergesKeys',										//	Package name
																					 pIndexVersion,												//	Package version
																					 _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
																					 'B',																	//	B = Boca, A = Alpharetta
																					 'N',																	//	N = Non-FCRA, F = FCRA
																					 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
																					),
												PRTE.UpdateVersion('FCRA_EmergesKeys',										//	Package name
																					 pIndexVersion,												//	Package version
																					 _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
																					 'B',																	//	B = Boca, A = Alpharetta
																					 'F',																	//	N = Non-FCRA, F = FCRA
																					 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
																					)
												);

		Running_in_production :=  PRTE2_Common.Constants.is_running_in_prod;
		Production_Steps_To_Do := IF(Running_in_production, PROD_SEQ_STEPS, OUTPUT('Skipping Production steps'));

		RETURN Production_Steps_To_Do;
END;
		