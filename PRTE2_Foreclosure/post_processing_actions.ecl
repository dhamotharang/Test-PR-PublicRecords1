IMPORT _Control, ut, PRTE, PRTE2, PRTE2_Common;

EXPORT post_processing_actions(boolean is_test_run, string filedate, string pIndexOldVersion) := FUNCTION
		CopyMissingKeys := SEQUENTIAL(
								PRTE.CopyMissingKeys('ForeclosureKeys',filedate,pIndexOldVersion),
								CreateEmptyForeclosureKeys(filedate),			// This creates 4 other foreclosure keys 
						);

		//* ========== CopyMissingKeys, CopyEmptyFiles, and UpdateVersion can only be run in Prod: ========= *//
		PROD_SEQ_STEPS := Sequential (
						CopyMissingKeys,
						PRTE.UpdateVersion(
									'ForeclosureKeys',				//	Package name
									 filedate,								//	Package version
									 PRTE2_Common.Email.DOPSInterestEmails,	//	Whom to email with specifics
									 'B',											//	B = Boca, A = Alpharetta
									 'N',											//	N = Non-FCRA, F = FCRA
									 'N'				//	N = Do not also include boolean, Y = Include boolean, too
									) 
						);
		TEST_RUN_STEPS := SEQUENTIAL(
						CopyMissingKeys,
						OUTPUT('Production TEST-RUN build so skipping UpdateVersion (ForeclosureKeys)')
									);
		CHOSEN_PROD_STEPS := IF(is_test_run, TEST_RUN_STEPS, PROD_SEQ_STEPS);								
		Running_in_production :=  PRTE2_Common.Constants.Running_in_production;
		Production_Steps_To_Do := IF(Running_in_production, CHOSEN_PROD_STEPS, OUTPUT('Skipping Production steps'));
		// Production_Steps_To_Do := IF(Running_in_production, TEST_RUN_STEPS, OUTPUT('Skipping Production steps'));

		RETURN Production_Steps_To_Do;
END;

