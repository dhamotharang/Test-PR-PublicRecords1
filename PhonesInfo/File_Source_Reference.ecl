IMPORT Data_Services, dx_PhonesInfo;

	//DF-24397: Create Dx-Prefixed Keys

EXPORT File_Source_Reference := MODULE
	
	//Carrier Reference Base File
	EXPORT Main 	:= dataset('~thor_data400::base::phones::source_reference_main', dx_PhonesInfo.Layouts.sourceRefBase, flat);
	
END; 