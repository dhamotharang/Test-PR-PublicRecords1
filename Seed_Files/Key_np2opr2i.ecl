numrec := record
	layout_np2opr2i;
	string3	prodnum;
end;

numrec into_num(layout_np2opr2i L, string3 p) := transform
	self.prodnum := p;
	self := L;
end;

df := project(files.file_np80, into_num(LEFT,'080')) + 
				project(files.file_np81,into_num(Left,'081')) +
				project(files.file_np82,into_num(Left,'082')) +
				project(files.file_np90, into_num(LEFT,'090')) + 
				project(files.file_np91,into_num(Left,'091')) +
				project(files.file_np92,into_num(Left,'092'))
				;
				
				
export Key_np2opr2i := index(df,{prodnum, social},{account_out,
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
	alertentity}, '~thor_data400::key::seed::qa::np2opr2i');
