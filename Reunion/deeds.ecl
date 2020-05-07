import ln_propertyv2, D2C_Customers;

ds_deed := ln_propertyv2.File_Deed(vendor_source_flag in ['D','O']);

r1 := record
 ds_deed.vendor_source_flag;
 ds_deed.ln_fares_id;
 ds_deed.current_record;
 ds_deed.state;
 ds_deed.county_name;
 ds_deed.apnt_or_pin_number;
 ds_deed.name1;
 ds_deed.name2;
 ds_deed.seller1;
 ds_deed.seller2;
 ds_deed.document_type_code;
 ds_deed.document_number;
 ds_deed.recorder_book_number;
 ds_deed.recorder_page_number;
 ds_deed.recording_date;
 ds_deed.contract_date;
 ds_deed.sales_price;
 ds_deed.first_td_loan_amount;
 ds_deed.first_td_interest_rate;
 ds_deed.loan_term_years;
 ds_deed.loan_term_months;
 ds_deed.lender_name;
 ds_deed.rate_change_frequency;
 ds_deed.title_company_name;
 ds_deed.type_financing;
 ds_deed.adjustable_rate_index;
 ds_deed.change_index;
 ds_deed.first_td_due_date;
 ds_deed.first_td_lender_type_code;
 ds_deed.first_td_loan_type_code;
 ds_deed.property_use_code;
 ds_deed.assessment_match_land_use_code;
 ds_deed.land_lot_size;
 ds_deed.legal_brief_description;
 string70 document_type_code_decoded        :='';
 string30 rate_change_frequency_decoded     :='';
 string30 type_financing_decoded            :='';
 string30 lender_type_decoded               :='';
 string40 loan_type_decoded                 :='';
 string45 property_use_decoded              :='';
 string80 assessment_match_land_use_decoded :='';
end;

r1 t1(ds_deed le) := transform
 self.document_type_code_decoded        := reunion.lookups.lookup_deed_document_type (le.document_type_code);
 self.rate_change_frequency_decoded     := reunion.lookups.lookup_deed_rate_change   (le.rate_change_frequency);
 self.type_financing_decoded            := reunion.lookups.lookup_deed_type_financing(le.type_financing);
 self.lender_type_decoded               := reunion.lookups.lookup_deed_lender_type   (le.first_td_lender_type_code);
 self.loan_type_decoded                 := reunion.lookups.lookup_deed_loan_type     (le.first_td_loan_type_code);
 self.property_use_decoded              := reunion.lookups.lookup_deed_property_use  (le.property_use_code);
 self.assessment_match_land_use_decoded := reunion.lookups.lookup_tax_land_use       (le.assessment_match_land_use_code);
 self                                   := le;
end;

p1        := distribute(project(ds_deed,t1(left)),hash(ln_fares_id));
srch_dist := distribute(reunion.property_search1(ln_fares_id2[2] in ['D','M'] and D2C_Customers.SRC_Allowed.Check(20, ln_fares_id2)),hash(ln_fares_id2));

r2 := record
 p1;
 srch_dist;
end;

r2 t2(p1 le, srch_dist ri) := transform
 self := le;
 self := ri;
end;

j1 := join(p1,srch_dist,left.ln_fares_id=right.ln_fares_id2,t2(left,right),local);
						  
current_owners := ln_propertyv2.key_addr_fid_prep(source_code='OP' and owner=true and ln_owner=true and ln_fares_id[2] in ['D','M']);

j1_dist             := distribute(j1,            hash(ln_fares_id));
current_owners_dist := distribute(current_owners,hash(ln_fares_id));

recordof(j1_dist) t3(j1_dist le, current_owners_dist ri) := transform
 self := le;
end;

//need to add name elements in the situation where, if there 
//are originally 2 parties and only 1 of them retains ownership
//mark and jessica at 2492 southrider -> ln_fares_id OD0005842389
//the code below still does not solve the issue where 2 people w/ the
//the same First initial (Mark and Mary)

j2 := join(j1_dist,current_owners_dist,
           left.ln_fares_id = right.ln_fares_id and
		   left.lname       = right.lname,
		   t3(left,right),
		   keep(1),
		   local
		  );

export deeds(unsigned1 mode) := j2 : persist('persist::reunion_deeds::' + reunion.Constants.sMode(mode));