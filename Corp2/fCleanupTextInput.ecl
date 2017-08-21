//This function cleans text strings from all blank characters and, 
//in addition, from all other characters except specified for a certain text fields.
// 04-13-2007 -  Added clean_name_filter to clean the names properly as per bug# 22540
import lib_stringlib;

EXPORT STRING fCleanupTextInput(STRING pTextString, STRING pTextStringFld  = '' ) := FUNCTION

corp_legal_name_filter := '[^-[:alnum:].,;&()/\'#?+`"!$@:\242\t\052=~%\134 ]';
other_names_filter := '[^-[:alnum:].,\'&/" ]';
alpha_filter := '[^[:alpha:]]';
alnum_filter := '[^[:alnum:]]';
digit_filter := '[^[:digit:]]';
//Remove all non-printable characters only
else_filter := '[^[:print:]]';
clean_name_filter := '[^[:alpha:] -]';

//The function to clean the leading non alpha numberic characters from a given string.
string cleanLeadingNonAlpNumChars(string instr) := function
  s := regexreplace(alnum_filter, instr, '', nocase);
	fchar := if (length(s) > 0, s[1], '');
	pos := if (fchar = '', 0, lib_stringlib.StringLib.StringFind(instr, fchar, 1));
  return(if (pos > 0, instr[pos..], ''));
end;
      
		 //Replace non-printable characters
		 //with spaces
	   PreClnString1 := IF(regexfind('\242',pTextString),
		                     pTextString,
		                     regexreplace('[^[:print:]]',pTextString,' ',NOCASE));
		 
		 //Cleanup from leading and trailing spaces					 
      ltrim_filter := '^ *';
			rtrim_filter := ' *$';
			PreClnString2 := regexreplace(rtrim_filter,
			                              regexreplace(ltrim_filter,PreClnString1,'',NOCASE),
			                              '',NOCASE);	
		 
		 PreClnString3 := fCleanDoubleQuotes(PreClnString2);   

     

     //Cleanup from leading and trailing plus signs
     //FIRST PASS
     PreClnString4 := regexreplace('^[+]*(.*)',PreClnString3,'$1',NOCASE);
     //SECOND PASS
     PreClnString5 := regexreplace('[+]*$',PreClnString4,'',NOCASE);
     
		 //Cleanup from leading and trailing asterisks
     //FIRST PASS
     PreClnString6 := regexreplace('^[*]*(.*)',PreClnString5,'$1',NOCASE);
     //SECOND PASS
     PreClnString7 := regexreplace('[*]*$',PreClnString6,'',NOCASE);
		 
     //Cleanup from leading and trailing backquotes
     //FIRST PASS
     PreClnString8 := regexreplace('^[`]*(.*)',PreClnString7,'$1',NOCASE);
     //SECOND PASS
     PreClnString9 := regexreplace('[`]*$',PreClnString8,'',NOCASE); 
		 
		 //Cleanup from leading and trailing percent signs
     //FIRST PASS
     PreClnString10 := regexreplace('^[%]*(.*)',PreClnString9,'$1',NOCASE);
     //SECOND PASS
     PreClnString11 := regexreplace('[%]*$',PreClnString10,'',NOCASE); 
		 
     
     FltrString := MAP(pTextStringFld = 'corp_legal_name' => 
		             regexreplace(corp_legal_name_filter,PreClnString11,'',NOCASE),
		             pTextStringFld = 'other_names' =>
								 cleanLeadingNonAlpNumChars(regexreplace(other_names_filter,PreClnString11,'',NOCASE)),
								 pTextStringFld = 'clean_names' =>
								 regexreplace(clean_name_filter,PreClnString11,'',NOCASE),
								 pTextStringFld = 'alpha' =>
								 regexreplace(alpha_filter,PreClnString11,'',NOCASE),
								 pTextStringFld = 'alnum' =>
								 regexreplace(alnum_filter,PreClnString11,'',NOCASE),
								 pTextStringFld = 'digit' =>
								 regexreplace(digit_filter,PreClnString11,'',NOCASE),
								 regexreplace(else_filter,PreClnString11,'',NOCASE)
     					   );
							 
RETURN FltrString;
END;