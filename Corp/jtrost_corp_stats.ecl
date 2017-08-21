old_ := dataset('~thor_data400::in::corporate_direct::corp_father',corp.Layout_Corporate_Direct_Corp_in, flat);
new_ := corp.File_Corporate_Direct_Corp_Update;

outrec1 := record
 old_.corp_state_origin;
 old_.corp_vendor;
 count_ := count(group);
 //old_.corp_process_date;
 min_process_date                    := min(group,old_.corp_process_date);
 max_process_date                    := max(group,old_.corp_process_date);
 bad_corp_address1_effective_date_ct := count(group,length(trim(old_.corp_address1_effective_date,left,right))!=length(trim(stringlib.stringfilter(old_.corp_address1_effective_date,'0123456789'),left,right)));
 bad_corp_filing_date_ct             := count(group,length(trim(old_.corp_filing_date,left,right))!=length(trim(stringlib.stringfilter(old_.corp_filing_date,'0123456789'),left,right)));
 bad_corp_status_date_ct             := count(group,length(trim(old_.corp_status_date,left,right))!=length(trim(stringlib.stringfilter(old_.corp_status_date,'0123456789'),left,right)));
 bad_corp_inc_date_ct                := count(group,length(trim(old_.corp_inc_date,left,right))!=length(trim(stringlib.stringfilter(old_.corp_inc_date,'0123456789'),left,right)));
 has_corp_term_exist_cd_other        := ave(group,if(trim(old_.corp_term_exist_cd) not in ['P','N','D',' '],1,0));
 has_corp_foreign_domestic_ind_other := ave(group,if(trim(old_.corp_foreign_domestic_ind) not in ['F','D',' '],1,0));
 bad_corp_forgn_date_ct              := count(group,length(trim(old_.corp_forgn_date,left,right))!=length(trim(stringlib.stringfilter(old_.corp_forgn_date,'0123456789'),left,right)));
 has_corp_forgn_term_exist_cd_other  := ave(group,if(trim(old_.corp_forgn_term_exist_cd) not in ['P','N','D',' '],1,0));
 has_corp_for_profit_ind_other       := ave(group,if(trim(old_.corp_for_profit_ind) not in ['Y','N',' '],1,0));
 bad_corp_ra_effective_date_ct       := count(group,length(trim(old_.corp_ra_effective_date,left,right))!=length(trim(stringlib.stringfilter(old_.corp_ra_effective_date,'0123456789'),left,right)));
 has_corp_key                        := ave(group,if(trim(old_.corp_key)!='',1,0));
 //bad_corp_key_ct                     := count(group,old_.corp_key[1..3]!=old_.corp_vendor+'-');
 has_corp_vendor                     := ave(group,if(trim(old_.corp_vendor)!='',1,0));
 has_corp_orig_sos_charter_nbr       := ave(group,if(trim(old_.corp_orig_sos_charter_nbr)!='',1,0));
 has_corp_legal_name                 := ave(group,if(trim(old_.corp_legal_name)!='',1,0));
 has_corp_address1_type_cd           := ave(group,if(trim(old_.corp_address1_type_cd)!='',1,0));
 has_corp_address1_type_desc         := ave(group,if(trim(old_.corp_address1_type_desc)!='',1,0));
 has_corp_address1_line1             := ave(group,if(trim(old_.corp_address1_line1)!='',1,0));
 has_corp_address1_line2             := ave(group,if(trim(old_.corp_address1_line2)!='',1,0));
 has_corp_address1_line3             := ave(group,if(trim(old_.corp_address1_line3)!='',1,0));
 has_corp_address1_effective_date    := ave(group,if(trim(old_.corp_address1_effective_date)!='',1,0));
 //has_corp_address2_type_cd           := ave(group,if(trim(old_.corp_address2_type_cd)!='',1,0));
 //has_corp_address2_type_desc         := ave(group,if(trim(old_.corp_address2_type_desc)!='',1,0));
 //has_corp_address2_line1             := ave(group,if(trim(old_.corp_address2_line1)!='',1,0));
 //has_corp_address2_line2             := ave(group,if(trim(old_.corp_address2_line2)!='',1,0));
 //has_corp_address2_line3             := ave(group,if(trim(old_.corp_address2_line3)!='',1,0));
 //has_corp_address2_effective_date    := ave(group,if(trim(old_.corp_address2_effective_date)!='',1,0));
 //bad_corp_address2_effective_date_ct := count(group,length(trim(old_.corp_address2_effective_date,left,right))!=length(trim(stringlib.stringfilter(old_.corp_address2_effective_date,'0123456789'),left,right))); 
 //has_corp_phone_number               := ave(group,if(trim(old_.corp_phone_number)!='',1,0));
 //has_corp_phone_number_type_cd       := ave(group,if(trim(old_.corp_phone_number_type_cd)!='',1,0));
 //has_corp_phone_number_type_desc     := ave(group,if(trim(old_.corp_phone_number_type_desc)!='',1,0));
 //has_corp_email_address              := ave(group,if(trim(old_.corp_email_address)!='',1,0));
 //has_corp_web_address                := ave(group,if(trim(old_.corp_web_address)!='',1,0));
 has_corp_filing_reference_nbr       := ave(group,if(trim(old_.corp_filing_reference_nbr)!='',1,0));
 has_corp_filing_date                := ave(group,if(trim(old_.corp_filing_date)!='',1,0));
 has_corp_filing_cd                  := ave(group,if(trim(old_.corp_filing_cd)!='',1,0));
 has_corp_filing_desc                := ave(group,if(trim(old_.corp_filing_desc)!='',1,0));
 has_corp_status_cd                  := ave(group,if(trim(old_.corp_status_cd)!='',1,0));
 has_corp_status_desc                := ave(group,if(trim(old_.corp_status_desc)!='',1,0));
 has_corp_status_date                := ave(group,if(trim(old_.corp_status_date)!='',1,0));
 //has_corp_ticker_symbol              := ave(group,if(trim(old_.corp_ticker_symbol)!='',1,0));
 //has_corp_stock_exchange             := ave(group,if(trim(old_.corp_stock_exchange)!='',1,0));
 has_corp_inc_state                  := ave(group,if(trim(old_.corp_inc_state)!='',1,0));
 has_corp_inc_date                   := ave(group,if(trim(old_.corp_inc_date)!='',1,0));
 has_corp_fed_tax_id                 := ave(group,if(trim(old_.corp_fed_tax_id)!='',1,0));
 has_corp_state_tax_id               := ave(group,if(trim(old_.corp_state_tax_id)!='',1,0));

 has_corp_term_exist_cd              := ave(group,if(trim(old_.corp_term_exist_cd)!='',1,0));
 has_corp_term_exist_cd_P            := ave(group,if(trim(old_.corp_term_exist_cd)='P',1,0));
 has_corp_term_exist_cd_N            := ave(group,if(trim(old_.corp_term_exist_cd)='N',1,0));
 has_corp_term_exist_cd_D            := ave(group,if(trim(old_.corp_term_exist_cd)='D',1,0));

 has_corp_term_exist_exp             := ave(group,if(trim(old_.corp_term_exist_exp)!='',1,0));
 has_corp_term_exist_desc            := ave(group,if(trim(old_.corp_term_exist_desc)!='',1,0));

 has_corp_foreign_domestic_ind       := ave(group,if(trim(old_.corp_foreign_domestic_ind)!='',1,0));
 has_corp_foreign_domestic_ind_F     := ave(group,if(trim(old_.corp_foreign_domestic_ind)='F',1,0));
 has_corp_foreign_domestic_ind_D     := ave(group,if(trim(old_.corp_foreign_domestic_ind)='D',1,0));

 has_corp_forgn_state_cd             := ave(group,if(trim(old_.corp_forgn_state_cd)!='',1,0));
 has_corp_forgn_state_desc           := ave(group,if(trim(old_.corp_forgn_state_desc)!='',1,0));
 has_corp_forgn_sos_charter_nbr      := ave(group,if(trim(old_.corp_forgn_sos_charter_nbr)!='',1,0));
 has_corp_forgn_date                 := ave(group,if(trim(old_.corp_forgn_date)!='',1,0));
 has_corp_forgn_fed_tax_id           := ave(group,if(trim(old_.corp_forgn_fed_tax_id)!='',1,0));
 has_corp_forgn_state_tax_id         := ave(group,if(trim(old_.corp_forgn_state_tax_id)!='',1,0));

 has_corp_forgn_term_exist_cd        := ave(group,if(trim(old_.corp_forgn_term_exist_cd)!='',1,0));
 has_corp_forgn_term_exist_cd_P      := ave(group,if(trim(old_.corp_forgn_term_exist_cd)='P',1,0));
 has_corp_forgn_term_exist_cd_N      := ave(group,if(trim(old_.corp_forgn_term_exist_cd)='N',1,0));
 has_corp_forgn_term_exist_cd_D      := ave(group,if(trim(old_.corp_forgn_term_exist_cd)='D',1,0));
 
 has_corp_forgn_term_exist_exp       := ave(group,if(trim(old_.corp_forgn_term_exist_exp)!='',1,0));
 has_corp_forgn_term_exist_desc      := ave(group,if(trim(old_.corp_forgn_term_exist_desc)!='',1,0));
 has_corp_orig_org_structure_cd      := ave(group,if(trim(old_.corp_orig_org_structure_cd)!='',1,0));
 has_corp_orig_org_structure_desc    := ave(group,if(trim(old_.corp_orig_org_structure_desc)!='',1,0));

 has_corp_for_profit_ind             := ave(group,if(trim(old_.corp_for_profit_ind)!='',1,0));
 has_corp_for_profit_ind_Y           := ave(group,if(trim(old_.corp_for_profit_ind)='Y',1,0));
 has_corp_for_profit_ind_N           := ave(group,if(trim(old_.corp_for_profit_ind)='N',1,0));

 has_corp_sic_code                   := ave(group,if(trim(old_.corp_sic_code)!='',1,0));
 has_corp_orig_bus_type_cd           := ave(group,if(trim(old_.corp_orig_bus_type_cd)!='',1,0));
 has_corp_orig_bus_type_desc         := ave(group,if(trim(old_.corp_orig_bus_type_desc)!='',1,0));
 has_corp_ra_name                    := ave(group,if(trim(old_.corp_ra_name)!='',1,0));
 has_corp_ra_title_cd                := ave(group,if(trim(old_.corp_ra_title_cd)!='',1,0));
 has_corp_ra_title_desc              := ave(group,if(trim(old_.corp_ra_title_desc)!='',1,0));
 has_corp_ra_fein                    := ave(group,if(trim(old_.corp_ra_fein)!='',1,0));
 has_corp_ra_ssn                     := ave(group,if(trim(old_.corp_ra_ssn)!='',1,0));
 has_corp_ra_dob                     := ave(group,if(trim(old_.corp_ra_dob)!='',1,0));
 has_corp_ra_effective_date          := ave(group,if(trim(old_.corp_ra_dob)!='',1,0));
 has_corp_ra_address_type_cd         := ave(group,if(trim(old_.corp_ra_address_type_cd)!='',1,0));
 has_corp_ra_address_type_desc       := ave(group,if(trim(old_.corp_ra_address_type_desc)!='',1,0));
 has_corp_ra_address_line1           := ave(group,if(trim(old_.corp_ra_address_line1)!='',1,0));
 has_corp_ra_address_line2           := ave(group,if(trim(old_.corp_ra_address_line2)!='',1,0));
 has_corp_ra_address_line3           := ave(group,if(trim(old_.corp_ra_address_line3)!='',1,0));
 //has_corp_ra_phone_number            := ave(group,if(trim(old_.corp_ra_phone_number)!='',1,0));
 //has_corp_ra_phone_number_type_cd    := ave(group,if(trim(old_.corp_ra_phone_number_type_cd)!='',1,0));
 //has_corp_ra_phone_number_type_desc  := ave(group,if(trim(old_.corp_ra_phone_number_type_desc)!='',1,0));
 //has_corp_ra_email_address           := ave(group,if(trim(old_.corp_ra_email_address)!='',1,0));
 //has_corp_ra_web_address             := ave(group,if(trim(old_.corp_ra_web_address)!='',1,0));
end;

//old_stats := sort(table(old_,outrec1,corp_state_origin,corp_vendor,few),corp_state_origin,corp_vendor);
//output(old_stats);

outrec2 := record
 new_.corp_state_origin;
 new_.corp_vendor;
 count_ := count(group);
 //new_.corp_process_date;
 min_process_date                    := min(group,new_.corp_process_date);
 max_process_date                    := max(group,new_.corp_process_date);
 bad_corp_address1_effective_date_ct := count(group,length(trim(new_.corp_address1_effective_date,left,right))!=length(trim(stringlib.stringfilter(new_.corp_address1_effective_date,'0123456789'),left,right)));
 bad_corp_filing_date_ct             := count(group,length(trim(new_.corp_filing_date,left,right))!=length(trim(stringlib.stringfilter(new_.corp_filing_date,'0123456789'),left,right)));
 bad_corp_status_date_ct             := count(group,length(trim(new_.corp_status_date,left,right))!=length(trim(stringlib.stringfilter(new_.corp_status_date,'0123456789'),left,right)));
 bad_corp_inc_date_ct                := count(group,length(trim(new_.corp_inc_date,left,right))!=length(trim(stringlib.stringfilter(new_.corp_inc_date,'0123456789'),left,right)));
 has_corp_term_exist_cd_other        := ave(group,if(trim(new_.corp_term_exist_cd) not in ['P','N','D',' '],1,0));
 has_corp_foreign_domestic_ind_other := ave(group,if(trim(new_.corp_foreign_domestic_ind) not in ['F','D',' '],1,0));
 bad_corp_forgn_date_ct              := count(group,length(trim(new_.corp_forgn_date,left,right))!=length(trim(stringlib.stringfilter(new_.corp_forgn_date,'0123456789'),left,right)));
 has_corp_forgn_term_exist_cd_other  := ave(group,if(trim(new_.corp_forgn_term_exist_cd) not in ['P','N','D',' '],1,0));
 has_corp_for_profit_ind_other       := ave(group,if(trim(new_.corp_for_profit_ind) not in ['Y','N',' '],1,0));
 bad_corp_ra_effective_date_ct       := count(group,length(trim(new_.corp_ra_effective_date,left,right))!=length(trim(stringlib.stringfilter(new_.corp_ra_effective_date,'0123456789'),left,right)));
 has_corp_key                        := ave(group,if(trim(new_.corp_key)!='',1,0));
 //bad_corp_key_ct                     := count(group,new_.corp_key[1..3]!=new_.corp_vendor+'-');
 has_corp_vendor                     := ave(group,if(trim(new_.corp_vendor)!='',1,0));
 has_corp_orig_sos_charter_nbr       := ave(group,if(trim(new_.corp_orig_sos_charter_nbr)!='',1,0));
 has_corp_legal_name                 := ave(group,if(trim(new_.corp_legal_name)!='',1,0));
 has_corp_address1_type_cd           := ave(group,if(trim(new_.corp_address1_type_cd)!='',1,0));
 has_corp_address1_type_desc         := ave(group,if(trim(new_.corp_address1_type_desc)!='',1,0));
 has_corp_address1_line1             := ave(group,if(trim(new_.corp_address1_line1)!='',1,0));
 has_corp_address1_line2             := ave(group,if(trim(new_.corp_address1_line2)!='',1,0));
 has_corp_address1_line3             := ave(group,if(trim(new_.corp_address1_line3)!='',1,0));
 has_corp_address1_effective_date    := ave(group,if(trim(new_.corp_address1_effective_date)!='',1,0));
 //has_corp_address2_type_cd           := ave(group,if(trim(new_.corp_address2_type_cd)!='',1,0));
 //has_corp_address2_type_desc         := ave(group,if(trim(new_.corp_address2_type_desc)!='',1,0));
 //has_corp_address2_line1             := ave(group,if(trim(new_.corp_address2_line1)!='',1,0));
 //has_corp_address2_line2             := ave(group,if(trim(new_.corp_address2_line2)!='',1,0));
 //has_corp_address2_line3             := ave(group,if(trim(new_.corp_address2_line3)!='',1,0));
 //has_corp_address2_effective_date    := ave(group,if(trim(new_.corp_address2_effective_date)!='',1,0));
 //bad_corp_address2_effective_date_ct := count(group,length(trim(new_.corp_address2_effective_date,left,right))!=length(trim(stringlib.stringfilter(new_.corp_address2_effective_date,'0123456789'),left,right))); 
 //has_corp_phone_number               := ave(group,if(trim(new_.corp_phone_number)!='',1,0));
 //has_corp_phone_number_type_cd       := ave(group,if(trim(new_.corp_phone_number_type_cd)!='',1,0));
 //has_corp_phone_number_type_desc     := ave(group,if(trim(new_.corp_phone_number_type_desc)!='',1,0));
 //has_corp_email_address              := ave(group,if(trim(new_.corp_email_address)!='',1,0));
 //has_corp_web_address                := ave(group,if(trim(new_.corp_web_address)!='',1,0));
 has_corp_filing_reference_nbr       := ave(group,if(trim(new_.corp_filing_reference_nbr)!='',1,0));
 has_corp_filing_date                := ave(group,if(trim(new_.corp_filing_date)!='',1,0));
 has_corp_filing_cd                  := ave(group,if(trim(new_.corp_filing_cd)!='',1,0));
 has_corp_filing_desc                := ave(group,if(trim(new_.corp_filing_desc)!='',1,0));
 has_corp_status_cd                  := ave(group,if(trim(new_.corp_status_cd)!='',1,0));
 has_corp_status_desc                := ave(group,if(trim(new_.corp_status_desc)!='',1,0));
 has_corp_status_date                := ave(group,if(trim(new_.corp_status_date)!='',1,0));
 //has_corp_ticker_symbol              := ave(group,if(trim(new_.corp_ticker_symbol)!='',1,0));
 //has_corp_stock_exchange             := ave(group,if(trim(new_.corp_stock_exchange)!='',1,0));
 has_corp_inc_state                  := ave(group,if(trim(new_.corp_inc_state)!='',1,0));
 has_corp_inc_date                   := ave(group,if(trim(new_.corp_inc_date)!='',1,0));
 has_corp_fed_tax_id                 := ave(group,if(trim(new_.corp_fed_tax_id)!='',1,0));
 has_corp_state_tax_id               := ave(group,if(trim(new_.corp_state_tax_id)!='',1,0));

 has_corp_term_exist_cd              := ave(group,if(trim(new_.corp_term_exist_cd)!='',1,0));
 has_corp_term_exist_cd_P            := ave(group,if(trim(new_.corp_term_exist_cd)='P',1,0));
 has_corp_term_exist_cd_N            := ave(group,if(trim(new_.corp_term_exist_cd)='N',1,0));
 has_corp_term_exist_cd_D            := ave(group,if(trim(new_.corp_term_exist_cd)='D',1,0));

 has_corp_term_exist_exp             := ave(group,if(trim(new_.corp_term_exist_exp)!='',1,0));
 has_corp_term_exist_desc            := ave(group,if(trim(new_.corp_term_exist_desc)!='',1,0));

 has_corp_foreign_domestic_ind       := ave(group,if(trim(new_.corp_foreign_domestic_ind)!='',1,0));
 has_corp_foreign_domestic_ind_F     := ave(group,if(trim(new_.corp_foreign_domestic_ind)='F',1,0));
 has_corp_foreign_domestic_ind_D     := ave(group,if(trim(new_.corp_foreign_domestic_ind)='D',1,0));

 has_corp_forgn_state_cd             := ave(group,if(trim(new_.corp_forgn_state_cd)!='',1,0));
 has_corp_forgn_state_desc           := ave(group,if(trim(new_.corp_forgn_state_desc)!='',1,0));
 has_corp_forgn_sos_charter_nbr      := ave(group,if(trim(new_.corp_forgn_sos_charter_nbr)!='',1,0));
 has_corp_forgn_date                 := ave(group,if(trim(new_.corp_forgn_date)!='',1,0));
 has_corp_forgn_fed_tax_id           := ave(group,if(trim(new_.corp_forgn_fed_tax_id)!='',1,0));
 has_corp_forgn_state_tax_id         := ave(group,if(trim(new_.corp_forgn_state_tax_id)!='',1,0));

 has_corp_forgn_term_exist_cd        := ave(group,if(trim(new_.corp_forgn_term_exist_cd)!='',1,0));
 has_corp_forgn_term_exist_cd_P      := ave(group,if(trim(new_.corp_forgn_term_exist_cd)='P',1,0));
 has_corp_forgn_term_exist_cd_N      := ave(group,if(trim(new_.corp_forgn_term_exist_cd)='N',1,0));
 has_corp_forgn_term_exist_cd_D      := ave(group,if(trim(new_.corp_forgn_term_exist_cd)='D',1,0));
 
 has_corp_forgn_term_exist_exp       := ave(group,if(trim(new_.corp_forgn_term_exist_exp)!='',1,0));
 has_corp_forgn_term_exist_desc      := ave(group,if(trim(new_.corp_forgn_term_exist_desc)!='',1,0));
 has_corp_orig_org_structure_cd      := ave(group,if(trim(new_.corp_orig_org_structure_cd)!='',1,0));
 has_corp_orig_org_structure_desc    := ave(group,if(trim(new_.corp_orig_org_structure_desc)!='',1,0));

 has_corp_for_profit_ind             := ave(group,if(trim(new_.corp_for_profit_ind)!='',1,0));
 has_corp_for_profit_ind_Y           := ave(group,if(trim(new_.corp_for_profit_ind)='Y',1,0));
 has_corp_for_profit_ind_N           := ave(group,if(trim(new_.corp_for_profit_ind)='N',1,0));

 has_corp_sic_code                   := ave(group,if(trim(new_.corp_sic_code)!='',1,0));
 has_corp_orig_bus_type_cd           := ave(group,if(trim(new_.corp_orig_bus_type_cd)!='',1,0));
 has_corp_orig_bus_type_desc         := ave(group,if(trim(new_.corp_orig_bus_type_desc)!='',1,0));
 has_corp_ra_name                    := ave(group,if(trim(new_.corp_ra_name)!='',1,0));
 has_corp_ra_title_cd                := ave(group,if(trim(new_.corp_ra_title_cd)!='',1,0));
 has_corp_ra_title_desc              := ave(group,if(trim(new_.corp_ra_title_desc)!='',1,0));
 has_corp_ra_fein                    := ave(group,if(trim(new_.corp_ra_fein)!='',1,0));
 has_corp_ra_ssn                     := ave(group,if(trim(new_.corp_ra_ssn)!='',1,0));
 has_corp_ra_dob                     := ave(group,if(trim(new_.corp_ra_dob)!='',1,0));
 has_corp_ra_effective_date          := ave(group,if(trim(new_.corp_ra_dob)!='',1,0));
 has_corp_ra_address_type_cd         := ave(group,if(trim(new_.corp_ra_address_type_cd)!='',1,0));
 has_corp_ra_address_type_desc       := ave(group,if(trim(new_.corp_ra_address_type_desc)!='',1,0));
 has_corp_ra_address_line1           := ave(group,if(trim(new_.corp_ra_address_line1)!='',1,0));
 has_corp_ra_address_line2           := ave(group,if(trim(new_.corp_ra_address_line2)!='',1,0));
 has_corp_ra_address_line3           := ave(group,if(trim(new_.corp_ra_address_line3)!='',1,0));
 //has_corp_ra_phone_number            := ave(group,if(trim(new_.corp_ra_phone_number)!='',1,0));
 //has_corp_ra_phone_number_type_cd    := ave(group,if(trim(new_.corp_ra_phone_number_type_cd)!='',1,0));
 //has_corp_ra_phone_number_type_desc  := ave(group,if(trim(new_.corp_ra_phone_number_type_desc)!='',1,0));
 //has_corp_ra_email_address           := ave(group,if(trim(new_.corp_ra_email_address)!='',1,0));
 //has_corp_ra_web_address             := ave(group,if(trim(new_.corp_ra_web_address)!='',1,0));
end;

new_stats := sort(table(new_,outrec2,corp_state_origin,corp_vendor,few),corp_state_origin,corp_vendor);
output(new_stats);
/*
slimrec := record
 decimal2 counter_;
 string35 condition;
 string10 old_val;
 string10 new_val;
 real4    delta;
end;

slimrec mapa(old_stats l, new_stats r) := transform
 self.counter_  := 1;
 self.condition := 'corp_state_origin + corp_vendor';
 self.old_val   := l.corp_state_origin+' - '+l.corp_vendor;
 self.new_val   := r.corp_state_origin+' - '+r.corp_vendor;
 self           := [];
end;

slimrec mapb(old_stats l, new_stats r) := transform
 self.counter_  := 2;
 self.condition := 'count_';
 self.old_val   := (string10) l.count_;
 self.new_val   := (string10) r.count_;
 self           := [];
end;
		  
slimrec mapc(old_stats l, new_stats r) := transform
 self.counter_  := 3;
 self.condition := 'min_process_date';
 self.old_val   := l.min_process_date;
 self.new_val   := r.min_process_date;
 self           := [];
end;

slimrec mapd(old_stats l, new_stats r) := transform
 self.counter_  := 4;
 self.condition := 'max_process_date';
 self.old_val   := l.max_process_date;
 self.new_val   := r.max_process_date;
 self           := [];
end;

slimrec mape(old_stats l, new_stats r) := transform
 self.counter_  := 5;
 self.condition := 'has_corp_key';
 self.old_val   := (string10)l.has_corp_key;
 self.new_val   := (string10)r.has_corp_key;
 self.delta     := l.has_corp_key - r.has_corp_key
end;
		  
//slimrec mapf(old_stats l, new_stats r) := transform
// self.counter_  := 6;
// self.condition := 'bad_corp_key_ct';
// self.old_val   := (string10)l.bad_corp_key_ct;
// self.new_val   := (string10)r.bad_corp_key_ct;
// self           := [];
//end;
		 
slimrec mapg(old_stats l, new_stats r) := transform
 self.counter_  := 7;
 self.condition := 'has_corp_vendor';
 self.old_val   := (string10)l.has_corp_vendor;
 self.new_val   := (string10)r.has_corp_vendor;
 self.delta     := l.has_corp_vendor - r.has_corp_vendor;
end;

slimrec maph(old_stats l, new_stats r) := transform
 self.counter_  := 8;
 self.condition := 'has_corp_orig_sos_charter_nbr';
 self.old_val   := (string10)l.has_corp_orig_sos_charter_nbr;
 self.new_val   := (string10)r.has_corp_orig_sos_charter_nbr;
 self.delta     := l.has_corp_orig_sos_charter_nbr - r.has_corp_orig_sos_charter_nbr;
end;

slimrec mapi(old_stats l, new_stats r) := transform
 self.counter_  := 9;
 self.condition := 'has_corp_legal_name';
 self.old_val   := (string10)l.has_corp_legal_name;
 self.new_val   := (string10)r.has_corp_legal_name;
 self.delta     := l.has_corp_legal_name - r.has_corp_legal_name;
end;

slimrec mapj(old_stats l, new_stats r) := transform
 self.counter_  := 10;
 self.condition := 'has_corp_address1_type_cd';
 self.old_val   := (string10)l.has_corp_address1_type_cd;
 self.new_val   := (string10)r.has_corp_address1_type_cd;
 self.delta     := l.has_corp_address1_type_cd - r.has_corp_address1_type_cd;
end;
		  
slimrec mapk(old_stats l, new_stats r) := transform
 self.counter_  := 11;
 self.condition := 'has_corp_address1_type_desc';
 self.old_val   := (string10)l.has_corp_address1_type_desc;
 self.new_val   := (string10)r.has_corp_address1_type_desc;
 self.delta     := l.has_corp_address1_type_desc - r.has_corp_address1_type_desc;
end;

slimrec mapl(old_stats l, new_stats r) := transform
 self.counter_  := 12;
 self.condition := 'has_corp_address1_line1';
 self.old_val   := (string10)l.has_corp_address1_line1;
 self.new_val   := (string10)r.has_corp_address1_line1;
 self.delta     := l.has_corp_address1_line1 - r.has_corp_address1_line1;
end;

slimrec mapm(old_stats l, new_stats r) := transform
 self.counter_  := 13;
 self.condition := 'has_corp_address1_line2';
 self.old_val   := (string10)l.has_corp_address1_line2;
 self.new_val   := (string10)r.has_corp_address1_line2;
 self.delta     := l.has_corp_address1_line2 - r.has_corp_address1_line2;
end;

slimrec mapn(old_stats l, new_stats r) := transform
 self.counter_  := 14;
 self.condition := 'has_corp_address1_line3';
 self.old_val   := (string10)l.has_corp_address1_line3;
 self.new_val   := (string10)r.has_corp_address1_line3;
 self.delta     := l.has_corp_address1_line3 - r.has_corp_address1_line3;
end;

slimrec mapo(old_stats l, new_stats r) := transform
 self.counter_  := 15;
 self.condition := 'has_corp_address1_effective_date';
 self.old_val   := (string10)l.has_corp_address1_effective_date;
 self.new_val   := (string10)r.has_corp_address1_effective_date;
 self.delta     := l.has_corp_address1_effective_date - r.has_corp_address1_effective_date;
end;

slimrec mapp(old_stats l, new_stats r) := transform
 self.counter_  := 16;
 self.condition := 'bad_corp_address1_effective_date_ct';
 self.old_val   := (string10)l.bad_corp_address1_effective_date_ct;
 self.new_val   := (string10)r.bad_corp_address1_effective_date_ct;
 self.delta     := [];
end;

//slimrec mapq(old_stats l, new_stats r) := transform
// self.counter_  := 17;
// self.condition := 'has_corp_address2_type_cd';
// self.old_val   := (string10)l.has_corp_address2_type_cd;
// self.new_val   := (string10)r.has_corp_address2_type_cd;
// self.delta     := l.has_corp_address2_type_cd - r.has_corp_address2_type_cd;
//end;
		  
//slimrec mapr(old_stats l, new_stats r) := transform
// self.counter_  := 18;
// self.condition := 'has_corp_address2_type_desc';
// self.old_val   := (string10)l.has_corp_address2_type_desc;
// self.new_val   := (string10)r.has_corp_address2_type_desc;
// self.delta     := l.has_corp_address2_type_desc - r.has_corp_address2_type_desc;
//end;

//slimrec maps(old_stats l, new_stats r) := transform
// self.counter_  := 19;
// self.condition := 'has_corp_address2_line1';
// self.old_val   := (string10)l.has_corp_address2_line1;
// self.new_val   := (string10)r.has_corp_address2_line1;
// self.delta     := l.has_corp_address2_line1 - r.has_corp_address2_line1;
//end;

//slimrec mapt(old_stats l, new_stats r) := transform
// self.counter_  := 20;
// self.condition := 'has_corp_address2_line2';
// self.old_val   := (string10)l.has_corp_address2_line2;
// self.new_val   := (string10)r.has_corp_address2_line2;
// self.delta     := l.has_corp_address2_line2 - r.has_corp_address2_line2;
//end;

//slimrec mapu(old_stats l, new_stats r) := transform
// self.counter_  := 21;
// self.condition := 'has_corp_address2_line3';
// self.old_val   := (string10)l.has_corp_address2_line3;
// self.new_val   := (string10)r.has_corp_address2_line3;
// self.delta     := l.has_corp_address2_line3 - r.has_corp_address2_line3;
//end;

//slimrec mapv(old_stats l, new_stats r) := transform
// self.counter_  := 22;
// self.condition := 'has_corp_address2_effective_date';
// self.old_val   := (string10)l.has_corp_address2_effective_date;
// self.new_val   := (string10)r.has_corp_address2_effective_date;
// self.delta     := l.has_corp_address2_effective_date - r.has_corp_address2_effective_date;
//end;

//slimrec mapw(old_stats l, new_stats r) := transform
// self.counter_  := 23;
// self.condition := 'bad_corp_address2_effective_date_ct';
// self.old_val   := (string10)l.bad_corp_address2_effective_date_ct;
// self.new_val   := (string10)r.bad_corp_address2_effective_date_ct;
// self.delta     := [];
//end;

//slimrec mapx(old_stats l, new_stats r) := transform
// self.counter_  := 24;
// self.condition := 'has_corp_phone_number';
// self.old_val   := (string10)l.has_corp_phone_number;
// self.new_val   := (string10)r.has_corp_phone_number;
// self.delta     := l.has_corp_phone_number - r.has_corp_phone_number;
//end;

//slimrec mapy(old_stats l, new_stats r) := transform
// self.counter_  := 25;
// self.condition := 'has_corp_phone_number_type_cd';
// self.old_val   := (string10)l.has_corp_phone_number_type_cd;
// self.new_val   := (string10)r.has_corp_phone_number_type_cd;
// self.delta     := l.has_corp_phone_number_type_cd - r.has_corp_phone_number_type_cd;
//end;

//slimrec mapz(old_stats l, new_stats r) := transform
// self.counter_  := 26;
// self.condition := 'has_corp_phone_number_type_desc';
// self.old_val   := (string10)l.has_corp_phone_number_type_desc;
// self.new_val   := (string10)r.has_corp_phone_number_type_desc;
// self.delta     := l.has_corp_phone_number_type_desc - r.has_corp_phone_number_type_desc;
//end;

//slimrec mapaa(old_stats l, new_stats r) := transform
// self.counter_  := 27;
// self.condition := 'has_corp_email_address';
// self.old_val   := (string10)l.has_corp_email_address;
// self.new_val   := (string10)r.has_corp_email_address;
// self.delta     := l.has_corp_email_address - r.has_corp_email_address;
//end;

//slimrec mapab(old_stats l, new_stats r) := transform
// self.counter_  := 28;
// self.condition := 'has_corp_web_address';
// self.old_val   := (string10)l.has_corp_web_address;
// self.new_val   := (string10)r.has_corp_web_address;
// self.delta     := l.has_corp_web_address - r.has_corp_web_address;
//end;

slimrec mapac(old_stats l, new_stats r) := transform
 self.counter_  := 29;
 self.condition := 'has_corp_filing_reference_nbr';
 self.old_val   := (string10)l.has_corp_filing_reference_nbr;
 self.new_val   := (string10)r.has_corp_filing_reference_nbr;
 self.delta     := l.has_corp_filing_reference_nbr - r.has_corp_filing_reference_nbr;
end;

slimrec mapad(old_stats l, new_stats r) := transform
 self.counter_  := 30;
 self.condition := 'has_corp_filing_date';
 self.old_val   := (string10)l.has_corp_filing_date;
 self.new_val   := (string10)r.has_corp_filing_date;
 self.delta     := l.has_corp_filing_date - r.has_corp_filing_date;
end;

slimrec mapae(old_stats l, new_stats r) := transform
 self.counter_  := 31;
 self.condition := 'bad_corp_filing_date_ct';
 self.old_val   := (string10)l.bad_corp_filing_date_ct;
 self.new_val   := (string10)r.bad_corp_filing_date_ct;
 self.delta     := [];
end;

slimrec mapaf(old_stats l, new_stats r) := transform
 self.counter_  := 32;
 self.condition := 'has_corp_filing_cd';
 self.old_val   := (string10)l.has_corp_filing_cd;
 self.new_val   := (string10)r.has_corp_filing_cd;
 self.delta     := l.has_corp_filing_cd - r.has_corp_filing_cd;
end;

slimrec mapag(old_stats l, new_stats r) := transform
 self.counter_  := 33;
 self.condition := 'has_corp_filing_desc';
 self.old_val   := (string10)l.has_corp_filing_desc;
 self.new_val   := (string10)r.has_corp_filing_desc;
 self.delta     := l.has_corp_filing_desc - r.has_corp_filing_desc;
end;

slimrec mapah(old_stats l, new_stats r) := transform
 self.counter_  := 34;
 self.condition := 'has_corp_status_cd';
 self.old_val   := (string10)l.has_corp_status_cd;
 self.new_val   := (string10)r.has_corp_status_cd;
 self.delta     := l.has_corp_status_cd - r.has_corp_status_cd;
end;

slimrec mapai(old_stats l, new_stats r) := transform
 self.counter_  := 35;
 self.condition := 'has_corp_status_desc';
 self.old_val   := (string10)l.has_corp_status_desc;
 self.new_val   := (string10)r.has_corp_status_desc;
 self.delta     := l.has_corp_status_desc - r.has_corp_status_desc;
end;

slimrec mapaj(old_stats l, new_stats r) := transform
 self.counter_  := 36;
 self.condition := 'has_corp_status_date';
 self.old_val   := (string10)l.has_corp_status_date;
 self.new_val   := (string10)r.has_corp_status_date;
 self.delta     := l.has_corp_status_date - r.has_corp_status_date;
end;

slimrec mapak(old_stats l, new_stats r) := transform
 self.counter_  := 37;
 self.condition := 'bad_corp_status_date_ct';
 self.old_val   := (string10)l.bad_corp_status_date_ct;
 self.new_val   := (string10)r.bad_corp_status_date_ct;
 self.delta     := [];
end;

//slimrec mapal(old_stats l, new_stats r) := transform
// self.counter_  := 38;
// self.condition := 'has_corp_ticker_symbol';
// self.old_val   := (string10)l.has_corp_ticker_symbol;
// self.new_val   := (string10)r.has_corp_ticker_symbol;
// self.delta     := l.has_corp_ticker_symbol - r.has_corp_ticker_symbol;
//end;

//slimrec mapam(old_stats l, new_stats r) := transform
// self.counter_  := 39;
// self.condition := 'has_corp_stock_exchange';
// self.old_val   := (string10)l.has_corp_stock_exchange;
// self.new_val   := (string10)r.has_corp_stock_exchange;
// self.delta     := l.has_corp_stock_exchange - r.has_corp_stock_exchange;
//end;

slimrec mapan(old_stats l, new_stats r) := transform
 self.counter_  := 40;
 self.condition := 'has_corp_inc_state';
 self.old_val   := (string10)l.has_corp_inc_state;
 self.new_val   := (string10)r.has_corp_inc_state;
 self.delta     := l.has_corp_inc_state - r.has_corp_inc_state;
end;

slimrec mapao(old_stats l, new_stats r) := transform
 self.counter_  := 41;
 self.condition := 'has_corp_inc_date';
 self.old_val   := (string10)l.has_corp_inc_date;
 self.new_val   := (string10)r.has_corp_inc_date;
 self.delta     := l.has_corp_inc_date - r.has_corp_inc_date;
end;

slimrec mapap(old_stats l, new_stats r) := transform
 self.counter_  := 42;
 self.condition := 'bad_corp_inc_date_ct';
 self.old_val   := (string10)l.bad_corp_inc_date_ct;
 self.new_val   := (string10)r.bad_corp_inc_date_ct;
 self.delta     := [];
end;

slimrec mapaq(old_stats l, new_stats r) := transform
 self.counter_  := 43;
 self.condition := 'has_corp_fed_tax_id';
 self.old_val   := (string10)l.has_corp_fed_tax_id;
 self.new_val   := (string10)r.has_corp_fed_tax_id;
 self.delta     := l.has_corp_fed_tax_id - r.has_corp_fed_tax_id;
end;

slimrec mapar(old_stats l, new_stats r) := transform
 self.counter_  := 44;
 self.condition := 'has_corp_state_tax_id';
 self.old_val   := (string10)l.has_corp_state_tax_id;
 self.new_val   := (string10)r.has_corp_state_tax_id;
 self.delta     := l.has_corp_state_tax_id - r.has_corp_state_tax_id;
end;

slimrec mapas(old_stats l, new_stats r) := transform
 self.counter_  := 45;
 self.condition := 'has_corp_term_exist_cd';
 self.old_val   := (string10)l.has_corp_term_exist_cd;
 self.new_val   := (string10)r.has_corp_term_exist_cd;
 self.delta     := l.has_corp_term_exist_cd - r.has_corp_term_exist_cd;
end;

slimrec mapat(old_stats l, new_stats r) := transform
 self.counter_  := 46;
 self.condition := 'has_corp_term_exist_cd_P';
 self.old_val   := (string10)l.has_corp_term_exist_cd_P;
 self.new_val   := (string10)r.has_corp_term_exist_cd_P;
 self.delta     := l.has_corp_term_exist_cd_P - r.has_corp_term_exist_cd_P;
end;

slimrec mapau(old_stats l, new_stats r) := transform
 self.counter_  := 47;
 self.condition := 'has_corp_term_exist_cd_N';
 self.old_val   := (string10)l.has_corp_term_exist_cd_N;
 self.new_val   := (string10)r.has_corp_term_exist_cd_N;
 self.delta     := l.has_corp_term_exist_cd_N - r.has_corp_term_exist_cd_N;
end;

slimrec mapav(old_stats l, new_stats r) := transform
 self.counter_  := 48;
 self.condition := 'has_corp_term_exist_cd_D';
 self.old_val   := (string10)l.has_corp_term_exist_cd_D;
 self.new_val   := (string10)r.has_corp_term_exist_cd_D;
 self.delta     := l.has_corp_term_exist_cd_D - r.has_corp_term_exist_cd_D;
end;

slimrec mapaw(old_stats l, new_stats r) := transform
 self.counter_  := 49;
 self.condition := 'has_corp_term_exist_cd_other';
 self.old_val   := (string10)l.has_corp_term_exist_cd_other;
 self.new_val   := (string10)r.has_corp_term_exist_cd_other;
 self.delta     := l.has_corp_term_exist_cd_other - r.has_corp_term_exist_cd_other;
end;

slimrec mapax(old_stats l, new_stats r) := transform
 self.counter_  := 50;
 self.condition := 'has_corp_term_exist_exp';
 self.old_val   := (string10)l.has_corp_term_exist_exp;
 self.new_val   := (string10)r.has_corp_term_exist_exp;
 self.delta     := l.has_corp_term_exist_exp - r.has_corp_term_exist_exp;
end;

slimrec mapay(old_stats l, new_stats r) := transform
 self.counter_  := 51;
 self.condition := 'has_corp_term_exist_desc';
 self.old_val   := (string10)l.has_corp_term_exist_desc;
 self.new_val   := (string10)r.has_corp_term_exist_desc;
 self.delta     := l.has_corp_term_exist_desc - r.has_corp_term_exist_desc;
end;

slimrec mapaz(old_stats l, new_stats r) := transform
 self.counter_  := 52;
 self.condition := 'has_corp_foreign_domestic_ind';
 self.old_val   := (string10)l.has_corp_foreign_domestic_ind;
 self.new_val   := (string10)r.has_corp_foreign_domestic_ind;
 self.delta     := l.has_corp_foreign_domestic_ind - r.has_corp_foreign_domestic_ind;
end;

slimrec mapaaa(old_stats l, new_stats r) := transform
 self.counter_  := 53;
 self.condition := 'has_corp_foreign_domestic_ind_F';
 self.old_val   := (string10)l.has_corp_foreign_domestic_ind_F;
 self.new_val   := (string10)r.has_corp_foreign_domestic_ind_F;
 self.delta     := l.has_corp_foreign_domestic_ind_F - r.has_corp_foreign_domestic_ind_F;
end;

slimrec mapaab(old_stats l, new_stats r) := transform
 self.counter_  := 54;
 self.condition := 'has_corp_foreign_domestic_ind_D';
 self.old_val   := (string10)l.has_corp_foreign_domestic_ind_D;
 self.new_val   := (string10)r.has_corp_foreign_domestic_ind_D;
 self.delta     := l.has_corp_foreign_domestic_ind_D - r.has_corp_foreign_domestic_ind_D;
end;

slimrec mapaac(old_stats l, new_stats r) := transform
 self.counter_  := 55;
 self.condition := 'has_corp_foreign_domestic_ind_other';
 self.old_val   := (string10)l.has_corp_foreign_domestic_ind_other;
 self.new_val   := (string10)r.has_corp_foreign_domestic_ind_other;
 self.delta     := l.has_corp_foreign_domestic_ind_other - r.has_corp_foreign_domestic_ind_other;
end;

slimrec mapaad(old_stats l, new_stats r) := transform
 self.counter_  := 56;
 self.condition := 'has_corp_forgn_state_cd';
 self.old_val   := (string10)l.has_corp_forgn_state_cd;
 self.new_val   := (string10)r.has_corp_forgn_state_cd;
 self.delta     := l.has_corp_forgn_state_cd - r.has_corp_forgn_state_cd;
end;

slimrec mapaae(old_stats l, new_stats r) := transform
 self.counter_  := 57;
 self.condition := 'has_corp_forgn_state_desc';
 self.old_val   := (string10)l.has_corp_forgn_state_desc;
 self.new_val   := (string10)r.has_corp_forgn_state_desc;
 self.delta     := l.has_corp_forgn_state_desc - r.has_corp_forgn_state_desc;
end;

slimrec mapaaf(old_stats l, new_stats r) := transform
 self.counter_  := 58;
 self.condition := 'has_corp_forgn_sos_charter_nbr';
 self.old_val   := (string10)l.has_corp_forgn_sos_charter_nbr;
 self.new_val   := (string10)r.has_corp_forgn_sos_charter_nbr;
 self.delta     := l.has_corp_forgn_sos_charter_nbr - r.has_corp_forgn_sos_charter_nbr;
end;

slimrec mapaag(old_stats l, new_stats r) := transform
 self.counter_  := 59;
 self.condition := 'has_corp_forgn_date';
 self.old_val   := (string10)l.has_corp_forgn_date;
 self.new_val   := (string10)r.has_corp_forgn_date;
 self.delta     := l.has_corp_forgn_date - r.has_corp_forgn_date;
end;

slimrec mapaah(old_stats l, new_stats r) := transform
 self.counter_  := 60;
 self.condition := 'bad_corp_forgn_date_ct';
 self.old_val   := (string10)l.bad_corp_forgn_date_ct;
 self.new_val   := (string10)r.bad_corp_forgn_date_ct;
 self.delta     := [];
end;

slimrec mapaai(old_stats l, new_stats r) := transform
 self.counter_  := 61;
 self.condition := 'has_corp_forgn_fed_tax_id';
 self.old_val   := (string10)l.has_corp_forgn_fed_tax_id;
 self.new_val   := (string10)r.has_corp_forgn_fed_tax_id;
 self.delta     := l.has_corp_forgn_fed_tax_id - r.has_corp_forgn_fed_tax_id;
end;

slimrec mapaaj(old_stats l, new_stats r) := transform
 self.counter_  := 62;
 self.condition := 'has_corp_forgn_state_tax_id';
 self.old_val   := (string10)l.has_corp_forgn_state_tax_id;
 self.new_val   := (string10)r.has_corp_forgn_state_tax_id;
 self.delta     := l.has_corp_forgn_state_tax_id - r.has_corp_forgn_state_tax_id;
end;

slimrec mapaak(old_stats l, new_stats r) := transform
 self.counter_  := 63;
 self.condition := 'has_corp_forgn_term_exist_cd';
 self.old_val   := (string10)l.has_corp_forgn_term_exist_cd;
 self.new_val   := (string10)r.has_corp_forgn_term_exist_cd;
 self.delta     := l.has_corp_forgn_term_exist_cd - r.has_corp_forgn_term_exist_cd;
end;

slimrec mapaal(old_stats l, new_stats r) := transform
 self.counter_  := 64;
 self.condition := 'has_corp_forgn_term_exist_cd_P';
 self.old_val   := (string10)l.has_corp_forgn_term_exist_cd_P;
 self.new_val   := (string10)r.has_corp_forgn_term_exist_cd_P;
 self.delta     := l.has_corp_forgn_term_exist_cd_P - r.has_corp_forgn_term_exist_cd_P;
end;

slimrec mapaam(old_stats l, new_stats r) := transform
 self.counter_  := 65;
 self.condition := 'has_corp_forgn_term_exist_cd_N';
 self.old_val   := (string10)l.has_corp_forgn_term_exist_cd_N;
 self.new_val   := (string10)r.has_corp_forgn_term_exist_cd_N;
 self.delta     := l.has_corp_forgn_term_exist_cd_N - r.has_corp_forgn_term_exist_cd_N;
end;

slimrec mapaan(old_stats l, new_stats r) := transform
 self.counter_  := 66;
 self.condition := 'has_corp_forgn_term_exist_cd_D';
 self.old_val   := (string10)l.has_corp_forgn_term_exist_cd_D;
 self.new_val   := (string10)r.has_corp_forgn_term_exist_cd_D;
 self.delta     := l.has_corp_forgn_term_exist_cd_D - r.has_corp_forgn_term_exist_cd_D;
end;

slimrec mapaao(old_stats l, new_stats r) := transform
 self.counter_  := 67;
 self.condition := 'has_corp_forgn_term_exist_cd_other';
 self.old_val   := (string10)l.has_corp_forgn_term_exist_cd_other;
 self.new_val   := (string10)r.has_corp_forgn_term_exist_cd_other;
 self.delta     := l.has_corp_forgn_term_exist_cd_other - r.has_corp_forgn_term_exist_cd_other;
end;

slimrec mapaap(old_stats l, new_stats r) := transform
 self.counter_  := 68;
 self.condition := 'has_corp_forgn_term_exist_exp';
 self.old_val   := (string10)l.has_corp_forgn_term_exist_exp;
 self.new_val   := (string10)r.has_corp_forgn_term_exist_exp;
 self.delta     := l.has_corp_forgn_term_exist_exp - r.has_corp_forgn_term_exist_exp;
end;

slimrec mapaaq(old_stats l, new_stats r) := transform
 self.counter_  := 69;
 self.condition := 'has_corp_forgn_term_exist_desc';
 self.old_val   := (string10)l.has_corp_forgn_term_exist_desc;
 self.new_val   := (string10)r.has_corp_forgn_term_exist_desc;
 self.delta     := l.has_corp_forgn_term_exist_desc - r.has_corp_forgn_term_exist_desc;
end;

slimrec mapaar(old_stats l, new_stats r) := transform
 self.counter_  := 70;
 self.condition := 'has_corp_orig_org_structure_cd';
 self.old_val   := (string10)l.has_corp_orig_org_structure_cd;
 self.new_val   := (string10)r.has_corp_orig_org_structure_cd;
 self.delta     := l.has_corp_orig_org_structure_cd - r.has_corp_orig_org_structure_cd;
end;

slimrec mapaas(old_stats l, new_stats r) := transform
 self.counter_  := 71;
 self.condition := 'has_corp_orig_org_structure_desc';
 self.old_val   := (string10)l.has_corp_orig_org_structure_desc;
 self.new_val   := (string10)r.has_corp_orig_org_structure_desc;
 self.delta     := l.has_corp_orig_org_structure_desc - r.has_corp_orig_org_structure_desc;
end;

slimrec mapaat(old_stats l, new_stats r) := transform
 self.counter_  := 72;
 self.condition := 'has_corp_for_profit_ind';
 self.old_val   := (string10)l.has_corp_for_profit_ind;
 self.new_val   := (string10)r.has_corp_for_profit_ind;
 self.delta     := l.has_corp_for_profit_ind - r.has_corp_for_profit_ind;
end;

slimrec mapaau(old_stats l, new_stats r) := transform
 self.counter_  := 73;
 self.condition := 'has_corp_for_profit_ind_Y';
 self.old_val   := (string10)l.has_corp_for_profit_ind_Y;
 self.new_val   := (string10)r.has_corp_for_profit_ind_Y;
 self.delta     := l.has_corp_for_profit_ind_Y - r.has_corp_for_profit_ind_Y;
end;

slimrec mapaav(old_stats l, new_stats r) := transform
 self.counter_  := 74;
 self.condition := 'has_corp_for_profit_ind_N';
 self.old_val   := (string10)l.has_corp_for_profit_ind_N;
 self.new_val   := (string10)r.has_corp_for_profit_ind_N;
 self.delta     := l.has_corp_for_profit_ind_N - r.has_corp_for_profit_ind_N;
end;

slimrec mapaaw(old_stats l, new_stats r) := transform
 self.counter_  := 75;
 self.condition := 'has_corp_for_profit_ind_other';
 self.old_val   := (string10)l.has_corp_for_profit_ind_other;
 self.new_val   := (string10)r.has_corp_for_profit_ind_other;
 self.delta     := l.has_corp_for_profit_ind_other - r.has_corp_for_profit_ind_other;
end;

slimrec mapaax(old_stats l, new_stats r) := transform
 self.counter_  := 76;
 self.condition := 'has_corp_sic_code';
 self.old_val   := (string10)l.has_corp_sic_code;
 self.new_val   := (string10)r.has_corp_sic_code;
 self.delta     := l.has_corp_sic_code - r.has_corp_sic_code;
end;

slimrec mapaay(old_stats l, new_stats r) := transform
 self.counter_  := 77;
 self.condition := 'has_corp_orig_bus_type_cd';
 self.old_val   := (string10)l.has_corp_orig_bus_type_cd;
 self.new_val   := (string10)r.has_corp_orig_bus_type_cd;
 self.delta     := l.has_corp_orig_bus_type_cd - r.has_corp_orig_bus_type_cd;
end;

slimrec mapaaz(old_stats l, new_stats r) := transform
 self.counter_  := 78;
 self.condition := 'has_corp_orig_bus_type_desc';
 self.old_val   := (string10)l.has_corp_orig_bus_type_desc;
 self.new_val   := (string10)r.has_corp_orig_bus_type_desc;
 self.delta     := l.has_corp_orig_bus_type_desc - r.has_corp_orig_bus_type_desc;
end;

slimrec mapaaaa(old_stats l, new_stats r) := transform
 self.counter_  := 79;
 self.condition := 'has_corp_ra_name';
 self.old_val   := (string10)l.has_corp_ra_name;
 self.new_val   := (string10)r.has_corp_ra_name;
 self.delta     := l.has_corp_ra_name - r.has_corp_ra_name;
end;

slimrec mapaaab(old_stats l, new_stats r) := transform
 self.counter_  := 80;
 self.condition := 'has_corp_ra_title_cd';
 self.old_val   := (string10)l.has_corp_ra_title_cd;
 self.new_val   := (string10)r.has_corp_ra_title_cd;
 self.delta     := l.has_corp_ra_title_cd - r.has_corp_ra_title_cd;
end;

slimrec mapaaac(old_stats l, new_stats r) := transform
 self.counter_  := 81;
 self.condition := 'has_corp_ra_title_desc';
 self.old_val   := (string10)l.has_corp_ra_title_desc;
 self.new_val   := (string10)r.has_corp_ra_title_desc;
 self.delta     := l.has_corp_ra_title_desc - r.has_corp_ra_title_desc;
end;

slimrec mapaaad(old_stats l, new_stats r) := transform
 self.counter_  := 82;
 self.condition := 'has_corp_ra_fein';
 self.old_val   := (string10)l.has_corp_ra_fein;
 self.new_val   := (string10)r.has_corp_ra_fein;
 self.delta     := l.has_corp_ra_fein - r.has_corp_ra_fein;
end;

slimrec mapaaae(old_stats l, new_stats r) := transform
 self.counter_  := 83;
 self.condition := 'has_corp_ra_ssn';
 self.old_val   := (string10)l.has_corp_ra_ssn;
 self.new_val   := (string10)r.has_corp_ra_ssn;
 self.delta     := l.has_corp_ra_ssn - r.has_corp_ra_ssn;
end;

slimrec mapaaaf(old_stats l, new_stats r) := transform
 self.counter_  := 84;
 self.condition := 'has_corp_ra_dob';
 self.old_val   := (string10)l.has_corp_ra_dob;
 self.new_val   := (string10)r.has_corp_ra_dob;
 self.delta     := l.has_corp_ra_dob - r.has_corp_ra_dob;
end;

slimrec mapaaag(old_stats l, new_stats r) := transform
 self.counter_  := 85;
 self.condition := 'has_corp_ra_effective_date';
 self.old_val   := (string10)l.has_corp_ra_effective_date;
 self.new_val   := (string10)r.has_corp_ra_effective_date;
 self.delta     := l.has_corp_ra_effective_date - r.has_corp_ra_effective_date;
end;

slimrec mapaaah(old_stats l, new_stats r) := transform
 self.counter_  := 86;
 self.condition := 'bad_corp_ra_effective_date_ct';
 self.old_val   := (string10)l.bad_corp_ra_effective_date_ct;
 self.new_val   := (string10)r.bad_corp_ra_effective_date_ct;
 self.delta     := [];
end;

slimrec mapaaai(old_stats l, new_stats r) := transform
 self.counter_  := 87;
 self.condition := 'has_corp_ra_address_type_cd';
 self.old_val   := (string10)l.has_corp_ra_address_type_cd;
 self.new_val   := (string10)r.has_corp_ra_address_type_cd;
 self.delta     := l.has_corp_ra_address_type_cd - r.has_corp_ra_address_type_cd;
end;

slimrec mapaaaj(old_stats l, new_stats r) := transform
 self.counter_  := 88;
 self.condition := 'has_corp_ra_address_type_desc';
 self.old_val   := (string10)l.has_corp_ra_address_type_desc;
 self.new_val   := (string10)r.has_corp_ra_address_type_desc;
 self.delta     := l.has_corp_ra_address_type_desc - r.has_corp_ra_address_type_desc;
end;

slimrec mapaaak(old_stats l, new_stats r) := transform
 self.counter_  := 89;
 self.condition := 'has_corp_ra_address_line1';
 self.old_val   := (string10)l.has_corp_ra_address_line1;
 self.new_val   := (string10)r.has_corp_ra_address_line1;
 self.delta     := l.has_corp_ra_address_line1 - r.has_corp_ra_address_line1;
end;

slimrec mapaaal(old_stats l, new_stats r) := transform
 self.counter_  := 90;
 self.condition := 'has_corp_ra_address_line2';
 self.old_val   := (string10)l.has_corp_ra_address_line2;
 self.new_val   := (string10)r.has_corp_ra_address_line2;
 self.delta     := l.has_corp_ra_address_line2 - r.has_corp_ra_address_line2;
end;

slimrec mapaaam(old_stats l, new_stats r) := transform
 self.counter_  := 91;
 self.condition := 'has_corp_ra_address_line3';
 self.old_val   := (string10)l.has_corp_ra_address_line3;
 self.new_val   := (string10)r.has_corp_ra_address_line3;
 self.delta     := l.has_corp_ra_address_line3 - r.has_corp_ra_address_line3;
end;

//slimrec mapaaan(old_stats l, new_stats r) := transform
// self.counter_  := 92;
// self.condition := 'has_corp_ra_phone_number';
// self.old_val   := (string10)l.has_corp_ra_phone_number;
// self.new_val   := (string10)r.has_corp_ra_phone_number;
// self.delta     := l.has_corp_ra_phone_number - r.has_corp_ra_phone_number;
//end;

//slimrec mapaaao(old_stats l, new_stats r) := transform
// self.counter_  := 93;
// self.condition := 'has_corp_ra_phone_number_type_cd';
// self.old_val   := (string10)l.has_corp_ra_phone_number_type_cd;
// self.new_val   := (string10)r.has_corp_ra_phone_number_type_cd;
// self.delta     := l.has_corp_ra_phone_number_type_cd - r.has_corp_ra_phone_number_type_cd;
//end;

//slimrec mapaaap(old_stats l, new_stats r) := transform
// self.counter_  := 94;
// self.condition := 'has_corp_ra_phone_number_type_desc';
// self.old_val   := (string10)l.has_corp_ra_phone_number_type_desc;
// self.new_val   := (string10)r.has_corp_ra_phone_number_type_desc;
// self.delta     := l.has_corp_ra_phone_number_type_desc - r.has_corp_ra_phone_number_type_desc;
//end;

//slimrec mapaaaq(old_stats l, new_stats r) := transform
// self.counter_  := 95;
// self.condition := 'has_corp_ra_email_address';
// self.old_val   := (string10)l.has_corp_ra_email_address;
// self.new_val   := (string10)r.has_corp_ra_email_address;
// self.delta     := l.has_corp_ra_email_address - r.has_corp_ra_email_address;
//end;

//slimrec mapaaar(old_stats l, new_stats r) := transform
// self.counter_  := 96;
// self.condition := 'has_corp_ra_web_address';
// self.old_val   := (string10)l.has_corp_ra_web_address;
// self.new_val   := (string10)r.has_corp_ra_web_address;
// self.delta     := l.has_corp_ra_web_address - r.has_corp_ra_web_address;
//end;


a     := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapa(left,right),lookup);
b     := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapb(left,right),lookup);
c     := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapc(left,right),lookup);
d     := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapd(left,right),lookup);
e     := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mape(left,right),lookup);
//f     := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapf(left,right),lookup);
g     := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapg(left,right),lookup);
h     := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,maph(left,right),lookup);
i     := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapi(left,right),lookup);
j     := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapj(left,right),lookup);
k     := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapk(left,right),lookup);
l     := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapl(left,right),lookup);
m     := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapm(left,right),lookup);
n     := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapn(left,right),lookup);
//o     := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapo(left,right),lookup);
//p     := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapp(left,right),lookup);
//q     := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapq(left,right),lookup);
//r     := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapr(left,right),lookup);
//s     := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,maps(left,right),lookup);
//t     := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapt(left,right),lookup);
//u     := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapu(left,right),lookup);
//v     := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapv(left,right),lookup);
//w     := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapw(left,right),lookup);
//x     := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapx(left,right),lookup);
//y     := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapy(left,right),lookup);
//z     := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapz(left,right),lookup);
//aa    := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapaa(left,right),lookup);
//ab    := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapab(left,right),lookup);
ac    := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapac(left,right),lookup);
ad    := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapad(left,right),lookup);
ae    := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapae(left,right),lookup);
af    := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapaf(left,right),lookup);
ag    := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapag(left,right),lookup);
ah    := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapah(left,right),lookup);
ai    := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapai(left,right),lookup);
aj    := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapaj(left,right),lookup);
ak    := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapak(left,right),lookup);
//al    := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapal(left,right),lookup);
//am    := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapam(left,right),lookup);
an    := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapan(left,right),lookup);
ao    := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapao(left,right),lookup);
ap    := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapap(left,right),lookup);
aq    := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapaq(left,right),lookup);
ar    := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapar(left,right),lookup);
as_   := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapas(left,right),lookup);
at    := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapat(left,right),lookup);
au    := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapau(left,right),lookup);
av    := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapav(left,right),lookup);
aw    := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapaw(left,right),lookup);
ax    := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapax(left,right),lookup);
ay    := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapay(left,right),lookup);
az    := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapaz(left,right),lookup);
aaa   := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapaaa(left,right),lookup);
aab   := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapaab(left,right),lookup);
aac   := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapaac(left,right),lookup);
aad   := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapaad(left,right),lookup);
aae   := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapaae(left,right),lookup);
aaf   := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapaaf(left,right),lookup);
aag   := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapaag(left,right),lookup);
aah   := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapaah(left,right),lookup);
aai   := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapaai(left,right),lookup);
aaj   := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapaaj(left,right),lookup);
aak   := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapaak(left,right),lookup);
aal   := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapaal(left,right),lookup);
aam   := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapaam(left,right),lookup);
aan   := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapaan(left,right),lookup);
aao   := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapaao(left,right),lookup);
aap   := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapaap(left,right),lookup);
aaq   := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapaaq(left,right),lookup);
aar   := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapaar(left,right),lookup);
aas   := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapaas(left,right),lookup);
aat   := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapaat(left,right),lookup);
aau   := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapaau(left,right),lookup);
aav   := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapaav(left,right),lookup);
aaw   := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapaaw(left,right),lookup);
aax   := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapaax(left,right),lookup);
aay   := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapaay(left,right),lookup);
aaz   := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapaaz(left,right),lookup);
aaaa  := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapaaaa(left,right),lookup);
aaab  := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapaaab(left,right),lookup);
aaac  := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapaaac(left,right),lookup);
aaad  := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapaaad(left,right),lookup);
aaae  := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapaaae(left,right),lookup);
aaaf  := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapaaaf(left,right),lookup);
aaag  := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapaaag(left,right),lookup);
aaah  := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapaaah(left,right),lookup);
aaai  := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapaaai(left,right),lookup);
aaaj  := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapaaaj(left,right),lookup);
aaak  := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapaaak(left,right),lookup);
aaal  := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapaaal(left,right),lookup);
aaam  := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapaaam(left,right),lookup);
aaan  := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapaaan(left,right),lookup);
aaao  := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapaaao(left,right),lookup);
aaap  := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapaaap(left,right),lookup);
//aaaq  := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapaaaq(left,right),lookup);
//aaar  := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapaaar(left,right),lookup);

concat := sort(a+b+c+d+e
              //+f
			  +g+h+i+j+k+l+m+n
              //+o+p+q+r+s+t+u+v+w+x+y+z+aa+ab
              +ac+ad+ae+af+ag+ah+ai+aj+ak
			  //+al+am
			  +an+ao+ap+aq+ar+as_+at+au+av+aw+ax+ay+az
			  +aaa+aab+aac+aad+aae+aaf+aag+aah+aai+aaj+aak+aal+aam+aan+aao+aap+aaq+aar+aas+aat+aau+aav+aaw+aax+aay+aaz
			  +aaaa+aaab+aaac+aaad+aaae+aaaf+aaag+aaah+aaai+aaaj+aaak+aaal+aaam+aaan+aaao+aaap
			  //+aaaq+aaar
			  ,counter_);
output(concat);
*/	  