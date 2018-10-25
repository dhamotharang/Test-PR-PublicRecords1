EXPORT MAC_Expand_Date_Field(infile,field_year,field_month,field_day,field_id,in_uid,o_layout,o) := MACRO
  #uniquename(tr)
	#uniquename(layout)
	o_layout %tr%(infile le) := TRANSFORM
	// using mm/dd/yyyy
	  SELF.word := (SALT38.StrType)le.field_month+'/'+(SALT38.StrType)le.field_day+'/'+(SALT38.StrType)le.field_year;
		SELF.uid := le.in_uid;
		SELF.field := field_id;
    SELF := le;
	END;
	o := PROJECT(infile,%tr%(LEFT));
	
ENDMACRO;
