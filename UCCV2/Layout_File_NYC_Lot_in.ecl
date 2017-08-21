export Layout_File_NYC_Lot_in 
     
	    := Record
		
		    string8                   process_date;
			string17                  Unique_Key;
			string1                   record_type;
			string9                   BOROUGH;
			string5                   Block;
			string4                   Lot;
			string1                   Easement;
			string7                   Partial_lot;
			string1                   Air_rights;
			string1                   Subterranean_rights;
			string30                   Property_type;
			string12                  Street_number;
			string32                  Street_name;
			string7                   Addr_unit;
        End;