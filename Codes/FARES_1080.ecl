export FARES_1080 := 
MODULE
	export VARSTRING PROPERTY_INDICATOR_CODE(string code) :=
		 CASE(code,
						'00' => 'MISCELLANEOUS',
						'10' => 'SINGLE FAMILY RESIDENCE',
						'11' => 'CONDOMINIUM (RESIDENTIAL)',
						'20' => 'COMMERCIAL',
						'21' => 'DUPLEX (TRIPLEX QUADPLEX)',
						'22' => 'APARTMENT',
						'23' => 'HOTEL MOTEL',
						'24' => 'COMMERCIAL CONDOMINIUM',
						'25' => 'RETAIL STORE',
						'26' => 'SERVICE (GENERAL PUBLIC)',
						'27' => 'OFFICE BUILDING',
						'28' => 'WAREHOUSE',
						'29' => 'FINANCIAL INSTITUTION',
						'30' => 'HOSPITAL (MEDICAL COMPLEX)',
						'31' => 'PARKING',
						'32' => 'AMUSEMENT RECREATION',
						'50' => 'INDUSTRIAL',
						'51' => 'INDUSTRIAL LIGHT',
						'52' => 'INDUSTRIAL HEAVY',
						'53' => 'TRANSPORT',
						'54' => 'UTILITIES',
						'70' => 'AGRIGULTURAL',
						'80' => 'VACANT',
						'90' => 'EXEMPT',
						'');
						
	export VARSTRING MORTGAGE_LOAN_TYPE_CODE(string code) :=
		 CASE(code,						
						'WRP' => 'WRAP AROUND MORTGAGE',
						'CDA' => 'COMMUNITY DEVELOPMENT AUTHORITY',
						'CNV' => 'CONVENTIONAL',
						'FHA' => 'FEDERAL HOUSING AUTHORITY',
						'LHM' => 'LEASE HOLD MORTGAGE',
						'PP' => 'PRIVATE PARTY LENDER',
						'SBA' => 'SMALL BUSINESS ADMINISTRATION',
						'VA' => 'VETERANS ADMINISTRATION',
						'');

	export VARSTRING	DOCTYPE(string code, string vendor) :=
		if (vendor = 'FAR_F',
				case(code,'G' => 'GRANT DEED',
						'N' => 'NOTICE OF DEFAULT',
						'Q' => 'QUIT CLAIM',
						'S' => 'LOAN ASSIGNMENT',
						'T' => 'DEED OF TRUST',
						'U' => 'FORECLOSURE',
						'X' => 'MULTI CNTY/ST OR OPEN END MORTGAGE',
						'D' => 'RELEASE OF MORTGAGE/DEED OF TRUST',
						'R' => 'RELEASE OF LIS PENDENS',
						'F' => 'FINAL JUDGEMENT',
						'L' => 'LIS PENDENS',
						'Z' => 'NOMINAL',
						''),
				case(code,'G' => 'GRANT DEED',
						'N' => 'NOTICE OF DEFAULT',
						'Q' => 'QUIT CLAIM',
						'S' => 'LOAN ASSIGNMENT',
						'T' => 'DEED OF TRUST',
						'U' => 'FORECLOSURE',
						'X' => 'MULTI CNTY/ST OR OPEN END MORTGAGE',
						'D' => 'RELEASE OF MORTGAGE/DEED OF TRUST',
						'R' => 'RELEASE OF LIS PENDENS',
						'F' => 'FINAL JUDGEMENT',
						'L' => 'LIS PENDENS',
						'Z' => 'NOMINAL',
						''));


	export VARSTRING	TRANSACTION_TYPE(string code, string vendor) :=
		if (vendor = 'FAR_F',
				case(code,'1' => 'RESALE',
						'2' => 'REFINANCE',
						'3' => 'SUBDIVISION/NEW CONSTRUCTION',
						'4' => 'TIMESHARE',
						'6' => 'CONSTRUCTION LOAD',
						'7' => 'SELLER CARRYBACK',
						'9' => 'NOMINAL',
						'D' => 'Release of Mortgage/Deed of Trust',
						'S' => 'Assignment',
						''),
				case(code,'1' => 'RESALE',
						'2' => 'REFINANCE',
						'3' => 'SUBDIVISION/NEW CONSTRUCTION',
						'4' => 'TIMESHARE',
						'6' => 'CONSTRUCTION LOAD',
						'7' => 'SELLER CARRYBACK',
						'9' => 'NOMINAL',
						'D' => 'Release of Mortgage/Deed of Trust',
						'S' => 'Assignment',
						''));

	export VARSTRING EQUITY_FLAG(string code, string vendor) :=
		if (vendor = 'FAR_F',
				case(code,'S' => 'EQUITY LOAN',
						''),
				case(code,'S' => 'EQUITY LOAN',
						''));

	export VARSTRING REFI_FLAG(string code, string vendor) :=
		if (vendor = 'FAR_F',
				case(code,'T' => 'REFINANCE',
				          'U' => 'OTHER SUBORDINATE LOAN',
						''),
				case(code,'T' => 'REFINANCE',
				          'U' => 'OTHER SUBORDINATE LOAN',
						''));
						
	export VARSTRING FORECLOSURE(string code, string vendor) :=
		if (vendor = 'FAR_F',
				case(code,'O' => 'REO (REPOSESSION)',
				          'P' => 'REO SALE (LENDER DISPOSITION)',
						''),
				case(code,'O' => 'REO (REPOSESSION)',
				          'P' => 'REO SALE (LENDER DISPOSITION)',
						''));


export checkChanges :=
	FUNCTION
		
	codes.Layout_Codes_V3 trans(codes.File_Codes_V3_in le) :=
		TRANSFORM
			translation := 
				MAP(le.field_name = 'PROPERTY_INDICATOR_CODE'	=>	PROPERTY_INDICATOR_CODE(le.code),
				    le.field_name = 'MORTGAGE_LOAN_TYPE_CODE'	=>	MORTGAGE_LOAN_TYPE_CODE(le.code),
                        le.field_name = 'DOCUMENT_TYPE'			=>	DOCTYPE(le.code, le.field_name2),
				    le.field_name = 'TRANSACTION_TYPE'            =>   TRANSACTION_TYPE(le.code, le.field_name2),
				    le.field_name = 'EQUITY_FLAG'                 =>   EQUITY_FLAG(le.code, le.field_name2),
				    le.field_name = 'REFI_FLAG'                   =>   REFI_FLAG(le.code, le.field_name2),
				    le.field_name = 'FORECLOSURE'                 =>   FORECLOSURE(le.code, le.field_name2),
				    '');
				  
			SELF.code := IF(stringlib.StringCleanSpaces(le.long_desc)=
                               stringlib.StringCleanSpaces(translation),SKIP,le.code);
			SELF := le;
		END;
	
	p := PROJECT(codes.File_Codes_V3_in(file_name='FARES_1080'
	,field_name in ['PROPERTY_INDICATOR_CODE','MORTGAGE_LOAN_TYPE_CODE','UNIVERSAL_LUSE_CODE','DOCUMENT_TYPE']
	//**
	),trans(LEFT));
	RETURN p;
		
	END;

END;