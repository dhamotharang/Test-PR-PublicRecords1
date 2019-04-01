IMPORT Doxie, Data_Services;

trM 	:= $.Layouts.Phones_Transaction_Main;

EXPORT Key_Phones_Transaction := INDEX({trM.phone} 
																				,trM 
																				,Data_Services.Data_location.Prefix('tools') + 'thor_data400::key::phones_transaction_' + doxie.Version_SuperKey);
