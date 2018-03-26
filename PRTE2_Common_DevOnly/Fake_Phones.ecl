/*  March 9, 2015 - as of now, the last number generated for Alphareatta is MAX(cellphone) in phonesplus
Fictitious phone numbers exchange = 555
except avoid number 1212
and avoid using 555 with area code 800 or 844, 855, 866, 877, 888 or Canadian area code 600.
Also found this:
Area codes in the NANP area cannot begin with 0 or 1. So area codes < 200 are not valid.
*/

// Later can add a get MAX() from existing records and do next after that via the maxFoundNumber...
EXPORT Fake_Phones(STRING maxFoundNumber='1005550100') := MODULE

PhonRec := RECORD
	STRING ac := '';
	STRING ex := '';
	STRING num := '';
END;

ACforAorB := 'A';
AlphaAreaCodeMin 	:= '100';
AlphaAreaCodeMax 	:= '125';
BocaAreaCodeMin		:= '126';
BocaAreaCodeMax		:= '150';

// The ACMin, NumMin, can also later be set to whatever a "MAX()" returned looking through a base file.
ACMinS := IF(ACforAorB='A', AlphaAreaCodeMin, BocaAreaCodeMin);
ACMaxS := IF(ACforAorB='A', AlphaAreaCodeMax, BocaAreaCodeMax);
ACMin := IF(maxFoundNumber='',ACMinS,maxFoundNumber[1..3]); 
ACMax := ACMaxS;	// no logic here just take the chosen Max
NumMin := IF(maxFoundNumber='','0100',maxFoundNumber[7..10]);
	
AreaCdNot := ['800', '844', '855', '866', '877', '888', '600'];
Exchange := '555';
NumberNot := '1212';


addOne (STRING n) := (STRING) ( (INTEGER) n + 1 );
addOne4 (STRING n) := INTFORMAT( ((INTEGER) n + 1), 4,1);

nextNum (STRING n) := FUNCTION
	nTmp := addOne4(n);
	RETURN IF(nTmp=NumberNot, addOne4(nTmp), nTmp);
END;

nextAc (STRING n) := FUNCTION
	nTmp := addOne(n);
	RETURN IF(nTmp IN AreaCdNot, addOne(nTmp), nTmp);
END;	

NextCTPhone(STRING ac, STRING ex, STRING num) := FUNCTION
		NumTmp := nextNum(num);
		NumNext := IF(NumTmp < '9999', NumTmp, '0100');
		AcNext := IF(NumNext = '0100', nextAc(ac), ac);
		errCondition := AcNext > ACMax;		// what to do to abort?
		RETURN [AcNext,ex,NumNext];
END;

// If first time called, ex is empty...
SHARED getNextCTPhone(STRING ac, STRING ex, STRING num) := FUNCTION
		RETURN IF( ex = '', [ACMin, Exchange, NumMin], NextCTPhone(ac,ex,num) );			
END;

EXPORT NextPhoneAsSet(STRING ac='', STRING ex='', STRING num='') := FUNCTION
	SET OF STRING ans := getNextCTPhone(ac,ex,num);
	RETURN ans;
END;

EXPORT FormattedNextPhone(STRING ac='', STRING ex='', STRING num='') := FUNCTION
	SET OF STRING ans := getNextCTPhone(ac,ex,num);
	RETURN ans[1]+'-'+ans[2]+'-'+ans[3];
END;

EXPORT String10NextPhone(STRING inPh ='') := FUNCTION
	ac := inPh[1..3];
	ex := inPh[4..6];
	num := inPh[7..10];
	SET OF STRING ans := getNextCTPhone(ac,ex,num);
	RETURN ans[1]+ans[2]+ans[3];
END;

END;