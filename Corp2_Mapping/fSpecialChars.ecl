import corp2;

//"fSpecialChars" function returns "FOUND" verbiage when passed parameter consists below list of foreign characters
//Capitalizing foreign letters not working with corp2.t2u(S) function,including both sets of foreign letters !!
EXPorT fSpecialChars(string C) := function

  S            := corp2.t2u(C);
	ForeignChars := if( regexfind('Ý', S) or regexfind('Ü', S) or regexfind('Û', S) or regexfind('Ú', S) or 
											regexfind('Ù', S) or regexfind('Ö',	S) or regexfind('Õ', S) or regexfind('Ô', S) or
											regexfind('Ó', S) or regexfind('Ò',	S) or regexfind('Ñ', S) or regexfind('Ï', S) or
											regexfind('Î', S) or regexfind('Í',	S) or regexfind('Ì', S) or regexfind('Ë', S) or
											regexfind('Ê', S) or regexfind('É',	S) or regexfind('È', S) or regexfind('Å', S) or
											regexfind('Ä', S) or regexfind('Ã',	S) or regexfind('Â', S) or regexfind('Á', S) or
											regexfind('À', S) or regexfind('À', S) or regexfind('Á', S) or regexfind('Â', S) or				
											regexfind('Ã', S) or regexfind('Ä', S) or regexfind('Å', S) or regexfind('È', S) or 
											regexfind('É', S) or regexfind('Ê', S) or regexfind('Ë', S) or regexfind('Ì', S) or 
											regexfind('Í', S) or regexfind('Î', S) or regexfind('Ï', S) or regexfind('Ñ', S) or 
											regexfind('Ò', S) or regexfind('Ó', S) or regexfind('Ô', S) or regexfind('Õ', S) or 
											regexfind('Ö', S) or regexfind('Ù', S) or regexfind('Ú', S) or regexfind('Û', S) or 
											regexfind('Ü', S) or regexfind('Ý', S) or											
											regexfind('ý', S) or regexfind('ü', S) or regexfind('û', S) or regexfind('ú', S) or 
											regexfind('ù', S) or regexfind('ö',	S) or regexfind('õ', S) or regexfind('ô', S) or
											regexfind('ó', S) or regexfind('ò',	S) or regexfind('ñ', S) or regexfind('ï', S) or
											regexfind('î', S) or regexfind('í',	S) or regexfind('ì', S) or regexfind('ë', S) or
											regexfind('ê', S) or regexfind('é',	S) or regexfind('è', S) or regexfind('å', S) or
											regexfind('ä', S) or regexfind('ã',	S) or regexfind('â', S) or regexfind('á', S) or
											regexfind('à', S) or regexfind('à', S) or regexfind('á', S) or regexfind('â', S) or				
											regexfind('ã', S) or regexfind('ä', S) or regexfind('å', S) or regexfind('è', S) or 
											regexfind('é', S) or regexfind('ê', S) or regexfind('ë', S) or regexfind('ì', S) or 
											regexfind('í', S) or regexfind('î', S) or regexfind('ï', S) or regexfind('ñ', S) or 
											regexfind('ò', S) or regexfind('ó', S) or regexfind('ô', S) or regexfind('õ', S) or 
											regexfind('ö', S) or regexfind('ù', S) or regexfind('ú', S) or regexfind('û', S) or 
											regexfind('ü', S) or regexfind('ý', S),'FOUND', 'NOTFOUND'
									 );

	return ForeignChars;
														
end;