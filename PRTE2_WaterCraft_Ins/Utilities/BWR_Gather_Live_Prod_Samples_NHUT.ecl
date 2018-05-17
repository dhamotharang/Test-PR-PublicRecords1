// PRTE2_WaterCraft_Ins.Utilities.BWR_Gather_Live_Prod_Samples_NHUT

IMPORT PromoteSupers,PRTE2_WaterCraft_Ins;

PROD_ReadOnly_DS	:= PRTE2_WaterCraft_Ins.Utilities.Files.LIVEProdMainReadOnly;
DS1 := PRTE2_WaterCraft_Ins.Utilities.Files.ProdGatherMainDS;
OutLay := PRTE2_WaterCraft_Ins.Utilities.Layouts.GatheredBaseMainLayout;
Files := PRTE2_WaterCraft_Ins.Utilities.Files;
DS2a := CHOOSEN(PROD_ReadOnly_DS(State_Origin='NH'),5000);
DS2b := CHOOSEN(PROD_ReadOnly_DS(State_Origin='UT'),5000);
DS2 := DS2a+DS2b;

OutLay trxForm(DS2 L,INTEGER C) := TRANSFORM
	SELF.UniqueCnt := C;
	SELF := L;
END;
DS2x := PROJECT(DS2,trxForm(LEFT,COUNTER));
DS2z := DS1+DS2x;
OutLay trxForm2(DS2z L,INTEGER C) := TRANSFORM
	SELF.UniqueCnt := C;
	SELF := L;
END;
DS3 := PROJECT(DS2z,trxForm2(LEFT,COUNTER));
COUNT(DS3);

PromoteSupers.Mac_SF_BuildProcess(DS3, Files.ProdGatherMainName, Build1,,,TRUE);

Build1;
