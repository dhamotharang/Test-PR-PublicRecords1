IMPORT Suppress;
	EXPORT Util := MODULE
	
		// Converts binary string (['0', '1']) to boolean ([FALSE, TRUE]) or return default value in case input is not in the range
		EXPORT BOOLEAN binStrToBool(STRING strValue, BOOLEAN defaultValue):= FUNCTION
			RETURN MAP(strValue = '0' => FALSE,
									strValue = '1' => TRUE,
									defaultValue);
		END;
		
		// Return Match codes
		EXPORT STRING1 getMatchCode(STRING subPhone, STRING primaryPhone):= FUNCTION
			RETURN MAP(subPhone = '' => 'X' ,
									subPhone = primaryPhone => 'C',
									'U');
		END;
		
	END;