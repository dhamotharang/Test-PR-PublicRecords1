// #workunit('name', 'FRCA bocashell 4.1');
#workunit('name', 'nonFRCA bocashell 4.1');
// #workunit('name', 'FRCA bocashell 5.0');
// #workunit('name', 'nonFRCA bocashell 5.0');

// ****** FILE NAMES ****************************************************************************
// basefilename := '~scoringqa::out::fcra::bocashell_41_historydate_999999_prod_20141104_1'; 
// basefilename := '~scoringqa::out::fcra::bocashell_41_historydate_999999_cert_20141106_1'; 
// testfilename := '~scoringqa::out::fcra::bocashell_41_historydate_999999_cert_20141106_nonderog'; 

basefilename := '~scoringqa::out::nonfcra::bocashell_41_historydate_999999_cert_20141109_1'; 
testfilename := '~scoringqa::out::nonfcra::bocashell_41_historydate_999999_prod_20141109_1'; 
// basefilename := '~scoringqa::out::fcra::bocashell_41_historydate_999999_cert_20141109_1'; 
// testfilename := '~scoringqa::out::fcra::bocashell_41_historydate_999999_prod_20141109_1'; 

// basefilename := '~scoringqa::out::fcra::bocashell_50_historydate_999999_cert_20141106_1'; 
// testfilename := '~scoringqa::out::fcra::bocashell_50_historydate_999999_cert_20141106_nonderog'; 

// basefilename := '~scoringqa::out::nonfcra::bocashell_50_historydate_999999_cert_20141106_1'; 
// testfilename := '~scoringqa::out::nonfcra::bocashell_50_historydate_999999_cert_20141106_nonderog'; 
// **********************************************************************************************

import risk_indicators, ut, riskprocessing;

ox := RECORD
	unsigned8 time_ms := 0;
	STRING30 AccountNumber;
	risk_indicators.Layout_Boca_Shell;
	STRING200 errorcode;
END;

ox_slim := record
STRING Environment;
STRING30 AccountNumber;
risk_indicators.Layout_Boca_Shell.shell_input shell_input;
// risk_indicators.Layout_Boca_Shell.address_verification address_verification;
risk_indicators.Layout_Boca_Shell.address_verification address_verification;
end;

cmpr := record
	dataset (ox_slim) res;
end;

ds_baseline := project(dataset(basefilename,riskprocessing.layouts.layout_internal_shell, thor), transform(ox_slim, self.environment := 'cert'; self := left));
ds_new := project(dataset(testfilename,riskprocessing.layouts.layout_internal_shell, thor), transform(ox_slim, self.environment := 'prod'; self := left));
// ds_baseline := project(dataset(basefilename,riskprocessing.layouts.layout_internal_shell, thor), transform(ox, self.time_ms := 0; self := left));
// ds_new := project(dataset(testfilename,riskprocessing.layouts.layout_internal_shell, thor), transform(ox, self.time_ms := 0; self := left));

j_outlier := join(ds_baseline, ds_new, left.AccountNumber=right.AccountNumber 
					and abs(left.address_verification.owned.property_total - right.address_verification.owned.property_total) > 2,
					transform(cmpr, self.res := left + right));

output(j_outlier, named('large_differences'));

/*					
j := join(ds_baseline, ds_new, left.AccountNumber=right.AccountNumber,
					transform( {string AccountNumber}, self.AccountNumber := left.AccountNumber));

j_outlier := join(ds_baseline, ds_new, left.AccountNumber=right.AccountNumber 
					and abs(left.address_verification.owned.property_total - right.address_verification.owned.property_total) > 2,
					transform(cmpr, self.res := left + right));

j_left := join(ds_baseline, ds_new, left.AccountNumber=right.AccountNumber 
					and left.address_verification.owned.property_total <> right.address_verification.owned.property_total,
					transform(ox_slim, self := left));

j_right := join(ds_baseline, ds_new, left.AccountNumber=right.AccountNumber 
					and left.address_verification.owned.property_total <> right.address_verification.owned.property_total,
					transform(ox_slim, self := right));
					
j_1 := sort(j_left + j_right, (integer) AccountNumber);
					
j_30 := join(j_left, j_right, left.AccountNumber=right.AccountNumber,
					transform( {integer owned_total}, self.owned_total := right.address_verification.owned.property_total - left.address_verification.owned.property_total));
					
// j_90 := join(ds_baseline, ds_new, left.AccountNumber=right.AccountNumber 
					// and left.source_verification.num_nonderogs90 <> right.source_verification.num_nonderogs90,
					// transform( {integer nonderogdiff}, self.nonderogdiff := right.source_verification.num_nonderogs90 - left.source_verification.num_nonderogs90));

t_30 := table(j_30, 
{
			// total := count(group);
			owned_total;
			// non_derog_change := count(group, nonderogdiff),
			owned_total_change := count(group)
}, 
			owned_total);

output(count(j), named('joined_count'));
output(t_30, named('stats_propertytotal'));
output(choosen(j_1, 50), named('prop_diff_detail'));
// output(t_90, named('stats_nonderog90'));

                                    
ashirey.flatten(ds_baseline, flat_baseline);
ashirey.flatten(ds_new, flat_new);
ashirey.diff( flat_baseline, flat_new, ['AccountNumber'], j1, 'BocaShell');

// output(choosen(j1, 40), named('nonderog_diff'));
*/
