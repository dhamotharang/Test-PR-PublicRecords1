import doxie, data_services;

df := bankrupt.File_Liens_Daily(plain_lname != '');

export Key_Liens_PlaintiffName := index(df,{plain_lname,string20 pfname := datalib.preferredfirst(plain_fname),plain_mname,state},{rmsid},data_services.data_location.prefix('bankruptcy') + 'thor_Data400::key::liens_plaintiffName_' + doxie.Version_SuperKey);

