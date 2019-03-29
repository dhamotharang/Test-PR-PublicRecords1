IMPORT dx_PhonesInfo;

//DF-24397: Create Dx-Prefixed Keys

EXPORT File_Phones_Type := MODULE

	EXPORT Main		:= dataset('~thor_data400::base::phones::phones_type_main', dx_PhonesInfo.Layouts.Phones_Type_Main, flat);	

END;