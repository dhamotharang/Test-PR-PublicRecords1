#workunit('name','Instant ID Generic');

import risk_indicators, ut, ashirey, scoring_project_Macros, scoring_project_pip, scoring_qa, RiskProcessing;

eyeball := 30;

input_layout := scoring_project_Macros.Global_Output_Layouts.NONFCRA_InstantId_Global_Layout;

	
import models, riskwise, iesp;


 
  // dataset('~scoringqa::out::nonfcra::instantid_xml_generic_20160603_1', lay, thor);


prii_layout := RECORD
  Scoring_Project_Macros.Regression.global_layout;
	Scoring_Project_Macros.Regression.pii_layout;
	Scoring_Project_Macros.Regression.runtime_layout;
 END;


basefilename := '~scoringqa::out::nonfcra::instantid_batch_generic_20180220_1';        //XML or Batch
testfilename := '~scoringqa::out::nonfcra::instantid_batch_generic_20180221_1';        
pii_name := scoring_project_pip.Input_Sample_Names.IID_Scores_V0_XML_Generic_infile;             //XML or Batch

ds_baseline := dataset(basefilename,input_layout, thor); 
ds_new := dataset(testfilename,input_layout, thor); 
ds_pii := dataset(pii_name, prii_layout, thor);

	clean_ds_baseline := ds_baseline(errorcode='');
	clean_ds_new := ds_new(errorcode='');
	
	output(count(ds_baseline(errorcode <> '')),named('base_errors'));
	output(count(ds_new(errorcode <> '')),named('prop_errors'));
//**** Join PII to results **************

join_lay := RECORD
	input_layout results;
	prii_layout pii;
END;


ds_join_baseline := JOIN( clean_ds_baseline, ds_pii, (integer)LEFT.acctno = RIGHT.accountnumber, TRANSFORM(join_lay, SELF.results := LEFT; SELF.pii := RIGHT));
ds_join_second := JOIN( clean_ds_new, ds_pii, (integer)LEFT.acctno = RIGHT.accountnumber, TRANSFORM(join_lay, SELF.results := LEFT; SELF.pii := []));

OUTPUT(choosen(ds_join_baseline, 25), named('baseline'));
OUTPUT(choosen(ds_join_second, 25), named('second'));


RiskView3Table := table(clean_ds_baseline,
	{
		nap_summary,
		Total := count(group)
	},
	nap_summary
);
output(RiskView3Table, named('nap_summary_base'));

RiskView3Table2 := table(clean_ds_new,
	{
		nap_summary,
		Total := count(group)
	},
	nap_summary
);
output(RiskView3Table2, named('nap_summary_second'));

RiskView3Table3 := table(clean_ds_baseline,
	{
		CVI,
		Total := count(group)
	},
	CVI
);
output(RiskView3Table3, named('CVI_base'));

RiskView3Table4 := table(clean_ds_new,
	{
		CVI,
		Total := count(group)
	},
	CVI
);
output(RiskView3Table4, named('CVI_second'));
/*
//*********table across fields*************
r1 := record
 ds_join_baseline.results.nap_summary;
 count_ := count(group);
end;

r2 := record
 ds_join_second.results.nap_summary;
 count_ := count(group);
end;

ta1 := table(ds_join_baseline,r1,results.nap_summary,few);
output(sort(ta1,nap_summary),all, named('baseline_summary'));
ta2 := table(ds_join_second,r2,results.nap_summary,few);
output(sort(ta2,nap_summary),all, named('second_summary'));
*/


cmpr := record, maxlength(50000)
	DATASET(join_lay) res;
end;

blank := DATASET(1, TRANSFORM(join_lay, SELF.results.acctno := '-', SELF := []));

// ashirey.Diff(ds_baseline, ds_new, ['accountnumber'], j1, 'LIA4' );

 j1 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					AND (INTEGER)LEFT.results.nap_summary <> (INTEGER)RIGHT.results.nap_summary,
				  TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));
				  // TRANSFORM(cmpr, SELF.res := LEFT + RIGHT));

 j2 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					AND (INTEGER)LEFT.results.nas_summary <> (INTEGER)RIGHT.results.nas_summary,
				  TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));
				  // TRANSFORM(cmpr, SELF.res := LEFT + RIGHT));
	
	j3 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					AND (INTEGER)LEFT.results.CVI <> (INTEGER)RIGHT.results.CVI,
					// TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));
					TRANSFORM(cmpr, SELF.res := LEFT + RIGHT));

	j4 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					AND LEFT.results.verhphone <> RIGHT.results.verhphone,
					// and left.results.verhphone <> ''
					// and right.results.verhphone = '',
					// AND LEFT.results.verhphone = ''
					// AND RIGHT.results.verhphone <> ''
					// AND Right.results.phone10 <> right.results.verhphone,
					// TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));
					TRANSFORM(cmpr, SELF.res := LEFT + RIGHT));

OUTPUT(count(j1), NAMED('Change_in_Nap_Count'));
OUTPUT(count(j2), NAMED('Change_in_Nas_count'));
OUTPUT(count(j3), NAMED('Change_in_cvi_count'));
OUTPUT(count(j4), NAMED('verhphone_count'));

OUTPUT(CHOOSEN(j1, 25), named('Change_in_Nap'));
OUTPUT(CHOOSEN(j2, 25), named('Change_in_Nas'));
OUTPUT(CHOOSEN(j3, 25), named('Change_in_CVI'));
OUTPUT(CHOOSEN(j4, 25), named('verhphone'));
// OUTPUT(CHOOSEN(j4, 25), named('NAP_increase_AND_new_VerHPhone'));


// ashirey.flatten(ds_baseline, flatten_baseline);
// ashirey.flatten(ds_new, flatten_second);

	 // scoring_project_pip.COMPARE_DSETS_MACRO(flatten_baseline, flatten_second, ['acctno'], 1);
// scoring_project_pip.CROSSTAB_MACRO(flatten_baseline, flatten_second, ['acctno'], 'nap_summary');
