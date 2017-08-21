EXPORT Layout_Corporate_Direct_Stock_Base_Expanded := record
	unsigned6 	bdid := 0;       
	unsigned4 	dt_first_seen;
	unsigned4 	dt_last_seen;
	unsigned4 	dt_vendor_first_reported;
	unsigned4 	dt_vendor_last_reported;
	Layout_Corporate_Direct_Stock_In;
	string250		stock_stock_description;
	string250		stock_stock_series;
	string1			stock_non_par_value_flag;
	string1			stock_additional_stock;
	unsigned8		stock_shares_proportion_to_ohio_for_foreign_license;
	unsigned8		stock_share_credits;
	unsigned8		stock_authorized_capital;
	unsigned8		stock_stock_paid_in_capital;
	string1			stock_pay_higher_stock_fees;
	unsigned8		stock_actual_amt_invested_in_state;
	string1			stock_share_exchange_during_merger;
	string8			stock_date_stock_limit_approved;
	unsigned8		stock_number_of_shares_paid_for;
	unsigned8		stock_total_value_of_shares_paid_for;
	unsigned8		stock_sharesofbeneficialinterest;
	unsigned8		stock_beneficialsharevalue;
	STRING1   	record_type;	// 'C' Current
														// 'H' Historical	
end;