export MAC_ReturnCodes(cnt, gdc_results_count) := MACRO

CHOOSEN( 
	//I01	Important Application Data Missing	-	If !(Minimum transation requirements)
	// this code is set in getGDCVerify
	//IF(~isInputOk,DATASET([{'I01',getRCDesc('I01')}],iesp.share.t_RiskIndicator)) & 

	//I02	The input is reported as deceased	External	UK Only If Deceased indicator UK Credit File
	IF(isDeceased,DATASET([{'I02',IntlIID.getRCDesc('I02')}],iesp.share.t_RiskIndicator)) &

	//IPA	Potential address discrepancy - the input address may be a previous address	External	If !addr on current source and addr on historical source
	//**FUTURE** -js

	//I9B	Evidence of historical property ownership but no current record	External	If addr on historical source and !addron current source
	//**There is no historical property ownership source **REFERENCE** -js
	
	//I06	The input NID is invalid	External	If !NID
	// **This will be a return from GDC should they be able to provide NID validation services **FUTURE** -js
	
	//I33	Single Source Verification Only
	IF(gdc_results_count = 1, DATASET([{'I33',IntlIID.getRCDesc('I33')}],iesp.share.t_RiskIndicator)) &
	
	//I12	The input identity information did not meet any category of global KYC for EIDV
	IF(cl = '0',DATASET([{'I12',IntlIID.getRCDesc('I12')}],iesp.share.t_RiskIndicator)) &

	//I37	Unable to verify name	-	If !lname
	IF(~isLastNameVer and ~isFullNameVer,DATASET([{'I37',IntlIID.getRCDesc('I37')}],iesp.share.t_RiskIndicator)) &
	
	//I48	Unable to verify first name - If !fname
	IF(fnamePop AND ~isFirstNameVer AND ~isNameVer,DATASET([{'I48',IntlIID.getRCDesc('I48')}],iesp.share.t_RiskIndicator)) &

	//I25	Unable to verify address - If !addr
	IF(addressPop AND ~isAddressVer,DATASET([{'I25',IntlIID.getRCDesc('I25')}],iesp.share.t_RiskIndicator)) &	   
	
	//I28	Unable to verify date-of-birth -	If !DOB
	IF(dobPop AND ~isDOBVer,DATASET([{'I28',IntlIID.getRCDesc('I28')}],iesp.share.t_RiskIndicator)) &

	//I27	Unable to verify phone number	-	If !phone
	IF(phonePop AND ~isPhoneNumberVer,DATASET([{'I27',IntlIID.getRCDesc('I27')}],iesp.share.t_RiskIndicator)) &			   
	
	//I22	Unable to verify applicant name and address	-	If !(fname and lname and addr)
	IF(~isNameVer AND addressPop AND ~isAddressVer,DATASET([{'I22',IntlIID.getRCDesc('I22')}],iesp.share.t_RiskIndicator)) &
	
	//I20	Unable to verify applicant name, address and phone number	-	If !(fname and lname and addr and phone)
	IF(~isNameVer AND addressPop AND ~isAddressVer AND phonePop AND ~isPhoneNumberVer,DATASET([{'I20',IntlIID.getRCDesc('I20')}],iesp.share.t_RiskIndicator)) &
	
	//I21	Unable to verify applicant name and phone number	-	If !(fname and lname and phone)
	IF(~isNameVer AND phonePop AND ~isPhoneNumberVer,DATASET([{'I21',IntlIID.getRCDesc('I21')}],iesp.share.t_RiskIndicator)) &
	
	//I64	The input address associated with a different phone number	-	If (addr and !phone) OR (!addr and phone)
	IF((addressPop AND isAddressVer AND phonePop AND ~isPhoneNumberVer) OR (addressPop AND ~isAddressVer AND phonePop AND isPhoneNumberVer) ,DATASET([{'I64',IntlIID.getRCDesc('I64')}],iesp.share.t_RiskIndicator)) &

	//I73	The input Telephone Number is not found in the public record databases	-	If phone = <missing> or <no match>.
	IF(phonePop AND ~isPhoneFound,DATASET([{'I73',IntlIID.getRCDesc('I73')}],iesp.share.t_RiskIndicator)) &

	//I26	Unable to verify NID - If !NID
	IF(nationalIDPop and ~isIdNumberVer,DATASET([{'I26',IntlIID.getRCDesc('I26')}],iesp.share.t_RiskIndicator)) &			   
	
	//I23	Unable to verify applicant name and NID	External	If !(fname and lname and NID)
	IF(~isNameVer AND nationalIDPop AND ~isIdNumberVer,DATASET([{'I23',IntlIID.getRCDesc('I23')}],iesp.share.t_RiskIndicator)) &
	
	//I24	Unable to verify applicant address and NID	External	If !(addr and NID)
	IF(addressPop AND ~isAddressVer AND nationalIDPop AND ~isIdNumberVer,DATASET([{'I24',IntlIID.getRCDesc('I24')}],iesp.share.t_RiskIndicator)) &
	
	//I19	Unable to verify name, address, NID and phone	-	If !(fname and lname and addr and NID and phone)
	IF(~isNameVer AND ~addressPop AND ~isAddressVer AND ~nationalIDPop AND ~isIdNumberVer AND ~phonePop AND ~isPhoneNumberVer,DATASET([{'I19',IntlIID.getRCDesc('I19')}],iesp.share.t_RiskIndicator)) &

	//I51	The input last name is not associated with the input NID -	if (NID and !lname) OR (!NID and lname)
	IF((nationalIDPop AND isIdNumberVer AND ~isLastNameVer AND ~isNameVer) OR (nationalIDPop AND ~isIdNumberVer AND (isLastNameVer OR isNameVer)),DATASET([{'I51',IntlIID.getRCDesc('I51')}],iesp.share.t_RiskIndicator)) &
	
	//I52	The input first name is not associated with input NID	-	if (NID and !fname) OR (!NID and fname)
	IF((nationalIDPop AND isIdNumberVer AND ~isFirstNameVer AND ~isNameVer) OR (nationalIDPop AND ~isIdNumberVer AND (isFirstNameVer OR isNameVer)),DATASET([{'I52',IntlIID.getRCDesc('I52')}],iesp.share.t_RiskIndicator)) &

	//I66	The input NID is associated with a different last name, same first name	-	If (NID and fname and !lname)
	IF(nationalIDPop AND isIdNumberVer AND isFirstNameVer AND ~isLastNameVer,DATASET([{'I66',IntlIID.getRCDesc('I66')}],iesp.share.t_RiskIndicator)) &

	//I71	The input National ID is not found in the public record databases	-	If NID = <no match>.
	IF(nationalIDPop AND ~isNIDFound,DATASET([{'I71',IntlIID.getRCDesc('I71')}],iesp.share.t_RiskIndicator)) &
	
	//I72	The input NID is associated with a different name and address	-	If (NID and !fname and !lname and !addr) OR (!NID and fname and lname and addr)
	IF((nationalIDPop AND isIdNumberVer AND ~isNameVer AND addressPop AND ~isAddressVer) OR
		 (nationalIDPop AND ~isIdNumberVer AND isNameVer AND addressPop AND isAddressVer),DATASET([{'I72',IntlIID.getRCDesc('I72')}],iesp.share.t_RiskIndicator)) &

	//I04	The input Last Name and NID are verified, but not with the input Address and Phone -	If lname and NID XOR addr and phone
	IF(nationalIDPop AND isIdNumberVer AND (isLastNameVer OR isNameVer) AND addressPop AND ~isAddressVer AND phonePop AND ~isPhoneNumberVer,DATASET([{'I04',IntlIID.getRCDesc('I04')}],iesp.share.t_RiskIndicator)) &
	
	//I45	The input NID and address are not associated with the input last name and phone	-	If ((NID and addr) and !(lname and phone)) OR (!(NID and addr) and !(lname and phone))
	IF((nationalIDPop AND isIdNumberVer AND addressPop AND isAddressVer AND ~isLastNameVer AND ~isNameVer AND phonePop AND ~isPhoneNumberVer) OR
			(nationalIDPop AND ~isIdNumberVer AND addressPop AND ~isAddressVer AND (isLastNameVer OR isNameVer) AND phonePop AND isPhoneNumberVer),DATASET([{'I45',IntlIID.getRCDesc('I45')}],iesp.share.t_RiskIndicator)) &
	
	//I77	The input name was missing-	If fname and lname = <missing> or blank on input
	IF(~fnamePop OR ~lnamePop,DATASET([{'I77',IntlIID.getRCDesc('I77')}],iesp.share.t_RiskIndicator)) &
	
	//I79	The input NID was missing or incomplete	-	If NID = <missing> or blank on input
	IF(SourceHasNID and (~nationalIDPop OR LENGTH(natID) < 6),DATASET([{'I79',IntlIID.getRCDesc('I79')}],iesp.share.t_RiskIndicator)) &
	
	//I78	The input address was missing - If addr = <missing> or blank on input
	IF(~addressPop,DATASET([{'I78',IntlIID.getRCDesc('I78')}],iesp.share.t_RiskIndicator)) &			
	
	//I82	The input name and address return a different phone number - If (fname and lname and !phone) OR (!fname and !lname and phone) -js
	IF((isNameVer AND phonePop AND isAddressVer AND ~isPhoneNumberVer) OR (~isNameVer AND phonePop AND ~isAddressVer AND isPhoneNumberVer) ,DATASET([{'I82',IntlIID.getRCDesc('I82')}],iesp.share.t_RiskIndicator)) &

	//I81	The input date-of-birth was missing or incomplete	-	If DOB = <missing> or blank on input
	IF(~dobPop,DATASET([{'I81',IntlIID.getRCDesc('I81')}],iesp.share.t_RiskIndicator)) &
	
	//I80	The input phone was missing or incomplete	- If phone = <missing> or blank on input
	IF(~phonePop OR LENGTH(phone) < 6,DATASET([{'I80',IntlIID.getRCDesc('I80')}],iesp.share.t_RiskIndicator)) &
	
	//I17	The input Passport is expired
	IF(isPassportExpired,DATASET([{'I17',IntlIID.getRCDesc('I17')}],iesp.share.t_RiskIndicator)) &
	
	//I14	The input US Visa is expired
	IF(isVisaExpired,DATASET([{'I14',IntlIID.getRCDesc('I14')}],iesp.share.t_RiskIndicator)) &
	
	//I16	The input Passport is not valid according to the ICAO/ICO 9303 international standard
	IF(ppLen > 0 and ~validPassport,DATASET([{'I16',IntlIID.getRCDesc('I16')}],iesp.share.t_RiskIndicator)) &
	
	//I13	The input US Visa is not valid according to the ICAO/ICO 9303 international standard
	IF(vLen > 0 and ~validVisa,DATASET([{'I13',IntlIID.getRCDesc('I13')}],iesp.share.t_RiskIndicator)) &
	
	//I18	The input Passport length not valid
	IF(ppLen > 0 and ppLen <> 88,DATASET([{'I18',IntlIID.getRCDesc('I18')}],iesp.share.t_RiskIndicator)) &
	
	//I15	The input US Visa length not valid
	IF(vLen > 0 and vLen <> 88,DATASET([{'I15',IntlIID.getRCDesc('I15')}],iesp.share.t_RiskIndicator)) &
	
	//I29	Unable to verify passport number
	IF(passportPop and ~isPassportVer,DATASET([{'I29',IntlIID.getRCDesc('I29')}],iesp.share.t_RiskIndicator)) &

	//IDV	Unable to verify driverâ€™s license number
	IF(driverPop and ~isDriverVer,DATASET([{'IDV',IntlIID.getRCDesc('IDV')}],iesp.share.t_RiskIndicator))
	
	//I08	The input phone number is potentially invalid
	//No datasource available - possible **FUTURE** validation -js
	
	//I75	The input name and address are associated with an unlisted/non-published phone number	External	Waiting for GDC response
	//No datasource available - possible **FUTURE** validation -js

	//I09	The input phone number is a pager number	External	Waiting for GDC response
	//No datasource available - possible **FUTURE** validation -js

	//I10	The input phone number is a mobile number	External	Waiting for GDC response
	//No datasource available - possible **FUTURE** validation -js

	//I34	Incomplete verification	-	Minimum verification not met.
	//Not used - see I01
	
	//I36	Identity elements not fully verified on all available sources
	//Not possible to determine  **REFERENCE** -js
	
			,	cnt)

ENDMACRO;