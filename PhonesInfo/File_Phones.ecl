//Combines the iConectiv & TCPA Base Files Together to Create the Ported Phone Base

import ut;

EXPORT File_Phones := Module

	EXPORT Ported_Current 	:= dataset('~thor_data400::base::phones::ported_common_main', 				PhonesInfo.Layout_Common.portedMain, thor);
	EXPORT Ported_Previous 	:= dataset('~thor_data400::base::phones::ported_common_main_father', 	PhonesInfo.Layout_Common.portedMain, thor);

END;