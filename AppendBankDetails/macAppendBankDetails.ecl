EXPORT macAppendBankDetails(dIn, inRoutingNumber, appendPrefix = '\'\'', UseIndexThreshold=100000000) := FUNCTIONMACRO
	IMPORT hipie_ecl, Bank_Routing;

	//Usually we hit the key after a filter/sort/dedup on the KEYED fields; however, this type of dataset tends to have a huge skew 
	//on the Bank Account (not a huge variety of Bank Account) and the JOIN to get all the records back is very slow so 
	//we are better off with doing a LEFT OUTER on the KEYED JOIN
	LOCAL dBankDetails 		:= hipie_ecl.macJoinKey(dIn , Bank_Routing.key_rtn,
		'KEYED((STRING)LEFT.' + #TEXT(inRoutingNumber) + ' = RIGHT.routing_number_MICR)',
		'(STRING)RIGHT.' + #TEXT(inRoutingNumber) + ' = LEFT.routing_number_MICR',
		UseIndexThreshold,
		JoinType := 'LEFT OUTER',
		KeepOption := TRUE, KeepValue := 1);
		
  LOCAL rOut := RECORD
    RECORDOF(dIn);
    STRING158 #EXPAND(appendPrefix + 'FullBankName');
    STRING50 #EXPAND(appendPrefix + 'AbbreviatedBankName');
    STRING11 #EXPAND(appendPrefix + 'FractionalRoutingNumber');
    STRING9 #EXPAND(appendPrefix + 'HeadOfficeRoutingNumber');
    STRING2 #EXPAND(appendPrefix + 'HeadOfficeBranchCodes');
		INTEGER #EXPAND(appendPrefix + 'Hit');
  END;
	
	LOCAL dOut := PROJECT(dBankDetails,
		TRANSFORM(rOut,
			SELF.#EXPAND(appendPrefix + 'FullBankName') := LEFT.institution_name_full,
			SELF.#EXPAND(appendPrefix + 'AbbreviatedBankName') := LEFT.institution_name_abbreviated,
			SELF.#EXPAND(appendPrefix + 'FractionalRoutingNumber') := LEFT.routing_number_fractional,
			SELF.#EXPAND(appendPrefix + 'HeadOfficeRoutingNumber') := LEFT.head_office_routing_number,
			SELF.#EXPAND(appendPrefix + 'HeadOfficeBranchCodes') := LEFT.head_office_branch_codes,
			SELF.#EXPAND(appendPrefix + 'Hit') := MAP(LEFT.inRoutingNumber <> '' AND LEFT.institution_name_full <> '' => 1,
				LEFT.inRoutingNumber <> '' AND LEFT.institution_name_full = '' => -1,
				0),
			SELF := LEFT));
		
	RETURN dOut;
ENDMACRO;