IMPORT BatchShare, header;
EXPORT IParams := MODULE

	EXPORT BatchParams := INTERFACE (BatchShare.IParam.BatchParamsV2)
	  EXPORT BOOLEAN   IncludeShortTermRental := FALSE;
	  EXPORT BOOLEAN   IncludeSTRSplitFlag    := FALSE;
	  EXPORT STRING6   AddrSearchDate         := '';
	  EXPORT BOOLEAN   DEBUG                  := FALSE;
	  EXPORT UNSIGNED1 MaxRecordsToReturn     := 1;
	  EXPORT BOOLEAN   getDids                := TRUE;
	  // For use in doxie/header_records_byDID as the ReturnLimit value
	  EXPORT UNSIGNED  MaxInterHdrRecs        := Header.constants.ReturnLimit;
	END;
	
	EXPORT getBatchParams() := FUNCTION
		base_params := BatchShare.IParam.getBatchParamsV2();
		// project the base params to read shared parameters from store.
		in_mod := module(PROJECT(base_params, BatchParams, opt))	
			// query level input options
			EXPORT BOOLEAN 	 IncludeShortTermRental := TRUE  : STORED('IncludeShortTermRental');
			EXPORT BOOLEAN 	 IncludeSTRSplitFlag    := FALSE : STORED('IncludeSTRSplitFlag');
			EXPORT STRING6	 AddrSearchDate         := ''    : STORED('AddrSearchDate');
			EXPORT BOOLEAN 	 DEBUG                  := FALSE : STORED('DEBUG');//permits test output statements
			EXPORT UNSIGNED1 MaxRecordsToReturn     := 1     : STORED('MaxRecordsToReturn');
		END;		
		
		RETURN in_mod;
	END;

END;
