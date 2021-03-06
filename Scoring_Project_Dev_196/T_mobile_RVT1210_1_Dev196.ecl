#workunit('name','Scoring Collection DID jobs');
#option ('hthorMemoryLimit', 1000)
import models, Riskwise, Risk_Indicators, ut, RiskProcessing ;

fcraroxieIP := riskwise.shortcuts.Dev196;
neutralroxieip := riskwise.shortcuts.Dev196;

threads := 1;

infile_name := '~sghatti::in::t_mobile_rvt1210_1_cust_rec_data';
outfile_name := '~nkoubsky::out::T_mobile_RVT1210_1_Dev196_' + thorlib.wuid();

include_internal_extras := true;

input_layout := RECORD
		 string seq;
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
		 unsigned did;
end;



unsigned8 no_of_records := 25000;


f2 := DATASET(infile_name,input_layout,thor );



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
		 unsigned did;
end;

prii_layout d_f(f2 le, integer c) := transform
	self.account := le.seq;
	self.FirstName := le.firstname;
	self.LastName := le.lastname;
	self.StreetAddress := le.streetaddress;
	self.CITY := le.city;
	self.STATE := le.state;
	self.ZIP := le.zip;
	self.HomePhone := le.homephone;
	self.SSN := le.ssn;
	self.DateOfBirth := le.dateofbirth;
	self := le;
	self := [];
	end;
	
	ds := project(f2, d_f (left, counter));
	
// output(DS, named('ds'));

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
	string DataRestrictionMask;	
	integer HistoryDateYYYYMM := 999999;
	boolean Attributes :=False;
	dataset(Models.Layout_Score_Chooser) scores;
	dataset(Risk_Indicators.Layout_Gateways_In) gateways;
	unsigned6 did;
end;

// params := dataset([], models.Layout_Parameters);

// version 4 models
paramsT := dataset([{'Custom', 'rvt1210_1'}], models.Layout_Parameters);	// use this for non-version1 models, also possibly change the scores that you call below


l := RECORD
	STRING old_account_number;
	layout_soap;
END;

l t_f(ds le, INTEGER c) := TRANSFORM
	SELF.old_account_number := le.account;
	SELF.Accountnumber := (STRING)1+c;	
	SELF.Attributes := False;
	self.HistoryDateYYYYMM := 999999;
	self.DataRestrictionMask := '00000000000101';  // to allow use of both Equifax and Experian, this is the default value for all legacy scoring products
	
// use it for FCRA RiskView	
	// if you only want to run one, pick the one you want
	// self.scores := dataset([{'Models.RVAuto_Service', fcraroxieIP, paramsA}], models.Layout_Score_Chooser); 
	// self.scores := dataset([{'Models.RVBankCard_Service', fcraroxieIP,paramsB}], models.Layout_Score_Chooser); 
	// self.scores := dataset([{'Models.RVAuto_Service', fcraroxieIP, paramsR}], models.Layout_Score_Chooser);
	self.scores := dataset([{'Models.RVTelecom_Service', fcraroxieIP,paramsT}], models.Layout_Score_Chooser);
	// self.scores := dataset([{'Models.RVMoney_Service', fcraroxieIP,paramsM}], models.Layout_Score_Chooser);
	// self.scores := dataset([{'Models.RVPrescreen_Service', fcraroxieIP,paramsP}], models.Layout_Score_Chooser);

	// use this for all 6 scores
	// self.scores := dataset([//{'Models.RVAuto_Service', fcraroxieIP, paramsA},
							// {'Models.RVBankCard_Service', fcraroxieIP,paramsB},
							// {'Models.RVRetail_Service', fcraroxieIP,paramsR},
							//{'Models.RVTelecom_Service', fcraroxieIP,paramsT},
							// {'Models.RVMoney_Service', fcraroxieIP,paramsM},
							// {'Models.RVPrescreen_Service', fcraroxieIP,paramsP}
							//], models.Layout_Score_Chooser); 
 
	self.gateways := dataset([{'neutralroxie', neutralroxieIP}], risk_indicators.Layout_Gateways_In);
	SELF := le;
	self := [];
end;
p_f := project(ds, t_f(left, counter));
// output(p_f, named('RV_Input'));

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
				'Models.RiskView_Service', {dist_dataset}, 
				DATASET(xlayout),
        RETRY(5), TIMEOUT(500), LITERAL,
        XPATH('Models.RiskView_ServiceResponse/Results/Result/Dataset[@name=\'Results\']/Row'),
				PARALLEL(threads), onFail(myFail(LEFT)));
				
// output(resu, named('resu'));
			
ox := RECORD
	STRING30 acctNo;
	string3 RV_score_telecom;
	string3 RV_telecom_reason;
	string3 RV_telecom_reason2;
	string3 RV_telecom_reason3;
	string3 RV_telecom_reason4;
	string3 RV_telecom_reason5;	
	#if(include_internal_extras)
		RiskProcessing.layout_internal_extras;
	#end
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
		
	
	
	teleModel1 := l.models[1].scores(description='Telecom' or description='TelecomRVT12101');
	teleModel2 := l.models[2].scores(description='Telecom'or description='TelecomRVT12101');
	teleModel3 := l.models[3].scores(description='Telecom'or description='TelecomRVT12101');
	teleModel4 := l.models[4].scores(description='Telecom'or description='TelecomRVT12101');
	teleModel5 := l.models[5].scores(description='Telecom'or description='TelecomRVT12101');
	teleModel6 := l.models[6].scores(description='Telecom'or description='TelecomRVT12101');
	
							
								
	self.rv_score_telecom := map(   teleModel1[1].i <> '' => teleModel1[1].i,
									teleModel2[1].i <> '' => teleModel2[1].i,
									teleModel3[1].i <> '' => teleModel3[1].i,
									teleModel4[1].i <> '' => teleModel4[1].i,
									teleModel5[1].i <> '' => teleModel5[1].i,
									teleModel6[1].i <> '' => teleModel6[1].i,
									'');
	self.rv_telecom_reason := map( teleModel1[1].i <> '' => teleModel1[1].reason_codes[1].reason_code,
								teleModel2[1].i <> '' => teleModel2[1].reason_codes[1].reason_code,
								teleModel3[1].i <> '' => teleModel3[1].reason_codes[1].reason_code,
								teleModel4[1].i <> '' => teleModel4[1].reason_codes[1].reason_code,
								teleModel5[1].i <> '' => teleModel5[1].reason_codes[1].reason_code,
								teleModel6[1].i <> '' => teleModel6[1].reason_codes[1].reason_code,
								'');
	self.rv_telecom_reason2 := map(teleModel1[1].i <> '' => teleModel1[1].reason_codes[2].reason_code,
								teleModel2[1].i <> '' => teleModel2[1].reason_codes[2].reason_code,
								teleModel3[1].i <> '' => teleModel3[1].reason_codes[2].reason_code,
								teleModel4[1].i <> '' => teleModel4[1].reason_codes[2].reason_code,
								teleModel5[1].i <> '' => teleModel5[1].reason_codes[2].reason_code,
								teleModel6[1].i <> '' => teleModel6[1].reason_codes[2].reason_code,
								'');
	self.rv_telecom_reason3 := map(teleModel1[1].i <> '' => teleModel1[1].reason_codes[3].reason_code,
								teleModel2[1].i <> '' => teleModel2[1].reason_codes[3].reason_code,
								teleModel3[1].i <> '' => teleModel3[1].reason_codes[3].reason_code,
								teleModel4[1].i <> '' => teleModel4[1].reason_codes[3].reason_code,
								teleModel5[1].i <> '' => teleModel5[1].reason_codes[3].reason_code,
								teleModel6[1].i <> '' => teleModel6[1].reason_codes[3].reason_code,
								'');
	self.rv_telecom_reason4 := map(teleModel1[1].i <> '' => teleModel1[1].reason_codes[4].reason_code,
								teleModel2[1].i <> '' => teleModel2[1].reason_codes[4].reason_code,
								teleModel3[1].i <> '' => teleModel3[1].reason_codes[4].reason_code,
								teleModel4[1].i <> '' => teleModel4[1].reason_codes[4].reason_code,
								teleModel5[1].i <> '' => teleModel5[1].reason_codes[4].reason_code,
								teleModel6[1].i <> '' => teleModel6[1].reason_codes[4].reason_code,
								'');								
	self.rv_telecom_reason5 := map(teleModel1[1].i <> '' => teleModel1[1].reason_codes[5].reason_code,
								teleModel2[1].i <> '' => teleModel2[1].reason_codes[5].reason_code,
								teleModel3[1].i <> '' => teleModel3[1].reason_codes[5].reason_code,
								teleModel4[1].i <> '' => teleModel4[1].reason_codes[5].reason_code,
								teleModel5[1].i <> '' => teleModel5[1].reason_codes[5].reason_code,
								teleModel6[1].i <> '' => teleModel6[1].reason_codes[5].reason_code,
								'');								
									
		
	self := L;
self := [];
end;

j_f := JOIN(resu,p_f,LEFT.accountnumber=RIGHT.accountnumber,normit(LEFT,RIGHT));

op_final := output(J_F,, outfile_name, CSV(HEADING(single), QUOTE('"')));

sequential(op_final);


EXPORT T_mobile_RVT1210_1_with_did := 'success';