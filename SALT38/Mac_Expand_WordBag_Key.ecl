//SALT38.mac_expand_wordbag_key(DataForKey1,company_name_hash,company_name,DataForKey1)
// Trying to pull out the text from
// Number MyWord Num MyOtherWord OtherNum
export mac_expand_wordbag_key(inkey,hash_field,field,outkey,scorefield='') := MACRO
  #uniquename(tr)
	typeof(inkey) %tr%(inkey le,unsigned c) := transform
	  self.hash_field := hash32(SALT38.GetNthWord(le.field,c));
		#IF (#TEXT(scorefield)<>'')
		self.scorefield := (unsigned)SALT38.GetNthWord(le.field,c+1);
		#END
	  self := le;
	end;
	outkey := normalize(inkey,SALT38.WordCount(left.field)/2,%tr%(left,counter*2));
		
  ENDMACRO;
