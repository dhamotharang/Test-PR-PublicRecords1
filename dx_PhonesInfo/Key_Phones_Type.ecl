IMPORT Doxie, Data_Services;

ptM 	:= $.Layouts.Phones_Type_Main;

EXPORT Key_Phones_Type := INDEX({ptM.phone} 
																,ptM 
																,Data_Services.Data_location.Prefix('tools') + 'thor_data400::key::phones_type_' + doxie.Version_SuperKey);

