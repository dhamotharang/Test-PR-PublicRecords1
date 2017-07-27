
import doxie,ut,atf;
df := WebClick_Tracker.File_Event_Description;

export key_Event_Description := index(df,{df},'~thor_data400::key::WebClick::' + doxie.Version_SuperKey + '::Event_desc');