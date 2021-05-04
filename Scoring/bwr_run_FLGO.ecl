prii_layout := RECORD
	STRING Account;
	STRING First;
	STRING Middle;
	STRING Last;
	STRING addr;
	STRING City;
	STRING State;
	STRING Zip;
	STRING HPhone;
	STRING socs;
	STRING Dob;
	STRING Wphone;
	STRING income;  
	string drlc;
	string drlcstate;
	string BALANCE; 
	string CHARGEOFFD;  
	string FormerName;
	string EMAIL;  
	string COMPANY;
	string historydateyyyymm;
END;
f := dataset('~thor_data100::in::test884', prii_layout, csv);

l :=	RECORD
	STRING old_account_number;
	riskwise.Layout_FLG1;
END;

l t_f(f le, INTEGER c) :=	TRANSFORM
	self.tribcode := 'flg1';
	self.old_account_number := le.account;
	self.account := (string)c;
	self := le;
END;

p_f := PROJECT(f,t_f(LEFT,COUNTER));
output(p_f);


roxieIP := 'http://certstagingvip.hpcc.risk.regn.net:9876'; // staging vip

s := riskwise.RiskwiseMainFLGO_Soapcall(project(p_f, transform(riskwise.Layout_FLG1, self:=left)), roxieIP);

riskprocessing.Layout_FLGOFLG1 joinem(p_f le, s rt) := transform
	self.account := le.old_account_number;
	self.account2 := le.old_account_number;
	self := le;
	self := rt;
end;

flg1 := join(p_f, s, left.account=right.account, joinem(left,right));

output(flg1, named('flg1'));
output(flg1,, '~dvstemp::out::flgo_test', csv(quote('"')),overwrite);
output(flg1(riskwiseid!=''),named('flgo_errors'));







