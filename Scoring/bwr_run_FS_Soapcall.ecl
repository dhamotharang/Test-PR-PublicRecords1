#workunit('name','Field Summary Rpt');

prii_layout := RECORD
	STRING Account;
	STRING first;
	STRING middle;
	STRING last;
	STRING addr;
	STRING City;
	STRING State;
	STRING Zip;
	STRING hphone;
	STRING Socs;
	STRING dob;
	STRING wphone;
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

// f := DATASET('~tfuerstenberg::in::bbt_670_ciid-fd_in',prii_layout,csv(quote('"')));
f := choosen(DATASET('~tfuerstenberg::in::bbt_670_ciid-fd_in',prii_layout,csv(quote('"'))),20);


output(f);

l :=	RECORD
	STRING old_account_number;
	riskwise.Layout_FLG1;
END;

l t_f(f le, INTEGER c) :=	TRANSFORM
    self.tribcode := 'flg1';
	self.old_account_number := le.account;
	self.account := (string)c;
	self := le;
	self:=[];
END;

p_f := PROJECT(f,t_f(LEFT,COUNTER));
output(p_f);


roxieIP := 'http://prdrroxiethorvip.hpcc.risk.regn.net:9876';// DR Roxie

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
output(f_o,,'~tfuerstenberg::out::bbt_F-S_out',CSV(heading(single), quote('"')), overwrite);
