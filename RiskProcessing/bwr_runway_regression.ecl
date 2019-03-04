import data_services, risk_indicators, models, riskwise, riskprocessing;
#workunit('name', 'runway regression');

eyeball := 10;
parallel_count := 2;  // when running using 50 way, set this to 2.  when running on pound_option_thor (3way), use up to 33 threads

ox := RECORD
	riskprocessing.layouts.layout_internal_shell_noDatasets;
END;

// prod tracking shells
// basefilename := data_services.foreign_prod + 'nmontpetit::out::bs_41_cert_tracking_full_fcra_150804_999999'; 
// testfilename := data_services.foreign_prod + 'nmontpetit::out::bs_41_cert_tracking_full_fcra_150803_999999';  

// cert tracking shells
// basefilename := data_services.foreign_prod + 'nmontpetit::out::bs_41_cert_tracking_full_fcra_150804_999999'; 
// testfilename := data_services.foreign_prod + 'nmontpetit::out::bs_41_cert_tracking_full_fcra_150803_999999';
  
// basefilename := '~dvstemp::out::audit::nonfcrashell_test_w20170309-140509'; 
// testfilename := '~dvstemp::out::audit::nonfcrashell_test_w20170309-140509';  

basefilename := '~khuls::out::nonfcrashell_addr_occupancy_base_51_current_w20181228-114552';
testfilename := '~khuls::out::nonfcrashell_addr_occupancy_test_51_current_w20181228-122249';

output_logical_files := false;  // if you're just testing an eyeball sample, don't need to output the logical files
runwaybaseline := '~dvstemp::out::baseline_runway_' + thorlib.wuid();
runwaytestfile := '~dvstemp::out::testfile_runway_' + thorlib.wuid();

// roxieIP := riskwise.shortcuts.p3;
// roxieIP := riskwise.shortcuts.dev192;
// roxieIP := riskwise.shortcuts.dev194;
// roxieIP := 'http://roxiecertossvip.sc.seisint.com:9876';//cert
roxieIP := riskwise.shortcuts.staging_neutral_roxieIP;
// roxieIP := riskwise.shortcuts.prod_batch_analytics_roxie;

baseline := distribute(dataset(basefilename, ox, csv(quote('"'), maxlength(20000)))(errorcode=''), random());
testfile := distribute(dataset(testfilename, ox, csv(quote('"'), maxlength(20000)))(errorcode=''), random());
// baseline := choosen(dataset(basefilename, ox, csv(quote('"'), maxlength(20000)))(errorcode=''), eyeball);
// testfile := choosen(dataset(testfilename, ox, csv(quote('"'), maxlength(20000)))(errorcode=''), eyeball);

layout_soap_in := record
	dataset(risk_indicators.Layout_Boca_Shell) shell;
	integer model_environment;
	boolean excludeReasons;
end;

layout_soap_in create_soap_in(ox le) := transform
	self.shell := project(le, transform(risk_indicators.Layout_Boca_Shell, self := left, self := []));
	//self.model_environment := 3;  // nonfcra only
	// self.model_environment := 2;  // fcra only
	self.model_environment := 1;  // run all models
	self.excludeReasons := false;
end;

soap_in_baseline := project(baseline, create_soap_in(left));
 output(choosen(soap_in_baseline, eyeball), named('soap_in_baseline'));
soap_in_testfile := project(testfile, create_soap_in(left));
 output(choosen(soap_in_testfile, eyeball), named('soap_in_testfile'));

xlayout := RECORD
  models.Layout_Runway;
	STRING errorcode;
END;

xlayout myFail(layout_soap_in le) := TRANSFORM
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	SELF := le;
	SELF := [];
END;

runway_results_baseline := SOAPCALL(soap_in_baseline, 
				roxieIP,
				'Models.Runway_Service', 
				{soap_in_baseline}, 
				DATASET(xlayout),
				PARALLEL(parallel_count),  
				onFail(myFail(LEFT)));

 output(CHOOSEN(runway_results_baseline, eyeball), named('runway_results_baseline'));

// only output the result to logical file if specifically requested
if(output_logical_files, 
	output(runway_results_baseline,, runwaybaseline + '_' + thorlib.wuid(), CSV(heading(single), QUOTE('"'))) );

runway_results_testfile := SOAPCALL(soap_in_testfile, 
				roxieIP,
				'Models.Runway_Service',
				{soap_in_testfile}, 
				DATASET(xlayout), 
				PARALLEL(parallel_count),
				onFail(myFail(LEFT)));

 output(CHOOSEN(runway_results_testfile, eyeball), named('runway_results_testfile'));

// only output the result to logical file if specifically requested
if(output_logical_files, 
	output(runway_results_testfile,, runwaytestfile + '_' + thorlib.wuid(), CSV(heading(single), QUOTE('"'))) );

// =========================================================
// to get a count of which models had the most differences
// =========================================================
Models.diff_macro(runway_results_baseline,runway_results_testfile, ['seq'], Differences, 'runway' );
output(differences, named ('differences'));


/*

// or to do more analysis on the runway results
xlayout := RECORD
  models.Layout_Runway;
	STRING errorcode;
END;

// runway_results_baseline := dataset('~dvstemp::out::bs41targus_utilraw_old_runway_w20130305-114953-2', xlayout, csv(quote('"'), heading(single)) )
// runway_results_testfile := dataset('~dvstemp::out::bs41targus_utilraw_new_runway_w20130305-114953-2', xlayout, csv(quote('"'), heading(single)) )
*/


// pick a score to isolate and analyze
cmpr := record
	unsigned seq;
	boolean any_difference;
real	NAP_baseline;	real	NAP_new;	real	NAP_diff;
real	NAS_baseline;	real	NAS_new;	real	NAS_diff;
real	CVI_score_baseline;	real	CVI_score_new;	real	CVI_score_diff;
// real	AID605_1_0_score_baseline;	real	AID605_1_0_score_new;	real	AID605_1_0_score_diff;
// real	AID606_0_0_score_baseline;	real	AID606_0_0_score_new;	real	AID606_0_0_score_diff;
// real	AID606_1_0_score_baseline;	real	AID606_1_0_score_new;	real	AID606_1_0_score_diff;
// real	AID607_0_0_score_baseline;	real	AID607_0_0_score_new;	real	AID607_0_0_score_diff;
// real	AID607_1_0_score_baseline;	real	AID607_1_0_score_new;	real	AID607_1_0_score_diff;
// real	AID607_2_0_score_baseline;	real	AID607_2_0_score_new;	real	AID607_2_0_score_diff;
real	AIN509_0_0_score_baseline;	real	AIN509_0_0_score_new;	real	AIN509_0_0_score_diff;
real	AIN602_1_0_score_baseline;	real	AIN602_1_0_score_new;	real	AIN602_1_0_score_diff;
real	AIN605_1_0_score_baseline;	real	AIN605_1_0_score_new;	real	AIN605_1_0_score_diff;
real	AIN605_2_0_score_baseline;	real	AIN605_2_0_score_new;	real	AIN605_2_0_score_diff;
real	AIN605_3_0_score_baseline;	real	AIN605_3_0_score_new;	real	AIN605_3_0_score_diff;
real	AIN801_1_0_score_baseline;	real	AIN801_1_0_score_new;	real	AIN801_1_0_score_diff;
real	ANMK909_0_1_score_baseline;	real	ANMK909_0_1_score_new;	real	ANMK909_0_1_score_diff;
// real	AWD605_0_0_score_baseline;	real	AWD605_0_0_score_new;	real	AWD605_0_0_score_diff;
// real	AWD605_2_0_score_baseline;	real	AWD605_2_0_score_new;	real	AWD605_2_0_score_diff;
// real	AWD606_10_0_score_baseline;	real	AWD606_10_0_score_new;	real	AWD606_10_0_score_diff;
// real	AWD606_11_0_score_baseline;	real	AWD606_11_0_score_new;	real	AWD606_11_0_score_diff;
// real	AWD606_1_0_score_baseline;	real	AWD606_1_0_score_new;	real	AWD606_1_0_score_diff;
// real	AWD606_2_0_score_baseline;	real	AWD606_2_0_score_new;	real	AWD606_2_0_score_diff;
// real	AWD606_3_0_score_baseline;	real	AWD606_3_0_score_new;	real	AWD606_3_0_score_diff;
// real	AWD606_4_0_score_baseline;	real	AWD606_4_0_score_new;	real	AWD606_4_0_score_diff;
// real	AWD606_6_0_score_baseline;	real	AWD606_6_0_score_new;	real	AWD606_6_0_score_diff;
// real	AWD606_7_0_score_baseline;	real	AWD606_7_0_score_new;	real	AWD606_7_0_score_diff;
// real	AWD606_8_0_score_baseline;	real	AWD606_8_0_score_new;	real	AWD606_8_0_score_diff;
// real	AWD606_9_0_score_baseline;	real	AWD606_9_0_score_new;	real	AWD606_9_0_score_diff;
// real	AWD710_1_0_score_baseline;	real	AWD710_1_0_score_new;	real	AWD710_1_0_score_diff;
real	AWN510_0_0_score_baseline;	real	AWN510_0_0_score_new;	real	AWN510_0_0_score_diff;
real	AWN603_1_0_score_baseline;	real	AWN603_1_0_score_new;	real	AWN603_1_0_score_diff;
real	BD3605_0_0_score_baseline;	real	BD3605_0_0_score_new;	real	BD3605_0_0_score_diff;
real	BD5605_0_0_score_baseline;	real	BD5605_0_0_score_new;	real	BD5605_0_0_score_diff;
real	BD5605_1_0_score_baseline;	real	BD5605_1_0_score_new;	real	BD5605_1_0_score_diff;
real	BD5605_2_0_score_baseline;	real	BD5605_2_0_score_new;	real	BD5605_2_0_score_diff;
real	BD5605_3_0_score_baseline;	real	BD5605_3_0_score_new;	real	BD5605_3_0_score_diff;
real	BD9605_0_0_score_baseline;	real	BD9605_0_0_score_new;	real	BD9605_0_0_score_diff;
real	BD9605_1_0_score_baseline;	real	BD9605_1_0_score_new;	real	BD9605_1_0_score_diff;
real	CDN1109_1_0_score_baseline;	real	CDN1109_1_0_score_new;	real	CDN1109_1_0_score_diff;
real	CDN1205_1_0_score_baseline;	real	CDN1205_1_0_score_new;	real	CDN1205_1_0_score_diff;
real	CDN1305_1_0_score_baseline;	real	CDN1305_1_0_score_new;	real	CDN1305_1_0_score_diff;
real	CDN1404_1_0_score_baseline;	real	CDN1404_1_0_score_new;	real	CDN1404_1_0_score_diff;
real	CDN1410_1_0_score_baseline;	real	CDN1410_1_0_score_new;	real	CDN1410_1_0_score_diff;
real	CDN1506_1_0_score_baseline;	real	CDN1506_1_0_score_new;	real	CDN1506_1_0_score_diff;
real	CDN1508_1_0_score_baseline;	real	CDN1508_1_0_score_new;	real	CDN1508_1_0_score_diff;
real	CDN604_0_0_score_baseline;	real	CDN604_0_0_score_new;	real	CDN604_0_0_score_diff;
real	CDN604_1_0_score_baseline;	real	CDN604_1_0_score_new;	real	CDN604_1_0_score_diff;
real	CDN604_2_0_score_baseline;	real	CDN604_2_0_score_new;	real	CDN604_2_0_score_diff;
real	CDN604_3_0_score_baseline;	real	CDN604_3_0_score_new;	real	CDN604_3_0_score_diff;
real	CDN604_4_0_score_baseline;	real	CDN604_4_0_score_new;	real	CDN604_4_0_score_diff;
real	CDN605_1_0_score_baseline;	real	CDN605_1_0_score_new;	real	CDN605_1_0_score_diff;
real	CDN606_2_0_score_baseline;	real	CDN606_2_0_score_new;	real	CDN606_2_0_score_diff;
real	CDN706_1_0_score_baseline;	real	CDN706_1_0_score_new;	real	CDN706_1_0_score_diff;
real	CDN707_1_0_score_baseline;	real	CDN707_1_0_score_new;	real	CDN707_1_0_score_diff;
real	CDN712_0_0_score_baseline;	real	CDN712_0_0_score_new;	real	CDN712_0_0_score_diff;
real	CDN806_1_0_score_baseline;	real	CDN806_1_0_score_new;	real	CDN806_1_0_score_diff;
//real	CDN810_1_0_score_baseline;	real	CDN810_1_0_score_new;	real	CDN810_1_0_score_diff;
real	CDN908_1_0_score_baseline;	real	CDN908_1_0_score_new;	real	CDN908_1_0_score_diff;
real	CEN509_0_0_score_baseline;	real	CEN509_0_0_score_new;	real	CEN509_0_0_score_diff;
real	CSN1007_0_0_score_baseline;	real	CSN1007_0_0_score_new;	real	CSN1007_0_0_score_diff;
real	FD3510_0_0_score_baseline;	real	FD3510_0_0_score_new;	real	FD3510_0_0_score_diff;
real	FD3606_0_0_score_baseline;	real	FD3606_0_0_score_new;	real	FD3606_0_0_score_diff;
real	FD5510_0_0_score_baseline;	real	FD5510_0_0_score_new;	real	FD5510_0_0_score_diff;
real	FD5603_1_0_score_baseline;	real	FD5603_1_0_score_new;	real	FD5603_1_0_score_diff;
real	FD5603_2_0_score_baseline;	real	FD5603_2_0_score_new;	real	FD5603_2_0_score_diff;
real	FD5603_3_0_score_baseline;	real	FD5603_3_0_score_new;	real	FD5603_3_0_score_diff;
real	FD5607_1_0_score_baseline;	real	FD5607_1_0_score_new;	real	FD5607_1_0_score_diff;
real	FD5609_1_0_score_baseline;	real	FD5609_1_0_score_new;	real	FD5609_1_0_score_diff;
real	FD5609_2_0_score_baseline;	real	FD5609_2_0_score_new;	real	FD5609_2_0_score_diff;
real	FD5709_1_0_score_baseline;	real	FD5709_1_0_score_new;	real	FD5709_1_0_score_diff;
real	FD9510_0_0_score_baseline;	real	FD9510_0_0_score_new;	real	FD9510_0_0_score_diff;
real	FD9603_1_0_score_baseline;	real	FD9603_1_0_score_new;	real	FD9603_1_0_score_diff;
real	FD9603_2_0_score_baseline;	real	FD9603_2_0_score_new;	real	FD9603_2_0_score_diff;
real	FD9603_3_0_score_baseline;	real	FD9603_3_0_score_new;	real	FD9603_3_0_score_diff;
real	FD9603_4_0_score_baseline;	real	FD9603_4_0_score_new;	real	FD9603_4_0_score_diff;
real	FD9604_1_0_score_baseline;	real	FD9604_1_0_score_new;	real	FD9604_1_0_score_diff;
real	FD9606_0_0_score_baseline;	real	FD9606_0_0_score_new;	real	FD9606_0_0_score_diff;
real	FD9607_1_0_score_baseline;	real	FD9607_1_0_score_new;	real	FD9607_1_0_score_diff;
real	FP1109_0_0_score_baseline;	real	FP1109_0_0_score_new;	real	FP1109_0_0_score_diff;
real	FP1210_1_0_score_baseline;	real	FP1210_1_0_score_new;	real	FP1210_1_0_score_diff;
real	FP1303_1_0_score_baseline;	real	FP1303_1_0_score_new;	real	FP1303_1_0_score_diff;
real	FP31105_1_0_score_baseline;	real	FP31105_1_0_score_new;	real	FP31105_1_0_score_diff;
real	FP31203_1_0_score_baseline;	real	FP31203_1_0_score_new;	real	FP31203_1_0_score_diff;
real	FP31604_0_0_score_baseline;	real	FP31604_0_0_score_new;	real	FP31604_0_0_score_diff;
real	FP3710_0_0_score_baseline;	real	FP3710_0_0_score_new;	real	FP3710_0_0_score_diff;
real	FP3904_1_0_score_baseline;	real	FP3904_1_0_score_new;	real	FP3904_1_0_score_diff;
real	FP3905_1_0_score_baseline;	real	FP3905_1_0_score_new;	real	FP3905_1_0_score_diff;
real	FP5812_1_0_score_baseline;	real	FP5812_1_0_score_new;	real	FP5812_1_0_score_diff;
real	FP1611_1_0_score_baseline;	real	FP1611_1_0_score_new;	real	FP1611_1_0_score_diff;
real	FP1610_1_0_score_baseline;	real	FP1610_1_0_score_new;	real	FP1610_1_0_score_diff;
real	FP1802_1_0_score_baseline;	real	FP1802_1_0_score_new;	real	FP1802_1_0_score_diff;
real	FP1610_2_0_score_baseline;	real	FP1610_2_0_score_new;	real	FP1610_2_0_score_diff;
real	FP1609_1_0_score_baseline;	real	FP1609_1_0_score_new;	real	FP1609_1_0_score_diff;
real	FP1508_1_0_score_baseline;	real	FP1508_1_0_score_new;	real	FP1508_1_0_score_diff;
real	FP1702_2_0_score_baseline;	real	FP1702_2_0_score_new;	real	FP1702_2_0_score_diff;
real	FP1702_1_0_score_baseline;	real	FP1702_1_0_score_new;	real	FP1702_1_0_score_diff;
real	FP1706_1_0_score_baseline;	real	FP1706_1_0_score_new;	real	FP1706_1_0_score_diff;
real	FP1705_1_0_score_baseline;	real	FP1705_1_0_score_new;	real	FP1705_1_0_score_diff;
real	FP1710_1_0_score_baseline;	real	FP1710_1_0_score_new;	real	FP1710_1_0_score_diff;
real	FP1806_1_0_score_baseline;	real	FP1806_1_0_score_new;	real	FP1806_1_0_score_diff;
real	FP1803_1_0_score_baseline;	real	FP1803_1_0_score_new;	real	FP1803_1_0_score_diff;
real	FP1609_2_0_score_baseline;	real	FP1609_2_0_score_new;	real	FP1609_2_0_score_diff;
real	FP1606_1_0_score_baseline;	real	FP1606_1_0_score_new;	real	FP1606_1_0_score_diff;
real	HCP1206_0_0_score_baseline;	real	HCP1206_0_0_score_new;	real	HCP1206_0_0_score_diff;
real	IDN605_1_0_score_baseline;	real	IDN605_1_0_score_new;	real	IDN605_1_0_score_diff;
// real	IE912_0_0_score_baseline;	real	IE912_0_0_score_new;	real	IE912_0_0_score_diff;
// real	IE912_1_0_score_baseline;	real	IE912_1_0_score_new;	real	IE912_1_0_score_diff;
real	IED1106_1_0_score_baseline;	real	IED1106_1_0_score_new;	real	IED1106_1_0_score_diff;
real	IEN1006_0_1_score_baseline;	real	IEN1006_0_1_score_new;	real	IEN1006_0_1_score_diff;
real	MNC21106_0_0_score_baseline;	real	MNC21106_0_0_score_new;	real	MNC21106_0_0_score_diff;
real	MPX1211_0_0_score_baseline;	real	MPX1211_0_0_score_new;	real	MPX1211_0_0_score_diff;
real	MSD1010_0_0_score_baseline;	real	MSD1010_0_0_score_new;	real	MSD1010_0_0_score_diff;
real	MSN1106_0_0_score_baseline;	real	MSN1106_0_0_score_new;	real	MSN1106_0_0_score_diff;
real	MSN605_1_0_score_baseline;	real	MSN605_1_0_score_new;	real	MSN605_1_0_score_diff;
real	MSN610_0_0_score_baseline;	real	MSN610_0_0_score_new;	real	MSN610_0_0_score_diff;
real	MSN1803_1_0_score_baseline;	real	MSN1803_1_0_score_new;	real	MSN1803_1_0_score_diff;
real	MV361006_0_0_score_baseline;	real	MV361006_0_0_score_new;	real	MV361006_0_0_score_diff;
real	MV361006_1_0_score_baseline;	real	MV361006_1_0_score_new;	real	MV361006_1_0_score_diff;
real	MX361006_0_0_score_baseline;	real	MX361006_0_0_score_new;	real	MX361006_0_0_score_diff;
real	MX361006_1_0_score_baseline;	real	MX361006_1_0_score_new;	real	MX361006_1_0_score_diff;
real	RSB801_1_0_score_baseline;	real	RSB801_1_0_score_new;	real	RSB801_1_0_score_diff;
real	RSN1001_1_0_score_baseline;	real	RSN1001_1_0_score_new;	real	RSN1001_1_0_score_diff;
real	RSN1009_1_0_score_baseline;	real	RSN1009_1_0_score_new;	real	RSN1009_1_0_score_diff;
real	RSN1010_1_0_score_baseline;	real	RSN1010_1_0_score_new;	real	RSN1010_1_0_score_diff;
real	RSN1103_1_0_score_baseline;	real	RSN1103_1_0_score_new;	real	RSN1103_1_0_score_diff;
real	RSN1105_1_0_score_baseline;	real	RSN1105_1_0_score_new;	real	RSN1105_1_0_score_diff;
real	RSN1105_2_0_score_baseline;	real	RSN1105_2_0_score_new;	real	RSN1105_2_0_score_diff;
real	RSN1105_3_0_score_baseline;	real	RSN1105_3_0_score_new;	real	RSN1105_3_0_score_diff;
real	RSN1108_1_0_score_baseline;	real	RSN1108_1_0_score_new;	real	RSN1108_1_0_score_diff;
real	RSN1108_2_0_score_baseline;	real	RSN1108_2_0_score_new;	real	RSN1108_2_0_score_diff;
real	RSN1108_3_0_score_baseline;	real	RSN1108_3_0_score_new;	real	RSN1108_3_0_score_diff;
real	RSN508_1_0_score_baseline;	real	RSN508_1_0_score_new;	real	RSN508_1_0_score_diff;
real	RSN509_1_0_score_baseline;	real	RSN509_1_0_score_new;	real	RSN509_1_0_score_diff;
real	RSN509_2_0_score_baseline;	real	RSN509_2_0_score_new;	real	RSN509_2_0_score_diff;
real	RSN604_2_0_score_baseline;	real	RSN604_2_0_score_new;	real	RSN604_2_0_score_diff;
real	RSN607_0_0_score_baseline;	real	RSN607_0_0_score_new;	real	RSN607_0_0_score_diff;
real	RSN607_1_0_score_baseline;	real	RSN607_1_0_score_new;	real	RSN607_1_0_score_diff;
real	RSN702_1_0_score_baseline;	real	RSN702_1_0_score_new;	real	RSN702_1_0_score_diff;
real	RSN704_0_0_score_baseline;	real	RSN704_0_0_score_new;	real	RSN704_0_0_score_diff;
real	RSN704_1_0_score_baseline;	real	RSN704_1_0_score_new;	real	RSN704_1_0_score_diff;
real	RSN802_1_0_score_baseline;	real	RSN802_1_0_score_new;	real	RSN802_1_0_score_diff;
real	RSN803_1_0_score_baseline;	real	RSN803_1_0_score_new;	real	RSN803_1_0_score_diff;
real	RSN803_2_0_score_baseline;	real	RSN803_2_0_score_new;	real	RSN803_2_0_score_diff;
real	RSN804_1_0_score_baseline;	real	RSN804_1_0_score_new;	real	RSN804_1_0_score_diff;
real	RSN807_0_0_score_baseline;	real	RSN807_0_0_score_new;	real	RSN807_0_0_score_diff;
real	RSN810_1_0_score_baseline;	real	RSN810_1_0_score_new;	real	RSN810_1_0_score_diff;
real	RSN912_1_0_score_baseline;	real	RSN912_1_0_score_new;	real	RSN912_1_0_score_diff;
real	RVA1003_0_0_score_baseline;	real	RVA1003_0_0_score_new;	real	RVA1003_0_0_score_diff;
real	RVA1007_1_0_score_baseline;	real	RVA1007_1_0_score_new;	real	RVA1007_1_0_score_diff;
real	RVA1007_2_0_score_baseline;	real	RVA1007_2_0_score_new;	real	RVA1007_2_0_score_diff;
real	RVA1007_3_0_score_baseline;	real	RVA1007_3_0_score_new;	real	RVA1007_3_0_score_diff;
real	RVA1008_1_0_score_baseline;	real	RVA1008_1_0_score_new;	real	RVA1008_1_0_score_diff;
real	RVA1008_2_0_score_baseline;	real	RVA1008_2_0_score_new;	real	RVA1008_2_0_score_diff;
real	RVA1104_0_0_score_baseline;	real	RVA1104_0_0_score_new;	real	RVA1104_0_0_score_diff;
real	RVA1304_1_0_score_baseline;	real	RVA1304_1_0_score_new;	real	RVA1304_1_0_score_diff;
real	RVA1304_2_0_score_baseline;	real	RVA1304_2_0_score_new;	real	RVA1304_2_0_score_diff;
real	RVA611_0_0_score_baseline;	real	RVA611_0_0_score_new;	real	RVA611_0_0_score_diff;
real	RVA707_0_0_score_baseline;	real	RVA707_0_0_score_new;	real	RVA707_0_0_score_diff;
real	RVA707_1_0_score_baseline;	real	RVA707_1_0_score_new;	real	RVA707_1_0_score_diff;
real	RVA709_1_0_score_baseline;	real	RVA709_1_0_score_new;	real	RVA709_1_0_score_diff;
// real	RVA711_0_0_score_baseline;	real	RVA711_0_0_score_new;	real	RVA711_0_0_score_diff;
real	RVA1611_1_0_score_baseline;	real	RVA1611_1_0_score_new;	real	RVA1611_1_0_score_diff;
real	RVA1611_2_0_score_baseline;	real	RVA1611_2_0_score_new;	real	RVA1611_2_0_score_diff;
real	RVB1003_0_0_score_baseline;	real	RVB1003_0_0_score_new;	real	RVB1003_0_0_score_diff;
real	RVB1104_0_0_score_baseline;	real	RVB1104_0_0_score_new;	real	RVB1104_0_0_score_diff;
real	RVB1104_1_0_score_baseline;	real	RVB1104_1_0_score_new;	real	RVB1104_1_0_score_diff;
real	RVB1310_1_0_score_baseline;	real	RVB1310_1_0_score_new;	real	RVB1310_1_0_score_diff;
real	RVB1402_1_0_score_baseline;	real	RVB1402_1_0_score_new;	real	RVB1402_1_0_score_diff;
real	RVB609_0_0_score_baseline;	real	RVB609_0_0_score_new;	real	RVB609_0_0_score_diff;
// real	RVB703_1_0_score_baseline;	real	RVB703_1_0_score_new;	real	RVB703_1_0_score_diff;
real	RVB705_1_0_score_baseline;	real	RVB705_1_0_score_new;	real	RVB705_1_0_score_diff;
// real	RVB711_0_0_score_baseline;	real	RVB711_0_0_score_new;	real	RVB711_0_0_score_diff;
real	RVB1610_1_0_score_baseline;	real	RVB1610_1_0_score_new;	real	RVB1610_1_0_score_diff;
real	RVC1110_1_0_score_baseline;	real	RVC1110_1_0_score_new;	real	RVC1110_1_0_score_diff;
real	RVC1110_2_0_score_baseline;	real	RVC1110_2_0_score_new;	real	RVC1110_2_0_score_diff;
real	RVC1112_0_0_score_baseline;	real	RVC1112_0_0_score_new;	real	RVC1112_0_0_score_diff;
real	RVC1208_1_0_score_baseline;	real	RVC1208_1_0_score_new;	real	RVC1208_1_0_score_diff;
real	RVC1210_1_0_score_baseline;	real	RVC1210_1_0_score_new;	real	RVC1210_1_0_score_diff;
real	RVC1301_1_0_score_baseline;	real	RVC1301_1_0_score_new;	real	RVC1301_1_0_score_diff;
real	RVD1010_0_0_score_baseline;	real	RVD1010_0_0_score_new;	real	RVD1010_0_0_score_diff;
real	RVD1010_1_0_score_baseline;	real	RVD1010_1_0_score_new;	real	RVD1010_1_0_score_diff;
real	RVD1010_2_0_score_baseline;	real	RVD1010_2_0_score_new;	real	RVD1010_2_0_score_diff;
real	RVD1110_1_0_score_baseline;	real	RVD1110_1_0_score_new;	real	RVD1110_1_0_score_diff;
real	RVG1003_0_0_score_baseline;	real	RVG1003_0_0_score_new;	real	RVG1003_0_0_score_diff;
real	RVG1103_0_0_score_baseline;	real	RVG1103_0_0_score_new;	real	RVG1103_0_0_score_diff;
real	RVG1106_1_0_score_baseline;	real	RVG1106_1_0_score_new;	real	RVG1106_1_0_score_diff;
real	RVG1201_1_0_score_baseline;	real	RVG1201_1_0_score_new;	real	RVG1201_1_0_score_diff;
real	RVG1302_1_0_score_baseline;	real	RVG1302_1_0_score_new;	real	RVG1302_1_0_score_diff;
real	RVG1304_1_0_score_baseline;	real	RVG1304_1_0_score_new;	real	RVG1304_1_0_score_diff;
real	RVG1304_2_0_score_baseline;	real	RVG1304_2_0_score_new;	real	RVG1304_2_0_score_diff;
real	RVG812_0_0_score_baseline;	real	RVG812_0_0_score_new;	real	RVG812_0_0_score_diff;
real	RVG903_1_0_score_baseline;	real	RVG903_1_0_score_new;	real	RVG903_1_0_score_diff;
// real	RVG904_1_0_score_baseline;	real	RVG904_1_0_score_new;	real	RVG904_1_0_score_diff;
// real	RVP1003_0_0_score_baseline;	real	RVP1003_0_0_score_new;	real	RVP1003_0_0_score_diff;
real	RVP1012_1_0_score_baseline;	real	RVP1012_1_0_score_new;	real	RVP1012_1_0_score_diff;
// real	RVP1104_0_0_score_baseline;	real	RVP1104_0_0_score_new;	real	RVP1104_0_0_score_diff;
real	RVP1208_1_0_score_baseline;	real	RVP1208_1_0_score_new;	real	RVP1208_1_0_score_diff;
real	RVP1401_1_0_score_baseline;	real	RVP1401_1_0_score_new;	real	RVP1401_1_0_score_diff;
real	RVP1401_2_0_score_baseline;	real	RVP1401_2_0_score_new;	real	RVP1401_2_0_score_diff;
real	RVP1503_1_0_score_baseline;	real	RVP1503_1_0_score_new;	real	RVP1503_1_0_score_diff;
// real	RVP804_0_0_score_baseline;	real	RVP804_0_0_score_new;	real	RVP804_0_0_score_diff;
real	RVP1702_1_0_score_baseline;	real	RVP1702_1_0_score_new;	real	RVP1702_1_0_score_diff;
// real	RVR1003_0_0_score_baseline;	real	RVR1003_0_0_score_new;	real	RVR1003_0_0_score_diff;
real	RVR1008_1_0_score_baseline;	real	RVR1008_1_0_score_new;	real	RVR1008_1_0_score_diff;
real	RVR1103_0_0_score_baseline;	real	RVR1103_0_0_score_new;	real	RVR1103_0_0_score_diff;
real	RVR1104_2_0_score_baseline;	real	RVR1104_2_0_score_new;	real	RVR1104_2_0_score_diff;
//real	RVR1104_3_0_score_baseline;	real	RVR1104_3_0_score_new;	real	RVR1104_3_0_score_diff;
real	RVR1210_1_0_score_baseline;	real	RVR1210_1_0_score_new;	real	RVR1210_1_0_score_diff;
real	RVR1303_1_0_score_baseline;	real	RVR1303_1_0_score_new;	real	RVR1303_1_0_score_diff;
// real	RVR611_0_0_score_baseline;	real	RVR611_0_0_score_new;	real	RVR611_0_0_score_diff;
real	RVR704_1_0_score_baseline;	real	RVR704_1_0_score_new;	real	RVR704_1_0_score_diff;
// real	RVR711_0_0_score_baseline;	real	RVR711_0_0_score_new;	real	RVR711_0_0_score_diff;
real	RVR803_1_0_score_baseline;	real	RVR803_1_0_score_new;	real	RVR803_1_0_score_diff;
real	RVS811_0_0_score_baseline;	real	RVS811_0_0_score_new;	real	RVS811_0_0_score_diff;
real	RVS1706_0_score_baseline;	real	RVS1706_0_score_new;	real	RVS1706_0_score_diff;
real	RVT1003_0_0_score_baseline;	real	RVT1003_0_0_score_new;	real	RVT1003_0_0_score_diff;
// real	RVT1006_1_0_score_baseline;	real	RVT1006_1_0_score_new;	real	RVT1006_1_0_score_diff;
real	RVT1104_0_0_score_baseline;	real	RVT1104_0_0_score_new;	real	RVT1104_0_0_score_diff;
real	RVT1104_1_0_score_baseline;	real	RVT1104_1_0_score_new;	real	RVT1104_1_0_score_diff;
real	RVT1204_1_score_baseline;	real	RVT1204_1_score_new;	real	RVT1204_1_score_diff;
real	RVT1210_1_0_score_baseline;	real	RVT1210_1_0_score_new;	real	RVT1210_1_0_score_diff;
real	RVT1212_1_0_score_baseline;	real	RVT1212_1_0_score_new;	real	RVT1212_1_0_score_diff;
// real	RVT612_0_score_baseline;	real	RVT612_0_score_new;	real	RVT612_0_score_diff;
// real	RVT711_0_0_score_baseline;	real	RVT711_0_0_score_new;	real	RVT711_0_0_score_diff;
real	RVT711_1_0_score_baseline;	real	RVT711_1_0_score_new;	real	RVT711_1_0_score_diff;
// real	RVT803_1_0_score_baseline;	real	RVT803_1_0_score_new;	real	RVT803_1_0_score_diff;
// real	RVT809_1_0_score_baseline;	real	RVT809_1_0_score_new;	real	RVT809_1_0_score_diff;
real	RVT1605_1_0_score_baseline;	real	RVT1605_1_0_score_new;	real	RVT1605_1_0_score_diff;
real	RVT1605_2_0_score_baseline;	real	RVT1605_2_0_score_new;	real	RVT1605_2_0_score_diff;
real	RVT1608_1_0_score_baseline;	real	RVT1608_1_0_score_new;	real	RVT1608_1_0_score_diff;
real  RVT1608_2_score_baseline;   real  RVT1608_2_score_new;    real  RVT1608_2_score_diff;
real	RVT1705_1_0_score_baseline;	real	RVT1705_1_0_score_new;	real	RVT1705_1_0_score_diff;
// real	TBD605_0_0_score_baseline;	real	TBD605_0_0_score_new;	real	TBD605_0_0_score_diff;
// real	TBD609_1_0_score_baseline;	real	TBD609_1_0_score_new;	real	TBD609_1_0_score_diff;
// real	TBD609_2_0_score_baseline;	real	TBD609_2_0_score_new;	real	TBD609_2_0_score_diff;
real	TBN509_0_0_score_baseline;	real	TBN509_0_0_score_new;	real	TBN509_0_0_score_diff;
real	TBN604_1_0_score_baseline;	real	TBN604_1_0_score_new;	real	TBN604_1_0_score_diff;
// real	TRD605_0_0_score_baseline;	real	TRD605_0_0_score_new;	real	TRD605_0_0_score_diff;
// real	TRD609_1_0_score_baseline;	real	TRD609_1_0_score_new;	real	TRD609_1_0_score_diff;
real	WIN704_0_0_score_baseline;	real	WIN704_0_0_score_new;	real	WIN704_0_0_score_diff;
real	WOMV002_0_0_score_baseline;	real	WOMV002_0_0_score_new;	real	WOMV002_0_0_score_diff;
real	WWN604_1_0_score_baseline;	real	WWN604_1_0_score_new;	real	WWN604_1_0_score_diff;
real	RVC1307_1_0_score_baseline;	real	RVC1307_1_0_score_new;	real	RVC1307_1_0_score_diff;
real	RVC1405_1_0_score_baseline;	real	RVC1405_1_0_score_new;	real	RVC1405_1_0_score_diff;
real	RVC1405_2_0_score_baseline;	real	RVC1405_2_0_score_new;	real	RVC1405_2_0_score_diff;
real	RVC1405_3_0_score_baseline;	real	RVC1405_3_0_score_new;	real	RVC1405_3_0_score_diff;
real	RVC1405_4_0_score_baseline;	real	RVC1405_4_0_score_new;	real	RVC1405_4_0_score_diff;
real	RVC1412_1_0_score_baseline;	real	RVC1412_1_0_score_new;	real	RVC1412_1_0_score_diff;
real	RVC1602_1_0_score_baseline;	real	RVC1602_1_0_score_new;	real	RVC1602_1_0_score_diff;
real	RVC1609_1_0_score_baseline;	real	RVC1609_1_0_score_new;	real	RVC1609_1_0_score_diff;
real	RVC1703_1_0_score_baseline;	real	RVC1703_1_0_score_new;	real	RVC1703_1_0_score_diff;
real	RVC1801_1_0_score_baseline;	real	RVC1801_1_0_score_new;	real	RVC1801_1_0_score_diff;
real	RVC1805_1_0_score_baseline;	real	RVC1805_1_0_score_new;	real	RVC1805_1_0_score_diff;
real	RVC1805_2_0_score_baseline;	real	RVC1805_2_0_score_new;	real	RVC1805_2_0_score_diff;
real	FP1310_1_0_score_baseline;	real	FP1310_1_0_score_new;	real	FP1310_1_0_score_diff;
real	FP1401_1_0_score_baseline;	real	FP1401_1_0_score_new;	real	FP1401_1_0_score_diff;
real	FP1404_1_0_score_baseline;	real	FP1404_1_0_score_new;	real	FP1404_1_0_score_diff;
real	FP1407_1_0_score_baseline;	real	FP1407_1_0_score_new;	real	FP1407_1_0_score_diff;
real	FP1406_1_0_score_baseline;	real	FP1406_1_0_score_new;	real	FP1406_1_0_score_diff;
real	RVA1310_1_0_score_baseline;	real	RVA1310_1_0_score_new;	real	RVA1310_1_0_score_diff;
real	RVA1310_2_0_score_baseline;	real	RVA1310_2_0_score_new;	real	RVA1310_2_0_score_diff;
real	RVA1310_3_0_score_baseline;	real	RVA1310_3_0_score_new;	real	RVA1310_3_0_score_diff;
real	RVT1307_3_0_score_baseline;	real	RVT1307_3_0_score_new;	real	RVT1307_3_0_score_diff;
real	RVT1402_1_0_score_baseline;	real	RVT1402_1_0_score_new;	real	RVT1402_1_0_score_diff;
real	RVA1311_1_0_score_baseline;	real	RVA1311_1_0_score_new;	real	RVA1311_1_0_score_diff;
real	RVA1504_1_0_score_baseline;	real	RVA1504_1_0_score_new;	real	RVA1504_1_0_score_diff;
real	RVA1504_2_0_score_baseline;	real	RVA1504_2_0_score_new;	real	RVA1504_2_0_score_diff;
real	RVA1311_2_0_score_baseline;	real	RVA1311_2_0_score_new;	real	RVA1311_2_0_score_diff;
real	RVA1311_3_0_score_baseline;	real	RVA1311_3_0_score_new;	real	RVA1311_3_0_score_diff;
real	RVG1401_1_0_score_baseline;	real	RVG1401_1_0_score_new;	real	RVG1401_1_0_score_diff;
real	RVG1401_2_0_score_baseline;	real	RVG1401_2_0_score_new;	real	RVG1401_2_0_score_diff;
// real	RVR1311_1_0_score_baseline;	real	RVR1311_1_0_score_new;	real	RVR1311_1_0_score_diff;
real	RVR1410_1_0_score_baseline;	real	RVR1410_1_0_score_new;	real	RVR1410_1_0_score_diff;
real	FP1307_1_0_score_baseline;	real	FP1307_1_0_score_new;	real	FP1307_1_0_score_diff;
real	FP31310_2_0_score_baseline;	real	FP31310_2_0_score_new;	real	FP31310_2_0_score_diff;
real	FP1403_1_0_score_baseline;	real	FP1403_1_0_score_new;	real	FP1403_1_0_score_diff;
real	RVG1310_1_0_score_baseline;	real	RVG1310_1_0_score_new;	real	RVG1310_1_0_score_diff;
real	RVG1404_1_0_score_baseline;	real	RVG1404_1_0_score_new;	real	RVG1404_1_0_score_diff;
real	FP1403_2_0_score_baseline;	real	FP1403_2_0_score_new;	real	FP1403_2_0_score_diff;
real	RVG1502_0_0_score_baseline;	real	RVG1502_0_0_score_new;	real	RVG1502_0_0_score_diff;
real  RVB1503_0_0_score_baseline;	real	RVB1503_0_0_score_new;	real	RVB1503_0_0_score_diff;
real  RVA1503_0_0_score_baseline;	real	RVA1503_0_0_score_new;	real	RVA1503_0_0_score_diff;
real  RVA1601_1_0_score_baseline;	real	RVA1601_1_0_score_new;	real	RVA1601_1_0_score_diff;
real  RVA1603_1_0_score_baseline;	real	RVA1603_1_0_score_new;	real	RVA1603_1_0_score_diff;
real  RVA1605_1_0_score_baseline;	real	RVA1605_1_0_score_new;	real	RVA1605_1_0_score_diff;
real  RVA1607_1_0_score_baseline;	real	RVA1607_1_0_score_new;	real	RVA1607_1_0_score_diff;
real  RVT1503_0_0_score_baseline;	real	RVT1503_0_0_score_new;	real	RVT1503_0_0_score_diff;
real  RVT1601_1_0_score_baseline;	real	RVT1601_1_0_score_new;	real	RVT1601_1_0_score_diff;
real  RVG1601_1_0_score_baseline;	real	RVG1601_1_0_score_new;	real	RVG1601_1_0_score_diff;
real	FP1409_2_0_score_baseline;	real	FP1409_2_0_score_new;	real	FP1409_2_0_score_diff;
real	FP1506_1_0_score_baseline;	real	FP1506_1_0_score_new;	real	FP1506_1_0_score_diff;
real	FP1509_1_0_score_baseline;	real	FP1509_1_0_score_new;	real	FP1509_1_0_score_diff;
real	FP1509_2_0_score_baseline;	real	FP1509_2_0_score_new;	real	FP1509_2_0_score_diff;
real	FP1510_2_0_score_baseline;	real	FP1510_2_0_score_new;	real	FP1510_2_0_score_diff;
real  FP1511_1_0_score_baseline;  real  FP1511_1_0_score_new; real  FP1511_1_0_score_diff;
real  OSN1504_0_0_score_baseline;  real  OSN1504_0_0_score_new; real  OSN1504_0_0_score_diff;
real  OSN1608_1_0_score_baseline;  real  OSN1608_1_0_score_new; real  OSN1608_1_0_score_diff;
real  OSN1803_1_0_score_baseline;  real  OSN1803_1_0_score_new; real  OSN1803_1_0_score_diff;
real  RVG1511_1_0_score_baseline;  real  RVG1511_1_0_score_new; real  RVG1511_1_0_score_diff;
real  FP1512_1_0_score_baseline;  real  FP1512_1_0_score_new; real  FP1512_1_0_score_diff;
real  RVC1412_2_0_score_baseline;  real  RVC1412_2_0_score_new; real  RVC1412_2_0_score_diff;
real	RVG1702_1_0_score_baseline;	real	RVG1702_1_0_score_new;	real	RVG1702_1_0_score_diff;
real	RVG1705_1_0_score_baseline;	real	RVG1705_1_0_score_new;	real	RVG1705_1_0_score_diff;
real	RVG1706_1_0_score_baseline;	real	RVG1706_1_0_score_new;	real	RVG1706_1_0_score_diff;
real	RVG1610_1_0_score_baseline;	real	RVG1610_1_0_score_new;	real	RVG1610_1_0_score_diff;
real	RVG1802_1_0_score_baseline;	real	RVG1802_1_0_score_new;	real	RVG1802_1_0_score_diff;
real	RVD1801_1_0_score_baseline;	real	RVD1801_1_0_score_new;	real	RVD1801_1_0_score_diff;
real	FP1801_1_0_score_baseline;	real	FP1801_1_0_score_new;	real	FP1801_1_0_score_diff;

real	FP31505_0_0_score_baseline;	real	FP31505_0_0_score_new;	real	FP31505_0_0_score_diff;
real	FP3FDN1505_0_0_score_baseline;	real	FP3FDN1505_0_0_score_new;	real	FP3FDN1505_0_0_score_diff;
real	RVA1811_1_0_score_baseline;	real	RVA1811_1_0_score_new;	real	RVA1811_1_0_score_diff;
real	RVG1808_3_0_score_baseline;	real	RVG1808_3_0_score_new;	real	RVG1808_3_0_score_diff;
real	RVG1808_1_0_score_baseline;	real	RVG1808_1_0_score_new;	real	RVG1808_1_0_score_diff;
real	RVG1808_2_0_score_baseline;	real	RVG1808_2_0_score_new;	real	RVG1808_2_0_score_diff;
real	RVA1809_1_0_score_baseline;	real	RVA1809_1_0_score_new;	real	RVA1809_1_0_score_diff;
end;

j := join(runway_results_baseline, runway_results_testfile, left.seq=right.seq, 
	transform(cmpr, 
self.seq := left.seq;
self.any_difference := left<>right;

self.NAP_baseline 	:= (real)left.NAP	;		self.NAP_new := (real)right.NAP	;		self.NAP_diff := (real)right.NAP	-(real)left.NAP	;
self.NAS_baseline 	:= (real)left.NAS	;		self.NAS_new := (real)right.NAS	;		self.NAS_diff := (real)right.NAS	-(real)left.NAS	;
self.CVI_score_baseline 	:= (real)left.CVI_score	;		self.CVI_score_new := (real)right.CVI_score	;		self.CVI_score_diff := (real)right.CVI_score	-(real)left.CVI_score	;
// self.AID605_1_0_score_baseline 	:= (real)left.AID605_1_0_score	;		self.AID605_1_0_score_new := (real)right.AID605_1_0_score	;		self.AID605_1_0_score_diff := (real)right.AID605_1_0_score	-(real)left.AID605_1_0_score	;
// self.AID606_0_0_score_baseline 	:= (real)left.AID606_0_0_score	;		self.AID606_0_0_score_new := (real)right.AID606_0_0_score	;		self.AID606_0_0_score_diff := (real)right.AID606_0_0_score	-(real)left.AID606_0_0_score	;
// self.AID606_1_0_score_baseline 	:= (real)left.AID606_1_0_score	;		self.AID606_1_0_score_new := (real)right.AID606_1_0_score	;		self.AID606_1_0_score_diff := (real)right.AID606_1_0_score	-(real)left.AID606_1_0_score	;
// self.AID607_0_0_score_baseline 	:= (real)left.AID607_0_0_score	;		self.AID607_0_0_score_new := (real)right.AID607_0_0_score	;		self.AID607_0_0_score_diff := (real)right.AID607_0_0_score	-(real)left.AID607_0_0_score	;
// self.AID607_1_0_score_baseline 	:= (real)left.AID607_1_0_score	;		self.AID607_1_0_score_new := (real)right.AID607_1_0_score	;		self.AID607_1_0_score_diff := (real)right.AID607_1_0_score	-(real)left.AID607_1_0_score	;
// self.AID607_2_0_score_baseline 	:= (real)left.AID607_2_0_score	;		self.AID607_2_0_score_new := (real)right.AID607_2_0_score	;		self.AID607_2_0_score_diff := (real)right.AID607_2_0_score	-(real)left.AID607_2_0_score	;
self.AIN509_0_0_score_baseline 	:= (real)left.AIN509_0_0_score	;		self.AIN509_0_0_score_new := (real)right.AIN509_0_0_score	;		self.AIN509_0_0_score_diff := (real)right.AIN509_0_0_score	-(real)left.AIN509_0_0_score	;
self.AIN602_1_0_score_baseline 	:= (real)left.AIN602_1_0_score	;		self.AIN602_1_0_score_new := (real)right.AIN602_1_0_score	;		self.AIN602_1_0_score_diff := (real)right.AIN602_1_0_score	-(real)left.AIN602_1_0_score	;
self.AIN605_1_0_score_baseline 	:= (real)left.AIN605_1_0_score	;		self.AIN605_1_0_score_new := (real)right.AIN605_1_0_score	;		self.AIN605_1_0_score_diff := (real)right.AIN605_1_0_score	-(real)left.AIN605_1_0_score	;
self.AIN605_2_0_score_baseline 	:= (real)left.AIN605_2_0_score	;		self.AIN605_2_0_score_new := (real)right.AIN605_2_0_score	;		self.AIN605_2_0_score_diff := (real)right.AIN605_2_0_score	-(real)left.AIN605_2_0_score	;
self.AIN605_3_0_score_baseline 	:= (real)left.AIN605_3_0_score	;		self.AIN605_3_0_score_new := (real)right.AIN605_3_0_score	;		self.AIN605_3_0_score_diff := (real)right.AIN605_3_0_score	-(real)left.AIN605_3_0_score	;
self.AIN801_1_0_score_baseline 	:= (real)left.AIN801_1_0_score	;		self.AIN801_1_0_score_new := (real)right.AIN801_1_0_score	;		self.AIN801_1_0_score_diff := (real)right.AIN801_1_0_score	-(real)left.AIN801_1_0_score	;
self.ANMK909_0_1_score_baseline := (real)left.ANMK909_0_1_score	;		self.ANMK909_0_1_score_new := (real)right.ANMK909_0_1_score	;		self.ANMK909_0_1_score_diff := (real)right.ANMK909_0_1_score	-(real)left.ANMK909_0_1_score	;
// self.AWD605_0_0_score_baseline 	:= (real)left.AWD605_0_0_score	;		self.AWD605_0_0_score_new := (real)right.AWD605_0_0_score	;		self.AWD605_0_0_score_diff := (real)right.AWD605_0_0_score	-(real)left.AWD605_0_0_score	;
// self.AWD605_2_0_score_baseline 	:= (real)left.AWD605_2_0_score	;		self.AWD605_2_0_score_new := (real)right.AWD605_2_0_score	;		self.AWD605_2_0_score_diff := (real)right.AWD605_2_0_score	-(real)left.AWD605_2_0_score	;
// self.AWD606_10_0_score_baseline := (real)left.AWD606_10_0_score	;		self.AWD606_10_0_score_new := (real)right.AWD606_10_0_score	;		self.AWD606_10_0_score_diff := (real)right.AWD606_10_0_score	-(real)left.AWD606_10_0_score	;
// self.AWD606_11_0_score_baseline := (real)left.AWD606_11_0_score	;		self.AWD606_11_0_score_new := (real)right.AWD606_11_0_score	;		self.AWD606_11_0_score_diff := (real)right.AWD606_11_0_score	-(real)left.AWD606_11_0_score	;
// self.AWD606_1_0_score_baseline 	:= (real)left.AWD606_1_0_score	;		self.AWD606_1_0_score_new := (real)right.AWD606_1_0_score	;		self.AWD606_1_0_score_diff := (real)right.AWD606_1_0_score	-(real)left.AWD606_1_0_score	;
// self.AWD606_2_0_score_baseline 	:= (real)left.AWD606_2_0_score	;		self.AWD606_2_0_score_new := (real)right.AWD606_2_0_score	;		self.AWD606_2_0_score_diff := (real)right.AWD606_2_0_score	-(real)left.AWD606_2_0_score	;
// self.AWD606_3_0_score_baseline 	:= (real)left.AWD606_3_0_score	;		self.AWD606_3_0_score_new := (real)right.AWD606_3_0_score	;		self.AWD606_3_0_score_diff := (real)right.AWD606_3_0_score	-(real)left.AWD606_3_0_score	;
// self.AWD606_4_0_score_baseline 	:= (real)left.AWD606_4_0_score	;		self.AWD606_4_0_score_new := (real)right.AWD606_4_0_score	;		self.AWD606_4_0_score_diff := (real)right.AWD606_4_0_score	-(real)left.AWD606_4_0_score	;
// self.AWD606_6_0_score_baseline 	:= (real)left.AWD606_6_0_score	;		self.AWD606_6_0_score_new := (real)right.AWD606_6_0_score	;		self.AWD606_6_0_score_diff := (real)right.AWD606_6_0_score	-(real)left.AWD606_6_0_score	;
// self.AWD606_7_0_score_baseline 	:= (real)left.AWD606_7_0_score	;		self.AWD606_7_0_score_new := (real)right.AWD606_7_0_score	;		self.AWD606_7_0_score_diff := (real)right.AWD606_7_0_score	-(real)left.AWD606_7_0_score	;
// self.AWD606_8_0_score_baseline 	:= (real)left.AWD606_8_0_score	;		self.AWD606_8_0_score_new := (real)right.AWD606_8_0_score	;		self.AWD606_8_0_score_diff := (real)right.AWD606_8_0_score	-(real)left.AWD606_8_0_score	;
// self.AWD606_9_0_score_baseline 	:= (real)left.AWD606_9_0_score	;		self.AWD606_9_0_score_new := (real)right.AWD606_9_0_score	;		self.AWD606_9_0_score_diff := (real)right.AWD606_9_0_score	-(real)left.AWD606_9_0_score	;
// self.AWD710_1_0_score_baseline 	:= (real)left.AWD710_1_0_score	;		self.AWD710_1_0_score_new := (real)right.AWD710_1_0_score	;		self.AWD710_1_0_score_diff := (real)right.AWD710_1_0_score	-(real)left.AWD710_1_0_score	;
self.AWN510_0_0_score_baseline 	:= (real)left.AWN510_0_0_score	;		self.AWN510_0_0_score_new := (real)right.AWN510_0_0_score	;		self.AWN510_0_0_score_diff := (real)right.AWN510_0_0_score	-(real)left.AWN510_0_0_score	;
self.AWN603_1_0_score_baseline 	:= (real)left.AWN603_1_0_score	;		self.AWN603_1_0_score_new := (real)right.AWN603_1_0_score	;		self.AWN603_1_0_score_diff := (real)right.AWN603_1_0_score	-(real)left.AWN603_1_0_score	;
self.BD3605_0_0_score_baseline 	:= (real)left.BD3605_0_0_score	;		self.BD3605_0_0_score_new := (real)right.BD3605_0_0_score	;		self.BD3605_0_0_score_diff := (real)right.BD3605_0_0_score	-(real)left.BD3605_0_0_score	;
self.BD5605_0_0_score_baseline 	:= (real)left.BD5605_0_0_score	;		self.BD5605_0_0_score_new := (real)right.BD5605_0_0_score	;		self.BD5605_0_0_score_diff := (real)right.BD5605_0_0_score	-(real)left.BD5605_0_0_score	;
self.BD5605_1_0_score_baseline 	:= (real)left.BD5605_1_0_score	;		self.BD5605_1_0_score_new := (real)right.BD5605_1_0_score	;		self.BD5605_1_0_score_diff := (real)right.BD5605_1_0_score	-(real)left.BD5605_1_0_score	;
self.BD5605_2_0_score_baseline 	:= (real)left.BD5605_2_0_score	;		self.BD5605_2_0_score_new := (real)right.BD5605_2_0_score	;		self.BD5605_2_0_score_diff := (real)right.BD5605_2_0_score	-(real)left.BD5605_2_0_score	;
self.BD5605_3_0_score_baseline 	:= (real)left.BD5605_3_0_score	;		self.BD5605_3_0_score_new := (real)right.BD5605_3_0_score	;		self.BD5605_3_0_score_diff := (real)right.BD5605_3_0_score	-(real)left.BD5605_3_0_score	;
self.BD9605_0_0_score_baseline 	:= (real)left.BD9605_0_0_score	;		self.BD9605_0_0_score_new := (real)right.BD9605_0_0_score	;		self.BD9605_0_0_score_diff := (real)right.BD9605_0_0_score	-(real)left.BD9605_0_0_score	;
self.BD9605_1_0_score_baseline 	:= (real)left.BD9605_1_0_score	;		self.BD9605_1_0_score_new := (real)right.BD9605_1_0_score	;		self.BD9605_1_0_score_diff := (real)right.BD9605_1_0_score	-(real)left.BD9605_1_0_score	;
self.CDN1109_1_0_score_baseline := (real)left.CDN1109_1_0_score	;		self.CDN1109_1_0_score_new := (real)right.CDN1109_1_0_score	;		self.CDN1109_1_0_score_diff := (real)right.CDN1109_1_0_score	-(real)left.CDN1109_1_0_score	;
self.CDN1205_1_0_score_baseline := (real)left.CDN1205_1_0_score	;		self.CDN1205_1_0_score_new := (real)right.CDN1205_1_0_score	;		self.CDN1205_1_0_score_diff := (real)right.CDN1205_1_0_score	-(real)left.CDN1205_1_0_score	;
self.CDN1305_1_0_score_baseline := (real)left.CDN1305_1_0_score	;		self.CDN1305_1_0_score_new := (real)right.CDN1305_1_0_score	;		self.CDN1305_1_0_score_diff := (real)right.CDN1305_1_0_score	-(real)left.CDN1305_1_0_score	;
self.CDN1404_1_0_score_baseline := (real)left.CDN1404_1_0_score	;		self.CDN1404_1_0_score_new := (real)right.CDN1404_1_0_score	;		self.CDN1404_1_0_score_diff := (real)right.CDN1404_1_0_score	-(real)left.CDN1404_1_0_score	;
self.CDN1410_1_0_score_baseline := (real)left.CDN1410_1_0_score	;		self.CDN1410_1_0_score_new := (real)right.CDN1410_1_0_score	;		self.CDN1410_1_0_score_diff := (real)right.CDN1410_1_0_score	-(real)left.CDN1410_1_0_score	;
self.CDN1506_1_0_score_baseline := (real)left.CDN1506_1_0_score	;		self.CDN1506_1_0_score_new := (real)right.CDN1506_1_0_score	;		self.CDN1506_1_0_score_diff := (real)right.CDN1506_1_0_score	-(real)left.CDN1506_1_0_score	;
self.CDN1508_1_0_score_baseline := (real)left.CDN1508_1_0_score	;		self.CDN1508_1_0_score_new := (real)right.CDN1508_1_0_score	;		self.CDN1508_1_0_score_diff := (real)right.CDN1508_1_0_score	-(real)left.CDN1508_1_0_score	;
self.CDN604_0_0_score_baseline 	:= (real)left.CDN604_0_0_score	;		self.CDN604_0_0_score_new := (real)right.CDN604_0_0_score	;		self.CDN604_0_0_score_diff := (real)right.CDN604_0_0_score	-(real)left.CDN604_0_0_score	;
self.CDN604_1_0_score_baseline 	:= (real)left.CDN604_1_0_score	;		self.CDN604_1_0_score_new := (real)right.CDN604_1_0_score	;		self.CDN604_1_0_score_diff := (real)right.CDN604_1_0_score	-(real)left.CDN604_1_0_score	;
self.CDN604_2_0_score_baseline 	:= (real)left.CDN604_2_0_score	;		self.CDN604_2_0_score_new := (real)right.CDN604_2_0_score	;		self.CDN604_2_0_score_diff := (real)right.CDN604_2_0_score	-(real)left.CDN604_2_0_score	;
self.CDN604_3_0_score_baseline 	:= (real)left.CDN604_3_0_score	;		self.CDN604_3_0_score_new := (real)right.CDN604_3_0_score	;		self.CDN604_3_0_score_diff := (real)right.CDN604_3_0_score	-(real)left.CDN604_3_0_score	;
self.CDN604_4_0_score_baseline 	:= (real)left.CDN604_4_0_score	;		self.CDN604_4_0_score_new := (real)right.CDN604_4_0_score	;		self.CDN604_4_0_score_diff := (real)right.CDN604_4_0_score	-(real)left.CDN604_4_0_score	;
self.CDN605_1_0_score_baseline 	:= (real)left.CDN605_1_0_score	;		self.CDN605_1_0_score_new := (real)right.CDN605_1_0_score	;		self.CDN605_1_0_score_diff := (real)right.CDN605_1_0_score	-(real)left.CDN605_1_0_score	;
self.CDN606_2_0_score_baseline 	:= (real)left.CDN606_2_0_score	;		self.CDN606_2_0_score_new := (real)right.CDN606_2_0_score	;		self.CDN606_2_0_score_diff := (real)right.CDN606_2_0_score	-(real)left.CDN606_2_0_score	;
self.CDN706_1_0_score_baseline 	:= (real)left.CDN706_1_0_score	;		self.CDN706_1_0_score_new := (real)right.CDN706_1_0_score	;		self.CDN706_1_0_score_diff := (real)right.CDN706_1_0_score	-(real)left.CDN706_1_0_score	;
self.CDN707_1_0_score_baseline 	:= (real)left.CDN707_1_0_score	;		self.CDN707_1_0_score_new := (real)right.CDN707_1_0_score	;		self.CDN707_1_0_score_diff := (real)right.CDN707_1_0_score	-(real)left.CDN707_1_0_score	;
self.CDN712_0_0_score_baseline 	:= (real)left.CDN712_0_0_score	;		self.CDN712_0_0_score_new := (real)right.CDN712_0_0_score	;		self.CDN712_0_0_score_diff := (real)right.CDN712_0_0_score	-(real)left.CDN712_0_0_score	;
self.CDN806_1_0_score_baseline 	:= (real)left.CDN806_1_0_score	;		self.CDN806_1_0_score_new := (real)right.CDN806_1_0_score	;		self.CDN806_1_0_score_diff := (real)right.CDN806_1_0_score	-(real)left.CDN806_1_0_score	;
//self.CDN810_1_0_score_baseline 	:= (real)left.CDN810_1_0_score	;		self.CDN810_1_0_score_new := (real)right.CDN810_1_0_score	;		self.CDN810_1_0_score_diff := (real)right.CDN810_1_0_score	-(real)left.CDN810_1_0_score	;
self.CDN908_1_0_score_baseline 	:= (real)left.CDN908_1_0_score	;		self.CDN908_1_0_score_new := (real)right.CDN908_1_0_score	;		self.CDN908_1_0_score_diff := (real)right.CDN908_1_0_score	-(real)left.CDN908_1_0_score	;
self.CEN509_0_0_score_baseline 	:= (real)left.CEN509_0_0_score	;		self.CEN509_0_0_score_new := (real)right.CEN509_0_0_score	;		self.CEN509_0_0_score_diff := (real)right.CEN509_0_0_score	-(real)left.CEN509_0_0_score	;
self.CSN1007_0_0_score_baseline := (real)left.CSN1007_0_0_score	;		self.CSN1007_0_0_score_new := (real)right.CSN1007_0_0_score	;		self.CSN1007_0_0_score_diff := (real)right.CSN1007_0_0_score	-(real)left.CSN1007_0_0_score	;
self.FD3510_0_0_score_baseline 	:= (real)left.FD3510_0_0_score	;		self.FD3510_0_0_score_new := (real)right.FD3510_0_0_score	;		self.FD3510_0_0_score_diff := (real)right.FD3510_0_0_score	-(real)left.FD3510_0_0_score	;
self.FD3606_0_0_score_baseline 	:= (real)left.FD3606_0_0_score	;		self.FD3606_0_0_score_new := (real)right.FD3606_0_0_score	;		self.FD3606_0_0_score_diff := (real)right.FD3606_0_0_score	-(real)left.FD3606_0_0_score	;
self.FD5510_0_0_score_baseline 	:= (real)left.FD5510_0_0_score	;		self.FD5510_0_0_score_new := (real)right.FD5510_0_0_score	;		self.FD5510_0_0_score_diff := (real)right.FD5510_0_0_score	-(real)left.FD5510_0_0_score	;
self.FD5603_1_0_score_baseline 	:= (real)left.FD5603_1_0_score	;		self.FD5603_1_0_score_new := (real)right.FD5603_1_0_score	;		self.FD5603_1_0_score_diff := (real)right.FD5603_1_0_score	-(real)left.FD5603_1_0_score	;
self.FD5603_2_0_score_baseline 	:= (real)left.FD5603_2_0_score	;		self.FD5603_2_0_score_new := (real)right.FD5603_2_0_score	;		self.FD5603_2_0_score_diff := (real)right.FD5603_2_0_score	-(real)left.FD5603_2_0_score	;
self.FD5603_3_0_score_baseline 	:= (real)left.FD5603_3_0_score	;		self.FD5603_3_0_score_new := (real)right.FD5603_3_0_score	;		self.FD5603_3_0_score_diff := (real)right.FD5603_3_0_score	-(real)left.FD5603_3_0_score	;
self.FD5607_1_0_score_baseline 	:= (real)left.FD5607_1_0_score	;		self.FD5607_1_0_score_new := (real)right.FD5607_1_0_score	;		self.FD5607_1_0_score_diff := (real)right.FD5607_1_0_score	-(real)left.FD5607_1_0_score	;
self.FD5609_1_0_score_baseline 	:= (real)left.FD5609_1_0_score	;		self.FD5609_1_0_score_new := (real)right.FD5609_1_0_score	;		self.FD5609_1_0_score_diff := (real)right.FD5609_1_0_score	-(real)left.FD5609_1_0_score	;
self.FD5609_2_0_score_baseline 	:= (real)left.FD5609_2_0_score	;		self.FD5609_2_0_score_new := (real)right.FD5609_2_0_score	;		self.FD5609_2_0_score_diff := (real)right.FD5609_2_0_score	-(real)left.FD5609_2_0_score	;
self.FD5709_1_0_score_baseline 	:= (real)left.FD5709_1_0_score	;		self.FD5709_1_0_score_new := (real)right.FD5709_1_0_score	;		self.FD5709_1_0_score_diff := (real)right.FD5709_1_0_score	-(real)left.FD5709_1_0_score	;
self.FD9510_0_0_score_baseline 	:= (real)left.FD9510_0_0_score	;		self.FD9510_0_0_score_new := (real)right.FD9510_0_0_score	;		self.FD9510_0_0_score_diff := (real)right.FD9510_0_0_score	-(real)left.FD9510_0_0_score	;
self.FD9603_1_0_score_baseline 	:= (real)left.FD9603_1_0_score	;		self.FD9603_1_0_score_new := (real)right.FD9603_1_0_score	;		self.FD9603_1_0_score_diff := (real)right.FD9603_1_0_score	-(real)left.FD9603_1_0_score	;
self.FD9603_2_0_score_baseline 	:= (real)left.FD9603_2_0_score	;		self.FD9603_2_0_score_new := (real)right.FD9603_2_0_score	;		self.FD9603_2_0_score_diff := (real)right.FD9603_2_0_score	-(real)left.FD9603_2_0_score	;
self.FD9603_3_0_score_baseline 	:= (real)left.FD9603_3_0_score	;		self.FD9603_3_0_score_new := (real)right.FD9603_3_0_score	;		self.FD9603_3_0_score_diff := (real)right.FD9603_3_0_score	-(real)left.FD9603_3_0_score	;
self.FD9603_4_0_score_baseline 	:= (real)left.FD9603_4_0_score	;		self.FD9603_4_0_score_new := (real)right.FD9603_4_0_score	;		self.FD9603_4_0_score_diff := (real)right.FD9603_4_0_score	-(real)left.FD9603_4_0_score	;
self.FD9604_1_0_score_baseline 	:= (real)left.FD9604_1_0_score	;		self.FD9604_1_0_score_new := (real)right.FD9604_1_0_score	;		self.FD9604_1_0_score_diff := (real)right.FD9604_1_0_score	-(real)left.FD9604_1_0_score	;
self.FD9606_0_0_score_baseline 	:= (real)left.FD9606_0_0_score	;		self.FD9606_0_0_score_new := (real)right.FD9606_0_0_score	;		self.FD9606_0_0_score_diff := (real)right.FD9606_0_0_score	-(real)left.FD9606_0_0_score	;
self.FD9607_1_0_score_baseline 	:= (real)left.FD9607_1_0_score	;		self.FD9607_1_0_score_new := (real)right.FD9607_1_0_score	;		self.FD9607_1_0_score_diff := (real)right.FD9607_1_0_score	-(real)left.FD9607_1_0_score	;
self.FP1109_0_0_score_baseline 	:= (real)left.FP1109_0_0_score	;		self.FP1109_0_0_score_new := (real)right.FP1109_0_0_score	;		self.FP1109_0_0_score_diff := (real)right.FP1109_0_0_score	-(real)left.FP1109_0_0_score	;
self.FP1210_1_0_score_baseline 	:= (real)left.FP1210_1_0_score	;		self.FP1210_1_0_score_new := (real)right.FP1210_1_0_score	;		self.FP1210_1_0_score_diff := (real)right.FP1210_1_0_score	-(real)left.FP1210_1_0_score	;
self.FP1303_1_0_score_baseline 	:= (real)left.FP1303_1_0_score	;		self.FP1303_1_0_score_new := (real)right.FP1303_1_0_score	;		self.FP1303_1_0_score_diff := (real)right.FP1303_1_0_score	-(real)left.FP1303_1_0_score	;
self.FP31105_1_0_score_baseline := (real)left.FP31105_1_0_score	;		self.FP31105_1_0_score_new := (real)right.FP31105_1_0_score	;		self.FP31105_1_0_score_diff := (real)right.FP31105_1_0_score	-(real)left.FP31105_1_0_score	;
self.FP31203_1_0_score_baseline := (real)left.FP31203_1_0_score	;		self.FP31203_1_0_score_new := (real)right.FP31203_1_0_score	;		self.FP31203_1_0_score_diff := (real)right.FP31203_1_0_score	-(real)left.FP31203_1_0_score	;
self.FP31604_0_0_score_baseline := (real)left.FP31604_0_0_score	;		self.FP31604_0_0_score_new := (real)right.FP31604_0_0_score	;		self.FP31604_0_0_score_diff := (real)right.FP31604_0_0_score	-(real)left.FP31604_0_0_score	;
self.FP3710_0_0_score_baseline 	:= (real)left.FP3710_0_0_score	;		self.FP3710_0_0_score_new := (real)right.FP3710_0_0_score	;		self.FP3710_0_0_score_diff := (real)right.FP3710_0_0_score	-(real)left.FP3710_0_0_score	;
self.FP3904_1_0_score_baseline 	:= (real)left.FP3904_1_0_score	;		self.FP3904_1_0_score_new := (real)right.FP3904_1_0_score	;		self.FP3904_1_0_score_diff := (real)right.FP3904_1_0_score	-(real)left.FP3904_1_0_score	;
self.FP3905_1_0_score_baseline 	:= (real)left.FP3905_1_0_score	;		self.FP3905_1_0_score_new := (real)right.FP3905_1_0_score	;		self.FP3905_1_0_score_diff := (real)right.FP3905_1_0_score	-(real)left.FP3905_1_0_score	;
self.FP5812_1_0_score_baseline 	:= (real)left.FP5812_1_0_score	;		self.FP5812_1_0_score_new := (real)right.FP5812_1_0_score	;		self.FP5812_1_0_score_diff := (real)right.FP5812_1_0_score	-(real)left.FP5812_1_0_score	;
self.FP1611_1_0_score_baseline 	:= (real)left.FP1611_1_0_score	;		self.FP1611_1_0_score_new := (real)right.FP1611_1_0_score	;		self.FP1611_1_0_score_diff := (real)right.FP1611_1_0_score	-(real)left.FP1611_1_0_score	;
self.FP1610_1_0_score_baseline 	:= (real)left.FP1610_1_0_score	;		self.FP1610_1_0_score_new := (real)right.FP1610_1_0_score	;		self.FP1610_1_0_score_diff := (real)right.FP1610_1_0_score	-(real)left.FP1610_1_0_score	;
self.FP1802_1_0_score_baseline 	:= (real)left.FP1802_1_0_score	;		self.FP1802_1_0_score_new := (real)right.FP1802_1_0_score	;		self.FP1802_1_0_score_diff := (real)right.FP1802_1_0_score	-(real)left.FP1802_1_0_score	;
self.FP1610_2_0_score_baseline 	:= (real)left.FP1610_2_0_score	;		self.FP1610_2_0_score_new := (real)right.FP1610_2_0_score	;		self.FP1610_2_0_score_diff := (real)right.FP1610_2_0_score	-(real)left.FP1610_2_0_score	;
self.FP1609_1_0_score_baseline 	:= (real)left.FP1609_1_0_score	;		self.FP1609_1_0_score_new := (real)right.FP1609_1_0_score	;		self.FP1609_1_0_score_diff := (real)right.FP1609_1_0_score	-(real)left.FP1609_1_0_score	;
self.FP1508_1_0_score_baseline 	:= (real)left.FP1508_1_0_score	;		self.FP1508_1_0_score_new := (real)right.FP1508_1_0_score	;		self.FP1508_1_0_score_diff := (real)right.FP1508_1_0_score	-(real)left.FP1508_1_0_score	;
self.FP1702_2_0_score_baseline 	:= (real)left.FP1702_2_0_score	;		self.FP1702_2_0_score_new := (real)right.FP1702_2_0_score	;		self.FP1702_2_0_score_diff := (real)right.FP1702_2_0_score	-(real)left.FP1702_2_0_score	;
self.FP1702_1_0_score_baseline 	:= (real)left.FP1702_1_0_score	;		self.FP1702_1_0_score_new := (real)right.FP1702_1_0_score	;		self.FP1702_1_0_score_diff := (real)right.FP1702_1_0_score	-(real)left.FP1702_1_0_score	;
self.FP1706_1_0_score_baseline 	:= (real)left.FP1706_1_0_score	;		self.FP1706_1_0_score_new := (real)right.FP1706_1_0_score	;		self.FP1706_1_0_score_diff := (real)right.FP1706_1_0_score	-(real)left.FP1706_1_0_score	;
self.FP1705_1_0_score_baseline 	:= (real)left.FP1705_1_0_score	;		self.FP1705_1_0_score_new := (real)right.FP1705_1_0_score	;		self.FP1705_1_0_score_diff := (real)right.FP1705_1_0_score	-(real)left.FP1705_1_0_score	;
self.FP1710_1_0_score_baseline 	:= (real)left.FP1710_1_0_score	;		self.FP1710_1_0_score_new := (real)right.FP1710_1_0_score	;		self.FP1710_1_0_score_diff := (real)right.FP1710_1_0_score	-(real)left.FP1710_1_0_score	;
self.FP1806_1_0_score_baseline 	:= (real)left.FP1806_1_0_score	;		self.FP1806_1_0_score_new := (real)right.FP1806_1_0_score	;		self.FP1806_1_0_score_diff := (real)right.FP1806_1_0_score	-(real)left.FP1806_1_0_score	;
self.FP1803_1_0_score_baseline 	:= (real)left.FP1803_1_0_score	;		self.FP1803_1_0_score_new := (real)right.FP1803_1_0_score	;		self.FP1803_1_0_score_diff := (real)right.FP1803_1_0_score	-(real)left.FP1803_1_0_score	;
self.FP1609_2_0_score_baseline 	:= (real)left.FP1609_2_0_score	;		self.FP1609_2_0_score_new := (real)right.FP1609_2_0_score	;		self.FP1609_2_0_score_diff := (real)right.FP1609_2_0_score	-(real)left.FP1609_2_0_score	;
self.FP1606_1_0_score_baseline 	:= (real)left.FP1606_1_0_score	;		self.FP1606_1_0_score_new := (real)right.FP1606_1_0_score	;		self.FP1606_1_0_score_diff := (real)right.FP1606_1_0_score	-(real)left.FP1606_1_0_score	;
self.HCP1206_0_0_score_baseline := (real)left.HCP1206_0_0_score	;		self.HCP1206_0_0_score_new := (real)right.HCP1206_0_0_score	;		self.HCP1206_0_0_score_diff := (real)right.HCP1206_0_0_score	-(real)left.HCP1206_0_0_score	;
self.IDN605_1_0_score_baseline 	:= (real)left.IDN605_1_0_score	;		self.IDN605_1_0_score_new := (real)right.IDN605_1_0_score	;		self.IDN605_1_0_score_diff := (real)right.IDN605_1_0_score	-(real)left.IDN605_1_0_score	;
// self.IE912_0_0_score_baseline 	:= (real)left.IE912_0_0_score	;		self.IE912_0_0_score_new := (real)right.IE912_0_0_score	;		self.IE912_0_0_score_diff := (real)right.IE912_0_0_score	-(real)left.IE912_0_0_score	;
// self.IE912_1_0_score_baseline   := (real)left.IE912_1_0_score	;		self.IE912_1_0_score_new := (real)right.IE912_1_0_score	;		self.IE912_1_0_score_diff := (real)right.IE912_1_0_score	-(real)left.IE912_1_0_score	;
self.IED1106_1_0_score_baseline := (real)left.IED1106_1_0_score	;		self.IED1106_1_0_score_new := (real)right.IED1106_1_0_score	;		self.IED1106_1_0_score_diff := (real)right.IED1106_1_0_score	-(real)left.IED1106_1_0_score	;
self.IEN1006_0_1_score_baseline := (real)left.IEN1006_0_1_score	;		self.IEN1006_0_1_score_new := (real)right.IEN1006_0_1_score	;		self.IEN1006_0_1_score_diff := (real)right.IEN1006_0_1_score	-(real)left.IEN1006_0_1_score	;
self.MNC21106_0_0_score_baseline := (real)left.MNC21106_0_0_score	;		self.MNC21106_0_0_score_new := (real)right.MNC21106_0_0_score	;		self.MNC21106_0_0_score_diff := (real)right.MNC21106_0_0_score	-(real)left.MNC21106_0_0_score	;
self.MPX1211_0_0_score_baseline := (real)left.MPX1211_0_0_score	;		self.MPX1211_0_0_score_new := (real)right.MPX1211_0_0_score	;		self.MPX1211_0_0_score_diff := (real)right.MPX1211_0_0_score	-(real)left.MPX1211_0_0_score	;
self.MSD1010_0_0_score_baseline := (real)left.MSD1010_0_0_score	;		self.MSD1010_0_0_score_new := (real)right.MSD1010_0_0_score	;		self.MSD1010_0_0_score_diff := (real)right.MSD1010_0_0_score	-(real)left.MSD1010_0_0_score	;
self.MSN1106_0_0_score_baseline := (real)left.MSN1106_0_0_score	;		self.MSN1106_0_0_score_new := (real)right.MSN1106_0_0_score	;		self.MSN1106_0_0_score_diff := (real)right.MSN1106_0_0_score	-(real)left.MSN1106_0_0_score	;
self.MSN605_1_0_score_baseline  := (real)left.MSN605_1_0_score	;		self.MSN605_1_0_score_new := (real)right.MSN605_1_0_score	;		self.MSN605_1_0_score_diff := (real)right.MSN605_1_0_score	-(real)left.MSN605_1_0_score	;
self.MSN610_0_0_score_baseline  := (real)left.MSN610_0_0_score	;		self.MSN610_0_0_score_new := (real)right.MSN610_0_0_score	;		self.MSN610_0_0_score_diff := (real)right.MSN610_0_0_score	-(real)left.MSN610_0_0_score	;
self.MSN1803_1_0_score_baseline := (real)left.MSN1803_1_0_score	;		self.MSN1803_1_0_score_new := (real)right.MSN1803_1_0_score	;		self.MSN1803_1_0_score_diff := (real)right.MSN1803_1_0_score	-(real)left.MSN1803_1_0_score	;
self.MV361006_0_0_score_baseline := (real)left.MV361006_0_0_score	;		self.MV361006_0_0_score_new := (real)right.MV361006_0_0_score	;		self.MV361006_0_0_score_diff := (real)right.MV361006_0_0_score	-(real)left.MV361006_0_0_score	;
self.MV361006_1_0_score_baseline := (real)left.MV361006_1_0_score	;		self.MV361006_1_0_score_new := (real)right.MV361006_1_0_score	;		self.MV361006_1_0_score_diff := (real)right.MV361006_1_0_score	-(real)left.MV361006_1_0_score	;
self.MX361006_0_0_score_baseline := (real)left.MX361006_0_0_score	;		self.MX361006_0_0_score_new := (real)right.MX361006_0_0_score	;		self.MX361006_0_0_score_diff := (real)right.MX361006_0_0_score	-(real)left.MX361006_0_0_score	;
self.MX361006_1_0_score_baseline := (real)left.MX361006_1_0_score	;		self.MX361006_1_0_score_new := (real)right.MX361006_1_0_score	;		self.MX361006_1_0_score_diff := (real)right.MX361006_1_0_score	-(real)left.MX361006_1_0_score	;
self.RSB801_1_0_score_baseline 	:= (real)left.RSB801_1_0_score	;		self.RSB801_1_0_score_new := (real)right.RSB801_1_0_score	;		self.RSB801_1_0_score_diff := (real)right.RSB801_1_0_score	-(real)left.RSB801_1_0_score	;
self.RSN1001_1_0_score_baseline := (real)left.RSN1001_1_0_score	;		self.RSN1001_1_0_score_new := (real)right.RSN1001_1_0_score	;		self.RSN1001_1_0_score_diff := (real)right.RSN1001_1_0_score	-(real)left.RSN1001_1_0_score	;
self.RSN1009_1_0_score_baseline := (real)left.RSN1009_1_0_score	;		self.RSN1009_1_0_score_new := (real)right.RSN1009_1_0_score	;		self.RSN1009_1_0_score_diff := (real)right.RSN1009_1_0_score	-(real)left.RSN1009_1_0_score	;
self.RSN1010_1_0_score_baseline := (real)left.RSN1010_1_0_score	;		self.RSN1010_1_0_score_new := (real)right.RSN1010_1_0_score	;		self.RSN1010_1_0_score_diff := (real)right.RSN1010_1_0_score	-(real)left.RSN1010_1_0_score	;
self.RSN1103_1_0_score_baseline := (real)left.RSN1103_1_0_score	;		self.RSN1103_1_0_score_new := (real)right.RSN1103_1_0_score	;		self.RSN1103_1_0_score_diff := (real)right.RSN1103_1_0_score	-(real)left.RSN1103_1_0_score	;
self.RSN1105_1_0_score_baseline := (real)left.RSN1105_1_0_score	;		self.RSN1105_1_0_score_new := (real)right.RSN1105_1_0_score	;		self.RSN1105_1_0_score_diff := (real)right.RSN1105_1_0_score	-(real)left.RSN1105_1_0_score	;
self.RSN1105_2_0_score_baseline := (real)left.RSN1105_2_0_score	;		self.RSN1105_2_0_score_new := (real)right.RSN1105_2_0_score	;		self.RSN1105_2_0_score_diff := (real)right.RSN1105_2_0_score	-(real)left.RSN1105_2_0_score	;
self.RSN1105_3_0_score_baseline := (real)left.RSN1105_3_0_score	;		self.RSN1105_3_0_score_new := (real)right.RSN1105_3_0_score	;		self.RSN1105_3_0_score_diff := (real)right.RSN1105_3_0_score	-(real)left.RSN1105_3_0_score	;
self.RSN1108_1_0_score_baseline := (real)left.RSN1108_1_0_score	;		self.RSN1108_1_0_score_new := (real)right.RSN1108_1_0_score	;		self.RSN1108_1_0_score_diff := (real)right.RSN1108_1_0_score	-(real)left.RSN1108_1_0_score	;
self.RSN1108_2_0_score_baseline := (real)left.RSN1108_2_0_score	;		self.RSN1108_2_0_score_new := (real)right.RSN1108_2_0_score	;		self.RSN1108_2_0_score_diff := (real)right.RSN1108_2_0_score	-(real)left.RSN1108_2_0_score	;
self.RSN1108_3_0_score_baseline := (real)left.RSN1108_3_0_score	;		self.RSN1108_3_0_score_new := (real)right.RSN1108_3_0_score	;		self.RSN1108_3_0_score_diff := (real)right.RSN1108_3_0_score	-(real)left.RSN1108_3_0_score	;
self.RSN508_1_0_score_baseline 	:= (real)left.RSN508_1_0_score	;		self.RSN508_1_0_score_new := (real)right.RSN508_1_0_score	;		self.RSN508_1_0_score_diff := (real)right.RSN508_1_0_score	-(real)left.RSN508_1_0_score	;
self.RSN509_1_0_score_baseline 	:= (real)left.RSN509_1_0_score	;		self.RSN509_1_0_score_new := (real)right.RSN509_1_0_score	;		self.RSN509_1_0_score_diff := (real)right.RSN509_1_0_score	-(real)left.RSN509_1_0_score	;
self.RSN509_2_0_score_baseline 	:= (real)left.RSN509_2_0_score	;		self.RSN509_2_0_score_new := (real)right.RSN509_2_0_score	;		self.RSN509_2_0_score_diff := (real)right.RSN509_2_0_score	-(real)left.RSN509_2_0_score	;
self.RSN604_2_0_score_baseline 	:= (real)left.RSN604_2_0_score	;		self.RSN604_2_0_score_new := (real)right.RSN604_2_0_score	;		self.RSN604_2_0_score_diff := (real)right.RSN604_2_0_score	-(real)left.RSN604_2_0_score	;
self.RSN607_0_0_score_baseline 	:= (real)left.RSN607_0_0_score	;		self.RSN607_0_0_score_new := (real)right.RSN607_0_0_score	;		self.RSN607_0_0_score_diff := (real)right.RSN607_0_0_score	-(real)left.RSN607_0_0_score	;
self.RSN607_1_0_score_baseline 	:= (real)left.RSN607_1_0_score	;		self.RSN607_1_0_score_new := (real)right.RSN607_1_0_score	;		self.RSN607_1_0_score_diff := (real)right.RSN607_1_0_score	-(real)left.RSN607_1_0_score	;
self.RSN702_1_0_score_baseline 	:= (real)left.RSN702_1_0_score	;		self.RSN702_1_0_score_new := (real)right.RSN702_1_0_score	;		self.RSN702_1_0_score_diff := (real)right.RSN702_1_0_score	-(real)left.RSN702_1_0_score	;
self.RSN704_0_0_score_baseline 	:= (real)left.RSN704_0_0_score	;		self.RSN704_0_0_score_new := (real)right.RSN704_0_0_score	;		self.RSN704_0_0_score_diff := (real)right.RSN704_0_0_score	-(real)left.RSN704_0_0_score	;
self.RSN704_1_0_score_baseline 	:= (real)left.RSN704_1_0_score	;		self.RSN704_1_0_score_new := (real)right.RSN704_1_0_score	;		self.RSN704_1_0_score_diff := (real)right.RSN704_1_0_score	-(real)left.RSN704_1_0_score	;
self.RSN802_1_0_score_baseline 	:= (real)left.RSN802_1_0_score	;		self.RSN802_1_0_score_new := (real)right.RSN802_1_0_score	;		self.RSN802_1_0_score_diff := (real)right.RSN802_1_0_score	-(real)left.RSN802_1_0_score	;
self.RSN803_1_0_score_baseline 	:= (real)left.RSN803_1_0_score	;		self.RSN803_1_0_score_new := (real)right.RSN803_1_0_score	;		self.RSN803_1_0_score_diff := (real)right.RSN803_1_0_score	-(real)left.RSN803_1_0_score	;
self.RSN803_2_0_score_baseline 	:= (real)left.RSN803_2_0_score	;		self.RSN803_2_0_score_new := (real)right.RSN803_2_0_score	;		self.RSN803_2_0_score_diff := (real)right.RSN803_2_0_score	-(real)left.RSN803_2_0_score	;
self.RSN804_1_0_score_baseline 	:= (real)left.RSN804_1_0_score	;		self.RSN804_1_0_score_new := (real)right.RSN804_1_0_score	;		self.RSN804_1_0_score_diff := (real)right.RSN804_1_0_score	-(real)left.RSN804_1_0_score	;
self.RSN807_0_0_score_baseline 	:= (real)left.RSN807_0_0_score	;		self.RSN807_0_0_score_new := (real)right.RSN807_0_0_score	;		self.RSN807_0_0_score_diff := (real)right.RSN807_0_0_score	-(real)left.RSN807_0_0_score	;
self.RSN810_1_0_score_baseline 	:= (real)left.RSN810_1_0_score	;		self.RSN810_1_0_score_new := (real)right.RSN810_1_0_score	;		self.RSN810_1_0_score_diff := (real)right.RSN810_1_0_score	-(real)left.RSN810_1_0_score	;
self.RSN912_1_0_score_baseline 	:= (real)left.RSN912_1_0_score	;		self.RSN912_1_0_score_new := (real)right.RSN912_1_0_score	;		self.RSN912_1_0_score_diff := (real)right.RSN912_1_0_score	-(real)left.RSN912_1_0_score	;
self.RVA1003_0_0_score_baseline := (real)left.RVA1003_0_0_score	;		self.RVA1003_0_0_score_new := (real)right.RVA1003_0_0_score	;		self.RVA1003_0_0_score_diff := (real)right.RVA1003_0_0_score	-(real)left.RVA1003_0_0_score	;
self.RVA1007_1_0_score_baseline := (real)left.RVA1007_1_0_score	;		self.RVA1007_1_0_score_new := (real)right.RVA1007_1_0_score	;		self.RVA1007_1_0_score_diff := (real)right.RVA1007_1_0_score	-(real)left.RVA1007_1_0_score	;
self.RVA1007_2_0_score_baseline := (real)left.RVA1007_2_0_score	;		self.RVA1007_2_0_score_new := (real)right.RVA1007_2_0_score	;		self.RVA1007_2_0_score_diff := (real)right.RVA1007_2_0_score	-(real)left.RVA1007_2_0_score	;
self.RVA1007_3_0_score_baseline := (real)left.RVA1007_3_0_score	;		self.RVA1007_3_0_score_new := (real)right.RVA1007_3_0_score	;		self.RVA1007_3_0_score_diff := (real)right.RVA1007_3_0_score	-(real)left.RVA1007_3_0_score	;
self.RVA1008_1_0_score_baseline := (real)left.RVA1008_1_0_score	;		self.RVA1008_1_0_score_new := (real)right.RVA1008_1_0_score	;		self.RVA1008_1_0_score_diff := (real)right.RVA1008_1_0_score	-(real)left.RVA1008_1_0_score	;
self.RVA1008_2_0_score_baseline := (real)left.RVA1008_2_0_score	;		self.RVA1008_2_0_score_new := (real)right.RVA1008_2_0_score	;		self.RVA1008_2_0_score_diff := (real)right.RVA1008_2_0_score	-(real)left.RVA1008_2_0_score	;
self.RVA1104_0_0_score_baseline := (real)left.RVA1104_0_0_score	;		self.RVA1104_0_0_score_new := (real)right.RVA1104_0_0_score	;		self.RVA1104_0_0_score_diff := (real)right.RVA1104_0_0_score	-(real)left.RVA1104_0_0_score	;
self.RVA1304_1_0_score_baseline := (real)left.RVA1304_1_0_score	;		self.RVA1304_1_0_score_new := (real)right.RVA1304_1_0_score	;		self.RVA1304_1_0_score_diff := (real)right.RVA1304_1_0_score	-(real)left.RVA1304_1_0_score	;
self.RVA1304_2_0_score_baseline := (real)left.RVA1304_2_0_score	;		self.RVA1304_2_0_score_new := (real)right.RVA1304_2_0_score	;		self.RVA1304_2_0_score_diff := (real)right.RVA1304_2_0_score	-(real)left.RVA1304_2_0_score	;
self.RVA611_0_0_score_baseline 	:= (real)left.RVA611_0_0_score	;		self.RVA611_0_0_score_new := (real)right.RVA611_0_0_score	;		self.RVA611_0_0_score_diff := (real)right.RVA611_0_0_score	-(real)left.RVA611_0_0_score	;
self.RVA707_0_0_score_baseline 	:= (real)left.RVA707_0_0_score	;		self.RVA707_0_0_score_new := (real)right.RVA707_0_0_score	;		self.RVA707_0_0_score_diff := (real)right.RVA707_0_0_score	-(real)left.RVA707_0_0_score	;
self.RVA707_1_0_score_baseline 	:= (real)left.RVA707_1_0_score	;		self.RVA707_1_0_score_new := (real)right.RVA707_1_0_score	;		self.RVA707_1_0_score_diff := (real)right.RVA707_1_0_score	-(real)left.RVA707_1_0_score	;
self.RVA709_1_0_score_baseline 	:= (real)left.RVA709_1_0_score	;		self.RVA709_1_0_score_new := (real)right.RVA709_1_0_score	;		self.RVA709_1_0_score_diff := (real)right.RVA709_1_0_score	-(real)left.RVA709_1_0_score	;
// self.RVA711_0_0_score_baseline 	:= (real)left.RVA711_0_0_score	;		self.RVA711_0_0_score_new := (real)right.RVA711_0_0_score	;		self.RVA711_0_0_score_diff := (real)right.RVA711_0_0_score	-(real)left.RVA711_0_0_score	;
self.RVA1611_1_0_score_baseline := (real)left.RVA1611_1_0_score	;		self.RVA1611_1_0_score_new := (real)right.RVA1611_1_0_score	;		self.RVA1611_1_0_score_diff := (real)right.RVA1611_1_0_score	-(real)left.RVA1611_1_0_score	;
self.RVA1611_2_0_score_baseline := (real)left.RVA1611_2_0_score	;		self.RVA1611_2_0_score_new := (real)right.RVA1611_2_0_score	;		self.RVA1611_2_0_score_diff := (real)right.RVA1611_2_0_score	-(real)left.RVA1611_2_0_score	;
self.RVB1003_0_0_score_baseline := (real)left.RVB1003_0_0_score	;		self.RVB1003_0_0_score_new := (real)right.RVB1003_0_0_score	;		self.RVB1003_0_0_score_diff := (real)right.RVB1003_0_0_score	-(real)left.RVB1003_0_0_score	;
self.RVB1104_0_0_score_baseline := (real)left.RVB1104_0_0_score	;		self.RVB1104_0_0_score_new := (real)right.RVB1104_0_0_score	;		self.RVB1104_0_0_score_diff := (real)right.RVB1104_0_0_score	-(real)left.RVB1104_0_0_score	;
self.RVB1104_1_0_score_baseline := (real)left.RVB1104_1_0_score	;		self.RVB1104_1_0_score_new := (real)right.RVB1104_1_0_score	;		self.RVB1104_1_0_score_diff := (real)right.RVB1104_1_0_score	-(real)left.RVB1104_1_0_score	;
self.RVB1310_1_0_score_baseline := (real)left.RVB1310_1_0_score	;		self.RVB1310_1_0_score_new := (real)right.RVB1310_1_0_score	;		self.RVB1310_1_0_score_diff := (real)right.RVB1310_1_0_score	-(real)left.RVB1310_1_0_score	;
self.RVB1402_1_0_score_baseline := (real)left.RVB1402_1_0_score	;		self.RVB1402_1_0_score_new := (real)right.RVB1402_1_0_score	;		self.RVB1402_1_0_score_diff := (real)right.RVB1402_1_0_score	-(real)left.RVB1402_1_0_score	;
self.RVB609_0_0_score_baseline 	:= (real)left.RVB609_0_0_score	;		self.RVB609_0_0_score_new := (real)right.RVB609_0_0_score	;		self.RVB609_0_0_score_diff := (real)right.RVB609_0_0_score	-(real)left.RVB609_0_0_score	;
// self.RVB703_1_0_score_baseline 	:= (real)left.RVB703_1_0_score	;		self.RVB703_1_0_score_new := (real)right.RVB703_1_0_score	;		self.RVB703_1_0_score_diff := (real)right.RVB703_1_0_score	-(real)left.RVB703_1_0_score	;
self.RVB705_1_0_score_baseline 	:= (real)left.RVB705_1_0_score	;		self.RVB705_1_0_score_new := (real)right.RVB705_1_0_score	;		self.RVB705_1_0_score_diff := (real)right.RVB705_1_0_score	-(real)left.RVB705_1_0_score	;
// self.RVB711_0_0_score_baseline 	:= (real)left.RVB711_0_0_score	;		self.RVB711_0_0_score_new := (real)right.RVB711_0_0_score	;		self.RVB711_0_0_score_diff := (real)right.RVB711_0_0_score	-(real)left.RVB711_0_0_score	;
self.RVB1610_1_0_score_baseline := (real)left.RVB1610_1_0_score	;		self.RVB1610_1_0_score_new := (real)right.RVB1610_1_0_score	;		self.RVB1610_1_0_score_diff := (real)right.RVB1610_1_0_score	-(real)left.RVB1610_1_0_score	;
self.RVC1110_1_0_score_baseline := (real)left.RVC1110_1_0_score	;		self.RVC1110_1_0_score_new := (real)right.RVC1110_1_0_score	;		self.RVC1110_1_0_score_diff := (real)right.RVC1110_1_0_score	-(real)left.RVC1110_1_0_score	;
self.RVC1110_2_0_score_baseline := (real)left.RVC1110_2_0_score	;		self.RVC1110_2_0_score_new := (real)right.RVC1110_2_0_score	;		self.RVC1110_2_0_score_diff := (real)right.RVC1110_2_0_score	-(real)left.RVC1110_2_0_score	;
self.RVC1112_0_0_score_baseline := (real)left.RVC1112_0_0_score	;		self.RVC1112_0_0_score_new := (real)right.RVC1112_0_0_score	;		self.RVC1112_0_0_score_diff := (real)right.RVC1112_0_0_score	-(real)left.RVC1112_0_0_score	;
self.RVC1208_1_0_score_baseline := (real)left.RVC1208_1_0_score	;		self.RVC1208_1_0_score_new := (real)right.RVC1208_1_0_score	;		self.RVC1208_1_0_score_diff := (real)right.RVC1208_1_0_score	-(real)left.RVC1208_1_0_score	;
self.RVC1210_1_0_score_baseline := (real)left.RVC1210_1_0_score	;		self.RVC1210_1_0_score_new := (real)right.RVC1210_1_0_score	;		self.RVC1210_1_0_score_diff := (real)right.RVC1210_1_0_score	-(real)left.RVC1210_1_0_score	;
self.RVC1301_1_0_score_baseline := (real)left.RVC1301_1_0_score	;		self.RVC1301_1_0_score_new := (real)right.RVC1301_1_0_score	;		self.RVC1301_1_0_score_diff := (real)right.RVC1301_1_0_score	-(real)left.RVC1301_1_0_score	;
self.RVD1010_0_0_score_baseline := (real)left.RVD1010_0_0_score	;		self.RVD1010_0_0_score_new := (real)right.RVD1010_0_0_score	;		self.RVD1010_0_0_score_diff := (real)right.RVD1010_0_0_score	-(real)left.RVD1010_0_0_score	;
self.RVD1010_1_0_score_baseline := (real)left.RVD1010_1_0_score	;		self.RVD1010_1_0_score_new := (real)right.RVD1010_1_0_score	;		self.RVD1010_1_0_score_diff := (real)right.RVD1010_1_0_score	-(real)left.RVD1010_1_0_score	;
self.RVD1010_2_0_score_baseline := (real)left.RVD1010_2_0_score	;		self.RVD1010_2_0_score_new := (real)right.RVD1010_2_0_score	;		self.RVD1010_2_0_score_diff := (real)right.RVD1010_2_0_score	-(real)left.RVD1010_2_0_score	;
self.RVD1110_1_0_score_baseline := (real)left.RVD1110_1_0_score	;		self.RVD1110_1_0_score_new := (real)right.RVD1110_1_0_score	;		self.RVD1110_1_0_score_diff := (real)right.RVD1110_1_0_score	-(real)left.RVD1110_1_0_score	;
self.RVG1003_0_0_score_baseline := (real)left.RVG1003_0_0_score	;		self.RVG1003_0_0_score_new := (real)right.RVG1003_0_0_score	;		self.RVG1003_0_0_score_diff := (real)right.RVG1003_0_0_score	-(real)left.RVG1003_0_0_score	;
self.RVG1103_0_0_score_baseline := (real)left.RVG1103_0_0_score	;		self.RVG1103_0_0_score_new := (real)right.RVG1103_0_0_score	;		self.RVG1103_0_0_score_diff := (real)right.RVG1103_0_0_score	-(real)left.RVG1103_0_0_score	;
self.RVG1106_1_0_score_baseline := (real)left.RVG1106_1_0_score	;		self.RVG1106_1_0_score_new := (real)right.RVG1106_1_0_score	;		self.RVG1106_1_0_score_diff := (real)right.RVG1106_1_0_score	-(real)left.RVG1106_1_0_score	;
self.RVG1201_1_0_score_baseline := (real)left.RVG1201_1_0_score	;		self.RVG1201_1_0_score_new := (real)right.RVG1201_1_0_score	;		self.RVG1201_1_0_score_diff := (real)right.RVG1201_1_0_score	-(real)left.RVG1201_1_0_score	;
self.RVG1302_1_0_score_baseline := (real)left.RVG1302_1_0_score	;		self.RVG1302_1_0_score_new := (real)right.RVG1302_1_0_score	;		self.RVG1302_1_0_score_diff := (real)right.RVG1302_1_0_score	-(real)left.RVG1302_1_0_score	;
self.RVG1304_1_0_score_baseline := (real)left.RVG1304_1_0_score	;		self.RVG1304_1_0_score_new := (real)right.RVG1304_1_0_score	;		self.RVG1304_1_0_score_diff := (real)right.RVG1304_1_0_score	-(real)left.RVG1304_1_0_score	;
self.RVG1304_2_0_score_baseline := (real)left.RVG1304_2_0_score	;		self.RVG1304_2_0_score_new := (real)right.RVG1304_2_0_score	;		self.RVG1304_2_0_score_diff := (real)right.RVG1304_2_0_score	-(real)left.RVG1304_2_0_score	;
self.RVG812_0_0_score_baseline 	:= (real)left.RVG812_0_0_score	;		self.RVG812_0_0_score_new := (real)right.RVG812_0_0_score	;		self.RVG812_0_0_score_diff := (real)right.RVG812_0_0_score	-(real)left.RVG812_0_0_score	;
self.RVG903_1_0_score_baseline 	:= (real)left.RVG903_1_0_score	;		self.RVG903_1_0_score_new := (real)right.RVG903_1_0_score	;		self.RVG903_1_0_score_diff := (real)right.RVG903_1_0_score	-(real)left.RVG903_1_0_score	;
// self.RVG904_1_0_score_baseline 	:= (real)left.RVG904_1_0_score	;		self.RVG904_1_0_score_new := (real)right.RVG904_1_0_score	;		self.RVG904_1_0_score_diff := (real)right.RVG904_1_0_score	-(real)left.RVG904_1_0_score	;
// self.RVP1003_0_0_score_baseline := (real)left.RVP1003_0_0_score	;		self.RVP1003_0_0_score_new := (real)right.RVP1003_0_0_score	;		self.RVP1003_0_0_score_diff := (real)right.RVP1003_0_0_score	-(real)left.RVP1003_0_0_score	;
self.RVP1012_1_0_score_baseline := (real)left.RVP1012_1_0_score	;		self.RVP1012_1_0_score_new := (real)right.RVP1012_1_0_score	;		self.RVP1012_1_0_score_diff := (real)right.RVP1012_1_0_score	-(real)left.RVP1012_1_0_score	;
// self.RVP1104_0_0_score_baseline := (real)left.RVP1104_0_0_score	;		self.RVP1104_0_0_score_new := (real)right.RVP1104_0_0_score	;		self.RVP1104_0_0_score_diff := (real)right.RVP1104_0_0_score	-(real)left.RVP1104_0_0_score	;
self.RVP1208_1_0_score_baseline := (real)left.RVP1208_1_0_score	;		self.RVP1208_1_0_score_new := (real)right.RVP1208_1_0_score	;		self.RVP1208_1_0_score_diff := (real)right.RVP1208_1_0_score	-(real)left.RVP1208_1_0_score	;
self.RVP1401_1_0_score_baseline := (real)left.RVP1401_1_0_score	;		self.RVP1401_1_0_score_new := (real)right.RVP1401_1_0_score	;		self.RVP1401_1_0_score_diff := (real)right.RVP1401_1_0_score	-(real)left.RVP1401_1_0_score	;
self.RVP1401_2_0_score_baseline := (real)left.RVP1401_2_0_score	;		self.RVP1401_2_0_score_new := (real)right.RVP1401_2_0_score	;		self.RVP1401_2_0_score_diff := (real)right.RVP1401_2_0_score	-(real)left.RVP1401_2_0_score	;
self.RVP1503_1_0_score_baseline := (real)left.RVP1503_1_0_score	;		self.RVP1503_1_0_score_new := (real)right.RVP1503_1_0_score	;		self.RVP1503_1_0_score_diff := (real)right.RVP1503_1_0_score	-(real)left.RVP1503_1_0_score	;
// self.RVP804_0_0_score_baseline 	:= (real)left.RVP804_0_0_score	;		self.RVP804_0_0_score_new := (real)right.RVP804_0_0_score	;		self.RVP804_0_0_score_diff := (real)right.RVP804_0_0_score	-(real)left.RVP804_0_0_score	;
self.RVP1702_1_0_score_baseline := (real)left.RVP1702_1_0_score	;		self.RVP1702_1_0_score_new := (real)right.RVP1702_1_0_score	;		self.RVP1702_1_0_score_diff := (real)right.RVP1702_1_0_score	-(real)left.RVP1702_1_0_score	;
// self.RVR1003_0_0_score_baseline := (real)left.RVR1003_0_0_score	;		self.RVR1003_0_0_score_new := (real)right.RVR1003_0_0_score	;		self.RVR1003_0_0_score_diff := (real)right.RVR1003_0_0_score	-(real)left.RVR1003_0_0_score	;
self.RVR1008_1_0_score_baseline := (real)left.RVR1008_1_0_score	;		self.RVR1008_1_0_score_new := (real)right.RVR1008_1_0_score	;		self.RVR1008_1_0_score_diff := (real)right.RVR1008_1_0_score	-(real)left.RVR1008_1_0_score	;
self.RVR1103_0_0_score_baseline := (real)left.RVR1103_0_0_score	;		self.RVR1103_0_0_score_new := (real)right.RVR1103_0_0_score	;		self.RVR1103_0_0_score_diff := (real)right.RVR1103_0_0_score	-(real)left.RVR1103_0_0_score	;
self.RVR1104_2_0_score_baseline := (real)left.RVR1104_2_0_score	;		self.RVR1104_2_0_score_new := (real)right.RVR1104_2_0_score	;		self.RVR1104_2_0_score_diff := (real)right.RVR1104_2_0_score	-(real)left.RVR1104_2_0_score	;
//self.RVR1104_3_0_score_baseline 	:= (real)left.RVR1104_3_0_score	;		self.RVR1104_3_0_score_new := (real)right.RVR1104_3_0_score	;		self.RVR1104_3_0_score_diff := (real)right.RVR1104_3_0_score	-(real)left.RVR1104_3_0_score	;
self.RVR1210_1_0_score_baseline := (real)left.RVR1210_1_0_score	;		self.RVR1210_1_0_score_new := (real)right.RVR1210_1_0_score	;		self.RVR1210_1_0_score_diff := (real)right.RVR1210_1_0_score	-(real)left.RVR1210_1_0_score	;
self.RVR1303_1_0_score_baseline := (real)left.RVR1303_1_0_score	;		self.RVR1303_1_0_score_new := (real)right.RVR1303_1_0_score	;		self.RVR1303_1_0_score_diff := (real)right.RVR1303_1_0_score	-(real)left.RVR1303_1_0_score	;
// self.RVR611_0_0_score_baseline 	:= (real)left.RVR611_0_0_score	;		self.RVR611_0_0_score_new := (real)right.RVR611_0_0_score	;		self.RVR611_0_0_score_diff := (real)right.RVR611_0_0_score	-(real)left.RVR611_0_0_score	;
self.RVR704_1_0_score_baseline 	:= (real)left.RVR704_1_0_score	;		self.RVR704_1_0_score_new := (real)right.RVR704_1_0_score	;		self.RVR704_1_0_score_diff := (real)right.RVR704_1_0_score	-(real)left.RVR704_1_0_score	;
// self.RVR711_0_0_score_baseline 	:= (real)left.RVR711_0_0_score	;		self.RVR711_0_0_score_new := (real)right.RVR711_0_0_score	;		self.RVR711_0_0_score_diff := (real)right.RVR711_0_0_score	-(real)left.RVR711_0_0_score	;
self.RVR803_1_0_score_baseline 	:= (real)left.RVR803_1_0_score	;		self.RVR803_1_0_score_new := (real)right.RVR803_1_0_score	;		self.RVR803_1_0_score_diff := (real)right.RVR803_1_0_score	-(real)left.RVR803_1_0_score	;
self.RVS811_0_0_score_baseline 	:= (real)left.RVS811_0_0_score	;		self.RVS811_0_0_score_new := (real)right.RVS811_0_0_score	;		self.RVS811_0_0_score_diff := (real)right.RVS811_0_0_score	-(real)left.RVS811_0_0_score	;
self.RVS1706_0_score_baseline 	:= (real)left.RVS1706_0_score	;		self.RVS1706_0_score_new := (real)right.RVS1706_0_score	;		self.RVS1706_0_score_diff := (real)right.RVS1706_0_score	-(real)left.RVS1706_0_score	;
self.RVT1003_0_0_score_baseline := (real)left.RVT1003_0_0_score	;		self.RVT1003_0_0_score_new := (real)right.RVT1003_0_0_score	;		self.RVT1003_0_0_score_diff := (real)right.RVT1003_0_0_score	-(real)left.RVT1003_0_0_score	;
// self.RVT1006_1_0_score_baseline := (real)left.RVT1006_1_0_score	;		self.RVT1006_1_0_score_new := (real)right.RVT1006_1_0_score	;		self.RVT1006_1_0_score_diff := (real)right.RVT1006_1_0_score	-(real)left.RVT1006_1_0_score	;
self.RVT1104_0_0_score_baseline := (real)left.RVT1104_0_0_score	;		self.RVT1104_0_0_score_new := (real)right.RVT1104_0_0_score	;		self.RVT1104_0_0_score_diff := (real)right.RVT1104_0_0_score	-(real)left.RVT1104_0_0_score	;
self.RVT1104_1_0_score_baseline := (real)left.RVT1104_1_0_score	;		self.RVT1104_1_0_score_new := (real)right.RVT1104_1_0_score	;		self.RVT1104_1_0_score_diff := (real)right.RVT1104_1_0_score	-(real)left.RVT1104_1_0_score	;
self.RVT1204_1_score_baseline 	:= (real)left.RVT1204_1_score	;		self.RVT1204_1_score_new := (real)right.RVT1204_1_score	;		self.RVT1204_1_score_diff := (real)right.RVT1204_1_score	-(real)left.RVT1204_1_score	;
self.RVT1210_1_0_score_baseline := (real)left.RVT1210_1_0_score	;		self.RVT1210_1_0_score_new := (real)right.RVT1210_1_0_score	;		self.RVT1210_1_0_score_diff := (real)right.RVT1210_1_0_score	-(real)left.RVT1210_1_0_score	;
self.RVT1212_1_0_score_baseline := (real)left.RVT1212_1_0_score	;		self.RVT1212_1_0_score_new := (real)right.RVT1212_1_0_score	;		self.RVT1212_1_0_score_diff := (real)right.RVT1212_1_0_score	-(real)left.RVT1212_1_0_score	;
// self.RVT612_0_score_baseline 	:= (real)left.RVT612_0_score	;		self.RVT612_0_score_new := (real)right.RVT612_0_score	;		self.RVT612_0_score_diff := (real)right.RVT612_0_score	-(real)left.RVT612_0_score	;
// self.RVT711_0_0_score_baseline 	:= (real)left.RVT711_0_0_score	;		self.RVT711_0_0_score_new := (real)right.RVT711_0_0_score	;		self.RVT711_0_0_score_diff := (real)right.RVT711_0_0_score	-(real)left.RVT711_0_0_score	;
self.RVT711_1_0_score_baseline 	:= (real)left.RVT711_1_0_score	;		self.RVT711_1_0_score_new := (real)right.RVT711_1_0_score	;		self.RVT711_1_0_score_diff := (real)right.RVT711_1_0_score	-(real)left.RVT711_1_0_score	;
// self.RVT803_1_0_score_baseline 	:= (real)left.RVT803_1_0_score	;		self.RVT803_1_0_score_new := (real)right.RVT803_1_0_score	;		self.RVT803_1_0_score_diff := (real)right.RVT803_1_0_score	-(real)left.RVT803_1_0_score	;
// self.RVT809_1_0_score_baseline 	:= (real)left.RVT809_1_0_score	;		self.RVT809_1_0_score_new := (real)right.RVT809_1_0_score	;		self.RVT809_1_0_score_diff := (real)right.RVT809_1_0_score	-(real)left.RVT809_1_0_score	;
self.RVT1605_1_0_score_baseline 	:= (real)left.RVT1605_1_0_score	;		self.RVT1605_1_0_score_new := (real)right.RVT1605_1_0_score	;		self.RVT1605_1_0_score_diff := (real)right.RVT1605_1_0_score	-(real)left.RVT1605_1_0_score	;
self.RVT1605_2_0_score_baseline 	:= (real)left.RVT1605_2_0_score	;		self.RVT1605_2_0_score_new := (real)right.RVT1605_2_0_score	;		self.RVT1605_2_0_score_diff := (real)right.RVT1605_2_0_score	-(real)left.RVT1605_2_0_score	;
self.RVT1608_1_0_score_baseline 	:= (real)left.RVT1608_1_0_score	;		self.RVT1608_1_0_score_new := (real)right.RVT1608_1_0_score	;		self.RVT1608_1_0_score_diff := (real)right.RVT1608_1_0_score	-(real)left.RVT1608_1_0_score	;
self.RVT1608_2_score_baseline 	  := (real)left.RVT1608_2_score	;		  self.RVT1608_2_score_new   := (real)right.RVT1608_2_score	;		  self.RVT1608_2_score_diff   := (real)right.RVT1608_2_score	  -(real)left.RVT1608_2_score	;
self.RVT1705_1_0_score_baseline 	:= (real)left.RVT1705_1_0_score	;		self.RVT1705_1_0_score_new := (real)right.RVT1705_1_0_score	;		self.RVT1705_1_0_score_diff := (real)right.RVT1705_1_0_score	-(real)left.RVT1705_1_0_score	;
// self.TBD605_0_0_score_baseline 	:= (real)left.TBD605_0_0_score	;		self.TBD605_0_0_score_new := (real)right.TBD605_0_0_score	;		self.TBD605_0_0_score_diff := (real)right.TBD605_0_0_score	-(real)left.TBD605_0_0_score	;
// self.TBD609_1_0_score_baseline 	:= (real)left.TBD609_1_0_score	;		self.TBD609_1_0_score_new := (real)right.TBD609_1_0_score	;		self.TBD609_1_0_score_diff := (real)right.TBD609_1_0_score	-(real)left.TBD609_1_0_score	;
// self.TBD609_2_0_score_baseline 	:= (real)left.TBD609_2_0_score	;		self.TBD609_2_0_score_new := (real)right.TBD609_2_0_score	;		self.TBD609_2_0_score_diff := (real)right.TBD609_2_0_score	-(real)left.TBD609_2_0_score	;
self.TBN509_0_0_score_baseline 	:= (real)left.TBN509_0_0_score	;		self.TBN509_0_0_score_new := (real)right.TBN509_0_0_score	;		self.TBN509_0_0_score_diff := (real)right.TBN509_0_0_score	-(real)left.TBN509_0_0_score	;
self.TBN604_1_0_score_baseline 	:= (real)left.TBN604_1_0_score	;		self.TBN604_1_0_score_new := (real)right.TBN604_1_0_score	;		self.TBN604_1_0_score_diff := (real)right.TBN604_1_0_score	-(real)left.TBN604_1_0_score	;
// self.TRD605_0_0_score_baseline 	:= (real)left.TRD605_0_0_score	;		self.TRD605_0_0_score_new := (real)right.TRD605_0_0_score	;		self.TRD605_0_0_score_diff := (real)right.TRD605_0_0_score	-(real)left.TRD605_0_0_score	;
// self.TRD609_1_0_score_baseline 	:= (real)left.TRD609_1_0_score	;		self.TRD609_1_0_score_new := (real)right.TRD609_1_0_score	;		self.TRD609_1_0_score_diff := (real)right.TRD609_1_0_score	-(real)left.TRD609_1_0_score	;
self.WIN704_0_0_score_baseline 	:= (real)left.WIN704_0_0_score	;		self.WIN704_0_0_score_new := (real)right.WIN704_0_0_score	;		self.WIN704_0_0_score_diff := (real)right.WIN704_0_0_score	-(real)left.WIN704_0_0_score	;
self.WOMV002_0_0_score_baseline := (real)left.WOMV002_0_0_score	;		self.WOMV002_0_0_score_new := (real)right.WOMV002_0_0_score	;		self.WOMV002_0_0_score_diff := (real)right.WOMV002_0_0_score	-(real)left.WOMV002_0_0_score	;
self.WWN604_1_0_score_baseline 	:= (real)left.WWN604_1_0_score	;		self.WWN604_1_0_score_new := (real)right.WWN604_1_0_score	;		self.WWN604_1_0_score_diff := (real)right.WWN604_1_0_score	-(real)left.WWN604_1_0_score	;
self.RVC1307_1_0_score_baseline := (real)left.RVC1307_1_0_score	;		self.RVC1307_1_0_score_new := (real)right.RVC1307_1_0_score	;		self.RVC1307_1_0_score_diff := (real)right.RVC1307_1_0_score	-(real)left.RVC1307_1_0_score	;
self.RVC1405_1_0_score_baseline := (real)left.RVC1405_1_0_score	;		self.RVC1405_1_0_score_new := (real)right.RVC1405_1_0_score	;		self.RVC1405_1_0_score_diff := (real)right.RVC1405_1_0_score	-(real)left.RVC1405_1_0_score	;
self.RVC1405_2_0_score_baseline := (real)left.RVC1405_2_0_score	;		self.RVC1405_2_0_score_new := (real)right.RVC1405_2_0_score	;		self.RVC1405_2_0_score_diff := (real)right.RVC1405_2_0_score	-(real)left.RVC1405_2_0_score	;
self.RVC1405_3_0_score_baseline := (real)left.RVC1405_3_0_score	;		self.RVC1405_3_0_score_new := (real)right.RVC1405_3_0_score	;		self.RVC1405_3_0_score_diff := (real)right.RVC1405_3_0_score	-(real)left.RVC1405_3_0_score	;
self.RVC1405_4_0_score_baseline := (real)left.RVC1405_4_0_score	;		self.RVC1405_4_0_score_new := (real)right.RVC1405_4_0_score	;		self.RVC1405_4_0_score_diff := (real)right.RVC1405_4_0_score	-(real)left.RVC1405_4_0_score	;
self.RVC1412_1_0_score_baseline := (real)left.RVC1412_1_0_score	;		self.RVC1412_1_0_score_new := (real)right.RVC1412_1_0_score	;		self.RVC1412_1_0_score_diff := (real)right.RVC1412_1_0_score	-(real)left.RVC1412_1_0_score	;
self.RVC1602_1_0_score_baseline := (real)left.RVC1602_1_0_score	;		self.RVC1602_1_0_score_new := (real)right.RVC1602_1_0_score	;		self.RVC1602_1_0_score_diff := (real)right.RVC1602_1_0_score	-(real)left.RVC1602_1_0_score	;
self.RVC1609_1_0_score_baseline := (real)left.RVC1609_1_0_score	;		self.RVC1609_1_0_score_new := (real)right.RVC1609_1_0_score	;		self.RVC1609_1_0_score_diff := (real)right.RVC1609_1_0_score	-(real)left.RVC1609_1_0_score	;
self.RVC1703_1_0_score_baseline := (real)left.RVC1703_1_0_score	;		self.RVC1703_1_0_score_new := (real)right.RVC1703_1_0_score	;		self.RVC1703_1_0_score_diff := (real)right.RVC1703_1_0_score	-(real)left.RVC1703_1_0_score	;
self.RVC1801_1_0_score_baseline := (real)left.RVC1801_1_0_score	;		self.RVC1801_1_0_score_new := (real)right.RVC1801_1_0_score	;		self.RVC1801_1_0_score_diff := (real)right.RVC1801_1_0_score	-(real)left.RVC1801_1_0_score	;
self.RVC1805_1_0_score_baseline := (real)left.RVC1805_1_0_score	;		self.RVC1805_1_0_score_new := (real)right.RVC1805_1_0_score	;		self.RVC1805_1_0_score_diff := (real)right.RVC1805_1_0_score	-(real)left.RVC1805_1_0_score	;
self.RVC1805_2_0_score_baseline := (real)left.RVC1805_2_0_score	;		self.RVC1805_2_0_score_new := (real)right.RVC1805_2_0_score	;		self.RVC1805_2_0_score_diff := (real)right.RVC1805_2_0_score	-(real)left.RVC1805_2_0_score	;
self.FP1310_1_0_score_baseline 	:= (real)left.FP1310_1_0_score	;		self.FP1310_1_0_score_new := (real)right.FP1310_1_0_score	;		self.FP1310_1_0_score_diff := (real)right.FP1310_1_0_score	-(real)left.FP1310_1_0_score	;
self.FP1401_1_0_score_baseline 	:= (real)left.FP1401_1_0_score	;		self.FP1401_1_0_score_new := (real)right.FP1401_1_0_score	;		self.FP1401_1_0_score_diff := (real)right.FP1401_1_0_score	-(real)left.FP1401_1_0_score	;
self.FP1404_1_0_score_baseline 	:= (real)left.FP1404_1_0_score	;		self.FP1404_1_0_score_new := (real)right.FP1404_1_0_score	;		self.FP1404_1_0_score_diff := (real)right.FP1404_1_0_score	-(real)left.FP1404_1_0_score	;
self.FP1407_1_0_score_baseline 	:= (real)left.FP1407_1_0_score	;		self.FP1407_1_0_score_new := (real)right.FP1407_1_0_score	;		self.FP1407_1_0_score_diff := (real)right.FP1407_1_0_score	-(real)left.FP1407_1_0_score	;
self.FP1406_1_0_score_baseline 	:= (real)left.FP1406_1_0_score	;		self.FP1406_1_0_score_new := (real)right.FP1406_1_0_score	;		self.FP1406_1_0_score_diff := (real)right.FP1406_1_0_score	-(real)left.FP1406_1_0_score	;
self.RVA1310_1_0_score_baseline := (real)left.RVA1310_1_0_score	;		self.RVA1310_1_0_score_new := (real)right.RVA1310_1_0_score	;		self.RVA1310_1_0_score_diff := (real)right.RVA1310_1_0_score	-(real)left.RVA1310_1_0_score	;
self.RVA1310_2_0_score_baseline := (real)left.RVA1310_2_0_score	;		self.RVA1310_2_0_score_new := (real)right.RVA1310_2_0_score	;		self.RVA1310_2_0_score_diff := (real)right.RVA1310_2_0_score	-(real)left.RVA1310_2_0_score	;
self.RVA1310_3_0_score_baseline := (real)left.RVA1310_3_0_score	;		self.RVA1310_3_0_score_new := (real)right.RVA1310_3_0_score	;		self.RVA1310_3_0_score_diff := (real)right.RVA1310_3_0_score	-(real)left.RVA1310_3_0_score	;
self.RVT1307_3_0_score_baseline := (real)left.RVT1307_3_0_score	;		self.RVT1307_3_0_score_new := (real)right.RVT1307_3_0_score	;		self.RVT1307_3_0_score_diff := (real)right.RVT1307_3_0_score	-(real)left.RVT1307_3_0_score	;
self.RVT1402_1_0_score_baseline := (real)left.RVT1402_1_0_score	;		self.RVT1402_1_0_score_new := (real)right.RVT1402_1_0_score	;		self.RVT1402_1_0_score_diff := (real)right.RVT1402_1_0_score	-(real)left.RVT1402_1_0_score	;
self.RVA1311_1_0_score_baseline := (real)left.RVA1311_1_0_score	;		self.RVA1311_1_0_score_new := (real)right.RVA1311_1_0_score	;		self.RVA1311_1_0_score_diff := (real)right.RVA1311_1_0_score	-(real)left.RVA1311_1_0_score	;
self.RVA1311_2_0_score_baseline := (real)left.RVA1311_2_0_score	;		self.RVA1311_2_0_score_new := (real)right.RVA1311_2_0_score	;		self.RVA1311_2_0_score_diff := (real)right.RVA1311_2_0_score	-(real)left.RVA1311_2_0_score	;
self.RVA1311_3_0_score_baseline := (real)left.RVA1311_3_0_score	;		self.RVA1311_3_0_score_new := (real)right.RVA1311_3_0_score	;		self.RVA1311_3_0_score_diff := (real)right.RVA1311_3_0_score	-(real)left.RVA1311_3_0_score	;
self.RVA1504_1_0_score_baseline := (real)left.RVA1504_1_0_score	;		self.RVA1504_1_0_score_new := (real)right.RVA1504_1_0_score	;		self.RVA1504_1_0_score_diff := (real)right.RVA1504_1_0_score	-(real)left.RVA1504_1_0_score	;
self.RVA1504_2_0_score_baseline := (real)left.RVA1504_2_0_score	;		self.RVA1504_2_0_score_new := (real)right.RVA1504_2_0_score	;		self.RVA1504_2_0_score_diff := (real)right.RVA1504_2_0_score	-(real)left.RVA1504_2_0_score	;
self.RVG1401_1_0_score_baseline := (real)left.RVG1401_1_0_score	;		self.RVG1401_1_0_score_new := (real)right.RVG1401_1_0_score	;		self.RVG1401_1_0_score_diff := (real)right.RVG1401_1_0_score	-(real)left.RVG1401_1_0_score	;
self.RVG1401_2_0_score_baseline := (real)left.RVG1401_2_0_score	;		self.RVG1401_2_0_score_new := (real)right.RVG1401_2_0_score	;		self.RVG1401_2_0_score_diff := (real)right.RVG1401_2_0_score	-(real)left.RVG1401_2_0_score	;
// self.RVR1311_1_0_score_baseline := (real)left.RVR1311_1_0_score	;		self.RVR1311_1_0_score_new := (real)right.RVR1311_1_0_score	;		self.RVR1311_1_0_score_diff := (real)right.RVR1311_1_0_score	-(real)left.RVR1311_1_0_score	;
self.RVR1410_1_0_score_baseline := (real)left.RVR1410_1_0_score	;		self.RVR1410_1_0_score_new := (real)right.RVR1410_1_0_score	;		self.RVR1410_1_0_score_diff := (real)right.RVR1410_1_0_score	-(real)left.RVR1410_1_0_score	;
self.FP1307_1_0_score_baseline	:= (real)left.FP1307_1_0_score	;		self.FP1307_1_0_score_new := (real)right.FP1307_1_0_score	;		self.FP1307_1_0_score_diff := (real)right.FP1307_1_0_score	-(real)left.FP1307_1_0_score	;
self.FP31310_2_0_score_baseline := (real)left.FP31310_2_0_score	;		self.FP31310_2_0_score_new := (real)right.FP31310_2_0_score	;		self.FP31310_2_0_score_diff := (real)right.FP31310_2_0_score	-(real)left.FP31310_2_0_score	;
self.FP1403_1_0_score_baseline	:= (real)left.FP1403_1_0_score	;		self.FP1403_1_0_score_new := (real)right.FP1403_1_0_score	;		self.FP1403_1_0_score_diff := (real)right.FP1403_1_0_score	-(real)left.FP1403_1_0_score	;
self.RVG1310_1_0_score_baseline	:= (real)left.RVG1310_1_0_score	;		self.RVG1310_1_0_score_new := (real)right.RVG1310_1_0_score	;		self.RVG1310_1_0_score_diff := (real)right.RVG1310_1_0_score	-(real)left.RVG1310_1_0_score	;
self.RVG1404_1_0_score_baseline	:= (real)left.RVG1404_1_0_score	;		self.RVG1404_1_0_score_new := (real)right.RVG1404_1_0_score	;		self.RVG1404_1_0_score_diff := (real)right.RVG1404_1_0_score	-(real)left.RVG1404_1_0_score	;
self.FP1403_2_0_score_baseline	:= (real)left.FP1403_2_0_score	;		self.FP1403_2_0_score_new := (real)right.FP1403_2_0_score	;		self.FP1403_2_0_score_diff := (real)right.FP1403_2_0_score	-(real)left.FP1403_2_0_score	;
self.RVG1502_0_0_score_baseline := (real)left.RVG1502_0_0_score	;		self.RVG1502_0_0_score_new := (real)right.RVG1502_0_0_score	;		self.RVG1502_0_0_score_diff := (real)right.RVG1502_0_0_score	-(real)left.RVG1502_0_0_score	;
self.RVG1601_1_0_score_baseline := (real)left.RVG1601_1_0_score	;		self.RVG1601_1_0_score_new := (real)right.RVG1601_1_0_score	;		self.RVG1601_1_0_score_diff := (real)right.RVG1601_1_0_score	-(real)left.RVG1601_1_0_score	;
self.RVB1503_0_0_score_baseline := (real)left.RVB1503_0_0_score	;		self.RVB1503_0_0_score_new := (real)right.RVB1503_0_0_score	;		self.RVB1503_0_0_score_diff := (real)right.RVB1503_0_0_score	-(real)left.RVB1503_0_0_score	;
self.RVA1503_0_0_score_baseline := (real)left.RVA1503_0_0_score	;		self.RVA1503_0_0_score_new := (real)right.RVA1503_0_0_score	;		self.RVA1503_0_0_score_diff := (real)right.RVA1503_0_0_score	-(real)left.RVA1503_0_0_score	;
self.RVA1601_1_0_score_baseline := (real)left.RVA1601_1_0_score	;		self.RVA1601_1_0_score_new := (real)right.RVA1601_1_0_score	;		self.RVA1601_1_0_score_diff := (real)right.RVA1601_1_0_score	-(real)left.RVA1601_1_0_score	;
self.RVA1603_1_0_score_baseline := (real)left.RVA1603_1_0_score	;		self.RVA1603_1_0_score_new := (real)right.RVA1603_1_0_score	;		self.RVA1603_1_0_score_diff := (real)right.RVA1603_1_0_score	-(real)left.RVA1603_1_0_score	;
self.RVA1605_1_0_score_baseline := (real)left.RVA1605_1_0_score	;		self.RVA1605_1_0_score_new := (real)right.RVA1605_1_0_score	;		self.RVA1605_1_0_score_diff := (real)right.RVA1605_1_0_score	-(real)left.RVA1605_1_0_score	;
self.RVA1607_1_0_score_baseline := (real)left.RVA1607_1_0_score	;		self.RVA1607_1_0_score_new := (real)right.RVA1607_1_0_score	;		self.RVA1607_1_0_score_diff := (real)right.RVA1607_1_0_score	-(real)left.RVA1607_1_0_score	;
self.RVT1503_0_0_score_baseline := (real)left.RVT1503_0_0_score	;		self.RVT1503_0_0_score_new := (real)right.RVT1503_0_0_score	;		self.RVT1503_0_0_score_diff := (real)right.RVT1503_0_0_score	-(real)left.RVT1503_0_0_score	;
self.RVT1601_1_0_score_baseline := (real)left.RVT1601_1_0_score	;		self.RVT1601_1_0_score_new := (real)right.RVT1601_1_0_score	;		self.RVT1601_1_0_score_diff := (real)right.RVT1601_1_0_score	-(real)left.RVT1601_1_0_score	;
self.FP1409_2_0_score_baseline	:= (real)left.FP1409_2_0_score	;		self.FP1409_2_0_score_new := (real)right.FP1409_2_0_score	;		self.FP1409_2_0_score_diff := (real)right.FP1409_2_0_score	-(real)left.FP1409_2_0_score	;
self.FP1506_1_0_score_baseline	:= (real)left.FP1506_1_0_score	;		self.FP1506_1_0_score_new := (real)right.FP1506_1_0_score	;		self.FP1506_1_0_score_diff := (real)right.FP1506_1_0_score	-(real)left.FP1506_1_0_score	;
self.FP1509_1_0_score_baseline	:= (real)left.FP1509_1_0_score	;		self.FP1509_1_0_score_new := (real)right.FP1509_1_0_score	;		self.FP1509_1_0_score_diff := (real)right.FP1509_1_0_score	-(real)left.FP1509_1_0_score	;
self.FP1509_2_0_score_baseline	:= (real)left.FP1509_2_0_score	;		self.FP1509_2_0_score_new := (real)right.FP1509_2_0_score	;		self.FP1509_2_0_score_diff := (real)right.FP1509_2_0_score	-(real)left.FP1509_2_0_score	;
self.FP1510_2_0_score_baseline	:= (real)left.FP1510_2_0_score	;		self.FP1510_2_0_score_new := (real)right.FP1510_2_0_score	;		self.FP1510_2_0_score_diff := (real)right.FP1510_2_0_score	-(real)left.FP1510_2_0_score	;
self.FP1511_1_0_score_baseline	:= (real)left.FP1511_1_0_score	;		self.FP1511_1_0_score_new := (real)right.FP1511_1_0_score	;		self.FP1511_1_0_score_diff := (real)right.FP1511_1_0_score	-(real)left.FP1511_1_0_score	;
self.OSN1504_0_0_score_baseline	:= (real)left.OSN1504_0_0_score	;		self.OSN1504_0_0_score_new := (real)right.OSN1504_0_0_score	;		self.OSN1504_0_0_score_diff := (real)right.OSN1504_0_0_score	-(real)left.OSN1504_0_0_score	;
self.OSN1608_1_0_score_baseline	:= (real)left.OSN1608_1_0_score	;		self.OSN1608_1_0_score_new := (real)right.OSN1608_1_0_score	;		self.OSN1608_1_0_score_diff := (real)right.OSN1608_1_0_score	-(real)left.OSN1608_1_0_score	;
self.OSN1803_1_0_score_baseline	:= (real)left.OSN1803_1_0_score	;		self.OSN1803_1_0_score_new := (real)right.OSN1803_1_0_score	;		self.OSN1803_1_0_score_diff := (real)right.OSN1803_1_0_score	-(real)left.OSN1803_1_0_score	;
self.RVG1511_1_0_score_baseline	:= (real)left.RVG1511_1_0_score	;	  self.RVG1511_1_0_score_new := (real)right.RVG1511_1_0_score	;		self.RVG1511_1_0_score_diff := (real)right.RVG1511_1_0_score	-(real)left.RVG1511_1_0_score	;
self.FP1512_1_0_score_baseline	:= (real)left.FP1512_1_0_score	;		self.FP1512_1_0_score_new := (real)right.FP1512_1_0_score	;		self.FP1512_1_0_score_diff := (real)right.FP1512_1_0_score	-(real)left.FP1512_1_0_score	;
Self.RVC1412_2_0_score_baseline	:= (real)left.RVC1412_2_0_score	;		self.RVC1412_2_0_score_new := (real)right.RVC1412_2_0_score	;		self.RVC1412_2_0_score_diff := (real)right.RVC1412_2_0_score	-(real)left.RVC1412_2_0_score	;
self.RVG1702_1_0_score_baseline := (real)left.RVG1702_1_0_score	;		self.RVG1702_1_0_score_new := (real)right.RVG1702_1_0_score	;		self.RVG1702_1_0_score_diff := (real)right.RVG1702_1_0_score	-(real)left.RVG1702_1_0_score	;
self.RVG1705_1_0_score_baseline := (real)left.RVG1705_1_0_score	;		self.RVG1705_1_0_score_new := (real)right.RVG1705_1_0_score	;		self.RVG1705_1_0_score_diff := (real)right.RVG1705_1_0_score	-(real)left.RVG1705_1_0_score	;
self.RVG1706_1_0_score_baseline := (real)left.RVG1706_1_0_score	;		self.RVG1706_1_0_score_new := (real)right.RVG1706_1_0_score	;		self.RVG1706_1_0_score_diff := (real)right.RVG1706_1_0_score	-(real)left.RVG1706_1_0_score	;
self.RVG1610_1_0_score_baseline := (real)left.RVG1610_1_0_score	;		self.RVG1610_1_0_score_new := (real)right.RVG1610_1_0_score	;		self.RVG1610_1_0_score_diff := (real)right.RVG1610_1_0_score	-(real)left.RVG1610_1_0_score	;
self.RVG1802_1_0_score_baseline := (real)left.RVG1802_1_0_score	;		self.RVG1802_1_0_score_new := (real)right.RVG1802_1_0_score	;		self.RVG1802_1_0_score_diff := (real)right.RVG1802_1_0_score	-(real)left.RVG1802_1_0_score	;
self.RVD1801_1_0_score_baseline := (real)left.RVD1801_1_0_score	;		self.RVD1801_1_0_score_new := (real)right.RVD1801_1_0_score	;		self.RVD1801_1_0_score_diff := (real)right.RVD1801_1_0_score	-(real)left.RVD1801_1_0_score	;
self.FP1801_1_0_score_baseline := (real)left.FP1801_1_0_score	;		self.FP1801_1_0_score_new := (real)right.FP1801_1_0_score	;		self.FP1801_1_0_score_diff := (real)right.FP1801_1_0_score	-(real)left.FP1801_1_0_score	;


self.FP31505_0_0_score_baseline	:= (real)left.FP31505_0_0_score	;		self.FP31505_0_0_score_new := (real)right.FP31505_0_0_score	;		self.FP31505_0_0_score_diff := (real)right.FP31505_0_0_score	-(real)left.FP31505_0_0_score	;
self.FP3FDN1505_0_0_score_baseline	:= (real)left.FP3FDN1505_0_0_score	;		self.FP3FDN1505_0_0_score_new := (real)right.FP3FDN1505_0_0_score	;		self.FP3FDN1505_0_0_score_diff := (real)right.FP3FDN1505_0_0_score	-(real)left.FP3FDN1505_0_0_score	;
self.RVA1811_1_0_score_baseline	:= (real)left.RVA1811_1_0_score	;		self.RVA1811_1_0_score_new := (real)right.RVA1811_1_0_score	;		self.RVA1811_1_0_score_diff := (real)right.RVA1811_1_0_score	-(real)left.RVA1811_1_0_score	;
self.RVG1808_3_0_score_baseline	:= (real)left.RVG1808_3_0_score	;		self.RVG1808_3_0_score_new := (real)right.RVG1808_3_0_score	;		self.RVG1808_3_0_score_diff := (real)right.RVG1808_3_0_score	-(real)left.RVG1808_3_0_score	;
self.RVG1808_1_0_score_baseline	:= (real)left.RVG1808_1_0_score	;		self.RVG1808_1_0_score_new := (real)right.RVG1808_1_0_score	;		self.RVG1808_1_0_score_diff := (real)right.RVG1808_1_0_score	-(real)left.RVG1808_1_0_score	;
self.RVG1808_2_0_score_baseline	:= (real)left.RVG1808_2_0_score	;		self.RVG1808_2_0_score_new := (real)right.RVG1808_2_0_score	;		self.RVG1808_2_0_score_diff := (real)right.RVG1808_2_0_score	-(real)left.RVG1808_2_0_score	;
self.RVA1809_1_0_score_baseline	:= (real)left.RVA1809_1_0_score	;		self.RVA1809_1_0_score_new := (real)right.RVA1809_1_0_score	;		self.RVA1809_1_0_score_diff := (real)right.RVA1809_1_0_score	-(real)left.RVA1809_1_0_score	;
		));

normed_rec := record
	string30 model_name;
	real difference;
end;

normed_rec norm(j le, integer c) := transform
	self.model_name := map(
C= 	1 => 'NAP	',
C= 	2 => 'NAS	',
C= 	3 => 'CVI_score	',
C= 	4 => 'AID605_1_0_score	',
C= 	5 => 'AID606_0_0_score	',
C= 	6 => 'AID606_1_0_score	',
C= 	7 => 'AID607_0_0_score	',
C= 	8 => 'AID607_1_0_score	',
C= 	9 => 'AID607_2_0_score	',
C= 	10 => 'AIN509_0_0_score	',
C= 	11 => 'AIN602_1_0_score	',
C= 	12 => 'AIN605_1_0_score	',
C= 	13 => 'AIN605_2_0_score	',
C= 	14 => 'AIN605_3_0_score	',
C= 	15 => 'AIN801_1_0_score	',
C= 	16 => 'ANMK909_0_1_score	',
C= 	17 => 'AWD605_0_0_score	',
C= 	18 => 'AWD605_2_0_score	',
C= 	19 => 'AWD606_10_0_score	',
C= 	20 => 'AWD606_11_0_score	',
C= 	21 => 'AWD606_1_0_score	',
C= 	22 => 'AWD606_2_0_score	',
C= 	23 => 'AWD606_3_0_score	',
C= 	24 => 'AWD606_4_0_score	',
C= 	25 => 'AWD606_6_0_score	',
C= 	26 => 'AWD606_7_0_score	',
C= 	27 => 'AWD606_8_0_score	',
C= 	28 => 'AWD606_9_0_score	',
C= 	29 => 'AWD710_1_0_score	',
C= 	30 => 'AWN510_0_0_score	',
C= 	31 => 'AWN603_1_0_score	',
C= 	32 => 'BD3605_0_0_score	',
C= 	33 => 'BD5605_0_0_score	',
C= 	34 => 'BD5605_1_0_score	',
C= 	35 => 'BD5605_2_0_score	',
C= 	36 => 'BD5605_3_0_score	',
C= 	37 => 'BD9605_0_0_score	',
C= 	38 => 'BD9605_1_0_score	',
C= 	39 => 'CDN1109_1_0_score	',
C= 	40 => 'CDN1205_1_0_score	',
C= 	41 => 'CDN1305_1_0_score	',
C= 	42 => 'CDN604_0_0_score	',
C= 	43 => 'CDN604_1_0_score	',
C= 	44 => 'CDN604_2_0_score	',
C= 	45 => 'CDN604_3_0_score	',
C= 	46 => 'CDN604_4_0_score	',
C= 	47 => 'CDN605_1_0_score	',
C= 	48 => 'CDN606_2_0_score	',
C= 	49 => 'CDN706_1_0_score	',
C= 	50 => 'CDN707_1_0_score	',
C= 	51 => 'CDN712_0_0_score	',
C= 	52 => 'CDN806_1_0_score	',
//C= 	53 => 'CDN810_1_0_score	',
C= 	54 => 'CDN908_1_0_score	',
C= 	55 => 'CEN509_0_0_score	',
C= 	56 => 'CSN1007_0_0_score	',
C= 	57 => 'FD3510_0_0_score	',
C= 	58 => 'FD3606_0_0_score	',
C= 	59 => 'FD5510_0_0_score	',
C= 	60 => 'FD5603_1_0_score	',
C= 	61 => 'FD5603_2_0_score	',
C= 	62 => 'FD5603_3_0_score	',
C= 	63 => 'FD5607_1_0_score	',
C= 	64 => 'FD5609_1_0_score	',
C= 	65 => 'FD5609_2_0_score	',
C= 	66 => 'FD5709_1_0_score	',
C= 	67 => 'FD9510_0_0_score	',
C= 	68 => 'FD9603_1_0_score	',
C= 	69 => 'FD9603_2_0_score	',
C= 	70 => 'FD9603_3_0_score	',
C= 	71 => 'FD9603_4_0_score	',
C= 	72 => 'FD9604_1_0_score	',
C= 	73 => 'FD9606_0_0_score	',
C= 	74 => 'FD9607_1_0_score	',
C= 	75 => 'FP1109_0_0_score	',
C= 	76 => 'FP1210_1_0_score	',
C= 	77 => 'FP1303_1_0_score	',
C= 	78 => 'FP31105_1_0_score	',
C= 	79 => 'FP31203_1_0_score	',
C= 	79 => 'FP31604_0_0_score	',
C= 	80 => 'FP3710_0_0_score	',
C= 	81 => 'FP3904_1_0_score	',
C= 	82 => 'FP3905_1_0_score	',
C= 	83 => 'FP5812_1_0_score	',
C= 	84 => 'HCP1206_0_0_score	',
C= 	85 => 'IDN605_1_0_score	',
C= 	86 => 'IE912_0_0_score	',
C= 	87 => 'IE912_1_0_score	',
C= 	88 => 'IED1106_1_0_score	',
C= 	89 => 'IEN1006_0_1_score	',
C= 	90 => 'MNC21106_0_0_score	',
C= 	91 => 'MPX1211_0_0_score	',
C= 	92 => 'MSD1010_0_0_score	',
C= 	93 => 'MSN1106_0_0_score	',
C= 	94 => 'MSN605_1_0_score	',
C= 	95 => 'MSN610_0_0_score	',
C= 	96 => 'MV361006_0_0_score	',
C= 	97 => 'MV361006_1_0_score	',
C= 	98 => 'MX361006_0_0_score	',
C= 	99 => 'MX361006_1_0_score	',
C= 	100 => 'RSB801_1_0_score	',
C= 	101 => 'RSN1001_1_0_score	',
C= 	102 => 'RSN1009_1_0_score	',
C= 	103 => 'RSN1010_1_0_score	',
C= 	104 => 'RSN1103_1_0_score	',
C= 	105 => 'RSN1105_1_0_score	',
C= 	106 => 'RSN1105_2_0_score	',
C= 	107 => 'RSN1105_3_0_score	',
C= 	108 => 'RSN1108_1_0_score	',
C= 	109 => 'RSN1108_2_0_score	',
C= 	110 => 'RSN1108_3_0_score	',
C= 	111 => 'RSN508_1_0_score	',
C= 	112 => 'RSN509_1_0_score	',
C= 	113 => 'RSN509_2_0_score	',
C= 	114 => 'RSN604_2_0_score	',
C= 	115 => 'RSN607_0_0_score	',
C= 	116 => 'RSN607_1_0_score	',
C= 	117 => 'RSN702_1_0_score	',
C= 	118 => 'RSN704_0_0_score	',
C= 	119 => 'RSN704_1_0_score	',
C= 	120 => 'RSN802_1_0_score	',
C= 	121 => 'RSN803_1_0_score	',
C= 	122 => 'RSN803_2_0_score	',
C= 	123 => 'RSN804_1_0_score	',
C= 	124 => 'RSN807_0_0_score	',
C= 	125 => 'RSN810_1_0_score	',
C= 	126 => 'RSN912_1_0_score	',
C= 	127 => 'RVA1003_0_0_score	',
C= 	128 => 'RVA1007_1_0_score	',
C= 	129 => 'RVA1007_2_0_score	',
C= 	130 => 'RVA1007_3_0_score	',
C= 	131 => 'RVA1008_1_0_score	',
C= 	132 => 'RVA1008_2_0_score	',
C= 	133 => 'RVA1104_0_0_score	',
C= 	134 => 'RVA1304_1_0_score	',
C= 	135 => 'RVA1304_2_0_score	',
C= 	136 => 'RVA611_0_0_score	',
C= 	137 => 'RVA707_0_0_score	',
C= 	138 => 'RVA707_1_0_score	',
C= 	139 => 'RVA709_1_0_score	',
C= 	140 => 'RVA711_0_0_score	',
C= 	141 => 'RVB1003_0_0_score	',
C= 	142 => 'RVB1104_0_0_score	',
C= 	143 => 'RVB609_0_0_score	',
C= 	144 => 'RVB703_1_0_score	',
C= 	145 => 'RVB705_1_0_score	',
C= 	146 => 'RVB711_0_0_score	',
C= 	147 => 'RVC1110_1_0_score	',
C= 	148 => 'RVC1110_2_0_score	',
C= 	149 => 'RVC1112_0_0_score	',
C= 	150 => 'RVC1208_1_0_score	',
C= 	151 => 'RVC1210_1_0_score	',
C= 	152 => 'RVC1301_1_0_score	',
C= 	153 => 'RVD1010_0_0_score	',
C= 	154 => 'RVD1010_1_0_score	',
C= 	155 => 'RVD1010_2_0_score	',
C= 	156 => 'RVD1110_1_0_score	',
C= 	157 => 'RVG1003_0_0_score	',
C= 	158 => 'RVG1103_0_0_score	',
C= 	159 => 'RVG1106_1_0_score	',
C= 	160 => 'RVG1201_1_0_score	',
C= 	161 => 'RVG1302_1_0_score	',
C= 	162 => 'RVG1304_1_0_score	',
C= 	163 => 'RVG1304_2_0_score	',
C= 	164 => 'RVG812_0_0_score	',
C= 	165 => 'RVG903_1_0_score	',
C= 	166 => 'RVG904_1_0_score	',
C= 	167 => 'RVP1003_0_0_score	',
C= 	168 => 'RVP1012_1_0_score	',
C= 	169 => 'RVP1104_0_0_score	',
C= 	170 => 'RVP1208_1_0_score	',
C= 	171 => 'RVP804_0_0_score	',
C= 	172 => 'RVR1003_0_0_score	',
C= 	173 => 'RVR1008_1_0_score	',
C= 	174 => 'RVR1103_0_0_score	',
C= 	175 => 'RVR1104_2_0_score	',
//C= 	176 => 'RVR1104_3_0_score	',
C= 	177 => 'RVR1210_1_0_score	',
C= 	178 => 'RVR1303_1_0_score	',
C= 	179 => 'RVR611_0_0_score	',
C= 	180 => 'RVR704_1_0_score	',
C= 	181 => 'RVR711_0_0_score	',
C= 	182 => 'RVR803_1_0_score	',
C= 	183 => 'RVS811_0_0_score	',
C= 	184 => 'RVT1003_0_0_score	',
C= 	185 => 'RVT1006_1_0_score	',
C= 	186 => 'RVT1104_0_0_score	',
C= 	187 => 'RVT1104_1_0_score	',
C= 	188 => 'RVT1204_1_score	',
C= 	189 => 'RVT1210_1_0_score	',
C= 	190 => 'RVT1212_1_0_score	',
C= 	191 => 'RVT612_0_score	',
C= 	192 => 'RVT711_0_0_score	',
C= 	193 => 'RVT711_1_0_score	',
C= 	194 => 'RVT803_1_0_score	',
C= 	195 => 'RVT809_1_0_score	',
C= 	196 => 'TBD605_0_0_score	',
C= 	197 => 'TBD609_1_0_score	',
C= 	198 => 'TBD609_2_0_score	',
C= 	199 => 'TBN509_0_0_score	',
C= 	200 => 'TBN604_1_0_score	',
C= 	201 => 'TRD605_0_0_score	',
C= 	202 => 'TRD609_1_0_score	',
C= 	203 => 'WIN704_0_0_score	',
C= 	204 => 'WOMV002_0_0_score	',
C= 	205 => 'WWN604_1_0_score	',
C= 	206 => 'RVC1307_1_0_score	',
C= 	207 => 'FP1310_1_0_score ',
C= 	208 => 'FP1401_1_0_score ',
C= 	209 => 'RVA1301_1_0_score ',
C= 	210 => 'RVA1301_2_0_score ',
C= 	211 => 'RVA1301_3_0_score ',
C= 	212 => 'RVT1307_3_0_score ',
C= 	213 => 'RVT1402_1_0_score ',
C= 	214 => 'RVA1311_1_0_score ',
C= 	215 => 'RVA1311_2_0_score ',
C= 	216 => 'RVA1311_3_0_score ',
C= 	217 => 'RVG1401_1_0_score ',
C= 	218 => 'RVG1401_2_0_score ',
C= 	219 => 'RVR1311_1_0_score ',
C= 	220 => 'FP1307_1_0_score ',
C= 	221 => 'FP31310_2_0_score ',
C= 	222 => 'RVP1401_1_0_score ',
C= 	223 => 'RVP1401_2_0_score ',
C= 	224 => 'FP1403_1_0_score ',
C= 	225 => 'RVG1310_1_0_score ',
C= 	226 => 'CDN1404_1_0_score ',
C= 	227 => 'RVG1404_1_0_score ',
C= 	228 => 'FP1404_1_0_score ',
C= 	229 => 'FP1407_1_0_score ',
C= 	230 => 'RVC1405_1_0_score ',
C= 	231 => 'FP1406_1_0_score ',
C= 	232 => 'RVC1405_2_0_score ',
C= 	233 => 'RVC1405_3_0_score ',
C=	234 => 'RVC1405_4_0_score ',
C= 	235 => 'FP1403_2_0_score ',
C=	236 => 'RVG1502_0_0_score ',
C=	237 => 'RVB1310_1_0_score ',
C=  238 => 'RVB1503_0_0_score ',
C=  239 => 'RVA1503_0_0_score ',
C=  240 => 'RVT1503_0_0_score ',
C=  241 => 'RVB1402_1_0_score ',
C= 	242 => 'FP1409_2_0_score ',
C=	243 => 'RVC1412_1_0_score ',
C=	244 => 'CDN1410_1_0_score ',
C=	245 => 'RVP1503_1_0_score ',
C=	246 => 'RVA1504_1_0_score ',
C=	247 => 'RVA1504_2_0_score ',
C=	248 => 'CDN1506_1_0_score ',
C=	249 => 'RVB1104_1_0_score ',
C=	250 => 'FP1506_1_0_score ',
C=	251 => 'RVR1410_1_0_score ',
C=	252 => 'FP1509_1_0_score ',
C=	253 => 'FP1509_2_0_score ',
C=	254 => 'FP31505_0_0_score ',
C=	255 => 'FP3FDN1505_0_0_score ',
C=	256 => 'FP1510_2_0_score ',
C=	257 => 'RVG1601_1_0_score ',
C=	258 => 'RVT1601_1_0_score ',
C=	259 => 'RVA1603_1_0_score ',
C=	260 => 'FP1511_1_0_score ',
C=	261 => 'OSN1504_0_0_score ',
C=	262 => 'RVG1511_1_0_score ',
C=	263 => 'FP1512_1_0_score ',
C=	264 => 'RVC1412_2_0_score ',
C=	265 => 'CDN1508_1_0_score ',
C=	266 => 'RVA1607_1_0_score ',
C=	267 => 'RVA1605_1_0_score ',
C=  268 => 'FP1610_1_0_score ',
C=  269 => 'FP1609_1_0_score ',
C=  270 => 'RVT1605_1_0_score ',
C=  271 => 'RVT1605_2_0_score ',
C=  272 => 'RVT1608_1_0_score ',
C=  273 => 'RVT1608_2_score ',  
C=  274 => 'RVA1601_1_0_score ',
C=  275 => 'FP1611_1_0_score ',  
C=  276 => 'OSN1608_1_0_score ', 
C=  277 => 'FP1610_2_0_score ', 
C=  278 => 'FP1606_1_0_score ',
C= 	279 => 'RVC1602_1_0_score ',
C= 	280 => 'RVC1703_1_0_score	',
C= 	281 => 'RVC1609_1_0_score	',
C= 	282 => 'RVG1702_1_0_score ',
C= 	283 => 'RVG1705_1_0_score ',
C= 	284 => 'RVB1610_1_0_score ',
C= 	285 => 'RVG1706_1_0_score ',
C= 	286 => 'RVA1611_1_0_score ',
C= 	287 => 'RVA1611_2_0_score ',
C= 	288 => 'FP1702_2_0_score ',
C= 	289 => 'FP1702_1_0_score ',
C= 	290 => 'FP1706_1_0_score ',
C= 	291 => 'FP1609_2_0_score ',
C= 	292 => 'RVS1706_0_score ',
C= 	293 => 'FP1607_1_0_score ',
C= 	294 => 'RVG1610_1_0_score ',
C= 	295 => 'FP1508_1_0_score ',
C= 	296 => 'RVC1801_1_0_score ',
C= 	297 => 'RVP1702_1_0_score ',
C= 	298 => 'FP1802_1_0_score ',
C= 	299 => 'FP1705_1_0_score ',
C= 	300 => 'RVG1802_1_0_score ',
C=  301 => 'RVT1705_1_0_score ',
C=  302 => 'RVD1801_1_0_score ',
C=  303 => 'FP1801_1_0_score ',
C=  304 => 'FP1806_1_0_score ',
C=  305 => 'FP1710_1_0_score ',
C= 	306 => 'RVC1805_1_0_score ',
C= 	307 => 'RVC1805_2_0_score ',
C= 	308 => 'OSN1803_1_0_score ',
C= 	309 => 'MSN1803_1_0_score	',
C= 	310 => 'FP1803_1_0_score ',
C= 	311 => 'RVA1811_1_0_score ',
C= 	312 => 'RVG1808_3_0_score ',
C= 	313 => 'RVG1808_1_0_score ',
C= 	314 => 'RVG1808_2_0_score ',
C= 	315 => 'RVA1809_1_0_score ',
''
);

self.difference := map(
C= 	1 => le.NAP_diff, 
C= 	2 => le.NAS_diff, 
C= 	3 => le.CVI_score_diff, 
// C= 	4 => le.AID605_1_0_score_diff, 
// C= 	5 => le.AID606_0_0_score_diff, 
// C= 	6 => le.AID606_1_0_score_diff, 
// C= 	7 => le.AID607_0_0_score_diff, 
// C= 	8 => le.AID607_1_0_score_diff, 
// C= 	9 => le.AID607_2_0_score_diff, 
C= 	10 => le.AIN509_0_0_score_diff, 
C= 	11 => le.AIN602_1_0_score_diff, 
C= 	12 => le.AIN605_1_0_score_diff, 
C= 	13 => le.AIN605_2_0_score_diff, 
C= 	14 => le.AIN605_3_0_score_diff, 
C= 	15 => le.AIN801_1_0_score_diff, 
C= 	16 => le.ANMK909_0_1_score_diff, 
// C= 	17 => le.AWD605_0_0_score_diff, 
// C= 	18 => le.AWD605_2_0_score_diff, 
// C= 	19 => le.AWD606_10_0_score_diff, 
// C= 	20 => le.AWD606_11_0_score_diff, 
// C= 	21 => le.AWD606_1_0_score_diff, 
// C= 	22 => le.AWD606_2_0_score_diff, 
// C= 	23 => le.AWD606_3_0_score_diff, 
// C= 	24 => le.AWD606_4_0_score_diff, 
// C= 	25 => le.AWD606_6_0_score_diff, 
// C= 	26 => le.AWD606_7_0_score_diff, 
// C= 	27 => le.AWD606_8_0_score_diff, 
// C= 	28 => le.AWD606_9_0_score_diff, 
// C= 	29 => le.AWD710_1_0_score_diff, 
C= 	30 => le.AWN510_0_0_score_diff, 
C= 	31 => le.AWN603_1_0_score_diff, 
C= 	32 => le.BD3605_0_0_score_diff, 
C= 	33 => le.BD5605_0_0_score_diff, 
C= 	34 => le.BD5605_1_0_score_diff, 
C= 	35 => le.BD5605_2_0_score_diff, 
C= 	36 => le.BD5605_3_0_score_diff, 
C= 	37 => le.BD9605_0_0_score_diff, 
C= 	38 => le.BD9605_1_0_score_diff, 
C= 	39 => le.CDN1109_1_0_score_diff, 
C= 	40 => le.CDN1205_1_0_score_diff, 
C= 	41 => le.CDN1305_1_0_score_diff, 
C= 	42=> le.CDN604_0_0_score_diff, 
C= 	43=> le.CDN604_1_0_score_diff, 
C= 	44=> le.CDN604_2_0_score_diff, 
C= 	45 => le.CDN604_3_0_score_diff, 
C= 	46 => le.CDN604_4_0_score_diff, 
C= 	47 => le.CDN605_1_0_score_diff, 
C= 	48 => le.CDN606_2_0_score_diff, 
C= 	49 => le.CDN706_1_0_score_diff, 
C= 	50 => le.CDN707_1_0_score_diff, 
C= 	51 => le.CDN712_0_0_score_diff, 
C= 	52 => le.CDN806_1_0_score_diff, 
//C= 	53 => le.CDN810_1_0_score_diff, 
C= 	54 => le.CDN908_1_0_score_diff, 
C= 	55 => le.CEN509_0_0_score_diff, 
C= 	56 => le.CSN1007_0_0_score_diff, 
C= 	57 => le.FD3510_0_0_score_diff, 
C= 	58 => le.FD3606_0_0_score_diff, 
C= 	59 => le.FD5510_0_0_score_diff, 
C= 	60 => le.FD5603_1_0_score_diff, 
C= 	61 => le.FD5603_2_0_score_diff, 
C= 	62 => le.FD5603_3_0_score_diff, 
C= 	63 => le.FD5607_1_0_score_diff, 
C= 	64 => le.FD5609_1_0_score_diff, 
C= 	65 => le.FD5609_2_0_score_diff, 
C= 	66 => le.FD5709_1_0_score_diff, 
C= 	67 => le.FD9510_0_0_score_diff, 
C= 	68 => le.FD9603_1_0_score_diff, 
C= 	69 => le.FD9603_2_0_score_diff, 
C= 	70 => le.FD9603_3_0_score_diff, 
C= 	71 => le.FD9603_4_0_score_diff, 
C= 	72 => le.FD9604_1_0_score_diff, 
C= 	73 => le.FD9606_0_0_score_diff, 
C= 	74 => le.FD9607_1_0_score_diff, 
C= 	75 => le.FP1109_0_0_score_diff, 
C= 	76 => le.FP1210_1_0_score_diff, 
C= 	77 => le.FP1303_1_0_score_diff, 
C= 	78 => le.FP31105_1_0_score_diff, 
C= 	79 => le.FP31203_1_0_score_diff, 
C= 	79 => le.FP31604_0_0_score_diff, 
C= 	80 => le.FP3710_0_0_score_diff, 
C= 	81 => le.FP3904_1_0_score_diff, 
C= 	82 => le.FP3905_1_0_score_diff, 
C= 	83 => le.FP5812_1_0_score_diff, 
C= 	84 => le.HCP1206_0_0_score_diff, 
C= 	85 => le.IDN605_1_0_score_diff, 
// C= 	86 => le.IE912_0_0_score_diff, 
// C= 	87 => le.IE912_1_0_score_diff, 
C= 	88 => le.IED1106_1_0_score_diff, 
C= 	89 => le.IEN1006_0_1_score_diff, 
C= 	90 => le.MNC21106_0_0_score_diff, 
C= 	91 => le.MPX1211_0_0_score_diff, 
C= 	92 => le.MSD1010_0_0_score_diff, 
C= 	93 => le.MSN1106_0_0_score_diff, 
C= 	94 => le.MSN605_1_0_score_diff, 
C= 	95 => le.MSN610_0_0_score_diff, 
C= 	96 => le.MV361006_0_0_score_diff, 
C= 	97 => le.MV361006_1_0_score_diff, 
C= 	98 => le.MX361006_0_0_score_diff, 
C= 	99 => le.MX361006_1_0_score_diff, 
C= 	100 => le.RSB801_1_0_score_diff, 
C= 	101 => le.RSN1001_1_0_score_diff, 
C= 	102 => le.RSN1009_1_0_score_diff, 
C= 	103 => le.RSN1010_1_0_score_diff, 
C= 	104 => le.RSN1103_1_0_score_diff, 
C= 	105 => le.RSN1105_1_0_score_diff, 
C= 	106 => le.RSN1105_2_0_score_diff, 
C= 	107 => le.RSN1105_3_0_score_diff, 
C= 	108 => le.RSN1108_1_0_score_diff, 
C= 	109 => le.RSN1108_2_0_score_diff, 
C= 	110 => le.RSN1108_3_0_score_diff, 
C= 	111 => le.RSN508_1_0_score_diff, 
C= 	112 => le.RSN509_1_0_score_diff, 
C= 	113 => le.RSN509_2_0_score_diff, 
C= 	114 => le.RSN604_2_0_score_diff, 
C= 	115 => le.RSN607_0_0_score_diff, 
C= 	116 => le.RSN607_1_0_score_diff, 
C= 	117 => le.RSN702_1_0_score_diff, 
C= 	118 => le.RSN704_0_0_score_diff, 
C= 	119 => le.RSN704_1_0_score_diff, 
C= 	120 => le.RSN802_1_0_score_diff, 
C= 	121 => le.RSN803_1_0_score_diff, 
C= 	122 => le.RSN803_2_0_score_diff, 
C= 	123 => le.RSN804_1_0_score_diff, 
C= 	124 => le.RSN807_0_0_score_diff, 
C= 	125 => le.RSN810_1_0_score_diff, 
C= 	126 => le.RSN912_1_0_score_diff, 
C= 	127 => le.RVA1003_0_0_score_diff, 
C= 	128 => le.RVA1007_1_0_score_diff, 
C= 	129 => le.RVA1007_2_0_score_diff, 
C= 	130 => le.RVA1007_3_0_score_diff, 
C= 	131 => le.RVA1008_1_0_score_diff, 
C= 	132 => le.RVA1008_2_0_score_diff, 
C= 	133 => le.RVA1104_0_0_score_diff, 
C= 	134 => le.RVA1304_1_0_score_diff, 
C= 	135 => le.RVA1304_2_0_score_diff, 
C= 	136 => le.RVA611_0_0_score_diff, 
C= 	137 => le.RVA707_0_0_score_diff, 
C= 	138 => le.RVA707_1_0_score_diff, 
C= 	139 => le.RVA709_1_0_score_diff, 
// C= 	140 => le.RVA711_0_0_score_diff, 
C= 	141 => le.RVB1003_0_0_score_diff, 
C= 	142 => le.RVB1104_0_0_score_diff, 
C= 	143 => le.RVB609_0_0_score_diff, 
// C= 	144 => le.RVB703_1_0_score_diff, 
C= 	145 => le.RVB705_1_0_score_diff, 
// C= 	146 => le.RVB711_0_0_score_diff, 
C= 	147 => le.RVC1110_1_0_score_diff, 
C= 	148 => le.RVC1110_2_0_score_diff, 
C= 	149 => le.RVC1112_0_0_score_diff, 
C= 	150 => le.RVC1208_1_0_score_diff, 
C= 	151 => le.RVC1210_1_0_score_diff, 
C= 	152 => le.RVC1301_1_0_score_diff, 
C= 	153 => le.RVD1010_0_0_score_diff, 
C= 	154 => le.RVD1010_1_0_score_diff, 
C= 	155 => le.RVD1010_2_0_score_diff, 
C= 	156 => le.RVD1110_1_0_score_diff, 
C= 	157 => le.RVG1003_0_0_score_diff, 
C= 	158 => le.RVG1103_0_0_score_diff, 
C= 	159 => le.RVG1106_1_0_score_diff, 
C= 	160 => le.RVG1201_1_0_score_diff, 
C= 	161 => le.RVG1302_1_0_score_diff, 
C= 	162 => le.RVG1304_1_0_score_diff, 
C= 	163 => le.RVG1304_2_0_score_diff, 
C= 	164 => le.RVG812_0_0_score_diff, 
C= 	165 => le.RVG903_1_0_score_diff, 
// C= 	166 => le.RVG904_1_0_score_diff, 
// C= 	167 => le.RVP1003_0_0_score_diff, 
C= 	168 => le.RVP1012_1_0_score_diff, 
// C= 	169 => le.RVP1104_0_0_score_diff, 
C= 	170 => le.RVP1208_1_0_score_diff, 
// C= 	171 => le.RVP804_0_0_score_diff, 
// C= 	172 => le.RVR1003_0_0_score_diff, 
C= 	173 => le.RVR1008_1_0_score_diff, 
C= 	174 => le.RVR1103_0_0_score_diff, 
C= 	175 => le.RVR1104_2_0_score_diff, 
//C= 	176 => le.RVR1104_3_0_score_diff, 
C= 	177 => le.RVR1210_1_0_score_diff, 
C= 	178 => le.RVR1303_1_0_score_diff, 
// C= 	179 => le.RVR611_0_0_score_diff, 
C= 	180 => le.RVR704_1_0_score_diff, 
// C= 	181 => le.RVR711_0_0_score_diff, 
C= 	182 => le.RVR803_1_0_score_diff, 
C= 	183 => le.RVS811_0_0_score_diff, 
C= 	184 => le.RVT1003_0_0_score_diff, 
// C= 	185 => le.RVT1006_1_0_score_diff, 
C= 	186 => le.RVT1104_0_0_score_diff, 
C= 	187 => le.RVT1104_1_0_score_diff, 
C= 	188 => le.RVT1204_1_score_diff, 
C= 	189 => le.RVT1210_1_0_score_diff, 
C= 	190 => le.RVT1212_1_0_score_diff, 
// C= 	191 => le.RVT612_0_score_diff, 
// C= 	192 => le.RVT711_0_0_score_diff, 
C= 	193 => le.RVT711_1_0_score_diff, 
// C= 	194 => le.RVT803_1_0_score_diff, 
// C= 	195 => le.RVT809_1_0_score_diff, 
// C= 	196 => le.TBD605_0_0_score_diff, 
// C= 	197 => le.TBD609_1_0_score_diff, 
// C= 	198 => le.TBD609_2_0_score_diff, 
C= 	199 => le.TBN509_0_0_score_diff, 
C= 	200 => le.TBN604_1_0_score_diff, 
// C= 	201 => le.TRD605_0_0_score_diff, 
// C= 	202 => le.TRD609_1_0_score_diff, 
C= 	203 => le.WIN704_0_0_score_diff, 
C= 	204 => le.WOMV002_0_0_score_diff, 
C= 	205 => le.WWN604_1_0_score_diff, 
C= 	206 => le.RVC1307_1_0_score_diff, 
C= 	207 => le.FP1310_1_0_score_diff, 
C= 	208 => le.FP1401_1_0_score_diff, 
C= 	209 => le.RVA1310_1_0_score_diff, 
C= 	210 => le.RVA1310_2_0_score_diff, 
C= 	211 => le.RVA1310_3_0_score_diff, 
C= 	212 => le.RVT1307_3_0_score_diff, 
C= 	213 => le.RVT1402_1_0_score_diff, 
C= 	214 => le.RVA1311_1_0_score_diff, 
C= 	215 => le.RVA1311_2_0_score_diff,
C= 	216 => le.RVA1311_3_0_score_diff,
C= 	217 => le.RVG1401_1_0_score_diff,
C= 	218 => le.RVG1401_2_0_score_diff,
// C= 	219 => le.RVR1311_1_0_score_diff,
C= 	220 => le.FP1307_1_0_score_diff,
C= 	221 => le.FP31310_2_0_score_diff,
C= 	222 => le.RVP1401_1_0_score_diff,
C= 	223 => le.RVP1401_2_0_score_diff,
C= 	224 => le.FP1403_1_0_score_diff,
C= 	225 => le.RVG1310_1_0_score_diff,
C= 	226 => le.CDN1404_1_0_score_diff,
C= 	227 => le.RVG1404_1_0_score_diff,
C= 	228 => le.FP1404_1_0_score_diff, 
C= 	229 => le.FP1407_1_0_score_diff, 
C= 	230 => le.RVC1405_1_0_score_diff, 
C= 	231 => le.FP1406_1_0_score_diff,
C= 	232 => le.RVC1405_2_0_score_diff,
C= 	233 => le.RVC1405_3_0_score_diff,
C=	234 => le.RVC1405_4_0_score_diff,
C= 	235 => le.FP1403_2_0_score_diff,
C=	236 => le.RVG1502_0_0_score_diff,
C=	237 => le.RVB1310_1_0_score_diff,
C=  238 => le.RVB1503_0_0_score_diff,
C=  239 => le.RVA1503_0_0_score_diff,
C=  240 => le.RVT1503_0_0_score_diff,
C=  241 => le.RVB1402_1_0_score_diff,
C= 	242 => le.FP1409_2_0_score_diff,
C=	243 => le.RVC1412_1_0_score_diff,
C=	244 => le.CDN1410_1_0_score_diff,
C=	245 => le.RVP1503_1_0_score_diff,
C=	246 => le.RVA1504_1_0_score_diff,
C=	247 => le.RVA1504_2_0_score_diff,
C=	248 => le.CDN1506_1_0_score_diff,
C=	249 => le.RVB1104_1_0_score_diff,
C=	250 => le.FP1506_1_0_score_diff,
C=	251 => le.RVR1410_1_0_score_diff,
C=	252 => le.FP1509_1_0_score_diff,
C=	253 => le.FP1509_2_0_score_diff,
C=	254 => le.FP31505_0_0_score_diff,
C=	255 => le.FP3FDN1505_0_0_score_diff,
C=	256 => le.FP1510_2_0_score_diff,
C=	257 => le.RVG1601_1_0_score_diff,
C=	258 => le.RVT1601_1_0_score_diff,
C=	259 => le.RVA1603_1_0_score_diff,
C=	260 => le.FP1511_1_0_score_diff,
C=	261 => le.OSN1504_0_0_score_diff,
C=	262 => le.RVG1511_1_0_score_diff,
C=	263 => le.FP1512_1_0_score_diff,
C=	264 => le.RVC1412_2_0_score_diff,
C=	265 => le.CDN1508_1_0_score_diff,
C=	266 => le.RVA1607_1_0_score_diff,
C=	267 => le.RVA1605_1_0_score_diff,
C=  268 => le.FP1610_1_0_score_diff,
C=  269 => le.FP1609_1_0_score_diff,
C=  270 => le.RVT1605_1_0_score_diff,
C=  271 => le.RVT1605_2_0_score_diff,
C=  272 => le.RVT1608_1_0_score_diff,
C=  273 => le.RVT1608_2_score_diff,
C=  274 => le.RVA1601_1_0_score_diff,
C=  275 => le.FP1611_1_0_score_diff,
C=  276 => le.OSN1608_1_0_score_diff,
C=  277 => le.FP1610_2_0_score_diff,
C=  278 => le.FP1606_1_0_score_diff,
C= 	279 => le.RVC1602_1_0_score_diff,
C= 	280 => le.RVC1703_1_0_score_diff,
C= 	281 => le.RVC1609_1_0_score_diff,
C= 	282 => le.RVG1702_1_0_score_diff, 
C= 	283 => le.RVG1705_1_0_score_diff,
C= 	284 => le.RVB1610_1_0_score_diff, 
C= 	285 => le.RVG1706_1_0_score_diff,
C= 	286 => le.RVA1611_1_0_score_diff,
C= 	287 => le.RVA1611_2_0_score_diff,
C= 	288 => le.FP1702_2_0_score_diff,
C= 	289 => le.FP1702_1_0_score_diff,
C= 	290 => le.FP1706_1_0_score_diff,
C= 	291 => le.FP1609_2_0_score_diff,
C= 	292 => le.RVS1706_0_score_diff,
// C= 	293 => le.FP1607_1_0_score_diff,
C= 	294 => le.RVG1610_1_0_score_diff,
C= 	295 => le.FP1508_1_0_score_diff,
C= 	296 => le.RVC1801_1_0_score_diff,
C= 	297 => le.RVP1702_1_0_score_diff,
C= 	298 => le.FP1802_1_0_score_diff,
C= 	299 => le.FP1705_1_0_score_diff,
C= 	300 => le.RVG1802_1_0_score_diff,
C=  301 => le.RVT1705_1_0_score_diff,
C=  302 => le.RVD1801_1_0_score_diff,
C=  303 => le.FP1801_1_0_score_diff,
C=  304 => le.FP1806_1_0_score_diff,
C=  305 => le.FP1710_1_0_score_diff,
C= 	306 => le.RVC1805_1_0_score_diff,
C= 	307 => le.RVC1805_2_0_score_diff,
C= 	308 => le.OSN1803_1_0_score_diff,
C= 	309 => le.MSN1803_1_0_score_diff,
C= 	310 => le.FP1803_1_0_score_diff,
C= 	311 => le.RVA1811_1_0_score_diff,
C= 	312 => le.RVG1808_3_0_score_diff,
C= 	313 => le.RVG1808_1_0_score_diff,
C= 	314 => le.RVG1808_2_0_score_diff,
C= 	315 => le.RVA1809_1_0_score_diff,
0);										
end;

name_pairs :=  normalize(j, 315, norm(left, counter));


// get an overall picture of impact
overall_model_summary := table(j, 
	{
		total_records := count(group),
		impacted_records := count(group, any_difference),
		pct_records_impacted :=  count(group, any_difference) / count(group)
	}	);
output(overall_model_summary, named('overall_model_summary'));

// output some raw stats per model
model_breakdown := sort(
table(name_pairs(difference<>0), 
{model_name, 
total_differences := count(group),
average_diff := ave(group, difference),

increased_count := count(group, difference>0),
max_diff := max(group, difference),

decreased_count := count(group, difference<0),
min_diff := min(group, difference),

}, model_name), 
-total_differences);
output(model_breakdown, all, named('model_breakdown'));
