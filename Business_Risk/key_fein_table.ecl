import doxie;

f := Business_Risk.FEIN_Table;

export key_fein_table := index(f,{fein},{f},'~thor_data400::key::fein_table_'+doxie.Version_SuperKey);

