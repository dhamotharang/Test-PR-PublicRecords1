EXPORT macAppendDisposableEmailDomainFlag(dIn, emailAddressField, appendPrefix = '\'\'', UseIndexThreshold=100000000)  := FUNCTIONMACRO
	IMPORT AppendDisposableEmailDomainFlag, STD;
	LOCAL rWithDomain := RECORD
		STRING emlDomain;	
		INTEGER cntDomain;
	END;

	LOCAL dWithDomain := PROJECT(dIn, TRANSFORM({RECORDOF(LEFT) OR rWithDomain},
		integer cntAtSymbol := STD.str.FindCount(LEFT.emailAddressField, '@');
		integer begIndexDomain := IF(cntAtSymbol <> 0, STD.str.Find(LEFT.emailAddressField, '@', cntAtSymbol), 0);
		SELF.emlDomain := IF(begIndexDomain <> 0, LEFT.emailAddressField[begIndexDomain+1..], '');
		SELF.cntDomain := STD.str.WordCount(STD.str.FindReplace(SELF.emlDomain, '.', ' '));
		SELF := LEFT));

	LOCAL dWithDomainDup := DEDUP(SORT(PROJECT(dWithDomain(emlDomain <> ''), TRANSFORM(rWithDomain, SELF := LEFT)), emlDomain), emlDomain); 

	//check for domains with more than 2 words if any matches to the last two words of the disposable email set
	LOCAL fnGetLastTwo(string email_domain) := function
		integer cntDotSymbol := STD.str.FindCount(email_domain, '.');
		integer begIndexDot := STD.str.Find(email_domain, '.', cntDotSymbol - 1);
		string lasttwo := email_domain[begIndexDot+1..];
		return lasttwo;
	end;
	LOCAL rInt := RECORD
		RECORDOF(dWithDomainDup);
		INTEGER isDisposableEmail;
	END;
	LOCAL dMoreThanTwoThatMatch := JOIN(dWithDomainDup(cntDomain > 2), AppendDisposableEmailDomainFlag.setDisposableEmailDomains,
		fnGetLastTwo(LEFT.emlDomain) = RIGHT.domain,
		TRANSFORM(rInt,
			SELF.isDisposableEmail := (INTEGER)(RIGHT.domain <> ''),
			SELF := LEFT), LOOKUP);

	//check the other ones (less than 2 words)
	LOCAL dDisposableEmail := JOIN(dWithDomainDup(cntDomain <= 2), AppendDisposableEmailDomainFlag.setDisposableEmailDomains,
		LEFT.emlDomain = RIGHT.domain, 
		TRANSFORM(rInt,
			SELF.isDisposableEmail := (INTEGER)(RIGHT.domain <> ''),
			SELF := LEFT), LOOKUP);
		
	LOCAL rOut := RECORD
		RECORDOF(dIn);
    INTEGER #EXPAND(appendPrefix + 'isDisposableEmail');
	END;

	LOCAL dOut := JOIN(dWithDomain, dDisposableEmail+dMoreThanTwoThatMatch,
		LEFT.emlDomain = RIGHT.emlDomain,
		TRANSFORM(rOut,
			SELF.#EXPAND(appendPrefix + 'isDisposableEmail') := RIGHT.isDisposableEmail ,
			SELF := LEFT),
		LEFT OUTER, LOOKUP, FEW);
	RETURN dOut;
ENDMACRO;
