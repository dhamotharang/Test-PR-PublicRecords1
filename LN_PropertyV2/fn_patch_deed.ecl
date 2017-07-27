//bug 25396 - nameasis in search would begin w/ a leading ", "

import ln_property,LN_PropertyV2;

//fn_handle_zeroes(string in_field) := if(regexfind('^[0]{2,}$',in_field) or (integer)in_field=0,'',(string)(integer)in_field);
//regexreplace useful for fields that have numeric value followed by some type of labeling (e.g. 8000 SF)
fn_handle_zeroes(string in_field) := if((integer)in_field=0,'',regexreplace('^0*',trim(in_field,left,right),''));

export fn_patch_deed(dataset(recordof(LN_PropertyV2.layout_deed_mortgage_common_model_base)) in_deed0,
                     dataset(recordof(LN_PropertyV2.layout_addl_fares_deed)) in_addl_fares_deed0
					) :=
function

in_deed            := distribute(in_deed0,hash(ln_fares_id));
in_addl_fares_deed := distribute(in_addl_fares_deed0(fares_mortgage_term<>''),hash(ln_fares_id));

//bug 27829
r1 := record
 in_deed;
 in_addl_fares_deed.fares_mortgage_term_code;
 in_addl_fares_deed.fares_mortgage_term;
end;

r1 t_j1(in_deed le, in_addl_fares_deed ri) := transform
 self := le;
 self := ri;
end;

j1 := join(in_deed,in_addl_fares_deed,
           left.ln_fares_id=right.ln_fares_id,
		   t_j1(left,right),
		   left outer, local
		  );
 
recordof(in_deed) t_suppress_zeroes(j1 l) := transform

    string v_fares_mortgage_term      := if(regexfind('[A-Z]',l.fares_mortgage_term),'',(string)(integer)l.fares_mortgage_term);
	string v_fares_mortgage_term_code := trim(l.fares_mortgage_term_code);
	
	//look for various values that mean MONTHLY value
	string v_term2 := if(regexfind('M',v_fares_mortgage_term_code),(string)((integer)v_fares_mortgage_term div 12),v_fares_mortgage_term);
    
	self.fips_code									   := fn_handle_zeroes(l.fips_code);
	self.process_date								   := fn_handle_zeroes(l.process_date);
	//important: lexis deed and mortage files have overlapping codes but different meanings.
	//codes_v3 references a single field so we're manipulating the overlapping mortgage codes
	//to define some uniqueness during the lookup
	self.record_type                                   := if(l.from_file='M' and l.vendor_source_flag in ['D','O'],
	                                                       case(l.record_type,
														    'C' => 'C-M',
															'R' => 'R-M',
															'X' => 'X-M',
															l.record_type),
														  l.record_type);
	self.tax_id_number								   := fn_handle_zeroes(l.tax_id_number);
	self.excise_tax_number						       := fn_handle_zeroes(l.excise_tax_number);
	self.phone_number								   := fn_handle_zeroes(l.phone_number);
	self.contract_date								   := fn_handle_zeroes(l.contract_date);
	self.recording_date								   := fn_handle_zeroes(l.recording_date);
	self.arm_reset_date								   := fn_handle_zeroes(l.arm_reset_date);
	self.document_number							   := fn_handle_zeroes(l.document_number);
	self.loan_number								   := fn_handle_zeroes(l.loan_number);
	self.recorder_book_number					       := fn_handle_zeroes(l.recorder_book_number);
	self.recorder_page_number					       := fn_handle_zeroes(l.recorder_page_number);
	self.concurrent_mortgage_book_page_document_number := fn_handle_zeroes(l.concurrent_mortgage_book_page_document_number);
	self.sales_price								   := fn_handle_zeroes(l.sales_price);
	self.city_transfer_tax						       := fn_handle_zeroes(l.city_transfer_tax);
	self.county_transfer_tax					       := fn_handle_zeroes(l.county_transfer_tax);
	self.total_transfer_tax						       := fn_handle_zeroes(l.total_transfer_tax);
	self.first_td_loan_amount					       := fn_handle_zeroes(l.first_td_loan_amount);
	self.second_td_loan_amount				           := fn_handle_zeroes(l.second_td_loan_amount);
	self.first_td_interest_rate				           := fn_handle_zeroes(l.first_td_interest_rate);
	self.partial_interest_transferred                  := fn_handle_zeroes(l.partial_interest_transferred);
	self.loan_term_months							   := fn_handle_zeroes(l.loan_term_months);
	self.loan_term_years							   := fn_handle_zeroes(if(l.loan_term_years<>'',l.loan_term_years,v_term2));
	self.land_lot_size								   := fn_handle_zeroes(l.land_lot_size);
	self.change_index								   := fn_handle_zeroes(l.change_index);
	self.adjustable_rate_index				           := fn_handle_zeroes(l.adjustable_rate_index);
	self											   := l;
end;

patch_zeroes := project(j1, t_suppress_zeroes(left));

recordof(in_deed) t_addl_handling(recordof(in_deed) le) := transform
 self.name1                 := ln_property.fn_patch_name_field(le.name1);
 self.name2                 := ln_property.fn_patch_name_field(le.name2);
 self.seller1               := ln_property.fn_patch_name_field(le.seller1);
 self.seller2               := ln_property.fn_patch_name_field(le.seller2);
 self                       := le;
end;

addl_handling := project(patch_zeroes,t_addl_handling(left));

recordof(in_deed) t_insert_decimals(recordof(in_deed) le) := transform

 string  v_city     := trim(le.city_transfer_tax);
 string  v_county   := trim(le.county_transfer_tax);
 string  v_total    := trim(le.total_transfer_tax);
 string  v_int_rate := trim(le.first_td_interest_rate);
 
 integer v_length_city     := length(v_city);
 integer v_length_county   := length(v_county);
 integer v_length_total    := length(v_total);
 integer v_length_int_rate := length(v_int_rate);
 
 boolean v_length_city_gt_2     := v_length_city   >2;
 boolean v_length_county_gt_2   := v_length_county >2;
 boolean v_length_total_gt_2    := v_length_total  >2;
 boolean v_length_int_rate_gt_2 := v_length_int_rate  >2;

 integer v_length_city_before_decimal     := v_length_city   -2;
 integer v_length_county_before_decimal   := v_length_county -2;
 integer v_length_total_before_decimal    := v_length_total  -2;
 integer v_length_int_rate_before_decimal := v_length_int_rate  -2;

 self.city_transfer_tax      := if(v_length_city_gt_2,  v_city[1..v_length_city_before_decimal]    +'.'+v_city[v_length_city-1..v_length_city],'');
 self.county_transfer_tax    := if(v_length_county_gt_2,v_county[1..v_length_county_before_decimal]+'.'+v_county[v_length_county-1..v_length_county],'');
 self.total_transfer_tax     := if(v_length_total_gt_2, v_total[1..v_length_total_before_decimal]  +'.'+v_total[v_length_total-1..v_length_total],'');
 self.first_td_interest_rate := if(v_length_int_rate_gt_2, v_int_rate[1..v_length_int_rate_before_decimal]  +'.'+v_int_rate[v_length_int_rate-1..v_length_int_rate],'');
 self                        := le;
end;

insert_decimals := project(addl_handling,t_insert_decimals(left));
 
return insert_decimals;

end;