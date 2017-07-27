export Layout_UCC_Collateral_In := record
string50  ucc_key;
string2   ucc_vendor;
string2   ucc_state_origin;
string8   ucc_process_date;
//
string20  event_key;
//
string20  collateral_key;
//
string20  party_key;
//
string1   collateral_trans_type;
string8   collateral_trans_date;
//
string8	  collateral_type_cd;
string60  collateral_type_desc;
string8   collateral_status_cd;
string60  collateral_status_desc;
string8   collateral_eff_date;
string8   collateral_exp_date;
string30  collateral_value_cert_num;
string8   collateral_value_cert_date;
string15  collateral_value_assessed_amt;
string15  collateral_value_balance_amt;
string15  collateral_qty;
string8   collateral_units_cd;
string60  collateral_units_desc;
string8   collateral_place_cd;
string60  collateral_place_desc;
//
string512 collateral_desc;
//
//string1    collateral_std_collateral_cd;
end;