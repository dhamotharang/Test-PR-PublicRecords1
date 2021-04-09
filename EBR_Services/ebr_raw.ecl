import AutostandardI, census_data, doxie, doxie_cbrs, dx_ebr, ebr, ebr_services, risk_indicators, TopBusiness_Services, ut;

export ebr_raw := MODULE

  // Gets  FILE NUMBER from BDIDs
  export get_file_number_from_bdids(dataset(doxie_cbrs.layout_references) in_bdids) := function

    bdids := DEDUP(SORT(in_bdids,bdid),bdid);
    pre_res := dx_EBR.Get.Header_0010_By_Bdid(bdids, keep_number := 1000);
    res := PROJECT(pre_res, TRANSFORM(EBR_Services.Layout_file_number, SELF := LEFT));
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

    export by_file_number(DATASET(ebr_services.layout_file_number) fnums) :=
      FUNCTION
        ebr_services.Layout_EBR_Search form(ebr.Key_0010_Header_FILE_NUMBER LE) :=
        TRANSFORM
          SELF.penalt := 0;
          SELF.timezone := '';
          SELF := LE;
          SELF := [];
        END;
        ebr_recs := dx_EBR.Get.Header_0010_By_File_Number(fnums, keep_number := EBR_Services.constants.maxcounts.default);
        p := PROJECT(ebr_recs, form(LEFT));
        ut.getTimeZone(p,phone_number,timezone,p_w_tzone);
      RETURN p_w_tzone;
    END;
  END;





  export report_view := MODULE

    export by_file_number(DATASET(ebr_services.layout_file_number) fnums,boolean current_demo5610=true) :=
      FUNCTION
      mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated (AutoStandardI.GlobalModule());
      get_county_name(STRING2 st, STRING5 county_code) :=
        CHOOSEN(Census_Data.Key_Fips2County(st <> '' and county_code <> '' and
                                            keyed(state_code=st) and
                                            keyed(county_fips=county_code[3..5])),1)[1].county_name;


      ebr_services.Layout_0010_Header_Base_Expanded add_header_county(ebr.Key_0010_Header_FILE_NUMBER le) :=
      TRANSFORM
        SELF.county_name := get_county_name(le.st,le.county);
          telcordia := Risk_Indicators.Key_Telcordia_tds(
          length(trim(le.phone_number,all))=10 and
          keyed(le.phone_number[1..3]=npa) and
          keyed(le.phone_number[4..6]=nxx))[1];
        SELF.timezone := ut.TimeZone_Convert((unsigned1) telcordia.timezone,telcordia.state);
        SELF := le;
      END;

      ebr_services.Layout_5000_Bank_Details_Expanded add_bank_details_county(ebr.Key_5000_Bank_Details_FILE_NUMBER le) :=
      TRANSFORM
        SELF.county_name :=get_county_name(le.st,le.county);
          telcordia := Risk_Indicators.Key_Telcordia_tds(
          keyed(le.telephone[1..3]=npa) and
          keyed(le.telephone[4..6]=nxx))[1];
        SELF.timezone := ut.TimeZone_Convert((unsigned1) telcordia.timezone,telcordia.state);
        SELF := le;
      END;

      ebr.Layout_5610_demographic_data_Out and not[global_sid,record_sid] add_demographic_5610(ebr.Key_5610_Demographic_Data_FILE_NUMBER le) :=
      TRANSFORM
          telcordia := Risk_Indicators.Key_Telcordia_tds(
          keyed(le.corp_phone[1..3]=npa) and
          keyed(le.corp_phone[4..6]=nxx))[1];
        SELF.timezone := ut.TimeZone_Convert((unsigned1) telcordia.timezone,telcordia.state);
        SELF := le;
      END;


      ebr_services.Layout_6510_Government_Debarred_Contractor_Expanded add_gvt_debarred_county(ebr.Key_6510_Government_Debarred_Contractor_FILE_NUMBER le) :=
      TRANSFORM
        SELF.county_name := get_county_name(le.clean_business_address.st,le.clean_business_address.county);
        SELF := le;
      END;

      ebr_services.Layout_EBR_Report get_header(fnums le) :=
      TRANSFORM
            SELF.file_number := le.file_number;

            header_recs := dx_EBR.Read.Header_0010_By_File_Number(le.file_number, EBR_Services.constants.maxcounts.default);
            SELF.Header_recs := SORT(PROJECT(header_recs, add_header_county(LEFT)), -process_date_last_seen)[1];
            SELF :=[];
      END;

      ebr_services.Layout_1000_Executive_Summary_Expanded add_exec_summary(ebr.Key_1000_Executive_Summary_FILE_NUMBER le):=
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
            default_n := EBR_Services.constants.maxcounts.default;

            // trade-line type data
            // An initial Choosen to protect against bad data.
            // Second choosen to only match against the most current header (0010 recs) process date
            // The current_only param allows for the return of all of the records, default value is true.
            // Sorting by sequence number, and then can also include other post-sequence sort criteria
            // Show a different number of records, depending on what makes sense for that particular data
            // For trade-line type data, we only want to show the latest processed report
            m(ds, cn, os= '-process_date') := MACRO
                  CHOOSEN(SORT(ds, sequence_number, os, RECORD), cn)
            ENDMACRO;

            executive_summary_recs := PROJECT(dx_EBR.Read.Executive_Summary_1000_By_File_Number(le.file_number, default_n, dt), add_exec_summary(LEFT));
            SELF.executive_summary_recs := m(executive_summary_recs, EBR_Services.constants.maxcounts.Executive_Summary);

            trade_recs := PROJECT(dx_EBR.Read.Trade_2000_By_File_Number(le.file_number, default_n, dt), ebr.Layout_2000_Trade_In);
            SELF.trade_recs := m(trade_recs, EBR_Services.constants.maxcounts.Trade, -date_reported);

            trade_payment_total_recs := PROJECT(dx_EBR.Read.Trade_Payment_Totals_2015_By_File_Number(le.file_number, default_n, dt), ebr.Layout_2015_Trade_Payment_Totals_In);
            SELF.trade_payment_total_recs := m(trade_payment_total_recs, EBR_Services.constants.maxcounts.Trade_Payment_Totals);

            trade_payment_trend_recs := PROJECT(dx_EBR.Read.Trade_Payment_Trends_2020_By_File_Number(le.file_number, default_n, dt), ebr.Layout_2020_Trade_Payment_Trends_Base and not[global_sid,record_sid]);
            SELF.trade_payment_trend_recs := m(trade_payment_trend_recs, EBR_Services.constants.maxcounts.Trade_Payment_Trends, -(unsigned)(trend_yy+trend_mm));

            trade_quarterly_average_recs := PROJECT(dx_EBR.Read.Trade_Quarterly_Averages_2025_By_File_Number(le.file_number, default_n, dt), ebr.Layout_2025_Trade_Quarterly_Averages_Base and not[global_sid,record_sid]);
            SELF.trade_quarterly_average_recs := m(trade_quarterly_average_recs, EBR_Services.constants.maxcounts.Trade_Quarterly_Averages, -(unsigned)(quarter_yy+quarter));

            collateral_account_recs := PROJECT(dx_EBR.Read.Collateral_Accounts_4500_by_File_Number(le.file_number, default_n, dt), ebr.Layout_4500_Collateral_Accounts_In);
            SELF.collateral_account_recs := m(collateral_account_recs, EBR_Services.constants.maxcounts.Collateral_Accounts);

            bank_detail_recs := PROJECT(dx_EBR.Read.Bank_Details_5000_By_File_Number(le.file_number, default_n, dt), add_bank_details_county(LEFT));
            SELF.bank_detail_recs := m(bank_detail_recs, EBR_Services.constants.maxcounts.Bank_Details);

            demographic_data_5600_recs := PROJECT(dx_EBR.Read.Demographic_Data_5600_By_File_Number(le.file_number, default_n, dt),
              TRANSFORM(EBR_Services.Layouts.demographic_5600_output_rec,
                SELF.SALES_ACTUAL := (STRING20)TopBusiness_Services.Functions.convert_EBR_sales(left.sales_actual),
                SELF := LEFT));
            SELF.demographic_data_5600_recs := m(demographic_data_5600_recs, EBR_Services.constants.maxcounts.Demographic_Data);

            // Double the initial choosen amount to account for possible suppression.
            demographic_data_5610_recs_raw := IF(current_demo5610,
              dx_EBR.Read.Demographic_Data_5610_By_File_Number(le.file_number, mod_access, default_n*2, dt),
              dx_EBR.Read.Demographic_Data_5610_By_File_Number(le.file_number, mod_access, default_n*2));

            demographic_data_5610_recs := PROJECT(demographic_data_5610_recs_raw, add_demographic_5610(left));
            SELF.demographic_data_5610_recs :=  m(demographic_data_5610_recs, EBR_Services.constants.maxcounts.Demographic_Data);

            government_trade_recs := PROJECT(dx_EBR.Read.Government_Trade_6500_By_File_Number(le.file_number, default_n, dt), ebr.Layout_6500_Government_Trade_In);
            SELF.government_trade_recs := m(government_trade_recs, EBR_Services.constants.maxcounts.Government_Trade);

            government_debarred_contractor_recs:= PROJECT(dx_EBR.Read.Government_Debarred_Contractor_6510_By_File_Number(le.file_number, default_n, dt), add_gvt_debarred_county(LEFT));
            SELF.government_debarred_contractor_recs := m(government_debarred_contractor_recs, EBR_Services.constants.maxcounts.Government_Debarred_Contractor);

            snp_data_recs := PROJECT(dx_EBR.Read.SNP_Data_7010_By_File_Number(le.file_number, default_n, dt), ebr.Layout_7010_SNP_Data_In);
            SELF.snp_data_recs := m(snp_data_recs, EBR_Services.constants.maxcounts.SNP_Data);

            inquiry_recs_pre := PROJECT(dx_EBR.Read.Inquiries_6000_By_File_Number(le.file_number, default_n, dt), ebr.Layout_6000_Inquiries_Base);
            inquiry_recs := m(inquiry_recs_pre, EBR_Services.constants.maxcounts.Inquiries, -(unsigned)(inq_yy+inq_mm+inq_count));
            SELF.inquiry_recs := format_inquiry_section(inquiry_recs);

            // public-records type data
            // An initial Choosen to protect against bad data
            // Sorting to bring latest date filed to the top
            // Always show just the first 100
            // For public-records type data, we show historical records; that is, from across process dates
            m_p(ds,cn) := macro
               CHOOSEN(SORT(DEDUP(ds, record, except process_date, sequence_number, all), -date_filed, RECORD), cn)
            ENDMACRO;

            bankruptcy_recs := PROJECT(dx_ebr.Read.Bankruptcy_4010_By_File_Number(le.file_number, default_n), ebr.Layout_4010_Bankruptcy_In);
            SELF.bankruptcy_recs := m_p(bankruptcy_recs, EBR_Services.constants.maxcounts.public_records);

            tax_lien_recs := PROJECT(dx_EBR.Read.Tax_Liens_4020_By_File_Number(le.file_number, default_n), ebr.Layout_4020_Tax_Liens_In);
            SELF.tax_lien_recs := m_p(tax_lien_recs, EBR_Services.constants.maxcounts.public_records);

            judgment_recs := PROJECT(dx_EBR.Read.Judgement_4030_By_File_Number(le.file_number, default_n), ebr.Layout_4030_Judgement_In);
            SELF.judgment_recs := m_p(judgment_recs, EBR_Services.constants.maxcounts.public_records);

            ucc_filing_recs := PROJECT(dx_EBR.Read.UCC_Filings_4510_By_File_Number(le.file_number, default_n), ebr.Layout_4510_UCC_Filings_In);
            SELF.ucc_filing_recs := m_p(ucc_filing_recs, EBR_Services.constants.maxcounts.public_records);
        END;

        p := PROJECT(p1, form(LEFT));
      RETURN p;
    END;
  END;

  export source_view := MODULE

    export by_file_number(DATASET(ebr_services.layout_file_number) fnums) :=	FUNCTION
      // Get current report and then add to it.
      rpt_recs := report_view.by_file_number(fnums,false);

      // Capture all previous header records
      ebr_services.Layout_EBR_Source add_historcial_header(ebr_services.Layout_EBR_Report l) :=	TRANSFORM
        SELF.curr_header_rec := l.header_recs;

        historical_header_recs := dx_EBR.Read.Header_0010_By_File_Number(l.file_number,
          EBR_Services.constants.maxcounts.default,
          excluded_record_types :=['C']);
        historical_header_recs_projected := PROJECT(historical_header_recs, TRANSFORM(ebr_services.Layout_0010_Header_Base_Expanded,
          SELF := LEFT, SELF := []));
        SELF.historical_header_recs := SORT(CHOOSEN(historical_header_recs_projected, ebr_services.constants.maxcounts.Historical_Header), -process_date_last_seen);
        SELF := l;
        SELF :=[];
      END;

      src_recs := PROJECT(rpt_recs,add_historcial_header(LEFT));
      RETURN src_recs;
    END;
  END; /* source view */
END;
