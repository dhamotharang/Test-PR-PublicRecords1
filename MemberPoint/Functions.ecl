Import STD,UT;
Import iesp;

EXPORT Functions := Module

EXPORT _blank := '';

EXPORT SSNCleaner(string SSN) := FUNCTION
string cleanSSN := STD.STR.filter(SSN,'0123456789');
ssnlength	:= length(cleanSSN);
set_invalid_ssn8	:= ['00000000','11111111','22222222','33333333','44444444','55555555','66666666','77777777','88888888','99999999','12345678','01234567','98765432','87654321','10101010'];
BOOLEAN	is_invalid_ssn8	:= cleanSSN[1..8] IN set_invalid_ssn8; 
BOOLEAN	is_invalid_ssn_length := IF(ssnlength IN [9], FALSE, TRUE);
OutSSN := IF(is_invalid_ssn8 OR is_invalid_ssn_length,_blank, cleanSSN);
return OutSSN;
END;


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
Export BuildMinInputErrorsDS(Cleaned_Input) := FUNCTIONMACRO
export _blank := '';
		EmptyExceptionDS := DATASET([], iesp.share.t_WsException);
		_EmptyExceptionDSRow := ROW({_blank, 0, _blank, _blank}, iesp.share.t_WsException);
		//Check for rejects
		Cleaned_Member_Input := Cleaned_Input[1];
		Name_First := Cleaned_Member_Input.Name_First;
		Name_Last := Cleaned_Member_Input.Name_Last;
		street_addr := Cleaned_Member_Input.street_addr;
		p_City_name := Cleaned_Member_Input.p_City_name;
		ST_Cln := Cleaned_Member_Input.ST_Cln;
		Z5_Cln := Cleaned_Member_Input.Z5_Cln;
		DOB_Cln := Cleaned_Member_Input.DOB_Cln;
		SSN_Cln := Cleaned_Member_Input.SSN_Cln;
		Met_MinInput_Condition_1 := IF(Name_First<>_blank AND Name_Last<>_blank  AND street_addr<>_blank AND p_City_name<>_blank AND Z5_Cln<>_blank  AND ST_Cln<>_blank,TRUE, FALSE);
		Met_MinInput_Condition_2 := IF(SSN_Cln<>_blank  AND Name_First<>_blank AND Name_Last<>_blank,TRUE, FALSE);
		Name_First_Rej_Row := IF(Name_First<>_blank, _EmptyExceptionDSRow, ROW({_blank, memberpoint.constants.Name_First_Rej_Code , _blank, memberpoint.constants.Name_First_Rej_Message}, iesp.share.t_WsException));
		Name_Last_Rej_Row := IF(Name_Last<>_blank,_EmptyExceptionDSRow, ROW({_blank, memberpoint.constants.Name_Last_Rej_Code , _blank, memberpoint.constants.Name_Last_Rej_Message}, iesp.share.t_WsException));
		street_addr_Rej_Row := IF(trim(street_addr,left,right)<>_blank,_EmptyExceptionDSRow, ROW({_blank, Models.Healthcare_Constants_RT_Service.street_addr_Rej_Code , _blank, Models.Healthcare_Constants_RT_Service.street_addr_Rej_Message}, iesp.share.t_WsException));
		p_City_name_Rej_Row := IF(p_City_name<>_blank,_EmptyExceptionDSRow, ROW({_blank, memberpoint.constants.p_City_name_Rej_Code , _blank, memberpoint.constants.p_City_name_Rej_Message}, iesp.share.t_WsException));
		ST_name_Rej_Row := IF(ST_Cln<>_blank,_EmptyExceptionDSRow, ROW({_blank, memberpoint.constants.ST_name_Rej_Code , _blank, memberpoint.constants.ST_name_Rej_Message}, iesp.share.t_WsException));
		Z5_Rej_Row := IF(Z5_Cln<>_blank,_EmptyExceptionDSRow, ROW({_blank, memberpoint.constants.Z5_Rej_Code , _blank, memberpoint.constants.Z5_Rej_Message}, iesp.share.t_WsException));
		SSN_Rej_Row := IF(SSN_Cln<>_blank,_EmptyExceptionDSRow, ROW({_blank, memberpoint.constants.SSN_Rej_Code , _blank, memberpoint.constants.SSN_Rej_Message}, iesp.share.t_WsException));
		
		Condition_1_Reject_DS := EmptyExceptionDS + Name_First_Rej_Row + Name_Last_Rej_Row + street_addr_Rej_Row +p_City_name_Rej_Row+ Z5_Rej_Row + ST_name_Rej_Row;
    Condition_2_Reject_DS := EmptyExceptionDS + SSN_Rej_Row +  Name_First_Rej_Row+ Name_Last_Rej_Row;		
		Condition_1_2_Reject_DS := IF(Met_MinInput_Condition_1 = TRUE or Met_MinInput_Condition_2 = TRUE,EmptyExceptionDS,
                               IF(Met_MinInput_Condition_1 = FALSE AND  Cleaned_Member_Input.SSN_cln=_blank, Condition_1_Reject_DS,IF(Met_MinInput_Condition_2 = TRUE AND Met_MinInput_Condition_1 = FALSE, EmptyExceptionDS,Condition_2_Reject_DS)));
		Output_Condition_1_2_Reject_DS := IF(COUNT(Condition_1_2_Reject_DS(code<>0)) > 0, Condition_1_2_Reject_DS(code<>0), EmptyExceptionDS);
		return Output_Condition_1_2_Reject_DS(code<>0);
	ENDMACRO;

  END;
