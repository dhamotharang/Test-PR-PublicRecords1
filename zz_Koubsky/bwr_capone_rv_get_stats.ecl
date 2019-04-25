// EXPORT bwr_capone_rv_get_stats := 'todo';

// EXPORT CapOne_ITA_statistics_macro := 'todo';

#workunit('name', 'ITA 3.0 attr freq distributions');
IMPORT riskview, riskprocessing, Scoring_Project_Macros;

// ******* Input report info here ********
// infile_name := '~scoringqa::out::fcra::riskview_batch_capitalone_attributes_v2_20150522_1';
infile_name := '~scoringqa::out::fcra::riskview_batch_capitalone_attributes_v2_20150527_1';
// filetag := 'RV2_cert_pre_Neustar_0522';
filetag := 'RV2_cert_post_Neustar_0527';

eyeball := 25000;
// ***************************************

rv2_layout := RECORD
	Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_BATCH_Capitalone_Attributes_V2_Global_Layout;			 
END;

rv3_layout := RECORD
	Scoring_Project_Macros.Global_Output_Layouts.RiskViewAttributes_v3;			 
END;

ds_temp := CHOOSEN(dataset(infile_name, rv2_layout, THOR), eyeball);
// ds_temp := CHOOSEN(dataset(infile_name, rv3_layout, THOR), eyeball);
ds_rv := ds_temp;

output(CHOOSEN(ds_temp, 10), named('input_sample'));

rv_stats := Scoring_Project_DailyTracking.Customized_Macro(ds_rv);


thorfile_name := '~nkoubsky::out::' + filetag + '_' + thorlib.wuid() + '.csv';
desprayfile_name := '/data/koubna01/' + filetag + '_' + thorlib.wuid()  + '.csv';
desprayfile_location := '10.140.128.250';

act1 := OUTPUT(rv_stats,, thorfile_name, csv(heading(single), quote('"')) );
act2 := FileServices.DeSpray( thorfile_name, desprayfile_location, desprayfile_name,,,,TRUE);
SEQUENTIAL(act1, act2);
