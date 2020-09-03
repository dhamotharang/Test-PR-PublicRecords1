IMPORT Data_Services, doxie, ut;

export Key_PhonesFeedback_DID(dataset(phonesFeedback.Layouts_PhonesFeedback.layoutPhonesFeedbackDID)	DIDFile) := function


return index(	DIDFile,
							{DID},
							{DIDFile},
							data_services.data_location.Prefix('phonesFeedback') + 'thor_data400::key::phonesFeedback::'+doxie.Version_SuperKey+'::DID');
							
end;		