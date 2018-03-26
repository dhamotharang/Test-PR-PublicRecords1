// PRTE2_Phonesplus_Ins.BWR_Perform_Post_Processing
/*		This is used if we did the build in PROD with DOPS turned off.
			by using this we can do DOPS UPDATE without running the build over again.
		******************** MAKE SURE YOU GET THE RIGHT VERSION IN THE filedate defintion ******************
*/
import	PRTE2_Common, ut, PRTE2_Phonesplus_Ins;

string filedate := '';	//****** REQUIRED TO EXACTLY MATCH THE BUILD VERSION ******

string EMAIL_ADDRESS := PRTE2_Common.Email.EmailTargetSuccess;

PerformUpdate := PRTE.UpdateVersion('PhonesPlusV2Keys',										//	Package name
																		 filedate,												//	Package version
																		 EMAIL_ADDRESS,	//	Who to email with specifics
																		 'B',																	//	B = Boca, A = Alpharetta
																		 'N',																	//	N = Non-FCRA, F = FCRA
																		 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
																		);
SEQUENTIAL(PerformUpdate);