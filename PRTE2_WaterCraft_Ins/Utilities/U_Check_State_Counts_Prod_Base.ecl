IMPORT PromoteSupers,PRTE2_WaterCraft_Ins;

PROD_ReadOnly_DS	:= PRTE2_WaterCraft_Ins.Utilities.Files.LIVEProdMainReadOnly;

DataIn := PROD_ReadOnly_DS;
OUTPUT(COUNT(dataIn));

report0 := RECORD
	recTypeSrc	 := DataIn.State_Origin;
	GroupCount := COUNT(GROUP);
END;

RepTable0 := TABLE(DataIn,report0,State_Origin);
OUTPUT(SORT(RepTable0,recTypeSrc));

OUTPUT(PROD_ReadOnly_DS(State_Origin='CA'));
OUTPUT(PROD_ReadOnly_DS(State_Origin='US'));
OUTPUT(PROD_ReadOnly_DS(State_Origin='FV'));

