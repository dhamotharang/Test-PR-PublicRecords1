import doxie,Data_Services;
f := File_Telcordia_tds;

export Key_Telcordia_tds := INDEX(f,{npa,nxx},{f},Data_Services.Data_Location.Prefix('Telcordia')+ 'thor_data400::key::telcordia_tds_' + doxie.Version_SuperKey);