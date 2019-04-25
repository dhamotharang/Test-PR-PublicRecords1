import zz_Koubsky.bus_shell_spr12_layout, Suspicious_Fraud_LN.Common;

inputFile := '~bpahl::tmp::business_shell_results_sprint12_w20141211-140022_pow.csv';

input_lay := RECORD
	zz_Koubsky.bus_shell_spr12_layout.layout;
	// Business_Risk_BIP.Layouts.OutputLayout;
	// STRING200 ErrorCode := '';
END;

ds_input_temp := DATASET(inputFile, input_lay, CSV(HEADING(1), QUOTE('"')));


search_bad(ds, prefix, att) := functionmacro
		
		dataset_lay := RECORD
			zz_Koubsky.bus_shell_spr12_layout.layout;
			DATASET({STRING2 Source}) sourcelist;
			DATASET({STRING2 Source}) Badsourcelist;
		END;

		ds_input := PROJECT(ds, TRANSFORM(dataset_lay,
				sourcelistSet := Suspicious_Fraud_LN.Common.fromDelimited(LEFT.#expand(prefix).#expand(att), ',');
				SELF.sourcelist := PROJECT(sourcelistSet, TRANSFORM({STRING2 Source}, SELF.Source := LEFT.fieldValues));
				SELF.Badsourcelist := PROJECT(sourcelistSet (fieldValues NOT IN zz_Koubsky.bus_shell_spr12_layout.sources), TRANSFORM({STRING2 Source}, SELF.Source := LEFT.fieldValues));
				
				SELF := LEFT; 
				SELF := []));

		ds_BadSourcesList := ds_input(COUNT(Badsourcelist) > 0);
		OUTPUT(Count(ds_BadSourcesList), NAMED('Count_Bad_' + att));
		OUTPUT(CHOOSEN(ds_BadSourcesList, 25), NAMED('Ex_Bad_' + att));

		ds_badsourcelist := ds_input.Badsourcelist;
		dup_badsourcelist := dedup(sort(ds_badsourcelist, source));
		output(dup_badsourcelist, named('bad_sources_for_' + att));
		return '';
endmacro;

search_bad(ds_input_temp, 'Verification', 'sourcelist');
search_bad(ds_input_temp, 'Verification', 'namematchsourcelist');
search_bad(ds_input_temp, 'Verification', 'addrverificationsourcelist');
search_bad(ds_input_temp, 'Verification', 'phonematchsourcelist');
search_bad(ds_input_temp, 'Verification', 'feinmatchsourcelist');

search_bad(ds_input_temp, 'firmographic', 'industrysourcenaicbestlist');
search_bad(ds_input_temp, 'firmographic', 'industrysourcenaiccompletelist');
search_bad(ds_input_temp, 'firmographic', 'industrysicsourcebestlist');
search_bad(ds_input_temp, 'firmographic', 'industrysourcesiccompletelist');
search_bad(ds_input_temp, 'firmographic', 'employeecountsourcelist');