import data_services;

df := seed_files.File_2x42_seeds;

numrec := record
	string4 trib;
	df;
end;

numrec into_num(df L, string4 p) := transform
	self.trib := p;
	self := L;
end;

df2 := project(df, into_num(LEFT, '2x42'));

export Key_bd1obd1i := index(df2,{trib, fein1}, {df2},data_services.data_location.prefix() + 'thor_data400::key::seed::qa::bd1obd1i');