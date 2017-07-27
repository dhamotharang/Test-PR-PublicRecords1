import ut;

numrec := record
	layout_sd1osd1i;
	string3	prodnum;
end;

numrec into_num(layout_sd1osd1i L, string3 p) := transform
	self.prodnum := p;
	self := L;
end;

df := project(file_Seed43, into_num(LEFT, '002')) +
	 project(file_Seed44, into_num(LEFT, '003')) +
	 project(file_Seed45, into_num(LEFT, '006')) + 
	 project(file_seed46, into_num(LEFT, '007')) +
	 project(file_seed47, into_num(LEFT, '008')) +
	 project(file_seed48, into_num(LEFT, '009')) +
	 project(file_seed49, into_num(LEFT, '010')) +
	 project(file_seed50, into_num(LEFT, '060')) +
	 project(file_Seed51, into_num(LEFT, '102')) +
	 project(file_seed72, into_num(LEFT, '070')) +
	 project(file_seed70, into_num(LEFT, '061')) +
	 project(file_seed84, into_num(LEFT, '208')) +
	 project(file_seed85, into_num(LEFT, '210')) +
	 project(file_seed96, into_num(LEFT, '075')) ;	 


export Key_sd1osd1i := index (df,{prodnum, social},{	account_out,	
	riskwiseid,
	firstcount,
	lastcount,
	cmpycount,
	addrcount,
	socscount,
	hphonecount,
	wphonecount,
	dobcount,
	drlccount,
	emailcount,
	socsverlvl,
	numelever,
	numsource,
	verfirst,
	verlast,
	vercmpy,
	veraddr,
	vercity,
	verstate,
	verzip,
	versocs,
	verdob,
	verhphone,
	verwphone,
	verdrlc,
	veremail,
	firstcount2,
	lastcount2,
	cmpycount2,
	addrcount2,
	socscount2,
	hphonecount2,
	wphonecount2,
	dobcount2,
	drlccount2,
	emailcount2,
	socsverlvl2,
	numelever2,
	numsource2,
	verfirst2,
	verlast2,
	vercmpy2,
	veraddr2,
	vercity2,
	verstate2,
	verzip2,
	versocs2,
	verdob2,
	verhphone2,
	verwphone2,
	verdrlc2,
	veremail2,
	versummary,
	score,
	reason11,
	reason21,
	reason31,
	reason41,
	score2,
	reason12,
	reason22,
	reason32,
	reason42,
	score3,
	reason13,
	reason23,
	reason33,
	reason43,
	score4,
	reason14,
	reason24,
	reason34,
	reason44,
	reserved_out}, '~thor_data400::key::seed::qa::sd1osd1i');
