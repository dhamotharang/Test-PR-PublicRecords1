//-----------------------------------------------------------------------
//------FUNCTION TO CLEAN GARBAGE IN ALPHANUMERIC STRINGS---------------
//-----------------------------------------------------------------------

EXPORT FN_Clean_String_Garbage(STRING DirtyString) := FUNCTION
 STRING CleanString := REGEXREPLACE('[^:alnum:]|[^:punct:] ',DirtyString, '');
 RETURN CleanString;
 END;
