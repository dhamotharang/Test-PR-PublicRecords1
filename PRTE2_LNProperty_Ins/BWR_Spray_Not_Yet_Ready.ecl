/* *********************************************************************************************************************
PRTE2_LNProperty_Ins.BWR_Spray_Not_Yet_Ready
There is confusing stuff in various code attributes here until we can re-write some of this.
Originally we were told we had to take our base file and split it into 3 base files - then Terri saw that and said no -
We just had to convert our layout to the new layout and save one base file - then the Boca code would do the splitting.
********************************************************************************************************************* */
IMPORT PromoteSupers, PRTE2_LNProperty_Ins,data_services,tools;
Original := PRTE2_LNProperty_Ins.Files.ALP_IN_SF_DS;
BaseAlpha := PRTE2_LNProperty_Ins.Get_payload.Alpharetta_LNProperty;
OUTPUT(Original);
OUTPUT(BaseAlpha);
PromoteSupers.Mac_SF_BuildProcess(BaseAlpha, PRTE2_LNProperty_Ins.Files.ALP_LNP_SF_NAME, build_main_base);
SEQUENTIAL(build_main_base);