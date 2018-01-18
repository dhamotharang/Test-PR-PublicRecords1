import data_services;

df := file_seed1;

numrec := record
	df;
	string3 prodnum;
end;

numrec into_num (df L, string3 p) := transform
	self.prodnum := p;
	self := L;
end;

df2 := project(df,into_num(LEFT,'002'));

export Key_ct1ophni := index(df2,{prodnum, homephone},{account_out,
									 riskwiseid,
									 nameaddrflag,
									 fname,
									 lname, 
									 addr,
									 city,
									 state,
									 zip,
									 reserved,
									 phonserviceflag,
									 cmpy},data_services.data_location.prefix() + 'thor_Data400::key::seed::qa::ct1ophni');
