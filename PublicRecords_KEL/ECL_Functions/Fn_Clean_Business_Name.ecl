﻿/* Cleans the Input Business Name
  o  Replace any accented characters with unaccented characters
  o  Remove any special characters
  o  Upper Case all lower case characters
*/

IMPORT STD, ut;

EXPORT Fn_Clean_Business_Name(STRING Name = '') := FUNCTION
  Name_CleanAccents := (STRING)STD.Uni.CleanAccents(Name);
	Name_RemoveSpecialChars := ut.fn_RemoveSpecialChars(Name_CleanAccents);
	Name_ToUpper := STD.Str.ToUpperCase(Name_RemoveSpecialChars);
	
  RETURN Name_ToUpper;
END;
