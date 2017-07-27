export EDA_Search_Field_Validate := MACRO

UNSIGNED2 errno := MAP(
		TRIM(queryType_val) = '' => 2003,
		TRIM(state_val) = '' => 2004,
		NOT(queryType_val in ['BG','BR','RS']) => 2100,
		NOT(useFirstInitial_val in ['Y','N']) => 2101,
		NOT(showNonPublished_val in ['Y','N']) => 2102,
		NOT(surroundMiles_val in [0, 10, 25, 50, 100]) => 2104,
		startRow_val=0 => 2106,
		rowsRequested_val=0 => 2107,
		rowsRequested_val>eda_via_xml.max_rowsRequested => 2108,
		LENGTH(Stringlib.StringFilter(bizGovName_val,'*'))>0 => 2109,
		LENGTH(Stringlib.StringFilter(firstName_val,'*'))>0 => 2110,
		LENGTH(Stringlib.StringFilter(lastName_val,'*'))>1 OR
			(LENGTH(Stringlib.StringFilter(lastName_val,'*'))=1 AND (LENGTH(TRIM(lastName_val))<4 OR LENGTH(Stringlib.StringFilter(lastName_val[1..(LENGTH(TRIM(lastName_val))-1)],'*'))>0)) => 2111,
		state_val<>'ALL' AND COUNT(EDA_VIA_XML.Valid_States(st=state_val))=0 =>2112,
		surroundMiles_val>0 AND (TRIM(city_val)='' OR state_val='ALL') => 2118,
		LENGTH(Stringlib.StringFilter(address_val,'*'))>0 => 2119,
		LENGTH(Stringlib.StringFilter(city_val,'*'))>0 => 2120,
		state_val='ALL' AND LENGTH(Stringlib.StringFilter(lastName_val,'*'))>0 => 2121,
		0
	);
	
ENDMACRO;