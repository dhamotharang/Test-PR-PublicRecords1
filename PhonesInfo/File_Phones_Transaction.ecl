IMPORT dx_PhonesInfo;

//DF-24397: Create Dx-Prefixed Keys

EXPORT File_Phones_Transaction := MODULE

	EXPORT Main			:= dataset('~thor_data400::base::phones::transaction_main', dx_PhonesInfo.Layouts.Phones_Transaction_Main, flat);	

END;