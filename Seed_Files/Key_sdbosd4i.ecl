numrec := record
	layout_sdbosd4i;
	string3	prodnum;
end;

numrec into_num(layout_sdbosd4i L, string3 p) := transform
	self.prodnum := p;
	self := L;
end;

df := project(file_seed56, into_num(LEFT,'001'));

export Key_sdbosd4i := index(df,{prodnum, social},{account_out,
	riskwiseid,
	hriskhphoneflag,
	hriskwphoneflag,
	hphonevalflag,
	wphonevalflag,
	hphonezipflag,
	wphonezipflag,
	hriskaddrflag,
	decsflag,
	socsdobflag,
	socsvalflag,
	drlcvalflag,
	addrvalflag,
	dwelltypeflag,
	bansflag,
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
	socsverlevel,
	cmpyphoneverlevel,
	cmpyfaxverlevel,
	hphoneverlevel,
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
	socsmiskeyflag,
	hphonemiskeyflag,
	wphonemiskeyflag,
	addrmiskeyflag,
	hriskhphoneflag2,
	hriskwphoneflag2,
	hphonevalflag2,
	wphonevalflag2,
	hphonezipflag2,
	wphonezipflag2,
	hriskaddrflag2,
	decsflag2,
	socsdobflag2,
	socsvalflag2,
	drlcvalflag2,
	addrvalflag2,
	dwelltypeflag2,
	bansflag2,
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
	socsverlevel2,
	cmpyphoneverlevel2,
	cmpyfaxverlevel2,
	hphoneverlevel2,
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
	socsmiskeyflag2,
	hphonemiskeyflag2,
	wphonemiskeyflag2,
	addrmiskeyflag2,
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
	distphoneaddr,
	distphone2addr2,
	distphoneaddr2,
	distphonephone2,
	distaddraddr2,
	distaddrphone2,
	newjlunrlsdjdgmtcount,
	oldjlunrlsdjdgmtcount,
	jlrlsdjdgmtcount,
	jlunrlsdliencount,
	jlrlsdliencount,
	newjlunrlsdjdgmtcount2,
	oldjlunrlsdjdgmtcount2,
	jlrlsdjdgmtcount2,
	jlunrlsdliencount2,
	jlrlsdliencount2},'~thor_data400::key::seed::qa::sdbosd4i');
