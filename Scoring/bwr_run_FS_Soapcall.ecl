layout:=record
string	IPAddress	;
string	S2FirstName	;
string	S2Lastname	;
string	S2Address1	;
string	S2Address2	;
string	S2City	;
string	S2State	;
string	S2Zipcode	;
string	S2Phone	;
string	account	;
string	FirstName	;
string	MiddleName	;
string	Lastname	;
string	Phone	;
string	Address1	;
string	Address2	;
string	City	;
string	State	;
string	Zipcode	;
string	EmailAddress	;
end;
f:=dataset('~file::10.121.145.79::e$::mn::516.csv',layout,csv(heading(1),quote('"')));

output(f);

l :=	RECORD
	STRING old_account_number;
	string tribcode := '';
	string account := '';
	string first := '';
	string last := '';
	string addr := '';
	string city := '';
	string state := '';
	string zip := '';
	string hphone := '';
	string socs := '';
	string dob := '';
	string wphone := '';
	string drlc := '';
	string drlcstate := '';
END;

l t_f(f le, INTEGER c) :=	TRANSFORM
    self.first := le.s2FirstName;
    self.Last := le.s2lastName;
	self.addr:=le.s2Address1+' '+le.s2Address2;
	self.city:=le.s2city;
	self.state:=le.s2state;
	self.zip:=le.s2zipcode;
    self.tribcode := 'flg1';
	self.old_account_number := le.account;
	self.account := (string)c;
	self.hphone:=le.s2phone;
	self := le;
	self:=[];
END;

p_f := PROJECT(f,t_f(LEFT,COUNTER));
output(p_f);


roxieIP := 'http://roxiestaging.br.seisint.com:9876'; // staging vip

s := riskwise.RiskwiseMainFLGO_Soapcall(project(p_f, transform(riskwise.Layout_FLG1, self:=left)), roxieIP);

riskprocessing.Layout_FLGOFLG1 joinem(p_f le, s rt) := transform
	self.account := le.old_account_number;
	self.account2 := le.old_account_number;
	self := le;
	self := rt;
end;

flg1 := join(p_f, s, left.account=right.account, joinem(left,right));

output(flg1, named('flg1'));
output(flg1(riskwiseid!=''),named('flgo_errors'));
Scoring.MAC_FS_Soapcall(flg1,f_o);
output(f_o);
output(f_o,,'~mzhang::out::516_flgo_test',csv(quote('"'),heading(single)),overwrite);
