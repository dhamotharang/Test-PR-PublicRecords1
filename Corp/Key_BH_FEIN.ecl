import business_header,doxie, data_services;

df := business_header.File_Business_Header_best;

slimrec := record	
	df.bdid;
	df.FEIN;
end;

df2 := table(df(bdid != 0, fein != 0),slimrec);

export Key_BH_FEIN := index(df2,{bdid},{fein},data_services.data_location.prefix() + 'thor_data400::key::bh_fein_for_corp_' + doxie.Version_SuperKey);
