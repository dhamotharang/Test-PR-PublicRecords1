EXPORT File_Phones_Transaction := MODULE

	EXPORT Main			:= dataset('~thor_data400::base::phones::transaction_main', PhonesInfo.Layout_Common.Phones_Transaction_Main, flat);	

END;