export CellPhonesKeys := macro
	output(choosen(AutoKey.Key_Address('~thor_data400::key::cellphones_'),10));
output(choosen(AutoKey.Key_CityStName('~thor_data400::key::cellphones_'),10));
output(choosen(AutoKey.Key_Name('~thor_data400::key::cellphones_'),10));
output(choosen(AutoKey.Key_Phone('~thor_data400::key::cellphones_'),10));
output(choosen(AutoKey.Key_SSN('~thor_data400::key::cellphones_'),10));
output(choosen(AutoKey.Key_StName('~thor_data400::key::cellphones_'),10));
output(choosen(AutoKey.Key_Zip('~thor_data400::key::cellphones_'),10));
output(choosen(Cellphone.key_cellphones_did,10));
output(choosen(CellPhone.key_cellphones_fdid,10));
endmacro;