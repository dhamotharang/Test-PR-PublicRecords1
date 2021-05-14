IMPORT _control, Inquiry_AccLogs, data_services, STD, ut; 
export InquiryRpts_bwrFCRAInq41(string pHostname, string pTarget, string pContact ='\' \'', STRING today = (STRING8)STD.Date.Today()) := function

filedate := today;

bsversion := 41;
isfcra := TRUE;

key := PULL(Inquiry_AccLogs.Key_FCRA_DID);

temprec := record
	recordof(key.person_q) person_q;
	string industry;
	string vertical;
	string func;
	string logdate;
	boolean Total_Inq;
	boolean Inquiry;
	boolean Collection;
	boolean Auto;
	boolean Banking;
	boolean Mortgage;
	boolean HighRiskCredit;
	boolean Retail;
	boolean Communications;
	boolean PrepaidCards; 
	boolean RetailPayments; 
	boolean Utilities; 
	boolean QuizProvider; 
	boolean StudentLoan;	
	boolean Other;
	string fcra_purpose;
    boolean isAuto_temp;
	boolean isMortgage_temp;
	boolean isHighRiskCredit_temp;
end;

temprec transform_raw(Inquiry_AccLogs.Key_FCRA_DID rt) := transform
	self.fcra_purpose := trim(rt.permissions.fcra_purpose);
	self.person_q := rt.person_q;
	industry := trim(StringLib.StringToUpperCase(rt.bus_intel.industry));
	vertical := trim(StringLib.StringToUpperCase(rt.bus_intel.vertical));
	sub_market := trim(StringLib.StringToUpperCase(rt.bus_intel.sub_market));
	use := trim(StringLib.StringToUpperCase(rt.bus_intel.use));
	func := trim(StringLib.StringToUpperCase(rt.search_info.function_description));
	logdate := rt.search_info.datetime[1..8];
	product_code := trim(rt.search_info.product_code);
	purpose := trim(rt.permissions.fcra_purpose);
	method := trim(StringLib.StringToUpperCase(rt.search_info.method)); 
																							
/* NEW 5.0 LOGIC */ 
is_banko_inquiry := func in Inquiry_AccLogs.shell_constants.banko_functions or (stringlib.stringfind(func, 'MONITORING', 1) > 0 AND product_code='5'); // monitoring transactions with product code=5 are also banko_batch
	function_is_ok := if(isfcra, 
			func in Inquiry_AccLogs.shell_constants.set_valid_fcra_functions(bsversion), // exclude batch functions
			func in Inquiry_AccLogs.shell_constants.set_valid_nonfcra_functions(bsversion));

inquiry_hit :=  /*Inquiry_AccLogs.shell_constants.inquiry_is_ok(le.historydate, logdate, isFCRA_temp) and*/
								 (trim(rt.permissions.fcra_purpose) in ['164','100','101'] or
								 (trim(rt.permissions.fcra_purpose) = '0' and StringLib.StringFind(func, 'BATCH', 1) = 0)) and
								 function_is_ok and
								 not is_banko_inquiry and
								 trim(rt.bus_intel.use)='' and
								 product_code in Inquiry_AccLogs.shell_constants.valid_product_codes;
is_164_purpose := trim(rt.permissions.fcra_purpose) = '164';

	boolean batch_method := method in ['BATCH','MONITORING']; 
	boolean isCollection := inquiry_hit and 
			(/*~isFCRA or*/ trim(rt.permissions.fcra_purpose) = '164') and
			(vertical='COLLECTIONS' or industry IN Inquiry_AccLogs.shell_constants.collection_industry or
				StringLib.StringFind(StringLib.StringToUpperCase(sub_market),'FIRST PARTY', 1) > 0);	
		
	boolean isAuto           := not is_164_purpose and not batch_method and inquiry_hit and industry in Inquiry_AccLogs.shell_constants.auto_industry;
	boolean isBanking        := not is_164_purpose and not batch_method and inquiry_hit and industry in 
		if(bsversion>=50, Inquiry_AccLogs.shell_constants.banking_industry5, Inquiry_AccLogs.shell_constants.banking_industry4);
	boolean isMortgage       := not is_164_purpose and not batch_method and inquiry_hit and industry in Inquiry_AccLogs.shell_constants.Mortgage_industry;	
	boolean isHighRiskCredit := not is_164_purpose and not batch_method and inquiry_hit and industry in 
		if(bsversion>=50, Inquiry_AccLogs.shell_constants.HighRiskCredit_industry5, Inquiry_AccLogs.shell_constants.HighRiskCredit_industry4);
	boolean isRetail         := not is_164_purpose and not batch_method and inquiry_hit and industry in Inquiry_AccLogs.shell_constants.Retail_industry;
	boolean isCommunications := not is_164_purpose and not batch_method and inquiry_hit and industry in 
		if(bsversion>=50, Inquiry_AccLogs.shell_constants.communications_industry5, Inquiry_AccLogs.shell_constants.communications_industry4);
	boolean isFraudSearch := inquiry_hit and func in Inquiry_AccLogs.shell_constants.fraud_search_functions;
	
	boolean isPrepaidCards := not is_164_purpose and not batch_method and inquiry_hit and industry in Inquiry_AccLogs.shell_constants.PrepaidCards_industry;
	boolean isRetailPayments := not is_164_purpose and not batch_method and inquiry_hit and industry in Inquiry_AccLogs.shell_constants.RetailPayments_industry and
													func in Inquiry_AccLogs.shell_constants.RetailPayments_functions;
	boolean isUtilities := not is_164_purpose and not batch_method and inquiry_hit and industry in Inquiry_AccLogs.shell_constants.Utilities_industry;
	boolean isQuizProvider := not is_164_purpose and not batch_method and inquiry_hit and industry in Inquiry_AccLogs.shell_constants.QuizProvider_industry;
	boolean isStudentLoan := not is_164_purpose and not batch_method and inquiry_hit and industry in Inquiry_AccLogs.shell_constants.StudentLoans_industry;

	boolean isOther_v4 := inquiry_hit and not batch_method and 
										not is_164_purpose and 
										not isAuto and 
										not isBanking and 
										not isMortgage and
										not isHighRiskCredit and
										not isRetail and
										not isCommunications;
										
	boolean isOther_v5 := inquiry_hit and not batch_method and 
										not is_164_purpose and
										not isAuto and 
										not isBanking and 
										not isMortgage and
										not isHighRiskCredit and
										not isRetail and
										not isCommunications and
										not isPrepaidCards and
										not isRetailPayments and
										not isUtilities and
										not isQuizProvider and
										not isStudentLoan;
										
	boolean isOther := if(bsversion >=50, isOther_v5, isOther_v4);
	
	// for the totals bucket in version 5.0, don't include collections or highriskcredit
	inquiry_total_hit := isAuto or isBanking or isCollection or isMOrtgage or isHighRiskCredit or isRetail or
				isCommunications or isOther;
	
	self.industry := industry;
	self.vertical := vertical;
	self.func := func;
	self.logdate := if(inquiry_hit, logdate, skip);		

	self.Total_Inq := inquiry_total_hit;
	self.Inquiry := inquiry_hit;	
	self.Collection := isCollection;
	self.Auto := isAuto;
	self.Banking := isBanking;
	self.Mortgage := isMortgage;
	self.HighRiskCredit := isHighRiskCredit;
	self.Retail := isRetail;
	self.Communications := isCommunications;
	self.PrepaidCards := isPrepaidCards; 
	self.RetailPayments := isRetailPayments; 
	self.Utilities := isUtilities; 
	self.QuizProvider := isQuizProvider; 
	self.StudentLoan := isStudentLoan; 
	self.Other := isOther;

  self.isAuto_temp := isAuto; 
	self.isMortgage_temp := isMortgage; 
	self.isHighRiskCredit_temp := isHighRiskCredit;
			
end;
	
temprec roll( temprec le, temprec rt ) := TRANSFORM		
	self := le;
END;
		
fcra_inquiries := project(Inquiry_AccLogs.Key_FCRA_DID((unsigned)search_info.datetime[1..4]>=2008), transform_raw(left));
//output(fcra_inquiries,named('fcra_inquiries')); 
s_fcra_inquiries := sort(fcra_inquiries,person_q.appended_adl, -logdate);

InqADLs := table(s_fcra_inquiries, {log_month := logdate[1..6], 
														//adl := person_q.appended_ADL,
														lexid := person_q.appended_ADL,
														total := count(group,Total_Inq),
														auto_inquiries := count(group, Auto),
														banking_inquiries := count(group, Banking),
														collection_inquiries := count(group, Collection),
														communications_inquiries := count(group, Communications),
														HighRiskCredit_inquiries := count(group, HighRiskCredit),
														Mortgage_inquiries := count(group, Mortgage),
														Retail_inquiries := count(group, Retail),
														Other_inquiries := count(group, Other)
														}, logdate[1..6], person_q.appended_ADL );

InqADLsByMonth := table(InqADLs, {
														log_month, 
														//unique_adls := count(group,total>0),
														unique_lexids := count(group,total>0),
														// total_records := count(group, total>0),
														auto := count(group, auto_inquiries>0),
														banking := count(group, Banking_inquiries>0),
														collection := count(group, Collection_inquiries>0),
														communications := count(group, Communications_inquiries>0),
														HighRiskCredit := count(group, HighRiskCredit_inquiries>0),
														Mortgage := count(group, Mortgage_inquiries>0),
														Retail := count(group, Retail_inquiries>0),
														Other := count(group, Other_inquiries>0)
														}, log_month, few);
														
//output(sort(InqADLsByMonth, -log_month), named('Inq_ADLs_By_Month'));
srt_InqADLsByMonth := sort(InqADLsByMonth, -log_month);

InqByMonth := table(InqADLs, {
														log_month, 
														total_records := sum(group, total),
														auto := sum(group, auto_inquiries),
														banking := sum(group, Banking_inquiries),
														collection := sum(group, Collection_inquiries),
														communications := sum(group, Communications_inquiries),
														HighRiskCredit := sum(group, HighRiskCredit_inquiries),
														Mortgage := sum(group, Mortgage_inquiries),
														Retail := sum(group, Retail_inquiries),
														Other := sum(group, Other_inquiries)
														}, log_month, few);

//output(sort(InqByMonth, -log_month), named('InqByMonth'));
srt_InqByMonth := sort(InqByMonth, -log_month);

//Despray CSV to bctlpedata12 (one thor file and one csv file). FTP to \\Risk\inf\Data_Factory\DI_Landingzone
despray_InqADLsByMonth := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_InquiryRpts_FCRAInq41_InqADLsByMonth_'+ filedate +'.csv',
																		pHostname, 
																		pTarget+ '/tbl_InquiryRpts_FCRAInq41_InqADLsByMonth_'+ filedate +'.csv'
																		,,,,true);

despray_InqByMonth :=STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_InquiryRpts_FCRAInq41_InqByMonth_'+ filedate +'.csv',
																		pHostname, 
																		pTarget+ '/tbl_InquiryRpts_FCRAInq41_InqByMonth_'+ filedate +'.csv'
																		,,,,true);

//if everything in the Sequential statement runs, it will send the Success email, else it will send the Failure email
email_alert := SEQUENTIAL(
					 output(srt_InqADLsByMonth,,'~thor_data400::data_insight::data_metrics::tbl_InquiryRpts_FCRAInq41_InqADLsByMonth_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))
					,output(srt_InqByMonth,,'~thor_data400::data_insight::data_metrics::tbl_InquiryRpts_FCRAInq41_InqByMonth_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))					
					,despray_InqADLsByMonth
					,despray_InqByMonth):
					Success(FileServices.SendEmail(pContact, 'InquiryRpts Group: InquiryRpts_bwrFCRAInq41 Build Succeeded', workunit + ': Build complete.' + filedate)),
					Failure(FileServices.SendEmail(pContact, 'InquiryRpts Group: InquiryRpts_bwrFCRAInq41 Build Failed', workunit + filedate + '\n' + FAILMESSAGE)
													);
return email_alert;

end;
					
