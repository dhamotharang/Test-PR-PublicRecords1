EXPORT MAC_Expand_Date_Field(infile,field_year,field_month,field_day,field_id,in_uid,o) := MACRO
  #uniquename(tr)
	SALT25.Layout_Uber_Plus %tr%(infile le) := TRANSFORM
	// using mm/dd/yyyy
	  SELF.word := (SALT25.StrType)le.field_month+'/'+(SALT25.StrType)le.field_day+'/'+(SALT25.StrType)le.field_year;
		SELF.uid := le.in_uid;
		SELF.field := field_id;
	END;
	o := PROJECT(infile,%tr%(LEFT));
		
  ENDMACRO;
