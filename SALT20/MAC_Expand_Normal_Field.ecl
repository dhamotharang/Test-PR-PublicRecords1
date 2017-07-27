//This macro is very similar to 
//SALT20.mac_expand_wordbag_key(DataForKey1,company_name_hash,company_name,DataForKey1)
// but given the time-critical nature of it (and low line count) - I am inclined to go the cut & paste route
// Trying to pull out the text from
// Word Word Word
export MAC_Expand_Normal_Field(infile,fieldname,field_id,in_uid,o) := MACRO
  #uniquename(tr)
	SALT20.Layout_Uber_Plus %tr%(infile le,unsigned c) := transform
	  self.word := ut.Word((string)le.fieldname,c);
		self.uid := le.in_uid;
		self.field := field_id;
	end;
	o := normalize(infile,ut.NoWords((string)left.fieldname),%tr%(left,counter));
		
  ENDMACRO;
	
