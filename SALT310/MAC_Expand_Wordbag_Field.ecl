//This macro is very similar to 
//SALT310.mac_expand_wordbag_key(DataForKey1,company_name_hash,company_name,DataForKey1)
// but given the time-critical nature of it (and low line count) - I am inclined to go the cut & paste route
// Trying to pull out the text from
// Number MyWord Num MyOtherWord OtherNum
EXPORT MAC_Expand_Wordbag_Field(infile,fieldname,field_id,in_uid,o_layout,o) := MACRO
  #uniquename(tr)
	o_layout %tr%(infile le,UNSIGNED c) := TRANSFORM
	  SELF.word := SALT310.GetNthWord(le.fieldname,c);
		SELF.uid := le.in_uid;
		SELF.field := field_id;
		SELF := le;
	END;
	o := NORMALIZE(infile,SALT310.WordCount(LEFT.fieldname)/2,%tr%(LEFT,COUNTER*2));
		
ENDMACRO;
	
	
