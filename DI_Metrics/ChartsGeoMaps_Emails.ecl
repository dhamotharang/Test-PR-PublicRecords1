//--- Email Domains Chart Map ---//

IMPORT _control,Email_Data, Email_DataV2, data_services, STD, ut; 
export ChartsGeoMaps_Emails(string pHostname, string pTarget, string pContact ='\' \'', STRING today = (STRING8)STD.Date.Today()) := function

filedate := today;

//Using EmailV2 base file, this file does not 'rollup' at source level and does not filter any records based on "current" or "valid domain" 
//EmailV1 := Email_Data.File_Email_Base;
EmailV1 := DATASET(Data_Services.foreign_prod+'thor_data400::base::email_data', Email_Data.Layout_Email.Scrubs_bits_base, thor);
EmailV2 := Email_DataV2.Files.Email_Base;

em1_append_domain_table := sort(table(EmailV1, {append_domain, total:=count(group)}, append_domain,many),append_domain);
em1_append_domain_table_filter := em1_append_domain_table(total > 25000000);

em2_append_domain_table := sort(table(EmailV2, {append_domain, total:=count(group)}, append_domain,many),append_domain);
em2_append_domain_table_filter := em2_append_domain_table(total > 25000000);


//Despray CSV to bctlpedata12 (one thor file and one csv file). FTP to \\Risk\inf\Data_Factory\DI_Landingzone
despray_emailV1_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_ChartsGeoMaps_tbl_EmailV1_ds_append_domain_'+ filedate +'.csv',
																				pHostname, 
																				pTarget+ '/tbl_ChartsGeoMaps_tbl_EmailV1_ds_append_domain_'+ filedate +'.csv'
																				,,,,true);

despray_emailV2_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_ChartsGeoMaps_tbl_EmailV2_ds_append_domain_'+ filedate +'.csv',
																				pHostname, 
																				pTarget+ '/tbl_ChartsGeoMaps_tbl_EmailV2_ds_append_domain_'+ filedate +'.csv'
																				,,,,true);

//Jessica's last wuid: W20190219-133546-prod
//fcra_EmailV1 := Email_Data.Key_Did_FCRA;
//fcra_EmailV2 := Email_DataV2.Files.Email_Base_FCRA;

//if everything in the Sequential statement runs, it will send the Success email, else it will send the Failure email
email_alert := SEQUENTIAL(
					output(sort(em1_append_domain_table_filter, append_domain, skew(1.0)),,'~thor_data400::data_insight::data_metrics::tbl_ChartsGeoMaps_tbl_EmailV1_ds_append_domain_'+ filedate +'.csv', CSV(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))
					,output(sort(em1_append_domain_table_filter, append_domain, skew(1.0)),,'~thor_data400::data_insight::data_metrics::tbl_ChartsGeoMaps_tbl_EmailV2_ds_append_domain_'+ filedate +'.csv', CSV(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))
					,despray_emailV1_tbl
					,despray_emailV2_tbl):
					Success(FileServices.SendEmail(pContact, 'ChartsGeoMaps Group: ChartsGeoMaps_Emails Build Succeeded', workunit + ': Build complete.' + filedate)),
					Failure(FileServices.SendEmail(pContact, 'ChartsGeoMaps Group: ChartsGeoMaps_Emails Build Failed', workunit + filedate + '\n' + FAILMESSAGE)
													);
return email_alert;

end;