//This macro is very similar to 
//SALT28.mac_expand_wordbag_key(DataForKey1,company_name_hash,company_name,DataForKey1)
// but given the time-critical nature of it (and low line count) - I am inclined to go the cut & paste route
// Trying to pull out the text from
// Number MyWord Num MyOtherWord OtherNum
export MAC_Expand_Wordbag_Field(infile,fieldname,field_id,in_uid,o) := MACRO
  #uniquename(tr)
	SALT28.Layout_Uber_Plus %tr%(infile le,unsigned c) := transform
	  self.word := SALT28.GetNthWord(le.fieldname,c);
		self.uid := le.in_uid;
		self.field := field_id;
	end;
	o := normalize(infile,SALT28.WordCount(left.fieldname)/2,%tr%(left,counter*2));
		
  ENDMACRO;
	
