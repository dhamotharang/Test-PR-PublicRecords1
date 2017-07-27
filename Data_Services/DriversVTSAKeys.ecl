export DriversVTSAKeys := macro
output(choosen(DriversVTSA.Key_DL,10));
output(choosen(DriversVTSA.Key_DL_DID,10));
output(choosen(DriversVTSA.Key_DL_Number,10));
output(choosen(DriversVTSA.Key_DL_Seq,10));
output(choosen(Autokey.Key_Address('~thor400_92::key::dl_vtsa::autokey::qa::'),10));
output(choosen(AutoKey.Key_CityStName('~thor400_92::key::dl_vtsa::autokey::qa::'),10));
output(choosen(AutoKey.Key_Name('~thor400_92::key::dl_vtsa::autokey::qa::'),10));
// output(choosen(AutoKey.Key_Phone2('~thor400_92::key::dl_vtsa::autokey::qa::'),10));
output(choosen(AutoKey.Key_SSN2('~thor400_92::key::dl_vtsa::autokey::qa::'),10));
output(choosen(AutoKey.Key_StName('~thor400_92::key::dl_vtsa::autokey::qa::'),10));
output(choosen(AutoKey.Key_Zip('~thor400_92::key::dl_vtsa::autokey::qa::'),10));
output(choosen(DriversVTSA.Key_AutoKey_Payload,10));
endmacro;