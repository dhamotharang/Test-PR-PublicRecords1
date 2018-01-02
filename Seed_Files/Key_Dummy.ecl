import data_services;

df := dataset([{'xxx','000000000','x'}],{string3 prodnum, string9 social, string1 foo});

export Key_Dummy := index(df,{prodnum, social},{foo},data_services.data_location.prefix() + 'thor_data400::key::seed_file_dummy');
