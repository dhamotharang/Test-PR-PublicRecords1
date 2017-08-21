export proc_QA(
	// NOTE: These types can be changed to out_dob as needed
	dataset(FidelityProp.layouts.out_dob) inf,
	dataset(FidelityProp.layouts.out_dob) prev
) := FUNCTION

// inf := FidelityProp.files.result;
// prev := FidelityProp.files.result_previous;

mac(f, isNumber = false) := macro
	#uniquename(count_new)
	#uniquename(count_old)
	#if(isNumber)
	%count_new% := count(inf((integer)f <> 0));
	%count_old% := count(prev((integer)f <> 0));
	#else
	%count_new% := count(inf(f <> ''));
	%count_old% := count(prev(f <> ''));
	#end
	output(%count_new%, named('count_new_' + #TEXT(f)));
	output(%count_old%, named('count_old_' + #TEXT(f)));
	output(abs(%count_old% - %count_new%)/%count_old%, named('change_count_' + #TEXT(f)));
	#if(isNumber)
		#uniquename(ave_new)
		#uniquename(ave_old)
		%ave_new% := ave(inf((integer)f > 0), (integer)inf.f);
		%ave_old% := ave(prev((integer)f > 0), (integer)prev.f);
		output(%ave_new%, named('ave_new_' + #TEXT(f)));
		output(%ave_old%, named('ave_old_' + #TEXT(f)));
		output(abs(%ave_old% - %ave_new%)/%ave_old%, named('change_ave_' + #TEXT(f)));
	#end
endmacro;

output(sort(inf(prop__zipcode_1[1..5] = '80209', prop__address_1[1..3] = '550'), prop__address_1), named('new_550'));
output(sort(inf(prop__zipcode_1[1..5] = '80209', prop__address_1[7..11] = 'WASHI'), prop__address_1), named('new_WASHI'));
output(sort(inf(prop__zipcode_1[1..5] = '76710', prop__address_1[1..3] = '392'), prop__address_1), named('new_392'));
output(sort(inf(prop__zipcode_1[1..5] = '80218', prop__address_1[1..3] = '109'), prop__address_1), named('new_109'));

output(sort(prev(prop__zipcode_1[1..5] = '80209', prop__address_1[1..3] = '550'), prop__address_1), named('old_550'));
output(sort(prev(prop__zipcode_1[1..5] = '80209', prop__address_1[7..11] = 'WASHI'), prop__address_1), named('old_WASHI'));
output(sort(prev(prop__zipcode_1[1..5] = '76710', prop__address_1[1..3] = '392'), prop__address_1), named('old_392'));
output(sort(prev(prop__zipcode_1[1..5] = '80218', prop__address_1[1..3] = '109'), prop__address_1), named('old_109'));

mac(parcel__number_1)
mac(name__owner__1_1)
mac(name__owner__2_1)
mac(prop__address_1)
mac(prop__city_1)
mac(prop__state_1)
mac(prop__zipcode_1)
mac(total__value_1, true)
mac(sale__date_1, true)
mac(sale__price_1, true)
mac(name__seller_1)
mac(mortgage__amount_1, true)
mac(assessed__value_1, true)
mac(total__market__value_1, true)
mac(legal__description_1)
mac(fares_transaction_type_code)
mac(fares_transaction_type)
mac(first_td_loan_type_code)
mac(fidelity_transaction_type)
mac(county_code)
mac(county)
mac(subj_first_1)
mac(subj_middle_1)
mac(subj_last_1)
mac(subj_suffix_1)
mac(subj_phone10_1)
mac(subj_name__dual_1)
mac(subj_phone_type_1)
mac(subj_date_first_1)
mac(subj_date_last_1)
mac(owner_1_dob_crim)
mac(owner_2_dob_crim)

return output(if(exists(inf) and exists(prev), 0, -1));

END;