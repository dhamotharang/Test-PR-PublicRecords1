/* *********************************************************************************************************************
PRTE2_LNProperty_Ins.BWR_Copy_PROD_to_DEV
There is confusing stuff in various code attributes here until we can re-write some of this.
Originally we were told we had to take our base file and split it into 3 base files - then Terri saw that and said no -
We just had to convert our layout to the new layout and save one base file - then the Boca code would do the splitting.

NOTE: We don't yet have a true despray and spray so for now just copy the PROD base to DEV base.
********************************************************************************************************************* */
IMPORT PromoteSupers, PRTE2_LNProperty_Ins,data_services,tools;

BaseAlpha		:= PRTE2_LNProperty_Ins.Files.ALP_LNP_SF_DS_Prod;
// BaseAlpha := PRTE2_LNProperty_Ins.Get_payload.Alpharetta_LNProperty;
// OUTPUT(BaseAlpha);
PromoteSupers.Mac_SF_BuildProcess(BaseAlpha, PRTE2_LNProperty_Ins.Files.ALP_LNP_SF_NAME, build_main_base);
SEQUENTIAL(build_main_base);