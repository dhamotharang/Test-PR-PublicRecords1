IMPORT Data_Services, dx_PhonesInfo;

	//DF-24397: Create Dx-Prefixed Keys
	//DF-28036: Convert_6-Digit_Spid_to_4-Character_OCN

EXPORT File_Source_Reference := MODULE
	
	//Carrier Reference Base File
	EXPORT Main 					:= dataset('~thor_data400::base::phones::source_reference_main', 						dx_PhonesInfo.Layouts.sourceRefBase, flat);
	EXPORT Main_Previous	:= dataset('~thor_data400::base::phones::source_reference_main_father',			dx_PhonesInfo.Layouts.sourceRefBase, flat);
	EXPORT Main_Orig 			:= dataset('~thor_data400::base::phones::source_reference_main_orig',				dx_PhonesInfo.Layouts.sourceRefBase, flat); //Original Carrier Reference File Before Spid-to-OCN Translation
	
	//Exception List
	EXPORT MainException	:= dataset('~thor_data400::base::phones::source_reference_main_exception', 	dx_PhonesInfo.Layouts.sourceRefBase, flat);

END; 