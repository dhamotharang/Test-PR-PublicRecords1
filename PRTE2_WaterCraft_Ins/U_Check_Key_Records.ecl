/* **********************************************************************************
PRTE2_WaterCraft_Ins.U_Check_Key_Records
********************************************************************************** */
IMPORT PRTE2_Common, PRTE2_WaterCraft_Ins;

Add_Foreign_prod				:= PRTE2_Common.Constants.Add_Foreign_prod;
	
NewDIDs := [888809439154,888809439160,888809439162,888809439164,888809439166,888809439168,888809439170,888809439172,
							888809439175,888809439179,888809439182,888809439184,888809439186,888809439188,888809439190,888809439192,
							888809439206,888809439212,888809439214,888809439216,888809439218,888809439220,888809439222,888809439224,
							888809439227,888809439231,888809439234,888809439236,888809439238,888809439240,888809439242,888809439244];

Layouts := PRTE2_WaterCraft_Ins.U_Key_Layouts_For_Checking;							
DIDKeyLay_i := Layouts.DIDKeyLay_i;
DIDKeyLay := Layouts.DIDKeyLay;
WID_Key_Layout_i := Layouts.WID_Key_Layout_i;
WID_Key_Layout := Layouts.WID_Key_Layout;
		
KeyFileName := Add_Foreign_prod('~prte::key::watercraft::qa::did');
PayKeyFileName := Add_Foreign_prod('~prte::key::watercraft::qa::wid');
prct_data_key := INDEX({DIDKeyLay_i}, DIDKeyLay, keyFileName);
prct_Pay_key := INDEX({WID_Key_Layout_i}, WID_Key_Layout, PayKeyFileName);
DS1 := prct_data_key(l_did in NewDIDs); 

COUNT(NewDIDs);
COUNT(DS1);

DS2 := JOIN ( DS1, prct_Pay_key,
									LEFT.state_origin = RIGHT.state_origin
									AND LEFT.watercraft_key = RIGHT.watercraft_key
									AND LEFT.sequence_key = RIGHT.sequence_key,
									TRANSFORM({prct_Pay_key}, SELF := RIGHT));
OUTPUT(COUNT(DS2));
OUTPUT(DS2,all);