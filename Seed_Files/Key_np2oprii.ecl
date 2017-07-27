import ut;

numrec := record
	layout_np2oprii;
	string3	prodnum;
end;

numrec into_num(layout_np2oprii L, string3 p) := transform
	self.prodnum := p;
	self := L;
end;

df := project(file_seed4, into_num(LEFT,'001')) +
	 project(file_seed5, into_num(LEFT,'002')) +
	 project(file_seed71, into_num(LEFT,'005')) +
	 project(file_seed6, into_num(LEFT,'070')) +
	 project(file_seed7, into_num(LEFT,'228')) +
	 project(file_seed8, into_num(LEFT,'229')) +
	 project(file_seed9, into_num(LEFT,'331')) +
	 project(file_seed10, into_num(LEFT,'332')) +
	 project(file_seed65, into_num(LEFT,'061')) +
	 project(file_seed90, into_num(LEFT,'052')) +
	 project(file_seed106 /* np33 */, into_num(LEFT,'333')) +
	 project(file_seed107 /* ex49 */, into_num(LEFT,'249')) ;
	 
	 
export Key_np2oprii := index(df,{prodnum, social},{account_out,
	riskwiseid,
	socsverlevel,
	phoneverlevel,
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
	correctdob,
	correcthphone,
	correctsocs,
	correctaddr,
	altareacode,
	splitdate,
	dirsfirst,
	dirslast,
	dirsaddr,
	dirscity,
	dirsstate,
	dirszip,
	nameaddrphone,
	socllowissue,
	soclhighissue,
	soclstate,
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
	eqfsphone3,
	altlast,
	altlast2,
	altlast3,
	hriskalerttable,
	hriskalertnum,
	alertfirst,
	alertlast,
	alertaddr,
	alertcity,
	alertstate,
	alertzip,
	alertentity}, '~thor_Data400::key::seed::qa::np2oprii');
