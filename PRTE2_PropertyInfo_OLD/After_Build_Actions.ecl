IMPORT PRTE, PRTE2_Common;

EXPORT After_Build_Actions := MODULE

		EXPORT post_processing_actions(boolean is_test_run, string filedate) := FUNCTION

				boolean is_running_in_prod := PRTE2_Common.Constants.is_running_in_prod;
				PROD_SEQ_STEPS := SEQUENTIAL (
   							PRTE.UpdateVersion(	'PropertyInformationKeys',	//	Package name
   									filedate,										//	Package version
   									PRTE2_Common.Email.DOPSInterestEmails,	//	Who to email with specifics
   									'B',												//	B = Boca,A = Alpharetta
   									'N',												//	N = Non-FCRA,F = FCRA
   									'N'													//	N = Do not also include boolean,Y = Include boolean,too
   									)
								);

				TEST_RUN_STEPS := SEQUENTIAL(
								OUTPUT('Production TEST-RUN build so skipping UpdateVersion (PropertyInformationKeys)')
								);

				DEV_STEPS := SEQUENTIAL(OUTPUT('Skipping Production steps'));

				CHOSEN_PROD_STEPS := IF(is_test_run, TEST_RUN_STEPS, PROD_SEQ_STEPS);								

				Production_Steps_To_Do := IF(is_running_in_prod, CHOSEN_PROD_STEPS, DEV_STEPS);

				RETURN Production_Steps_To_Do;
		END;

END;