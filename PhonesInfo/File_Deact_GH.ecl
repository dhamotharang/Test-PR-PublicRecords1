IMPORT Data_Services, dx_PhonesInfo;

//DF-24397: Create Dx-Prefixed Keys

EXPORT File_Deact_GH := MODULE

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Gong History Deact Files////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	//Daily History
	EXPORT History				:= dataset('~thor_data400::in::phones::deact_gh_history', 		PhonesInfo.Layout_Deact_GH.History, flat);
	
	//Base File	
	EXPORT Main						:= dataset('~thor_data400::base::phones::deact_gh_main', 			dx_PhonesInfo.Layouts.Phones_Transaction_Main, flat);	//Phone Transaction Key	
	EXPORT Main_Current 	:= dataset('~thor_data400::base::phones::disconnect_gh_main', PhonesInfo.Layout_Deact_GH.Temp, flat);
	
	
END;