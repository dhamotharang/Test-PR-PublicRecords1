EXPORT Macros := MODULE
	
	EXPORT Mac_Median(inrec, outvalue, median_field) := MACRO
		#uniquename(temp_rec);
		#uniquename(inrec_srtd);
		#uniquename(inrec_count);

		%temp_rec% := record
			integer field;
		end;
		
		%inrec_srtd% := SORT(PROJECT(inrec , TRANSFORM(%temp_rec% , SELF.field := (integer)LEFT.median_field)), field);
		%inrec_count% := COUNT(%inrec_srtd%);
		
		outvalue := IF(%inrec_count%%2=0, ((%inrec_srtd%[%inrec_count%/2].field + %inrec_srtd%[%inrec_count%/2+1].field) / 2), %inrec_srtd%[%inrec_count%/2+1].field);
	ENDMACRO;

	EXPORT mac_ListBusAccounts := MACRO
			'Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported'
	ENDMACRO;

	EXPORT mac_JoinBusAccounts := MACRO
			(
				KEYED(LEFT.Sbfe_Contributor_Number = RIGHT.Sbfe_Contributor_Number) AND
				KEYED(LEFT.Contract_Account_Number = RIGHT.Contract_Account_Number) AND
				KEYED(LEFT.Account_Type_Reported 	 = RIGHT.Account_Type_Reported)
			)
	ENDMACRO;
	
END;
