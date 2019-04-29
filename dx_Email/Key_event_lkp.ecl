IMPORT $, Data_Services, Doxie;

inFile := $.Layouts.i_Event_lkp;

EXPORT Key_event_lkp := INDEX({inFile.email_address, inFile.date_added, inFile.source}
															,inFile
															,Data_Services.Data_location.Prefix('Email_Data')+'thor_data400::key::email_dataV2::'+doxie.Version_SuperKey+'::email_event_lkp');