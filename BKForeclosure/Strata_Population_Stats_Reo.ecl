﻿IMPORT ut,strata, BKForeclosure;

EXPORT Strata_Population_Stats_Reo(STRING filedate) := FUNCTION;
basefile_Reo := File_BK_Foreclosure.fReo;
rPopulationStats_Reo := RECORD
      basefile_Reo.fips_cd;
      CountGroup     := COUNT(GROUP); 
			record_id_CountNonBlank         	:= SUM(GROUP,IF(basefile_Reo.record_id<>0,1,0));   
	    date_first_seen_CountNonBlank   	:= SUM(GROUP,IF(basefile_Reo.date_first_seen<>'',1,0));   
	    date_last_seen_CountNonBlank    	:= SUM(GROUP,IF(basefile_Reo.date_last_seen<>'',1,0));  
	    date_vendor_first_reported_CountNonBlank   := SUM(GROUP,IF(basefile_Reo.date_vendor_first_reported<>'',1,0));   
	    date_vendor_last_reported_CountNonBlank    := SUM(GROUP,IF(basefile_Reo.date_vendor_last_reported<>'',1,0));   
	    process_date_CountNonBlank      	:= SUM(GROUP,IF(basefile_Reo.process_date<>'',1,0));   
      src_CountNonBlank               	:= SUM(GROUP,IF(basefile_Reo.src<>'',1,0));  
	    Delete_Flag_CountNonBlank         := SUM(GROUP,IF(basefile_Reo.Delete_Flag<>'',1,0));
			foreclosure_id_CountNonBlank			:= SUM(GROUP,IF(basefile_Reo.foreclosure_id<>'',1,0));
			ln_filedate_CountNonBlank         := SUM(GROUP,IF(basefile_Reo.ln_filedate<>'',1,0));
	    bk_infile_type_CountNonBlank      := SUM(GROUP,IF(basefile_Reo.bk_infile_type<>'',1,0));	
      prop_full_addr_CountNonBlank      := SUM(GROUP,IF(basefile_Reo.prop_full_addr<>'',1,0));
      prop_addr_city_CountNonBlank      := SUM(GROUP,IF(basefile_Reo.prop_addr_city<>'',1,0));
      prop_addr_state_CountNonBlank     := SUM(GROUP,IF(basefile_Reo.prop_addr_state<>'',1,0));
      prop_addr_zip5_CountNonBlank      := SUM(GROUP,IF(basefile_Reo.prop_addr_zip5<>'',1,0));
      prop_addr_zip4_CountNonBlank      := SUM(GROUP,IF(basefile_Reo.prop_addr_zip4<>'',1,0));
      prop_addr_unit_type_CountNonBlank := SUM(GROUP,IF(basefile_Reo.prop_addr_unit_type<>'',1,0));
      prop_addr_unit_no_CountNonBlank   := SUM(GROUP,IF(basefile_Reo.prop_addr_unit_no<>'',1,0));
      prop_addr_house_no_CountNonBlank  := SUM(GROUP,IF(basefile_Reo.prop_addr_house_no<>'',1,0));
      prop_addr_predir_CountNonBlank    := SUM(GROUP,IF(basefile_Reo.prop_addr_predir<>'',1,0));
      prop_addr_street_CountNonBlank    := SUM(GROUP,IF(basefile_Reo.prop_addr_street<>'',1,0));
      prop_addr_suffix_CountNonBlank    := SUM(GROUP,IF(basefile_Reo.prop_addr_suffix<>'',1,0));
      prop_addr_postdir_CountNonBlank   := SUM(GROUP,IF(basefile_Reo.prop_addr_postdir<>'',1,0));
      prop_addr_carrier_rt_CountNonBlank:= SUM(GROUP,IF(basefile_Reo.prop_addr_carrier_rt<>'',1,0));
      recording_date_CountNonBlank      := SUM(GROUP,IF(basefile_Reo.recording_date<>'',1,0));
      recording_book_num_CountNonBlank  := SUM(GROUP,IF(basefile_Reo.recording_book_num<>'',1,0));
      recording_page_num_CountNonBlank  := SUM(GROUP,IF(basefile_Reo.recording_page_num<>'',1,0));
      recording_doc_num_CountNonBlank   := SUM(GROUP,IF(basefile_Reo.recording_doc_num<>'',1,0));
      doc_type_cd_CountNonBlank         := SUM(GROUP,IF(basefile_Reo.doc_type_cd<>'',1,0));
      APN_CountNonBlank                 := SUM(GROUP,IF(basefile_Reo.APN<>'',1,0));
      multi_APN_CountNonBlank           := SUM(GROUP,IF(basefile_Reo.multi_APN<>'',1,0));
      partial_interest_trans_CountNonBlank	:= SUM(GROUP,IF(basefile_Reo.partial_interest_trans<>'',1,0));
      seller1_fname_CountNonBlank       := SUM(GROUP,IF(basefile_Reo.seller1_fname<>'',1,0));
      seller1_lname_CountNonBlank       := SUM(GROUP,IF(basefile_Reo.seller1_lname<>'',1,0));
      seller1_id_CountNonBlank          := SUM(GROUP,IF(basefile_Reo.seller1_id<>'',1,0));
      seller2_fname_CountNonBlank       := SUM(GROUP,IF(basefile_Reo.seller2_fname<>'',1,0));
      seller2_lname_CountNonBlank       := SUM(GROUP,IF(basefile_Reo.seller2_lname<>'',1,0));
      buyer1_fname_CountNonBlank        := SUM(GROUP,IF(basefile_Reo.buyer1_fname<>'',1,0));
      buyer1_lname_CountNonBlank        := SUM(GROUP,IF(basefile_Reo.buyer1_lname<>'',1,0));
      buyer1_id_cd_CountNonBlank        := SUM(GROUP,IF(basefile_Reo.buyer1_id_cd<>'',1,0));
      buyer2_fname_CountNonBlank        := SUM(GROUP,IF(basefile_Reo.buyer2_fname<>'',1,0));
      buyer2_lname_CountNonBlank        := SUM(GROUP,IF(basefile_Reo.buyer2_lname<>'',1,0));
      buyer_vesting_cd_CountNonBlank    := SUM(GROUP,IF(basefile_Reo.buyer_vesting_cd<>'',1,0));
      concurrent_doc_num_CountNonBlank  := SUM(GROUP,IF(basefile_Reo.concurrent_doc_num<>'',1,0));
      buyer_mail_city_CountNonBlank     := SUM(GROUP,IF(basefile_Reo.buyer_mail_city<>'',1,0));
      buyer_mail_state_CountNonBlank    := SUM(GROUP,IF(basefile_Reo.buyer_mail_state<>'',1,0));
      buyer_mail_zip5_CountNonBlank     := SUM(GROUP,IF(basefile_Reo.buyer_mail_zip5<>'',1,0));
      buyer_mail_zip4_CountNonBlank     := SUM(GROUP,IF(basefile_Reo.buyer_mail_zip4<>'',1,0));
      legal_lot_cd_CountNonBlank        := SUM(GROUP,IF(basefile_Reo.legal_lot_cd<>'',1,0));
      legal_lot_num_CountNonBlank       := SUM(GROUP,IF(basefile_Reo.legal_lot_num<>'',1,0));
      legal_block_CountNonBlank         := SUM(GROUP,IF(basefile_Reo.legal_block<>'',1,0));
      legal_section_CountNonBlank       := SUM(GROUP,IF(basefile_Reo.legal_section<>'',1,0));
      legal_district_CountNonBlank      := SUM(GROUP,IF(basefile_Reo.legal_district<>'',1,0));
      legal_land_lot_CountNonBlank      := SUM(GROUP,IF(basefile_Reo.legal_land_lot<>'',1,0));
      legal_unit_CountNonBlank          := SUM(GROUP,IF(basefile_Reo.legal_unit<>'',1,0));
      legacl_city_CountNonBlank         := SUM(GROUP,IF(basefile_Reo.legacl_city<>'',1,0));
      legal_subdivision_CountNonBlank   := SUM(GROUP,IF(basefile_Reo.legal_subdivision<>'',1,0));
      legal_phase_num_CountNonBlank     := SUM(GROUP,IF(basefile_Reo.legal_phase_num<>'',1,0));
      legal_tract_num_CountNonBlank     := SUM(GROUP,IF(basefile_Reo.legal_tract_num<>'',1,0));
      legal_brief_desc_CountNonBlank    := SUM(GROUP,IF(basefile_Reo.legal_brief_desc<>'',1,0));
      Legal_Township_CountNonBlank      := SUM(GROUP,IF(basefile_Reo.Legal_Township<>'',1,0));
      recorder_map_ref_CountNonBlank    := SUM(GROUP,IF(basefile_Reo.recorder_map_ref<>'',1,0));
      prop_buyer_mail_addr_cd_CountNonBlank	:= SUM(GROUP,IF(basefile_Reo.prop_buyer_mail_addr_cd<>'',1,0));
      property_use_cd_CountNonBlank     := SUM(GROUP,IF(basefile_Reo.property_use_cd<>'',1,0));
      orig_contract_date_CountNonBlank  := SUM(GROUP,IF(basefile_Reo.orig_contract_date<>'',1,0));
      sales_price_CountNonBlank         := SUM(GROUP,IF(basefile_Reo.sales_price<>'',1,0));
      sales_price_cd_CountNonBlank      := SUM(GROUP,IF(basefile_Reo.sales_price_cd<>'',1,0));
      city_xfer_tax_CountNonBlank       := SUM(GROUP,IF(basefile_Reo.city_xfer_tax<>'',1,0));
      county_xfer_tax_CountNonBlank     := SUM(GROUP,IF(basefile_Reo.county_xfer_tax<>'',1,0));
      total_xfer_tax_CountNonBlank      := SUM(GROUP,IF(basefile_Reo.total_xfer_tax<>'',1,0));
      concurrent_lender_name_CountNonBlank       := SUM(GROUP,IF(basefile_Reo.concurrent_lender_name<>'',1,0));
      concurrent_lender_type_CountNonBlank       := SUM(GROUP,IF(basefile_Reo.concurrent_lender_type<>'',1,0));
      concurrent_loan_amt_CountNonBlank          := SUM(GROUP,IF(basefile_Reo.concurrent_loan_amt<>'',1,0));
      concurrent_loan_type_CountNonBlank         := SUM(GROUP,IF(basefile_Reo.concurrent_loan_type<>'',1,0));
      concurrent_type_fin_CountNonBlank          := SUM(GROUP,IF(basefile_Reo.concurrent_type_fin<>'',1,0));
      concurrent_interest_rate_CountNonBlank     := SUM(GROUP,IF(basefile_Reo.concurrent_interest_rate<>'',1,0));
      concurrent_due_dt_CountNonBlank            := SUM(GROUP,IF(basefile_Reo.concurrent_due_dt<>'',1,0));
      concurrent_2nd_loan_amt_CountNonBlank      := SUM(GROUP,IF(basefile_Reo.concurrent_2nd_loan_amt<>'',1,0));
      buyer_mail_full_addr_CountNonBlank         := SUM(GROUP,IF(basefile_Reo.buyer_mail_full_addr<>'',1,0));
      buyer_mail_unit_type_CountNonBlank         := SUM(GROUP,IF(basefile_Reo.buyer_mail_unit_type<>'',1,0));
      buyer_mail_unit_no_CountNonBlank           := SUM(GROUP,IF(basefile_Reo.buyer_mail_unit_no<>'',1,0));
      lps_internal_pid_CountNonBlank             := SUM(GROUP,IF(basefile_Reo.lps_internal_pid<>'',1,0));
      buyer_mail_careof_CountNonBlank            := SUM(GROUP,IF(basefile_Reo.buyer_mail_careof<>'',1,0));
      title_co_name_CountNonBlank                := SUM(GROUP,IF(basefile_Reo.title_co_name<>'',1,0));
      legal_desc_cd_CountNonBlank                := SUM(GROUP,IF(basefile_Reo.legal_desc_cd<>'',1,0));
      adj_rate_rider_CountNonBlank               := SUM(GROUP,IF(basefile_Reo.adj_rate_rider<>'',1,0));
      adj_rate_index_CountNonBlank               := SUM(GROUP,IF(basefile_Reo.adj_rate_index<>'',1,0));
      change_index_CountNonBlank                 := SUM(GROUP,IF(basefile_Reo.change_index<>'',1,0));
      rate_change_freq_CountNonBlank             := SUM(GROUP,IF(basefile_Reo.rate_change_freq<>'',1,0));
      int_rate_ngt_CountNonBlank          := SUM(GROUP,IF(basefile_Reo.int_rate_ngt<>'',1,0));
      int_rate_nlt_CountNonBlank          := SUM(GROUP,IF(basefile_Reo.int_rate_nlt<>'',1,0));
      max_int_rate_CountNonBlank          := SUM(GROUP,IF(basefile_Reo.max_int_rate<>'',1,0));
      int_only_period_CountNonBlank       := SUM(GROUP,IF(basefile_Reo.int_only_period<>'',1,0));
      fixed_rate_rider_CountNonBlank      := SUM(GROUP,IF(basefile_Reo.fixed_rate_rider<>'',1,0));
      first_chg_dt_yy_CountNonBlank       := SUM(GROUP,IF(basefile_Reo.first_chg_dt_yy<>'',1,0));
      first_chg_dt_mmdd_CountNonBlank     := SUM(GROUP,IF(basefile_Reo.first_chg_dt_mmdd<>'',1,0));
      prepayment_rider_CountNonBlank      := SUM(GROUP,IF(basefile_Reo.prepayment_rider<>'',1,0));
      prepayment_term_CountNonBlank       := SUM(GROUP,IF(basefile_Reo.prepayment_term<>'',1,0));
      asses_land_use_CountNonBlank        := SUM(GROUP,IF(basefile_Reo.asses_land_use<>'',1,0));
      res_indicator_CountNonBlank         := SUM(GROUP,IF(basefile_Reo.res_indicator<>'',1,0));
      construction_loan_CountNonBlank     := SUM(GROUP,IF(basefile_Reo.construction_loan<>'',1,0));
      inter_family_CountNonBlank          := SUM(GROUP,IF(basefile_Reo.inter_family<>'',1,0));
      cash_purchase_CountNonBlank         := SUM(GROUP,IF(basefile_Reo.cash_purchase<>'',1,0));
      stand_alone_refi_CountNonBlank      := SUM(GROUP,IF(basefile_Reo.stand_alone_refi<>'',1,0));
      equity_credit_line_CountNonBlank    := SUM(GROUP,IF(basefile_Reo.equity_credit_line<>'',1,0));
      reo_flag_CountNonBlank              := SUM(GROUP,IF(basefile_Reo.reo_flag<>'',1,0));
      DistressedSaleFlag_CountNonBlank    := SUM(GROUP,IF(basefile_Reo.DistressedSaleFlag<>'',1,0));	
END;

  
basestrata_Reo := SORT(TABLE(basefile_Reo,rPopulationStats_Reo,fips_cd[1..2],few),fips_cd);

STRATA.createXMLStats(basestrata_Reo,
                      'BKForeclosure_Reo',
					            'data',
					            filedate,
					            BKForeclosure.Roxie_Email_List,
					            strataresults
					           );
return strataresults;
END;							 