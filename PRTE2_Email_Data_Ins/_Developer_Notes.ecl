/* **************************************************************************************************
PRTE2_Email_Data_Ins._Developer_Notes
**************************************************************************************************
**************************************************************************************************
**************************************************************************************************

Nov 2017 - need to alter PRTE2_Email_Data.proc_build_keys to make DOPS and emails compatible.
Sample: PRTE2_PhonesPlus.proc_build_keys
**************************************************************************************************
Nov 2017 - had to re-write to new LZ and Boca base layouts and Boca builds for a custom load

ALPHARETTA NOTES:
	July 2015 - Bad situation we need to fix as soon as we can SYNC the LexIDs
	The original 12 emails that were put in here have Alpharetta LexIDs and we're leaving those in case they are needed.
	The new 48k emails we added for BC3800 all have Boca LexIDs.

	Also needs fixing once headers are sync'd - 
		PRTE2_Email_Data_Ins.Fn_Spray_And_Build_BaseMain currently uses MHDR instead of BHDR - eventually move it to Alpha-BHDR

	PRTE2_Email_Data_Ins.BWR_Despray_Alpha_Base		- despray the alpharetta base file
	PRTE2_Email_Data_Ins.BWR_Spray_Alpha_Base			- spray the alpharetta base file (does NOT build keys)
		(as all Boca builds, the spray is not part of the build process)
	PRTE2_Email_Data_Ins.BWR_Build_Email					- builds keys with alpharetta base file (and Boca if they add one)


BOCA NOTES:
	Currently no Boca data CSV is added to this build.

TO DO A NEW BUILD WITH NEW ALPHA DATA:
Spray new data:			PRTE2_Email_Data_Ins.BWR_Spray_Alpha_Base
Then build keys: 		PRTE2_Email_Data_Ins.BWR_Build_Email

****************** What Boca build reads: ******************
prct::base::ct::email_data_v2::qa::alpha_base
prte::base::email_data::alpha
************************************************************************************************** */