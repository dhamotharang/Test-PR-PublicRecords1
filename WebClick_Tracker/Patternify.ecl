export string Patternify(string InStr) := function
		LetterifiedStr:=regexreplace('[A-Za-z]',InStr,'L');
		DigitifiedStr:=regexreplace('[0-9]',LetterifiedStr,'D');
		return trim(DigitifiedStr,left,right);
end;