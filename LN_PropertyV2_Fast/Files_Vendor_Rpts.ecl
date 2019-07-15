import std, Data_Services;
EXPORT Files_Vendor_Rpts := module;

//***************************Layouts*************************************
//Fares Assessment Report
shared layout_frs_taxreport	:=	RECORD
	STRING	State;
	STRING	County;
	STRING	FIPS;
	STRING	CERTDate;
	STRING	Edition;
	STRING	FileName;
	STRING	Total;
	STRING	MaxRecordingDate;
	STRING	MaxSaleDate;
	STRING	MaxOfTaxYear;
	STRING	MaxOfAssessedYear;
	STRING	__filename	{VIRTUAL(logicalfilename)};
END;

shared layout_frs_taxreport_new := record
layout_frs_taxreport - __filename;
string __filename;
string10 filedate;
end;

//----------------------------------------------------------------------------
//BK Assessment Report
shared layout_bk_taxreport	:=	RECORD
	STRING	st;
	STRING	county;
	STRING	tape_cut_date;
	STRING	assessment_year;
	STRING	ln_tape_num;
	STRING	num_of_records;
	STRING	ed_num;
	STRING	cert_date;
	STRING	__filename	{VIRTUAL(logicalfilename)};
END;

shared layout_bk_taxreport_new := record
layout_bk_taxreport - __filename;
string __filename;
string10 filedate;
end;

//Fares Deed Report
shared ly_frs_deed_input_rpt := record
string line;
string __filename { virtual(logicalfilename)};
end;

shared ly_frs_deed_trantype_new := record
string5 FIPS;   
string2 State;   
string County;                 
unsigned Total;    
unsigned Resell;   
unsigned Stand_Alone;  
unsigned New_Con;   
unsigned TimeShare; 
unsigned Cons_Loan; 
unsigned Seller_CBk;
unsigned Nominal;
string __filename;
string10 filedate;
end; 

//BK Deed Report
shared layout_bk_deedreport	:=	RECORD
  String  FileName;
  String  FileSize;
  String  fips;		
	STRING	state;
	STRING	county;
	String  DataType;
	STRING	MinOfRecording_date;
	STRING	MaxOfRecording_date;
	STRING	SumOfNo_rec;
	STRING	SumOfMain_and_Add;
	STRING	__filename	{VIRTUAL(logicalfilename)};
END;

shared layout_bk_deedreport_new := record
layout_bk_deedreport - __filename;
string __filename;
string10 filedate;
end;

//BK Deed-Sam Currency Report
shared rec_temp := record // This layout to remove invalid new line code from record
	string linein;
	STRING	__filename	{VIRTUAL(logicalfilename)};
end;
shared rec_temp_new := record
	rec_temp - __filename;
	STRING	__filename;
	string10 filedate;
end;

shared layout_bk_currencyreport	:=	RECORD
	STRING	FIPS;
	STRING	ST;
	STRING	COUNTY;
	STRING	DOC_TYPE;
	STRING	KEYED_REC_THRU_DATE_IN_SITEX;
	STRING	FREQUENCY;
	STRING	DATA_LAG;
	STRING	STATUS;
	STRING	ETA_KEYING;
	STRING	POPULATION;
	/* old layout
	STRING	DATA_TYPE;
	STRING	KEY;
	STRING	COST_MODEL;
	STRING	KEYED_REC_THRU_DATE_IN_TRACKER;
	STRING	KEYED_REC_THRU_DATE_IN_SITEX;
	STRING	DAYS_PAST_EXPECTED_KEYED_REC_THRU_DATE_IN_TRACKER;
	STRING	DAYS_PAST_EXPECTED_KEYED_REC_THRU_DATE_IN_SITEX;
	STRING	LAST_UPLOAD_DATE_FROM_VENDOR;
	STRING	REC_THRU_DATE_OF_LAST_UPLOAD;
	STRING	DAYS_PAST_EXPECTED_UPLOAD_FROM_VENDOR;
	STRING	LATE;
	STRING	IN_LEGAL;
	STRING	ACQ_LEGAL_HOLD;
	STRING	KNOWN_DELAY;
	STRING	KNOWN_DELAY_OWNERSHIP;
	STRING	KNOWN_DELAY_CATEGORY;
	STRING	ETA_TO_RESUME_PRODUCTION;
	STRING	SOURCE_ISSUE;
	STRING	KEYING_ISSUE;
	STRING	LOADING_ISSUE;
	STRING	LAST_IMAGE_SHIPMENT_DATE_TO_VENDOR;
	STRING	REC_START_DATE_OF_LAST_IMAGE_SHIPMENT;
	STRING	REC_THRU_DATE_OF_LAST_IMAGE_SHIPMENT;
	STRING	DAYS_PAST_EXPECTED_IMAGE_SHIPMENT_TO_VENDOR;
	STRING	CURRENT_DATA_SOURCE;
	STRING	DATA_VENDOR;
	STRING	MEDIA;
	STRING	FREQUENCY;
	STRING	DATA_LAG;
	STRING	DATA_FORMAT;
	STRING	TIER;
	STRING	POPULATION;
	STRING	COMMENTS;
	STRING	RUN_DATE;
	*/
	STRING	__filename;
	STRING filedate;
END;

shared layout_cl_currencyreport :=	RECORD
	STRING	FIPS;
	STRING	ST;
  STRING	COUNTY;
	STRING	RANK_NO;
	STRING	DOC_TYPE;
	STRING	KEYING_TIME_FRAME;
	STRING	COUNTY_RECORDING_TIMEFRAME;
	STRING	TOTAL_KEYING_TIMEFRAME;
	STRING	COUNTY_MAX_REC_DATE;
	STRING	DIABLO_MAX_REC_DATE;
	STRING	COUNTY_ACQUISITION_FREQUENCY;	
	STRING	__filename;
	STRING filedate;
end;	

//BK Assessor Currency Report
shared layout_bk_assessor_currencyreport	:=	RECORD
	STRING   FIPS;
	STRING   ST;
	STRING   COUNTY;
	//STRING   OPERATION; removed from new layout
	//STRING   ORDER_MTH;
	//STRING   CURRENT;
	STRING   LAST_AY;
	STRING   LAST_ASSESMENT_MONTH_FROM_SOURCE;
	STRING   LAST_ACQUISTION_YR;
	STRING   LAST_RELEASED_DATE;
//	STRING   LAST_RE_RELEASED_DATE;
//	STRING   LAST_PROGRAM_TYPE;
//	STRING   LAST_WORKING_DAYS;
	STRING   NEXT_AY;
	STRING   NEXT_ASSESMENT_MONTH_FROM_SOURCE;
//	STRING   NEXT_WORKING_DAYS;
  STRING    FILE_RECEIVED_DATE;
	STRING   CURRENT; //NEXT_STATUS; name changed on new layout
	STRING	__filename	{VIRTUAL(logicalfilename)};
END;

shared layout_bk_assessor_currencyreport_new := record
	layout_bk_assessor_currencyreport - __filename;
	string __filename;
	string10 filedate;
end;

//***************************Files

export taxreport_frs_fname := '~thor_data400::in::property::raw::frs::taxreports::csv';
export taxreport_bk_fname := '~thor_data::in::ln_propertyv2::raw::bk::taxreport';
export deedreport_frs_fname := '~thor_data400::in::property::raw::frs::deedreports::trantype';
export deedreport_bk_fname := '~thor_data::in::ln_propertyv2::raw::bk::deedreport';
export taxreport_frs_reporting_fname  := '~thor_data400::in::property::raw::frs::taxreports::csv_reporting';
export bk_curr_report_fname	:= '~Thor_data::in::ln_propertyv2::raw::bk::newcurrency_report';
export bk_assessor_curr_report_fname	:= '~Thor_data::in::ln_propertyv2::raw::bk::assessor::newcurrency_report';
//corelogic currency report VC 20180111
export cl_curr_report_fname	:= '~thor_data::in::ln_propertyv2::raw::cl::newcurrency_report'; 

shared taxreport_frs_d	:=	DATASET(Data_Services.Data_location.Prefix('NONAMEGIVEN')+ taxreport_frs_fname,layout_frs_taxreport, csv(separator(',')));
export taxreport_frs := project(taxreport_frs_d (state <> 'State'), transform(layout_frs_taxreport_new, self.filedate := left.__filename[std.str.Find(left.__filename, ':',12)+1 ..std.str.Find(left.__filename, ':',12)+8], self := left)); 

shared taxreport_frs_reporting_d	:=	DATASET(Data_Services.Data_location.Prefix('NONAMEGIVEN')+ taxreport_frs_reporting_fname,layout_frs_taxreport, csv(separator(',')));
export taxreport_frs_reporting := project(taxreport_frs_reporting_d (state <> 'State'), transform(layout_frs_taxreport_new, self.filedate := left.__filename[std.str.Find(left.__filename, ':',12)+1 ..std.str.Find(left.__filename, ':',12)+8], self := left)); 

shared taxreport_bk_d	:=	DATASET(Data_Services.Data_location.Prefix('NONAMEGIVEN')+taxreport_bk_fname,layout_bk_taxreport, csv(terminator('\r\n'), separator(','),quote('"')));
export taxreport_bk := project(taxreport_bk_d(tape_cut_date <> 'TAPE CUT DATE'), transform(layout_bk_taxreport_new, self.filedate := left.__filename[length(left.__filename) -7.. length(left.__filename)], self := left));

shared rpt_trantype := dataset(Data_Services.Data_location.Prefix('NONAMEGIVEN')+ deedreport_frs_fname,ly_frs_deed_input_rpt, csv(terminator('\r\n'), separator('\t'),quote('"')));
shared headings := ['FIPS', 'SEIS', 'WEEK', 'STAT', '****', 'GRAN'];
shared line_filter (dataset(ly_frs_deed_input_rpt)rpt):= rpt(trim(line, all) <> '' and StringLib.StringToUpperCase(trim(line[..4], all)) not in headings and stringlib.stringFind(line, '/',1)=0 and length(trim(line, all)) > 5 and (unsigned) line[..5] > 0);
export deedreport_frs:=  project(line_filter(rpt_trantype),
													transform(ly_frs_deed_trantype_new,
													self.filedate :=left.__filename[length(left.__filename) - 7..];
													self.FIPS := trim(left.line[1..7], left, right),   
													self.State:= trim(left.line[8..15], left, right),   
													self.County:= trim(left.line[16..38], left, right), 
													self.Total:= (unsigned)left.line[39..47];
													self.Resell:= (unsigned)left.line[48..60],
													self.Stand_Alone:= (unsigned)left.line[61..77],
													self.New_Con:= (unsigned)left.line[78..92],  
													self.TimeShare:= (unsigned)left.line[93..107],
													self.Cons_Loan:= (unsigned)left.line[108..122],
													self.Seller_CBk:= (unsigned)left.line[123..138],
													self.Nominal:= (unsigned)left.line[139..150],
													self := left));		
													
													
shared deedreport_bk_d := dataset(/*Data_Services.Data_location.Prefix('NONAMEGIVEN')+*/ deedreport_bk_fname,layout_bk_deedreport, csv(terminator('\r\n'), separator('	'),quote('"')));
export deedreport_bk := project(deedreport_bk_d(state <> 'State'), transform(layout_bk_deedreport_new, self.filedate := left.__filename[length(left.__filename) -7.. length(left.__filename)], self := left));

bk_curr_report_temp	:= '~Thor_data::temp::in::ln_propertyv2::raw::bk::newcurrency_report';
currencyreport_bk_x := dataset(bk_curr_report_fname,rec_temp, csv(separator('|'),quote('"')));
currencyreport_bk_f := project(currencyreport_bk_x,transform(rec_temp_new,self.linein:=regexreplace('_x000D_',left.linein,''), self.filedate := regexfind('report::([0-9]{8})',left.__filename,1), self.__filename:=','+left.__filename+','));
out_temp_file				:= output(currencyreport_bk_f,,bk_curr_report_temp,csv(separator('|')),overwrite,expire(1));
currencyreport_bk_d := dataset(bk_curr_report_temp,layout_bk_currencyreport, csv(separator(','),quote('"')));
currencyreport_bk_0 := project(currencyreport_bk_d(FIPS <> 'FIPS'), transform(layout_bk_currencyreport, 
																																						//self.RUN_DATE	 := regexreplace('\\|',left.RUN_DATE,''),
																																						self.__filename:= regexreplace('\\|',left.__filename,''),
																																						self.filedate  := regexreplace('\\|',left.filedate,''),
																																						//self.KEYED_REC_THRU_DATE_IN_TRACKER:= regexreplace('-',regexreplace('-([0-9]{2})$',left.KEYED_REC_THRU_DATE_IN_TRACKER,'-20\\1'),'/'),
																																						self.KEYED_REC_THRU_DATE_IN_SITEX  := regexreplace('-',regexreplace('-([0-9]{2})$',left.KEYED_REC_THRU_DATE_IN_SITEX,'-20\\1'),'/'),
																																						//self.LAST_UPLOAD_DATE_FROM_VENDOR  := regexreplace('-',regexreplace('-([0-9]{2})$',left.LAST_UPLOAD_DATE_FROM_VENDOR,'-20\\1'),'/'),
																																						//self.REC_THRU_DATE_OF_LAST_UPLOAD  := regexreplace('-',regexreplace('-([0-9]{2})$',left.REC_THRU_DATE_OF_LAST_UPLOAD,'-20\\1'),'/'),
																																						//self.ETA_TO_RESUME_PRODUCTION      := regexreplace('-',regexreplace('-([0-9]{2})$',left.ETA_TO_RESUME_PRODUCTION,'-20\\1'),'/'),
																																						self := left));
export currencyreport_bk := when(currencyreport_bk_0,out_temp_file, BEFORE);

assessorcurrencyreport_bk_d := dataset(/*Data_Services.Data_location.Prefix('NONAMEGIVEN')+*/ bk_assessor_curr_report_fname,layout_bk_assessor_currencyreport, csv(separator(','),quote('"')));
export assessorcurrencyreport_bk := project(assessorcurrencyreport_bk_d(FIPS <> 'FIPS'), transform(layout_bk_assessor_currencyreport_new, self.filedate := regexfind('report::([0-9]{8})',left.__filename,1), self := left));

/***************************************************************CL Prep*****************************************************************************/
clcurr_report_temp	:= '~Thor_data::temp::in::ln_propertyv2::raw::cl::newcurrency_report';
currencyreport_clx := dataset(cl_curr_report_fname,rec_temp, csv(separator('|'),quote('"')));

currencyreport_clf := project(currencyreport_clx,
                              transform(rec_temp_new,self.linein:=regexreplace('_x000D_',left.linein,''), 
															                       self.filedate := regexfind('report::([0-9]{8})',left.__filename,1), 
																										 self.__filename:=','+left.__filename+','));

out_temp_clfile				:= output(currencyreport_clf,,clcurr_report_temp,csv(separator('|')),overwrite,expire(1));
currencyreport_cld := dataset(clcurr_report_temp,layout_cl_currencyreport, csv(separator(','),quote('"')));
currencyreport_cl0 := project(currencyreport_cld(FIPS <> 'FIPS'), transform(layout_bk_currencyreport, 
																																						self.__FILENAME:= regexreplace('\\|',left.__FILENAME,''),
																																						self.FILEDATE  := regexreplace('\\|',left.FILEDATE,''),
																																						self.DATA_LAG  := left.COUNTY_RECORDING_TIMEFRAME,
																																						self.KEYED_REC_THRU_DATE_IN_SITEX  := regexreplace('-',regexreplace('-([0-9]{2})$',left.COUNTY_MAX_REC_DATE,'-20\\1'),'/'),
																																						self.FREQUENCY := (string)ROUND(7/(integer)regexreplace('([0-9]+) X WEEK',left.COUNTY_ACQUISITION_FREQUENCY,'$1')),
																																						self.STATUS    := '',
																																						self.ETA_KEYING:= '',
																																						self.POPULATION:= '',
																																						self := left));
																																					
currencyreport_cl := when(currencyreport_cl0,out_temp_clfile, BEFORE);

currencyreport_cl rolluprecs(currencyreport_cl L, currencyreport_cl R) := transform
 self.DATA_LAG                      := IF(L.doc_type ='DEED', L.DATA_LAG,R.DATA_LAG);
 self.KEYED_REC_THRU_DATE_IN_SITEX  := IF(L.doc_type ='DEED', L.KEYED_REC_THRU_DATE_IN_SITEX, R.KEYED_REC_THRU_DATE_IN_SITEX);
 self.FREQUENCY                     := IF(L.doc_type ='DEED', L.FREQUENCY, R.FREQUENCY);
 self := L;
end;

s_currencyreport_cl  := sort(currencyreport_cl(doc_type in ['ABSTRACT','DEED','DEED/MORTGAGE','Deed/Mortgage/ADC','MORTGAGE']),FIPS,doc_type,-regexreplace('([0-9]+)[/]([0-9]+)[/]([0-9]+)',KEYED_REC_THRU_DATE_IN_SITEX,'$3$1$2'));

ru_currencyreport_cl := rollup(s_currencyreport_cl,left.fips =right.fips ,
                               rolluprecs(LEFT,RIGHT));
																																				
export currencyreport_clo := ru_currencyreport_cl;

end;