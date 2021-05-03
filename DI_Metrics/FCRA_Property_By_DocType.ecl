//Property deed transfers
//W20200326-094031 Prod
//PROPERTY BY DOCUMENT TYPE: For the following events, I would like the number of new events by type by month by state
// all the way back to 2010. This data should be created using only data on the FCRA Roxies

IMPORT _Control, data_services, LN_PropertyV2, LN_PropertyV2_Fast, STD, ut;

export FCRA_Property_By_DocType(string pHostname, string pTarget, string pContact ='\' \'', STRING today = (STRING8)STD.Date.Today()) := function

filedate := today;

//FCRA keys:
Key_Deeds_FCRA_monthly := PULL(LN_PropertyV2.key_deed_fid(true));
Key_Deeds_FCRA_fast := PULL(LN_PropertyV2_Fast.Key_Deed_FID(true,true));

rSource := RECORD
		string source_val;
		string which_prop_file;
		Key_Deeds_FCRA_monthly;
	END;

rSource TwoSourcesMonthly(Key_Deeds_FCRA_monthly pInput) :=	TRANSFORM
		SELF.source_val := IF(pInput.vendor_source_flag IN ['F','S'], 'Source A', 'Source B');  
		SELF.which_prop_file := 'DEEDS-MONTHLY';
		SELF := pInput;
	END;

File_Base_Deeds_Mnthly_plus_2010 := PROJECT(Key_Deeds_FCRA_monthly((proc_date between 201001 and (unsigned6) filedate[1..6]), state <> '', document_type_code <> ''), TwoSourcesMonthly(LEFT));

rSource TwoSourcesFast(Key_Deeds_FCRA_fast pInput) :=	TRANSFORM
		SELF.source_val := IF(pInput.vendor_source_flag IN ['F','S'], 'Source A', 'Source B'); 
		SELF.which_prop_file := 'DEEDS-FAST';
		SELF := pInput;
	END;

File_Base_Deeds_Fast_plus_2010 := PROJECT(Key_Deeds_FCRA_fast((proc_date between 201001 and (unsigned6) filedate[1..6]), state <> '', document_type_code <> ''), TwoSourcesFast(LEFT));

Key_Deeds_FCRA_2010 := File_Base_Deeds_Mnthly_plus_2010 + File_Base_Deeds_Fast_plus_2010;

Key_Deeds_FCRA_2010_props := DEDUP(sort(distribute(Key_Deeds_FCRA_2010(fares_unformatted_apn <> ''), hash(fares_unformatted_apn)), proc_date,state, fips_code,fares_unformatted_apn,document_type_code, local), proc_date,state, fips_code,fares_unformatted_apn,document_type_code, all,local);

//proc_date is YYYYMM from the value for Recording Date, which is when the transaction was filed at the county
tbl_Key_Deeds_FCRA_2010_props := TABLE(Key_Deeds_FCRA_2010_props, {proc_date, state, document_type_code, document_type := DI_Metrics.fnSourceBDocTypes(document_type_code), property_count := count(group)}, proc_date, state, document_type_code, few);

//Despray to bctlpedata12 (one thor file and one csv file). FTP to \\Risk\inf\Data_Factory\DI_Landingzone
despray_fcra_deed_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_key_deeds_fcra_2010_properties_by_doctype_'+ filedate +'.csv',
																					pHostname, 
																					pTarget + '/tbl_key_deeds_fcra_2010_properties_by_doctype_'+ filedate +'.csv'
																					,,,,true);

//if everything in the Sequential statement runs, it will send the Success email, else it will send the Failure email
email_alert := SEQUENTIAL(
					output(sort(tbl_Key_Deeds_FCRA_2010_props, -proc_date, state, document_type_code, skew(1.0)),,'~thor_data400::data_insight::data_metrics::tbl_key_deeds_fcra_2010_properties_by_doctype_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite,expire(10))
					,despray_fcra_deed_tbl):
					Success(FileServices.SendEmail(pContact, 'FCRA Group: FCRA_Property_By_DocType Build Succeeded', workunit + ': Build complete.' + filedate)),
					Failure(FileServices.SendEmail(pContact, 'FCRA Group: FCRA_Property_By_DocType Build Failed', workunit + filedate + '\n' + FAILMESSAGE)
													);
return email_alert;

end;