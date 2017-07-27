export UCC_FILING :=
MODULE

	export VARSTRING FILING_TYPE(string code) := MAP(	
		code='0801' => 'UCC FINANCE STATEMENT FILED',
		code='0802' => 'UCC FINANCE STATEMENT AMENDED',
		code='0803' => 'UCC FINANCE STATEMENT ASSIGNED',
		code='0804' => 'UCC FINANCE STATEMENT PARTIAL RELEASE',
		code='0805' => 'UCC FINANCE STATEMENT FULL RELEASE',
		code='0807' => 'UCC FINANCE STATEMENT RELEASE',
		code='0808' => 'UCC FINANCE STATEMENT TERMINATED',
		code='0809' => 'UCC FINANCE STATEMENT CONTINUED',
		code='0831' => 'UCC FINANCE STATEMENT 10 YEAR LIFE',
		'');
	
	export VARSTRING COL_CODE(string code) := MAP(
		code = '0' => 'UNDEFINED',
		code = '1' => 'ACCOUNTS RECEIVABLE',
		code = '2' => 'APPLIANCES',
		code = '3' => 'CHATTEL PAPER',
		code = '4' => 'EQUIPMENT',
		code = '5' => 'FURNITURE & FIXTURES',
		code = '6' => 'INVENTORY',
		code = '7' => 'LIVESTOCK',
		code = '8' => 'MACHINERY',
		code = '9' => 'HEREAFTER ACQUIRED PROPERTY',
		code = 'A' => 'PRODUCTS',
		code = 'B' => 'SIGN',
		code = 'C' => 'CROPS',
		code = 'D' => 'ACCOUNTS',
		code = 'F' => 'CONTRACT RIGHTS',
		code = 'G' => 'FARM PRODUCTS',
		code = 'H' => 'REAL PROPERTY',
		code = 'I' => 'BUILDINGS',
		code = 'J' => 'CERTAIN DESCRIBED INVENTORY',
		code = 'K' => 'ETC.',
		code = 'L' => 'LEASES',
		code = 'M' => 'FURNISHINGS',
		code = 'N' => 'FISHING VESSELS',
		code = 'O' => 'LOCATED ON CERTAIN REAL PROPERTY',
		code = 'P' => 'AIRCRAFT',
		code = 'Q' => 'VEHICLES',
		code = 'R' => 'TOOLS',
		code = 'S' => 'FISHING GEAR',
		code = 'T' => 'CERTAIN DESCRIBED TIRES',
		code = 'U' => 'NOTES RECEIVABLE',
		code = 'V' => 'CERTAIN DESCRIBED COMPUTER EQUIPMENT',
		code = 'W' => 'ASSIGNMENT OF CERTAIN NOTE',
		code = 'X' => 'FISH',
		code = 'Y' => 'ASSIGNMENT OF CERTAIN LEASE',
		code = 'Z' => 'ASSIGNMENT OF CERTAIN REAL ESTATE CONTRACT',
		'');
	
	export checkChanges := 
	FUNCTION
		
	codes.Layout_Codes_V3 trans(codes.File_Codes_V3_in le) :=
		TRANSFORM
			translation := 
				MAP(le.field_name = 'FILING_TYPE'	   => FILING_TYPE(le.code),
				    le.field_name = 'COLLATERAL_CODE' => COL_CODE(le.code),
				    '');
			
			SELF.code := IF(le.long_desc=translation,SKIP,le.code);
			SELF := le;
		END;
	
	p := PROJECT(codes.File_Codes_V3_in(file_name='UCC_FILING', field_name = 'FILING_TYPE' or field_name = 'COLLATERAL_CODE'),trans(LEFT));
	//ONLY HANDLING FILING_TYPE!!!
	// um....and collateral code.
	RETURN p;
		
	END;

END;