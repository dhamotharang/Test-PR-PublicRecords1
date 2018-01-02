import data_services;

df := file_seed61;

numrec := record
	df;
	string3	prodnum;
end;

numrec into_num(DF L, string3 p) := transform
	self.prodnum := p;
	self := L;
end;

df2 := project(df, into_num(LEFT, '001'));

export Key_idpoidpi := index(df2,{prodnum, string9 social := df2.socs},{account_out,
	riskwiseid,
	socsverlevel,
	phoneverlevel,
	score,
	reason1,
	reason2,
	reason3,
	reason4,
	reason5,
	reason6,
	correctdob,
	correcthphone,
	correctsocs,
	correctaddr,
	dirsfirst,
	dirslast,
	dirsaddr,
	dirscity,
	dirsstate,
	dirszip,
	nameaddrphone,
	altlast,
	altlast2,
	correctlast},data_services.data_location.prefix() + 'thor_Data400::key::seed::qa::idpoidpi');
	