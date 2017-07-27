export CORP2 := module

	export varstring CORP_FOR_PROFIT_IND(string code) := MAP(
				code = 'Y' => 'For Profit',
				code = 'P' => 'For Profit',
				code = 'N' => 'Not For Profit',
				'');

	export varstring CORP_FOREIGN_DOMESTIC_IND(string code) := map(
				code = 'F' => 'Foreign',
				code = 'D' => 'Domestic',
				'');

	export varstring corp_public_or_private_ind(string code) :=map(
			code = '1' => 'Public',
			code = '2' => 'Private',
			'');
	export varstring corp_record_date(string code) := map(
			code = 'C' => 'CURRENT',
			code = 'H' => 'HISTORICAL',
			'');

	export checkChanges := FUNCTION		
	codes.Layout_Codes_V3 trans(codes.File_Codes_V3_in le) :=
		TRANSFORM
			translation := 
				MAP(le.field_name = 'CORP_FOR_PROFIT_IND'	   =>	CORP_FOR_PROFIT_IND(le.code),
				    le.field_name = 'CORP_FOREIGN_DOMESTIC_IND' =>	CORP_FOREIGN_DOMESTIC_IND(le.code),
				'');			    
			SELF.code := IF(le.long_desc=translation,SKIP,le.code);
			SELF := le;
		END;
	
	p := PROJECT(codes.File_Codes_V3_in(file_name='CORP2'),trans(LEFT));
	RETURN p;
		
	END;
	
end;
