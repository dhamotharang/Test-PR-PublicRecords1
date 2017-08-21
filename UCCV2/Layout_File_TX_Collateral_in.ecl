export Layout_File_TX_Collateral_in
		:= record
				string8    process_date;
				string1    transaction_code;
				string12   original_filing_number;
				string10   ucc3_filing_number;
				string6    collateral_line_sequence_number;
				string80   collateral_description;
				string512  all_collateral;
			end;