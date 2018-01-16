import doxie, Data_Services;

df := liens_superior.file_superior_liens((integer)did != 0);

export key_did := index(df, {unsigned6 did := (integer)did}, {LNI},Data_Services.Data_location.Prefix()+'thor_data400::key::superior_liens_did_' + doxie.Version_SuperKey);
