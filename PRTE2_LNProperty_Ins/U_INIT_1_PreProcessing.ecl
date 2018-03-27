// PRTE2_LNProperty_Ins.U_INIT_1_PreProcessing
IMPORT PromoteSupers;

Original := Files.ALP_IN_SF_DS;
BaseAlpha := Get_payload.Alpharetta_LNProperty;
OUTPUT(Original);
OUTPUT(BaseAlpha);
PromoteSupers.Mac_SF_BuildProcess(BaseAlpha, Files.ALP_LNP_SF_NAME, build_main_base);
SEQUENTIAL(build_main_base);