export MFindKeys := macro
	output(choosen(MFind.Key_MFind_DID,10));
	output(choosen(MFind.Key_MFind_VID,10));
	output(choosen(AutoKey.Key_Address(MFind.constant.str_AutokeyName),10));
	output(choosen(AutoKey.Key_CityStName(MFind.constant.str_AutokeyName),10));
	output(choosen(AutoKey.Key_Name(MFind.constant.str_AutokeyName),10));
	output(choosen(AutoKey.Key_StName(MFind.constant.str_AutokeyName),10));
	output(choosen(AutoKey.Key_Zip(MFind.constant.str_AutokeyName),10));
	output(choosen(MFind.Key_MFind_AutokeyPayload,10));
	
endmacro;

