import riskwise;

export getNumFraud(string coaalertflag, string aptscanflag, string addrvalflag, string decsflag, string bansflag, string drlcvalflag) := 

MODULE
	
	//Beginning of PRIO numfraud logic
	a(string hriskphoneflag) := IF((integer)hriskphoneflag > 0 and (integer)hriskphoneflag < 7,1,0);
	b(string phonevalflag) :=   IF(phonevalflag = '0', 1,0);
	c(string phonezipflag) :=   IF(phonezipflag = '1', 1,0);
	d(string hriskaddrflag) :=  IF((integer)hriskaddrflag > 0 and (integer)hriskaddrflag < 5, 1,0);
	e :=                        IF(decsflag = '1', 1,0);
	f(string socsdobflag) :=    IF(socsdobflag = '1',1,0);
	g(string socsvalflag) :=    IF(socsvalflag = '1',1,0);
	h :=                        IF(drlcvalflag = '1',1,0);
	i :=                        IF(addrvalflag = 'N',1,0);
	j :=                        IF(coaalertflag = '1', 1,0);
	k(string idtheftflag) :=    IF(idtheftflag = '1',1,0);
	l :=                        IF(aptscanflag = '1', 1,0);
	m :=                        IF((integer)bansflag > 0 and (integer)bansflag < 3, 1,0);
	
	
	export PRIO(string hriskphoneflag,string phonevalflag,string phonezipflag,string hriskaddrflag,string socsdobflag,string socsvalflag,string idtheftflag) := 
											(string)(a(hriskphoneflag)+b(phonevalflag)+c(phonezipflag)+d(hriskaddrflag)+e+f(socsdobflag)+g(socsvalflag)+h+i+j+k(idtheftflag)+l+m);



	//Beginning of PRWO numfraud logic
	a :=                         IF(coaalertflag = '1', 1,0);
	b :=                         IF(aptscanflag = '1', 1,0);
	c(string wphonetypeflag) :=  IF(wphonetypeflag <> '0', 1,0);
	d(string wphonevalflag) :=   IF(wphonevalflag = '0', 1,0);
	e(string hphonetypeflag) :=  IF(hphonetypeflag <> '0', 1,0);
	f(string hphonevalflag) :=   IF(hphonevalflag = '0', 1,0);
	g(string PWphonezipflag) :=  IF(PWphonezipflag ='1' ,1,0);
	h(string phonedissflag) :=   IF(phonedissflag = '1', 1,0);
	i :=                         IF(addrvalflag = 'N', 1,0);
	j(string PWsocsvalflag) :=   IF(PWsocsvalflag <> '0', 1,0);
	k :=                         IF(decsflag = '1', 1,0);
	l(string PWsocsdobflag) :=   IF(PWsocsdobflag = '1', 1,0);
	m :=                         IF(bansflag > '0' and bansflag < '3', 1,0);
	n :=                         IF(drlcvalflag <> '0', 1,0);
	o(string statezipflag) :=    IF(statezipflag = '1', 1,0);
	p(string cityzipflag) :=     IF(cityzipflag = '1', 1,0);
	q(string hphonestateflag) := IF(hphonestateflag = '1', 1,0);
	r(string addrcommflag) :=    IF(addrcommflag <> '0', 1,0);
	
	
	export PRWO(string wphonetypeflag,string wphonevalflag,string hphonetypeflag,string hphonevalflag,string PWphonezipflag,string phonedissflag,string PWsocsvalflag,string PWsocsdobflag,
			  string statezipflag,string cityzipflag,string hphonestateflag,string addrcommflag) := 
														(string)(a+b+c(wphonetypeflag)+d(wphonevalflag)+e(hphonetypeflag)+f(hphonevalflag)+g(PWphonezipflag)+h(phonedissflag)+i+
															    j(PWsocsvalflag)+k+l(PWsocsdobflag)+m+n+o(statezipflag)+p(cityzipflag)+q(hphonestateflag)+r(addrcommflag));
	
END;