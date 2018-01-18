import doxie,Data_Services, Risk_Indicators;

j_ := Risk_Indicators.Telcordia_tpm_base;
j  := dedup(sort(distribute(j_(zip <> ''), hash(npa)), npa, city, st, zip,local),npa, city, st,zip,local);

export Key_Telcordia_Zip := INDEX(j,{zip},{j},Data_Services.Data_Location.Prefix('Telcordia')+'thor_data400::key::telcordia_zip_' + doxie.Version_SuperKey,OPT);

