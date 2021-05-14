IMPORT Data_Services, dx_PhonesInfo;

	//DF-23660: Lerg6 Build Process
	//DF-24140: Lerg6 Layout Change
	//DF-24037: Replace LIDB Use Lerg6 for Carrier Info
	//DF-24397: Create Dx-Prefixed Keys

EXPORT File_Lerg := MODULE

	//Lerg1: Carrier Information
	EXPORT Lerg1 									:= dataset('~thor_data400::in::phones::lerg1', 	 										PhonesInfo.Layout_Lerg.lerg1, 						csv(terminator('\n'), 	separator(','), quote('"')));
	EXPORT Lerg1Hist							:= dataset('~thor_data400::in::phones::lerg1_history', 							PhonesInfo.Layout_Lerg.lerg1Hist, 				flat);
	EXPORT Lerg1Hist_Father				:= dataset('~thor_data400::in::phones::lerg1_history_father', 			PhonesInfo.Layout_Lerg.lerg1Hist, 				flat);
 	
	//Lerg1Con: Contact Information
	EXPORT Lerg1Con 							:= dataset('~thor_data400::in::phones::lerg1con', 									PhonesInfo.Layout_Lerg.lerg1Con, 					csv(terminator('\n'), 	separator(','), quote('"')));
	EXPORT Lerg1ConHist						:= dataset('~thor_data400::in::phones::lerg1con_history', 					PhonesInfo.Layout_Lerg.lerg1ConHist, 			flat);
	
	//Lerg Prep Files In Common Layout (Lerg1 + Lerg1Con)
	EXPORT Lerg1Prep							:= dataset('~thor_data400::in::phones::lerg1_prep',									PhonesInfo.Layout_Lerg.lergPrep, 					flat);				
	EXPORT Lerg1PrepClean					:= dataset('~thor400_data::persist::lerg_address_aid', 							PhonesInfo.Layout_Lerg.lergPrep, 					flat);	
	
	//Lerg6
	EXPORT Lerg6									:= dataset('~thor_data400::in::phones::lerg6', 	 										PhonesInfo.Layout_Lerg.lerg6, 									csv(terminator('\n'), 	separator(','), quote('"')));
	EXPORT Lerg6Hist							:= dataset('~thor_data400::in::phones::lerg6_history', 							PhonesInfo.Layout_Lerg.lerg6Hist, 							flat);
	EXPORT Lerg6Main							:= dataset('~thor_data400::base::phones::lerg6_main', 							dx_PhonesInfo.Layouts.lerg6Main, 								flat);	

	//Lerg6 OCN Append
	EXPORT Lerg6NewPhone					:= dataset('~thor_data400::in::phones::new_phone_daily', 						PhonesInfo.Layout_Lerg.lerg6UpdHist, 						flat);
	EXPORT Lerg6UpdPhoneHist			:= dataset('~thor_data400::in::phones::lerg6_upd_phone_history', 		PhonesInfo.Layout_Lerg.lerg6UpdHist, 						flat);
	EXPORT Lerg6UpdPhone					:= dataset('~thor_data400::base::phones::lerg6_upd_phone', 					PhonesInfo.Layout_Lerg.lerg6UpdHist_Prep,				flat);

END;