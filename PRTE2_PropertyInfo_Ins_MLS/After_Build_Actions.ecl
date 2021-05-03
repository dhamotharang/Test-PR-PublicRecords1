/* ************************************************************************************************************************
**********************************************************************************************
***** MLS CONVERSION NOTES:   Do we want to auto update Alpha too for the 9299 data?????
* Is 9299 altering it's logic for the new sources?
**********************************************************************************************
************************************************************************************************************************ */

IMPORT PRTE, PRTE2_Common;

EXPORT After_Build_Actions := MODULE

		EXPORT post_processing_actions(string filedate) := FUNCTION

				boolean is_running_in_prod := PRTE2_Common.Constants.is_running_in_prod;

				PROD_SEQ_STEPS := SEQUENTIAL (
   							PRTE.UpdateVersion(	'PropertyInformationKeys',	//	Package name
   									filedate,										//	Package version
   									PRTE2_Common.Email.DOPSInterestEmails,	//	Who to email with specifics
   									'B',												//	B = Boca,A = Alpharetta
   									'N',												//	N = Non-FCRA,F = FCRA
   									'N'												//	N = Do not also include boolean,Y = Include boolean,too
   									)
								);

				DEV_STEPS := SEQUENTIAL(OUTPUT('Skipping Production steps'));

				RETURN IF(is_running_in_prod, PROD_SEQ_STEPS, DEV_STEPS);
		END;

END;