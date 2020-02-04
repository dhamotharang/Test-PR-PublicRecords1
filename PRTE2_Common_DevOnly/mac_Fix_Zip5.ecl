
EXPORT mac_Fix_Zip5(inTbl, field1='') := FUNCTIONMACRO;
	
	RETURN PROJECT(inTbl, TRANSFORM(RECORDOF(inTbl),
			#if (#TEXT(field1)<>'')
				self.field1 := INTFORMAT( (INTEGER)left.field1, 5, 1);
			#end
			self := left));

ENDMACRO;
