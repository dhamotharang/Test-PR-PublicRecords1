/*Function to handle triStateBoolean iesp fields defined as - //values['U','Y','N',''] in the iesp module
**INPUT - a valid tri state bool string (see examples below)
**OUTPUT - single char tri state val
___________________________________________________
      Test	                                |Output|      
--------------------------------------------|------|
ut.String2TriStateBool('        UNK     '); |  'U' |
ut.String2TriStateBool('UNKNOWN     ');     |  'U' |
ut.String2TriStateBool('yes     ');         |  'Y' |
ut.String2TriStateBool('   fAlSe     ');    |  'N' |
ut.String2TriStateBool('        ');         |  'U' |
ut.String2TriStateBool('True');             |  'Y' |
----------------------------------------------------
**to test your values for NOT NOT EQUAL, use - ut.NNEQ_TriStateBool*/

EXPORT String2TriStateBool(STRING str) := FUNCTION
  s := StringLib.StringToUpperCase((STRING1)TRIM(str,ALL));
  RETURN MAP(s IN ['Y','T'] =>'Y', 
             s IN ['N','F'] =>'N',
                   'U');						
END;