import ln_property,LN_PropertyV2,ut;

fn_handle_zeroes(string in_field) := if((integer)in_field=0,'',regexreplace('^0*',trim(in_field,left,right),''));

export fn_patch_fares_addl_tax(dataset(recordof(LN_PropertyV2.layout_addl_fares_tax)) in_addl_tax) := function

recordof(in_addl_tax) t_cleanup(recordof(in_addl_tax) le) := transform
	self.fares_calculated_land_value				:= fn_handle_zeroes(le.fares_calculated_land_value);
	self.fares_appr_total_value							:= fn_handle_zeroes(le.fares_appr_total_value);
	self.fares_appr_land_value							:= fn_handle_zeroes(le.fares_appr_land_value);
	self.fares_appr_improvement_value				:= fn_handle_zeroes(le.fares_appr_improvement_value);
	self.fares_calculated_improvement_value := fn_handle_zeroes(le.fares_calculated_improvement_value);
	self.fares_calculated_total_value       := fn_handle_zeroes(le.fares_calculated_total_value);
	self.fares_adjusted_gross_square_feet   := fn_handle_zeroes(le.fares_adjusted_gross_square_feet);	
	self.fares_living_square_feet						:= fn_handle_zeroes(le.fares_living_square_feet);
	self.fares_gross_square_feet						:= fn_handle_zeroes(le.fares_gross_square_feet);
	self.fares_garage_square_feet						:= fn_handle_zeroes(le.fares_garage_square_feet);
	self.fares_mortgage_assumption_amt			:= fn_handle_zeroes(le.fares_mortgage_assumption_amt);
	self.fares_second_mortgage_amt					:= fn_handle_zeroes(le.fares_second_mortgage_amt);
	self.fares_prior_mortgage_amount				:= fn_handle_zeroes(le.fares_prior_mortgage_amount);
	self.fares_total_baths_calculated				:= fn_handle_zeroes(le.fares_total_baths_calculated);
	self.fares_no_of_full_baths             := fn_handle_zeroes(le.fares_no_of_full_baths);
	self.fares_no_of_half_baths             := fn_handle_zeroes(le.fares_no_of_half_baths);
	self.fares_no_of_one_qtr_baths					:= fn_handle_zeroes(le.fares_no_of_one_qtr_baths);
	self.fares_no_of_three_qtr_baths				:= fn_handle_zeroes(le.fares_no_of_three_qtr_baths);
	self.fares_no_of_bath_fixtures					:= fn_handle_zeroes(le.fares_no_of_bath_fixtures);
	self                                    := le;

end;

cleanup := project(in_addl_tax,t_cleanup(left));

return cleanup;

end;