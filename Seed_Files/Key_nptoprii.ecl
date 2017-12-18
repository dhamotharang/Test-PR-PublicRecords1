import data_services;

numrec := record
	layout_nptoprii;
	string3	prodnum;
end;

numrec into_num(layout_nptoprii L, string3 p) := transform
	self.prodnum := p;
	self := L;
end;

df := project(file_seed57, into_num(LEFT,'003'))  // npt3
	 + project(file_Seed58, into_num(LEFT,'004')) // npt4
	 + project(file_seed66, into_num(left,'001'))
	 + project(file_seed92, into_num(LEFT,'005')) // npt5
	 ;

export Key_nptoprii := index(df,{prodnum, social},{account_out,
	riskwiseid,
	socsverlevel,
	phoneverlevel,
	correctdob,
	correcthphone,
	correctsocs,
	score,
	score2,
	score3,
	reason1,
	reason2,
	reason3,
	reason4,
	reason5,
	reason6,
	action1,
	action2,
	action3,
	action4,
	altlast,
	altlast2,
	altlast3,
	altareacode,
	splitdate,
	socllowissue,
	soclhighissue,
	soclstate,
	hriskalerttable,
	hriskalertnum,
	alertfirst,
	alertlast,
	alertaddr,
	alertcity,
	alertstate,
	alertzip,
	alertentity,
	dirsfirst,
	dirslast,
	dirsaddr,
	dirscity,
	dirsstate,
	dirszip,
	nameaddrphone,
	eqfsfirst,
	eqfslast,
	eqfsaddr,
	eqfscity,
	eqfsstate,
	eqfszip,
	eqfsphone,
	eqfsaddr2,
	eqfscity2,
	eqfsstate2,
	eqfszip2,
	eqfsphone2,
	eqfsaddr3,
	eqfscity3,
	eqfsstate3,
	eqfszip3,
	eqfsphone3},data_services.data_location.prefix() + 'thor_data400::key::seed::qa::nptoprii');
