//bug 25396 - nameasis in search would begin w/ a leading ", "

import ln_property,LN_PropertyV2;

//fn_handle_zeroes(string in_field) := if(regexfind('^[0]{2,}$',in_field) or (integer)in_field=0,'',(string)(integer)in_field);
//regexreplace useful for fields that have numeric value followed by some type of labeling (e.g. 8000 SF)
fn_handle_zeroes(string in_field) := if((integer)in_field=0,'',regexreplace('^0*',trim(in_field,left,right),''));

export fn_patch_tax(dataset(recordof(LN_PropertyV2.layout_property_common_model_base)) in_tax) :=
function

recordof(in_tax) t_suppress_zeroes(recordof(in_tax) l) := transform

    string v_land_dimensions := stringlib.stringtouppercase(l.land_dimensions);
    integer v_x := stringlib.stringfind(v_land_dimensions,'X',1);
	
	string v_1st_part := if(v_x!=0,v_land_dimensions[1..v_x-1],v_land_dimensions);
	string v_2nd_part := if(v_x!=0,v_land_dimensions[v_x+1..20],'');
	
	string v_1st_part2 := (string)(integer)v_1st_part;
	string v_2nd_part2 := (string)(integer)v_2nd_part;

	string v_1st_part3 := if(v_1st_part2='0','',v_1st_part2);
	string v_2nd_part3 := if(v_2nd_part2='0','',v_2nd_part2);
	
	self.fips_code					:= fn_handle_zeroes(l.fips_code);
	self.assessee_phone_number 		:= fn_handle_zeroes(l.assessee_phone_number);
	self.recorder_document_number 	:= fn_handle_zeroes(l.recorder_document_number);
	self.recorder_book_number 		:= fn_handle_zeroes(l.recorder_book_number);
	self.recorder_page_number 		:= fn_handle_zeroes(l.recorder_page_number);
	self.tax_account_number 		:= fn_handle_zeroes(l.tax_account_number);
	self.transfer_date 				:= fn_handle_zeroes(l.transfer_date);
	self.recording_date 			:= fn_handle_zeroes(l.recording_date);
	self.sale_date 					:= fn_handle_zeroes(l.sale_date);
	self.sales_price 				:= fn_handle_zeroes(l.sales_price);
	self.mortgage_loan_amount 		:= fn_handle_zeroes(l.mortgage_loan_amount);
	self.prior_transfer_date 		:= fn_handle_zeroes(l.prior_transfer_date);
	self.prior_recording_date 		:= fn_handle_zeroes(l.prior_recording_date);
	self.prior_sales_price 			:= fn_handle_zeroes(l.prior_sales_price);
	self.assessed_land_value 		:= fn_handle_zeroes(l.assessed_land_value);
	self.assessed_improvement_value := fn_handle_zeroes(l.assessed_improvement_value);
	self.assessed_total_value 		:= fn_handle_zeroes(l.assessed_total_value);
	self.assessed_value_year 		:= fn_handle_zeroes(l.assessed_value_year);	
	//moxie implies 2 decimal places but i'm not sure that's the case (based on the data)
	self.market_land_value 			:= fn_handle_zeroes(l.market_land_value);
	self.market_improvement_value 	:= fn_handle_zeroes(l.market_improvement_value);
	self.market_total_value 		:= fn_handle_zeroes(l.market_total_value);
	self.market_value_year 			:= fn_handle_zeroes(l.market_value_year);
	self.tax_amount 				:= fn_handle_zeroes(l.tax_amount);
	self.tax_year 					:= fn_handle_zeroes(l.tax_year);
	self.tax_delinquent_year 		:= fn_handle_zeroes(l.tax_delinquent_year);
	self.land_acres 				:= fn_handle_zeroes(l.land_acres);
	self.land_square_footage 		:= fn_handle_zeroes(l.land_square_footage);
	self.land_dimensions            := if(v_1st_part3='' and v_2nd_part3='','',v_1st_part3+'X'+v_2nd_part3);
	self.building_area 				:= fn_handle_zeroes(l.building_area);
	self.building_area1 			:= fn_handle_zeroes(l.building_area1);
	self.building_area2 			:= fn_handle_zeroes(l.building_area2);
	self.building_area3 			:= fn_handle_zeroes(l.building_area3);
	self.building_area4 			:= fn_handle_zeroes(l.building_area4);
	self.building_area5 			:= fn_handle_zeroes(l.building_area5);
	self.building_area6 			:= fn_handle_zeroes(l.building_area6);
	self.building_area7 			:= fn_handle_zeroes(l.building_area7);
	self.no_of_buildings 			:= fn_handle_zeroes(l.no_of_buildings);
	self.year_built 				:= fn_handle_zeroes(l.year_built);
	self.effective_year_built 		:= fn_handle_zeroes(l.effective_year_built);
	self.no_of_stories 				:= fn_handle_zeroes(l.no_of_stories);
	self.no_of_units 				:= fn_handle_zeroes(l.no_of_units);
	self.no_of_rooms 				:= fn_handle_zeroes(l.no_of_rooms);
	self.no_of_bedrooms 			:= fn_handle_zeroes(l.no_of_bedrooms);
	self.no_of_baths 				:= fn_handle_zeroes(l.no_of_baths);
	self.no_of_partial_baths 	    := fn_handle_zeroes(l.no_of_partial_baths);
	self.parking_no_of_cars 		:= fn_handle_zeroes(l.parking_no_of_cars);
	self.fireplace_number 			:= if(regexfind('[A-Z]',l.fireplace_number),'',fn_handle_zeroes(l.fireplace_number));
	self.tape_cut_date 				:= fn_handle_zeroes(l.tape_cut_date);
	self.certification_date 		:= fn_handle_zeroes(l.certification_date);
	self.edition_number 			:= fn_handle_zeroes(l.edition_number);
	self.style_code 				:= if(trim(regexreplace('^[0]{2,}',l.style_code,''),left,right) in ['0','1','2','999'],
										trim(l.style_code,left,right),
									   trim(stringlib.stringfilter(l.style_code,'ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ'),left,right));
	self 							:= l;
end;

patch_zeroes := project(in_tax, t_suppress_zeroes(left));

recordof(in_tax) t_addl_handling(recordof(in_tax) le) := transform
 self.assessee_name              := ln_property.fn_patch_name_field(le.assessee_name);
 self.second_assessee_name       := ln_property.fn_patch_name_field(le.second_assessee_name);
 self.assessee_name_type_code    := if(le.vendor_source_flag not in ['F','S'],le.assessee_name_type_code,
                                    if(le.vendor_source_flag     in ['F','S'] and le.assessee_name_type_code in ['C','Y'],le.assessee_name_type_code,
									''));
 self.style_code				 := if(length(trim(le.style_code,left,right)) = 1 or length(trim(le.style_code,left,right)) = 3,
									 trim(le.style_code,left,right),
									'');
 //only lexis sources provide new_record_type_code									
 self.new_record_type_code       := if(trim(le.new_record_type_code,left,right) in ['','DR','MA','MO','MP','SP'],le.new_record_type_code,'');									
 self                            := le;
end;

addl_handling := project(patch_zeroes,t_addl_handling(left));

recordof(in_tax) t_insert_decimals(recordof(in_tax) le) := transform

 string  v_tax_amt                       := trim(le.tax_amount);
 integer v_length_tax_amt                := length(v_tax_amt);
 boolean v_length_tax_amt_gt_2           := v_length_tax_amt   >2;
 integer v_length_tax_amt_before_decimal := v_length_tax_amt   -2;

 string  v_no_of_baths                       := trim(le.no_of_baths);
 integer v_length_no_of_baths                := length(v_no_of_baths);
 boolean v_length_no_of_baths_gt_2           := v_length_no_of_baths   >2;
 integer v_length_no_of_baths_before_decimal := v_length_no_of_baths   -2;
 
 self.tax_amount    := if(v_length_tax_amt_gt_2, v_tax_amt[1..v_length_tax_amt_before_decimal]  +'.'+v_tax_amt[v_length_tax_amt-1..v_length_tax_amt],'');
 self.no_of_baths   := if(v_length_no_of_baths_gt_2, v_no_of_baths[1..v_length_no_of_baths_before_decimal]  +'.'+v_no_of_baths[v_length_no_of_baths-1..v_length_no_of_baths],'');
 self               := le;
end;

insert_decimals := project(addl_handling,t_insert_decimals(left));
 
return insert_decimals;

end;