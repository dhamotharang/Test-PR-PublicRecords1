import doxie;

df := edgar.file_edgar_company_base(bdid != 0);

export key_edgar_company_bdid := index(df,{bdid},{df},'~thor_data400::key::edgar_company_bdid_' + doxie.Version_SuperKey);
