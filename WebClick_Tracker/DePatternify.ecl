export string DePatternify(string PatternStr):=function
		DeLetterifiedStr:=regexreplace('L',PatternStr,'[A-Za-z]');
		DeDigitifiedStr:=regexreplace('D',DeLetterifiedStr,'[0-9]');
		return('^'+DeDigitifiedStr+'\\s*$');
end;