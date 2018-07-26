/*2017-01-30T23:55:59Z (Robert Berger)
DF-18353
*/
import ut,LN_PropertyV2_Fast, Codes, LN_PropertyV2, _validate, dops, std, data_services;
EXPORT fn_New_Rpt_Farm_to_Market_hist (string pversion ='') := module

shared valid_date_comp (string date1, string date2) := _validate.date.fCorrectedDateString(date2) > _validate.date.fCorrectedDateString(date1) and _validate.date.fCorrectedDateString(date1) > '18000101' and _validate.date.fCorrectedDateString(date2) > '18000101' and _validate.date.fCorrectedDateString(date2) <= (STRING8)Std.Date.Today() and _validate.date.fCorrectedDateString(date1) <= (STRING8)Std.Date.Today();

//******************************* Raw Data File Names ********************************************
shared frs_assess_fname    	:= data_services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::in::property::raw::frs::assessment_archive';
shared frs_assess_ptu_fname	:= data_services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::in::property::raw::frs::assessment_ptu_archive';
shared frs_deed_fname      	:= data_services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::in::property::raw::frs::deed_archive';
shared bk_assess_fname     	:= data_services.Data_location.Prefix('NONAMEGIVEN')+'thor_data::in::ln_propertyv2::raw::bk::assessment_archive';
shared bk_assess_repl_fname	:= data_services.Data_location.Prefix('NONAMEGIVEN')+'thor_data::in::ln_propertyv2::raw::bk::assessment_repl_archive';
shared bk_deed_fname       	:= data_services.Data_location.Prefix('NONAMEGIVEN')+'thor_data::in::ln_propertyv2::raw::bk::deed_archive';
shared bk_deed_repl_fname  	:= data_services.Data_location.Prefix('NONAMEGIVEN')+'thor_data::in::ln_propertyv2::raw::bk::deed_repl_archive';
shared bk_mrtg_fname       	:= data_services.Data_location.Prefix('NONAMEGIVEN')+'thor_data::in::ln_propertyv2::raw::bk::mortgage_archive';
shared bk_mrtg_repl_fname  	:= data_services.Data_location.Prefix('NONAMEGIVEN')+'thor_data::in::ln_propertyv2::raw::bk::mortgage_repl_archive';
shared okc_assess_fname     := data_services.Data_location.Prefix('NONAMEGIVEN')+'thor_data::in::ln_propertyv2::raw::okc::assessment_archive';
shared okc_assess_repl_fname:= data_services.Data_location.Prefix('NONAMEGIVEN')+'thor_data::in::ln_propertyv2::raw::okc::assessment_repl_archive';
shared okc_deed_fname      	:= data_services.Data_location.Prefix('NONAMEGIVEN')+'thor_data::in::ln_propertyv2::raw::okc::deed_archive';
shared okc_deed_repl_fname 	:= data_services.Data_location.Prefix('NONAMEGIVEN')+'thor_data::in::ln_propertyv2::raw::okc::deed_repl_archive';
shared okc_mrtg_fname      	:= data_services.Data_location.Prefix('NONAMEGIVEN')+'thor_data::in::ln_propertyv2::raw::okc::mortgage_archive';
shared okc_mrtg_repl_fname 	:= data_services.Data_location.Prefix('NONAMEGIVEN')+'thor_data::in::ln_propertyv2::raw::okc::mortgage_repl_archive';

//*DF-21489
/*shared bk_assess_new_fname 	:= data_services.Data_location.Prefix('NONAMEGIVEN')+'thor_data::in::ln_propertyv2::raw::bk::assessment::newcty';
shared bk_as_repl_new_fname := data_services.Data_location.Prefix('NONAMEGIVEN')+'thor_data::in::ln_propertyv2::raw::bk::assessment_repl::newcty';
shared bk_deed_new_fname 	  := data_services.Data_location.Prefix('NONAMEGIVEN')+'thor_data::in::ln_propertyv2::raw::bk::deed::newcty';
shared bk_mrtg_new_fname 	  := data_services.Data_location.Prefix('NONAMEGIVEN')+'thor_data::in::ln_propertyv2::raw::bk::mortgage::newcty';*/

//******************************* logical files info ********************************************
shared okc_currency_report := dedup(SORT(LN_PropertyV2_Fast.Files_Vendor_Rpts.currencyreport_bk,
																				FIPS,DOC_TYPE,/*key,*/-ut.ConvertDate(/*run_date*/KEYED_REC_THRU_DATE_IN_SITEX,'%m/%d/%Y','%Y%m%d')),
																		FIPS,DOC_TYPE/*key*/);
shared currency_report_cl := dedup(SORT(LN_PropertyV2_Fast.Files_Vendor_Rpts.currencyreport_clo,
																				FIPS,DOC_TYPE,/*key,*/-ut.ConvertDate(/*run_date*/KEYED_REC_THRU_DATE_IN_SITEX,'%m/%d/%Y','%Y%m%d')),
																		    FIPS,DOC_TYPE/*key*/);
																		
shared okc_assessor_currency_report := dedup(SORT(LN_PropertyV2_Fast.Files_Vendor_Rpts.assessorcurrencyreport_bk,
																									fips,-filedate),
																							fips);

shared build_metrics := LN_PropertyV2_Fast.File_Build_Metrics.file;

shared dops_layout := record
	string  certversion ;
	string  certwhenupdated ;
	string  prodversion ;
	string  prodwhenupdated ;
	string  updateflag ;
end;

shared dops_enh_layout := record
	string  certversion ;
	string  certwhenupdated ;
	string  prodversion ;
	string  prodwhenupdated ;
	string  updateflag ;
	string8 prep_start_date := '' ;
	string8 key_build_end_date := '' ;
	string5 update_type := '' ;
end;

shared dops_history_ := project(dops.GetReleaseHistory('B', 'N', 'LNPropertyV2Keys'),dops_layout);
shared dops_history	 := sort(join(dops_history_,build_metrics,left.prodversion[1..8]=right.version,transform(dops_enh_layout,self:=left,self:=right)),prodversion);

FsLogicalFileNameRecord := RECORD 
	STRING name; 
END;

fileinfoLayout := RECORD
	STRING superType;
	STRING logicalFileName;
	STRING fileDescription;
	STRING fileRecordCount;
	STRING procdate;
END;

addTofileinfo (STRING superFileName) := FUNCTION
	logicalFileNames := std.file.SuperFileContents('~'+superFileName);
	fileinfoLayout tFillReport(FsLogicalFileNameRecord L) := TRANSFORM
		SELF.superType := superFileName;
		SELF.logicalFileName := L.name;
		SELF.fileDescription := std.file.GetFileDescription( '~'+L.name );
		SELF.fileRecordCount := std.file.GetLogicalFileAttribute('~'+L.name ,'recordCount');
		SELF.procdate := regexfind('p.*date ([0-9]{8})',SELF.fileDescription,1); // To extract date from file description
	END;
	RETURN project(logicalFileNames,tFillReport(LEFT));
END;

shared file_info := sort(nothor(addTofileinfo(frs_assess_fname)+
																addTofileinfo(frs_assess_ptu_fname)+
																addTofileinfo(frs_deed_fname)+
																addTofileinfo(bk_assess_fname)+
																addTofileinfo(bk_assess_repl_fname)+
																addTofileinfo(bk_deed_fname)+
																addTofileinfo(bk_deed_repl_fname)+
																addTofileinfo(bk_mrtg_fname)+
																addTofileinfo(bk_mrtg_repl_fname)+
																addTofileinfo(okc_assess_fname  )+
																addTofileinfo(okc_assess_repl_fname)+
																addTofileinfo(okc_deed_fname)+
																addTofileinfo(okc_deed_repl_fname)+
																addTofileinfo(okc_mrtg_fname)+
																addTofileinfo(okc_mrtg_repl_fname)/*+
																addTofileinfo(bk_assess_new_fname)+
																addTofileinfo(bk_as_repl_new_fname)+
																addTofileinfo(bk_deed_new_fname)+
																addTofileinfo(bk_mrtg_new_fname)*/),logicalFileName) : persist('~thor_data::persist::propertyv2::file_info');

superinfolayout := record
 string superType;
 integer superfilecount;
end;

shared superfile_info := table(file_info,{superType,superfilecount:=count(group)},superType);

//********************************* Deed table by county ****************************************
export f_aggregate_deed(ds):= functionmacro
	recdeed1 := record
		string5  fips_code;
//** Keeping state and county name commented out in case there's need to change from FIPS to state county **
		//string2  state;
		//string18 county_name;
		string7  source;
		string8	 recording_date;
	end;
	filedeed 	:= sort(
									distribute(
											project(ds,
													transform(recdeed1,self.source:=map(left.vendor_source_flag+left.from_file in ['FF','SF'] => 'FRS',
																															left.vendor_source_flag+left.from_file in ['DD','OD'] => 'BK',
																															left.vendor_source_flag+left.from_file in ['DM','OM'] => 'BK-MTG',''),
																						 self := left)),
											hash(fips_code/*,state,county_name*/,source,recording_date)),
									fips_code,/*state,county_name,*/source,-recording_date,local);
	recdeed2 := record
		filedeed.fips_code;
		//filedeed.state;
		//filedeed.county_name;
		filedeed.source;
		string10 max_recording_date := MAX(group, if(filedeed.recording_date<(STRING8)Std.Date.Today(),filedeed.recording_date,'00000000'));
		unsigned RecordCount				:= count(group);
	end;
	tabledeed	:= table(filedeed,recdeed2,fips_code/*,state,county_name*/,source,merge,few);
	filereturn:= project(tabledeed,transform(recdeed2,self.max_recording_date:=ut.ConvertDate(left.max_recording_date,'%Y%m%d','%m/%d/%Y'),self:=left));
	return(filereturn);                
endmacro;

//********************************* Assessor table by county *************************************
export f_aggregate_assess(dsin):= functionmacro
	recassess1 := record
		string5  fips_code;
//** Keeping state and county name commented out in case there's need to change from FIPS to state county **
		//string2  state_code;
		//string18 county_name;
		string3  source;
		string8	 process_date;
		string4  tax_year;
		string4  assessed_value_year;

	end;
	 fileassess := sort(
										distribute(
												project(dsin,
														transform(
																recassess1,self.source:=map(left.vendor_source_flag in ['D','O'] => 'BK',
																														left.vendor_source_flag in ['F','S'] => 'FRS',''),
																					 self := left)),
												hash(fips_code/*,state_code,county_name*/,source,process_date)),
										fips_code,/*state_code,county_name,*/source,process_date,local);
	recassess2 := record
		fileassess.fips_code;
		//fileassess.state_code;
		//fileassess.county_name;
		fileassess.source;
		string8  max_process_date		:= MAX(group, if(fileassess.process_date<=(STRING8)Std.Date.Today(),fileassess.process_date,'00000000'));
		string4  max_tax_year    		:= MAX(group, fileassess.tax_year);
		string4  min_tax_year    		:= MIN(group, if((unsigned)fileassess.tax_year = 0, '9999', fileassess.tax_year));
		string4  max_assessment_year:= MAX(group, fileassess.assessed_value_year);
		string4  min_assessment_year:= MIN(group, if((unsigned)fileassess.assessed_value_year = 0, '9999', fileassess.assessed_value_year));
		unsigned RecordCount		 		:= count(group);
	end;
	tableassessor	:= table(fileassess,recassess2,fips_code,/*state_code,county_name,*/source);
	return(tableassessor);                
endmacro;

//********************************* Expansion counties ******************************************
shared newfipssam		:= set(LN_PropertyV2_Fast.File_New_BK_Counties_Temp.mtg,fips);
shared newfipsdeeds	:= set(LN_PropertyV2_Fast.File_New_BK_Counties_Temp.deed,fips);
shared newfipsassess:= set(LN_PropertyV2_Fast.File_New_BK_Counties_Temp.assessor,fips);

//********************************** Deed Input Files *******************************************
raw_bk_deed_1o			:= dataset(bk_deed_fname, recordof(LN_PropertyV2_Fast.Files.raw.bk_deed), thor);
//raw_bk_deed_1n			:= dataset(bk_deed_new_fname, recordof(LN_PropertyV2_Fast.Files.raw.bk_deed), thor)(FIPSCountyCode in newfipsdeeds);
raw_bk_deed_1				:= dedup(raw_bk_deed_1o,record,all);
raw_bk_deed_2				:= project(raw_bk_deed_1,transform({recordof(LN_PropertyV2_Fast.Files.raw.bk_deed), 
																												string8 filedate, string7 source, string8 file_pdate:='', string8 file_prod_date:='', 
																												string5 file_build_type:='', string8 file_start_process_date:='', string8 file_end_process_date:=''},
																self.filedate := trim(left.raw_file_name,all)[length(trim(left.raw_file_name,all)) - 7.. length(trim(left.raw_file_name,all))], 
																self.source := 'BK' , 
																self := left));
raw_bk_deed_3				:= join(raw_bk_deed_2(filedate<=pversion),file_info(procdate<=pversion),left.raw_file_name=right.logicalFileName,
														transform(recordof(raw_bk_deed_2),
																self.file_pdate := right.procdate,
																self:=left),
														LEFT OUTER,MANY LOOKUP,few);
shared raw_bk_deed	:= join(raw_bk_deed_3(file_pdate<>''),dops_history,left.file_pdate=right.prodversion[1..8],
														transform(recordof(raw_bk_deed_3),
																self.filedate := if(left.filedate[5..8] in ['2013','2014','2015'], left.filedate[5..8]+left.filedate[1..4], left.filedate),
																self.file_prod_date := ut.ConvertDate(right.prodwhenupdated),
																self.file_start_process_date := right.prep_start_date,
																self.file_end_process_date := right.key_build_end_date,
																self.file_build_type := right.update_type,
																self:=left),
														LEFT OUTER,MANY LOOKUP,few);
												
raw_okc_deed_1			:= dedup(dataset(okc_deed_fname, recordof(LN_PropertyV2_Fast.Files.raw.bk_deed), thor),record,all);
raw_okc_deed_2			:= project(raw_okc_deed_1, transform({recordof(LN_PropertyV2_Fast.Files.raw.bk_deed), 
																												string8 filedate, string7 source, string8 file_pdate:='', string8 file_prod_date:='', 
																												string5 file_build_type:='', string8 file_start_process_date:='', string8 file_end_process_date:=''},
																self.filedate := if(left.raw_file_name[36..45]='deed::deed',
																										'20'+left.raw_file_name[54..55]+left.raw_file_name[50..53],
																										trim(regexfind('.*deed::([0-9]{8}).*',left.raw_file_name,1))), // To extract date from file name
																self.source := 'OKC' , 
																self := left));
raw_okc_deed_3			:= join(raw_okc_deed_2(filedate<=pversion),file_info(procdate<=pversion),left.raw_file_name=right.logicalFileName,
														transform(recordof(raw_okc_deed_2),
																self.file_pdate := right.procdate,
																self:=left),
														LEFT OUTER,MANY LOOKUP,few);
shared raw_okc_deed	:= join(raw_okc_deed_3(file_pdate<>''),dops_history,left.file_pdate=right.prodversion[1..8],
														transform(recordof(raw_okc_deed_3),
																self.filedate := if(left.filedate[5..8] in ['2013','2014','2015'], left.filedate[5..8]+left.filedate[1..4], left.filedate),
																self.file_prod_date := ut.ConvertDate(right.prodwhenupdated),
																self.file_start_process_date := right.prep_start_date,
																self.file_end_process_date := right.key_build_end_date,
																self.file_build_type := right.update_type,
																self:=left),
														LEFT OUTER,MANY LOOKUP,few);

raw_bk_mrtg_1o			:= dataset(bk_mrtg_fname, recordof(LN_PropertyV2_Fast.Files.raw.bk_mortgage), thor);
//raw_bk_mrtg_1n			:= dataset(bk_mrtg_new_fname, recordof(LN_PropertyV2_Fast.Files.raw.bk_mortgage), thor)(FIPSCode in newfipssam);
raw_bk_mrtg_1				:= dedup(raw_bk_mrtg_1o,record,all);
raw_bk_mrtg_2				:= project(raw_bk_mrtg_1, transform({recordof(LN_PropertyV2_Fast.Files.raw.bk_mortgage), 
																													string8 filedate, string7 source, string8 file_pdate:='', string8 file_prod_date:='', 
																													string5 file_build_type:='', string8 file_start_process_date:='', string8 file_end_process_date:=''},
                                self.filedate := trim(left.raw_file_name,all)[length(trim(left.raw_file_name,all)) - 7.. length(trim(left.raw_file_name,all))], 
																self.source := 'BK-MTG' , 
																self := left));
raw_bk_mrtg_3				:= join(raw_bk_mrtg_2(filedate<=pversion),file_info(procdate<=pversion),left.raw_file_name=right.logicalFileName,
														transform(recordof(raw_bk_mrtg_2),
																self.file_pdate := right.procdate,
																self:=left),
														LEFT OUTER,MANY LOOKUP,few);
shared raw_bk_mrtg	:= join(raw_bk_mrtg_3(file_pdate<>''),dops_history,left.file_pdate=right.prodversion[1..8],
														transform(recordof(raw_bk_mrtg_3),
																self.filedate := if(left.filedate[5..8] in ['2013','2014','2015'], left.filedate[5..8]+left.filedate[1..4], left.filedate),
																self.file_prod_date := ut.ConvertDate(right.prodwhenupdated),
																self.file_start_process_date := right.prep_start_date,
																self.file_end_process_date := right.key_build_end_date,
																self.file_build_type := right.update_type,
																self:=left),
														LEFT OUTER,MANY LOOKUP,few);

raw_okc_mrtg_1			:= dedup(dataset(okc_mrtg_fname, recordof(LN_PropertyV2_Fast.Files.raw.bk_mortgage), thor),record,all);
raw_okc_mrtg_2			:= project(raw_okc_mrtg_1, transform({recordof(LN_PropertyV2_Fast.Files.raw.bk_mortgage), 
																													string8 filedate, string7 source, string8 file_pdate:='', string8 file_prod_date:='', 
																													string5 file_build_type:='', string8 file_start_process_date:='', string8 file_end_process_date:=''},
																self.filedate := if(left.raw_file_name[36..45]='mort::deed',
																										'20'+left.raw_file_name[54..55]+left.raw_file_name[50..53],
																										trim(regexfind('.*mort::([0-9]{8}).*',left.raw_file_name,1))), // To extract date from file name
																self.source := 'OKC-MTG' , 
																self := left));
raw_okc_mrtg_3			:= join(raw_okc_mrtg_2(filedate<=pversion),file_info(procdate<=pversion),left.raw_file_name=right.logicalFileName,
														transform(recordof(raw_okc_mrtg_2),
																self.file_pdate := right.procdate,
																self:=left),
														LEFT OUTER,MANY LOOKUP,few);
shared raw_okc_mrtg	:= join(raw_okc_mrtg_3(file_pdate<>''),dops_history,left.file_pdate=right.prodversion[1..8],
												 		transform(recordof(raw_okc_mrtg_3),
																self.filedate := if(left.filedate[5..8] in ['2013','2014','2015'], left.filedate[5..8]+left.filedate[1..4], left.filedate),
																self.file_prod_date := ut.ConvertDate(right.prodwhenupdated),
																self.file_start_process_date := right.prep_start_date,
																self.file_end_process_date := right.key_build_end_date,
																self.file_build_type := right.update_type,
																self:=left),
														LEFT OUTER,MANY LOOKUP,few);

raw_frs_deed_1			:= dedup(dataset(frs_deed_fname, recordof(LN_PropertyV2_Fast.Files.raw.frs_deed), thor),record,all);
raw_frs_deed_2			:= project(raw_frs_deed_1, transform({recordof(LN_PropertyV2_Fast.Files.raw.frs_deed), 
																													string8 filedate, string7 source, string8 file_pdate:='', string8 file_prod_date:='', 
																													string5 file_build_type:='', string8 file_start_process_date:='', string8 file_end_process_date:=''},
                                self.filedate := trim(left.raw_file_name,all)[length(trim(left.raw_file_name,all)) - 7.. length(trim(left.raw_file_name,all))], 
																self.source := 'FRS' , 
																self := left));
raw_frs_deed_3			:= join(raw_frs_deed_2(filedate<=pversion),file_info(procdate<=pversion),left.raw_file_name=right.logicalFileName,
														transform(recordof(raw_frs_deed_2),
																self.file_pdate := right.procdate,
																self:=left),
														LEFT OUTER,MANY LOOKUP,few);
shared raw_frs_deed	:= join(raw_frs_deed_3(file_pdate<>''),dops_history,left.file_pdate=right.prodversion[1..8],
														transform(recordof(raw_frs_deed_3),
																self.filedate := if(left.filedate[5..8] in ['2013','2014','2015'], left.filedate[5..8]+left.filedate[1..4], left.filedate),
																self.file_prod_date := ut.ConvertDate(right.prodwhenupdated),
																self.file_start_process_date := right.prep_start_date,
																self.file_end_process_date := right.key_build_end_date,
																self.file_build_type := right.update_type,
																self:=left),
														LEFT OUTER,MANY LOOKUP,few);
												
//******************************* Deed Record Age ***********************************************
raw_deed_slim_ly_frs := record
	raw_frs_deed.file_pdate;
	raw_frs_deed.file_prod_date;
	raw_frs_deed.file_build_type;
	raw_frs_deed.file_start_process_date;
	raw_frs_deed.file_end_process_date;
	raw_frs_deed.source;
	raw_frs_deed.fips;
	string2  state;
	string   county_name   := '';
	raw_frs_deed.document_type;
	string8  delivery_date;
	string8  sale_date;
	string8  recording_date;
	raw_frs_deed.mortgage_date;
	string8  trans_date;
	string8  max_input_date;
end;

raw_deed_slim_ly_bk := record
	raw_bk_deed.file_pdate;
	raw_bk_deed.file_prod_date;
	raw_bk_deed.file_build_type;
	raw_bk_deed.file_start_process_date;
	raw_bk_deed.file_end_process_date;
	raw_bk_deed.source;
	string5  fips_code;
	string2  state;
	string   county_name   := '';
	string3  document_type;
	string8  delivery_date;
	string8  sale_date;
	string8  recording_date;
	string8  mortgage_date := '';
	string8  trans_date;
	string8  max_input_date;
end;

raw_mrtg_slim_ly_bk := record
	raw_bk_mrtg.file_pdate;
	raw_bk_mrtg.file_prod_date;
	raw_bk_mrtg.file_build_type;
	raw_bk_mrtg.file_start_process_date;
	raw_bk_mrtg.file_end_process_date;
	raw_bk_mrtg.source;
	string5  fips_code;
	string2  state;
	string   county_name   := '';
	string3  document_type;
	string8  delivery_date;
	string8  sale_date     := '';
	string8  recording_date;
	string8  mortgage_date := '';
	string8  trans_date;
	string8  max_input_date;
end;

raw_deed_slim_ly_okc := record
	raw_okc_deed.file_pdate;
	raw_okc_deed.file_prod_date;
	raw_okc_deed.file_build_type;
	raw_okc_deed.file_start_process_date;
	raw_okc_deed.file_end_process_date;
	raw_okc_deed.source;
	string5  fips_code;
	string2  state;
	string   county_name   := '';
	string3  document_type;
	string8  delivery_date;
	string8  sale_date;
	string8  recording_date;
	string8  mortgage_date := '';
	string8  trans_date;
	string8  max_input_date;
end;

raw_mrtg_slim_ly_okc := record
	raw_okc_mrtg.file_pdate;
	raw_okc_mrtg.file_prod_date;
	raw_okc_mrtg.file_build_type;
	raw_okc_mrtg.file_start_process_date;
	raw_okc_mrtg.file_end_process_date;
	raw_okc_mrtg.source;
	string5  fips_code;
	string2  state;
	string   county_name   := '';
	string3  document_type;
	string8  delivery_date;
	string8  sale_date     := '';
	string8  recording_date;
	string8  mortgage_date := '';
	string8  trans_date;
	string8  max_input_date;
end;

raw_deed_slim_ly_frs t_days(raw_frs_deed le) := transform
	self.state					:= le.prop_state;
	self.sale_date			:= if(valid_date_comp(le.sale_date_yyyymmdd,(STRING8)Std.Date.Today()),le.sale_date_yyyymmdd,'');
	self.recording_date	:= if(valid_date_comp(le.recording_date_yyyymmdd,(STRING8)Std.Date.Today()),le.recording_date_yyyymmdd,'');
	self.delivery_date	:= le.filedate;
	self.trans_date			:= (string)MAX((unsigned)if(valid_date_comp(le.mortgage_date,(STRING8)Std.Date.Today()),le.mortgage_date,''),
																				 (unsigned)if(valid_date_comp(le.sale_date_yyyymmdd,(STRING8)Std.Date.Today()),le.sale_date_yyyymmdd,''));
	self.max_input_date	:= (string)MAX((unsigned)if(valid_date_comp(le.mortgage_date,(STRING8)Std.Date.Today()),le.mortgage_date,''),
																		 (unsigned)if(valid_date_comp(le.sale_date_yyyymmdd,(STRING8)Std.Date.Today()),le.sale_date_yyyymmdd,''),
																		 (unsigned)if(valid_date_comp(le.recording_date_yyyymmdd,(STRING8)Std.Date.Today()),le.recording_date_yyyymmdd,''));
	self								:= le;
end;

raw_deed_slim_ly_bk t_days2(raw_bk_deed le) := transform
	self.fips_code      := le.FIPSCountyCode;
	self.document_type  := le.DocumentTypeCode;
	self.state          := le.StateCode;
	self.sale_date      := (string)if(valid_date_comp((string)ut.Date_MMDDYYYY_I2(le.SaleDocContractDate),(STRING8)Std.Date.Today()),ut.Date_MMDDYYYY_I2(le.SaleDocContractDate),0);
	self.recording_date := (string)if(valid_date_comp((string)ut.Date_MMDDYYYY_I2(le.RecordingDate),(STRING8)Std.Date.Today()),ut.Date_MMDDYYYY_I2(le.RecordingDate),0);
	self.delivery_date  := le.filedate;
	self.trans_date     := (string)MAX(if(valid_date_comp((string)ut.Date_MMDDYYYY_I2(le.RecordingDate),(STRING8)Std.Date.Today()),ut.Date_MMDDYYYY_I2(le.RecordingDate),0),
																				 if(valid_date_comp((string)ut.Date_MMDDYYYY_I2(le.SaleDocContractDate),(STRING8)Std.Date.Today()),ut.Date_MMDDYYYY_I2(le.SaleDocContractDate),0));
	self.max_input_date := (string)MAX(if(valid_date_comp((string)ut.Date_MMDDYYYY_I2(le.RecordingDate),(STRING8)Std.Date.Today()),ut.Date_MMDDYYYY_I2(le.RecordingDate),0),
																				 if(valid_date_comp((string)ut.Date_MMDDYYYY_I2(le.SaleDocContractDate),(STRING8)Std.Date.Today()),ut.Date_MMDDYYYY_I2(le.SaleDocContractDate),0));
	self                := le;
end;

raw_mrtg_slim_ly_bk t_days3(raw_bk_mrtg le) := transform
	self.fips_code      := le.FIPSCode;
	self.document_type  := le.DocumentTypeCode;
	self.state          := le.State;
	self.sale_date      := (string)if(valid_date_comp((string)ut.Date_MMDDYYYY_I2(le.ContractDate),(STRING8)Std.Date.Today()),ut.Date_MMDDYYYY_I2(le.ContractDate),0);
	self.recording_date := (string)if(valid_date_comp((string)ut.Date_MMDDYYYY_I2(le.RecordingDate),(STRING8)Std.Date.Today()),ut.Date_MMDDYYYY_I2(le.RecordingDate),0);
	self.delivery_date  := le.filedate;
	self.trans_date     := (string)MAX(if(valid_date_comp((string)ut.Date_MMDDYYYY_I2(le.RecordingDate),(STRING8)Std.Date.Today()),ut.Date_MMDDYYYY_I2(le.RecordingDate),0),
																				 if(valid_date_comp(le.ContractDate,(STRING8)Std.Date.Today()),(unsigned)le.ContractDate,0));
	self.max_input_date := (string)MAX(if(valid_date_comp((string)ut.Date_MMDDYYYY_I2(le.RecordingDate),(STRING8)Std.Date.Today()),ut.Date_MMDDYYYY_I2(le.RecordingDate),0),
																				 if(valid_date_comp(le.ContractDate,(STRING8)Std.Date.Today()),(unsigned)le.ContractDate,0));
	self                := le;
end;

raw_deed_slim_ly_okc t_days4(raw_okc_deed le) := transform
	self.fips_code      := le.FIPSCountyCode;
	self.document_type  := le.DocumentTypeCode;
	self.state          := le.StateCode;
	self.sale_date      := (string)if(valid_date_comp((string)ut.Date_MMDDYYYY_I2(le.SaleDocContractDate),(STRING8)Std.Date.Today()),ut.Date_MMDDYYYY_I2(le.SaleDocContractDate),0);
	self.recording_date := (string)if(valid_date_comp((string)ut.Date_MMDDYYYY_I2(le.RecordingDate),(STRING8)Std.Date.Today()),ut.Date_MMDDYYYY_I2(le.RecordingDate),0);
	self.delivery_date  := le.filedate;
	self.trans_date     := (string)MAX(if(valid_date_comp((string)ut.Date_MMDDYYYY_I2(le.RecordingDate),(STRING8)Std.Date.Today()),ut.Date_MMDDYYYY_I2(le.RecordingDate),0),
																				 if(valid_date_comp((string)ut.Date_MMDDYYYY_I2(le.SaleDocContractDate),(STRING8)Std.Date.Today()),ut.Date_MMDDYYYY_I2(le.SaleDocContractDate),0));
	self.max_input_date := (string)MAX(if(valid_date_comp((string)ut.Date_MMDDYYYY_I2(le.RecordingDate),(STRING8)Std.Date.Today()),ut.Date_MMDDYYYY_I2(le.RecordingDate),0),
																				if(valid_date_comp((string)ut.Date_MMDDYYYY_I2(le.SaleDocContractDate),(STRING8)Std.Date.Today()),ut.Date_MMDDYYYY_I2(le.SaleDocContractDate),0));
	self                := le;
end;

raw_mrtg_slim_ly_okc t_days5(raw_okc_mrtg le) := transform
	self.fips_code      := le.FIPSCode;
	self.document_type  := le.DocumentTypeCode;
	self.state          := le.State;
	self.sale_date      := (string)if(valid_date_comp((string)ut.Date_MMDDYYYY_I2(le.ContractDate),(STRING8)Std.Date.Today()),ut.Date_MMDDYYYY_I2(le.ContractDate),0);
	self.recording_date := (string)if(valid_date_comp((string)ut.Date_MMDDYYYY_I2(le.RecordingDate),(STRING8)Std.Date.Today()),ut.Date_MMDDYYYY_I2(le.RecordingDate),0);
	self.delivery_date  := le.filedate;
	self.trans_date     := (string)MAX(if(valid_date_comp((string)ut.Date_MMDDYYYY_I2(le.RecordingDate),(STRING8)Std.Date.Today()),ut.Date_MMDDYYYY_I2(le.RecordingDate),0),
																				 if(valid_date_comp(le.ContractDate,(STRING8)Std.Date.Today()),(unsigned)le.ContractDate,0));
	self.max_input_date := (string)MAX(if(valid_date_comp((string)ut.Date_MMDDYYYY_I2(le.RecordingDate),(STRING8)Std.Date.Today()),ut.Date_MMDDYYYY_I2(le.RecordingDate),0),
																				 if(valid_date_comp(le.ContractDate,(STRING8)Std.Date.Today()),(unsigned)le.ContractDate,0));
	self                := le;
end;

raw_deed_slim_frs     := project(raw_frs_deed,t_days (left));
raw_deed_slim_bk      := project(raw_bk_deed, t_days2(left));
raw_mrtg_slim_bk      := project(raw_bk_mrtg, t_days3(left));
raw_deed_slim_okc     := project(raw_okc_deed,t_days4(left));
raw_mrtg_slim_okc     := project(raw_okc_mrtg,t_days5(left));
shared raw_deed_slim  := raw_deed_slim_frs + raw_deed_slim_bk + raw_mrtg_slim_bk + raw_deed_slim_okc +raw_mrtg_slim_okc;

//************************ Assessment files ********************************
	bk_assesso 			    	:= dataset(bk_assess_fname,recordof(LN_PropertyV2_Fast.Files.raw.bk_assessment), thor, OPT);
	//bk_assessn     				:= dataset(bk_assess_new_fname,recordof(LN_PropertyV2_Fast.Files.raw.bk_assessment), thor, OPT)(fIPS_Code_State_County in newfipsassess);
	shared bk_assess			:= dedup(bk_assesso,record,all);

	bk_assess_replo				:= dataset(bk_assess_repl_fname,recordof(LN_PropertyV2_Fast.Files.raw.bk_assessment_repl), thor, OPT);
//	bk_assess_repln				:= dataset(bk_as_repl_new_fname,recordof(LN_PropertyV2_Fast.Files.raw.bk_assessment_repl), thor, OPT)(fIPS_Code_State_County in newfipsassess);
	shared bk_assess_repl := dedup(bk_assess_replo,record,all);

	shared okc_assess     := dedup(dataset(okc_assess_fname,recordof(LN_PropertyV2_Fast.Files.raw.bk_assessment), thor, OPT),record,all);
	shared okc_assess_repl:= dedup(dataset(okc_assess_repl_fname,recordof(LN_PropertyV2_Fast.Files.raw.bk_assessment_repl), thor, OPT),record,all);

	shared frs_assess     := dedup(dataset(frs_assess_fname,recordof({LN_PropertyV2.Layout_Raw_Fares.Input_Assessor,string100 raw_file_name { virtual(logicalfilename)}}), thor, OPT),record,all);
										
	shared frs_assess_ptu := dedup(dataset(frs_assess_ptu_fname,recordof({LN_PropertyV2.Layout_Raw_Fares.Input_Assessor,string100 raw_file_name { virtual(logicalfilename)}}), thor, OPT),record,all);
														
	shared frs_assess_rpt := if(nothor(FileServices.GetSuperFileSubCount(LN_PropertyV2_Fast.Files_Vendor_Rpts.taxreport_frs_reporting_fname)) > 0,
															project(LN_PropertyV2_Fast.Files_Vendor_Rpts.taxreport_frs_reporting,
																		 transform(recordof(left), self.certdate := ut.date_slashed_MMDDYYYY_to_YYYYMMDD(left.certdate), self := left)),
															dataset([],recordof(LN_PropertyV2_Fast.Files_Vendor_Rpts.taxreport_frs_reporting)));       
	
	
	shared bk_assess_new_l := record
		recordof(bk_assess);
		string8 file_pdate := '';
		string5 file_build_type := '';
		string8 file_start_process_date := '';
		string8 file_end_process_date := '';
		string8 file_prod_date := '';
		string8 filedate;
		string7 source;
	end;
	
	shared okc_assess_new_l := record
		recordof(okc_assess);
		string8 file_pdate := '';
		string5 file_build_type := '';
		string8 file_start_process_date := '';
		string8 file_end_process_date := '';
		string8 file_prod_date := '';
		string8 filedate;
		string7 source;
	end;

	shared frs_assess_new_l := record
		recordof(frs_assess);
		string8 file_pdate := '';
		string5 file_build_type := '';
		string8 file_start_process_date := '';
		string8 file_end_process_date := '';
		string8 file_prod_date := '';
		string8 filedate;
		string7 source;
	end;
	
	bk_assess_new_1  			:= project(bk_assess,
																				transform(bk_assess_new_l,  
																						self.filedate := trim(left.raw_file_name,all)[length(trim(left.raw_file_name,all)) - 7.. length(trim(left.raw_file_name,all))], 
																						self.source := 'BK' , 
																						self := left))(new_record_type_legal_description = '' );
	bk_assess_new_2				:= join(bk_assess_new_1(filedate<=pversion),file_info(procdate<=pversion),left.raw_file_name=right.logicalFileName,
																				transform(recordof(bk_assess_new_1),
																						self.file_pdate := right.procdate,
																						self:=left),
																LEFT OUTER,MANY LOOKUP,few);
	shared bk_assess_new	:= join(bk_assess_new_2,dops_history,left.file_pdate=right.prodversion[1..8],
																				transform(recordof(bk_assess_new_2),
																						self.filedate := if(left.filedate[5..8] in ['2013','2014','2015'], left.filedate[5..8]+left.filedate[1..4], left.filedate),
																						self.file_prod_date := ut.ConvertDate(right.prodwhenupdated),
																						self.file_start_process_date := right.prep_start_date,
																						self.file_end_process_date := right.key_build_end_date,
																						self.file_build_type := right.update_type,
																						self:=left),
																LEFT OUTER,MANY LOOKUP,few);

	bk_assess_repl_new_1  := project(bk_assess_repl, 
																				transform(bk_assess_new_l,  
																						self.filedate := trim(left.raw_file_name,all)[length(trim(left.raw_file_name,all)) - 7.. length(trim(left.raw_file_name,all))], 
																						self.source := 'BK',
																						self := left))(new_record_type_legal_description = '' );
	bk_assess_repl_new_2	:= join(bk_assess_repl_new_1(filedate<=pversion),file_info(procdate<=pversion),left.raw_file_name=right.logicalFileName,
																				transform(recordof(bk_assess_repl_new_1),
																						self.file_pdate := right.procdate,
																						self:=left),
																LEFT OUTER,MANY LOOKUP,few);    
	shared bk_assess_repl_new := join(bk_assess_repl_new_2,dops_history,left.file_pdate=right.prodversion[1..8],
																				transform(recordof(bk_assess_repl_new_2),
																						self.filedate := if(left.filedate[5..8] in ['2013','2014','2015'], left.filedate[5..8]+left.filedate[1..4], left.filedate),
																						self.file_prod_date := ut.ConvertDate(right.prodwhenupdated),
																						self.file_start_process_date := right.prep_start_date,
																						self.file_end_process_date := right.key_build_end_date,
																						self.file_build_type := right.update_type,
																						self:=left),
																LEFT OUTER,MANY LOOKUP,few);

	okc_assess_new_1			:= project(okc_assess, 
																				transform(okc_assess_new_l,  
																						self.filedate := trim(left.raw_file_name,all)[length(trim(left.raw_file_name,all)) - 7.. length(trim(left.raw_file_name,all))], 
																						self.source := 'OKC' , 
																						self := left))(new_record_type_legal_description = '' );
	okc_assess_new_2			:= join(okc_assess_new_1(filedate<=pversion),file_info(procdate<=pversion),left.raw_file_name=right.logicalFileName,
																				transform(recordof(okc_assess_new_1),
																						self.file_pdate := right.procdate,
																						self:=left),
																LEFT OUTER,MANY LOOKUP,few);    
	shared okc_assess_new := join(okc_assess_new_2,dops_history,left.file_pdate=right.prodversion[1..8],
																				transform(recordof(okc_assess_new_2),
																						self.filedate := if(left.filedate[5..8] in ['2013','2014','2015'], left.filedate[5..8]+left.filedate[1..4], left.filedate),
																						self.file_prod_date := ut.ConvertDate(right.prodwhenupdated),
																						self.file_start_process_date := right.prep_start_date,
																						self.file_end_process_date := right.key_build_end_date,
																						self.file_build_type := right.update_type,
																						self:=left),
																LEFT OUTER,MANY LOOKUP,few);

	okc_assess_repl_new_1 := project(okc_assess_repl, 
																				transform(okc_assess_new_l,  
																						self.filedate := trim(left.raw_file_name,all)[length(trim(left.raw_file_name,all)) - 7.. length(trim(left.raw_file_name,all))], 
																						self.source := 'OKC',
																						self := left))(new_record_type_legal_description = '' );
	okc_assess_repl_new_2	:= join(okc_assess_repl_new_1(filedate<=pversion),file_info(procdate<=pversion),left.raw_file_name=right.logicalFileName,
																				transform(recordof(okc_assess_repl_new_1),
																						self.file_pdate := right.procdate,
																						self:=left),
																LEFT OUTER,MANY LOOKUP,few);    
	shared okc_assess_repl_new:= join(okc_assess_repl_new_2,dops_history,left.file_pdate=right.prodversion[1..8],
																				transform(recordof(okc_assess_repl_new_2),
																						self.filedate := if(left.filedate[5..8] in ['2013','2014','2015'], left.filedate[5..8]+left.filedate[1..4], left.filedate),
																						self.file_prod_date := ut.ConvertDate(right.prodwhenupdated),
																						self.file_start_process_date := right.prep_start_date,
																						self.file_end_process_date := right.key_build_end_date,
																						self.file_build_type := right.update_type,
																						self:=left),
																LEFT OUTER,MANY LOOKUP,few);

	frs_assess_new_1  		:= project(frs_assess, 
																				transform(frs_assess_new_l,  
																						self.filedate := trim(left.raw_file_name,all)[length(trim(left.raw_file_name,all)) - 7.. length(trim(left.raw_file_name,all))], 
																						self.source := 'FRS' , 
																						self := left))	;
	frs_assess_new_2			:= join(frs_assess_new_1(filedate<=pversion),file_info(procdate<=pversion),left.raw_file_name=right.logicalFileName,
																				transform(recordof(frs_assess_new_1),
																						self.file_pdate := right.procdate,
																						self:=left),
																LEFT OUTER,MANY LOOKUP,few);    
	shared frs_assess_new := join(frs_assess_new_2,dops_history,left.file_pdate=right.prodversion[1..8],
																				transform(recordof(frs_assess_new_2),
																						self.filedate := if(left.filedate[5..8] in ['2013','2014','2015'], left.filedate[5..8]+left.filedate[1..4], left.filedate),
																						self.file_prod_date := ut.ConvertDate(right.prodwhenupdated),
																						self.file_start_process_date := right.prep_start_date,
																						self.file_end_process_date := right.key_build_end_date,
																						self.file_build_type := right.update_type,
																						self:=left),
																LEFT OUTER,MANY LOOKUP,few);

	frs_assess_ptu_new_1  := project(frs_assess_ptu, 
																				transform(frs_assess_new_l,  
																						self.filedate := trim(left.raw_file_name,all)[length(trim(left.raw_file_name,all)) - 7.. length(trim(left.raw_file_name,all))], 
																						self.source := 'FRS',
																						self := left));
	frs_assess_ptu_new_2	:= join(frs_assess_ptu_new_1(filedate<=pversion),file_info(procdate<=pversion),left.raw_file_name=right.logicalFileName,
																				transform(recordof(frs_assess_ptu_new_1),
																						self.file_pdate := right.procdate,
																						self:=left),
																LEFT OUTER,MANY LOOKUP,few);    
	shared frs_assess_ptu_new:= join(frs_assess_ptu_new_2,dops_history,left.file_pdate=right.prodversion[1..8],
																				transform(recordof(frs_assess_ptu_new_2),
																						self.filedate := if(left.filedate[5..8] in ['2013','2014','2015'], left.filedate[5..8]+left.filedate[1..4], left.filedate),
																						self.file_prod_date := ut.ConvertDate(right.prodwhenupdated),
																						self.file_start_process_date := right.prep_start_date,
																						self.file_end_process_date := right.key_build_end_date,
																						self.file_build_type := right.update_type,
																						self:=left),
																LEFT OUTER,MANY LOOKUP,few);

shared assess_slim_ly := record
	string8  file_pdate;
	string8  file_prod_date;
	string5  file_build_type;
	string8  file_start_process_date;
	string8  file_end_process_date;
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
	string4  assessment_Year;
	string8  trans_date;
	string8  max_input_date;
end;

assess_slim_ly t_days1(bk_assess_new le) := transform
self.state            := le.state_postal_code;
self.fips 						:= le.fips_code_state_county;
self.document_type    := '';
self.delivery_date    := le.filedate;
self.tape_cut_date    := le.tape_cut_date[3..] + le.tape_cut_date[1..2] + '01'; 
self.cert_date        := le.certification_date[length(le.certification_date)-3.. length(le.certification_date)] + le.certification_date[..2] + le.certification_date[3..4] ;
self.recording_date   := le.recording_date[length(le.recording_date) - 3 .. length(le.recording_date)] + le.recording_date[1..2] + le.recording_date[3..4],
self                  := le;
self                  := [];
end;

shared bk_assess_new_slim := project(bk_assess_new + bk_assess_repl_new + okc_assess_new + okc_assess_repl_new, t_days1(left));

shared frs_assess_new_j := join(frs_assess_new + frs_assess_ptu_new, frs_assess_rpt, left.fips_code = right.fips and left.filedate = right.filedate, 
                                   transform({recordof(left), string8 cert_date}, self.cert_date := right.certdate, self := left),
                                   left outer);

assess_slim_ly t_days2(frs_assess_new_j le) := transform
self.state            := le.prop_state;
self.fips             := le.fips_code;
self.document_type    := '';
self.delivery_date    := le.filedate;
self.assessment_Year	:= '';
self.trans_date       := (string)MAX((unsigned)le.mortgage_date,(unsigned)le.sale_date);
self.max_input_date   := (string)MAX((unsigned)le.mortgage_date,(unsigned)le.sale_date);
self                  := le;
self                  := [];
end;

shared frs_assess_new_slim := project(frs_assess_new_j, t_days2(left));

shared assess_new_slim := frs_assess_new_slim + bk_assess_new_slim;

//*****************************Function to agregate data ************************************
export f_aggregate_data(ds, aggregate_field, filetype, rpttype):= functionmacro
days_apart_stats_ly := RECORD
  ds.source;
  ds.fips;
	ds.delivery_date;
	ds.file_pdate;
// Keeping below fields state, county_name, and file_build_type for display purposes, 
// grouping is by source, FIPS, delivery date, and file_pdate (version), not a problem
// a fips corresponds to the same state and county name, and version to same build type.
// This is generating warning message but its not an issue
	ds.state; 
  ds.county_name;
	ds.file_build_type;
  unsigned RecordCount       := count(group);
#if(filetype = 'A')  
  string4 max_tax_year       := MAX(group, ds.tax_year);
  string4 min_tax_year       := MIN(group, if((unsigned)ds.tax_year = 0, '9999', ds.tax_year));
  string4 max_assessment_Year:= MAX(group, ds.assessment_Year);
  string4 min_assessment_Year:= MIN(group, if((unsigned)ds.assessment_Year = 0, '9999', ds.assessment_Year));
#end    
	string8 max_build_version	 := MAX(group, ds.file_pdate);
	string8 max_file_prod_date := MAX(group, ds.file_prod_date);
	string8 start_process_date := MAX(group, ds.file_start_process_date);
	string8 end_process_date   := MAX(group, ds.file_end_process_date);
  string8 max_sale_date      := MAX(group, ds.sale_date);
  string8 min_sale_date      := MIN(group, if((unsigned)ds.sale_date = 0, '99999999', ds.sale_date));
  string8 max_mortgage_date  := MAX(group, ds.mortgage_date);
  string8 min_mortgage_date  := MIN(group, if((unsigned)ds.mortgage_date = 0, '99999999', ds.mortgage_date));
  string8 max_trans_date     := MAX(group, ds.trans_date);
  string8 min_trans_date     := MIN(group, if((unsigned)ds.trans_date = 0, '99999999', ds.trans_date));
  string8 max_minput_date    := MAX(group, ds.max_input_date);
  string8 min_minput_date    := MIN(group, if((unsigned)ds.max_input_date = 0, '99999999', ds.max_input_date));
  string8 max_recording_date := MAX(group, if(ds.recording_date<ds.delivery_date and ds.recording_date<(STRING8)Std.Date.Today(),ds.recording_date,'00000000'));
  string8 min_recording_date := MIN(group, if((unsigned)ds.recording_date = 0, '99999999', ds.recording_date));
  string8 max_delivery_date  := MAX(group, ds.delivery_date);
  string8 min_delivery_date  := MIN(group, if((unsigned)ds.delivery_date = 0, '99999999', ds.delivery_date));

#if(filetype = 'A')
 string8 max_cert_date      := MAX(group, if(ds.cert_date<=(STRING8)Std.Date.Today(),ds.cert_date,'0'));
 string8 max_tape_cut_date  := MAX(group, if(ds.tape_cut_date<=(STRING8)Std.Date.Today(),ds.tape_cut_date,'0'));
#end
END;

days_apart_stats := table(ds, days_apart_stats_ly, source, fips, delivery_date, file_pdate, few);

days_apart_stats_t := project(days_apart_stats,
                              transform(days_apart_stats_ly,
															self.max_build_version	:= if((unsigned)left.max_build_version = 0, '-',left.max_build_version),
															self.max_file_prod_date	:= if((unsigned)left.max_file_prod_date = 0, '-',left.max_file_prod_date),
                              self.max_sale_date      := if((unsigned)left.max_sale_date = 0, '-',left.max_sale_date),
                              self.min_sale_date      := if((unsigned)left.min_sale_date = 99999999, '-', left.min_sale_date),
                              self.max_mortgage_date  := if((unsigned)left.max_mortgage_date = 0, '-',left.max_mortgage_date),
                              self.min_mortgage_date  := if((unsigned)left.min_mortgage_date = 99999999, '-', left.min_mortgage_date),
                              self.max_trans_date     := if((unsigned)left.max_trans_date = 0, '-',left.max_trans_date),
                              self.min_trans_date     := if((unsigned)left.min_trans_date = 99999999, '-', left.min_trans_date),
                              self.max_recording_date := if((unsigned)left.max_recording_date = 0, '-',left.max_recording_date),
                              self.min_recording_date := if((unsigned)left.min_recording_date = 99999999, '-', left.min_recording_date),
                              self.max_minput_date    := if((unsigned)left.max_minput_date = 0, '-',left.max_minput_date),
                              self.min_minput_date    := if((unsigned)left.min_minput_date = 99999999, '-', left.min_minput_date),
                              self.max_delivery_date  := if((unsigned)left.max_delivery_date = 0, '-',left.max_delivery_date),
                              self.min_delivery_date  := if((unsigned)left.min_delivery_date = 99999999, '-', left.min_delivery_date),
#if(filetype = 'A')  
                              self.max_tax_year       := if((unsigned)left.max_tax_year = 0, '-',left.max_tax_year),
                              self.min_tax_year       := if((unsigned)left.min_tax_year = 9999, '-', left.min_tax_year),
                              self.max_assessment_Year:= if((unsigned)left.max_assessment_Year = 0, '-',left.max_assessment_Year),
                              self.min_assessment_Year:= if((unsigned)left.min_assessment_Year = 9999, '-', left.min_assessment_Year),
                              self.max_cert_date      := if((unsigned)left.max_cert_date = 0, '-',left.max_cert_date),
                              self.max_tape_cut_date  := if((unsigned)left.max_tape_cut_date = 0, '-',left.max_tape_cut_date),
#end
                              self := left));
                              
return(days_apart_stats_t);                
endmacro;

shared fn_append_county_data (ds) := functionmacro
county_lookup := dataset(data_services.foreign_prod+'thor_400::fips_code_lookup',{string5 fips_code, string2 state_code, string30 county_name}, thor);

get_county_data_  := join(county_lookup, ds, left.fips_code = right.fips, full outer);
get_county_data   := join(get_county_data_(county_name = ''),county_lookup, left.state_code = right.state_code and trim(left.county_name,all) = trim(right.county_name,all), left outer);
get_county_data_t := project(get_county_data + get_county_data_(county_name <> ''),
														 transform({recordof(left) -[fips, state]},
//************** Standardizing on some county names since they vary between vendors and between name provided and name on our database  ***************
														 self.county_name:= map(left.state_code='AK' and left.county_name='FAIRBANKS NORTH STAR' => 'FAIRBANKS NORTH ST',
																										left.state_code='AK' and left.county_name='KETCHIKAN GATEWAY' and left.source[1..3]<>'FRS' => 'KETCHIKAN GTWY',
																										left.state_code='AK' and left.county_name='LAKE AND PENINSULA' and left.source='OKC' => 'LAKE PENINSULA',
																										left.state_code='AK' and left.county_name='MATANUSKA-SUSITNA' and left.source='OKC' => 'MATANUSKA SUSITNA',
																										left.state_code='AK' and left.county_name='PRINCE OF WALES HYDER' => 'PRINCEWALES HYDER',
																										left.state_code='AK' and left.county_name='VALDEZ-CORDOVA' and left.source[1..2]='BK' => 'VALDEZ CORDOVA',
																										left.state_code='AK' and left.county_name='WRANGELL' and left.source='FRS' => 'WRANGELL-PETERSBUR',
																										left.state_code='AK' and left.county_name='YUKON-KOYUKUK' and left.source[1..2]='BK' => 'YUKON KOYUKUK',
																										left.state_code='DC' and left.county_name='DISTRICT OF COLUMBIA' and left.source='OKC' => 'DIST OF COLUMBIA',
																										left.state_code='DC' and left.county_name='DISTRICT OF COLUMBIA' and left.source='BK-MTG' => 'DIST OF COLUMBIA',
																										left.state_code='DC' and left.county_name='DISTRICT OF COLUMBIA' and left.source='FRS' => 'DISTRICT OF COLUMB',
																										left.state_code='FL' and left.county_name='MIAMI-DADE' and left.source[1..2]='BK' => 'DADE',
																										left.state_code='GA' and left.county_name='ATHENS-CLARKE' and left.source='FRS' => 'CLARKE',
																										left.state_code='IA' and left.county_name='OBRIEN' and left.source='BK-MTG' => 'O BRIEN',
																										left.state_code='IN' and left.county_name='LAPORTE' and left.source[1..2]='BK' => 'LA PORTE',
																										left.state_code='LA' and left.county_name='ST JOHN THE BAPTIST' and left.source='FRS' => 'ST JOHN THE BAPTIS',
																										left.state_code='MO' and left.county_name='ST CHARLES' and left.source[1..2]='BK' => 'SAINT CHARLES',
																										left.state_code='MO' and left.county_name='ST LOUIS' and left.source[1..2]='BK' => 'SAINT LOUIS COUNTY',
																										left.state_code='NC' and left.county_name='MECKLENBURG' and left.source='FRS' => 'MECKLENBERG',
																										left.state_code='VA' and left.county_name='ALEXANDRIA' and left.source[1..2]='BK' => 'ALEXANDRIA CITY',
																										left.state_code='VA' and left.county_name='BRISTOL' and left.source[1..2]='BK' => 'BRISTOL CITY',
																										left.state_code='VA' and left.county_name='BUENA VISTA CITY' and left.source='FRS' => 'BUENA VISTA',
																										left.state_code='VA' and left.county_name='CHESAPEAKE CITY' and left.source='FRS' => 'CHESAPEAKE',
																										left.state_code='VA' and left.county_name='COVINGTON CITY' and left.source='FRS' => 'COVINGTON',
																										left.state_code='VA' and left.county_name='DANVILLE' and left.source[1..2]='BK' => 'DANVILLE CITY',
																										left.state_code='VA' and left.county_name='HAMPTON' and left.source[1..2]='BK' => 'HAMPTON CITY',
																										left.state_code='VA' and left.county_name='HOPEWELL' and left.source[1..2]='BK' => 'HOPEWELL CITY',
																										left.state_code='VA' and left.county_name='LEXINGTON' and left.source[1..2]='BK' => 'LEXINGTON CITY',
																										left.state_code='VA' and left.county_name='LYNCHBURG' and left.source[1..2]='BK' => 'LYNCHBURG CITY',
																										left.state_code='VA' and left.county_name='MANASSAS PARK CITY' and left.source='OKC' => 'MANASSAS PARK',
																										left.state_code='VA' and left.county_name='MARTINSVILLE' and left.source[1..2]='BK' => 'MARTINSVILLE CITY',
																										left.state_code='VA' and left.county_name='NEWPORT NEWS CITY' and left.source='FRS' => 'NEWPORT NEWS',
																										left.state_code='VA' and left.county_name='NORFOLK' and left.source[1..2]='BK' => 'NORFOLK CITY',
																										left.state_code='VA' and left.county_name='PETERSBURG CITY' and left.source='FRS' => 'PETERSBURG',
																										left.state_code='VA' and left.county_name='POQUOSON' and left.source[1..2]='BK' => 'POQUOSON CITY',
																										left.state_code='VA' and left.county_name='PORTSMOUTH CITY' and left.source='FRS' => 'PORTSMOUTH',
																										left.state_code='VA' and left.county_name='RADFORD CITY ' and left.source='FRS' => 'RADFORD',
																										left.state_code='VA' and left.county_name='RICHMOND CITY' and left.source='FRS' => 'RICHMOND',
																										left.state_code='VA' and left.county_name='SALEM' and left.source='BK' => 'SALEM CITY',
																										left.state_code='VA' and left.county_name='SALEM' and left.source='BK-MTG' => 'SALEM CITY',
																										left.state_code='VA' and left.county_name='STAUNTON' and left.source='BK' => 'STAUNTON CITY',
																										left.state_code='VA' and left.county_name='STAUNTON' and left.source='BK-MTG' => 'STAUNTON CITY',
																										left.state_code='VA' and left.county_name='SUFFOLK CITY' and left.source='FRS' => 'SUFFOLK',
																										left.state_code='VA' and left.county_name='WAYNESBORO' and left.source='BK' => 'WAYNESBORO CITY',
																										left.state_code='VA' and left.county_name='WAYNESBORO' and left.source='BK-MTG' => 'WAYNESBORO CITY',
																										left.state_code='VA' and left.county_name='WILLIAMSBURG' and left.source[1..2]='BK' => 'WILLIAMSBURG CITY',
																										left.state_code='VA' and left.county_name='WINCHESTER' and left.source[1..2]='BK' => 'WINCHESTER CITY',
																										left.state_code='VI' and left.county_name='ST JOHN ISLAND' and left.source='FRS' => 'ST JOHN',
																										left.state_code='VI' and left.county_name='ST THOMAS ISLAND' and left.source='FRS' => 'ST THOMAS',
																										left.county_name),
                             self.fips_code  := if(left.fips_code  <> '', left.fips_code,  left.fips),
                             self.state_code := if(left.state_code <> '', left.state_code, left.state),
                             self := left));

return dedup(sort(get_county_data_t, source, fips_code, state_code, county_name, -max_delivery_date, -file_pdate), source, fips_code, state_code, county_name);
endmacro;

//****************************** Report Output Reformat ***********************
shared t_reformat(ds, rpttype, rptby) := functionmacro
	ly_common := record
		string8  file_pdate;
		string5  file_build_type;
		string10 max_file_prod_date;
		string2	 state_code;
		string 	 county_name;
		string5  fips_code;
		string10 max_delivery_date;
		string7  source;
		unsigned total_reccount:=0;
#if(rpttype = 'A')
		unsigned RecordCount;
#end
#if(rpttype in ['C','D'])
		string10 max_sale_date;
		string10 max_recording_date;
		string10 max_mortgage_date;
#end
#if(rpttype = 'A')
		string10 max_cert_date;
		string10 max_tape_cut_date;
		string4  min_tax_year;
		string4  max_tax_year;
		string4  min_assessment_Year;
		string4  max_assessment_Year;
#end
		string   min_delivery_date_to_prod_date_days;
#if(rptby = 'fips' and rpttype = 'D')
		string   min_Days_from_Recording_to_Production := '';
		STRING	 KEYED_REC_THRU_DATE_IN_SITEX := '';
		STRING	 FREQUENCY := '';
		STRING	 DATA_LAG := '';
		STRING	 STATUS := '';
		STRING	 ETA_KEYING := '';
		STRING	 POPULATION := '';
		/* old layout
		STRING   COST_MODEL := '';
		STRING	 KEYED_REC_THRU_DATE_IN_TRACKER := '';
		STRING	 KEYED_REC_THRU_DATE_IN_SITEX := '';
		STRING	 DAYS_PAST_EXPECTED_KEYED_REC_THRU_DATE_IN_TRACKER := '';
		STRING	 DAYS_PAST_EXPECTED_KEYED_REC_THRU_DATE_IN_SITEX := '';
		STRING	 LAST_UPLOAD_DATE_FROM_VENDOR := '';
		STRING	 REC_THRU_DATE_OF_LAST_UPLOAD := '';
		STRING	 DAYS_PAST_EXPECTED_UPLOAD_FROM_VENDOR := '';
		STRING	 LATE := '';
		STRING	 IN_LEGAL := '';
		STRING	 ACQ_LEGAL_HOLD := '';
		STRING	 KNOWN_DELAY := '';
		STRING	 KNOWN_DELAY_OWNERSHIP := '';
		STRING	 KNOWN_DELAY_CATEGORY := '';
		STRING	 ETA_TO_RESUME_PRODUCTION := '';
		STRING	 SOURCE_ISSUE := '';
		STRING	 KEYING_ISSUE := '';
		STRING	 LOADING_ISSUE := '';
		STRING	 LAST_IMAGE_SHIPMENT_DATE_TO_VENDOR := '';
		STRING	 REC_START_DATE_OF_LAST_IMAGE_SHIPMENT := '';
		STRING	 REC_THRU_DATE_OF_LAST_IMAGE_SHIPMENT := '';
		STRING	 DAYS_PAST_EXPECTED_IMAGE_SHIPMENT_TO_VENDOR := '';
		STRING	 CURRENT_DATA_SOURCE := '';
		STRING	 DATA_VENDOR := '';
		STRING	 MEDIA := '';
		STRING	 FREQUENCY := '';
		STRING	 DATA_LAG := '';
		STRING	 DATA_FORMAT := '';
		STRING	 TIER := '';
		STRING	 POPULATION := '';
		STRING	 COMMENTS := '';
		STRING10 RUN_DATE := '';
		*/
#elseif(rptby = 'fips' and rpttype = 'C')
		string   min_Days_from_Recording_to_Production := '';
		//STRING	 KEYED_REC_THRU_DATE_IN_TRACKER := '';
		//STRING	 LATE := '';
		//STRING	 IN_LEGAL := '';
		//STRING	 KNOWN_DELAY := '';
		//STRING	 KNOWN_DELAY_CATEGORY := '';
		STRING	 FREQUENCY := '';
		STRING	 DATA_LAG := '';
		STRING	 STATUS := '';
		STRING	 ETA_KEYING := '';
		STRING	 POPULATION := '';
#elseif(rptby = 'fips' and rpttype = 'A')
		string   min_Days_from_Cert_Date_to_Production;
		string   min_Days_from_Tape_Cut_Date_to_Production;
		//string   OPERATION := '';
		string   ORDER_MTH := '';
		string   CURRENT := '';
		string   LAST_AY := '';
		string   LAST_RELEASED_DATE := '';
		string   LAST_RE_RELEASED_DATE := '';
		string   LAST_PROGRAM_TYPE := '';
		string   LAST_WORKING_DAYS := '';
		string   NEXT_AY := '';
		string   NEXT_PROGRAM_TYPE := '';
		string   NEXT_WORKING_DAYS := '';
		string   STATUS := '';
#end
	end;

ds_t1 := project(ds, transform(ly_common,
															self.max_file_prod_date												:= ut.ConvertDate(left.max_file_prod_date,'%Y%m%d','%m/%d/%Y'),
															self.min_delivery_date_to_prod_date_days			:= if(trim(left.max_delivery_date) <> '-' and trim(left.max_file_prod_date) <> '-',
																																									(string)(ut.BusDaysApart((unsigned)left.max_delivery_date, (unsigned)left.max_file_prod_date)-
																																										(if(Std.Date.DayOfWeek((unsigned)left.max_delivery_date) in [1,7], 0, 1))),'-'),
#if(rptby = 'delivery_date' or rptby = '')
															self.max_delivery_date												:= ut.ConvertDate(left.max_delivery_date,'%Y%m%d','%m/%d/%Y'),
                              self.total_process_days 											:= (string)ut.BusDaysApart((unsigned)left.max_file_prod_date, (unsigned)end_process_date),
															self.deployment_days 													:= (string)ut.BusDaysApart((unsigned)end_process_date, (unsigned)qa_date),
                              self.total_qa_days 														:= (string)ut.BusDaysApart((unsigned)qa_date, (unsigned)prod_date),
															self.total_inhouse_days 											:= (string)ut.BusDaysApart((unsigned)left.delivery_date, (unsigned)prod_date),
															self.days_between_builds 											:= (string)ut.BusDaysApart((unsigned)prev_prod_date, (unsigned)prod_date),
#elseif(rptby = 'fips' and rpttype in ['C','D'])
															self.max_delivery_date												:= ut.ConvertDate(left.max_delivery_date,'%Y%m%d','%m/%d/%Y'),
															self.max_sale_date														:= ut.ConvertDate(left.max_sale_date,'%Y%m%d','%m/%d/%Y'),
															self.max_recording_date												:= ut.ConvertDate(left.max_recording_date,'%Y%m%d','%m/%d/%Y'),
															self.max_mortgage_date												:= ut.ConvertDate(left.max_mortgage_date,'%Y%m%d','%m/%d/%Y'),
#elseif(rptby = 'fips' and rpttype = 'A')
															self.max_delivery_date												:= ut.ConvertDate(left.max_delivery_date,'%Y%m%d','%m/%d/%Y'),
															self.max_cert_date														:= ut.ConvertDate(left.max_cert_date,'%Y%m%d','%m/%d/%Y'),
															self.max_tape_cut_date												:= ut.ConvertDate(left.max_tape_cut_date,'%Y%m%d','%m/%d/%Y'),
															self.min_Days_from_Cert_Date_to_Production		:= if(trim(left.max_cert_date) <> '-' and trim(left.max_file_prod_date) <> '-',
																																									(string)(ut.BusDaysApart((unsigned)left.max_cert_date, (unsigned)left.max_file_prod_date)-
																																										(if(Std.Date.DayOfWeek((unsigned)left.max_cert_date) in [1,7], 0, 1))),'-'),
															self.min_Days_from_Tape_Cut_Date_to_Production:= if(trim(left.max_tape_cut_date) <> '-' and trim(left.max_file_prod_date) <> '-',
																																									(string)(ut.BusDaysApart((unsigned)left.max_tape_cut_date, (unsigned)left.max_file_prod_date)-
																																										(if(Std.Date.DayOfWeek((unsigned)left.max_tape_cut_date) in [1,7], 0, 1))),'-'),
#end
                              self := left));

#if(rpttype in ['C','D'])
// output(ds_t1);
ds_t2	:= join(ds_t1(county_name<>''),okc_currency_report,
//** Keeping state and county name commented out in case there's need to change from FIPS to state county **
													//trim(right.st)	= trim(left.state_code)  and 
													//trim(regexreplace('-',right.county,''),all)		
													//								= trim(regexreplace('-',left.county_name,''),all) and
													  left.fips_code= right.fips/*key[1..5]*/ and
													((left.source		= 'BK-MTG' and right.doc_type = 'SAM') or
													 (left.source		= 'BK' 		 and right.doc_type = 'DEED')),
													transform(ly_common,self:=right,self:=left),
													left outer, few);
ds_tdee := ds_t2(source in ['BK','OKC']);
ds_tmtg	:= ds_t2(source in ['BK-MTG','OKC-MTG']);
ds_tall	:= ds_t2(source not in ['BK','OKC','BK-MTG','OKC-MTG','FRS']);
//Populated the FRS entries in the report using the Core logic report VC 
ds_tfrc:= join(ds_t1(county_name<>'' and source		= 'FRS'),currency_report_cl(),
													  (integer)left.fips_code= (integer)right.fips/*key[1..5]*/ ,
													transform(ly_common,self:=right,self:=left),
													left outer, few);
// output(ds_tfrc(source		= 'FRS' and (integer)fips_code in Set_fips_code),named('AfterJoinFRSRecWithCLCurrReport'))	;												
ds_rdee	:= rollup(sort(ds_tdee,fips_code,/*state_code,county_name,*/source),
													left.fips_code	= right.fips_code and
													//left.state_code	= right.state_code and
													//trim(regexreplace('-',right.county_name,''),all)		
													//								= trim(regexreplace('-',left.county_name,''),all) and
													(left.source		= 'BK' and 
													right.source		= 'OKC'),transform(ly_common,self:=left));
ds_rmtg	:= rollup(sort(ds_tmtg,fips_code,/*state_code,county_name,*/source),
													left.fips_code	= right.fips_code and
													//left.state_code	= right.state_code and
													//trim(regexreplace('-',right.county_name,''),all)		
													//								= trim(regexreplace('-',left.county_name,''),all) and
													(left.source		= 'BK-MTG' and 
													right.source		= 'OKC-MTG'),transform(ly_common,self:=left));
ds_t3		:= sort(ds_rdee+ds_rmtg+ds_tall+ds_tfrc,fips_code,/*state_code,county_name,*/source,-file_pdate/*max_build_version*/);

tbdeed:=f_aggregate_deed((LN_PropertyV2.File_deed+LN_PropertyV2_Fast.files.base.deed_mortg)(process_date<=pversion));

ds_t		:= join(ds_t3(fips_code<>''),tbdeed(fips_code<>''),
													//left.state_code	 = right.state			 and
													//left.county_name = right.county_name and
													left.fips_code	 = right.fips_code	 and
													left.source			 = right.source,
													transform(ly_common,self.max_recording_date	:= 
																									if(trim(right.max_recording_date) not in ['','00/00/0000'] and 
																											ut.ConvertDate(right.max_recording_date,'%m/%d/%Y','%Y%m%d') <= ut.ConvertDate(left.max_delivery_date,'%m/%d/%Y','%Y%m%d'),
																											right.max_recording_date,left.max_recording_date),
																							self.min_Days_from_Recording_to_Production := 
																									if(trim(right.max_recording_date)not in ['','00/00/0000'] and 
																											ut.ConvertDate(right.max_recording_date,'%m/%d/%Y','%Y%m%d') <= ut.ConvertDate(left.max_delivery_date,'%m/%d/%Y','%Y%m%d') and 
																											trim(left.max_file_prod_date) <> '-',
																											(string)(ut.BusDaysApart((unsigned)ut.ConvertDate(right.max_recording_date,'%m/%d/%Y','%Y%m%d'),(unsigned)ut.ConvertDate(left.max_file_prod_date,'%m/%d/%Y','%Y%m%d'))-
																												(if(Std.Date.DayOfWeek((unsigned)ut.ConvertDate(right.max_recording_date,'%m/%d/%Y','%Y%m%d')) in [1,7], 0, 1))),
																											if(trim(left.max_recording_date) <> '' and trim(left.max_file_prod_date) <> '-',
																													(string)(ut.BusDaysApart((unsigned)ut.ConvertDate(left.max_recording_date,'%m/%d/%Y','%Y%m%d'),(unsigned)ut.ConvertDate(left.max_file_prod_date,'%m/%d/%Y','%Y%m%d'))-
																														(if(Std.Date.DayOfWeek((unsigned)ut.ConvertDate(left.max_recording_date,'%m/%d/%Y','%Y%m%d')) in [1,7], 0, 1))),'-')),
																						  self.total_reccount			:= right.RecordCount,
																							self										:= left),
													few);

#elseif(rpttype = 'A')
ds_t2		:= join(ds_t1(trim(county_name,right,left)[1] not in ['','1']),okc_assessor_currency_report,
													//trim(right.st)	= trim(left.state_code)  and 
													//trim(regexreplace('-',right.county,''),all)		
													//								= trim(regexreplace('-',left.county_name,''),all) and
													left.fips_code = right.fips and
													left.source[1..2] in ['BK','OK'],
													transform(ly_common,self:=right,self:=left),
													left outer, few);
ds_tokc := ds_t2(source in ['BK','OKC']);
ds_tfrs	:= ds_t2(source not in ['BK','OKC']);
ds_rokc	:= rollup(sort(ds_tokc,fips_code,/*state_code,county_name,*/source),
													left.fips_code	= right.fips_code and
													//left.state_code	= right.state_code and
													//trim(regexreplace('-',right.county_name,''),all)		
													//								= trim(regexreplace('-',left.county_name,''),all) and
													(left.source		= 'BK' and 
													right.source		= 'OKC'),transform(ly_common,self:=left));
ds_t3		:= sort(ds_rokc+ds_tfrs,fips_code,/*state_code,county_name,*/source,-file_pdate/*max_build_version*/);

tbassess:=f_aggregate_assess((LN_PropertyV2.File_assessment+LN_PropertyV2_Fast.files.base.assessment)(process_date<=pversion));

ds_t		:= join(ds_t3(fips_code<>''),tbassess(fips_code<>''),
													//left.state_code= right.state_code	   and
													//left.county_name = right.county_name and
													left.fips_code	= right.fips_code	 and
													(left.source		= right.source		 or
													(left.source		= 'OKC' and
													right.source		= 'BK')),
													transform(ly_common,self.total_reccount := right.RecordCount,
																							self.max_tax_year    := if((unsigned)right.max_tax_year <= 1900,
																																					if((unsigned)left.max_tax_year <= 1900, '-',left.max_tax_year),
																																					right.max_tax_year),
																							self.min_tax_year    := if((unsigned)right.min_tax_year = 9999 or (unsigned)right.min_tax_year <= 1900,
																																					if((unsigned)left.min_tax_year = 9999 or (unsigned)left.min_tax_year <= 1900, '-', left.min_tax_year),
																																					right.min_tax_year),
																							self.max_assessment_Year    := if((unsigned)right.max_assessment_Year <= 1900,
																																					if((unsigned)left.max_assessment_Year <= 1900, '-',left.max_assessment_Year),
																																					right.max_assessment_Year),
																							self.min_assessment_Year    := if((unsigned)right.min_assessment_Year = 9999 or (unsigned)right.min_assessment_year <= 1900,
																																					if((unsigned)left.min_assessment_year = 9999 or (unsigned)left.min_assessment_year <= 1900, '-', left.min_assessment_year),
																																					right.min_assessment_Year),
																							self.file_pdate	  	 := if(left.file_build_type<>'',left.file_pdate,
																							// ** These process dates were identified as being deployed with different versions **
																																			map(right.max_process_date='20150421' => '20150420',
																																					right.max_process_date='20150207' => '20150206',
																																					right.max_process_date='20140905' => '20141107',
																																					right.max_process_date='20140830' => '20141029',
																																			set(dops_history(prodversion[1..8]>=right.max_process_date),prodversion)[1])),
																							self.file_build_type := if(left.file_build_type<>'',left.file_build_type,
																																			map(right.max_process_date='20150421' => 'DELTA',
																																					right.max_process_date='20150207' => 'DELTA',
																																					right.max_process_date='20140905' => 'DELTA',
																																					right.max_process_date='20140830' => 'FULL',
																																			set(dops_history(prodversion[1..8]>=right.max_process_date),update_type)[1])),
																							self.max_file_prod_date	:= if(left.max_file_prod_date<>'',left.max_file_prod_date,
																																			map(right.max_process_date='20150421' => '04/29/2015',
																																					right.max_process_date='20150207' => '02/18/2015',
																																					right.max_process_date='20140905' => '11/18/2014',
																																					right.max_process_date='20140830' => '11/18/2014',
																																			set(dops_history(prodversion[1..8]>=right.max_process_date),ut.ConvertDate(prodwhenupdated,,'%m/%d/%Y'))[1])),
																							self.min_delivery_date_to_prod_date_days			:= if(trim(left.max_delivery_date) <> '' and trim(self.max_file_prod_date) <> '',
																																									(string)(ut.BusDaysApart((unsigned)(ut.ConvertDate(left.max_delivery_date,'%m/%d/%Y','%Y%m%d')), (unsigned)(ut.ConvertDate(self.max_file_prod_date,'%m/%d/%Y','%Y%m%d'))-
																																										(if(Std.Date.DayOfWeek((unsigned)(ut.ConvertDate(left.max_delivery_date,'%m/%d/%Y','%Y%m%d'))) in [1,7], 0, 1)))),'-'),
																							self.min_Days_from_Cert_Date_to_Production		:= if(trim(left.max_cert_date) <> '' and trim(self.max_file_prod_date) <> '',
																																									(string)(ut.BusDaysApart((unsigned)(ut.ConvertDate(left.max_cert_date,'%m/%d/%Y','%Y%m%d')), (unsigned)(ut.ConvertDate(self.max_file_prod_date,'%m/%d/%Y','%Y%m%d'))-
																																										(if(Std.Date.DayOfWeek((unsigned)(ut.ConvertDate(left.max_cert_date,'%m/%d/%Y','%Y%m%d'))) in [1,7], 0, 1)))),'-'),
																							self.min_Days_from_Tape_Cut_Date_to_Production:= if(trim(left.max_tape_cut_date) <> '' and trim(self.max_file_prod_date) <> '',
																																									(string)(ut.BusDaysApart((unsigned)(ut.ConvertDate(left.max_tape_cut_date,'%m/%d/%Y','%Y%m%d')), (unsigned)(ut.ConvertDate(self.max_file_prod_date,'%m/%d/%Y','%Y%m%d'))-
																																										(if(Std.Date.DayOfWeek((unsigned)(ut.ConvertDate(left.max_tape_cut_date,'%m/%d/%Y','%Y%m%d'))) in [1,7], 0, 1)))),'-'),
																						  self := left),
													few);

#end

return ds_t;
endmacro;

//** Keeping state and county name commented out in case there's need to change from FIPS to state county **

//Deed Rpt by County and delivery_date
shared deed_days_apart_stats_all := fn_append_county_data(f_aggregate_data(raw_deed_slim, fips, 'D', ''));

export deed_days_apart_stats_all_updated := sort(t_reformat(deed_days_apart_stats_all(recordcount > 0), 'D', 'fips'), /*state_code, county_name, */fips_code, file_pdate/*max_delivery_date*/);
export deed_days_apart_stats_all_condensed := sort(t_reformat(deed_days_apart_stats_all(recordcount > 0), 'C', 'fips'), /*state_code, county_name, */fips_code, file_pdate/*max_delivery_date*/);

//Assessor Rpt by County and delivery_date
shared assess_days_apart_stats_all := fn_append_county_data(f_aggregate_data(assess_new_slim, fips, 'A', 'F'));
export assess_days_apart_stats_all_updated := sort(t_reformat(assess_days_apart_stats_all(RecordCount > 0), 'A', 'fips'), /*state_code, county_name, */fips_code, file_pdate/*max_delivery_date*/);

end;