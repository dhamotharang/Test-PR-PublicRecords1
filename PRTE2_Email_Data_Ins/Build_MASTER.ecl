/* ************************************************************************************************
PRTE2_Email_Data_Ins.Build_MASTER
Nov 2017 - re-write to new Boca build process.
************************************************************************************************ */
IMPORT PRTE2_Common, PRTE2_Email_Data;

EXPORT Build_MASTER(String fileVersion) := FUNCTION

			Build_all_keys := PRTE2_Email_Data.proc_build_all(fileVersion);
			
			// ==================================================================================
			built := SEQUENTIAL(
									Build_all_keys
								):	SUCCESS(PRTE2_Common.Email.sendSuccess( 'Email Data')),
										FAILURE(PRTE2_Common.Email.sendFail( 'Email Data'));

				RETURN built;
		
END;