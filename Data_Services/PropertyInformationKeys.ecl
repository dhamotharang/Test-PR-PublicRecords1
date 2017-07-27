export	PropertyInformationKeys	:=
macro
	output(choosen(PropertyCharacteristics.Key_PropChar_RID,10));
	output(choosen(PropertyCharacteristics.Key_PropChar_Autokey_Payload,10));
	output(choosen(PropertyCharacteristics.Key_PropChar_Address,10));
	output(choosen(Autokey.key_address('~thor_data400::key::propertybluebook::qa::autokey::'),10));
	output(choosen(Autokey.key_citystname('~thor_data400::key::propertybluebook::qa::autokey::'),10));
	output(choosen(Autokey.key_name('~thor_data400::key::propertybluebook::qa::autokey::'),10));
	output(choosen(Autokey.key_stname('~thor_data400::key::propertybluebook::qa::autokey::'),10));
	output(choosen(Autokey.key_zip('~thor_data400::key::propertybluebook::qa::autokey::'),10));
endmacro;