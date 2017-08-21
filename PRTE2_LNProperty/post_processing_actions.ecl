IMPORT _Control, ut, PRTE, PRTE2, PRTE2_Common;

EXPORT post_processing_actions(boolean is_test_run, string filedate, string pIndexOldVersion, string pFCRAOldVersion) := FUNCTION
		//* ========== CopyMissingKeys, CopyEmptyFiles, and UpdateVersion can only be run in Prod: ========= *//
		string EMAIL_ADDRESS := PRTE2_Common.Email.DOPSInterestEmails;
		CopyMissingKeys := SEQUENTIAL(
																PRTE.CopyMissingKeys('LNPropertyV2Keys',filedate,pIndexOldVersion,'N','Y')
																,PRTE.CopyMissingKeys('FCRA_LNPropertyV2Keys',filedate,pFCRAOldVersion,'F')
																);
		PROD_SEQ_STEPS := Sequential (
						CopyMissingKeys
						,PRTE.UpdateVersion('LNPropertyV2Keys',		//	Package name
												filedate,												//	Package version
												EMAIL_ADDRESS,									//	Who to email with specifics
												'B',														//	B = Boca,A = Alpharetta
												'N',														//	N = Non-FCRA,F = FCRA
												'N'															//	N = Do not also include boolean,Y = Include boolean,too
											) 
						,PRTE.UpdateVersion('FCRA_LNPropertyV2Keys',	//	Package name
											filedate,												//	Package version
											EMAIL_ADDRESS,									//	Who to email with specifics
											'B',														//	B = Boca,A = Alpharetta
											'F',														//	N = Non-FCRA,F = FCRA
											'N'															//	N = Do not also include boolean,Y = Include boolean,too
										) 
				);

		TEST_RUN_STEPS := SEQUENTIAL(
						CopyMissingKeys
						,OUTPUT('Production TEST-RUN build so skipping UpdateVersion (LNPropertyV2Keys, FCRA_LNPropertyV2Keys)')
									);
		CHOSEN_PROD_STEPS := IF(is_test_run, TEST_RUN_STEPS, PROD_SEQ_STEPS);								
		Running_in_production :=  PRTE2_Common.Constants.is_running_in_prod;
		Production_Steps_To_Do := IF(Running_in_production, CHOSEN_PROD_STEPS, OUTPUT('Skipping Production steps'));
		// Production_Steps_To_Do := IF(Running_in_production, TEST_RUN_STEPS, OUTPUT('Skipping Production steps'));

		RETURN Production_Steps_To_Do;
END;
		