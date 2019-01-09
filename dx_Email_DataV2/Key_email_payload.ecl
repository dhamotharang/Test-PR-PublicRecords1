IMPORT $, Data_Services, Doxie;

inFile := $.Layouts.i_Payload;

EXPORT Key_email_payload(boolean isFCRA = false) := INDEX({inFile.email_rec_key}
																													,{inFile}
																													,IF(isFCRA,
																															Data_Services.Data_location.Prefix('Email_Data')+'thor_200::key::email_dataV2::'+doxie.Version_SuperKey+'::payload'
																															,Data_Services.Data_location.Prefix('Email_Data')+'thor_200::key::email_dataV2::fcra::'+doxie.Version_SuperKey+'::payload')
																													);