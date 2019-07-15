/*
This function will remove ASCII special characters (unprintables) from a string.
It will optionally replace a special characters with another specified string

It REMOVES characters that are NOT in this range in the Unicode Table:  
		0020 (space) through 00FF (ÿ)

It KEEPS other characters, including foreign letters (and also capitalizes foreign letters)		
*/

export fn_RemoveSpecialChars(string s, string replacement='') := function
			
	stripInvalids := REGEXREPLACE('([^ -ÿ]+)',s,replacement);	//Removes chars not in space through ÿ		
	
	// Capitalizes foreign letters à through ý  
	// 	(ÿ can't be capitalized, because the capital form is unprintable)
	return REGEXREPLACE('ý',	 REGEXREPLACE('ü',	 REGEXREPLACE('û',	 REGEXREPLACE('ú',
				 REGEXREPLACE('ù',	 REGEXREPLACE('ö',	 REGEXREPLACE('õ',	 REGEXREPLACE('ô',
				 REGEXREPLACE('ó',	 REGEXREPLACE('ò',	 REGEXREPLACE('ñ',	 REGEXREPLACE('ï',
				 REGEXREPLACE('î',	 REGEXREPLACE('í',	 REGEXREPLACE('ì',	 REGEXREPLACE('ë',
				 REGEXREPLACE('ê',	 REGEXREPLACE('é',	 REGEXREPLACE('è',	 REGEXREPLACE('å',
				 REGEXREPLACE('ä',	 REGEXREPLACE('ã',	 REGEXREPLACE('â',	 REGEXREPLACE('á',
				 REGEXREPLACE('à',stripInvalids,  
											'À'),								'Á'),								'Â'),								'Ã'),
											'Ä'), 							'Å'),								'È'),								'É'),	
											'Ê'),								'Ë'),								'Ì'),								'Í'),		
											'Î'),								'Ï'),								'Ñ'),								'Ò'),	
											'Ó'),								'Ô'),								'Õ'),								'Ö'), 	
											'Ù'),								'Ú'),								'Û'),								'Ü'),		
											'Ý');
																	
end;																			
																			
