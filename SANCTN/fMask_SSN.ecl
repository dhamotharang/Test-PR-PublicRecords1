export fMask_SSN(string pStringIn) := function

	string	lPreAndPostSpace:=	' ' + pStringIn + ' ';

	// string	lRegExNoSep		:=	'([^0-9,^-ABORTLabortl])([0-9]{9})([^0-9])';
	string	lRegExNoSep		:=	'([ N:])([0-9]{9})([^0-9])';
	string	lNoSepReplace	:=	'\\1XXXXXXXXX\\3';

	// string	lRegExSep		:=	'([^0-9,^-ABORTLabortl])([0-9]{3}[^0-9][0-9]{2}[^0-9][0-9]{4})([^0-9])';
	string	lRegExSep		:=	'([ N:])([0-9]{3}[^0-9][0-9]{2}[^0-9][0-9]{4})([^0-9])';
	string	lSepReplace		:=	'\\1XXX-XX-XXXX\\3';

	string	lPreReturnValue	:=	regexreplace(lRegExNoSep
	                                        ,regexreplace(lRegExSep
											             ,lPreAndPostSpace
														 ,lSepReplace)
											,lNoSepReplace);

return	lPreReturnValue[2..(length(lPreReturnValue)-1)];

end
;
