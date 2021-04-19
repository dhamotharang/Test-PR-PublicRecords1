#workunit('name','FCRA-RiskView attributes');


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
end;

f := DATASET('~tfuerstenberg::in::sprint_input',prii_layout,csv(quote('"')));
//f := choosen(dataset('~tfuerstenberg::in::worlds_input',prii_layout, csv(quote('"'))),5);
output(f, named('original_input'));


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
	boolean  Attributes :=False;
	dataset(Models.Layout_Score_Chooser) scores;
	dataset(Risk_Indicators.Layout_Gateways_In) gateways;
end;

params := dataset([], models.Layout_Parameters);

l := RECORD
	STRING old_account_number;
	layout_soap;
END;


fcraroxieIP := 'http://prdrfcrathorvip.hpcc.risk.regn.net:9876'; 


l t_f(f le, INTEGER c) := TRANSFORM
	SELF.old_account_number := le.account;
	SELF.Accountnumber := (STRING)c;	
	SELF.DPPAPurpose := 0;
	SELF.GLBPurpose := 5;
	SELF.Attributes := True;
	self.HistoryDateYYYYMM:=999999;

// use it for FCRA RiskView
//	self.scores := dataset([{'Models.RVAuto_Service', fcraroxieIP, params}], models.Layout_Score_Chooser); 
//  self.scores := dataset([{'Models.RVBankCard_Service', fcraroxieIP,params}], models.Layout_Score_Chooser); 
//	self.scores := dataset([{'Models.RVRetail_Service', fcraroxieIP,params}], models.Layout_Score_Chooser); 
	self.scores := dataset([{'Models.RVTelecom_Service', fcraroxieIP,params}], models.Layout_Score_Chooser); 
	self.gateways := dataset([{'neutralroxie', 'http://prdrroxiethorvip.hpcc.risk.regn.net:9876'}], risk_indicators.Layout_Gateways_In);
//	self.gateways := dataset([{'neutralroxie', 'http://roxievip.br.seisint.com:9876'}], risk_indicators.Layout_Gateways_In);
	SELF := le;
	self := [];
end;

p_f := project(f, t_f(left, counter));
output(p_f, named('RV_Input'));

dist_dataset := PROJECT(p_f,TRANSFORM(layout_soap,SELF := LEFT));

Layout_Attribute := RECORD
	DATASET(Models.Layout_Parameters) Attribute;
END;
Layout_AttributeGroup := RECORD
	string name;
	string index;
	DATASET(Layout_Attribute) Attributes;
END;
layout_RVAttributesOut := RECORD
	string30 accountnumber;
	DATASET(Layout_AttributeGroup) AttributeGroup;
END;
xlayout := RECORD
	STRING30 AccountNumber;
	DATASET(Models.Layout_Model) models;
	Layout_RVAttributesOut AttributeGroups;
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
				PARALLEL(30), onFail(myFail(LEFT)));
				
output(resu, named('resu'));


			
rv_attributes_norm := RECORD
	string30 AccountNumber;
	// lifestyle
	string1 dwelltype;
	string11 assessed_amount;
//	string11 automated_valuation;
	string5 applicant_owned;
	string5 family_owned;
	string5 occupant_owned;
	string5 isbestmatch;
	string8 date_first_seen;
	string8 date_first_seen2;
	string8 date_first_seen3;
	string2 number_nonderogs;
	string8 date_last_seen;
	string5 recent_update;
	string60 license_type;
	// dems
	string3 age;
	string5 ssn_issued;
	string8 low_issue_date;
	string8 high_issue_date;
	string5 nonUS_ssn;
	string2 ssn_issue_state;
	string8 ssn_first_seen;
	// finance
	string5 phone_full_name_match;
	string5 phone_last_name_match;
	string1 nap_status;
	string8 credit_first_seen;
	// property
	string2 property_owned_total;
	string13 property_owned_assessed_total;
//	string13 prop_automated_valuation;
	string2 property_historically_owned;
	string8 date_most_recent_purchase;
	string8 date_first_purchase;
	// derogs
	string2 criminal_count;
	string2 filing_count;
	string8 derog_date_last_seen;
	string35 disposition;
	string2 liens_historical_unreleased_count;
	string2 liens_recent_unreleased_count;
	string2 judgements_count;
	string2 evictions_count;
	string2 foreclosure_count;
	string2 total_number_derogs;
	string8 date_last_derog;
	
	string3 RV_score;
	string3 RV_reason;
	string3 RV_reason2;
	string3 RV_reason3;
	string3 RV_reason4;
	
	string errorcode;
END;


get_group(recordof(layout_rvattributesout) groups, string name_i) := function
	groupi := groups.attributegroup(name=name_i);
	return groupi;
end;


get_attribute(dataset(Layout_AttributeGroup) groupi, integer i) := function
	attr := groupi.attributes[i];
	return attr;	
end;

rv_attributes_norm normit(resu L, p_f R) := transform
	self.AccountNumber := r.old_account_number;
	
	
	just_groups := project(l, transform(layout_RVAttributesOut, self := l.attributegroups));
	
	// Lifestyle
	life := get_group(just_groups, 'Lifestyle');
	life1 := get_attribute(life, 1);
	life2 := get_attribute(life, 2);
	life3 := get_attribute(life, 3);
	life4 := get_attribute(life, 4);
	life5 := get_attribute(life, 5);
	life6 := get_attribute(life, 6);
	life7 := get_attribute(life, 7);
	life8 := get_attribute(life, 8);
	life9 := get_attribute(life, 9);
	life10 := get_attribute(life, 10);
	life11 := get_attribute(life, 11);
	life12 := get_attribute(life, 12);
	life13 := get_attribute(life, 13);
//	life14 := get_attribute(life, 14);
	
	self.dwelltype := life1.attribute[1].value;
	self.assessed_amount := life2.attribute[1].value;
//	self.automated_valuation := life3.attribute[1].value;
	self.applicant_owned := life3.attribute[1].value;
	self.family_owned := life4.attribute[1].value;
	self.occupant_owned := life5.attribute[1].value;
	self.isbestmatch := life6.attribute[1].value;
	self.date_first_seen := life7.attribute[1].value;
	self.date_first_seen2 := life8.attribute[1].value;
	self.date_first_seen3 := life9.attribute[1].value;
	self.number_nonderogs := life10.attribute[1].value;
	self.date_last_seen := life11.attribute[1].value;
	self.recent_update := life12.attribute[1].value;
	self.license_type := life13.attribute[1].value;
	
	// dems
	dems := get_group(just_groups, 'Demographic');
	dems1 := get_attribute(dems, 1);
	dems2 := get_attribute(dems, 2);
	dems3 := get_attribute(dems, 3);
	dems4 := get_attribute(dems, 4);
	dems5 := get_attribute(dems, 5);
	dems6 := get_attribute(dems, 6);
	dems7 := get_attribute(dems, 7);

	self.age := dems1.attribute[1].value;
	self.ssn_issued := dems2.attribute[1].value;
	self.low_issue_date := dems3.attribute[1].value;
	self.high_issue_date := dems4.attribute[1].value;
	self.nonUS_ssn := dems5.attribute[1].value;
	self.ssn_issue_state := dems6.attribute[1].value;
	self.ssn_first_seen := dems7.attribute[1].value;
	
	// finance
	fins := get_group(just_groups, 'Financial');
	fins1 := get_attribute(fins, 1);
	fins2 := get_attribute(fins, 2);
	fins3 := get_attribute(fins, 3);
	fins4 := get_attribute(fins, 4);
	
	self.phone_full_name_match := fins1.attribute[1].value;
	self.phone_last_name_match := fins2.attribute[1].value;
	self.nap_status := fins3.attribute[1].value;
	self.credit_first_seen := fins4.attribute[1].value;
	
	// property
	props := get_group(just_groups, 'Property');
	props1 := get_attribute(props, 1);
	props2 := get_attribute(props, 2);
	props3 := get_attribute(props, 3);
	props4 := get_attribute(props, 4);
	props5 := get_attribute(props, 5);
//	props6 := get_attribute(props, 6);
	
	self.property_owned_total := props1.attribute[1].value;
	self.property_owned_assessed_total := props2.attribute[1].value;
//	self.prop_automated_valuation := props3.attribute[1].value;
	self.property_historically_owned := props3.attribute[1].value;
	self.date_most_recent_purchase := props4.attribute[1].value;
	self.date_first_purchase := props5.attribute[1].value;
	
	// derogs
	derogs := get_group(just_groups, 'Derogatory');
	derogs1 := get_attribute(derogs, 1);
	derogs2 := get_attribute(derogs, 2);
	derogs3 := get_attribute(derogs, 3);
	derogs4 := get_attribute(derogs, 4);
	derogs5 := get_attribute(derogs, 5);
	derogs6 := get_attribute(derogs, 6);
	derogs7 := get_attribute(derogs, 7);
	derogs8 := get_attribute(derogs, 8);
	derogs9 := get_attribute(derogs, 9);
	derogs10 := get_attribute(derogs, 10);
	derogs11 := get_attribute(derogs, 11);
	
	self.criminal_count := derogs1.attribute[1].value;
	self.filing_count := derogs2.attribute[1].value;
	self.derog_date_last_seen := derogs3.attribute[1].value;
	self.disposition := derogs4.attribute[1].value;
	self.liens_historical_unreleased_count := derogs5.attribute[1].value;
	self.liens_recent_unreleased_count := derogs6.attribute[1].value;
	self.judgements_count := derogs7.attribute[1].value;
	self.evictions_count := derogs8.attribute[1].value;
	self.foreclosure_count := derogs9.attribute[1].value;
	self.total_number_derogs := derogs10.attribute[1].value;
	self.date_last_derog := derogs11.attribute[1].value;
	
	
	self.rv_score := l.models[1].scores[1].i;
	self.rv_reason := l.models[1].scores[1].reason_codes[1].reason_code;
	self.rv_reason2 := l.models[1].scores[1].reason_codes[2].reason_code;
	self.rv_reason3 := l.models[1].scores[1].reason_codes[3].reason_code;
	self.rv_reason4 := l.models[1].scores[1].reason_codes[4].reason_code;
	
	self := l;
	self := [];
end;


j_f := JOIN(resu,p_f,LEFT.attributegroups.accountnumber=RIGHT.accountnumber,normit(LEFT,RIGHT));

output(j_f);

output(j_f,,'~tfuerstenberg::out::sprint_RVTelecom_rvattrib_out',CSV(QUOTE('"')), overwrite);
output(j_f(errorcode<>''),,'~tfuerstenberg::out::sprint_RVTelecom_rvattrib_error',CSV(QUOTE('"')), overwrite);

