IMPORT iesp, ut;

EXPORT utilities := MODULE

	//Convert a dataset to set
	EXPORT covertToSet(DATASET(iesp.frauddefensenetwork.t_FDNFileType) ft) := FUNCTION
	
		convert_layout := {string result};			
		
		prep := PROJECT(ft, TRANSFORM(convert_layout, SELF.result := '"' + LEFT.FileType + '"'));

		rollUp_result  := ROLLUP(prep, TRUE, TRANSFORM(convert_layout, SELF.result := LEFT.result + ',' + RIGHT.result));		
		fileTypeSet		 := rollUp_result[1].result;

	
		RETURN fileTypeSet;
	END;
	
		
		//================================================================
		// Date Conversion
		//================================================================
		
		// Getting YYYY-MM-DD HH:MM:SS format from YYYYMMDD and HHMMSS
		EXPORT STRING20 TimeFormatStamp(STRING17 dt) := FUNCTION
			ret := dt[1..4]   + (STRING1) '-'   + 
	           dt[5..6]	  + (STRING1) '-'   + 
			       dt[7..8]   + (STRING1) ' '   + 
						 dt[9..10]  + (STRING1) ':'   + 
						 dt[11..12] + (STRING1) ':'   + 
						 dt[13..14];	 
			RETURN ret;
	  END;
		 
		 EXPORT TodayDate	 		   := TimeFormatStamp(ut.GetDate + ut.getTime());
		 EXPORT offset3Days      := TimeFormatStamp(ut.getDateOffset(-3, ut.GetDate) + ut.getTime());
		 
		 //Getting YYYYMMDD format from YYYY-MM-DD HH:MM:SS
		 EXPORT STRING8 convertDate(STRING20 dt) := FUNCTION
			ret := dt[1..4]   +  
	           dt[6..7]		+ 
			       dt[9..10];
			RETURN ret;
		END;
			
			//Getting HHMMSS format from YYYY-MM-DD HH:MM:SS
			EXPORT STRING6 convertTime(STRING20 dt) := FUNCTION
			ret := dt[12..13]   +  
	           dt[15..16]		+ 
			       dt[18..19];
			RETURN ret;			
	  END;
		 
END;