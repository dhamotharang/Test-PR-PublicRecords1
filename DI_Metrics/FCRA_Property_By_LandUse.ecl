//Property tax assessments:  Source B is the only FCRA Property source
//W20200326-094059 Prod
//For the following events, I would like the number of new events by type by month by state all the way back to 2010. This data should be created using only data on the FCRA Roxies

IMPORT _Control, census_data, LN_PropertyV2, LN_PropertyV2_Fast, data_services, STD, ut;

export FCRA_Property_By_LandUse(string pHostname, string pTarget, string pContact ='\' \'', STRING today = (STRING8)STD.Date.Today()) := function

filedate := today;

//FCRA keys:
tax_key1 := LN_PropertyV2.key_assessor_fid(true);
tax_key2 := LN_PropertyV2_Fast.key_assessor_fid(true,true);
Key_Tax_FCRA_monthly := tax_key1 + tax_key2;

rSource := RECORD
		string source_val;
		//string which_prop_file;
		string new_recording_date;
		Key_Tax_FCRA_monthly;
	END;

rSource TwoSourcesMonthly(Key_Tax_FCRA_monthly pInput) := TRANSFORM
		SELF.source_val := 'Source B';  
		//SELF.which_prop_file := 'TAX-MONTHLY';
		self.new_recording_date := pInput.recording_date[1..6];
		SELF.state_code := MAP(pInput.fips_code[1..2] = '01' => 'AL',
											 pInput.fips_code[1..2] = '02' => 'AK',
											 pInput.fips_code[1..2] = '04' => 'AZ',
											 pInput.fips_code[1..2] = '05' => 'AR',
											 pInput.fips_code[1..2] = '06' => 'CA',
											 pInput.fips_code[1..2] = '08' => 'CO',
											 pInput.fips_code[1..2] = '09' => 'CT',
											 pInput.fips_code[1..2] = '10' => 'DE',
											 pInput.fips_code[1..2] = '11' => 'DC',
											 pInput.fips_code[1..2] = '12' => 'FL',
											 pInput.fips_code[1..2] = '13' => 'GA',
											 pInput.fips_code[1..2] = '15' => 'HI',
											 pInput.fips_code[1..2] = '16' => 'ID',
											 pInput.fips_code[1..2] = '17' => 'IL',
											 pInput.fips_code[1..2] = '18' => 'IN',
											 pInput.fips_code[1..2] = '19' => 'IA',
											 pInput.fips_code[1..2] = '20' => 'KS',
											 pInput.fips_code[1..2] = '21' => 'KY',
											 pInput.fips_code[1..2] = '22' => 'LA',
											 pInput.fips_code[1..2] = '23' => 'ME',
											 pInput.fips_code[1..2] = '24' => 'MD',
											 pInput.fips_code[1..2] = '25' => 'MA',
											 pInput.fips_code[1..2] = '26' => 'MI',
											 pInput.fips_code[1..2] = '27' => 'MN',
											 pInput.fips_code[1..2] = '28' => 'MS',
											 pInput.fips_code[1..2] = '29' => 'MO',
											 pInput.fips_code[1..2] = '30' => 'MT',
											 pInput.fips_code[1..2] = '31' => 'NE',
											 pInput.fips_code[1..2] = '32' => 'NV',
											 pInput.fips_code[1..2] = '33' => 'NH',
											 pInput.fips_code[1..2] = '34' => 'NJ',
											 pInput.fips_code[1..2] = '35' => 'NM',
											 pInput.fips_code[1..2] = '36' => 'NY',
											 pInput.fips_code[1..2] = '37' => 'NC',
											 pInput.fips_code[1..2] = '38' => 'ND',
											 pInput.fips_code[1..2] = '39' => 'OH',
											 pInput.fips_code[1..2] = '40' => 'OK',
											 pInput.fips_code[1..2] = '41' => 'OR',
											 pInput.fips_code[1..2] = '42' => 'PA',
											 pInput.fips_code[1..2] = '44' => 'RI',
											 pInput.fips_code[1..2] = '45' => 'SC',
											 pInput.fips_code[1..2] = '46' => 'SD',
											 pInput.fips_code[1..2] = '47' => 'TN',
											 pInput.fips_code[1..2] = '48' => 'TX',
											 pInput.fips_code[1..2] = '49' => 'UT',
											 pInput.fips_code[1..2] = '50' => 'VT',
											 pInput.fips_code[1..2] = '51' => 'VA',
											 pInput.fips_code[1..2] = '53' => 'WA',
											 pInput.fips_code[1..2] = '54' => 'WV',
											 pInput.fips_code[1..2] = '55' => 'WI',
											 pInput.fips_code[1..2] = '56' => 'WY',
											 ''); 
		SELF := pInput;
	END;

Key_Tax_FCRA_monthly_plus_2010 := PROJECT(Key_Tax_FCRA_monthly((recording_date between '201001' and (string6) filedate[1..6]), fips_code <> ''), TwoSourcesMonthly(LEFT));
															
Key_Tax_FCRA_2010_props := DEDUP(sort(distribute(Key_Tax_FCRA_monthly_plus_2010(fares_unformatted_apn <> ''), hash(fares_unformatted_apn)), 
																 fares_unformatted_apn, new_recording_date, state_code, standardized_land_use_code, local), 
																 fares_unformatted_apn, new_recording_date, state_code, standardized_land_use_code, all);

//proc_date is YYYYMM from the value for Recording Date, which is when the transaction was filed at the county
tbl_Key_Tax_FCRA_2010_props := TABLE(Key_Tax_FCRA_2010_props, {new_recording_date, state_code, standardized_land_use_code, standardized_land_use := DI_Metrics.fnSourceBStandardizedLandUse(standardized_land_use_code), property_count := count(group)}, proc_date, state_code, standardized_land_use_code, few);

//Despray to bctlpedata12 (one thor file and one csv file). FTP to \\Risk\inf\Data_Factory\DI_Landingzone
despray_fcra_tax_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_FCRA_Key_Tax_2010_properties_by_StandLandUse_'+ filedate +'.csv',
																			pHostname, 
																			pTarget + '/tbl_FCRA_Key_Tax_2010_properties_by_StandLandUse_'+ filedate +'.csv'
																					,,,,true);

//if everything in the Sequential statement runs, it will send the Success email, else it will send the Failure email
email_alert := SEQUENTIAL(
					output(sort(tbl_Key_Tax_FCRA_2010_props, -new_recording_date, state_code, standardized_land_use_code, skew(1.0)),,'~thor_data400::data_insight::data_metrics::tbl_FCRA_Key_Tax_2010_properties_by_StandLandUse_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite,expire(10))
					,despray_fcra_tax_tbl):
					Success(FileServices.SendEmail(pContact, 'FCRA Group: FCRA_Property_By_LandUse Build Succeeded', workunit + ': Build complete.' + filedate)),
					Failure(FileServices.SendEmail(pContact, 'FCRA Group: FCRA_Property_By_LandUse Build Failed', workunit + filedate + '\n' + FAILMESSAGE)
													);
return email_alert;

end;