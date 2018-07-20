Import STD,UT;
Import iesp;

EXPORT Healthcare_SocioEconomic_Functions_RT_Service := Module

EXPORT _blank := '';
//TODO: Since product spec gives freedom to customer to omit name and address fields if ssn is populated, it is mandatory to have a length of 9 in that case.
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
LEN_DATE :=	LENGTH(TRIM(cleanDOB,LEFT,RIGHT)); //TODO: No need to trim here due to filter
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

// EXPORT checkForRejects(dataset(Models.Layouts_Healthcare_RT_Service.Layout_SocioEconomic_Data_Cln) Cleaned_Member_Input) := FUNCTION
// 	Cleaned_Input := Cleaned_Member_Input[1];
// 	Name_First := Cleaned_Input.Name_First;
// 	Name_Last := Cleaned_Input.Name_Last;
// 	street_addr := Cleaned_Input.street_addr;
// 	p_City_name := Cleaned_Input.p_City_name;
// 	ST_Cln := Cleaned_Input.ST_Cln;
// 	Z5_Cln := Cleaned_Input.Z5_Cln;
// 	DOB_Cln := Cleaned_Input.DOB_Cln;
// 	MemberGender_Cln := Cleaned_Input.MemberGender_Cln;
// 	SSN_Cln := Cleaned_Input.SSN_Cln;
// 	ADMIT_DATE_Cln := Cleaned_Input.ADMIT_DATE_Cln;
// 	isMinor:= IF(Cleaned_Input.Age<18,TRUE,FALSE);

// 	Met_MinInput_Condition_1 := IF(SSN_Cln <>'' AND MemberGender_Cln <>'' AND DOB_Cln <>''AND ST_Cln<>'',TRUE, FALSE);
// 	//Met_MinInput_Condition_1;
// 	Met_MinInput_Condition_2 := IF(Name_First <>'' AND Name_Last<>'' AND street_addr <>'' AND p_City_name<>'' AND Z5_Cln<>'' AND MemberGender_Cln <>'' AND DOB_Cln <>''AND ST_Cln<>'',TRUE, FALSE);
// 	//Met_MinInput_Condition_2;

// 	Reject_Code_Reason_Prefix := 'Reject Code - Reject Reason Description: ';
// 	Name_First_Rej_Message := IF(Name_First<>'','','8-INVALID OR BLANK FIRST NAME;');
// 	Name_Last_Rej_Message := IF(Name_Last<>'','','4-INVALID OR BLANK LAST NAME;');
// 	street_addr_Rej_Message := IF(street_addr<>'','','512-INVALID OR BLANK STREET ADDRESS;');
// 	p_City_name_Rej_Message := IF(p_City_name<>'','','1024-IINVALID OR BLANK CITY;');
// 	ST_name_Rej_Message := IF(ST_Cln<>'','','2048-INVALID OR BLANK STATE;');
// 	Z5_Rej_Message := IF(Z5_Cln<>'','','4096-INVALID OR BLANK ZIP CODE;');
// 	DOB_Rej_Message := IF(DOB_Cln<>'','','256-INVALID OR BLANK DATE OF BIRTH;');
// 	MemberGender_Rej_Message := IF(MemberGender_Cln<>'','','16777216-INVALID OR BLANK GENDER;');
// 	SSN_Rej_Message := IF(SSN_Cln<>'','','128-INVALID OR BLANK SSN;');

// 	Condition_1_Reject_Message := Reject_Code_Reason_Prefix + SSN_Rej_Message + MemberGender_Rej_Message + DOB_Rej_Message + ST_name_Rej_Message;
// 	// Condition_1_Reject_Message;
// 	Condition_2_Reject_Message := Reject_Code_Reason_Prefix + Name_First_Rej_Message + Name_Last_Rej_Message + street_addr_Rej_Message + p_City_name_Rej_Message + Z5_Rej_Message + MemberGender_Rej_Message + DOB_Rej_Message + ST_name_Rej_Message;
// 	// Condition_2_Reject_Message;
// 	Condition_1_2_Reject_Message := IF(Met_MinInput_Condition_1 = TRUE or Met_MinInput_Condition_2 = TRUE,'',IF(Met_MinInput_Condition_2 = FALSE, Condition_2_Reject_Message,IF(Met_MinInput_Condition_2 = TRUE AND Met_MinInput_Condition_1 = FALSE,'',Condition_1_Reject_Message)));
// 	//Condition_1_2_Reject_Message;
// 	IF(Condition_1_2_Reject_Message<>'',FAIL(Condition_1_2_Reject_Message));
// 	IF(Condition_1_2_Reject_Message<>'' AND isMinor,FAIL('Reject Code - Reject Reason Description: 666666-INPUT RECORD IS A MINOR;'));
// 	return true;
// END;

END;