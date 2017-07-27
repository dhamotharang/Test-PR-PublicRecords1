import doxie, doxie_cbrs, corp2;

Simplified_Contact := Corp2_services.IParams.getServiceParams().SimplifiedContactReturn;

export corp2_raw := module

	//*******
	//******* Only join bdids to the master file because all bdids should be there
	//*******
	export get_corpkeys_from_bdids(dataset(doxie_cbrs.layout_references) in_bdids,
																 unsigned in_limit = 0) := function
	  key := corp2.Key_Corp_Bdid;

		res := join(dedup(sort(in_bdids,bdid),bdid),key,
		            keyed(left.bdid = right.bdid),
								transform(corp2_services.layout_corpkey,self := right),
								limit(10000));

		ded := dedup(sort(res,corp_key),corp_key);
		return if(in_limit = 0,ded,choosen(ded,in_limit));
	end;
	
	export get_corpkeys_from_bdids_batch(dataset(doxie_cbrs.layout_references_acctno) in_bdids,
																 unsigned in_limit = 0) := function
	  key := corp2.Key_Corp_Bdid;

		res := join(dedup(sort(in_bdids,bdid),bdid),key,
		            keyed(left.bdid = right.bdid),
								transform( {STRING30 acctno, corp2_services.layout_corpkey}, self := left, self := right),
								limit(10000));

		ded := dedup(sort(res,acctno,corp_key),acctno,corp_key);
		return if(in_limit = 0,ded,choosen(ded,in_limit));
	end;	

	export get_corpkeys_from_charter_and_state(dataset(corp2_services.layout_charter_state) in_charter) :=function
		key :=corp2.Key_Corp_StCharter;
		res :=join(in_charter,key,keyed(stringlib.stringtouppercase(LEFT.state)=RIGHT.corp_state_origin OR LEFT.state='') 
					and Keyed(left.charter_nbr=right.corp_sos_charter_nbr),
					transform(corp2_services.layout_corpkey,self:=right),
					limit(10000));
		return (dedup(sort(res,corp_key),corp_key));
		end;

	export get_corpkeys_from_dids(dataset(doxie.layout_references) in_dids) :=function
		key :=corp2.key_cont_did;
		res := join(dedup(sort(in_dids,did),did),key,
		            keyed(left.did = right.did) and
								(~Simplified_Contact or right.cont_type_desc <> Corp2.constants.Ra_Desc),								
								transform(corp2_services.layout_corpkey,self := right),
								limit(10000));
		return dedup(sort(res,corp_key),corp_key);
		end;
		
  export report_view := module
	

		export by_corpkey(dataset(corp2_services.layout_corpkey) in_corpkeys,
		                  string in_ssn_mask_type = '',
		                  BOOLEAN return_multiple_pages = FALSE,
											BOOLEAN is_batch_service = FALSE) := function
		  return corp2_services.get_corp_corpkeys.report(in_corpkeys, in_ssn_mask_type, return_multiple_pages, is_batch_service);
		end;
		
		
		export by_bdid(dataset(doxie_cbrs.layout_references) in_bdids,
		unsigned in_limit = 0,
		string in_ssn_mask_type = '') := function
		  return by_corpkey(get_corpkeys_from_bdids(in_bdids,in_limit),in_ssn_mask_type);
		end;
		
	end;
	
	export search_view := module
	
		export by_corpkey(dataset(corp2_services.layout_corpkey) in_corpkeys,
		                  string in_ssn_mask_type = '',
		                  BOOLEAN isCorpSearchService = FALSE) := function
			return corp2_services.get_corp_corpkeys.search(in_corpkeys, isCorpSearchService);
		end;
		
	end;
	
	export source_view := module
	
		export by_corpkey(dataset(corp2_services.layout_corpkey) in_corpkeys,
		string in_ssn_mask_type = ''):= function
		  return corp2_services.get_corp_corpkeys.report(in_corpkeys,in_ssn_mask_type);
		end;
		
		
		export by_bdid(dataset(doxie_cbrs.layout_references) in_bdids,
		unsigned in_limit = 0,
		string in_ssn_mask_type = '') := function
		  return by_corpkey(get_corpkeys_from_bdids(in_bdids,in_limit),in_ssn_mask_type);
		end;
		
	end;

	
	EXPORT batch_view := MODULE
	
	   format_cont_desc(Corp2_services.layout_titles t) := FUNCTION
		    RETURN TRIM(t.cont_type_desc)+if(TRIM(t.cont_type_desc)<>'' and TRIM(t.cont_title_desc)<>'','-','')+TRIM(t.cont_title_desc);
		 END;

		 format_cont_name(Corp2_services.layout_names n) := FUNCTION
				RETURN TRIM(TRIM(n.cont_fname)+' '+TRIM(n.cont_mname)+' '+TRIM(n.cont_lname));
		 END;

		 format_cont_addr(Corp2_services.layout_addresses a) := FUNCTION
				street_addr := TRIM(a.cont_prim_range)<>'' OR TRIM(a.cont_predir)<>''
											OR TRIM(a.cont_prim_name)<>'' OR TRIM(a.cont_addr_suffix)<>''
											OR TRIM(a.cont_postdir)<>'' ;
				ste_num := TRIM(a.cont_unit_desig)<>''
											OR TRIM(a.cont_sec_range)<>'';
				city_st := TRIM(a.cont_p_city_name)<>'' OR TRIM(a.cont_state)<>'';										
				
				RETURN TRIM(a.cont_prim_range)
							 +IF(TRIM(a.cont_predir)<>'',' ','')+TRIM(a.cont_predir)
							 +IF(TRIM(a.cont_prim_name)<>'',' ','')+TRIM(a.cont_prim_name)
							 +IF(TRIM(a.cont_addr_suffix)<>'',' ','')+TRIM(a.cont_addr_suffix)
							 +IF(TRIM(a.cont_postdir)<>'',' ','')+TRIM(a.cont_postdir)
							 +IF(street_addr and ste_num,', ','')+TRIM(a.cont_unit_desig)
							 +IF(TRIM(a.cont_sec_range)<>'',' ','')+TRIM(a.cont_sec_range)
							 +IF((street_addr OR ste_num)  and TRIM(a.cont_p_city_name)<>'',', ','')+TRIM(a.cont_p_city_name)
							 +IF(TRIM(a.cont_p_city_name)<>'' and TRIM(a.cont_state)<>'',', ','')+TRIM(a.cont_state)
							 +IF((street_addr OR Ste_num OR city_st)AND (TRIM(a.cont_zip5)<>'' OR TRIM(a.cont_zip4)<>''),', ','')+TRIM(a.cont_zip5)
							 +IF(TRIM(a.cont_zip5)<>'' and TRIM(a.cont_zip4)<>'','-','')+TRIM(a.cont_zip4);
   	 END;
		 
		 format_cont_phone_fax(Corp2_services.layout_addresses pf) := FUNCTION
				RETURN TRIM(pf.cont_phone_number_type_desc)
				       +IF(TRIM(pf.cont_phone_number_type_desc)<>'',' ','')
				       +IF(TRIM(pf.cont_phone10)<>'','PHONE-','')
				       +TRIM(pf.cont_phone10)
							 +IF(TRIM(pf.cont_fax_nbr)<>'',' FAX-','')+TRIM(pf.cont_fax_nbr);
		 END;
		 
		 format_cont_addl(Corp2_services.layout_addresses ew) := FUNCTION
				RETURN IF(TRIM(ew.cont_email_address)<>'','EMAIL-','')+TRIM(ew.cont_email_address)+IF(TRIM(ew.cont_web_address)<>'',' WEB-','')+TRIM(ew.cont_web_address);
		 END;
		 
		 format_event_corp_nbr(corp2_services.layout_events_out evt) := FUNCTION
				RETURN TRIM(evt.event_corp_nbr)
				       +IF(TRIM(evt.event_corp_nbr_desc)<>'','-','')+TRIM(evt.event_corp_nbr_desc);
		 END;
		 
		 format_shares_dt1(corp2_services.layout_stocks_out st):=FUNCTION
			  RETURN  IF(TRIM(st.stock_exchange)<>'','EXC:'+TRIM(st.stock_exchange)+' ','')+
								IF(TRIM(st.stock_ticker_symbol)<>'','SYM:'+TRIM(st.stock_ticker_symbol)+' ','')+
								IF(TRIM(st.stock_class)<>'','Class:'+TRIM(st.stock_class)+' ','')+
								IF(TRIM(st.stock_type)<>'','Type:'+TRIM(st.stock_type)+' ','')+
								IF(TRIM(st.stock_shares_issued)<>'','Shares:'+TRIM(st.stock_shares_issued)+' ','')+ 
								IF(TRIM(st.stock_shares_issued)<>'','MKT Cap:'+TRIM(st.stock_total_capital),'');
		 END;
		 
		 format_ar_type(corp2_services.layout_ar_out ar) := FUNCTION
				RETURN IF(TRIM((string)ar.ar_year)<>'','Year:'+ TRIM((string)ar.ar_year),'')
				          +
									IF(TRIM(ar.ar_type)<>'' OR TRIM((string)ar.ar_year)<>'',' ','')
									+
									IF(TRIM(ar.ar_type)<>'','Type:'+  TRIM(ar.ar_type),'');
		 END;
		 
		 format_ar_cap_tax(corp2_services.layout_ar_out ar) := FUNCTION
				RETURN IF(TRIM(ar.ar_annual_report_cap )<>'','Cap:'+TRIM(ar.ar_annual_report_cap ),'')
				          +
									IF(TRIM(ar.ar_annual_report_cap )<>'' OR TRIM(ar.ar_tax_amount_paid)<>'',' ','')
									+
									IF(TRIM(ar.ar_tax_amount_paid)<>'','Tax:'+TRIM(ar.ar_tax_amount_paid),'');

		 END;
		 
		 format_CorpHist_addr1(corp2_services.layout_corps_out ch) := FUNCTION
				ste_num:=	TRIM(ch.corp_addr1_unit_desig)<>''
									OR TRIM(ch.corp_addr1_sec_range)<>'';
				street_addr := TRIM(ch.corp_addr1_prim_range)<>'' OR TRIM(ch.corp_addr1_predir)<>''
									OR TRIM(ch.corp_addr1_prim_name)<>'' OR TRIM(ch.corp_addr1_addr_suffix)<>''
									OR TRIM(ch.corp_addr1_postdir)<>'';

				city_st := TRIM(ch.corp_addr1_p_city_name)<>'' OR TRIM(ch.corp_addr1_state)<>'';	

				RETURN TRIM(ch.corp_addr1_prim_range)
						 +IF(TRIM(ch.corp_addr1_predir)<>'',' ','')+TRIM(ch.corp_addr1_predir)
						 +IF(TRIM(ch.corp_addr1_prim_name)<>'',' ','')+TRIM(ch.corp_addr1_prim_name)
						 +IF(TRIM(ch.corp_addr1_addr_suffix)<>'',' ','')+TRIM(ch.corp_addr1_addr_suffix)
						 +IF(TRIM(ch.corp_addr1_postdir)<>'',' ','')+TRIM(ch.corp_addr1_postdir)
						 +IF(street_addr and ste_num,', ','')+TRIM(ch.corp_addr1_unit_desig)
						 +IF(TRIM(ch.corp_addr1_sec_range)<>'',' ','')+TRIM(ch.corp_addr1_sec_range)
						 +IF((street_addr OR ste_num)  and TRIM(ch.corp_addr1_p_city_name)<>'',', ','')+TRIM(ch.corp_addr1_p_city_name)
						 +IF(TRIM(ch.corp_addr1_p_city_name)<>'' and TRIM(ch.corp_addr1_state)<>'',', ','')+TRIM(ch.corp_addr1_state)
						 +IF(TRIM(ch.corp_addr1_zip5)<>'' OR TRIM(ch.corp_addr1_zip4)<>'',', ','')+TRIM(ch.corp_addr1_zip5)
						 +IF(TRIM(ch.corp_addr1_zip5)<>'' and TRIM(ch.corp_addr1_zip4)<>'','-','')+TRIM(ch.corp_addr1_zip4);
   	 END;
		 
		 format_CorpHist_addr2(corp2_services.layout_corps_out ch) := FUNCTION
				ste_num:=	TRIM(ch.corp_addr2_unit_desig)<>''
							OR TRIM(ch.corp_addr2_sec_range)<>'';
				street_addr := TRIM(ch.corp_addr2_prim_range)<>'' OR TRIM(ch.corp_addr2_predir)<>''
									OR TRIM(ch.corp_addr2_prim_name)<>'' OR TRIM(ch.corp_addr2_addr_suffix)<>''
									OR TRIM(ch.corp_addr2_postdir)<>'' ;
				city_st := TRIM(ch.corp_addr2_p_city_name)<>'' OR TRIM(ch.corp_addr2_state)<>'';	
				
				RETURN TRIM(ch.corp_addr2_prim_range)
						 +IF(TRIM(ch.corp_addr2_predir)<>'',' ','')+TRIM(ch.corp_addr2_predir)
						 +IF(TRIM(ch.corp_addr2_prim_name)<>'',' ','')+TRIM(ch.corp_addr2_prim_name)
						 +IF(TRIM(ch.corp_addr2_addr_suffix)<>'',' ','')+TRIM(ch.corp_addr2_addr_suffix)
						 +IF(TRIM(ch.corp_addr2_postdir)<>'',' ','')+TRIM(ch.corp_addr2_postdir)
						 +IF(street_addr and ste_num,', ','')+TRIM(ch.corp_addr2_unit_desig)
						 +IF(TRIM(ch.corp_addr2_sec_range)<>'',' ','')+TRIM(ch.corp_addr2_sec_range)
						 +IF((street_addr OR ste_num)  and TRIM(ch.corp_addr2_p_city_name)<>'',', ','')+TRIM(ch.corp_addr2_p_city_name)
						 +IF(TRIM(ch.corp_addr2_p_city_name)<>'' and TRIM(ch.corp_addr2_state)<>'',', ','')+TRIM(ch.corp_addr2_state)
						 +IF(TRIM(ch.corp_addr2_zip5)<>'' OR TRIM(ch.corp_addr2_zip4)<>'',', ','')+TRIM(ch.corp_addr2_zip5)
						 +IF(TRIM(ch.corp_addr2_zip5)<>'' and TRIM(ch.corp_addr2_zip4)<>'','-','')+TRIM(ch.corp_addr2_zip4);
   	 END;
		 
		 format_ch_phFax_details(corp2_services.layout_corps_out ch) := FUNCTION
				RETURN  TRIM(ch.corp_phone_number_type_desc)
					      +IF(TRIM(ch.corp_phone10)<>'','- PH:'+TRIM(ch.corp_phone10)+' ',' ')
								+IF(TRIM(ch.corp_fax_nbr)<>'','Fax:'+TRIM(ch.corp_fax_nbr),'');
		 END;
		 
		 format_ch_addInfo(corp2_services.layout_corps_out ch) := FUNCTION
				RETURN IF(TRIM(ch.corp_email_address)<>'','Email:'+ TRIM(ch.corp_email_address)+' ','')
						 +IF(TRIM(ch.corp_web_address)<>'','Fax:'+ TRIM(ch.corp_web_address),'');
		 END;
		 
		 format_corp_ra_name(corp2_services.layout_corps_out ch) := FUNCTION
				RETURN 	IF( TRIM(ch.corp_ra_name)<>'',TRIM(ch.corp_ra_name)
				            ,IF(ch.corp_ra_lname1<>'',TRIM(ch.corp_ra_fname1)
										                          +IF(TRIM(ch.corp_ra_mname1)<>'',' '+TRIM(ch.corp_ra_mname1),'')
										                          +IF(TRIM(ch.corp_ra_lname1)<>'',' '+TRIM(ch.corp_ra_lname1),'')
																							+IF(TRIM(ch.corp_ra_title_desc)<>'',' DESC:'+TRIM(ch.corp_ra_title_desc),'')
																							,''));
																							
		 END;
		 
		 format_ra_ssn(corp2_services.layout_corps_out ch) := FUNCTION
				RETURN IF(TRIM(ch.corp_ra_fein)<>'','FEIN:'+TRIM(ch.corp_ra_fein),'')
							+IF(TRIM(ch.corp_ra_ssn)<>'',' SSN:'+TRIM(ch.corp_ra_ssn),'');
		 END;
		 
		 format_RA_addr(corp2_services.layout_corps_out ch) := FUNCTION
				RETURN TRIM(ch.corp_ra_prim_range)
				       +IF(TRIM(ch.corp_ra_predir)<>'',' ','')+TRIM(ch.corp_ra_predir)
							 +IF(TRIM(ch.corp_ra_prim_name)<>'',' ','')+TRIM(ch.corp_ra_prim_name)
				       +IF(TRIM(ch.corp_ra_addr_suffix)<>'',' ','')+TRIM(ch.corp_ra_addr_suffix)
							 +IF(TRIM(ch.corp_ra_postdir)<>'',' ','')+TRIM(ch.corp_ra_postdir)
							 +IF(TRIM(ch.corp_ra_unit_desig)<>'' OR TRIM(ch.corp_addr2_sec_range)<>'',', ','')+TRIM(ch.corp_ra_unit_desig)
							 +IF(TRIM(ch.corp_ra_sec_range)<>'',' ','')+TRIM(ch.corp_ra_sec_range)
							 +IF(TRIM(ch.corp_ra_p_city_name)<>'',', ','')+TRIM(ch.corp_ra_p_city_name)
							 +IF(TRIM(ch.corp_ra_state)<>'',', ','')+TRIM(ch.corp_ra_state)
							 +IF(TRIM(ch.corp_ra_zip5)<>'' OR TRIM(ch.corp_ra_zip4)<>'',', ','')+TRIM(ch.corp_ra_zip5)
							 +IF(TRIM(ch.corp_ra_zip4)<>'','-','')+TRIM(ch.corp_ra_zip4);
   	 END;
		 
		 format_ra_PhFax(corp2_services.layout_corps_out ch) := FUNCTION
		    RETURN 	TRIM(ch.corp_ra_phone_number_type_desc)
					      +IF(TRIM(ch.corp_ra_phone10)<>'','- PH:'+TRIM(ch.corp_ra_phone10)+' ',' ')
								+IF(TRIM(ch.corp_ra_fax_nbr)<>'','Fax:'+TRIM(ch.corp_ra_fax_nbr),'');
   	 END;
		 
		 format_ra_addInfo(corp2_services.layout_corps_out ch) := FUNCTION
				 RETURN IF(TRIM(ch.corp_ra_email_address)<>'','Email:'+ TRIM(ch.corp_ra_email_address)+' ','')
							 +IF(TRIM(ch.corp_ra_web_address)<>'','Fax:'+ TRIM(ch.corp_ra_web_address),'');
		 END;
		 
		 format_tn(corp2_services.layout_trades_out tn) := FUNCTION
		     RETURN TRIM(tn.corp_legal_name)
					      +IF(TRIM(tn.corp_term_exist_exp)<>'',' Exp:'+TRIM(tn.corp_term_exist_exp),'')
					      +IF(TRIM(tn.corp_orig_bus_type_desc)<>'',' Desc:'+TRIM(tn.corp_orig_bus_type_desc),'');
																 
		 END;
		 
		 EXPORT get_batch_out(DATASET(Corp2_services.layout_corp2_rollup) D_LCR) := FUNCTION
				Corp2_services.assorted_layouts.corp2_batch_layout xfm_batch_out(Corp2_services.layout_corp2_rollup LCR) := TRANSFORM
				   //Contacts
					 LCR_c := LCR.contacts(record_type='C');
					 SELF.corp_key   := LCR.corp_key   ;
					 SELF.corp_orig_sos_charter_nbr   := LCR.corp_orig_sos_charter_nbr   ;
					 SELF.corp_sos_charter_nbr   := LCR.corp_sos_charter_nbr   ; 
					 SELF.corp_state_origin   := LCR.corp_state_origin   ;
					 SELF.corp_state_origin_decoded   := LCR.corp_state_origin_decoded   ;
      		 SELF.cont_1_corp_legal_name     := LCR_c[1].corp_legal_name   ;
					 SELF.cont_1_desc     :=  format_cont_desc(LCR_c.title_descriptions[1]);
					 SELF.cont_1_cname     := TRIM(LCR_c.names[1].cont_cname)   ;
					 SELF.cont_1_name      := format_cont_name(LCR_c.names[1]);
					 SELF.cont_1_address_type_desc     := LCR_c.addresses[1].cont_address_type_desc   ;
					 SELF.cont_1_address1     := format_cont_addr(LCR_c.addresses[1])   ;
					 SELF.cont_1_phone_fax     := format_cont_phone_fax(LCR_c.addresses[1])   ;
					 SELF.cont_1_addl_details     := format_cont_addl(LCR_c.addresses[1])   ;
           SELF.cont_2_corp_legal_name     := LCR_c[2].corp_legal_name   ;
					 SELF.cont_2_desc     :=  format_cont_desc(LCR_c.title_descriptions[2]);
					 SELF.cont_2_cname     := TRIM(LCR_c.names[2].cont_cname)   ;
					 SELF.cont_2_name     := format_cont_name(LCR_c.names[2]);
					 SELF.cont_2_address_type_desc     := LCR_c.addresses[2].cont_address_type_desc   ;
					 SELF.cont_2_address1     := format_cont_addr(LCR_c.addresses[2])   ;
					 SELF.cont_2_phone_fax     := format_cont_phone_fax(LCR_c.addresses[2])   ;
					 SELF.cont_2_addl_details     := format_cont_addl(LCR_c.addresses[2])   ;		
      		 SELF.cont_3_corp_legal_name     := LCR_c[3].corp_legal_name   ;
					 SELF.cont_3_desc     :=  format_cont_desc(LCR_c.title_descriptions[3]);
					 SELF.cont_3_cname     := TRIM(LCR_c.names[3].cont_cname)   ;
					 SELF.cont_3_name     := format_cont_name(LCR_c.names[3]);
					 SELF.cont_3_address_type_desc     := LCR_c.addresses[3].cont_address_type_desc   ;
					 SELF.cont_3_address1     := format_cont_addr(LCR_c.addresses[3])   ;
					 SELF.cont_3_phone_fax     := format_cont_phone_fax(LCR_c.addresses[3])   ;
					 SELF.cont_3_addl_details     := format_cont_addl(LCR_c.addresses[3])   ;	
      		 SELF.cont_4_corp_legal_name     := LCR_c[4].corp_legal_name   ;
					 SELF.cont_4_desc     :=  format_cont_desc(LCR_c.title_descriptions[4]);
					 SELF.cont_4_cname     := TRIM(LCR_c.names[4].cont_cname)   ;
					 SELF.cont_4_name     := format_cont_name(LCR_c.names[4]);
					 SELF.cont_4_address_type_desc     := LCR_c.addresses[4].cont_address_type_desc   ;
					 SELF.cont_4_address1     := format_cont_addr(LCR_c.addresses[4])   ;
					 SELF.cont_4_phone_fax     := format_cont_phone_fax(LCR_c.addresses[4])   ;
					 SELF.cont_4_addl_details     := format_cont_addl(LCR_c.addresses[4])   ;		
      		 SELF.cont_5_corp_legal_name     := LCR_c[5].corp_legal_name   ;
					 SELF.cont_5_desc     :=  format_cont_desc(LCR_c.title_descriptions[5]);
					 SELF.cont_5_cname     := TRIM(LCR_c.names[5].cont_cname)   ;
					 SELF.cont_5_name     := format_cont_name(LCR_c.names[5]);
					 SELF.cont_5_address_type_desc     := LCR_c.addresses[5].cont_address_type_desc   ;
					 SELF.cont_5_address1     := format_cont_addr(LCR_c.addresses[5])   ;
					 SELF.cont_5_phone_fax     := format_cont_phone_fax(LCR_c.addresses[5])   ;
					 SELF.cont_5_addl_details     := format_cont_addl(LCR_c.addresses[5])   ;					 
					 
					 //EVENTS
					 LCR_e := LCR.events;
					 SELF.event_1_filing_reference_nbr   := LCR_e[1].event_filing_reference_nbr  ;
					 SELF.event_1_amendment_nbr   := LCR_e[1].event_amendment_nbr;
					 SELF.event_1_filing_date   := LCR_e[1].event_filing_date  ;
					 SELF.event_1_filing_desc   := LCR_e[1].event_filing_desc  ;
					 SELF.event_1_corp_nbr_withdesc   := format_event_corp_nbr(LCR_e[1])  ;
					 SELF.event_1_microfilm_nbr   := LCR_e[1].event_microfilm_nbr  ;
					 SELF.event_1_desc   := LCR_e[1].event_desc  ;
					 SELF.event_2_filing_reference_nbr   := LCR_e[2].event_filing_reference_nbr  ;
					 SELF.event_2_amendment_nbr   := LCR_e[2].event_amendment_nbr;
					 SELF.event_2_filing_date   := LCR_e[2].event_filing_date  ;
					 SELF.event_2_filing_desc   := LCR_e[2].event_filing_desc  ;
					 SELF.event_2_corp_nbr_withdesc   := format_event_corp_nbr(LCR_e[2])  ;
					 SELF.event_2_microfilm_nbr   := LCR_e[2].event_microfilm_nbr  ;
					 SELF.event_2_desc   := LCR_e[2].event_desc  ;
					 SELF.event_3_filing_reference_nbr   := LCR_e[3].event_filing_reference_nbr  ;
					 SELF.event_3_amendment_nbr   := LCR_e[3].event_amendment_nbr;
					 SELF.event_3_filing_date   := LCR_e[3].event_filing_date  ;
					 SELF.event_3_filing_desc   := LCR_e[3].event_filing_desc  ;
					 SELF.event_3_corp_nbr_withdesc   := format_event_corp_nbr(LCR_e[3])  ;
					 SELF.event_3_microfilm_nbr   := LCR_e[3].event_microfilm_nbr  ;
					 SELF.event_3_desc   := LCR_e[3].event_desc  ;
					 SELF.event_4_filing_reference_nbr   := LCR_e[4].event_filing_reference_nbr  ;
					 SELF.event_4_amendment_nbr   := LCR_e[4].event_amendment_nbr;
					 SELF.event_4_filing_date   := LCR_e[4].event_filing_date  ;
					 SELF.event_4_filing_desc   := LCR_e[4].event_filing_desc  ;
					 SELF.event_4_corp_nbr_withdesc   := format_event_corp_nbr(LCR_e[4])  ;
					 SELF.event_4_microfilm_nbr   := LCR_e[4].event_microfilm_nbr  ;
					 SELF.event_4_desc   := LCR_e[4].event_desc  ;
					 SELF.event_5_filing_reference_nbr   := LCR_e[5].event_filing_reference_nbr  ;
					 SELF.event_5_amendment_nbr   := LCR_e[5].event_amendment_nbr;
					 SELF.event_5_filing_date   := LCR_e[5].event_filing_date  ;
					 SELF.event_5_filing_desc   := LCR_e[5].event_filing_desc  ;
					 SELF.event_5_corp_nbr_withdesc   := format_event_corp_nbr(LCR_e[5])  ;
					 SELF.event_5_microfilm_nbr   := LCR_e[5].event_microfilm_nbr  ;
					 SELF.event_5_desc   := LCR_e[5].event_desc  ;
					 
					 //STOCKS
					 LCR_s := LCR.stocks;
					 SELF.stock_1_details1  := format_shares_dt1(LCR_s[1]) ;
		       SELF.stock_1_addl_info := LCR_s[1].stock_addl_info ;
					 SELF.stock_2_details1  := format_shares_dt1(LCR_s[2]) ;
		       SELF.stock_2_addl_info := LCR_s[2].stock_addl_info ;
					 SELF.stock_3_details1  := format_shares_dt1(LCR_s[3]) ;
		       SELF.stock_3_addl_info := LCR_s[3].stock_addl_info ;
					 SELF.stock_4_details1  := format_shares_dt1(LCR_s[4]) ;
		       SELF.stock_4_addl_info := LCR_s[4].stock_addl_info ;					 
					 SELF.stock_5_details1  := format_shares_dt1(LCR_s[5]) ;
		       SELF.stock_5_addl_info := LCR_s[5].stock_addl_info ;
					 
					 //ANNUAL REPORTS
					 LCR_ar := LCR.annual_reports;
					 SELF.ar_1_year_type := format_ar_type(LCR_ar[1]);
		       SELF.ar_1_cap_tax := format_ar_cap_tax(LCR_ar[1]);
		       SELF.ar_1_microfilm_nbr := LCR_ar[1].ar_microfilm_nbr;
		       SELF.ar_1_comment := LCR_ar[1].ar_comment;
					 SELF.ar_2_year_type := format_ar_type(LCR_ar[2]);
		       SELF.ar_2_cap_tax := format_ar_cap_tax(LCR_ar[2]);
		       SELF.ar_2_microfilm_nbr := LCR_ar[2].ar_microfilm_nbr;
		       SELF.ar_2_comment := LCR_ar[2].ar_comment;
					 SELF.ar_3_year_type := format_ar_type(LCR_ar[3]);
		       SELF.ar_3_cap_tax := format_ar_cap_tax(LCR_ar[3]);
		       SELF.ar_3_microfilm_nbr := LCR_ar[3].ar_microfilm_nbr;
		       SELF.ar_3_comment := LCR_ar[3].ar_comment;
					 SELF.ar_4_year_type := format_ar_type(LCR_ar[4]);
		       SELF.ar_4_cap_tax := format_ar_cap_tax(LCR_ar[4]);
		       SELF.ar_4_microfilm_nbr := LCR_ar[4].ar_microfilm_nbr;
		       SELF.ar_4_comment := LCR_ar[4].ar_comment;
					 SELF.ar_5_year_type := format_ar_type(LCR_ar[5]);
		       SELF.ar_5_cap_tax := format_ar_cap_tax(LCR_ar[5]);
		       SELF.ar_5_microfilm_nbr := LCR_ar[5].ar_microfilm_nbr;
		       SELF.ar_5_comment := LCR_ar[5].ar_comment;		
					 
					 //CORP HISTORY
					 LCR_ch := LCR.corp_hist;
					 SELF.corphist_1_legal_name    := LCR_ch[1].corp_legal_name;
					 SELF.corphist_1_ln_name_type_desc    := LCR_ch[1].corp_ln_name_type_desc;
					 SELF.corphist_1_DotID			:= LCR_ch[1].DotID;	
				 	 SELF.corphist_1_EmpID			:= LCR_ch[1].EmpID;
					 SELF.corphist_1_PowID			:= LCR_ch[1].PowID;
					 SELF.corphist_1_ProxID			:= LCR_ch[1].ProxID;
					 SELF.corphist_1_SeleID			:= LCR_ch[1].SeleID; 
					 SELF.corphist_1_OrgID			:= LCR_ch[1].OrgID;
					 SELF.corphist_1_UltID			:= LCR_ch[1].UltID;
		       SELF.corphist_1_address1_type_desc    := LCR_ch[1].corp_address1_type_desc;
		       SELF.corphist_1_address1    := format_CorpHist_addr1(LCR_ch[1]);
		       SELF.corphist_1_address2_type_desc    := LCR_ch[1].corp_address2_type_desc;
		       SELF.corphist_1_address2    := format_CorpHist_addr2(LCR_ch[1]);
           SELF.corphist_1_filing_date := LCR_ch[1].corp_filing_date;		
		       SELf.corphist_1_status_date := LCR_ch[1].corp_status_date;
	         SELF.corphist_1_standing    := LCR_ch[1].corp_standing;
	         SELF.corphist_1_inc_state   := LCR_ch[1].corp_inc_state;
					 SELF.corphist_1_inc_date    := LCR_ch[1].corp_inc_date;			
					 SELF.corphist_1_forgn_state_desc    := LCR_ch[1].corp_forgn_state_desc;
					 SELF.corphist_1_fed_tax_id          := LCR_ch[1].corp_fed_tax_id;
					 SELF.corphist_1_state_tax_id        := LCR_ch[1].corp_state_tax_id;
		       SELF.corphist_1_phonefax_details  := format_ch_phFax_details(LCR_ch[1]);
		       SELF.corphist_1_webemail_info    := format_ch_addinfo(LCR_ch[1]);
		       SELF.corphist_1_filing_reference_nbr    := LCR_ch[1].corp_filing_reference_nbr;
		       SELF.corphist_1_forgn_sos_charter_nbr    := LCR_ch[1].corp_forgn_sos_charter_nbr;
		       SELF.corphist_1_status_desc    := LCR_ch[1].corp_status_desc;
		       SELF.corphist_1_orig_org_structure_desc    := LCR_ch[1].corp_orig_org_structure_desc;
		       // SELF.corphist_orig_bus_type_desc    := 
					 SELF.corphist_1_for_profit_ind := LCR_ch[1].corp_for_profit_ind;
		       SELF.corphist_1_addl_info    := LCR_ch[1].corp_addl_info;
		       SELF.corphist_1_ra_name    := format_corp_ra_name(LCR_ch[1]);
		       SELF.corphist_1_ra_fein_ssn    := format_ra_ssn(LCR_ch[1]);
		       SELF.corphist_1_ra_addl_info    := LCR_ch[1].corp_ra_addl_info;
		       SELF.corphist_1_ra_address_type_desc    := LCR_ch[1].corp_ra_address_type_desc;
		       SELF.corphist_1_ra_addr1  := format_ra_addr(LCR_ch[1]); 
		       SELF.corphist_1_ra_phoneFax    := format_ra_PhFax(LCR_ch[1]); 
		       SELF.corphist_1_ra_webemail_info    := format_ra_addInfo(LCR_ch[1]); 
					
					SELF.corphist_2_legal_name     := LCR_ch[2].corp_legal_name;
					 SELF.corphist_2_ln_name_type_desc     := LCR_ch[2].corp_ln_name_type_desc;
					 SELF.corphist_2_DotID			:= LCR_ch[2].DotID;	
				 	 SELF.corphist_2_EmpID			:= LCR_ch[2].EmpID;
					 SELF.corphist_2_PowID			:= LCR_ch[2].PowID;
					 SELF.corphist_2_ProxID			:= LCR_ch[2].ProxID;
					 SELF.corphist_2_SeleID			:= LCR_ch[2].SeleID; 
					 SELF.corphist_2_OrgID			:= LCR_ch[2].OrgID;
					 SELF.corphist_2_UltID			:= LCR_ch[2].UltID;
		       SELF.corphist_2_address1_type_desc     := LCR_ch[2].corp_address1_type_desc;
		       SELF.corphist_2_address1     := format_CorpHist_addr1(LCR_ch[2]);
		       SELF.corphist_2_address2_type_desc     := LCR_ch[2].corp_address2_type_desc;
		       SELF.corphist_2_address2     := format_CorpHist_addr2(LCR_ch[2]);
           SELF.corphist_2_filing_date := LCR_ch[2].corp_filing_date;		
		       SELf.corphist_2_status_date := LCR_ch[2].corp_status_date;
	         SELF.corphist_2_standing    := LCR_ch[2].corp_standing;
	         SELF.corphist_2_inc_state   := LCR_ch[2].corp_inc_state;
					 SELF.corphist_2_inc_date    := LCR_ch[2].corp_inc_date;					 
					 SELF.corphist_2_forgn_state_desc    := LCR_ch[2].corp_forgn_state_desc;
					 SELF.corphist_2_fed_tax_id          := LCR_ch[2].corp_fed_tax_id;
					 SELF.corphist_2_state_tax_id        := LCR_ch[2].corp_state_tax_id;					 
		       SELF.corphist_2_phonefax_details  := format_ch_phFax_details(LCR_ch[2]);
		       SELF.corphist_2_webemail_info     := format_ch_addinfo(LCR_ch[2]);
		       SELF.corphist_2_filing_reference_nbr     := LCR_ch[2].corp_filing_reference_nbr;
		       SELF.corphist_2_forgn_sos_charter_nbr     := LCR_ch[2].corp_forgn_sos_charter_nbr;
		       SELF.corphist_2_status_desc     := LCR_ch[2].corp_status_desc;
		       SELF.corphist_2_orig_org_structure_desc     := LCR_ch[2].corp_orig_org_structure_desc;
		       // SELF.corphist_2_orig_bus_type_desc     := 
					 SELF.corphist_2_for_profit_ind := LCR_ch[2].corp_for_profit_ind;
		       SELF.corphist_2_addl_info     := LCR_ch[2].corp_addl_info;
		       SELF.corphist_2_ra_name     := format_corp_ra_name(LCR_ch[2]);
		       SELF.corphist_2_ra_fein_ssn     := format_ra_ssn(LCR_ch[2]);
		       SELF.corphist_2_ra_addl_info     := LCR_ch[2].corp_ra_addl_info;
		       SELF.corphist_2_ra_address_type_desc     := LCR_ch[2].corp_ra_address_type_desc;
		       SELF.corphist_2_ra_addr1  := format_ra_addr(LCR_ch[2]); 
		       SELF.corphist_2_ra_phoneFax     := format_ra_PhFax(LCR_ch[2]); 
		       SELF.corphist_2_ra_webemail_info     := format_ra_addInfo(LCR_ch[2]); 
           
					 SELF.corphist_3_legal_name     := LCR_ch[3].corp_legal_name;
					 SELF.corphist_3_ln_name_type_desc     := LCR_ch[3].corp_ln_name_type_desc;
					 SELF.corphist_3_DotID			:= LCR_ch[3].DotID;	
				 	 SELF.corphist_3_EmpID			:= LCR_ch[3].EmpID;
					 SELF.corphist_3_PowID			:= LCR_ch[3].PowID;
					 SELF.corphist_3_ProxID			:= LCR_ch[3].ProxID;
					 SELF.corphist_3_SeleID			:= LCR_ch[3].SeleID; 
					 SELF.corphist_3_OrgID			:= LCR_ch[3].OrgID;
					 SELF.corphist_3_UltID			:= LCR_ch[3].UltID;
		       SELF.corphist_3_address1_type_desc     := LCR_ch[3].corp_address1_type_desc;
		       SELF.corphist_3_address1     := format_CorpHist_addr1(LCR_ch[3]);
		       SELF.corphist_3_address2_type_desc     := LCR_ch[3].corp_address2_type_desc;
		       SELF.corphist_3_address2     := format_CorpHist_addr2(LCR_ch[3]);
           SELF.corphist_3_filing_date := LCR_ch[3].corp_filing_date;		
		       SELf.corphist_3_status_date := LCR_ch[3].corp_status_date;
	         SELF.corphist_3_standing    := LCR_ch[3].corp_standing;
	         SELF.corphist_3_inc_state   := LCR_ch[3].corp_inc_state;
					 SELF.corphist_3_inc_date    := LCR_ch[3].corp_inc_date;			
					 SELF.corphist_3_forgn_state_desc    := LCR_ch[3].corp_forgn_state_desc;
					 SELF.corphist_3_fed_tax_id          := LCR_ch[3].corp_fed_tax_id;
					 SELF.corphist_3_state_tax_id        := LCR_ch[3].corp_state_tax_id;					 
		       SELF.corphist_3_phonefax_details   := format_ch_phFax_details(LCR_ch[3]);
		       SELF.corphist_3_webemail_info     := format_ch_addinfo(LCR_ch[3]);
		       SELF.corphist_3_filing_reference_nbr     := LCR_ch[3].corp_filing_reference_nbr;
		       SELF.corphist_3_forgn_sos_charter_nbr     := LCR_ch[3].corp_forgn_sos_charter_nbr;
		       SELF.corphist_3_status_desc     := LCR_ch[3].corp_status_desc;
		       SELF.corphist_3_orig_org_structure_desc     := LCR_ch[3].corp_orig_org_structure_desc;
		       // SELF.corphist_3_orig_bus_type_desc     := 
					 SELF.corphist_3_for_profit_ind := LCR_ch[3].corp_for_profit_ind;
		       SELF.corphist_3_addl_info     := LCR_ch[3].corp_addl_info;
		       SELF.corphist_3_ra_name     := format_corp_ra_name(LCR_ch[3]);
		       SELF.corphist_3_ra_fein_ssn     := format_ra_ssn(LCR_ch[3]);
		       SELF.corphist_3_ra_addl_info     := LCR_ch[3].corp_ra_addl_info;
		       SELF.corphist_3_ra_address_type_desc     := LCR_ch[3].corp_ra_address_type_desc;
		       SELF.corphist_3_ra_addr1   := format_ra_addr(LCR_ch[3]); 
		       SELF.corphist_3_ra_phoneFax     := format_ra_PhFax(LCR_ch[3]); 
		       SELF.corphist_3_ra_webemail_info     := format_ra_addInfo(LCR_ch[3]); 
          
				   SELF.corphist_4_legal_name     := LCR_ch[4].corp_legal_name;
					 SELF.corphist_4_ln_name_type_desc     := LCR_ch[4].corp_ln_name_type_desc;
					 SELF.corphist_4_DotID			:= LCR_ch[4].DotID;	
				 	 SELF.corphist_4_EmpID			:= LCR_ch[4].EmpID;
					 SELF.corphist_4_PowID			:= LCR_ch[4].PowID;
					 SELF.corphist_4_ProxID			:= LCR_ch[4].ProxID;
					 SELF.corphist_4_SeleID			:= LCR_ch[4].SeleID; 
					 SELF.corphist_4_OrgID			:= LCR_ch[4].OrgID;
					 SELF.corphist_4_UltID			:= LCR_ch[4].UltID;
		       SELF.corphist_4_address1_type_desc     := LCR_ch[4].corp_address1_type_desc;
		       SELF.corphist_4_address1     := format_CorpHist_addr1(LCR_ch[4]);
		       SELF.corphist_4_address2_type_desc     := LCR_ch[4].corp_address2_type_desc;
		       SELF.corphist_4_address2     := format_CorpHist_addr2(LCR_ch[4]);
           SELF.corphist_4_filing_date := LCR_ch[4].corp_filing_date;		
		       SELf.corphist_4_status_date := LCR_ch[4].corp_status_date;
	         SELF.corphist_4_standing    := LCR_ch[4].corp_standing;
	         SELF.corphist_4_inc_state   := LCR_ch[4].corp_inc_state;
					 SELF.corphist_4_inc_date    := LCR_ch[4].corp_inc_date;	
					 SELF.corphist_4_forgn_state_desc    := LCR_ch[4].corp_forgn_state_desc;
					 SELF.corphist_4_fed_tax_id          := LCR_ch[4].corp_fed_tax_id;
					 SELF.corphist_4_state_tax_id        := LCR_ch[4].corp_state_tax_id;					 
		       SELF.corphist_4_phonefax_details  := format_ch_phFax_details(LCR_ch[4]);
		       SELF.corphist_4_webemail_info     := format_ch_addinfo(LCR_ch[4]);
		       SELF.corphist_4_filing_reference_nbr     := LCR_ch[4].corp_filing_reference_nbr;
		       SELF.corphist_4_forgn_sos_charter_nbr     := LCR_ch[4].corp_forgn_sos_charter_nbr;
		       SELF.corphist_4_status_desc     := LCR_ch[4].corp_status_desc;
		       SELF.corphist_4_orig_org_structure_desc     := LCR_ch[4].corp_orig_org_structure_desc;
		       // SELF.corphist_4_orig_bus_type_desc     := 
					 SELF.corphist_4_for_profit_ind := LCR_ch[4].corp_for_profit_ind;
		       SELF.corphist_4_addl_info     := LCR_ch[4].corp_addl_info;
		       SELF.corphist_4_ra_name     := format_corp_ra_name(LCR_ch[4]);
		       SELF.corphist_4_ra_fein_ssn     := format_ra_ssn(LCR_ch[4]);
		       SELF.corphist_4_ra_addl_info     := LCR_ch[4].corp_ra_addl_info;
		       SELF.corphist_4_ra_address_type_desc     := LCR_ch[4].corp_ra_address_type_desc;
		       SELF.corphist_4_ra_addr1  := format_ra_addr(LCR_ch[4]); 
		       SELF.corphist_4_ra_phoneFax     := format_ra_PhFax(LCR_ch[4]); 
		       SELF.corphist_4_ra_webemail_info     := format_ra_addInfo(LCR_ch[4]); 
					 
					 SELF.corphist_5_legal_name := LCR_ch[5].corp_legal_name;
					 SELF.corphist_5_ln_name_type_desc := LCR_ch[5].corp_ln_name_type_desc;
					 SELF.corphist_5_DotID			:= LCR_ch[5].DotID;	
				 	 SELF.corphist_5_EmpID			:= LCR_ch[5].EmpID;
					 SELF.corphist_5_PowID			:= LCR_ch[5].PowID;
					 SELF.corphist_5_ProxID			:= LCR_ch[5].ProxID;
					 SELF.corphist_5_SeleID			:= LCR_ch[5].SeleID; 
					 SELF.corphist_5_OrgID			:= LCR_ch[5].OrgID;
					 SELF.corphist_5_UltID			:= LCR_ch[5].UltID;
		       SELF.corphist_5_address1_type_desc     := LCR_ch[5].corp_address1_type_desc;
		       SELF.corphist_5_address1     := format_CorpHist_addr1(LCR_ch[5]);
		       SELF.corphist_5_address2_type_desc     := LCR_ch[5].corp_address2_type_desc;
		       SELF.corphist_5_address2     := format_CorpHist_addr2(LCR_ch[5]);
           SELF.corphist_5_filing_date := LCR_ch[5].corp_filing_date;		
		       SELf.corphist_5_status_date := LCR_ch[5].corp_status_date;
	         SELF.corphist_5_standing    := LCR_ch[5].corp_standing;
	         SELF.corphist_5_inc_state   := LCR_ch[5].corp_inc_state;
					 SELF.corphist_5_inc_date    := LCR_ch[5].corp_inc_date;	
					 SELF.corphist_5_forgn_state_desc    := LCR_ch[5].corp_forgn_state_desc;
					 SELF.corphist_5_fed_tax_id          := LCR_ch[5].corp_fed_tax_id;
					 SELF.corphist_5_state_tax_id        := LCR_ch[5].corp_state_tax_id;					 
		       SELF.corphist_5_phonefax_details  := format_ch_phFax_details(LCR_ch[5]);
		       SELF.corphist_5_webemail_info     := format_ch_addinfo(LCR_ch[5]);
		       SELF.corphist_5_filing_reference_nbr     := LCR_ch[5].corp_filing_reference_nbr;
		       SELF.corphist_5_forgn_sos_charter_nbr     := LCR_ch[5].corp_forgn_sos_charter_nbr;
		       SELF.corphist_5_status_desc     := LCR_ch[5].corp_status_desc;
		       SELF.corphist_5_orig_org_structure_desc     := LCR_ch[5].corp_orig_org_structure_desc;
		       // SELF.corphist_5_orig_bus_type_desc     := 
					 SELF.corphist_5_for_profit_ind := LCR_ch[5].corp_for_profit_ind;
		       SELF.corphist_5_addl_info     := LCR_ch[5].corp_addl_info;
		       SELF.corphist_5_ra_name     := format_corp_ra_name(LCR_ch[5]);
		       SELF.corphist_5_ra_fein_ssn     := format_ra_ssn(LCR_ch[5]);
		       SELF.corphist_5_ra_addl_info     := LCR_ch[5].corp_ra_addl_info;
		       SELF.corphist_5_ra_address_type_desc     := LCR_ch[5].corp_ra_address_type_desc;
		       SELF.corphist_5_ra_addr1  := format_ra_addr(LCR_ch[5]); 
		       SELF.corphist_5_ra_phoneFax     := format_ra_PhFax(LCR_ch[5]); 
		       SELF.corphist_5_ra_webemail_info     := format_ra_addInfo(LCR_ch[5]); 		
					 
					 LCR_tn := LCR.tradenames;
					 LCR_tm := LCR.trademarks;
					 SELF.tn_1_details  := format_tn(LCR_tn[1]);
					 SELF.tn_2_details  := format_tn(LCR_tn[2]);
					 SELF.tn_3_details  := format_tn(LCR_tn[3]);
					 SELF.tn_4_details  := format_tn(LCR_tn[4]);
					 SELF.tn_5_details  := format_tn(LCR_tn[5]);
					 SELF.tm_1_details  := format_tn(LCR_tm[1]);
					 SELF.tm_2_details  := format_tn(LCR_tm[2]);
					 SELF.tm_3_details  := format_tn(LCR_tm[3]);
					 SELF.tm_4_details  := format_tn(LCR_tm[4]);
					 SELF.tm_5_details  := format_tn(LCR_tm[5]);
				 
					 SELF := LCR;
					 SELF := [];
				END;
				batch_out := PROJECT(D_LCR,xfm_batch_out(LEFT));
				RETURN batch_out;
		 END;
	END;

		
end;
	
