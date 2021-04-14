//Property deed transfers
//W20200806-095729 Prod
//orig code pulled from W20190211-123626-dataland

IMPORT _Control, data_services, LN_PropertyV2, LN_PropertyV2_Fast, STD, ut;
EXPORT NonFCRA_Property_Deeds_By_DocType(string pHostname, string pTarget, string pContact ='\' \'', STRING today = (STRING8)STD.Date.Today()) := function

filedate := today;

//NonFCRA keys:
Key_Deeds_Non_FCRA_monthly := PULL(LN_PropertyV2.key_deed_fid(false));
Key_Deeds_Non_FCRA_fast := PULL(LN_PropertyV2_Fast.Key_Deed_FID(false,true));

rSource := RECORD
		string source_val;
		string which_prop_file;
		Key_Deeds_Non_FCRA_monthly;
	END;

rSource TwoSourcesMonthly(Key_Deeds_Non_FCRA_monthly pInput) := TRANSFORM
		SELF.source_val := IF(pInput.vendor_source_flag IN ['F','S'], 'Source A', 'Source B');  
		SELF.which_prop_file := 'DEEDS-MONTHLY';
		SELF := pInput;
	END;

//File_Base_Deeds_Mnthly_plus_2010 := PROJECT(Key_Deeds_Non_FCRA_monthly((proc_date between 201001 and (unsigned6) data_services.GetDate[1..6]), state <> '', document_type_code <> ''), TwoSourcesMonthly(LEFT));
File_Base_Deeds_Mnthly_plus_2010 := PROJECT(Key_Deeds_Non_FCRA_monthly((proc_date between 201001 and (unsigned6) filedate[1..6]), state <> '', document_type_code <> ''), TwoSourcesMonthly(LEFT));

rSource TwoSourcesFast(Key_Deeds_Non_FCRA_fast pInput) := TRANSFORM
		SELF.source_val := IF(pInput.vendor_source_flag IN ['F','S'], 'Source A', 'Source B'); 
		SELF.which_prop_file := 'DEEDS-FAST';
		SELF := pInput;
	END;

//File_Base_Deeds_Fast_plus_2010 := PROJECT(Key_Deeds_Non_FCRA_fast((proc_date between 201001 and (unsigned6) filedate[1..6]), state <> '', document_type_code <> ''), TwoSourcesFast(LEFT));
File_Base_Deeds_Fast_plus_2010 := PROJECT(Key_Deeds_Non_FCRA_fast((proc_date between 201001 and (unsigned6) filedate[1..6]), state <> '', document_type_code <> ''), TwoSourcesFast(LEFT));

Key_Deeds_Non_FCRA_2010 := File_Base_Deeds_Mnthly_plus_2010 + File_Base_Deeds_Fast_plus_2010;
// output(Key_Deeds_Non_FCRA_2010);

Key_Deeds_Non_FCRA_2010_props_srcA := DEDUP(sort(distribute(Key_Deeds_Non_FCRA_2010(source_val = 'Source A' AND fares_unformatted_apn <> ''), hash(proc_date,state, fips_code,fares_unformatted_apn)), proc_date,state, fips_code,fares_unformatted_apn,document_type_code, local), proc_date,state, fips_code,fares_unformatted_apn,document_type_code, local);
Key_Deeds_Non_FCRA_2010_props_srcB := DEDUP(sort(distribute(Key_Deeds_Non_FCRA_2010(source_val = 'Source B' AND fares_unformatted_apn <> ''), hash(proc_date,state, fips_code,fares_unformatted_apn)), proc_date,state, fips_code,fares_unformatted_apn,document_type_code, local), proc_date,state, fips_code,fares_unformatted_apn,document_type_code, local);

//proc_date is YYYYMM from the value for Recording Date, which is when the transaction was filed at the county
tbl_Key_Deeds_Non_FCRA_2010_props_srcA := TABLE(Key_Deeds_Non_FCRA_2010_props_srcA, {source_val, proc_date, state, document_type_code, document_type := DI_Metrics.fnDeedsDocTypes(document_type_code,vendor_source_flag), property_count := count(group)}, source_val, proc_date, state, document_type_code, MANY);
tbl_Key_Deeds_Non_FCRA_2010_props_srcB := TABLE(Key_Deeds_Non_FCRA_2010_props_srcB, {source_val, proc_date, state, document_type_code, document_type := DI_Metrics.fnDeedsDocTypes(document_type_code,vendor_source_flag), property_count := count(group)}, source_val, proc_date, state, document_type_code, MANY);

//Despray to bctlpedata12 (one thor file and one csv file). FTP to \\Risk\inf\Data_Factory\DI_Landingzone
tbl_Non_FCRA_Deeds_srcA := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_Key_Deeds_Non_FCRA_2010_properties_by_DocType_SrcA_'+ filedate +'.csv',
																						pHostname, 
																						pTarget +'/tbl_Key_Deeds_Non_FCRA_2010_properties_by_DocType_SrcA_'+ filedate +'.csv'
																						,,,,true);																								
																									
tbl_Non_FCRA_Deeds_srcB := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_Key_Deeds_Non_FCRA_2010_properties_by_DocType_SrcB_'+ filedate +'.csv',
																						pHostname, 
																						pTarget +'/tbl_Key_Deeds_Non_FCRA_2010_properties_by_DocType_SrcB_'+ filedate +'.csv'
																						,,,,true);

//if everything in the Sequential statement runs, it will send the Success email, else it will send the Failure email
email_alert := SEQUENTIAL(
					output(sort(tbl_Key_Deeds_Non_FCRA_2010_props_srcA, source_val, proc_date,state, document_type_code, skew(1.0)),,'~thor_data400::data_insight::data_metrics::tbl_Key_Deeds_Non_FCRA_2010_properties_by_DocType_SrcA_'+ filedate +'.csv', CSV(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))
					,output(sort(tbl_Key_Deeds_Non_FCRA_2010_props_srcB, source_val, proc_date,state, document_type_code, skew(1.0)),,'~thor_data400::data_insight::data_metrics::tbl_Key_Deeds_Non_FCRA_2010_properties_by_DocType_SrcB_'+ filedate +'.csv', CSV(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))
					,tbl_Non_FCRA_Deeds_srcA
					,tbl_Non_FCRA_Deeds_srcB):
					Success(FileServices.SendEmail(pContact, 'NonFCRA Group: NonFCRA_Property_Deeds_By_DocType Build Succeeded', workunit + ': Build complete.' + filedate)),
					Failure(FileServices.SendEmail(pContact, 'NonFCRA Group: NonFCRA_Property_Deeds_By_DocType Build Failed', workunit + filedate + '\n' + FAILMESSAGE)
					);
return email_alert;

end;