EXPORT mac_ConvertToUpperCase(inTbl, field1='', field2='', field3='') := FUNCTIONMACRO;

ToUpperCase(STRING aString) := StringLib.StringToUpperCase(aString);
		
resultTbl := PROJECT(inTbl, TRANSFORM(RECORDOF(inTbl),
			#if (#TEXT(field1)<>'')
				self.field1 := (typeof(left.field1))ToUpperCase(left.field1);
			#end
			#if (#TEXT(field2)<>'')
				self.field2 := (typeof(left.field2))ToUpperCase(left.field2);
			#end
			#if (#TEXT(field3)<>'')
				self.field3 := (typeof(left.field3))ToUpperCase(left.field3);
			#end
			self := left));
			
RETURN resultTbl;

ENDMACRO;
