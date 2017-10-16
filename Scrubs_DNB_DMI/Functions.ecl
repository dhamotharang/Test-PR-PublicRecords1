IMPORT Scrubs_DNB_DMI, Scrubs;
	
EXPORT Functions := MODULE
		
		EXPORT set_valid_states    := ['AK','AL','AR','AZ','CA','CO','CT','DC','DE','FL','GA','HI','IA','ID','IL','IN',
																   'KS','KY','LA','MA','MD','ME','MI','MN','MO','MS','MT','NC','ND','NE','NH','NJ',
																	 'NM','NV','NY','OH','OK','OR','PA','PR','RI','SC','SD','TN','TX','UT','VA','VI',
																	 'VT','WA','WI','WV','WY',''];	
																	
		
		EXPORT set_valid_industry  := ['A','B','C','D','E','F','G','H','I','J','K','M',''];
	 	
		
		EXPORT invalid_duns(STRING s) := FUNCTION
     	RETURN IF(LENGTH(s) = 9 AND Stringlib.StringFilterOut(s, '0123456789') = '', 1, 0);
    END;
		
		
		EXPORT invalid_sic(STRING s) := FUNCTION
		  RETURN IF(LENGTH(s) in [0,4,8] AND Stringlib.StringFilterOut(s, '0123456789') = '', 1, 0);
		END;
		
    
		EXPORT invalid_zip(STRING s) := FUNCTION
		  RETURN IF(LENGTH(s) in [0,5,9] AND Stringlib.StringFilterOut(s, '0123456789') = '', 1, 0);
		END;


		EXPORT invalid_all_digits(STRING s) := FUNCTION
		  RETURN IF(LENGTH(s) in [0,9] AND Stringlib.StringFilterOut(s, '0123456789') = '', 1, 0);
		END;
		
		
		EXPORT invalid_hierarchy(STRING s) := FUNCTION
		  RETURN IF(Stringlib.StringFilterOut(s, ' 0123456789') = '', 1, 0);
		END;
		
    
		EXPORT invalid_optional_date(STRING s) := FUNCTION
      clean_date  := StringLib.StringFilterOut(s, '/');
			yyyymmdd_date := clean_date[5..8] + clean_date[1..2] + clean_date[3..4];
      isValidDate := IF(LENGTH(yyyymmdd_date) = 8, Scrubs.fn_valid_GeneralDate(yyyymmdd_date) > 0, FALSE);
 			RETURN IF(clean_date = '' OR isValidDate, 1, 0);
    END;
		
		
		EXPORT invalid_report_date(STRING s) := FUNCTION
      yyyymmdd_date := '20' + s[5..6] + s[1..4];
      isValidDate := IF(LENGTH(yyyymmdd_date) = 8, Scrubs.fn_valid_GeneralDate(yyyymmdd_date) > 0, FALSE);
			RETURN IF(s = '000000' OR isValidDate, 1, 0);
    END;
END;

