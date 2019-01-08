IMPORT $, Data_Services, Doxie;

inFile := $.Layouts.i_Email_Address;
				   
EXPORT Key_Email_Address := INDEX({inFile.clean_email, inFile.email_rec_key}
																	,inFile
																	,Data_Services.Data_location.Prefix('Email_Data')+'thor_200::key::email_dataV2::'+doxie.Version_SuperKey+'::email_addresses');

