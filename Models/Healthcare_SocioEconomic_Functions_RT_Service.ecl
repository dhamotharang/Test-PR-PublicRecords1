Import STD,UT;
Import iesp;

EXPORT Healthcare_SocioEconomic_Functions_RT_Service := Module

EXPORT _blank := '';
//Since product spec gives freedom to customer to omit name and address fields if ssn is populated, it is mandatory to have a length of 9 in that case.
//Tested socio query to retrieve results on 7 or 8 digit padded SSN's, it does not return results. Hence 9 is needed.
EXPORT SSNCleaner(string SSN) := FUNCTION
string cleanSSN := STD.STR.filter(SSN,'0123456789');
ssnlength	:= length(cleanSSN);
set_invalid_ssn8	:= ['00000000','11111111','22222222','33333333','44444444','55555555','66666666','77777777','88888888','99999999','12345678','01234567','98765432','87654321','10101010'];
BOOLEAN	is_invalid_ssn8	:= cleanSSN[1..8] IN set_invalid_ssn8; 
BOOLEAN	is_invalid_ssn_length := IF(ssnlength IN [9], FALSE, TRUE);
OutSSN := IF(is_invalid_ssn8 OR is_invalid_ssn_length,_blank, cleanSSN);
return OutSSN;
END;

//Code can be used for DOB and ADMIT_DATE
EXPORT DOBCleaner(string8 InDate) := FUNCTION
string cleanDOB := STD.STR.filter(InDate,'0123456789');
LEN_DATE :=	LENGTH(cleanDOB); //No need to trim here due to filter
is_Valid_DOB := IF(STD.Date.IsValidDate((integer)cleanDOB) 
					AND (integer) cleanDOB <= (integer) STD.Date.CurrentDate()
					AND (integer) cleanDOB[1..4] >= 1900 , TRUE, FALSE);
OutDOB := IF(LEN_DATE = 8 and is_Valid_DOB, cleanDOB, _blank);
return OutDOB;	
END;

//History Date 
//Not beeing used in the RT service
EXPORT HistoryDateCleaner(string6 InDate) := FUNCTION
string cleanHistoryDate := STD.STR.filter(InDate,'0123456789');
LEN_DATE :=	LENGTH(TRIM(cleanHistoryDate,LEFT,RIGHT));
is_Valid_HistoryDate := IF(STD.Date.IsValidDate((integer)(cleanHistoryDate + '01')) 
						AND (integer) (cleanHistoryDate + '01') < (integer) STD.Date.CurrentDate()
						AND (integer) cleanHistoryDate[1..4] >= 1900 , TRUE, FALSE);
OutHistoryDate := IF(LEN_DATE = 6 and is_Valid_HistoryDate, cleanHistoryDate, _blank);
return OutHistoryDate;	
END;

//Code can be used for US Phone Numbers
EXPORT PhoneCleaner(string pPhone) := function
	alpha		:= '[[:alpha:]]+';
	whitespace	:= '[[:space:]]*';
	sepchar		:= '[-./]?';
	separator1	:= whitespace + sepchar + whitespace;
	frontdigit	:= '[01]?' + separator1;  // front digit
	OpenParen 	:= '[[({<]?';
	CloseParen	:= '[])}>]?';
	areacode 	:= frontdigit + OpenParen + '([[:digit:]]{3})' + CloseParen;
	exchange	:= '([[:digit:]]{3})';
	lastfour	:= '([[:digit:]]{4})';
	seven		:= exchange + separator1 + lastfour;
	extension	:= '(' + whitespace + alpha + sepchar + whitespace + '[[:digit:]]+' + ')?';
	phonenumber_regex := '(' + areacode + ')?' +  separator1 + seven + extension + whitespace;
	phone_number := regexreplace(phonenumber_regex, pPhone, '$2$3$4');
	find_phone_number := regexfind(phonenumber_regex, pPhone);
	clean_phone_length := length(trim(phone_number));
	clean_phone := if(find_phone_number,
						map(clean_phone_length = 7 => '' + phone_number,
						clean_phone_length < 7 or clean_phone_length > 10 => '',
						phone_number)
						,'');
	clean_phone_area := if(length(clean_phone) = 10 and (clean_phone[1] in ['0','1'] or clean_phone[2] = '9'), '', clean_phone);
 	clean_phone_second_group := if((length(clean_phone_area) = 10 and clean_phone_area[4] in ['0','1']) or (length(clean_phone_area) = 7 and clean_phone_area[1] in ['0','1']), _blank, clean_phone_area);
	return clean_phone_second_group;
end;

//Code for US Zip cleaner
EXPORT ZIPCleaner(STRING ZIP) := FUNCTION
string cleanZIP := STD.STR.filter(ZIP,'0123456789');
ZIPlength	:= length(cleanZIP);
OutZIP := map(ZIPlength =3 => '00'+ cleanZIP,
				ZIPlength =4 => '0'+ cleanZIP,
				ZIPlength =5 AND cleanZIP<>'00000'  => cleanZIP,
				ZIPlength in [6,7,8,9] => cleanZIP[1..5],
				_blank);
return OutZip;
END;

//STATE Cleaner
EXPORT StateCleaner(string InState) := FUNCTION
clnVal := trim(STD.Str.ToUpperCase(InState),left,right);
CleanState := STD.STR.filter(clnVal, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ');
set_valid_state := ['AK','AL','AR','AZ','CA','CO','CT','DE','FL','GA','HI','IA','ID','IL','IN','KS','KY','LA','MA','MD','ME','MI','MN','MO','MS','MT','NC','ND','NE','NH','NJ','NM','NV','NY','OH','OK','OR','PA','RI','SC','SD','TN','TX','UT','VA','VT','WA','WI','WV','WY','DC','PR','AS','FM','GS','GU','MH','MP','PW','VI','RN','RR','EE'];
OutState := IF( length(CleanState) = 2 AND CleanState IN set_valid_state, CleanState, _blank);
return OutState;
END;

//GENDER Cleaner and Validator
EXPORT GenderCleaner(string inGender) := FUNCTION
clnVal := trim(STD.Str.ToUpperCase(inGender),left,right);
CleanGender := STD.STR.filter(clnVal , 'ABCDEFGHIJKLMNOPQRSTUVWXYZ');
OutGender := map(CleanGender ='F' => 'F',
					CleanGender ='M' => 'M',
					CleanGender ='FEMALE' => 'F',
					CleanGender ='MALE' => 'M',
					_blank);
return OutGender;
END;

EXPORT getBooleanFlagValueForKeyFromIESP(dataset(iesp.healthcare_account_info.t_HCConfigParsedValue) EspValues, String MatchString) := FUNCTION
	getTag := EspValues(STD.Str.ToUpperCase(Key)=STD.Str.ToUpperCase(MatchString));
		// and Active = Healthcare_Constants_RT_Service.Constants.CFG_MBS_ACTIVE); //Active field will not be used by socio for suppression
	tagExists:= exists(getTag);
	getVal:=if( tagExists, STD.Str.ToUpperCase(trim(getTag[1].Value,left,right)), 'FALSE');
	RETURN iff(tagExists and getVal = 'TRUE', true, false);
END;

EXPORT getCatThresholdValueForKeyFromIESP(dataset(iesp.healthcare_account_info.t_HCConfigParsedValue) EspValues, String MatchString) := FUNCTION
	getTag := EspValues(STD.Str.ToUpperCase(Key)=STD.Str.ToUpperCase(MatchString));
		// and Active = Healthcare_Constants_RT_Service.Constants.CFG_MBS_ACTIVE); //Active field will not be used by socio for suppression
	tagExists:= exists(getTag);
	getVal:= STD.Str.ToUpperCase(trim(getTag[1].Value,left,right));
	RETURN iff(tagExists and getVal <> _blank, getVal, _blank);
END;

EXPORT FirstAndLastNameValidator (string inName) := FUNCTION
	uName := trim(STD.Str.ToUpperCase(inName),left,right);
	//Check if we have at least one letter
	OnlyAlphaCharacters := STD.STR.filter(uName , 'ABCDEFGHIJKLMNOPQRSTUVWXYZ');
	//If we have atleast one letter in the input, then verify that it contains only alpha characters, spaces, periods, apostrophes, and/or dashes. 
	//regexfind('^([A-Z \'.-]+)$', name, 1);
	ValidatedName := regexfind('^([A-Z \'.-]+)$', uName, 1);
	outName := IF(OnlyAlphaCharacters <> _blank AND ValidatedName <> _blank, inName, _blank);
	RETURN outName;
END;

END;