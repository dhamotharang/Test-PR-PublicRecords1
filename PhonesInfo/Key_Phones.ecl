EXPORT Key_Phones := MODULE

import Data_Services, doxie;

	inFCurr 								:= PhonesInfo.File_Phones.Ported_Current;
	inFCurrP								:= project(inFCurr, PhonesInfo.Layout_Common.portedMain-service_type);//Remove service_type field from the key
	export Ported 					:= index(inFCurrP
																					,{phone}
																					,{inFCurrP}
																					,Data_Services.Data_location.Prefix()+'thor_data400::key::phones_ported_'+doxie.Version_SuperKey);

	inFPrev									:= PhonesInfo.File_Phones.Ported_Previous;
	inFPrevP								:= project(inFPrev, PhonesInfo.Layout_Common.portedMain-service_type);
	export Ported_Father 		:= index(inFPrevP
																					,{phone}
																					,{inFPrevP}
																					,Data_Services.Data_location.Prefix()+'thor_data400::key::phones_ported_father');

	inFPL 									:= PhonesInfo.File_Metadata.PortedMetadata_Main;
	export Ported_Metadata	:= index(inFPL
																				,{phone}
																				,{inFPL}
																				,Data_Services.Data_location.Prefix()+'thor_data400::key::phones_ported_metadata_'+doxie.Version_SuperKey);

END;