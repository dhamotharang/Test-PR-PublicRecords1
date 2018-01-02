import data_services;

numrec := record
	layout_ef1oef1i;
	string3 prodnum;
end;

numrec into_num(layout_ef1oef1i L, string3 p) := transform
	self.prodnum := p;
	self := L;
end;

df := project(file_seed64,into_num(LEFT,'001'));

export Key_ef1oef1i := index(df,{prodnum, string9 social := df.socs},{account_out,riskwiseid,socsverlevel},data_services.data_location.prefix() + 'thor_Data400::key::seed::qa::ef1oef1i');
