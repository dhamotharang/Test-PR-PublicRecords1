import ut;
EXPORT POC := MODULE

rload := RECORD
		string2	Case_State_Abbreviation
		,string1	Case_Benefit_Type
		,string6	Case_Benefit_Month
		,string20	Case_Identifier
		,string30	Case_Last_Name
		,string25	Case_First_Name
		,string25	Case_Middle_Name
		,string10	Case_Phone_1
		,string10	Case_Phone_2
		,string256	Case_Email
		,string130	Case_Physical_Address_Street_1	// change width
		//,string70	Case_Physical_Address_Street_2
		,string30	Case_Physical_Address_City
		,string2	Case_Physical_Address_State
		,string9	Case_Physical_Address_Zip
		,string130	Case_Mailing_Address_Street_1		// change width
		//,string70	Case_Mailing_Address_Street_2
		,string30	Case_Mailing_Address_City
		,string2	Case_Mailing_Address_State
		,string9	Case_Mailing_Address_Zip
		,string25	Case_County_Parish_Name		// reversed with code
		,string3	Case_County_Parish_Code
		,string17	Client_Identifier					// change width
		,string30	Client_Last_Name
		,string25	Client_First_Name
		,string25	Client_Middle_Name
		,string1	Client_Gender
		,string1	Client_Race
		,string1	Client_Ethnicity
		,string9	Client_SSN
		,string1	Client_SSN_Type_Indicator
		,string8	Client_DOB
		,string1	Client_DOB_Type_Indicator
		,string1	Client_Eligible_Status_Indicator
		,string8	Client_Eligible_Status_Date
		,string10	Client_Phone
		,string256	Client_Email
		,string50	State_Contact_Name
		,string10	State_Contact_Phone
		,string10	State_Contact_Phone_Extension
		,string256	State_Contact_Email
		,string52	Filler:=''
		,string1 cr:='\n'
	END;
root := '~nac::poc::mo';

d:=dataset(root,{string FullRecord},csv(terminator(['\r\n', '\n']), separator([]), quote([]), notrim));
rload t(d l) := transform
	string4096 lString   := l.FullRecord;
	rload lRecord := transfer(lString, rload);
	self                 := lRecord;
end;
p:=project(d,t(left));

//export File_MO := PROJECT(p, TRANSFORM({string75 fn { virtual(logicalfilename)},Layouts.load},
//										self := left;
//										self := [];)); 


export File_MO := DATASET('~nac::poc::mo::rectified', {string75 fn { virtual(logicalfilename)},Layouts.load}, thor);


END;