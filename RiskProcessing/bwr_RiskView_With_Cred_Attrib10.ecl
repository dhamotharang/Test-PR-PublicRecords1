#workunit('name','FCRA-Credit Attributes 1.0');
#option ('hthorMemoryLimit', 1000)


// NOTE:  THIS WILL ONLY OUTPUT VERSION1 ATTRIBUTES, COPIED FROM VERSION2

import models, Risk_Indicators;

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

// f := dataset('~tfuerstenberg::in::valuedservices_779_in',prii_layout, csv(quote('"')));
f := choosen(dataset('~tfuerstenberg::in::lobel_1259_in',prii_layout, csv(quote('"'))),5);

output(f, named('original_input'));


Layout_Attributes_In := RECORD
	string name;
END;


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
	integer HistoryDateYYYYMM := 999999;
	boolean Attributes := False;
	dataset(Models.Layout_Score_Chooser) scores;
	dataset(Layout_Attributes_In) RequestedAttributeGroups;
	dataset(Risk_Indicators.Layout_Gateways_In) gateways;
end;

// params := dataset([], models.Layout_Parameters);
params := dataset([{'Custom', 'rvr711_0'}], models.Layout_Parameters);	// use this for non-version1 models, also possibly change the scores that you call below

// current possible models available as of 7/25/2008
	// version 2 riskview
		// rvb711_0 - bankcard
		// rva711_0 - auto
		// rvt711_0 - telecom
		// rvr711_0 - retail
	// Custom retail models 
		// rvr803_1	- retail		 
	// Custom auto models 
		// aid605_1	- auto
		// aid607_0 - auto
		// rva707_0 - subprime auto



l := RECORD
	STRING old_account_number;
	layout_soap;
END;


fcraroxieIP := 'http://fcrathorvip.hpcc.risk.regn.net:9876'; 

l t_f(f le, INTEGER c) := TRANSFORM
	SELF.old_account_number := le.account;
	SELF.Accountnumber := (STRING)c;	
	SELF.Attributes := True;
	
	// 	for version1 attributes, there are 5 sections, each of which can be removed independently of the others, just comment that one out if not needed.  
	//	if all commented out then they are all ON
	// SELF.RequestedAttributeGroups := dataset([{'Lifestyle'},
											  // {'Demographic'},
											  // {'Financial'},
											  // {'Property'},
											  // {'Derogatory'}], layout_attributes_in); 

//	self.HistoryDateYYYYMM := le.historydateyyyymm; //999999;

// use it for FCRA RiskView
//	self.scores := dataset([{'Models.RVAuto_Service', fcraroxieIP, params}], models.Layout_Score_Chooser); 
//  self.scores := dataset([{'Models.RVBankCard_Service', fcraroxieIP,params}], models.Layout_Score_Chooser); 
	self.scores := dataset([{'Models.RVRetail_Service', fcraroxieIP,params}], models.Layout_Score_Chooser); 
//	self.scores := dataset([{'Models.RVTelecom_Service', fcraroxieIP,params}], models.Layout_Score_Chooser); 
	self.gateways := dataset([{'neutralroxie', 'http://roxiethorvip.hpcc.risk.regn.net:9856'}], risk_indicators.Layout_Gateways_In);

	SELF := le;
	self := [];
end;

p_f := project(f, t_f(left, counter));
output(p_f, named('RV_Input'));
output(count(p_f));


dist_dataset := PROJECT(p_f,TRANSFORM(layout_soap,SELF := LEFT));

Layout_Attribute := RECORD, maxlength(100000)
	DATASET(Models.Layout_Parameters) Attribute;
END;
Layout_AttributeGroup := RECORD, maxlength(100000)
	string name;
	string index;
	DATASET(Layout_Attribute) Attributes;
END;
layout_RVAttributesOut := RECORD, maxlength(100000)
	string30 accountnumber;
	DATASET(Layout_AttributeGroup) AttributeGroup;
END;
xlayout := RECORD, maxlength(100000)
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
                    RETRY(5), TIMEOUT(500), LITERAL,
                    XPATH('Models.RiskView_Testing_ServiceResponse/Results/Result/Dataset[@name=\'Results\']/Row'),
										PARALLEL(25), onFail(myFail(LEFT)));
				
output(resu, named('resu'));


			
rv_attributes_norm := RECORD
	unsigned seq;

	string30 AccountNumber;
	
	// Lifestyle
	string1 dwelltype;
	string11 assessed_amount;
	string1 applicant_owned;
	string1 family_owned;
	string1 occupant_owned;
	string1 isbestmatch;
	string8 date_first_seen;
	string8 date_first_seen2;
	string8 date_first_seen3;
	string2 number_nonderogs;
	string8 date_last_seen;
	string1 recent_update;
	string60 license_type;	// not output in version 1, always blank
	
	// Demographic
	string3 age;	// not output in version 1, always blank
	string1 ssn_issued;
	string8 low_issue_date;
	string8 high_issue_date;
	string1 nonUS_ssn;
	string2 ssn_issue_state;
	string6 ssn_first_seen;
	
	// Financial
	string1 phone_full_name_match;
	string1 phone_last_name_match;
	string1 nap_status;
	string6 credit_first_seen;	// not output in version 1, always blank
	
	// Property
	string2 property_owned_total;
	string13 property_owned_assessed_total;
	string2 property_historically_owned;
	string6 date_most_recent_purchase;	// not output in version 1, always blank
	string6 date_first_purchase;		// not output in version 1, always blank
	
	// Derogatory
	string2 criminal_count;
	string2 filing_count;
	string8 date_last_seen2;
	string35 disposition;
	string2 liens_historical_unreleased_count;
	string2 liens_recent_unreleased_count;
	string2 judgements_count;	// not output in version 1, always blank
	string2 evictions_count;	// not output in version 1, always blank
	string2 foreclosure_count;	// not output in version 1, always blank
	string2 total_number_derogs;
	string6 date_last_derog;	// not output in version 1, always blank
	
	// Scores
	string3 RV_score;
	string3 RV_reason;
	string3 RV_reason2;
	string3 RV_reason3;
	string3 RV_reason4;
	
	string6 history_date;
	
	string10 errorcode;
END;


get_group(recordof(layout_rvattributesout) groups, string name_i) := function
	groupi := groups.attributegroup(name=name_i);
	return groupi;
end;


get_attribute(dataset(Layout_AttributeGroup) groupi, integer i) := function
	attr := groupi.attributes[i];
	// return attr;
	
	// temporary conversion of booleans until the riskview product starts returning booleans as 0 and 1 instead of true and false
	// checkBoolean(boolean x) := if(x, 'true', 'false');
			attribute_values_converted := dataset([{attr.attribute[1].name, map(attr.attribute[1].value='true' => '1',
														  attr.attribute[1].value='false' => '0',
														  attr.attribute[1].value) }], Models.Layout_Parameters);
														 
			attr_converted := DATASET([{attribute_values_converted}], Layout_Attribute);
			return attr_converted;
	// end of temporary conversion for booleans
	
end;



rv_attributes_norm normit(resu L, p_f R) := transform
	self.AccountNumber := r.old_account_number;
	
	
	just_groups := project(l, transform(layout_RVAttributesOut, self := l.attributegroups));
	
	// version1 output
	Life := get_group(just_groups, 'Lifestyle');
	v11 := get_attribute(Life, 1);
	v12 := get_attribute(Life, 2);
	v13 := get_attribute(Life, 3);
	v14 := get_attribute(Life, 4);
	v15 := get_attribute(Life, 5);
	v16 := get_attribute(Life, 6);
	v17 := get_attribute(Life, 7);
	v18 := get_attribute(Life, 8);
	v19 := get_attribute(Life, 9);
	v110 := get_attribute(Life, 10);
	v111 := get_attribute(Life, 11);
	v112 := get_attribute(Life, 12);
	v113 := get_attribute(Life, 13);
	
	Demo := get_group(just_groups, 'Demographic');
	v114 := get_attribute(Demo, 1);
	v115 := get_attribute(Demo, 1);
	v116 := get_attribute(Demo, 2);
	v117 := get_attribute(Demo, 3);
	v118 := get_attribute(Demo, 4);
	v119 := get_attribute(Demo, 5);
	v120 := get_attribute(Demo, 6);
	
	Fin := get_group(just_groups, 'Financial');
	v121 := get_attribute(Fin, 1);
	v122 := get_attribute(Fin, 2);
	v123 := get_attribute(Fin, 3);
	v124 := get_attribute(Fin, 4);
	
	Prop := get_group(just_groups, 'Property');
	v125 := get_attribute(Prop, 1);
	v126 := get_attribute(Prop, 2);
	v127 := get_attribute(Prop, 3);
	v128 := get_attribute(Prop, 4);
	v129 := get_attribute(Prop, 5);
	
	Derog := get_group(just_groups, 'Derogatory');
	v130 := get_attribute(Derog, 1);
	v131 := get_attribute(Derog, 2);
	v132 := get_attribute(Derog, 3);
	v133 := get_attribute(Derog, 4);
	v134 := get_attribute(Derog, 5);
	v135 := get_attribute(Derog, 6);
	v136 := get_attribute(Derog, 7);
	v137 := get_attribute(Derog, 8);
	v138 := get_attribute(Derog, 9);
	v139 := get_attribute(Derog, 7);
	v140 := get_attribute(Derog, 11);

	
	self.dwelltype := v11.attribute[1].value;
	self.assessed_amount := v12.attribute[1].value;
	self.applicant_owned := v13.attribute[1].value;
	self.family_owned := v14.attribute[1].value;
	self.occupant_owned := v15.attribute[1].value;
	self.isbestmatch := v16.attribute[1].value;
	self.date_first_seen := v17.attribute[1].value;
	self.date_first_seen2 := v18.attribute[1].value;
	self.date_first_seen3 := v19.attribute[1].value;
	self.number_nonderogs := v110.attribute[1].value;
	self.date_last_seen := v111.attribute[1].value;
	self.recent_update := v112.attribute[1].value;
	self.license_type := v113.attribute[1].value;
	
	// Demographic
	self.age := '';//v114.attribute[1].value;
	self.ssn_issued := v115.attribute[1].value;
	self.low_issue_date := v116.attribute[1].value;
	self.high_issue_date := v117.attribute[1].value;
	self.nonUS_ssn := v118.attribute[1].value;
	self.ssn_issue_state := v119.attribute[1].value;
	self.ssn_first_seen := v120.attribute[1].value;
	
	// Financial
	self.phone_full_name_match := v121.attribute[1].value;
	self.phone_last_name_match := v122.attribute[1].value;
	self.nap_status := v123.attribute[1].value;
	self.credit_first_seen := '';//v124.attribute[1].value;
	
	// Property
	self.property_owned_total := v125.attribute[1].value;
	self.property_owned_assessed_total := v126.attribute[1].value;
	self.property_historically_owned := v127.attribute[1].value;
	self.date_most_recent_purchase := '';//v128.attribute[1].value;
	self.date_first_purchase := '';//v129.attribute[1].value;
	
	// Derogatory
	self.criminal_count := v130.attribute[1].value;
	self.filing_count := v131.attribute[1].value;
	self.date_last_seen2 := v132.attribute[1].value;
	self.disposition := v133.attribute[1].value;
	self.liens_historical_unreleased_count := v134.attribute[1].value;
	self.liens_recent_unreleased_count := v135.attribute[1].value;
	self.judgements_count := '';//v136.attribute[1].value;
	self.evictions_count := '';//v137.attribute[1].value;
	self.foreclosure_count := '';//v138.attribute[1].value;
	self.total_number_derogs := v139.attribute[1].value;
	self.date_last_derog := '';//v140.attribute[1].value;
	
	
	self.rv_score := l.models[1].scores[1].i;
	self.rv_reason := l.models[1].scores[1].reason_codes[1].reason_code;
	self.rv_reason2 := l.models[1].scores[1].reason_codes[2].reason_code;
	self.rv_reason3 := l.models[1].scores[1].reason_codes[3].reason_code;
	self.rv_reason4 := l.models[1].scores[1].reason_codes[4].reason_code;
	
	self.history_date := (string)r.HistoryDateYYYYMM;

	self.seq := (unsigned)l.accountnumber;
	
	self := l;
	self := [];
end;


j_f := JOIN(resu,p_f,LEFT.attributegroups.accountnumber=RIGHT.accountnumber,normit(LEFT,RIGHT));

output(j_f);

// ******* Resort output to original order ********

layout_final := RECORD
	rv_attributes_norm - seq;
end;

s := sort(j_f, seq);

layout_final intoFinal(s le) := transform
	self := le;
end;
final := project(s, intoFinal(left));
output(final);

// *************************************************

output(final,,'~tfuerstenberg::out::test_attrib_out',CSV(heading(single), quote('"')), overwrite);
output(final(errorcode<>''),,'~tfuerstenberg::out::test_attrib_error',CSV(QUOTE('"')), overwrite);
