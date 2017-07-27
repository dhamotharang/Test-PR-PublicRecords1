export DEAKeys := macro
output(choosen(dea.key_dea_did,10));
output(choosen(dea.key_dea_bdid,10));
output(choosen(dea.Key_dea_reg_num,10));
output(choosen(dea.Key_dea_payload,10));
output(choosen(Autokey.Key_Address(dea.constants('abc').ak_qaname),10));
output(choosen(AutoKey.Key_CityStName(dea.constants('abc').ak_qaname),10));
output(choosen(AutoKey.Key_Name(dea.constants('abc').ak_qaname),10));
output(choosen(AutoKey.Key_StName(dea.constants('abc').ak_qaname),10));
output(choosen(AutoKey.Key_Zip(dea.constants('abc').ak_qaname),10));
output(choosen(AutokeyB2.Key_Address(dea.constants('abc').ak_qaname),10));
output(choosen(AutoKeyB2.Key_CityStName(dea.constants('abc').ak_qaname),10));
output(choosen(AutoKeyB2.key_name(dea.constants('abc').ak_qaname),10));
output(choosen(AutoKeyB2.Key_NameWords(dea.constants('abc').ak_qaname),10));
output(choosen(AutoKeyB2.Key_StName(dea.constants('abc').ak_qaname),10));
output(choosen(AutoKeyB2.Key_Zip(dea.constants('abc').ak_qaname),10));
output(choosen(Autokey.Key_SSN2(dea.constants('abc').ak_qaname),10));
endmacro;