IMPORT AutoKeyI;

EXPORT AccuityBankData_Constants := MODULE

	EXPORT ErrCode := MODULE
		EXPORT CONFIG_ERR := AutoKeyI.errorcodes._codes.CONFIG_ERR;
		EXPORT INSUFFICIENT_INPUT := AutoKeyI.errorcodes._codes.INSUFFICIENT_INPUT;
	END;

	EXPORT ErrMsg := MODULE
		EXPORT CONFIG_ERR := AutoKeyI.errorcodes._msgs(AutoKeyI.errorcodes._codes.CONFIG_ERR,'DataPermissionMask');
		EXPORT INSUFFICIENT_INPUT := 'Lacking min. input';
	END;

	EXPORT SrchCode := MODULE
		EXPORT BANK_STATE_MATCHED   := 0;
		EXPORT BANK_STATE_NO_MATCH  := 1;
		EXPORT BANK_STATE_NULL      := 2;
		EXPORT ABA_RTN_NOT_FOUND    := 3;
	END;

	EXPORT SrchMsg := MODULE
		EXPORT BANK_STATE_MATCHED   := 'Y';
		EXPORT BANK_STATE_NO_MATCH  := 'N';
		EXPORT BANK_STATE_NULL      := 'Null';
		EXPORT ABA_RTN_NOT_FOUND    := 'ABA not found';
	END;

	EXPORT GeoMsg := MODULE
		EXPORT REGION_MATCHED       := 'Match';
		EXPORT REGION_IP_MISMATCH   := 'IP Mismatch';
		EXPORT REGION_BANK_MISMATCH := 'Ultimate Bank Mismatch';
		EXPORT REGION_NO_MATCH      := 'No match';
	END;

	EXPORT Limits := MODULE
		EXPORT JOIN_LIMIT := 1000;
	END;

END;
