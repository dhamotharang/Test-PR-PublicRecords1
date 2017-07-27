IMPORT Address;

EXPORT Layout_Edgar_Company_Single_Address := RECORD
	UNSIGNED8 rcid;
	Layout_Edgar_Company_In;
	STRING1 addr_type;  // 'B' => business or 'M' => mail
	Address.Layout_Address_Clean_Components;
	STRING10 phone10;
END;