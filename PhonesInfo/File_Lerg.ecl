IMPORT Data_Services;

//DF-23660: Lerg6 Build Process
//DF-24140: Lerg6 Layout Change
//DF-24037: Replace LIDB Use Lerg6 for Carrier Info

EXPORT File_Lerg := MODULE

	//Lerg6
	EXPORT Lerg6									:= dataset('~thor_data400::in::phones::lerg6', 	 										PhonesInfo.Layout_Lerg.lerg6, 									csv(terminator('\n'), 	separator(','), quote('"')));
	EXPORT Lerg6Hist							:= dataset('~thor_data400::in::phones::lerg6_history', 							PhonesInfo.Layout_Lerg.lerg6Hist, 							flat);
	EXPORT Lerg6Main							:= dataset('~thor_data400::base::phones::lerg6_main', 							PhonesInfo.Layout_Lerg.lerg6Main, 							flat);	

	//Lerg6 OCN Append
	EXPORT Lerg6NewPhone					:= dataset('~thor_data400::in::phones::new_phone_daily', 						PhonesInfo.Layout_Lerg.lerg6UpdHist, 						flat);
	EXPORT Lerg6UpdPhoneHist			:= dataset('~thor_data400::in::phones::lerg6_upd_phone_history', 		PhonesInfo.Layout_Lerg.lerg6UpdHist, 						flat);
	EXPORT Lerg6UpdPhone					:= dataset('~thor_data400::base::phones::lerg6_upd_phone', 					PhonesInfo.Layout_Lerg.lerg6UpdHist_Prep,				flat);

END;