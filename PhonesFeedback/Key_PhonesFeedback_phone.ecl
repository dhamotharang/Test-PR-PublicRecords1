Import Data_Services, doxie, ut;

export Key_PhonesFeedback_phone(dataset(phonesFeedback.Layouts_PhonesFeedback.Layout_PhonesFeedback_base)	phoneFile = DATASET([],phonesFeedback.Layouts_PhonesFeedback.Layout_PhonesFeedback_base)) := function

return index(	phoneFile,
							{phone_number},
							{phoneFile},
							data_services.data_location.Prefix('phonesFeedback') + 'thor_data400::key::phonesFeedback::'+doxie.Version_SuperKey+'::phone');
							
end;