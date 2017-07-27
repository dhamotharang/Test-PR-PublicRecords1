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
		
		EXPORT STRING toStrMask(UNSIGNED1 mask):= FUNCTION
			SC:= Suppress.constants;
			RETURN	MAP(mask = SC.dateMask.DAY		=>	SC.DATE_MASK_TYPE.DAY,
									mask = SC.dateMask.MONTH	=>	SC.DATE_MASK_TYPE.MONTH,
									mask = SC.dateMask.YEAR		=>	SC.DATE_MASK_TYPE.YEAR,
									mask = SC.dateMask.ALL		=>	SC.DATE_MASK_TYPE.ALL,
																								SC.DATE_MASK_TYPE.NONE);
		END;

	END;