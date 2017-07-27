export layout_stocks_out := RECORD
	
	unsigned4 dt_last_seen;
	unsigned4 corp_process_date;
	string5   stock_ticker_symbol;
	string5   stock_exchange;
	string20  stock_type;
	string20  stock_class;
	string15  stock_shares_issued;
	string50  stock_authorized_nbr;
	string15  stock_par_value;
	string15  stock_nbr_par_shares;
	string1   stock_change_ind;
	string8   stock_change_date;
	string1   stock_voting_rights_ind;
	string1   stock_convert_ind;
	string8   stock_convert_date;
	string8   stock_change_in_cap;
	string15  stock_tax_capital;
	string15  stock_total_capital;
	string250  stock_addl_info;
	end;
		