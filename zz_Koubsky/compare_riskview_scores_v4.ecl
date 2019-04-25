// EXPORT compare_riskview_v4 := 'todo';

import risk_indicators, ut, ashirey;

eyeball := 25;

score_input_layout := RECORD
  string30 acctno;
  string3 rv_score_auto;
  string3 rv_auto_reason;
  string3 rv_auto_reason2;
  string3 rv_auto_reason3;
  string3 rv_auto_reason4;
  string3 rv_auto_reason5;
  string3 rv_score_bank;
  string3 rv_bank_reason;
  string3 rv_bank_reason2;
  string3 rv_bank_reason3;
  string3 rv_bank_reason4;
  string3 rv_bank_reason5;
  string3 rv_score_retail;
  string3 rv_retail_reason;
  string3 rv_retail_reason2;
  string3 rv_retail_reason3;
  string3 rv_retail_reason4;
  string3 rv_retail_reason5;
  string3 rv_score_telecom;
  string3 rv_telecom_reason;
  string3 rv_telecom_reason2;
  string3 rv_telecom_reason3;
  string3 rv_telecom_reason4;
  string3 rv_telecom_reason5;
  string3 rv_score_money;
  string3 rv_money_reason;
  string3 rv_money_reason2;
  string3 rv_money_reason3;
  string3 rv_money_reason4;
  string3 rv_money_reason5;
  string3 rv_score_prescreen;
  string3 rv_prescreen_reason;
  string6 historydate;
  unsigned6 did;
  boolean fnamepop;
  boolean lnamepop;
  boolean addrpop;
  string1 ssnlength;
  boolean dobpop;
  boolean emailpop;
  boolean ipaddrpop;
  boolean hphnpop;
  string200 errorcode;
 END;
 
pii_layout := RECORD
    STRING Account;
    STRING FirstName;
    STRING MiddleName;
    STRING LastName;
    STRING StreetAddress;
    STRING City;
    STRING State;
    STRING Zip;
    STRING HomePhone;
    STRING SSN;
    STRING DateOfBirth;
    STRING WorkPhone;
    STRING income;  
    string DLNumber;
    string DLState;													
    string BALANCE; 
    string CHARGEOFFD;  
    string FormerName;
    string EMAIL;  
    string employername;
    integer historydateyyyymm;
  END;

join_lay := RECORD
	score_input_layout results;
	pii_layout pii;
END;

basefilename := '~sghatti::out::batch_fcra_rvscores_v4_20140609_1';
testfilename := '~sghatti::out::batch_fcra_rvscores_v4_20140611_1';  

ds_baseline := dataset(basefilename, score_input_layout, csv(quote('"'), maxlength(32000), HEADING(1)));
ds_second := dataset(testfilename, score_input_layout, csv(quote('"'), maxlength(32000), HEADING(1)));

pii_filename := ut.foreign_prod + 'nmontpetit::in::ge_cap_100302_pii';  

ds_pii_file := dataset(pii_filename, pii_layout, csv(quote('"'), maxlength(32000), HEADING(1)));

OUTPUT(COUNT(ds_baseline), NAMED('baseline_cnt'));
OUTPUT(CHOOSEN(ds_baseline(), eyeball), NAMED('baseline'));
OUTPUT(COUNT(ds_second), NAMED('second_cnt'));
OUTPUT(CHOOSEN(ds_second(), eyeball), NAMED('second'));
OUTPUT(COUNT(ds_pii_file), NAMED('pii_cnt'));
OUTPUT(CHOOSEN(ds_pii_file(), eyeball), NAMED('pii'));


   
// basetable1 := table(ds_baseline1,{errorcode, total := count(group)}, errorcode);
// basetable2 := table(ds_baseline2,{errorcode, total := count(group)}, errorcode);
// output(basetable1, named('error_tally_01_24'));
// output(basetable2, named('error_tally_01_25'));
   
cmpr := RECORD
		DATASET(join_lay) res;
END;
	
blank := DATASET(1, TRANSFORM(join_lay, SELF.results.acctno := '-', SELF := []));
      
base_append := JOIN(ds_baseline, ds_pii_file, LEFT.acctno = RIGHT.Account,
				TRANSFORM(join_lay, SELF.results := LEFT; SELF.pii := RIGHT));
				
second_append := JOIN(ds_baseline, ds_pii_file, LEFT.acctno = RIGHT.Account,
				TRANSFORM(join_lay, SELF.results := LEFT; SELF.pii := RIGHT));
      					
j2 := JOIN(base_append, second_append, LEFT.results.acctno = RIGHT.results.acctno	AND (
				(LEFT.results.rv_score_auto <> RIGHT.results.rv_score_auto AND LEFT.results.rv_score_auto < '300') OR
				(LEFT.results.rv_score_bank <> RIGHT.results.rv_score_bank AND LEFT.results.rv_score_bank < '300') OR
				(LEFT.results.rv_score_retail <> RIGHT.results.rv_score_retail AND LEFT.results.rv_score_retail < '300') OR
				(LEFT.results.rv_score_telecom <> RIGHT.results.rv_score_telecom AND LEFT.results.rv_score_telecom < '300') OR
				(LEFT.results.rv_score_money <> RIGHT.results.rv_score_money AND LEFT.results.rv_score_money < '300') // OR
				// (LEFT.results.rv_score_prescreen <> RIGHT.results.rv_score_prescreen AND LEFT.results.rv_score_prescreen < '300')
				), 
				// TRANSFORM(join_lay, SELF := LEFT));
				TRANSFORM(cmpr, SELF.res := LEFT + RIGHT));
				// TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));
   						

ashirey.Diff(ds_baseline, ds_second, ['acctno'], j1, 'RV4' );

OUTPUT(COUNT(base_append), NAMED('base_append_count'));
OUTPUT(CHOOSEN(base_append, eyeball), NAMED('base_append'));
OUTPUT(COUNT(second_append), NAMED('second_append_count'));
OUTPUT(CHOOSEN(second_append, eyeball), NAMED('second_append'));

OUTPUT(COUNT(j1), NAMED('macro_differences'));
OUTPUT(CHOOSEN(j1, eyeball), NAMED('macro_difference_count'));
OUTPUT(COUNT(j2), NAMED('differences'));
OUTPUT(CHOOSEN(j2, eyeball), NAMED('difference_count'));