import data_services, ut;

//DF-23525: Phones Metadata - Split Key into Transaction & Phone Type

EXPORT File_Deact := MODULE

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Operator ID Files////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	//Raw Operator ID
	EXPORT OIDRaw							:= distribute(dataset('~thor_data400::in::phones::deact2_operator_id',PhonesInfo.Layout_Deact.OIDRaw, csv(heading(1), terminator('\n'), separator(','))));

	//Raw Operator ID History
	EXPORT OIDHistory					:= dataset('~thor_data400::in::phones::deact2_operator_id_history',		PhonesInfo.Layout_Deact.OIDHistory, flat);
	
	//Base Operator ID File
	EXPORT OIDMain						:= dataset('~thor_data400::base::phones::deact2_operator_id_main',		PhonesInfo.Layout_Deact.OIDMain, flat);

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Deact Daily Files////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	//Raw Daily	
	EXPORT Raw								:= distribute(dataset('~thor_data400::in::phones::deact_daily', 			PhonesInfo.Layout_Deact.Raw, 	csv(terminator('\n'), separator('|'))))(regexfind('_deact', filename, 0)<>'');	
	EXPORT Raw2								:= dataset('~thor_data400::in::phones::deact2_daily', 								PhonesInfo.Layout_Deact.Raw2, csv(heading(1), terminator('\n'), separator(',')));
	
	//Raw Daily History
	EXPORT History						:= dataset('~thor_data400::in::phones::deact_daily_history', 					PhonesInfo.Layout_Deact.History, flat);
	EXPORT History2						:= dataset('~thor_data400::in::phones::deact2_daily_history', 				PhonesInfo.Layout_Deact.History2, flat);

	//Base File	
	EXPORT Main 							:= dataset('~thor_data400::base::phones::deact2_main', 								PhonesInfo.Layout_Common.Phones_Transaction_Main, flat);	//Phone Transaction Key (DF-23525)
	EXPORT Main_Current 			:= dataset('~thor_data400::base::phones::disconnect_main', 						PhonesInfo.Layout_Deact.Temp, flat);
	EXPORT Main_Current2 			:= dataset('~thor_data400::base::phones::disconnect2_main', 					PhonesInfo.Layout_Deact.Temp, flat);

END; 