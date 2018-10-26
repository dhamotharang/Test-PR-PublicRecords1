//This macro is very similar to 
//SALT38.mac_expand_wordbag_key(DataForKey1,company_name_hash,company_name,DataForKey1)
// but given the time-critical nature of it (and low line count) - I am inclined to go the cut & paste route
// Trying to pull out the text from
// Word Word Word
EXPORT MAC_Expand_Normal_Field(infile,fieldname,field_id,in_uid,o_layout,o) := MACRO
  #uniquename(tr)
	#uniquename(layout)
	o_layout %tr%(infile le,UNSIGNED c) := TRANSFORM
	  SELF.word := SALT38.GetNthWord((SALT38.StrType)le.fieldname,c);
		SELF.uid := le.in_uid;
		SELF.field := field_id;
    SELF := le;
	END;
	o := NORMALIZE(infile,SALT38.WordCount((SALT38.StrType)LEFT.fieldname),%tr%(LEFT,COUNTER));
		
  ENDMACRO;
	
