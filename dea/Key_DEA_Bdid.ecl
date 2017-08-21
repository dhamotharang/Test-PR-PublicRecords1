import doxie, Data_Services, DEA;

df := dea.File_DEA((integer)bdid != 0);

// export Key_DEA_Bdid := index(df,{unsigned6 bd := (integer)bdid},{df},'~thor_data400::key::dea_bdid_' + doxie.Version_SuperKey);
export Key_DEA_Bdid := index(df,{unsigned6 bd := (integer)bdid},{df},
                             Data_Services.Data_location.Prefix('DEA') + 
			                       'thor_data400::key::dea::' + doxie.Version_SuperKey + '::bdid');
