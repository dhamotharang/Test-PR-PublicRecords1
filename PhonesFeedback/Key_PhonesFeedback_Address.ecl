IMPORT Data_Services, doxie, ut;

export Key_PhonesFeedback_Address(dataset(phonesFeedback.Layouts_PhonesFeedback.layoutPhonesFeedbackAddress)	AddressFile) := function

 
return index(	AddressFile,
							{prim_range, prim_name, predir, addr_suffix, sec_range, zip5},
							{AddressFile},
							data_services.data_location.Prefix('phonesFeedback') + 'thor_data400::key::phonesFeedback::'+doxie.Version_SuperKey+'::address');
							
end;