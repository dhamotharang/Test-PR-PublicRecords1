import census_data,doxie_cbrs,ebr,gong,risk_indicators,TopBusiness_Services,ut;

export ebr_raw := MODULE

	shared initial_choosen := 2000;

	// Gets  FILE NUMBE from BDIDs
	export get_file_number_from_bdids(dataset(doxie_cbrs.layout_references) in_bdids) := function
		key := ebr.Key_0010_Header_BDID;
		res := join(dedup(sort(in_bdids,bdid),bdid),key,
								keyed(left.bdid = right.bdid),
								transform(layout_file_number,self := right),
								keep(1000));
		return dedup(res,file_number,all);
	end;
	

	export search_view := MODULE
		export by_autokey_and_header_recs(DATASET(ebr.Layout_0010_Header_Base) head) :=
			FUNCTION
				ebr_services.Layout_EBR_Search form(head le) :=
				TRANSFORM
					SELF.penalt := 0;
					SELF.timezone :='';
					SELF := le;
				END;				
				p := PROJECT(head, form(LEFT));
				ut.getTimeZone(p,phone_number,timezone,p_w_tzone)
			RETURN p_w_tzone;
		END;
		
		export by_file_number(DATASET(layout_file_number) fnums) :=
			FUNCTION
				ebr_services.Layout_EBR_Search form(fnums le, ebr.Key_0010_Header_FILE_NUMBER ri) :=
				TRANSFORM
					SELF.penalt := 0;
					SELF.timezone := '';
					SELF := ri;
					self := [];
				END;				
				p := JOIN(fnums, ebr.Key_0010_Header_FILE_NUMBER, keyed(LEFT.File_Number=RIGHT.File_Number), form(LEFT,RIGHT), KEEP(constants.maxcounts.default));
				ut.getTimeZone(p,phone_number,timezone,p_w_tzone)
			RETURN p_w_tzone;
		END;
	END;
	
	
	
	
	
	export report_view := MODULE
		
		export by_file_number(DATASET(layout_file_number) fnums,boolean current_demo5610=true) :=
			FUNCTION
	
			get_county_name(STRING2 st, STRING5 county_code) :=
				CHOOSEN(Census_Data.Key_Fips2County(st <> '' and county_code <> '' and 
																						keyed(state_code=st) and 
																						keyed(county_fips=county_code[3..5])),1)[1].county_name;
	

			Layout_0010_Header_Base_Expanded add_header_county(ebr.Key_0010_Header_FILE_NUMBER le) :=
			TRANSFORM
				SELF.county_name := get_county_name(le.st,le.county);
					telcordia := Risk_Indicators.Key_Telcordia_tds(
					length(trim(le.phone_number,all))=10 and
					keyed(le.phone_number[1..3]=npa) and
					keyed(le.phone_number[4..6]=nxx))[1];
				SELF.timezone := ut.TimeZone_Convert((unsigned1) telcordia.timezone,telcordia.state);		
				SELF := le;
			END;
			
			Layout_5000_Bank_Details_Expanded add_bank_details_county(ebr.Key_5000_Bank_Details_FILE_NUMBER le) :=
			TRANSFORM
				SELF.county_name :=get_county_name(le.st,le.county);
					telcordia := Risk_Indicators.Key_Telcordia_tds(
					keyed(le.telephone[1..3]=npa) and
					keyed(le.telephone[4..6]=nxx))[1];
				SELF.timezone := ut.TimeZone_Convert((unsigned1) telcordia.timezone,telcordia.state);		
				SELF := le;
			END;

			ebr.Layout_5610_demographic_data_Out add_demographic_5610(ebr.Key_5610_Demographic_Data_FILE_NUMBER le) :=
			TRANSFORM
					telcordia := Risk_Indicators.Key_Telcordia_tds(
					keyed(le.corp_phone[1..3]=npa) and
					keyed(le.corp_phone[4..6]=nxx))[1];
				SELF.timezone := ut.TimeZone_Convert((unsigned1) telcordia.timezone,telcordia.state);		
				SELF := le;
			END;


			Layout_6510_Government_Debarred_Contractor_Expanded add_gvt_debarred_county(ebr.Key_6510_Government_Debarred_Contractor_FILE_NUMBER le) :=
			TRANSFORM
				SELF.county_name := get_county_name(le.clean_business_address.st,le.clean_business_address.county);
				SELF := le;
			END;
		
			ebr_services.Layout_EBR_Report get_header(fnums le) :=
			TRANSFORM
						SELF.file_number := le.file_number;
						SELF.Header_recs := SORT(CHOOSEN(PROJECT(ebr.Key_0010_Header_FILE_NUMBER(keyed(file_number=le.file_number)),add_header_county(LEFT)),constants.maxcounts.default),-process_date_last_seen)[1];					
						SELF :=[];
			END;
			
			Layout_1000_Executive_Summary_Expanded add_exec_summary(ebr.Key_1000_Executive_Summary_FILE_NUMBER le):=
			transform
							self.PAYMENT_PERFORMANCE_DECODE := EBR_Services.decode.DPP(le.PAYMENT_PERFORMANCE);
							self.PAYMENT_TREND_DECODE := EBR_Services.decode.DPT(le.PAYMENT_TREND);
							Self :=le;
			END;
		
			p1 := PROJECT(fnums, get_header(LEFT));
		
			ebr_services.Layout_EBR_Report form(ebr_services.Layout_EBR_Report le) :=
				TRANSFORM
						SELF.file_number := le.file_number;
						SELF.header_recs := le.header_recs;
				
						dt := (unsigned)(le.header_recs.process_date_last_seen);
				
						// trade-line type data
						// An initial Choosen to protect against bad data.
						// Second choosen to only match against the most current header (0010 recs) process date 
						// The current_only param allows for the return of all of the records, default value is true.
						// Sorting by sequence number, and then can also include other post-sequence sort criteria
						// Show a different number of records, depending on what makes sense for that particular data
						// For trade-line type data, we only want to show the latest processed report
						m(ds,cn,os='-process_date') := macro
									CHOOSEN(SORT(CHOOSEN(ds((unsigned)process_date=dt),constants.maxcounts.default),sequence_number,os,RECORD),cn)
						ENDMACRO;
						m_all(ds,cn,os='-process_date') := macro
						 			CHOOSEN(SORT(CHOOSEN(ds,constants.maxcounts.default),sequence_number,os,RECORD),cn)
						ENDMACRO;				
						SELF.executive_summary_recs := m(PROJECT(ebr.Key_1000_Executive_Summary_FILE_NUMBER(keyed(file_number=le.file_number)),add_exec_summary(left)),constants.maxcounts.Executive_Summary);
						SELF.trade_recs := m(PROJECT(ebr.Key_2000_Trade_FILE_NUMBER(keyed(file_number=le.file_number)),ebr.Layout_2000_Trade_In),constants.maxcounts.Trade,-date_reported);
						SELF.trade_payment_total_recs := m(PROJECT(ebr.Key_2015_Trade_Payment_Totals_FILE_NUMBER(keyed(file_number=le.file_number)),ebr.Layout_2015_Trade_Payment_Totals_In),constants.maxcounts.Trade_Payment_Totals);
						SELF.trade_payment_trend_recs := m(PROJECT(ebr.Key_2020_Trade_Payment_Trends_FILE_NUMBER(keyed(file_number=le.file_number)),ebr.Layout_2020_Trade_Payment_Trends_Base),200,-(unsigned)(trend_yy+trend_mm));
						SELF.trade_quarterly_average_recs := m(PROJECT(ebr.Key_2025_Trade_Quarterly_Averages_FILE_NUMBER(keyed(file_number=le.file_number)),ebr.Layout_2025_Trade_Quarterly_Averages_Base),constants.maxcounts.Trade_Payment_Trends,-(unsigned)(quarter_yy+quarter));
						SELF.collateral_account_recs := m(PROJECT(ebr.Key_4500_Collateral_Accounts_FILE_NUMBER(keyed(file_number=le.file_number)),ebr.Layout_4500_Collateral_Accounts_In),constants.maxcounts.Collateral_Accounts);
						self.bank_detail_recs := m(PROJECT(ebr.Key_5000_Bank_Details_FILE_NUMBER(keyed(file_number=le.file_number)),add_bank_details_county(LEFT)),constants.maxcounts.Bank_Details);
						SELF.demographic_data_5600_recs := m(PROJECT(ebr.Key_5600_Demographic_Data_FILE_NUMBER(keyed(file_number=le.file_number)),
                                                   TRANSFORM(EBR_Services.Layouts.demographic_5600_output_rec,
                                                             SELF.SALES_ACTUAL := (STRING20)TopBusiness_Services.Functions.convert_EBR_sales(left.sales_actual),
                                                             SELF := LEFT)),constants.maxcounts.Demographic_Data);			
						SELF.demographic_data_5610_recs := IF(current_demo5610,m(PROJECT(ebr.Key_5610_Demographic_Data_FILE_NUMBER(keyed(file_number=le.file_number)),add_demographic_5610(left)),constants.maxcounts.Demographic_Data),
																																	m_all(PROJECT(ebr.Key_5610_Demographic_Data_FILE_NUMBER(keyed(file_number=le.file_number)),add_demographic_5610(left)),constants.maxcounts.Demographic_Data));
						SELF.government_trade_recs := m(PROJECT(ebr.Key_6500_Government_Trade_FILE_NUMBER(keyed(file_number=le.file_number)),ebr.Layout_6500_Government_Trade_In),constants.maxcounts.Government_Trade);
						SELF.government_debarred_contractor_recs := m(PROJECT(ebr.Key_6510_Government_Debarred_Contractor_FILE_NUMBER(keyed(file_number=le.file_number)),add_gvt_debarred_county(LEFT)),constants.maxcounts.Government_Debarred_Contractor);
						SELF.snp_data_recs := m(PROJECT(ebr.Key_7010_SNP_Data_FILE_NUMBER(keyed(file_number=le.file_number)),ebr.Layout_7010_SNP_Data_In),constants.maxcounts.SNP_Data);


						inquiry_recs := m(PROJECT(ebr.Key_6000_Inquiries_FILE_NUMBER(keyed(file_number=le.file_number)),ebr.Layout_6000_Inquiries_Base),constants.maxcounts.Inquiries, -(unsigned)(inq_yy+inq_mm+inq_count));

						SELF.inquiry_recs := format_inquiry_section(inquiry_recs);

						// public-records type data
						// An initial Choosen to protect against bad data
						// Sorting to bring latest date filed to the top
						// Always show just the first 100
						// For public-records type data, we show historical records; that is, from across process dates
						m_p(ds,cn) := macro
							CHOOSEN(SORT(dedup(CHOOSEN(ds,initial_choosen),record,except process_date,sequence_number,all),-date_filed,RECORD),cn)
						ENDMACRO;			
						SELF.bankruptcy_recs := m_p(PROJECT(ebr.Key_4010_Bankruptcy_FILE_NUMBER(keyed(file_number=le.file_number)),ebr.Layout_4010_Bankruptcy_In),constants.maxcounts.public_records);
						SELF.tax_lien_recs := m_p(PROJECT(ebr.Key_4020_Tax_Liens_FILE_NUMBER(keyed(file_number=le.file_number)),ebr.Layout_4020_Tax_Liens_In),constants.maxcounts.public_records);
						SELF.judgment_recs := m_p(PROJECT(ebr.Key_4030_Judgement_FILE_NUMBER(keyed(file_number=le.file_number)),ebr.Layout_4030_Judgement_In),constants.maxcounts.public_records);
						SELF.ucc_filing_recs := m_p(PROJECT(ebr.Key_4510_UCC_Filings_FILE_NUMBER(keyed(file_number=le.file_number)),ebr.Layout_4510_UCC_Filings_In),constants.maxcounts.public_records);
				END;	
				
				p := PROJECT(p1, form(LEFT));
			RETURN p;
		END;
	END;
	
	export source_view := MODULE
	
		export by_file_number(DATASET(layout_file_number) fnums) :=	FUNCTION
			// Get current report and then add to it.
			rpt_recs := report_view.by_file_number(fnums,false);
			
			// Capture all previous header records
			ebr_services.Layout_EBR_Source add_historcial_header(ebr_services.Layout_EBR_Report l) :=	TRANSFORM
						SELF.curr_header_rec := l.header_recs;
						SELF.historical_header_recs := SORT(
																							CHOOSEN(
																									PROJECT(ebr.Key_0010_Header_FILE_NUMBER(keyed(file_number=l.file_number),record_type != 'C'),
																															TRANSFORM(Layout_0010_Header_Base_Expanded,
																																				SELF := LEFT,SELF:=[])),
																									constants.maxcounts.Historical_Header),
																							-process_date_last_seen);
						SELF := l;
						SELF :=[];
			END;
			
			src_recs := PROJECT(rpt_recs,add_historcial_header(LEFT));
			RETURN src_recs;
		END;
	END; /* source view */
END;