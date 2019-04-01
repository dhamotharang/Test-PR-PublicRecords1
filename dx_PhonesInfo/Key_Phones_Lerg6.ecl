IMPORT Doxie, Data_Services;

lgM 	:= $.Layouts.lerg6Main;

EXPORT Key_Phones_Lerg6 := INDEX({lgM.npa, lgM.nxx, lgM.block_id} 
																	,lgM 
																	,Data_Services.Data_location.Prefix('tools') + 'thor_data400::key::phones_lerg6_' + doxie.Version_SuperKey);
