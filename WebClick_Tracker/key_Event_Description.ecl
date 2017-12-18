
import doxie,data_services;
df := WebClick_Tracker.File_Event_Description;

export key_Event_Description := index(df,{df},data_services.data_location.prefix() + 'thor_data400::key::WebClick::' + doxie.Version_SuperKey + '::Event_desc');