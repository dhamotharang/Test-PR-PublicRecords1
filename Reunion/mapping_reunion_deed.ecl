import address;

EXPORT mapping_reunion_deed(unsigned1 mode, STRING sVersion) := MODULE

deed := reunion.deeds(mode);

reunion.layouts.l_deed t1(deed le) := transform
 self.main_adl             := intformat(le.did,12,1);
 self.state                := le.state;
 self.county               := le.county_name;
 self.apn                  := le.apnt_or_pin_number;
 self.owner1               := le.name1;
 self.owner2               := le.name2;
 self.seller1              := le.seller1;
 self.seller2              := le.seller2;
 self.property_street      := address.Addr1FromComponents(le.pro_prim_range,le.pro_predir,le.pro_prim_name,le.pro_suffix,le.pro_postdir,le.pro_unit_desig,le.pro_sec_range);
 self.property_city        := le.pro_v_city_name;
 self.property_st          := le.pro_st;
 self.property_zip         := le.pro_zip+if(le.pro_zip4<>'','-'+le.pro_zip4,'');
 self.owner_street         := address.Addr1FromComponents(le.own_prim_range,le.own_predir,le.own_prim_name,le.own_suffix,le.own_postdir,le.own_unit_desig,le.own_sec_range);
 self.owner_city           := le.own_v_city_name;
 self.owner_st             := le.own_st;
 self.owner_zip            := le.own_zip+if(le.own_zip4<>'','-'+le.own_zip4,'');
 self.document_type        := le.document_type_code_decoded;
 self.document_number      := le.document_number;
 self.recorder_book        := le.recorder_book_number;
 self.recorder_page        := le.recorder_page_number;
 self.recording_date       := le.recording_date;
 self.sale_date            := le.contract_date;
 self.sales_price          := le.sales_price;
 self.loan_amount          := le.first_td_loan_amount;
 self.interest_rate        := le.first_td_interest_rate;
 self.term                 := if(le.loan_term_years<>'',le.loan_term_years,le.loan_term_months);
 self.term_ind             := if(le.loan_term_years<>'','Y',if(le.loan_term_months<>'','M',''));
 self.lender               := le.lender_name;
 self.rate_change          := le.rate_change_frequency_decoded;
 self.title_company        := le.title_company_name;
 self.type_financing       := le.type_financing_decoded;
 self.adjustable_index     := le.adjustable_rate_index;
 self.change_index         := le.change_index;
 self.due_date             := le.first_td_due_date;
 self.lender_type          := le.lender_type_decoded;
 self.loan_type            := le.loan_type_decoded;
 self.property_use         := le.property_use_decoded;
 self.land_use             := le.assessment_match_land_use_decoded;
 self.lot_size             := le.land_lot_size;
 self.legal_description    := le.legal_brief_description;
end;

EXPORT all := dedup(project(deed, t1(left)),record,all);

END;