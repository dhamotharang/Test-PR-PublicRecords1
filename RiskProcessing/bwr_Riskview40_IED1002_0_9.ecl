#workunit('name','FCRA-RiskView IED1002_0');
#option ('hthorMemoryLimit', 1000);
import models, Riskwise, Risk_Indicators;

// new internal fields for debugging, set to false so they are excluded from the layout by default
include_internal_extras := false;

prii_layout := RECORD
     string ACCOUNT;
     string FirstName;
     string MiddleName;
     string LastName;
     string StreetAddress;
     string CITY;
     string STATE;
     string ZIP;
     string HomePhone;
     string SSN;
     string DateOfBirth;
     string WorkPhone;
     string INCOME;
     string DLNumber;
     string DLState;
     string BALANCE;
     string CHARGEOFFD;
     string FORMERName;
     string EMAIL;
     string EmployerName;
     integer HistoryDateYYYYMM;
		 // unsigned did;
end;

f := DATASET('~jpyon::in::ele_7055_f_s_in_8byte_in',prii_layout,csv(quote('"')));
// f := choosen(DATASET('~jpyon::in::ele_7055_f_s_in_8byte_in',prii_layout,csv(quote('"'))),10);
output(f, named('original_input'));
output(count(f));

layout_soap := record
	STRING AccountNumber;
	STRING FirstName;
	STRING MiddleName;
	STRING LastName;
	STRING NameSuffix;
	STRING StreetAddress;
	STRING City;
	STRING State;
	STRING Zip;
	STRING Country;
	STRING SSN;
	STRING DateOfBirth;
	STRING Age;
	STRING DLNumber;
	STRING DLState;
	STRING Email;
	STRING IPAddress;
	STRING HomePhone;
	STRING WorkPhone;
	STRING EmployerName;
	STRING FormerName;
	INTEGER GLBPurpose;
	INTEGER DPPAPurpose;
	integer HistoryDateYYYYMM := 999999;
	boolean Attributes :=False;
	String IntendedPurpose := '';
	dataset(Models.Layout_Score_Chooser) scores;
	dataset(Risk_Indicators.Layout_Gateways_In) gateways;
	unsigned6 did;
end;

// params := dataset([], models.Layout_Parameters);

// version 4 model to run
paramsA := dataset([{'Custom', 'ied1002_0'}], models.Layout_Parameters);	// use this for non-version1 models, also possibly change the scores that you call below

l := RECORD
	STRING old_account_number;
	layout_soap;
END;

fcraroxieIP := 'http://fcrathorvip.hpcc.risk.regn.net:9876'; 
neutralroxieIP := 'http://roxiebatch.br.seisint.com:9856';


l t_f(f le, INTEGER c) := TRANSFORM
	SELF.old_account_number := le.account;
	SELF.Accountnumber := (STRING)c;	
	SELF.Attributes := False;
	// SELF.IntendedPurpose := 'PRESCREENING';  //Use this to run model in Prescreen mode
  SELF.HistoryDateYYYYMM := (Integer) le.historydateyyyymm[1..6];
	// scores
	self.scores := dataset([{'', fcraroxieIP, paramsA}], models.Layout_Score_Chooser);

	self.gateways := dataset([{'neutralroxie', neutralroxieIP}], risk_indicators.Layout_Gateways_In);
	SELF := le;
	self := [];
end;
p_f := project(f, t_f(left, counter));
output(p_f, named('RV_Input'));

dist_dataset := PROJECT(p_f,TRANSFORM(layout_soap,SELF := LEFT));

xlayout := RECORD
	STRING30 AccountNumber;
	unsigned6 did := 0;
	DATASET(Models.Layout_Model) models;
	STRING errorcode;
END;

xlayout myFail(dist_dataset le) := TRANSFORM
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	SELF := le;
	SELF := [];
END;

resu := soapcall(dist_dataset, fcraroxieIP,
				'Models.RiskView_Testing_Service', {dist_dataset}, 
				DATASET(xlayout),
        RETRY(5), TIMEOUT(500), LITERAL,
        XPATH('Models.RiskView_Testing_ServiceResponse/Results/Result/Dataset[@name=\'Results\']/Row'),
				PARALLEL(25), onFail(myFail(LEFT)));
				
output(resu, named('resu'));
			
ox := RECORD
	STRING30 acctNo;
	STRING3 RV_Income_Score;
	STRING3 RV_Income_Reason;
	STRING3 RV_Income_Reason2;
	STRING3 RV_Income_Reason3;
	STRING3 RV_Income_Reason4;
	#if(include_internal_extras)
		RiskProcessing.layout_internal_extras;
	#end
//	STRING errorcode;
END;

ox normit(resu L, p_f R) := transform
	SELF.Acctno := R.old_account_number;
	#if(include_internal_extras)
		self.DID := l.did; 
		self.historydate := (string)r.HistoryDateYYYYMM;
		self.FNamePop := r.firstname<>'';
		self.LNamePop := r.lastname<>'';
		self.AddrPop := r.streetaddress<>'';
		self.SSNLength := (string)(length(trim(r.ssn))) ;
		self.DOBPop := r.dateofbirth<>'';
		self.EmailPop := r.email<>'';
		self.IPAddrPop := r.ipaddress<>'';
		self.HPhnPop := r.homephone<>'';
	#end;
		
	// score fields 
	IncomeModel1 := l.models[1].scores(description='IncomeIED10020');
	
	self.RV_Income_Score := IncomeModel1[1].i;
	self.RV_Income_Reason := IncomeModel1[1].reason_codes[1].reason_code;
	self.RV_Income_Reason2 := IncomeModel1[1].reason_codes[2].reason_code;
	self.RV_Income_Reason3 := IncomeModel1[1].reason_codes[3].reason_code;
	self.RV_Income_Reason4 := IncomeModel1[1].reason_codes[4].reason_code;
	
end;

j_f := JOIN(resu,p_f,LEFT.accountnumber=RIGHT.accountnumber,normit(LEFT,RIGHT));

output(j_f, named('j_f'));

output(j_f,,'~fallen::out::Income_score_' + thorlib.wuid(),CSV(heading(single), quote('"')));
//output(j_f(errorcode<>''),,'~jpyon::out::sprint_1522_rvmoney_error',CSV(QUOTE('"')), overwrite);
