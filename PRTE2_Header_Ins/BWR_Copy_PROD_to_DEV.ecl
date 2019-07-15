/* *********************************************************************************************************************
PRTE2_Header_Ins.BWR_Copy_PROD_to_DEV

NOTE: We don't yet have a true despray and spray so for now just copy the PROD base to DEV base. (Dev data was lost)
********************************************************************************************************************* */
IMPORT PRTE2_Common, PRTE2_Header_Ins;

fileVersion := PRTE2_Common.Constants.TodayString+'';			// DATE PLUS LETTER IF NEEDED
BaseAlpha		:= PRTE2_Header_Ins.Files.HDR_BASE_ALPHA_DS_Prod;
build_main_base := PRTE2_Header_Ins.fn_Save_Alpharetta_Base(BaseAlpha, fileVersion);
SEQUENTIAL(build_main_base);