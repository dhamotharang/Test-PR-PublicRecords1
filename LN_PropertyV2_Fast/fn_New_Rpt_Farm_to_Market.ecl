import ut,LN_PropertyV2_Fast, Codes, LN_PropertyV2, std, _validate;
EXPORT fn_New_Rpt_Farm_to_Market(string start_process_date = '', 
                                 string end_process_date 	 = '', 
                                 string prod_date          = '', 
								                 string qa_date 	         = '',
                                 string pversion           = '',
                                 string buildtype          = '',
																 string prev_prod_date     = '') := module

shared valid_date_comp (string date1, string date2) := _validate.date.fCorrectedDateString(date2) > _validate.date.fCorrectedDateString(date1) and _validate.date.fCorrectedDateString(date1) > '18000101' and _validate.date.fCorrectedDateString(date2) > '18000101' and _validate.date.fCorrectedDateString(date2) <= (STRING8)Std.Date.Today() and _validate.date.fCorrectedDateString(date1) <= (STRING8)Std.Date.Today();

//******************************* Raw Data File Names ********************************************
//****** Keeping OKC files commented out in case there's need to retrieve historical data ********
//shared bk_deed_fname       	:= '~thor_data::in::ln_propertyv2::raw::okc::deed_reporting2';
//shared bk_mrtg_fname       	:= '~thor_data::in::ln_propertyv2::raw::okc::mortgage_reporting2';
//shared bk_assess_fname     	:= '~thor_data::in::ln_propertyv2::raw::okc::assessment_reporting2';
//shared bk_assess_repl_fname	:= '~thor_data::in::ln_propertyv2::raw::okc::assessment_repl_reporting2';
shared bk_deed_fname        := '~thor_data::in::ln_propertyv2::raw::bk::deed_reporting2';
shared bk_mrtg_fname        := '~thor_data::in::ln_propertyv2::raw::bk::mortgage_reporting2';
shared bk_assess_fname      := '~thor_data::in::ln_propertyv2::raw::bk::assessment_reporting2';
shared bk_assess_repl_fname := '~thor_data::in::ln_propertyv2::raw::bk::assessment_repl_reporting2';
shared frs_deed_fname       := '~thor_data400::in::property::raw::frs::deed_reporting2';
shared frs_assess_fname     := '~thor_data400::in::property::raw::frs::assessment_reporting2';    
shared frs_assess_ptu_fname := '~thor_data400::in::property::raw::frs::assessment_ptu_reporting2';

//********************************** Deed Input Files *******************************************
				 raw_bk_deed_		:= dataset(bk_deed_fname, recordof(LN_PropertyV2_Fast.Files.raw.bk_deed), thor, OPT);
	shared raw_bk_deed		:= project(raw_bk_deed_, transform({recordof(LN_PropertyV2_Fast.Files.raw.bk_deed), string8 filedate, string7 source},
																	self.filedate := trim(left.raw_file_name, all)[length(trim(left.raw_file_name, all)) - 7.. length(trim(left.raw_file_name, all))], 
																	self.source := 'BK' , self := left));
//****** Keeping these lines commented out in case there's need to retrieve historical data for OKC *******
																	//self.filedate := if(left.raw_file_name[36..45]='deed::deed',
																											//'2015'+left.raw_file_name[50..53],
																											//trim(regexfind('.*deed::([0-9]{8}).*',left.raw_file_name,1), all)), 
																	//self.source := 'OKC' , self := left));

				 raw_bk_mrtg_		:= dataset(bk_mrtg_fname, recordof(LN_PropertyV2_Fast.Files.raw.bk_mortgage), thor, OPT);
	shared raw_bk_mrtg		:= project(raw_bk_mrtg_, transform({recordof(LN_PropertyV2_Fast.Files.raw.bk_mortgage), string8 filedate, string7 source},
																	self.filedate := trim(left.raw_file_name, all)[length(trim(left.raw_file_name, all)) - 7.. length(trim(left.raw_file_name, all))], self.source := 'BK-MTG' , self := left));
//****** Keeping these lines commented out in case there's need to retrieve historical data for OKC *******
																	//self.filedate := if(left.raw_file_name[36..45]='mort::deed',
																											//'2015'+left.raw_file_name[50..53],
																											//trim(regexfind('.*mort::([0-9]{8}).*',left.raw_file_name,1), all)), 
																	//self.source := 'OKC-MTG' , self := left));

				 raw_frs_deed_	:= dataset(frs_deed_fname, recordof(LN_PropertyV2_Fast.Files.raw.frs_deed), thor, OPT);
	shared raw_frs_deed		:= project(raw_frs_deed_, transform({recordof(LN_PropertyV2_Fast.Files.raw.frs_deed), string8 filedate, string7 source},
																	self.filedate := trim(left.raw_file_name, all)[length(trim(left.raw_file_name, all)) - 7.. length(trim(left.raw_file_name, all))], self.source := 'FRS' , self := left));

//******************************* Deed Record Age ***********************************************
	raw_deed_slim_ly_frs	:= record
	raw_frs_deed.source;
	raw_frs_deed.fips;
	string2  state;
	string   county_name	:= '';
	raw_frs_deed.document_type;
	string8  delivery_date;
	string8  sale_date;
	string8  recording_date;
	raw_frs_deed.mortgage_date;
	string8  trans_date;
	string8  max_input_date;
	end;

	raw_deed_slim_ly_bk		:= record
	raw_bk_deed.source;
	string5  fips_code;
	string2  state;
	string   county_name	:= '';
	string3  document_type;
	string8  delivery_date;
	string8  sale_date;
	string8  recording_date;
	string8  mortgage_date:= '';
	string8  trans_date;
	string8  max_input_date;
	end;

	raw_mrtg_slim_ly_bk		:= record
	raw_bk_mrtg.source;
	string5  fips_code;
	string2  state;
	string   county_name	:= '';
	string3  document_type;
	string8  delivery_date;
	string8  sale_date		:= '';
	string8  recording_date;
	string8  mortgage_date:= '';
	string8  trans_date;
	string8  max_input_date;
	end;

	raw_deed_slim_ly_frs t_days(raw_frs_deed le) := transform
	self.state						:= le.prop_state;
	self.sale_date				:= if(valid_date_comp(le.sale_date_yyyymmdd,(STRING8)Std.Date.Today()),le.sale_date_yyyymmdd,'');
	self.recording_date		:= if(valid_date_comp(le.recording_date_yyyymmdd,(STRING8)Std.Date.Today()),le.recording_date_yyyymmdd,'');
	self.delivery_date		:= le.filedate;
	self.trans_date				:= (string)MAX((unsigned)if(valid_date_comp(le.mortgage_date,(STRING8)Std.Date.Today()),le.mortgage_date,''),
																					 (unsigned)if(valid_date_comp(le.sale_date_yyyymmdd,(STRING8)Std.Date.Today()),le.sale_date_yyyymmdd,''));
	self.max_input_date		:= (string)max((unsigned)if(valid_date_comp(le.mortgage_date,(STRING8)Std.Date.Today()),le.mortgage_date,''),
																			 (unsigned)if(valid_date_comp(le.sale_date_yyyymmdd,(STRING8)Std.Date.Today()),le.sale_date_yyyymmdd,''),
																			 (unsigned)if(valid_date_comp(le.recording_date_yyyymmdd,(STRING8)Std.Date.Today()),le.recording_date_yyyymmdd,''));
	self									:= le;
	end;

	raw_deed_slim_ly_bk t_days2(raw_bk_deed le) := transform
	self.fips_code				:= le.FIPSCountyCode;
	self.document_type		:= le.DocumentTypeCode;
	self.state						:= le.StateCode;
	self.sale_date				:= (string)if(valid_date_comp((string)ut.Date_MMDDYYYY_I2(le.SaleDocContractDate),(STRING8)Std.Date.Today()),ut.Date_MMDDYYYY_I2(le.SaleDocContractDate),0);
	self.recording_date		:= (string)if(valid_date_comp((string)ut.Date_MMDDYYYY_I2(le.RecordingDate),(STRING8)Std.Date.Today()),ut.Date_MMDDYYYY_I2(le.RecordingDate),0);
	self.delivery_date		:= le.filedate;
	self.trans_date				:= (string)MAX(if(valid_date_comp((string)ut.Date_MMDDYYYY_I2(le.RecordingDate),(STRING8)Std.Date.Today()),ut.Date_MMDDYYYY_I2(le.RecordingDate),0),
																					 if(valid_date_comp((string)ut.Date_MMDDYYYY_I2(le.SaleDocContractDate),(STRING8)Std.Date.Today()),ut.Date_MMDDYYYY_I2(le.SaleDocContractDate),0));
	self.max_input_date		:= (string)MAX(if(valid_date_comp((string)ut.Date_MMDDYYYY_I2(le.RecordingDate),(STRING8)Std.Date.Today()),ut.Date_MMDDYYYY_I2(le.RecordingDate),0),
																					 if(valid_date_comp((string)ut.Date_MMDDYYYY_I2(le.SaleDocContractDate),(STRING8)Std.Date.Today()),ut.Date_MMDDYYYY_I2(le.SaleDocContractDate),0));
	self									:= le;
	end;

	raw_mrtg_slim_ly_bk t_days3(raw_bk_mrtg le) := transform
	self.fips_code				:= le.FIPSCode;
	self.document_type		:= le.DocumentTypeCode;
	self.state						:= le.State;
	self.sale_date				:= (string)if(valid_date_comp((string)ut.Date_MMDDYYYY_I2(le.ContractDate),(STRING8)Std.Date.Today()),ut.Date_MMDDYYYY_I2(le.ContractDate),0);
	self.recording_date		:= (string)if(valid_date_comp((string)ut.Date_MMDDYYYY_I2(le.RecordingDate),(STRING8)Std.Date.Today()),ut.Date_MMDDYYYY_I2(le.RecordingDate),0);
	self.delivery_date		:= le.filedate;
	self.trans_date				:= (string)MAX(if(valid_date_comp((string)ut.Date_MMDDYYYY_I2(le.RecordingDate),(STRING8)Std.Date.Today()),ut.Date_MMDDYYYY_I2(le.RecordingDate),0),
																					 if(valid_date_comp(le.ContractDate,(STRING8)Std.Date.Today()),(unsigned)le.ContractDate,0));
	self.max_input_date		:= (string)MAX(if(valid_date_comp((string)ut.Date_MMDDYYYY_I2(le.RecordingDate),(STRING8)Std.Date.Today()),ut.Date_MMDDYYYY_I2(le.RecordingDate),0),
																					 if(valid_date_comp(le.ContractDate,(STRING8)Std.Date.Today()),(unsigned)le.ContractDate,0));
	self									:= le;
	end;

	raw_deed_slim_frs			:= project(raw_frs_deed,t_days (left));
	raw_deed_slim_bk			:= project(raw_bk_deed, t_days2(left));
	raw_mrtg_slim_bk			:= project(raw_bk_mrtg, t_days3(left));
	shared raw_deed_slim	:= raw_deed_slim_frs + raw_deed_slim_bk + raw_mrtg_slim_bk;

//************************ Assessment files ********************************
	shared bk_assess			:= dataset(bk_assess_fname,recordof(LN_PropertyV2_Fast.Files.raw.bk_assessment), thor, OPT);

	shared bk_assess_repl := dataset(bk_assess_repl_fname,recordof(LN_PropertyV2_Fast.Files.raw.bk_assessment_repl), thor, OPT);

	shared frs_assess     := dataset(frs_assess_fname,recordof({LN_PropertyV2.Layout_Raw_Fares.Input_Assessor,string100 raw_file_name { virtual(logicalfilename)}}), thor, OPT);
										
	shared frs_assess_ptu := dataset(frs_assess_ptu_fname,recordof({LN_PropertyV2.Layout_Raw_Fares.Input_Assessor,string100 raw_file_name { virtual(logicalfilename)}}), thor, OPT);
														
	shared frs_assess_rpt := if(nothor(FileServices.GetSuperFileSubCount(LN_PropertyV2_Fast.Files_Vendor_Rpts.taxreport_frs_reporting_fname)) > 0,
															project(LN_PropertyV2_Fast.Files_Vendor_Rpts.taxreport_frs_reporting,
																		 transform(recordof(left), self.certdate := ut.date_slashed_MMDDYYYY_to_YYYYMMDD(left.certdate), self := left)),
															dataset([],recordof(LN_PropertyV2_Fast.Files_Vendor_Rpts.taxreport_frs_reporting)));       
	
	shared bk_assess_new_l := record
	recordof(bk_assess);
	string8 filedate;
	string7 source;
	end;
	
	shared frs_assess_new_l := record
	recordof(frs_assess);
	string8 filedate;
	string7 source;
	end;
	
	shared bk_assess_new      := project(bk_assess, transform(bk_assess_new_l,  self.filedate := trim(left.raw_file_name, all)[length(trim(left.raw_file_name, all)) - 7.. length(trim(left.raw_file_name, all))], self.source := 'BK', self := left)) (new_record_type_legal_description = '' );
	shared bk_assess_repl_new := project(bk_assess_repl, transform(bk_assess_new_l,  self.filedate := trim(left.raw_file_name, all)[length(trim(left.raw_file_name, all)) - 7.. length(trim(left.raw_file_name, all))], self.source := 'BK-RPL',  self := left)) (new_record_type_legal_description = '' );
//****** Keeping these lines commented out in case there's need to retrieve historical data for OKC *******
	//shared bk_assess_new      := project(bk_assess, transform(bk_assess_new_l,  self.filedate := trim(left.raw_file_name, all)[length(trim(left.raw_file_name, all)) - 7.. length(trim(left.raw_file_name, all))], self.source := 'OKC', self := left)) (new_record_type_legal_description = '' );
	//shared bk_assess_repl_new := project(bk_assess_repl, transform(bk_assess_new_l,  self.filedate := trim(left.raw_file_name, all)[length(trim(left.raw_file_name, all)) - 7.. length(trim(left.raw_file_name, all))], self.source := 'OKC-RPL',  self := left)) (new_record_type_legal_description = '' );
	shared frs_assess_new     := project(frs_assess, transform(frs_assess_new_l,  self.filedate := trim(left.raw_file_name, all)[length(trim(left.raw_file_name, all)) - 7.. length(trim(left.raw_file_name, all))], self.source := 'FRS', self := left));
	shared frs_assess_ptu_new := project(frs_assess_ptu, transform(frs_assess_new_l, self.filedate := trim(left.raw_file_name, all)[length(trim(left.raw_file_name, all)) - 7.. length(trim(left.raw_file_name, all))], self.source := 'FRS-PTU', self := left));
	
	shared assess_slim_ly := record
	string7  source;
	string5  fips;
	string2  State;
	string30 County_name;
	string3  document_type := '';
	string8  delivery_date;
	string8  recording_date;
	string8  cert_date;
	string8  tape_cut_date;
	string8  sale_date;
	string8  mortgage_date;
	string4  tax_year;
	string8  trans_date;
	string8  max_input_date;
	end;

	assess_slim_ly t_days1(bk_assess_new le) := transform
	self.state             := le.state_postal_code;
	self.fips := le.fips_code_state_county;
	self.document_type     := '';
	self.delivery_date     := le.filedate;
	self.tape_cut_date     := le.tape_cut_date[3..] + le.tape_cut_date[1..2] + '01'; 
	self.cert_date         := le.certification_date[length(le.certification_date)-3.. length(le.certification_date)] + le.certification_date[..2] + le.certification_date[3..4] ;
	self.recording_date    := le.recording_date[length(le.recording_date) - 3 .. length(le.recording_date)] + le.recording_date[1..2] + le.recording_date[3..4],
	self                   := le;
	self                   := [];
	end;

	shared bk_assess_new_slim := project(bk_assess_new + bk_assess_repl_new, t_days1(left));

	shared frs_assess_rpt_t := table(frs_assess_rpt, {fips, cert_date := max(group,certdate)}, fips, few);
	shared frs_assess_new_j := join(frs_assess_new + frs_assess_ptu_new, frs_assess_rpt, left.fips_code = right.fips and left.filedate = right.filedate, 
																		 transform({recordof(left), string8 cert_date}, self.cert_date := right.certdate, self := left),
																		 left outer);

	assess_slim_ly t_days2(frs_assess_new_j le) := transform
	self.state            := le.prop_state;
	self.fips             := le.fips_code;
	self.document_type    := '';
	self.delivery_date    := le.filedate;
	self.trans_date       := (string)MAX((unsigned)le.mortgage_date,(unsigned)le.sale_date);
	self.max_input_date   := (string)MAX((unsigned)le.mortgage_date,(unsigned)le.sale_date);
	self                  := le;
	self                  := [];
	end;

	shared frs_assess_new_slim := project(frs_assess_new_j, t_days2(left));

	shared assess_new_slim := frs_assess_new_slim + bk_assess_new_slim;

//*****************************************************************
export f_aggregate_data(ds, aggregate_field, filetype, rpttype):= functionmacro
	days_apart_stats_ly := RECORD
		ds.source;
		ds.delivery_date;
		unsigned RecordCount       := count(group);
#if(filetype = 'A')  
		string4 max_tax_year       := MAX(group, ds.tax_year);
		string4 min_tax_year       := MIN(group, if((unsigned)ds.tax_year = 0, '9999', ds.tax_year));
#end    
		string8 max_mortgage_date  := MAX(group, ds.mortgage_date);
		string8 max_trans_date     := MAX(group, ds.trans_date);
		string8 max_minput_date    := MAX(group, ds.max_input_date);
		string8 max_recording_date := MAX(group, ds.recording_date);
		string8 max_delivery_date  := MAX(group, ds.delivery_date);
#if(filetype = 'A')
	 string8 max_cert_date       := MAX(group, ds.cert_date);
	 string8 max_tape_cut_date   := MAX(group, ds.tape_cut_date);
#end
		string11 max_delivery_date_to_start_process_date_days := (string)MAX(group,(unsigned)ut.BusDaysApart((unsigned)ds.delivery_date, (unsigned)start_process_date)-
																																									 (if(Std.Date.DayOfWeek((integer)ds.delivery_date) in [1,7], 0, 1)));
		string11 max_delivery_date_to_end_process_date_days   := (string)MAX(group,(unsigned)ut.BusDaysApart((unsigned)ds.delivery_date, (unsigned)end_process_date));
		string11 max_delivery_date_to_prod_date_days          := (string)MAX(group,(unsigned)ut.BusDaysApart((unsigned)ds.delivery_date, (unsigned)prod_date));
#if(filetype = 'D')	
		string11 max_Days_from_Recording_to_Production				:= (string)MAX(group,(unsigned)ut.BusDaysApart((unsigned)ds.recording_date, (unsigned)prod_date));
#elseif(filetype = 'A')
		string11 max_Days_from_Cert_Date_to_Production				:= (string)MAX(group,(unsigned)ut.BusDaysApart((unsigned)ds.cert_date, (unsigned)prod_date));
		string11 max_Days_from_Tape_Cut_Date_to_Production		:= (string)MAX(group,(unsigned)ut.BusDaysApart((unsigned)ds.tape_cut_date, (unsigned)prod_date));
#end
	END;

	days_apart_stats	 := table(ds, days_apart_stats_ly, source, aggregate_field, few);

	days_apart_stats_t := project(days_apart_stats,
                              transform(days_apart_stats_ly,
                              self.max_mortgage_date  := if((unsigned)left.max_mortgage_date = 0, '-',left.max_mortgage_date),
                              self.max_trans_date     := if((unsigned)left.max_trans_date = 0, '-',left.max_trans_date),
                              self.max_recording_date := if((unsigned)left.max_recording_date = 0, '-',left.max_recording_date),
                              self.max_minput_date    := if((unsigned)left.max_minput_date = 0, '-',left.max_minput_date),
                              self.max_delivery_date  := if((unsigned)left.max_delivery_date = 0, '-',left.max_delivery_date),
                              
                              #if(filetype = 'A')  
                              self.max_tax_year       := if((unsigned)left.max_tax_year = 0, '-',left.max_tax_year),
                              self.max_cert_date      := if((unsigned)left.max_cert_date = 0, '-',left.max_cert_date),
                              self.max_tape_cut_date  := if((unsigned)left.max_tape_cut_date = 0, '-',left.max_tape_cut_date),
                              #end
                              
                              self := left));
                              
	return(days_apart_stats_t);                
endmacro;

shared fn_append_doctype (ds) := functionmacro
	codes_v3_doctype := dedup(sort(Codes.File_Codes_V3_In(field_name = 'DOCUMENT_TYPE'), file_name, code), file_name, code);

	get_doctype := join(project(ds, transform({recordof(ds), string filename}, self.filename := if(left.source[..3] = 'FRS', 'FARES_1080', 'PROPERTY_DEED'), self := left)),
											codes_v3_doctype,
											left.filename = trim(right.file_name,all) and
											trim(left.document_type, all) = trim(right.code, all),
											transform(recordof(ds),
																self.document_type := trim(left.document_type,all) + ' = ' + right.long_desc,
																self := left),
																left outer);
											 
	return get_doctype;
endmacro;

//******************************* Report Output Reformat *******************
shared t_reformat(ds, rpttype, rptby) := functionmacro
	ly_common := record
		string8  build_version;
		string5  build_type;
		string8  prod_release_date;
		string delivery_date;
		string7  source;
		unsigned RecordCount;
		string   percentage;
	#if(rpttype = 'D')
		string8  max_trans_date;
		string8  max_recording_date;
		string8  max_minput_date;
	#end
	#if(rpttype = 'A')
		string8  max_cert_date;
		string8  max_tape_cut_date;
		string4  min_tax_year;
		string4  max_tax_year;
	#end
		string max_delivery_date_to_start_process_date_days;
		string total_process_days;
		string deployment_days;
		string total_qa_days;
		string processing_days:='';
		string total_inhouse_days;
		string days_between_builds;
	end;

	total_recs := sum(ds,recordCount);
	ds_t1 := project(ds, transform(ly_common,
															self.build_version 				:= pversion;
															self.build_type 					:= buildtype;
															self.prod_release_date 		:= prod_date;
															self.percentage 					:= (string)((decimal5_2)(((decimal12_2)left.recordCount/(decimal12_2)total_recs) * 100.00)) + '%';
#if(rptby = 'delivery_date' or rptby = '')
															self.total_process_days 	:= (string)(ut.BusDaysApart((unsigned)start_process_date, (unsigned)end_process_date)-
																														 (if(Std.Date.DayOfWeek((unsigned)start_process_date) in [1,7], 0, 1))),
															self.deployment_days 			:= (string)(ut.BusDaysApart((unsigned)end_process_date, (unsigned)qa_date)-
																														 (if(Std.Date.DayOfWeek((unsigned)end_process_date) in [1,7], 0, 1))),
															self.total_qa_days 				:= (string)(ut.BusDaysApart((unsigned)qa_date, (unsigned)prod_date)-
																														 (if(Std.Date.DayOfWeek((unsigned)qa_date) in [1,7], 0, 1))),
															self.total_inhouse_days 	:= (string)(ut.BusDaysApart((unsigned)left.delivery_date, (unsigned)prod_date)-
																														 (if(Std.Date.DayOfWeek((unsigned)left.delivery_date) in [1,7], 0, 1))),
															self.days_between_builds 	:= (string)(ut.BusDaysApart((unsigned)prev_prod_date, (unsigned)prod_date)-
																														 (if(Std.Date.DayOfWeek((unsigned)prev_prod_date) in [1,7], 0, 1))),
#end
															self := left));
	ds_t := project(ds_t1,transform(ly_common,
#if(rptby = 'delivery_date' or rptby = '')
															self.max_delivery_date_to_start_process_date_days
																												:= if(left.max_delivery_date_to_start_process_date_days = '0','<1',left.max_delivery_date_to_start_process_date_days),
															self.total_process_days 	:= if(left.total_process_days = '0','<1',left.total_process_days),
															self.deployment_days 			:= if(left.deployment_days = '0','<1',left.deployment_days),
															self.total_qa_days 				:= if(left.total_qa_days = '0','<1',left.total_qa_days),
															self.processing_days			:= (string)((unsigned)left.total_process_days+(unsigned)left.deployment_days+(unsigned)left.total_qa_days);
															self.total_inhouse_days 	:= if(left.total_inhouse_days = '0','<1',left.total_inhouse_days),
															self.days_between_builds 	:= if(left.days_between_builds = '0','<1',left.days_between_builds),
#end
															self := left));
	return ds_t;
endmacro;

	//Deed Rpt by delivery_date
	shared deed_days_apart_stats_delivery_date_updated_ 	:= f_aggregate_data(raw_deed_slim, delivery_date, 'D', '');
	export deed_days_apart_stats_delivery_date_updated 		:= sort(t_reformat(deed_days_apart_stats_delivery_date_updated_(recordcount > 0), 'D', 'delivery_date'), delivery_date);

	//Assessor Rpt by delivery_date
	shared assess_days_apart_stats_delivery_date_updated_ := f_aggregate_data(assess_new_slim, delivery_date, 'A', '');
	export assess_days_apart_stats_delivery_date_updated 	:= sort(t_reformat(assess_days_apart_stats_delivery_date_updated_(recordcount > 0), 'A', 'delivery_date'), delivery_date);

end;