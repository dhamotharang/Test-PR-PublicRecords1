import ut,LN_PropertyV2_Fast, Codes, LN_PropertyV2, _validate;
EXPORT fn_Reports_Farm_to_Market(string start_process_date = '', string end_process_date = '', string prod_date = '') := module


shared valid_date_comp (string date1, string date2) := _validate.date.fCorrectedDateString(date2) > _validate.date.fCorrectedDateString(date1) and _validate.date.fCorrectedDateString(date1) > '18000101' and _validate.date.fCorrectedDateString(date2) > '18000101' and _validate.date.fCorrectedDateString(date2) <= ut.GetDate and _validate.date.fCorrectedDateString(date1) <= ut.GetDate;

//*******************************Raw Data File Names *********************************************
shared frs_deed_fname := '~thor_data400::in::property::raw::frs::deed_reporting';
shared bk_assess_fname := '~thor_data::in::ln_propertyv2::raw::bk::assessment_reporting';
shared bk_assess_repl_fname := '~thor_data::in::ln_propertyv2::raw::bk::assessment_repl_reporting';
shared frs_assess_fname :='~thor_data400::in::property::raw::frs::assessment_reporting';		
shared frs_assess_ptu_fname :=	'~thor_data400::in::property::raw::frs::assessment_ptu_reporting';

//*******************************FARES Deed Input Files *********************************************

shared raw_frs_deed_ := if(nothor(FileServices.GetSuperFileSubCount(frs_deed_fname)) > 0,
																	dataset(frs_deed_fname, recordof(LN_PropertyV2_Fast.Files.raw.frs_deed), thor),
																	dataset([],recordof(LN_PropertyV2_Fast.Files.raw.frs_deed)));
shared raw_frs_deed := project(raw_frs_deed_, transform({recordof(LN_PropertyV2_Fast.Files.raw.frs_deed), string8 filedate, string7 source},
											          self.filedate := trim(left.raw_file_name, all)[length(trim(left.raw_file_name, all)) - 7.. length(trim(left.raw_file_name, all))], self.source := 'FRS' , self := left));
shared raw_deed := raw_frs_deed;
//*******************************Deed Record Age ***********************************************
raw_deed_slim_ly := record
raw_deed.source;
raw_deed.fips;
string2 state;
string county_name := '';
raw_deed.document_type;
string8 delivery_date;
string8 sale_date;
string8 recording_date;
raw_deed.mortgage_date;
string8 trans_date;
string11 sale_date_to_recording_date_days := 0;
string11 mortgage_date_to_recording_date_days := 0;
string11 trans_date_to_recording_date_days := 0;
string11 recording_date_to_delivery_date_days := 0;
end;

raw_deed_slim_ly t_days(raw_deed le) := transform
self.state := le.prop_state;
self.sale_date := le.sale_date_yyyymmdd;
self.recording_date := le.recording_date_yyyymmdd;
self.delivery_date := le.filedate;
self.trans_date := (string)ut.max2((unsigned)le.mortgage_date,(unsigned)le.sale_date_yyyymmdd);
self.sale_date_to_recording_date_days := (string)if( valid_date_comp(le.sale_date_yyyymmdd, le.recording_date_yyyymmdd), ut.DaysApart(le.sale_date_yyyymmdd, le.recording_date_yyyymmdd), 0);
self.mortgage_date_to_recording_date_days := (string)if(valid_date_comp(le.mortgage_date,le.recording_date_yyyymmdd), ut.DaysApart(le.mortgage_date, le.recording_date_yyyymmdd), 0);
self.trans_date_to_recording_date_days := (string) if(valid_date_comp(self.trans_date,le.recording_date_yyyymmdd), ut.DaysApart(self.trans_date, le.recording_date_yyyymmdd), 0);
self.recording_date_to_delivery_date_days := (string)if(valid_date_comp (le.recording_date_yyyymmdd, le.filedate), ut.DaysApart(le.recording_date_yyyymmdd, le.filedate), 0);
self := le;
end;

shared raw_deed_slim := project(raw_deed, t_days(left));

//************************Assessment files
	  shared bk_assess		:=	if(nothor(FileServices.GetSuperFileSubCount(bk_assess_fname)) > 0,
															dataset(bk_assess_fname,
																recordof(LN_PropertyV2_Fast.Files.raw.bk_assessment), thor),
															 dataset([], recordof(LN_PropertyV2_Fast.Files.raw.bk_assessment)));
		shared bk_assess_repl := if(nothor(FileServices.GetSuperFileSubCount(bk_assess_repl_fname)) > 0,
															dataset(bk_assess_repl_fname,
															recordof(LN_PropertyV2_Fast.Files.raw.bk_assessment_repl), thor),
															dataset([], recordof(LN_PropertyV2_Fast.Files.raw.bk_assessment_repl)));
		shared frs_assess		:=	if(nothor(FileServices.GetSuperFileSubCount(frs_assess_fname)) > 0,
															dataset(frs_assess_fname, 
															recordof({LN_PropertyV2.Layout_Raw_Fares.Input_Assessor,string100 raw_file_name { virtual(logicalfilename)}}), thor),
															dataset([],{LN_PropertyV2.Layout_Raw_Fares.Input_Assessor, string100 raw_file_name { virtual(logicalfilename)}}));
											
		shared frs_assess_ptu :=	if(nothor(FileServices.GetSuperFileSubCount(frs_assess_ptu_fname)) > 0,
															dataset(frs_assess_ptu_fname, 
															recordof({LN_PropertyV2.Layout_Raw_Fares.Input_Assessor,string100 raw_file_name { virtual(logicalfilename)}}), thor),
															dataset([],{LN_PropertyV2.Layout_Raw_Fares.Input_Assessor, string100 raw_file_name { virtual(logicalfilename)}}));
															
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
		
		shared bk_assess_new := project(bk_assess, transform(bk_assess_new_l,  self.filedate := trim(left.raw_file_name, all)[length(trim(left.raw_file_name, all)) - 7.. length(trim(left.raw_file_name, all))], self.source := 'bk', self := left)) (new_record_type_legal_description = '' );
		shared bk_assess_repl_new := project(bk_assess_repl, transform(bk_assess_new_l,  self.filedate := trim(left.raw_file_name, all)[length(trim(left.raw_file_name, all)) - 7.. length(trim(left.raw_file_name, all))], self.source := 'bk-RPL',  self := left)) (new_record_type_legal_description = '' );
		shared frs_assess_new := project(frs_assess, transform(frs_assess_new_l,  self.filedate := trim(left.raw_file_name, all)[length(trim(left.raw_file_name, all)) - 7.. length(trim(left.raw_file_name, all))], self.source := 'FRS', self := left));
	  shared frs_assess_ptu_new := project(frs_assess_ptu, transform(frs_assess_new_l, self.filedate := trim(left.raw_file_name, all)[length(trim(left.raw_file_name, all)) - 7.. length(trim(left.raw_file_name, all))], self.source := 'FRS-PTU', self := left));
		
shared assess_slim_ly := record
string7 source;
string5 fips;
string2 State;
string30 County_name;
string3 document_type := '';
string8 delivery_date;
string8 recording_date;
string8 cert_date;
string8 tape_cut_date;
string8 sale_date;
string8 mortgage_date;
string4 tax_year;
string8 trans_date;
string11 recording_date_to_tape_cut_date_days;
string11 sale_date_to_recording_date_days := 0;
string11 mortgage_date_to_recording_date_days := 0;
string11 trans_date_to_recording_date_days := 0;
string11 recording_date_to_delivery_date_days := 0;
string11 tape_cut_date_to_delivery_date_days := 0;
string11 cert_date_to_tape_cut_date_days := 0;
string11 cert_date_to_delivery_date_days := 0;
end;

assess_slim_ly t_days1(bk_assess_new le) := transform
self.state := le.state_postal_code;
self.fips := le.fips_code_state_county;
self.document_type := '';
self.delivery_date := le.filedate;
self.tape_cut_date := le.tape_cut_date[3..] + le.tape_cut_date[1..2] + '01'; 
self.cert_date := le.certification_date[length(le.certification_date)-3.. length(le.certification_date)] + le.certification_date[..2] + le.certification_date[3..4] ;
self.recording_date := le.recording_date[length(le.recording_date) - 3 .. length(le.recording_date)] + le.recording_date[1..2] + le.recording_date[3..4],
self.recording_date_to_delivery_date_days := (string)if(valid_date_comp (self.recording_date, le.filedate), ut.DaysApart(self.recording_date, le.filedate), 0);
self.recording_date_to_tape_cut_date_days := (string)if(valid_date_comp (self.recording_date, self.tape_cut_date), ut.DaysApart(self.recording_date, self.tape_cut_date), 0);
self.tape_cut_date_to_delivery_date_days := (string)if(valid_date_comp (self.tape_cut_date, le.filedate), ut.DaysApart(self.tape_cut_date, le.filedate), 0);
self.cert_date_to_tape_cut_date_days := (string)if(valid_date_comp (self.cert_date, self.tape_cut_date), ut.DaysApart(self.cert_date, self.tape_cut_date), 0);
self.cert_date_to_delivery_date_days := (string)if(valid_date_comp (self.cert_date, le.filedate), ut.DaysApart(self.cert_date, le.filedate), 0);
self := le;
self := [];
end;

shared bk_assess_new_slim := project(bk_assess_new + bk_assess_repl_new, t_days1(left));


shared frs_assess_rpt_t := table(frs_assess_rpt, {fips, cert_date := max(group,certdate)}, fips, few);
shared frs_assess_new_j := join(frs_assess_new + frs_assess_ptu_new, frs_assess_rpt, left.fips_code = right.fips and left.filedate = right.filedate, 
																	 transform({recordof(left), string8 cert_date}, self.cert_date := right.certdate, self := left),
																	 left outer);

assess_slim_ly t_days2(frs_assess_new_j le) := transform
self.state := le.prop_state;
self.fips := le.fips_code;
self.document_type := '';
self.delivery_date := le.filedate;
self.trans_date := (string)ut.max2((unsigned)le.mortgage_date,(unsigned)le.sale_date);
self.sale_date_to_recording_date_days := (string)if( valid_date_comp(le.sale_date, le.recording_date), ut.DaysApart(le.sale_date, le.recording_date), 0);
self.mortgage_date_to_recording_date_days := (string)if(valid_date_comp(le.mortgage_date,le.recording_date), ut.DaysApart(le.mortgage_date, le.recording_date), 0);
self.trans_date_to_recording_date_days := (string) if(valid_date_comp(self.trans_date,le.recording_date), ut.DaysApart(self.trans_date, le.recording_date), 0);
self.recording_date_to_delivery_date_days := (string)if(valid_date_comp (le.recording_date, le.filedate), ut.DaysApart(le.recording_date, le.filedate), 0);
//self.recording_date_to_tape_cut_date_days := (string)if(valid_date_comp (le.recording_date, le.tape_cut_date), ut.DaysApart(le.recording_date, le.tape_cut_date), 0);
//self.tape_cut_date_to_delivery_date_days := (string)if(valid_date_comp (le.tape_cut_date, le.filedate), ut.DaysApart(le.tape_cut_date, le.filedate), 0);
self.cert_date_to_delivery_date_days := (string)if(valid_date_comp (le.cert_date, le.filedate), ut.DaysApart(le.cert_date, le.filedate), 0);

self := le;
self := [];
end;

shared frs_assess_new_slim := project(frs_assess_new_j, t_days2(left));

shared assess_new_slim := frs_assess_new_slim + bk_assess_new_slim;

//*****************************************************************
export f_aggregate_data(ds, aggregate_field, filetype, rpttype):= functionmacro
days_apart_stats_ly := RECORD
  ds.source;
  ds.fips;
	ds.state;
	ds.county_name;
	ds.delivery_date;
	string30 document_type := ds.document_type;
  unsigned RecordCount:= count(group);
#if(filetype = 'A')	
	string4 max_tax_year :=  MAX(group, ds.tax_year);
	string4 min_tax_year :=  MIN(group, if((unsigned)ds.tax_year = 0, '9999', ds.tax_year));
#end		
  string8 max_sale_date := MAX(group, ds.sale_date);
	string8 min_sale_date := MIN(group, if((unsigned)ds.sale_date = 0, '99999999', ds.sale_date));
	string8 max_mortgage_date:= MAX(group, ds.mortgage_date);
	string8 min_mortgage_date := MIN(group, if((unsigned)ds.mortgage_date = 0, '99999999', ds.mortgage_date));
	string8 max_trans_date := MAX(group, ds.trans_date);
	string8 min_trans_date :=  MIN(group, if((unsigned)ds.trans_date = 0, '99999999', ds.trans_date));
	string8 max_recording_date:= MAX(group, ds.recording_date);
	string8 min_recording_date:= MIN(group, if((unsigned)ds.recording_date = 0, '99999999', ds.recording_date));
  string8 max_delivery_date:= MAX(group, ds.delivery_date);
	string8 min_delivery_date:= MIN(group, if((unsigned)ds.delivery_date = 0, '99999999', ds.delivery_date));

#if(filetype = 'A')
 string8 max_cert_date:= MAX(group, ds.cert_date);
 string8 min_cert_date:= MIN(group, if((unsigned)ds.cert_date = 0, '99999999', ds.cert_date));
 string8 max_tape_cut_date:= MAX(group, ds.tape_cut_date);
 string8 min_tape_cut_date:= MIN(group, if((unsigned)ds.tape_cut_date = 0, '99999999', ds.tape_cut_date));
#end
	
	string11 avg_sale_date_to_recording_date_days := (string)(unsigned)AVE(group, (unsigned)ds.sale_date_to_recording_date_days);
	string11 max_sale_date_to_recording_date_days := (string)MAX(group, (unsigned)ds.sale_date_to_recording_date_days);
	string11 min_sale_date_to_recording_date_days := (string)MIN(group, if((unsigned)ds.sale_date_to_recording_date_days = 0, 99999999999, (unsigned)ds.sale_date_to_recording_date_days));
	string11 avg_mortgage_date_to_recording_date_days := (string)(unsigned)AVE(group, (unsigned)ds.mortgage_date_to_recording_date_days);
	string11 max_mortgage_date_to_recording_date_days := (string)MAX(group, (unsigned)ds.mortgage_date_to_recording_date_days);
	string11 min_mortgage_date_to_recording_date_days := (string)MIN(group, if((unsigned)ds.mortgage_date_to_recording_date_days = 0, 99999999999, (unsigned)ds.mortgage_date_to_recording_date_days));
	string11 avg_trans_date_to_recording_date_days := (string)(unsigned)AVE(group, (unsigned)ds.trans_date_to_recording_date_days);
	string11 max_trans_date_to_recording_date_days := (string)MAX(group, (unsigned)ds.trans_date_to_recording_date_days);
	string11 min_trans_date_to_recording_date_days := (string)MIN(group, if((unsigned)ds.trans_date_to_recording_date_days = 0, 99999999999, (unsigned)ds.trans_date_to_recording_date_days));
	string11 avg_recording_date_to_delivery_date_days := (string)(unsigned)AVE(group, (unsigned)ds.recording_date_to_delivery_date_days);
	string11 max_recording_date_to_delivery_date_days := (string)MAX(group, (unsigned)ds.recording_date_to_delivery_date_days);
	string11 min_recording_date_to_delivery_date_days := (string)MIN(group, if((unsigned)ds.recording_date_to_delivery_date_days = 0, 99999999999, (unsigned)ds.recording_date_to_delivery_date_days));		

#if(filetype = 'A')
	string11 avg_recording_date_to_tape_cut_date_days := (string)(unsigned)AVE(group, (unsigned)ds.recording_date_to_tape_cut_date_days);
	string11 max_recording_date_to_tape_cut_date_days := (string)MAX(group, (unsigned)ds.recording_date_to_tape_cut_date_days);
	string11 min_recording_date_to_tape_cut_date_days := (string)MIN(group, if((unsigned)ds.recording_date_to_tape_cut_date_days = 0, 99999999999, (unsigned)ds.recording_date_to_tape_cut_date_days));		
	
	string11 avg_tape_cut_date_to_delivery_date_days := (string)(unsigned)AVE(group, (unsigned)ds.tape_cut_date_to_delivery_date_days);
	string11 max_tape_cut_date_to_delivery_date_days := (string)MAX(group, (unsigned)ds.tape_cut_date_to_delivery_date_days);
	string11 min_tape_cut_date_to_delivery_date_days := (string)MIN(group, if((unsigned)ds.tape_cut_date_to_delivery_date_days = 0, 99999999999, (unsigned)ds.tape_cut_date_to_delivery_date_days));		

	string11 avg_cert_date_to_tape_cut_date_days := (string)(unsigned)AVE(group, (unsigned)ds.cert_date_to_tape_cut_date_days);
	string11 max_cert_date_to_tape_cut_date_days := (string)MAX(group, (unsigned)ds.cert_date_to_tape_cut_date_days);
	string11 min_cert_date_to_tape_cut_date_days := (string)MIN(group, if((unsigned)ds.cert_date_to_tape_cut_date_days = 0, 99999999999, (unsigned)ds.cert_date_to_tape_cut_date_days));		


	string11 avg_cert_date_to_delivery_date_days := (string)(unsigned)AVE(group, (unsigned)ds.cert_date_to_delivery_date_days);
	string11 max_cert_date_to_delivery_date_days := (string)MAX(group, (unsigned)ds.cert_date_to_delivery_date_days);
	string11 min_cert_date_to_delivery_date_days := (string)MIN(group, if((unsigned)ds.cert_date_to_delivery_date_days = 0, 99999999999, (unsigned)ds.cert_date_to_delivery_date_days));		



#end

  string11 avg_delivery_date_to_start_process_date_days := (string)(unsigned)AVE(group,(unsigned)ut.DaysApart(ds.delivery_date, (string)start_process_date));
  string11 max_delivery_date_to_start_process_date_days := (string)MAX(group,(unsigned)ut.DaysApart(ds.delivery_date, (string)start_process_date));
  string11 min_delivery_date_to_start_process_date_days := (string)MIN(group,(unsigned)ut.DaysApart(ds.delivery_date, (string) start_process_date));
	
  string11 avg_delivery_date_to_end_process_date_days := (string)(unsigned)AVE(group,(unsigned)ut.DaysApart(ds.delivery_date, (string)end_process_date));
  string11 max_delivery_date_to_end_process_date_days := (string)MAX(group,(unsigned)ut.DaysApart(ds.delivery_date, (string)end_process_date));
  string11 min_delivery_date_to_end_process_date_days := (string)MIN(group,(unsigned)ut.DaysApart(ds.delivery_date, (string) end_process_date));
	
  string11 avg_delivery_date_to_prod_date_days := (string)(unsigned)AVE(group,(unsigned)ut.DaysApart(ds.delivery_date, (string)prod_date));
  string11 max_delivery_date_to_prod_date_days := (string)MAX(group,(unsigned)ut.DaysApart(ds.delivery_date, (string)prod_date));
  string11 min_delivery_date_to_prod_date_days := (string)MIN(group,(unsigned)ut.DaysApart(ds.delivery_date, (string) prod_date));


	unsigned avg_total_days := '0';
	unsigned max_total_days := '0';
	unsigned min_total_days := '0';
END;

#if(rpttype = 'F')
days_apart_stats := table(ds, days_apart_stats_ly, source, fips, delivery_date, document_type, few);
#else
days_apart_stats := table(ds, days_apart_stats_ly, source, aggregate_field, few);
#end

days_apart_stats_t := project(days_apart_stats,
															transform(days_apart_stats_ly,
															self.max_sale_date := if((unsigned)left.max_sale_date = 0, '-',left.max_sale_date),
															self.min_sale_date  :=  if((unsigned)left.min_sale_date = 99999999, '-', left.min_sale_date),
															self.max_mortgage_date := if((unsigned)left.max_mortgage_date = 0, '-',left.max_mortgage_date),
															self.min_mortgage_date  :=  if((unsigned)left.min_mortgage_date = 99999999, '-', left.min_mortgage_date),
															self.max_trans_date := if((unsigned)left.max_trans_date = 0, '-',left.max_trans_date),
															self.min_trans_date  :=  if((unsigned)left.min_trans_date = 99999999, '-', left.min_trans_date),
															self.max_recording_date := if((unsigned)left.max_recording_date = 0, '-',left.max_recording_date),
															self.min_recording_date  :=  if((unsigned)left.min_recording_date = 99999999, '-', left.min_recording_date),
															self.max_delivery_date := if((unsigned)left.max_delivery_date = 0, '-',left.max_delivery_date),
															self.min_delivery_date  :=  if((unsigned)left.min_delivery_date = 99999999, '-', left.min_delivery_date),
													
															self.avg_sale_date_to_recording_date_days := if(self.max_sale_date = '-' or self.max_recording_date = '-' , '-', left.avg_sale_date_to_recording_date_days ),
															self.max_sale_date_to_recording_date_days := if(self.max_sale_date = '-' or self.max_recording_date = '-', '-', left.max_sale_date_to_recording_date_days ),
															self.min_sale_date_to_recording_date_days := if(self.max_sale_date = '-' or self.max_recording_date = '-', '-', if((unsigned)left.min_sale_date_to_recording_date_days <> 99999999999, left.min_sale_date_to_recording_date_days, '0')),
															
															self.avg_mortgage_date_to_recording_date_days := if(self.max_mortgage_date = '-' or self.max_recording_date = '-', '-', left.avg_mortgage_date_to_recording_date_days ),
															self.max_mortgage_date_to_recording_date_days := if(self.max_mortgage_date = '-' or self.max_recording_date = '-', '-', left.max_mortgage_date_to_recording_date_days ),
															self.min_mortgage_date_to_recording_date_days := if(self.max_mortgage_date = '-' or self.max_recording_date = '-', '-', if((unsigned)left.min_mortgage_date_to_recording_date_days <> 99999999999, left.min_mortgage_date_to_recording_date_days, '0')),
															
															self.avg_trans_date_to_recording_date_days := if(self.max_trans_date = '-' or self.max_recording_date = '-', '-', left.avg_trans_date_to_recording_date_days ),
															self.max_trans_date_to_recording_date_days := if(self.max_trans_date = '-' or self.max_recording_date = '-', '-', left.max_trans_date_to_recording_date_days ),
															self.min_trans_date_to_recording_date_days := if(self.max_trans_date = '-' or self.max_recording_date = '-', '-', if((unsigned)left.min_trans_date_to_recording_date_days  <> 99999999999,left.min_trans_date_to_recording_date_days, '0')),													
															
															self.avg_recording_date_to_delivery_date_days := if(self.max_recording_date = '-' or self.max_delivery_date = '-', '-', left.avg_recording_date_to_delivery_date_days),
															self.max_recording_date_to_delivery_date_days := if(self.max_recording_date = '-' or self.max_delivery_date = '-', '-', left.max_recording_date_to_delivery_date_days),
															self.min_recording_date_to_delivery_date_days := if(self.max_recording_date = '-' or self.max_delivery_date = '-', '-', if((unsigned)left.min_recording_date_to_delivery_date_days <> 99999999999, left.min_recording_date_to_delivery_date_days, '0')),											
															
															self.avg_total_days := (unsigned)left.avg_delivery_date_to_prod_date_days + (unsigned)self.avg_trans_date_to_recording_date_days + (unsigned)self.avg_recording_date_to_delivery_date_days;
															self.max_total_days := (unsigned)left.max_delivery_date_to_prod_date_days + (unsigned)self.max_trans_date_to_recording_date_days + (unsigned)self.max_recording_date_to_delivery_date_days;
															self.min_total_days := (unsigned)left.min_delivery_date_to_prod_date_days + (unsigned)self.min_trans_date_to_recording_date_days + (unsigned)self.min_recording_date_to_delivery_date_days;
															
															#if(filetype = 'A')	
															self.max_tax_year :=  if((unsigned)left.max_tax_year = 0, '-',left.max_tax_year),
															self.min_tax_year :=  if((unsigned)left.min_tax_year = 9999, '-', left.min_tax_year),
															self.max_cert_date := if((unsigned)left.max_cert_date = 0, '-',left.max_cert_date),
															self.min_cert_date  :=  if((unsigned)left.min_cert_date = 99999999, '-', left.min_cert_date),
															self.max_tape_cut_date := if((unsigned)left.max_tape_cut_date = 0, '-',left.max_tape_cut_date),
															self.min_tape_cut_date  :=  if((unsigned)left.min_tape_cut_date = 99999999, '-', left.min_tape_cut_date),
															self.avg_recording_date_to_tape_cut_date_days := if(self.max_recording_date = '-' or self.max_tape_cut_date = '-', '-', left.avg_recording_date_to_tape_cut_date_days),
															self.max_recording_date_to_tape_cut_date_days := if(self.max_recording_date = '-' or self.max_tape_cut_date = '-', '-', left.max_recording_date_to_tape_cut_date_days),
															self.min_recording_date_to_tape_cut_date_days := if(self.max_recording_date = '-' or self.max_tape_cut_date = '-', '-', if((unsigned)left.min_recording_date_to_tape_cut_date_days <> 99999999999, left.min_recording_date_to_tape_cut_date_days, '0')),																
															self.avg_tape_cut_date_to_delivery_date_days := if(self.max_tape_cut_date = '-' or self.max_delivery_date = '-', '-', left.avg_tape_cut_date_to_delivery_date_days),
															self.max_tape_cut_date_to_delivery_date_days := if(self.max_tape_cut_date = '-' or self.max_delivery_date = '-', '-', left.max_tape_cut_date_to_delivery_date_days),
															self.min_tape_cut_date_to_delivery_date_days := if(self.max_tape_cut_date = '-' or self.max_delivery_date = '-', '-', if((unsigned)left.min_tape_cut_date_to_delivery_date_days <> 99999999999, left.min_tape_cut_date_to_delivery_date_days, '0')),															self.avg_cert_date_to_delivery_date_days := if(self.max_cert_date = '-' or self.max_delivery_date = '-', '-', left.avg_cert_date_to_delivery_date_days),
															self.max_cert_date_to_delivery_date_days := if(self.max_cert_date = '-' or self.max_delivery_date = '-', '-', left.max_cert_date_to_delivery_date_days),
															self.min_cert_date_to_delivery_date_days := if(self.max_cert_date = '-' or self.max_delivery_date = '-', '-', if((unsigned)left.min_cert_date_to_delivery_date_days <> 99999999999, left.min_cert_date_to_delivery_date_days, '0')),																
															self.avg_cert_date_to_tape_cut_date_days := if(self.max_cert_date = '-' or self.max_tape_cut_date = '-', '-', left.avg_cert_date_to_tape_cut_date_days),
															self.max_cert_date_to_tape_cut_date_days := if(self.max_cert_date = '-' or self.max_tape_cut_date = '-', '-', left.max_cert_date_to_tape_cut_date_days),
															self.min_cert_date_to_tape_cut_date_days := if(self.max_cert_date = '-' or self.max_tape_cut_date = '-', '-', if((unsigned)left.min_cert_date_to_tape_cut_date_days <> 99999999999, left.min_cert_date_to_tape_cut_date_days, '0')),																
															#end
															
															
															self := left));
															
return(days_apart_stats_t);								
endmacro;

shared fn_append_county_data (ds) := functionmacro
county_lookup := dataset('~thor_400::fips_code_lookup',{string5 fips_code, string2 state_code, string30 county_name}, thor);

get_county_data_ := join(county_lookup, ds, left.fips_code = right.fips, full outer);
get_county_data := join(get_county_data_(county_name = ''),county_lookup, left.state_code = right.state_code and trim(left.county_name,all) = trim(right.county_name,all), left outer);
get_county_data_t := project(get_county_data + get_county_data_(county_name <> ''),
													   transform({recordof(left) -[fips, state]},
														 self.fips_code := if(left.fips_code <> '', left.fips_code, left.fips),
														 self.state_code := if(left.state_code <> '', left.state_code, left.state),
														 self := left));

return dedup(sort(get_county_data_t, source, fips_code, state_code, county_name, delivery_date, document_type), source, fips_code, state_code, county_name, delivery_date, document_type);
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

//*******************************Report Output Reformat
shared t_reformat(ds, rpttype, rptby) := functionmacro
ly_common := record
#if(rptby = 'fips' or rptby = '')
string state_code;
string county_name;
string fips_code;
#end
#if(rptby = 'delivery_date' or rptby = '')
string delivery_date;
#end
#if(rptby = 'document_type' or rptby = '')
string document_type;
#end
string7 source;
unsigned RecordCount;
string percentage;
string8 max_trans_date;
string8 max_recording_date;
string8 as_of_date;
string8 max_delivery_date;
#if(rpttype = 'A')
string8 max_cert_date;
string8 max_tape_cut_date;
string4 min_tax_year;
string4 max_tax_year;
#end
string11 avg_trans_date_to_recording_date_days;
string11 max_trans_date_to_recording_date_days;
string11 avg_recording_date_to_delivery_date_days;
string11 max_recording_date_to_delivery_date_days;
#if(rpttype = 'A')
string11 avg_cert_date_to_delivery_date_days;
string11 max_cert_date_to_delivery_date_days;
string11 avg_tape_cut_date_to_delivery_date_days;
string11 max_tape_cut_date_to_delivery_date_days;
#end
string11 avg_delivery_date_to_start_process_date_days;
string11 max_delivery_date_to_start_process_date_days;
string11 total_process_days;
string11 total_qa_days;
string11 avg_total_days;
string11 max_total_days;
end;

total_recs := sum(ds,recordCount);
ds_t := project(ds, transform(ly_common,
															self.percentage := (string)((decimal5_2)(((decimal12_2)left.recordCount/(decimal12_2)total_recs) * 100.00)) + '%';
															self.as_of_date := (string)ut.max2((unsigned)left.max_trans_date,(unsigned)left.max_recording_date),
															self.total_process_days :=  (string)ut.DaysApart(start_process_date, end_process_date),
															self.total_qa_days :=  (string)ut.DaysApart(end_process_date, prod_date),
															#if(rpttype = 'D')
															self.avg_total_days :=  (string)((unsigned)left.avg_trans_date_to_recording_date_days + (unsigned)left.avg_recording_date_to_delivery_date_days + (unsigned)left.avg_delivery_date_to_start_process_date_days + (unsigned)self.total_process_days + (unsigned)self.total_qa_days),
															self.max_total_days :=(string)((unsigned)left.max_trans_date_to_recording_date_days + (unsigned)left.max_recording_date_to_delivery_date_days + (unsigned)left.max_delivery_date_to_start_process_date_days + (unsigned)self.total_process_days + (unsigned)self.total_qa_days),
															#end
															#if(rpttype = 'A')
															self.avg_total_days :=  (string)((unsigned)left.avg_cert_date_to_delivery_date_days + (unsigned)left.avg_delivery_date_to_start_process_date_days + (unsigned)self.total_process_days + (unsigned)self.total_qa_days),
															self.max_total_days :=(string)((unsigned)left.max_cert_date_to_delivery_date_days + (unsigned)left.max_delivery_date_to_start_process_date_days + (unsigned)self.total_process_days + (unsigned)self.total_qa_days),
															#end
															self := left));
return ds_t;
endmacro;

//*********************************Deed Reports
//Deed Rpt by county
shared deed_days_apart_stats_cnty := fn_append_county_data(f_aggregate_data(raw_deed_slim, fips, 'D', ''));
export deed_days_apart_stats_cnty_updated := sort(t_reformat(deed_days_apart_stats_cnty (recordcount > 0), 'D', 'fips'), state_code, county_name, fips_code);

//Deed Rpt by delivery_date
shared deed_days_apart_stats_delivery_date_updated_ := f_aggregate_data(raw_deed_slim, delivery_date, 'D', '');
export deed_days_apart_stats_delivery_date_updated := sort(t_reformat(deed_days_apart_stats_delivery_date_updated_(recordcount > 0), 'D', 'delivery_date'), delivery_date);

//Deed Rpt by document type
shared deed_days_apart_stats_doctype := fn_append_doctype(f_aggregate_data(raw_deed_slim, document_type, 'D', ''));
export deed_days_apart_stats_doctype_updated := sort(t_reformat(deed_days_apart_stats_doctype, 'D', 'document_type'), document_type);

//Assessor Rpt by County and delivery_date
shared deed_days_apart_stats_all := fn_append_doctype(fn_append_county_data(f_aggregate_data(raw_deed_slim, fips, 'D', 'F')));
export deed_days_apart_stats_all_updated := sort(t_reformat(deed_days_apart_stats_all(recordcount > 0), 'D', ''), state_code, county_name, fips_code, delivery_date, document_type);

//Deed Rpt counties not updated
//shared ds_deed:= dataset('~thor_data400::base::ln_propertyv2::deed_20140912', LN_PropertyV2.Layouts.layout_deed_mortgage_common_model_base_scrubs, thor);	
shared ds_deed:= LN_PropertyV2.file_deed;	
shared ds_deed_g  :=  table(ds_deed(fips_code <>  ''), {fips_code, max_process_Date := max(group, process_date)}, fips_code, few);
shared ds_deed_j := join(deed_days_apart_stats_cnty(recordcount = 0), ds_deed_g, left.fips_code = right.fips_code);
export deed_noupdate_days_apart_stats_cnty := project(ds_deed_j, transform({string state_code, string county_name, string fips_code, string max_process_date, string days_since_last_update}, self.days_since_last_update := (string)ut.DaysApart(left.max_process_date, prod_date), self := left)); 

//*********************************Assessment Reports
//Assessor Rpt by County
//export assess_update_days_apart_stats_cnty := join(f_aggregate_data(assess_new_slim, fips, 'A', '') , county_lookup , left.fips = right.fips or (left.state = right.state_code and trim(left.county_name,all) = trim(right.county_name,all)), transform(recordof(left), self.county_name := right.county_name, self.fips := right.fips, self := left), all);
shared assess_days_apart_stats_cnty := fn_append_county_data(f_aggregate_data(assess_new_slim, fips, 'A', ''));
export assess_days_apart_stats_cnty_updated := sort(t_reformat(assess_days_apart_stats_cnty(RecordCount > 0), 'A', 'fips'), state_code, county_name, fips_code);

//Assessor Rpt by delivery_date
shared assess_days_apart_stats_delivery_date_updated_ := f_aggregate_data(assess_new_slim, delivery_date, 'A', '');
export assess_days_apart_stats_delivery_date_updated := sort(t_reformat(assess_days_apart_stats_delivery_date_updated_(recordcount > 0), 'A', 'delivery_date'), delivery_date);

//Assessor Rpt by County and delivery_date
shared assess_days_apart_stats_all := fn_append_county_data(f_aggregate_data(assess_new_slim, fips, 'A', 'F'));
export assess_days_apart_stats_all_updated := sort(t_reformat(assess_days_apart_stats_all(RecordCount > 0), 'A', ''), state_code, county_name, fips_code, delivery_date);

//Assess Rpt counties not updated
//shared ds_assess:= dataset('~thor_data400::base::ln_propertyv2::assesor_20140912a',LN_PropertyV2.Layouts.layout_property_common_model_base_scrubs, thor);	
shared ds_assess:= LN_PropertyV2.file_assessment;	
shared ds_assess_slim:= project(ds_assess, {ds_assess.fips_code, ds_assess.process_date});	
shared ds_assess_g  :=  table(ds_assess_slim(fips_code <>  ''), {fips_code, max_process_Date := max(group, process_date)}, fips_code, few);
shared ds_assess_j := join(assess_days_apart_stats_cnty(recordcount = 0), ds_assess_g, left.fips_code = right.fips_code);
export assess_noupdate_days_apart_stats_cnty := project(ds_assess_j, transform({string state_code, string county_name, string fips_code,string max_process_date, string days_since_last_update}, self.days_since_last_update := (string)ut.DaysApart(left.max_process_date, prod_date), self := left)); 

shared deed_update_counties_body := 'Start Process Date :' + start_process_date + '\n' +
																		'End Process Date :' + end_process_date + '\n' +
																		'Production Release Date: ' + prod_date + '\n\n' ;
																		
//export deed_updated_counties :=  sequential(LN_PropertyV2.fn_send_email_attachment(deed_update_days_apart_stats_cnty, 'deed update' , deed_update_counties_body, pversion, 'PropertyDeedUpdatedCounties'));
//export deed_notupdated_counties :=  sequential(LN_PropertyV2.fn_send_email_attachment(deed_noupdate_days_apart_stats_cnty , 'deed noupdate' , 'List of Counties not updated in this version', pversion, 'PropertyDeedNotUpdatedCounties'));

//*************************************ASSESSMENT*****************************************
//
end;