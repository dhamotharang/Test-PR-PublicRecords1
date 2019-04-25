#workunit('name','PII Layout Comparison');

import ashirey, scoring_project_Macros;

eyeball := 30;

prii_layout := RECORD
  Scoring_Project_Macros.Regression.global_layout;
	Scoring_Project_Macros.Regression.pii_layout;
	Scoring_Project_Macros.Regression.runtime_layout;
 END;

pii_Old_Sample := '~scoring_project::in::riskview_xml_generic_version3_20140805';      //Old Sample
pii_New_Sample := '~scoring_project::in::riskview_xml_generic_version3_20141205';      //New Sample


ds_piiOldSample := dataset(pii_Old_Sample, prii_layout, thor);
ds_piiNewSample := dataset(pii_New_Sample, prii_layout, thor);

OUTPUT(COUNT(ds_piiOldSample), NAMED('Old_Sample_count'));
OUTPUT(COUNT(ds_piiNewSample), NAMED('New_Sample_count'));

cmpr := record, maxlength(50000)
	DATASET(prii_layout) res;
end;

ashirey.Diff(ds_piiOldSample, ds_piiNewSample, ['accountnumber'], differences, 'RV3' );

Output(differences, Named('Differences'));


 // j1 := join(ds_pii1, ds_pii2, left.accountnumber = right.accountnumber
					// AND LEFT.streetaddress = RIGHT.streetaddress,
				  // TRANSFORM(cmpr, SELF.res := LEFT + RIGHT));
				  // TRANSFORM(cmpr, SELF.res := LEFT ));

// OUTPUT(count(j1), NAMED('Diff_StreetAddress_Count'));
// OUTPUT(CHOOSEN(j1, 25), named('Diff_StreetAddress'));

scoring_project_pip.COMPARE_DSETS_MACRO(ds_piiOldSample, ds_piiNewSample, ['accountnumber'], 1 );
// scoring_project_pip.CROSSTAB_MACRO(ds_piiOldSample, ds_piiNewSample, ['accountnumber'], 'rv_score_prescreen');