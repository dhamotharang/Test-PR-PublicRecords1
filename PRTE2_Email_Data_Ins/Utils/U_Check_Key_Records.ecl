/* **********************************************************************************
PRTE2_Email_Data_Ins.U_Check_Key_Records
********************************************************************************** */
IMPORT PRTE2_Common, PRTE2_Email_Data_Ins;

Add_Foreign_prod				:= PRTE2_Common.Constants.Add_Foreign_prod;
	
NewDIDs := [888809439154,888809439157,888809439158,888809439172,888809439175,888809439179,
								888809439206,888809439209,888809439210,888809439224,888809439227,888809439231];

DIDKeyLay_i := PRTE2_Email_Data_Ins.U_Key_Layouts_For_Checking.DIDKeyLay_i;
DIDKeyLay := PRTE2_Email_Data_Ins.U_Key_Layouts_For_Checking.DIDKeyLay;

KeyFileName := Add_Foreign_prod('~prte::key::email_data::qa::did');
KeyFCRAName := Add_Foreign_prod('~prte::key::email_data::fcra::qa::did');
prct_data_key := INDEX({DIDKeyLay_i}, DIDKeyLay, keyFileName);
prct_FCRA_key := INDEX({DIDKeyLay_i}, DIDKeyLay, KeyFCRAName);
DS1 := prct_data_key(did in NewDIDs); 
DSFCRA := prct_FCRA_key(did in NewDIDs); 

COUNT(NewDIDs);
COUNT(DS1);
OUTPUT(DS1,all);
COUNT(DSFCRA);
OUTPUT(DSFCRA,all);