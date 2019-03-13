IMPORT Data_Services;

//DF-23660: Lerg6 Build Process
//DF-24140: Lerg6 Layout Change

EXPORT File_Lerg := MODULE

	//Lerg6
	EXPORT Lerg6									:= dataset('~thor_data400::in::phones::lerg6', 	 										PhonesInfo.Layout_Lerg.lerg6, 						csv(terminator('\n'), 	separator(','), quote('"')));
	EXPORT Lerg6Hist							:= dataset('~thor_data400::in::phones::lerg6_history', 							PhonesInfo.Layout_Lerg.lerg6Hist, 				flat);
	EXPORT Lerg6Hist_Father				:= dataset('~thor_data400::in::phones::lerg6_history_father', 			PhonesInfo.Layout_Lerg.lerg6Hist, 				flat);	
	EXPORT Lerg6Main							:= dataset('~thor_data400::base::phones::lerg6_main', 							PhonesInfo.Layout_Lerg.lerg6Main, 				flat);	

END;