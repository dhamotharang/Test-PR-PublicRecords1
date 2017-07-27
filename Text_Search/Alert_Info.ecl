EXPORT Alert_Info := MODULE

	EXPORT AlertParams := INTERFACE
			EXPORT BOOLEAN isAlert := FALSE;
			EXPORT Text_Search.Types.SegmentName dateSegName := '';
			EXPORT UNSIGNED2 lastXDays := 0;
			EXPORT STRING envVerName := '';
	END;
	
	EXPORT SetAlertParams(STRING segName = '', 
												UNSIGNED2 days = 0, 
												STRING envName = '', 
												BOOLEAN alert = false) := FUNCTION
		  
			aMOD := MODULE(AlertParams)
				EXPORT BOOLEAN isAlert := alert;	
				EXPORT Text_Search.Types.SegmentName dateSegName := segName;
				EXPORT UNSIGNED2 lastXDays := days;
				EXPORT STRING envVerName := envName;
			END;
			RETURN aMod;
	END;
	
END;