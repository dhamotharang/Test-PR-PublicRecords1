IMPORT _Control, ut, PRTE, PRTE2, PRTE2_Common;

EXPORT after_build_actions := MODULE

		EXPORT post_processing_actions(boolean is_test_run, string filedate) := FUNCTION
				//* ========== CopyMissingKeys, CopyEmptyFiles, and UpdateVersion can only be run in Prod: ========= *//
 				PROD_SEQ_STEPS := Sequential (
   								PRTE.UpdateVersion(	'WatercraftKeys',	//	Package name
   											filedate,												//	Package version
   											_Constants.EmailTargetSuccess,	//	Who to email with specifics
   											'B',												//	B = Boca,A = Alpharetta
   											'N',												//	N = Non-FCRA,F = FCRA
   											'N'													//	N = Do not also include boolean,Y = Include boolean,too
   											)
   				);

				TEST_RUN_STEPS := SEQUENTIAL(
								// no copy steps - there are only 2 keys in this product
								OUTPUT('Production TEST-RUN build so skipping UpdateVersion (PropertyInformationKeys)')
											);
				CHOSEN_PROD_STEPS := IF(is_test_run, TEST_RUN_STEPS, PROD_SEQ_STEPS);								
				Running_in_production :=  PRTE2_Common.Constants.Running_in_production;
				DEV_STEPS := OUTPUT('No DOPS update for dev environment - Non-FCRA');
				Production_Steps_To_Do := IF(Running_in_production, CHOSEN_PROD_STEPS, DEV_STEPS);
				// Production_Steps_To_Do := IF(Running_in_production, TEST_RUN_STEPS, OUTPUT('Skipping Production steps'));

				RETURN Production_Steps_To_Do;
		END;

END;
