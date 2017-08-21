export layout_moxie_WithExpCollateral := record
	string1		record_type; // current/historical
	string1		isDirect;
	string2 		ucc_vendor;
	string8 		ucc_process_date;		
	string50 		ucc_key;
	string20 		event_key;		
	string2 		file_state;
	string32 		orig_filing_num;
	string25 		collateral_type_cd;
	string60 		collateral_type_desc;
	string8 		collateral_status_cd;
	string60		collateral_status_desc;
	string8 		collateral_eff_date;
	string8 		collateral_exp_date;
	string15 		collateral_value_assessed_amt;
	string15 		collateral_qty;
	string8 		collateral_units_cd;
	string60 		collateral_units_desc;
	string8 		collateral_place_cd;
	string60 		collateral_place_desc;
	string512 	collateral_desc;
end;
