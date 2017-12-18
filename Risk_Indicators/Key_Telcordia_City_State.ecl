import doxie,Data_Services, Risk_Indicators;

j_ := Risk_Indicators.Telcordia_tpm_base;
j  := dedup(sort(distribute(j_, hash(npa)), npa, city, st,local),npa, city, st,local);

export Key_Telcordia_City_State:= INDEX(j,{city,st},{j},Data_Services.Data_Location.Prefix('Telcordia')+'thor_data400::key::telcordia_city_state_'+ doxie.Version_SuperKey,OPT);


