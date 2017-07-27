import ut;

numrec := record
	layout_prwoprwi;
	string3	prodnum;
end;

numrec into_num(layout_prwoprwi L, string3 p) := transform
	self.prodnum := p;
	self := L;
end;

df := project(file_seed16, into_num(LEFT, '001')) +
	 project(file_seed17, into_num(LEFT, '003')) +
	 project(file_seed18, into_num(LEFT, '006')) +
	 project(file_seed19, into_num(LEFT, '007')) +
	 project(file_seed20, into_num(LEFT, '008')) +
	 project(file_seed21, into_num(LEFT, '009')) +
	 project(file_seed22, into_num(LEFT, '013')) + 
	 project(file_seed23, into_num(LEFT, '014')) +
	 project(file_seed24, into_num(LEFT, '015')) +
	 project(file_seed25, into_num(LEFT, '019')) +
	 project(file_seed26, into_num(LEFT, '022')) +
	 project(file_seed67, into_num(LEFT, '010')) +
	 project(file_seed68, into_num(LEFT, '012')) +
	 project(file_seed69, into_num(LEFT, '024')) +
	 project(file_seed73, into_num(LEFT, '051')) +
	 project(file_seed108, into_num(LEFT, '034')) ;


export Key_prwoprwi := index (df,{prodnum, social},{account_out,
	riskwiseid,
	firstcount,
	lastcount,
	addrcount,
	formeraddrcount,
	hphonecount,
	socscount,
	socsverlevel,
	dobcount,
	drlccount,
	cmpycount,
	verfirst,
	verlast,
	vercmpy,
	veraddr,
	vercity,
	verstate,
	verzip,
	verhphone,
	versocs,
	verdrlc,
	verdob,
	numelever,
	numsource,
	firstscore,
	lastscore,
	cmpyscore,
	addrscore,
	hphonescore,
	socsscore,
	dobscore,
	drlcscore,
	wphonename,
	wphoneaddr,
	wphonecity,
	wphonestate,
	wphonezip,
	socsmiskeyflag,
	hphonemiskeyflag,
	addrmiskeyflag,
	idtheftflag,
	aptscanflag,
	addrhistoryflag,
	coaalertflag,
	coafirst,
	coalast,
	coaaddr,
	coacity,
	coastate,
	coazip,
	wphonetypeflag,
	wphonevalflag,
	hphonetypeflag,
	hphonevalflag,
	phonezipflag,
	phonedissflag,
	addrvalflag,
	dwelltypeflag,
	ziptypeflag,
	socsvalflag,
	decsflag,
	socsdobflag,
	areacodesplitflag,
	altareacode,
	bansflag,
	drlcvalflag,
	drlcsoundx,
	drlcfirst,
	drlclast,
	drlcmiddle,
	drlcsocs,
	drlcdob,
	drlcgender,
	distaddrprevaddr,
	disthphonewphone,
	distwphoneaddr,
	statezipflag,
	cityzipflag,
	hphonestateflag,
	checkacctflag,
	cassaddr,
	casscity,
	cassstate,
	casszip,
	addrcommflag,
	nonresname,
	nonressic,
	nonresphone,
	nonresaddr,
	nonrescity,
	nonresstate,
	nonreszip,
	numfraud,
	airwavesscore,
	score2,
	tciaddrflag,
	tciprevaddrflag,
	estincome,
	emaildomainflag,
	emailuserflag,
	emailbrowserflag,
	hriskemaildomainflag,
	distaddrdomain}, '~thor_data400::key::seed::qa::prwoprwi');
