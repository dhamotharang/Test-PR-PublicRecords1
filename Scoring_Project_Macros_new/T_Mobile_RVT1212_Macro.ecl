﻿EXPORT T_Mobile_RVT1212_Macro (fcraroxie_IP,neutralroxie_IP, Thread, Timeout, Retry, Input_file_name,Output_file_name, records_ToRun):= functionmacro


IMPORT Models, iESP, Risk_Indicators, RiskWise, RiskProcessing, UT;

unsigned8 no_of_records := records_ToRun;
integer eyeball := 50;
integer retry := retry;
integer timeout := timeout;
integer threads := Thread;

String neutralroxieIP := neutralroxie_IP ; 
String fcraroxieIP := fcraroxie_IP ;

Infile_name :=  Input_file_name;

String outfile_name :=  Output_file_name ;

// new internal fields for debugging, set to false so they are excluded from the layout by default
include_internal_extras := true;

layout_input := RECORD
    Scoring_Project_Macros.Regression.global_layout;
	Scoring_Project_Macros.Regression.pii_layout;
	Scoring_Project_Macros.Regression.runtime_layout;
END;


ds := IF(no_of_records <= 0, dataset(ut.foreign_prod + infile_name, layout_input , CSV(HEADING(single), QUOTE('"')) ),
                            CHOOSEN(DATASET(ut.foreign_prod + infile_name, layout_input , CSV(HEADING(single), QUOTE('"'))), no_of_records));
/* 														
   f2 := f1;
   
   
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
   
   	ds := project(f2, d_f(left, counter));
   	
    //output(DS, named('ds'));
*/

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
	dataset(Models.Layout_Score_Chooser) scores;
	dataset(Risk_Indicators.Layout_Gateways_In) gateways;
	unsigned6 did;
end;

// params := dataset([], models.Layout_Parameters);

// version 4 models
paramsT := dataset([{'Custom', 'rvt1212_1'}], models.Layout_Parameters);	// use this for non-version1 models, also possibly change the scores that you call below


l := RECORD
	STRING old_account_number;
	layout_soap;
END;


// fcraroxieIP := 'http://fcrabatch.sc.seisint.com:9876'; 
// neutralroxieIP := 'http://roxiebatch.br.seisint.com:9856';




l t_f(ds le, INTEGER c) := TRANSFORM
	SELF.old_account_number := (string)le.AccountNumber;
	SELF.Accountnumber := (STRING)1+c;	
	SELF.Attributes := False;
	self.HistoryDateYYYYMM := 999999;
	
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
 //output(p_f, named('RV_Input'));

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
        RETRY(retry), TIMEOUT(timeout), LITERAL,
        XPATH('Models.RiskView_Testing_ServiceResponse/Results/Result/Dataset[@name=\'Results\']/Row'),
				PARALLEL(threads), onFail(myFail(LEFT)));
				
 // output(resu, named('resu'));
			
ox := RECORD
	STRING30 acctNo;
	// string3 RV_score_auto;
	// string3 RV_auto_reason;
	// string3 RV_auto_reason2;
	// string3 RV_auto_reason3;
	// string3 RV_auto_reason4;
	// string3 RV_auto_reason5;
	// string3 RV_score_bank;
	// string3 RV_bank_reason;
	// string3 RV_bank_reason2;
	// string3 RV_bank_reason3;
	// string3 RV_bank_reason4;
	// string3 RV_bank_reason5;	
	// string3 RV_score_retail;
	// string3 RV_retail_reason;
	// string3 RV_retail_reason2;
	// string3 RV_retail_reason3;
	// string3 RV_retail_reason4;
	// string3 RV_retail_reason5;
	string3 RV_score_telecom;
	string3 RV_telecom_reason;
	string3 RV_telecom_reason2;
	string3 RV_telecom_reason3;
	string3 RV_telecom_reason4;
	string3 RV_telecom_reason5;	
	// string3 RV_score_money;
	// string3 RV_money_reason;
	// string3 RV_money_reason2;
	// string3 RV_money_reason3;
	// string3 RV_money_reason4;
	// string3 RV_money_reason5;
	// string3 RV_score_prescreen;
	// string3 RV_prescreen_reason;
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
	// autoModel1 := l.models[1].scores(description='Auto' or description='AutoRVA10071' or description='AutoRVA10072');
	// autoModel2 := l.models[2].scores(description='Auto' or description='AutoRVA10071' or description='AutoRVA10072');
	// autoModel3 := l.models[3].scores(description='Auto' or description='AutoRVA10071' or description='AutoRVA10072');
	// autoModel4 := l.models[4].scores(description='Auto' or description='AutoRVA10071' or description='AutoRVA10072');
	// autoModel5 := l.models[5].scores(description='Auto' or description='AutoRVA10071' or description='AutoRVA10072');
	// autoModel6 := l.models[6].scores(description='Auto' or description='AutoRVA10071' or description='AutoRVA10072');
	
	// bankModel1 := l.models[1].scores(description='BankCard');
	// bankModel2 := l.models[2].scores(description='BankCard');
	// bankModel3 := l.models[3].scores(description='BankCard');
	// bankModel4 := l.models[4].scores(description='BankCard');
	// bankModel5 := l.models[5].scores(description='BankCard');
	// bankModel6 := l.models[6].scores(description='BankCard');
	
	// retaModel1 := l.models[1].scores(description='Retail');
	// retaModel2 := l.models[2].scores(description='Retail');
	// retaModel3 := l.models[3].scores(description='Retail');
	// retaModel4 := l.models[4].scores(description='Retail');
	// retaModel5 := l.models[5].scores(description='Retail');
	// retaModel6 := l.models[6].scores(description='Retail');
	
	teleModel1 := l.models[1].scores(description='Telecom' or description='TelecomRVT12121');
	teleModel2 := l.models[2].scores(description='Telecom'or description='TelecomRVT12121');
	teleModel3 := l.models[3].scores(description='Telecom'or description='TelecomRVT12121');
	teleModel4 := l.models[4].scores(description='Telecom'or description='TelecomRVT12121');
	teleModel5 := l.models[5].scores(description='Telecom'or description='TelecomRVT12121');
	teleModel6 := l.models[6].scores(description='Telecom'or description='TelecomRVT12121');
	
	// monyModel1 := l.models[1].scores(description='Money');
	// monyModel2 := l.models[2].scores(description='Money');
	// monyModel3 := l.models[3].scores(description='Money');
	// monyModel4 := l.models[4].scores(description='Money');
	// monyModel5 := l.models[5].scores(description='Money');
	// monyModel6 := l.models[6].scores(description='Money');
	
	// presModel1 := l.models[1].scores(description='PreScreen');
	// presModel2 := l.models[2].scores(description='PreScreen');
	// presModel3 := l.models[3].scores(description='PreScreen');
	// presModel4 := l.models[4].scores(description='PreScreen');
	// presModel5 := l.models[5].scores(description='PreScreen');
	// presModel6 := l.models[6].scores(description='PreScreen');

	// self.rv_score_auto := map(  autoModel1[1].i <> '' => autoModel1[1].i,
								// autoModel2[1].i <> '' => autoModel2[1].i,
								// autoModel3[1].i <> '' => autoModel3[1].i,
								// autoModel4[1].i <> '' => autoModel4[1].i,
								// autoModel5[1].i <> '' => autoModel5[1].i,
								// autoModel6[1].i <> '' => autoModel6[1].i,
								// '');
	// self.rv_auto_reason := map( autoModel1[1].i <> '' => autoModel1[1].reason_codes[1].reason_code,
								// autoModel2[1].i <> '' => autoModel2[1].reason_codes[1].reason_code,
								// autoModel3[1].i <> '' => autoModel3[1].reason_codes[1].reason_code,
								// autoModel4[1].i <> '' => autoModel4[1].reason_codes[1].reason_code,
								// autoModel5[1].i <> '' => autoModel5[1].reason_codes[1].reason_code,
								// autoModel6[1].i <> '' => autoModel6[1].reason_codes[1].reason_code,
								// '');
	// self.rv_auto_reason2 := map(autoModel1[1].i <> '' => autoModel1[1].reason_codes[2].reason_code,
								// autoModel2[1].i <> '' => autoModel2[1].reason_codes[2].reason_code,
								// autoModel3[1].i <> '' => autoModel3[1].reason_codes[2].reason_code,
								// autoModel4[1].i <> '' => autoModel4[1].reason_codes[2].reason_code,
								// autoModel5[1].i <> '' => autoModel5[1].reason_codes[2].reason_code,
								// autoModel6[1].i <> '' => autoModel6[1].reason_codes[2].reason_code,
								// '');
	// self.rv_auto_reason3 := map(autoModel1[1].i <> '' => autoModel1[1].reason_codes[3].reason_code,
								// autoModel2[1].i <> '' => autoModel2[1].reason_codes[3].reason_code,
								// autoModel3[1].i <> '' => autoModel3[1].reason_codes[3].reason_code,
								// autoModel4[1].i <> '' => autoModel4[1].reason_codes[3].reason_code,
								// autoModel5[1].i <> '' => autoModel5[1].reason_codes[3].reason_code,
								// autoModel6[1].i <> '' => autoModel6[1].reason_codes[3].reason_code,
								// '');
	// self.rv_auto_reason4 := map(autoModel1[1].i <> '' => autoModel1[1].reason_codes[4].reason_code,
								// autoModel2[1].i <> '' => autoModel2[1].reason_codes[4].reason_code,
								// autoModel3[1].i <> '' => autoModel3[1].reason_codes[4].reason_code,
								// autoModel4[1].i <> '' => autoModel4[1].reason_codes[4].reason_code,
								// autoModel5[1].i <> '' => autoModel5[1].reason_codes[4].reason_code,
								// autoModel6[1].i <> '' => autoModel6[1].reason_codes[4].reason_code,
								// '');
	// self.rv_auto_reason5 := map(autoModel1[1].i <> '' => autoModel1[1].reason_codes[5].reason_code,
								// autoModel2[1].i <> '' => autoModel2[1].reason_codes[5].reason_code,
								// autoModel3[1].i <> '' => autoModel3[1].reason_codes[5].reason_code,
								// autoModel4[1].i <> '' => autoModel4[1].reason_codes[5].reason_code,
								// autoModel5[1].i <> '' => autoModel5[1].reason_codes[5].reason_code,
								// autoModel6[1].i <> '' => autoModel6[1].reason_codes[5].reason_code,
								// '');
	
	// self.rv_score_bank := map(  bankModel1[1].i <> '' => bankModel1[1].i,
								// bankModel2[1].i <> '' => bankModel2[1].i,
								// bankModel3[1].i <> '' => bankModel3[1].i,
								// bankModel4[1].i <> '' => bankModel4[1].i,
								// bankModel5[1].i <> '' => bankModel5[1].i,
								// bankModel6[1].i <> '' => bankModel6[1].i,
								// '');
	// self.rv_bank_reason := map( bankModel1[1].i <> '' => bankModel1[1].reason_codes[1].reason_code,
								// bankModel2[1].i <> '' => bankModel2[1].reason_codes[1].reason_code,
								// bankModel3[1].i <> '' => bankModel3[1].reason_codes[1].reason_code,
								// bankModel4[1].i <> '' => bankModel4[1].reason_codes[1].reason_code,
								// bankModel5[1].i <> '' => bankModel5[1].reason_codes[1].reason_code,
								// bankModel6[1].i <> '' => bankModel6[1].reason_codes[1].reason_code,
								// '');
	// self.rv_bank_reason2 := map(bankModel1[1].i <> '' => bankModel1[1].reason_codes[2].reason_code,
								// bankModel2[1].i <> '' => bankModel2[1].reason_codes[2].reason_code,
								// bankModel3[1].i <> '' => bankModel3[1].reason_codes[2].reason_code,
								// bankModel4[1].i <> '' => bankModel4[1].reason_codes[2].reason_code,
								// bankModel5[1].i <> '' => bankModel5[1].reason_codes[2].reason_code,
								// bankModel6[1].i <> '' => bankModel6[1].reason_codes[2].reason_code,
								// '');
	// self.rv_bank_reason3 := map(bankModel1[1].i <> '' => bankModel1[1].reason_codes[3].reason_code,
								// bankModel2[1].i <> '' => bankModel2[1].reason_codes[3].reason_code,
								// bankModel3[1].i <> '' => bankModel3[1].reason_codes[3].reason_code,
								// bankModel4[1].i <> '' => bankModel4[1].reason_codes[3].reason_code,
								// bankModel5[1].i <> '' => bankModel5[1].reason_codes[3].reason_code,
								// bankModel6[1].i <> '' => bankModel6[1].reason_codes[3].reason_code,
								// '');
	// self.rv_bank_reason4 := map(bankModel1[1].i <> '' => bankModel1[1].reason_codes[4].reason_code,
								// bankModel2[1].i <> '' => bankModel2[1].reason_codes[4].reason_code,
								// bankModel3[1].i <> '' => bankModel3[1].reason_codes[4].reason_code,
								// bankModel4[1].i <> '' => bankModel4[1].reason_codes[4].reason_code,
								// bankModel5[1].i <> '' => bankModel5[1].reason_codes[4].reason_code,
								// bankModel6[1].i <> '' => bankModel6[1].reason_codes[4].reason_code,
								// '');
	// self.rv_bank_reason5 := map(bankModel1[1].i <> '' => bankModel1[1].reason_codes[5].reason_code,
								// bankModel2[1].i <> '' => bankModel2[1].reason_codes[5].reason_code,
								// bankModel3[1].i <> '' => bankModel3[1].reason_codes[5].reason_code,
								// bankModel4[1].i <> '' => bankModel4[1].reason_codes[5].reason_code,
								// bankModel5[1].i <> '' => bankModel5[1].reason_codes[5].reason_code,
								// bankModel6[1].i <> '' => bankModel6[1].reason_codes[5].reason_code,
								// '');
								
	// self.rv_score_retail := map(retaModel1[1].i <> '' => retaModel1[1].i,
								// retaModel2[1].i <> '' => retaModel2[1].i,
								// retaModel3[1].i <> '' => retaModel3[1].i,
								// retaModel4[1].i <> '' => retaModel4[1].i,
								// retaModel5[1].i <> '' => retaModel5[1].i,
								// retaModel6[1].i <> '' => retaModel6[1].i,
								// '');
	// self.rv_retail_reason := map( retaModel1[1].i <> '' => retaModel1[1].reason_codes[1].reason_code,
								// retaModel2[1].i <> '' => retaModel2[1].reason_codes[1].reason_code,
								// retaModel3[1].i <> '' => retaModel3[1].reason_codes[1].reason_code,
								// retaModel4[1].i <> '' => retaModel4[1].reason_codes[1].reason_code,
								// retaModel5[1].i <> '' => retaModel5[1].reason_codes[1].reason_code,
								// retaModel6[1].i <> '' => retaModel6[1].reason_codes[1].reason_code,
								// '');
	// self.rv_retail_reason2 := map(retaModel1[1].i <> '' => retaModel1[1].reason_codes[2].reason_code,
								// retaModel2[1].i <> '' => retaModel2[1].reason_codes[2].reason_code,
								// retaModel3[1].i <> '' => retaModel3[1].reason_codes[2].reason_code,
								// retaModel4[1].i <> '' => retaModel4[1].reason_codes[2].reason_code,
								// retaModel5[1].i <> '' => retaModel5[1].reason_codes[2].reason_code,
								// retaModel6[1].i <> '' => retaModel6[1].reason_codes[2].reason_code,
								// '');
	// self.rv_retail_reason3 := map(retaModel1[1].i <> '' => retaModel1[1].reason_codes[3].reason_code,
								// retaModel2[1].i <> '' => retaModel2[1].reason_codes[3].reason_code,
								// retaModel3[1].i <> '' => retaModel3[1].reason_codes[3].reason_code,
								// retaModel4[1].i <> '' => retaModel4[1].reason_codes[3].reason_code,
								// retaModel5[1].i <> '' => retaModel5[1].reason_codes[3].reason_code,
								// retaModel6[1].i <> '' => retaModel6[1].reason_codes[3].reason_code,
								// '');
	// self.rv_retail_reason4 := map(retaModel1[1].i <> '' => retaModel1[1].reason_codes[4].reason_code,
								// retaModel2[1].i <> '' => retaModel2[1].reason_codes[4].reason_code,
								// retaModel3[1].i <> '' => retaModel3[1].reason_codes[4].reason_code,
								// retaModel4[1].i <> '' => retaModel4[1].reason_codes[4].reason_code,
								// retaModel5[1].i <> '' => retaModel5[1].reason_codes[4].reason_code,
								// retaModel6[1].i <> '' => retaModel6[1].reason_codes[4].reason_code,
								// '');							
	// self.rv_retail_reason5 := map(retaModel1[1].i <> '' => retaModel1[1].reason_codes[5].reason_code,
								// retaModel2[1].i <> '' => retaModel2[1].reason_codes[5].reason_code,
								// retaModel3[1].i <> '' => retaModel3[1].reason_codes[5].reason_code,
								// retaModel4[1].i <> '' => retaModel4[1].reason_codes[5].reason_code,
								// retaModel5[1].i <> '' => retaModel5[1].reason_codes[5].reason_code,
								// retaModel6[1].i <> '' => retaModel6[1].reason_codes[5].reason_code,
								// '');							
								
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
									
	// self.rv_score_money := map( monyModel1[1].i <> '' => monyModel1[1].i,
								// monyModel2[1].i <> '' => monyModel2[1].i,
								// monyModel3[1].i <> '' => monyModel3[1].i,
								// monyModel4[1].i <> '' => monyModel4[1].i,
								// monyModel5[1].i <> '' => monyModel5[1].i,
								// monyModel6[1].i <> '' => monyModel6[1].i,
								// '');
	// self.rv_money_reason := map(monyModel1[1].i <> '' => monyModel1[1].reason_codes[1].reason_code,
								// monyModel2[1].i <> '' => monyModel2[1].reason_codes[1].reason_code,
								// monyModel3[1].i <> '' => monyModel3[1].reason_codes[1].reason_code,
								// monyModel4[1].i <> '' => monyModel4[1].reason_codes[1].reason_code,
								// monyModel5[1].i <> '' => monyModel5[1].reason_codes[1].reason_code,
								// monyModel6[1].i <> '' => monyModel6[1].reason_codes[1].reason_code,
								// '');
	// self.rv_money_reason2 := map(monyModel1[1].i <> '' => monyModel1[1].reason_codes[2].reason_code,
								// monyModel2[1].i <> '' => monyModel2[1].reason_codes[2].reason_code,
								// monyModel3[1].i <> '' => monyModel3[1].reason_codes[2].reason_code,
								// monyModel4[1].i <> '' => monyModel4[1].reason_codes[2].reason_code,
								// monyModel5[1].i <> '' => monyModel5[1].reason_codes[2].reason_code,
								// monyModel6[1].i <> '' => monyModel6[1].reason_codes[2].reason_code,
								// '');
	// self.rv_money_reason3 := map(monyModel1[1].i <> '' => monyModel1[1].reason_codes[3].reason_code,
								// monyModel2[1].i <> '' => monyModel2[1].reason_codes[3].reason_code,
								// monyModel3[1].i <> '' => monyModel3[1].reason_codes[3].reason_code,
								// monyModel4[1].i <> '' => monyModel4[1].reason_codes[3].reason_code,
								// monyModel5[1].i <> '' => monyModel5[1].reason_codes[3].reason_code,
								// monyModel6[1].i <> '' => monyModel6[1].reason_codes[3].reason_code,
								// '');
	// self.rv_money_reason4 := map(monyModel1[1].i <> '' => monyModel1[1].reason_codes[4].reason_code,
								// monyModel2[1].i <> '' => monyModel2[1].reason_codes[4].reason_code,
								// monyModel3[1].i <> '' => monyModel3[1].reason_codes[4].reason_code,
								// monyModel4[1].i <> '' => monyModel4[1].reason_codes[4].reason_code,
								// monyModel5[1].i <> '' => monyModel5[1].reason_codes[4].reason_code,
								// monyModel6[1].i <> '' => monyModel6[1].reason_codes[4].reason_code,
								// '');							
	// self.rv_money_reason5 := map(monyModel1[1].i <> '' => monyModel1[1].reason_codes[5].reason_code,
								// monyModel2[1].i <> '' => monyModel2[1].reason_codes[5].reason_code,
								// monyModel3[1].i <> '' => monyModel3[1].reason_codes[5].reason_code,
								// monyModel4[1].i <> '' => monyModel4[1].reason_codes[5].reason_code,
								// monyModel5[1].i <> '' => monyModel5[1].reason_codes[5].reason_code,
								// monyModel6[1].i <> '' => monyModel6[1].reason_codes[5].reason_code,
								// '');							
								
	// self.rv_score_prescreen := map( presModel1[1].i <> '' => presModel1[1].i,
									// presModel2[1].i <> '' => presModel2[1].i,
									// presModel3[1].i <> '' => presModel3[1].i,
									// presModel4[1].i <> '' => presModel4[1].i,
									// presModel5[1].i <> '' => presModel5[1].i,
									// presModel6[1].i <> '' => presModel6[1].i,
									// '');	
	// self.RV_prescreen_reason := map( presModel1[1].i <> '' => presModel1[1].reason_codes[1].reason_code,
									// presModel2[1].i <> '' => presModel2[1].reason_codes[1].reason_code,
									// presModel3[1].i <> '' => presModel3[1].reason_codes[1].reason_code,
									// presModel4[1].i <> '' => presModel4[1].reason_codes[1].reason_code,
									// presModel5[1].i <> '' => presModel5[1].reason_codes[1].reason_code,
									// presModel6[1].i <> '' => presModel6[1].reason_codes[1].reason_code,
									// '');		
	self := L;
self := [];
end;

j_f := JOIN(resu,p_f,LEFT.accountnumber=RIGHT.accountnumber,normit(LEFT,RIGHT));
 // output(j_f, named('j_f'));



op_final := output(J_F,, outfile_name , CSV(HEADING(single), QUOTE('"')), OVERWRITE);

fin_res := sequential(op_final);

return fin_res;

endmacro;





