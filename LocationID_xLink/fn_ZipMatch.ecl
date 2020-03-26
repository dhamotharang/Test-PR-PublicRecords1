export boolean fn_ZipMatch(string leftZip, string rightZip)  := function
	unsigned6 leftZipNum  := (unsigned6) leftZip;
	unsigned6 rightZipNum := (unsigned6) rightZip;
	
	leftIsValidZip        := leftZipNum > 0 and length(trim(leftZip))=5;
	rightIsValidZip       := rightZipNum > 0 and length(trim(rightZip))=5;
	
	leftZipSet            := ziplib.ZipsWithinRadius(leftZip, 20);
	rightZipSet           := ziplib.ZipsWithinRadius(rightZip, 20);
	
	leftZipInRightSet     := leftZipNum in rightZipSet;
	rightZipInLefSet      := rightZipNum in leftZipSet;
	
	isMatch               := leftIsValidZip and rightIsValidZip 
	                       and (trim(leftZip) = trim(rightZip) or leftZipInRightSet or rightZipInLefSet);
	
	return isMatch;
end;