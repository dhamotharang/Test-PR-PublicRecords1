// EXPORT compare_santander_rva1304 := 'todo';

#workunit('name','Santander Compare');

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
 END;
 
pii_layout := RECORD
  unsigned8 date_added;
  string customer;
  string source_info;
  integer1 perm_flag;
  integer3 accountnumber;
  string firstname;
  string middlename;
  string lastname;
  string streetaddress;
  string city;
  string state;
  string zip;
  string homephone;
  string ssn;
  string dateofbirth;
  string workphone;
  string income;
  string dlnumber;
  string dlstate;
  string balance;
  string chargeoffd;
  string formername;
  string email;
  string company;
  integer8 historydateyyyymm;
  string placeholder_1;
  string placeholder_2;
  string placeholder_3;
  string placeholder_4;
  string placeholder_5;
  string dppa;
  string glb;
  string drm;
  integer8 history_date;
  string other1;
  string other2;
  string other3;
  string other4;
 END;


join_lay := RECORD
	score_input_layout results;
	pii_layout pii;
END;

// basefilename := '~scoringqa::out::fcra::riskview_xml_santander_rva1304_1_v3_20140615';
// testfilename := '~scoringqa::out::fcra::riskview_xml_santander_rva1304_1_v3_20140616';  
basefilename := '~scoringqa::out::fcra::riskview_xml_santander_rva1304_2_v3_20140615';
testfilename := '~scoringqa::out::fcra::riskview_xml_santander_rva1304_2_v3_20140616';  

ds_baseline := dataset(basefilename, score_input_layout, csv(quote('"'), maxlength(32000), HEADING(1)));
ds_second := dataset(testfilename, score_input_layout, csv(quote('"'), maxlength(32000), HEADING(1)));

// pii_filename := '~Scoring_Project::in::RiskView_XML_Santander_1304_1_20140414';  
pii_filename := '~Scoring_Project::in::RiskView_XML_Santander_1304_2_20140414';  

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
	
// blank := DATASET(1, TRANSFORM(join_lay, SELF.results.acctno := '*', SELF := []));
      
base_append := JOIN(ds_baseline, ds_pii_file, LEFT.acctno = (STRING) RIGHT.accountnumber,
				TRANSFORM(join_lay, SELF.results := LEFT; SELF.pii := RIGHT));
				
second_append := PROJECT(ds_second, TRANSFORM(join_lay, SELF.results := LEFT; SELF.pii := []));
      					
j2 := JOIN(base_append, second_append, LEFT.results.acctno = RIGHT.results.acctno	AND
				(LEFT.results.rv_score_auto <> RIGHT.results.rv_score_auto AND LEFT.results.rv_score_auto < '300'), 
				// TRANSFORM(join_lay, SELF := LEFT));
				TRANSFORM(cmpr, SELF.res := LEFT + RIGHT));
				// TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));

j3 := JOIN(base_append, second_append, LEFT.results.acctno = RIGHT.results.acctno	AND
				(LEFT.results.rv_score_auto <> RIGHT.results.rv_score_auto AND RIGHT.results.rv_score_auto < '300'), 
				// TRANSFORM(join_lay, SELF := LEFT));
				TRANSFORM(cmpr, SELF.res := LEFT + RIGHT));
				// TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));
   						
// ashirey.Diff(ds_baseline, ds_second, ['acctno'], j1, 'RV4' );

OUTPUT(COUNT(base_append), NAMED('base_append_count'));
OUTPUT(CHOOSEN(base_append, eyeball), NAMED('base_append'));
OUTPUT(COUNT(second_append), NAMED('second_append_count'));
OUTPUT(CHOOSEN(second_append, eyeball), NAMED('second_append'));

// OUTPUT(COUNT(j1), NAMED('macro_differences_count'));
// OUTPUT(CHOOSEN(j1, eyeball), NAMED('macro_difference'));
OUTPUT(COUNT(j2), NAMED('resurected_differences_count'));
OUTPUT(CHOOSEN(j2, eyeball), NAMED('resurected_difference'));
OUTPUT(COUNT(j3), NAMED('newlydead_differences_count'));
OUTPUT(CHOOSEN(j3, eyeball), NAMED('newlydead_difference'));