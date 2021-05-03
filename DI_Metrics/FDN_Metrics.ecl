#CONSTANT	('Platform','FDN');

IMPORT _control, FraudShared, data_services, STD; 
export FDN_Metrics(string pHostname, string pTarget, string pContact ='\' \'', STRING today = (STRING8)STD.Date.Today()) := function

filedate := today;

//Input File
key_in := PULL(FraudShared.Keys().main.id.qa);

layout_key_out := RECORD
	unsigned8	record_id;
	string12	customer_id;
	string12	sub_customer_id;
	string60	vendor_id;
	string12	sub_sub_customer_id;
	string20	customer_event_id;
	string12	sub_customer_event_id;
	string12	sub_sub_customer_event_id;
	string12	ln_product_id; 
	string12	ln_sub_product_id;
	string12	ln_sub_sub_product_id;
	string12	ln_product_key;
	string8	ln_report_date;
	string10	ln_report_time;
	string8	reported_date;
	string10	reported_time;
	string8	event_date;
	string10	event_end_date;
	string25	event_location;
	unsigned6	did;
	//	source
	string25	classification_source_source_type;
	string10	classification_source_primary_source_entity;
	string10	classification_source_expectation_of_victim_entities;
	string100	classification_source_industry_segment;
	//	permissible_use_access
	unsigned6	classification_permissible_use_access_fdn_file_info_id;
	string100	classification_permissible_use_access_fdn_file_code;
	//	entity
	string25	classification_entity_entity_type;
	string25	classification_entity_entity_sub_type;
	string25	classification_entity_role;
	string10	classification_entity_evidence;
	string10	classification_entity_investigated_count;
	//	activity
	string25	classification_activity_suspected_discrepancy;
	string10	classification_activity_confidence_that_activity_was_deceitful;
	string15	classification_activity_workflow_stage_committed;
	string15	classification_activity_workflow_stage_detected;
	string10	classification_activity_channels;
	string50	classification_activity_category_or_fraudtype;
	string150	classification_activity_description;
	string50	classification_activity_threat;
	string12	classification_activity_exposure;
	string12	classification_activity_write_off_loss;
	string12	classification_activity_mitigated;
	string10	classification_activity_alert_level;
	//	Rest of Main
	unsigned8	uid;
	string20	source;
	unsigned4	process_date;
	unsigned4	dt_first_seen;
	unsigned4	dt_last_seen;
	unsigned4	dt_vendor_last_reported;
	unsigned4	dt_vendor_first_reported;
	unsigned6	source_rec_id;
END;

layout_key_out makerecord (key_in L) := transform
	self.record_id := L.record_id;
	self.customer_id := L.customer_id;
	self.sub_customer_id := L.sub_customer_id;
	self.vendor_id := L.vendor_id;
	self.sub_sub_customer_id := L.sub_sub_customer_id;
	self.customer_event_id := L.customer_event_id;
	self.sub_customer_event_id := L.sub_customer_event_id;
	self.sub_sub_customer_event_id := L.sub_sub_customer_event_id;
	self.ln_product_id := L.ln_product_id;
	self.ln_sub_product_id := L.ln_sub_product_id;
	self.ln_sub_sub_product_id := L.ln_sub_sub_product_id;
	self.ln_product_key := L.ln_product_key;
	self.ln_report_date := L.ln_report_date;
	self.ln_report_time := L.ln_report_time;
	self.reported_date := L.reported_date;
	self.reported_time := L.reported_time;
	self.event_date := L.event_date;
	self.event_end_date := L.event_end_date;
	self.event_location := L.event_location;
	self.did := L.did;
	// Source
	self.classification_source_source_type := L.classification_source.source_type;
	self.classification_source_primary_source_entity := L.classification_source.primary_source_entity;
	self.classification_source_expectation_of_victim_entities := L.classification_source.expectation_of_victim_entities;
	self.classification_source_industry_segment := L.classification_source.industry_segment;
	//Activity
	self.classification_activity_suspected_discrepancy := L.classification_activity.suspected_discrepancy;
	self.classification_activity_confidence_that_activity_was_deceitful := L.classification_activity.confidence_that_activity_was_deceitful;
	self.classification_activity_workflow_stage_committed := L.classification_activity.workflow_stage_committed;
	self.classification_activity_workflow_stage_detected := L.classification_activity.workflow_stage_detected;
	self.classification_activity_channels := L.classification_activity.channels;
	self.classification_activity_category_or_fraudtype := L.classification_activity.category_or_fraudtype;
	self.classification_activity_description := L.classification_activity.description;
	self.classification_activity_threat := L.classification_activity.threat;
	self.classification_activity_exposure := L.classification_activity.exposure;
	self.classification_activity_write_off_loss := L.classification_activity.write_off_loss;
	self.classification_activity_mitigated := L.classification_activity.mitigated;
	self.classification_activity_alert_level := L.classification_activity.alert_level;
	//Entity
	self.classification_entity_entity_type := L.classification_entity.entity_type;
	self.classification_entity_entity_sub_type := L.classification_entity.entity_sub_type;
	self.classification_entity_role := L.classification_entity.role;
	self.classification_entity_evidence := L.classification_entity.evidence;
	self.classification_entity_investigated_count := L.classification_entity.investigated_count;
	// Permissable_Use_Access
	self.classification_permissible_use_access_fdn_file_info_id := L.classification_permissible_use_access.fdn_file_info_id;
	self.classification_permissible_use_access_fdn_file_code := L.classification_permissible_use_access.fdn_file_code;
	//Rest of Main
	self.uid := L.uid;
	self.source := L.source;
	self.process_date := L.process_date;
	self.dt_first_seen := L.dt_first_seen;
	self.dt_last_seen := L.dt_last_seen;
	self.dt_vendor_last_reported := L.dt_vendor_last_reported;
	self.dt_vendor_first_reported := L.dt_vendor_first_reported;
	self.source_rec_id := L.source_rec_id;
END;

ds_main := project(key_in,makerecord(left));

//Count of Base File //869,631
//Output(COUNT(ds_main), named('COUNT_MAIN'));

//Sample of Base File
//Output(ds_main, named('SAMPLE_MAIN'));

// Unique Counts Base File //772,135
ds_main_unq := dedup(sort(distribute(ds_main(did>0),hash64(did)),did,local),did, local);
//Output(COUNT(ds_main_unq), named('COUNT_UNIQUE_MAIN'));;
//Output(ds_main_unq, named('SAMPLE_UNIQUE_MAIN'));

//1. Industry Counts
layout_stat := record
	ds_main.classification_source_industry_segment;
	total:= count(group);
end;
	
srt_industry_counts_tbl := sort(table(ds_main,layout_stat,classification_source_industry_segment,few),classification_source_industry_segment);

//2. Unique Industry Counts
layout_stat_6a := record
	ds_main_unq.classification_source_industry_segment;
	total:= count(group);
end;
	
srt_unq_industry_counts_tbl := sort(table(ds_main_unq,layout_stat_6a,classification_source_industry_segment,few),classification_source_industry_segment);

//3. Customer Counts
layout_stat25 := record
	ds_main.classification_permissible_use_access_fdn_file_code;
	total:= count(group);
end;
	
srt_customer_counts_tbl := sort(table(ds_main,layout_stat25,classification_permissible_use_access_fdn_file_code,few),classification_permissible_use_access_fdn_file_code);

//4. Unique Customer Counts
layout_stat25a := record
	ds_main_unq.classification_permissible_use_access_fdn_file_code;
	total:= count(group);
end;
	
srt_unq_customer_counts_tbl := sort(table(ds_main_unq,layout_stat25a,classification_permissible_use_access_fdn_file_code,few),classification_permissible_use_access_fdn_file_code);

//5. Source Type Counts
layout_stat2 := record
	ds_main.classification_source_source_type;
	total:= count(group);
end;
	
srt_source_type_counts_tbl := sort(table(ds_main,layout_stat2,classification_source_source_type,few),classification_source_source_type);

//6. Unique Source Type Counts
layout_stat2a := record
	ds_main_unq.classification_source_source_type;
	total:= count(group);
end;
	
srt_unq_source_type_counts_tbl := sort(table(ds_main_unq,layout_stat2a,classification_source_source_type,few),classification_source_source_type);

//7. Entity Type Counts
layout_stat9 := record
	ds_main.classification_entity_entity_type;
	total:= count(group);
end;
	
srt_entity_counts_tbl := sort(table(ds_main,layout_stat9,classification_entity_entity_type,few),classification_entity_entity_type);

//8. Unique Entity Type Counts
layout_stat9a := record
	ds_main_unq.classification_entity_entity_type;
	total:= count(group);
end;
	
srt_unq_entity_counts_tbl := sort(table(ds_main_unq,layout_stat9a,classification_entity_entity_type,few),classification_entity_entity_type);

//9. Data Type Counts
layout_stat22 := record
	ds_main.classification_activity_category_or_fraudtype;
	total:= count(group);
end;
	
srt_data_type_counts_tbl := sort(table(ds_main,layout_stat22,classification_activity_category_or_fraudtype,few),classification_activity_category_or_fraudtype);

//10. Unique Data Type Counts
layout_stat22a := record
	ds_main_unq.classification_activity_category_or_fraudtype;
	total:= count(group);
end;
	
srt_unq_data_type_counts_tbl := sort(table(ds_main_unq,layout_stat22a,classification_activity_category_or_fraudtype,few),classification_activity_category_or_fraudtype);

//11. Time Stamp Counts
layout_stat16 := record
	ds_main.process_date;
	total:= count(group);
end;
	
srt_time_stamp_counts_tbl := sort(table(ds_main,layout_stat16,process_date,few),process_date);

//12. Unique Time Stamp Counts
layout_stat16a := record
	ds_main_unq.process_date;
	total:= count(group);
end;
	
srt_unq_time_stamp_counts_tbl := sort(table(ds_main_unq,layout_stat16a,process_date,few),process_date);


//Despray CSV to bctlpedata12 (one thor file and one csv file). FTP to \\Risk\inf\Data_Factory\DI_Landingzone
despray_srt_industry_counts_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_FDN_Industry_Counts_'+ filedate +'.csv',
																		pHostname, 
																		pTarget+ '/tbl_FDN_Industry_Counts_'+ filedate +'.csv'
																		,,,,true);
																		
despray_srt_unq_industry_counts_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_FDN_Unq_Industry_Counts_'+ filedate +'.csv',
																		pHostname, 
																		pTarget+ '/tbl_FDN_Unq_Industry_Counts_'+ filedate +'.csv'
																		,,,,true);

despray_srt_customer_counts_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_FDN_Customer_Counts_'+ filedate +'.csv',
																		pHostname, 
																		pTarget+ '/tbl_FDN_Customer_Counts_'+ filedate +'.csv'
																		,,,,true);
																		
despray_srt_unq_customer_counts_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_FDN_Unq_Customer_Counts_'+ filedate +'.csv',
																		pHostname, 
																		pTarget+ '/tbl_FDN_Unq_Customer_Counts_'+ filedate +'.csv'
																		,,,,true);

despray_srt_source_type_counts_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_FDN_Source_Type_Counts_'+ filedate +'.csv',
																		pHostname, 
																		pTarget+ '/tbl_FDN_Source_Type_Counts_'+ filedate +'.csv'
																		,,,,true);
																		
despray_srt_unq_source_type_counts_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_FDN_Unq_Source_Type_Counts_'+ filedate +'.csv',
																		pHostname, 
																		pTarget+ '/tbl_FDN_Unq_Source_Type_Counts_'+ filedate +'.csv'
																		,,,,true);

despray_srt_entity_counts_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_FDN_Entity_Counts_'+ filedate +'.csv',
																		pHostname, 
																		pTarget+ '/tbl_FDN_Entity_Counts_'+ filedate +'.csv'
																		,,,,true);
																		
despray_srt_unq_entity_counts_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_FDN_Unq_Entity_Counts_'+ filedate +'.csv',
																		pHostname, 
																		pTarget+ '/tbl_FDN_Unq_Entity_Counts_'+ filedate +'.csv'
																		,,,,true);

despray_srt_data_type_counts_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_FDN_Data_Type_Counts_'+ filedate +'.csv',
																		pHostname, 
																		pTarget+ '/tbl_FDN_Data_Type_Counts_'+ filedate +'.csv'
																		,,,,true);
																		
despray_srt_unq_data_type_counts_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_FDN_Unq_Data_Type_Counts_'+ filedate +'.csv',
																		pHostname, 
																		pTarget+ '/tbl_FDN_Unq_Data_Type_Counts_'+ filedate +'.csv'
																		,,,,true);

despray_srt_time_stamp_counts_tbl:= STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_FDN_Time_Stamp_Counts_'+ filedate +'.csv',
																		pHostname, 
																		pTarget+ '/tbl_FDN_Time_Stamp_Counts_'+ filedate +'.csv'
																		,,,,true);
																		
despray_srt_unq_time_stamp_counts_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_FDN_Unq_Time_Stamp_Counts_'+ filedate +'.csv',
																		pHostname, 
																		pTarget+ '/tbl_FDN_Unq_Time_Stamp_Counts_'+ filedate +'.csv'
																		,,,,true);

//if everything in the Sequential statement runs, it will send the Success email, else it will send the Failure email
email_alert := SEQUENTIAL(
					 output(srt_industry_counts_tbl,,'~thor_data400::data_insight::data_metrics::tbl_FDN_Industry_Counts_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))
					,output(srt_unq_industry_counts_tbl,,'~thor_data400::data_insight::data_metrics::tbl_FDN_Unq_Industry_Counts_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))
					,output(srt_customer_counts_tbl,,'~thor_data400::data_insight::data_metrics::tbl_FDN_Customer_Counts_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))
					,output(srt_unq_customer_counts_tbl,,'~thor_data400::data_insight::data_metrics::tbl_FDN_Unq_Customer_Counts_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))
					,output(srt_source_type_counts_tbl,,'~thor_data400::data_insight::data_metrics::tbl_FDN_Source_Type_Counts_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))
					,output(srt_unq_source_type_counts_tbl,,'~thor_data400::data_insight::data_metrics::tbl_FDN_Unq_Source_Type_Counts_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))
					,output(srt_entity_counts_tbl,,'~thor_data400::data_insight::data_metrics::tbl_FDN_Entity_Counts_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))
					,output(srt_unq_entity_counts_tbl,,'~thor_data400::data_insight::data_metrics::tbl_FDN_Unq_Entity_Counts_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))
					,output(srt_data_type_counts_tbl,,'~thor_data400::data_insight::data_metrics::tbl_FDN_Data_Type_Counts_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))
					,output(srt_unq_data_type_counts_tbl,,'~thor_data400::data_insight::data_metrics::tbl_FDN_Unq_Data_Type_Counts_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))
					,output(srt_time_stamp_counts_tbl,,'~thor_data400::data_insight::data_metrics::tbl_FDN_Time_Stamp_Counts_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))
					,output(srt_unq_time_stamp_counts_tbl,,'~thor_data400::data_insight::data_metrics::tbl_FDN_Unq_Time_Stamp_Counts_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))
					,despray_srt_industry_counts_tbl 
					,despray_srt_unq_industry_counts_tbl 
					,despray_srt_customer_counts_tbl 
					,despray_srt_unq_customer_counts_tbl 
					,despray_srt_source_type_counts_tbl 
					,despray_srt_unq_source_type_counts_tbl 
					,despray_srt_entity_counts_tbl 
					,despray_srt_unq_entity_counts_tbl 
					,despray_srt_data_type_counts_tbl 
					,despray_srt_unq_data_type_counts_tbl 
					,despray_srt_time_stamp_counts_tbl
					,despray_srt_unq_time_stamp_counts_tbl ):
					Success(FileServices.SendEmail(pContact, 'FDN Group: FDN_Metrics Build Succeeded', workunit + ': Build complete.' + filedate)),
					Failure(FileServices.SendEmail(pContact, 'FDN Group: FDN_Metrics Build Failed', workunit + filedate + '\n' + FAILMESSAGE)
					);
return email_alert;

end;
