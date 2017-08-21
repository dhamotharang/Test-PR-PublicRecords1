export Layout_Corporate_Direct_Stock_In := record

string30  corp_key;
string2   corp_vendor;
string3   corp_vendor_county;
string5   corp_vendor_subcode;
string2   corp_state_origin;
string8   corp_process_date;
string32  corp_sos_charter_nbr;

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
string250 stock_addl_info;  //modified length from 98 to 250

end;