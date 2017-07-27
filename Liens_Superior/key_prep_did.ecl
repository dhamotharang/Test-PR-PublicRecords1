import doxie;

df := liens_superior.file_superior_liens((integer)did != 0);

export key_prep_did := index(df, {unsigned6 did := (integer)did}, {LNI},'~thor_data400::key::superior_liens_did_' + doxie.Version_SuperKey);
