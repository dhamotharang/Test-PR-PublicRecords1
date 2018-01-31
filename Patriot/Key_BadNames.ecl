import doxie,Data_Services;

export Key_BadNames := index(annotated_names,keytype_badnames,Data_Services.Data_location.Prefix()+'thor_data400::key::annotated_names_' + doxie.Version_SuperKey);