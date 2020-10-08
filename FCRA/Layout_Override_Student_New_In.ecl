EXPORT Layout_Override_Student_New_In := RECORD
		// DF-23067 - Add tier2 field to override ASL input data file
   		fcra.Layout_Override_Student_New - [global_sid, record_sid];  //CCPA-1045 - exclude CCPA new fields from ASL input file
END;