import corp2;

//"fSpecialChars" function returns "FOUND" verbiage when passed parameter consists below list of foreign characters
EXPORT fSpecialChars(string C) := function

	S            := corp2.t2u(c);  
	ForeignChars := if( REGEXFIND('Ý', S) OR REGEXFIND('Ü', S) OR REGEXFIND('Û', S) OR REGEXFIND('Ú', S) OR 
											REGEXFIND('Ù', S) OR REGEXFIND('Ö',	S) OR REGEXFIND('Õ', S) OR REGEXFIND('Ô', S) OR
											REGEXFIND('Ó', S) OR REGEXFIND('Ò',	S) OR REGEXFIND('Ñ', S) OR REGEXFIND('Ï', S) OR
											REGEXFIND('Î', S) OR REGEXFIND('Í',	S) OR REGEXFIND('Ì', S) OR REGEXFIND('Ë', S) OR
											REGEXFIND('Ê', S) OR REGEXFIND('É',	S) OR REGEXFIND('È', S) OR REGEXFIND('Å', S) OR
											REGEXFIND('Ä', S) OR REGEXFIND('Ã',	S) OR REGEXFIND('Â', S) OR REGEXFIND('Á', S) OR
											REGEXFIND('À', S) OR REGEXFIND('À', S) OR REGEXFIND('Á', S) OR REGEXFIND('Â', S) OR				
											REGEXFIND('Ã', S) OR REGEXFIND('Ä', S) OR REGEXFIND('Å', S) OR REGEXFIND('È', S) OR 
											REGEXFIND('É', S) OR REGEXFIND('Ê', S) OR REGEXFIND('Ë', S) OR REGEXFIND('Ì', S) OR 
											REGEXFIND('Í', S) OR REGEXFIND('Î', S) OR REGEXFIND('Ï', S) OR REGEXFIND('Ñ', S) OR 
											REGEXFIND('Ò', S) OR REGEXFIND('Ó', S) OR REGEXFIND('Ô', S) OR REGEXFIND('Õ', S) OR 
											REGEXFIND('Ö', S) OR REGEXFIND('Ù', S) OR REGEXFIND('Ú', S) OR REGEXFIND('Û', S) OR 
											REGEXFIND('Ü', S) OR REGEXFIND('Ý', S), 'FOUND', 'NOTFOUND'
									 );

	return ForeignChars;
														
end;