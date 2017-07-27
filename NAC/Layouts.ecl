import header,address,AID,Tools;
export Layouts := MODULE

	export load := RECORD
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
		,string70	Case_Physical_Address_Street_1
		,string70	Case_Physical_Address_Street_2
		,string30	Case_Physical_Address_City
		,string2	Case_Physical_Address_State
		,string9	Case_Physical_Address_Zip
		,string70	Case_Mailing_Address_Street_1
		,string70	Case_Mailing_Address_Street_2
		,string30	Case_Mailing_Address_City
		,string2	Case_Mailing_Address_State
		,string9	Case_Mailing_Address_Zip
		,string3	Case_County_Parish_Code
		,string25	Case_County_Parish_Name
		,string20	Client_Identifier
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
		,string52	Filler
		,string1 cr
	END;

	export Input_Prepped := RECORD
		string75 FileName:=''
		,unsigned4 ProcessDate:=0
		,unsigned4 NCF_FileDate:=0
		,unsigned6 PrepRecNo:=0
		,unsigned6 PrepRecSeq:=0
		,load -[filler,cr]
	END;

	export load_old := RECORD
		String25 Case_Last_Name
		,String25 Case_First_Name
		,String1 Case_Middle_Initial
		,String6 Case_Benefit_Month
		,String1 Case_Benefit_Type
		,String25 Client_Last_Name
		,String25 Client_First_Name
		,String1 Client_Middle_Initial
		,String1 Client_Gender
		,String9 Client_SSN
		,String8 Client_DOB
		,String1 Client_Eligible_Indicator
		,String2 State_Abbreviation
		,String1 Client_SSN_Verification_Flag
		,String25 Case_Physical_Address_Street_1
		,String25 Case_Physical_Address_Street_2
		,String20 Case_Physical_Address_City
		,String2 Case_Physical_Address_State
		,String9 Case_Physical_Address_Zip
		,String25 Case_Mailing_Address_Street_1
		,String25 Case_Mailing_Address_Street_2
		,String20 Case_Mailing_Address_City
		,String2 Case_Mailing_Address_State
		,String9 Case_Mailing_Address_Zip
		,string1 cr
	END;

	export base := RECORD
		string75 FileName:=''
		,unsigned6 Case_Id:=0
		,load -[filler,cr]
		,String75  Prepped_name:=''
		,String60  Prepped_addr1:=''
		,String35  Prepped_addr2:=''
		,unsigned6 did:=0
		,unsigned  did_score:=0
		,unsigned4 ProcessDate:=0
		,unsigned4 NCF_FileDate:=0
		,unsigned6 PrepRecSeq:=0
		,string9   clean_ssn:=''
		,string9   best_ssn:=''
		,integer4  clean_dob:=0
		,integer4  age:=0
		,integer4  best_dob:=0
		,address.Layout_Clean_Name.title
		,address.Layout_Clean_Name.fname
		,address.Layout_Clean_Name.mname
		,address.Layout_Clean_Name.lname
		,address.Layout_Clean_Name.name_suffix

		,address.Layout_Clean182.prim_range
		,address.Layout_Clean182.predir
		,address.Layout_Clean182.prim_name
		,address.Layout_Clean182.addr_suffix
		,address.Layout_Clean182.postdir
		,address.Layout_Clean182.unit_desig
		,address.Layout_Clean182.sec_range
		,address.Layout_Clean182.p_city_name
		,address.Layout_Clean182.v_city_name
		,address.Layout_Clean182.st
		,address.Layout_Clean182.zip
		,address.Layout_Clean182.zip4
		,address.Layout_Clean182.cart
		,address.Layout_Clean182.cr_sort_sz
		,address.Layout_Clean182.lot
		,address.Layout_Clean182.lot_order
		,address.Layout_Clean182.dbpc
		,address.Layout_Clean182.chk_digit
		,address.Layout_Clean182.rec_type
		,string2		fips_county:=''
		,string3		county:=''
		,address.Layout_Clean182.geo_lat
		,address.Layout_Clean182.geo_long
		,address.Layout_Clean182.msa
		,address.Layout_Clean182.geo_blk
		,address.Layout_Clean182.geo_match
		,address.Layout_Clean182.err_stat
		,unsigned1 zero :=0
		,string1   blank:=''
	END;

	export slim1 := RECORD
		Base.PrepRecSeq
		,Base.NCF_FileDate
		,load.Case_State_Abbreviation
		,load.Case_Identifier
		,load.Client_Identifier
		,load.Client_Last_Name
		,load.Client_First_Name
		,load.Client_Middle_Name
		,load.Client_SSN
		,load.Client_DOB
	END;

	export Collisions_slim := RECORD
		unsigned1 pri:=0
		,string15 matchset:=''
		,unsigned6 LexID:=0
		,unsigned6 LexID_score:=0
		,load.Case_Benefit_Month
		,load.Client_Eligible_Status_Indicator
		,load.Case_Benefit_Type
		,slim1 left_rec
		,slim1 right_rec
	END;

export Collisions := record
	unsigned1 pri:=0
	,string15 matchset:=''
	,unsigned6 LexID:=0
	,string1 ActivityType:='4'
	,string40 BuildVersion
	,string2 BenefitState
	,string20 SearchCaseID
	,string20 SearchClientID
	,string1 SearchBenefitType
	,string6 SearchBenefitMonth
	,string30 SearchLastName
	,string25 SearchFirstName
	,string25 SearchMiddleName
	,string9 SearchSSN
	,string8 SearchDOB
	,string70 SearchAddress1StreetAddress1
	,string70 SearchAddress1StreetAddress2
	,string30 SearchAddress1City
	,string2 SearchAddress1State
	,string9 SearchAddress1Zip
	,string70 SearchAddress2StreetAddress1
	,string70 SearchAddress2StreetAddress2
	,string30 SearchAddress2City
	,string2 SearchAddress2State
	,string9 SearchAddress2Zip
	,string2 CaseState
	,string1 CaseBenefitType
	,string6 CaseBenefitMonth
	,string20 CaseID
	,string30 CaseLastName
	,string25 CaseFirstName
	,string25 CaseMiddleName
	,string10 CasePhone1
	,string10 CasePhone2
	,string256 CaseEmail
	,string70 CasePhysicalStreet1
	,string70 CasePhysicalStreet2
	,string30 CasePhysicalCity
	,string2 CasePhysicalState
	,string9 CasePhysicalZip
	,string70 CaseMailStreet1
	,string70 CaseMailStreet2
	,string30 CaseMailCity
	,string2 CaseMailState
	,string9 CaseMailZip
	,string3 CaseCountyParishCode
	,string25 CaseCountyParishName
	,string20 ClientID
	,string30 ClientLastName
	,string25 ClientFirstName
	,string25 ClientMiddleName
	,string1 ClientGender
	,string1 ClientRace
	,string1 ClientEthnicity
	,string9 ClientSSN
	,string1 ClientSSNType
	,string8 ClientDOB
	,string1 ClientDOBType
	,string1 ClientEligibilityStatus
	,string8 ClientEligibilityDate
	,string10 ClientPhone
	,string256 ClientEmail
	,string50 StateContactName
	,string10 StateContactPhone
	,string10 StateContactPhoneExtension
	,string256 StateContactEmail
	,string3 LexIdScore
	,string10 MatchCodes
	,string4 SearchSequenceNumber
	,string4 ClientSequenceNumber
	,unsigned4 SearchNCFFileDate
	,unsigned4 ClientNCFFileDate
	,unsigned4 SearchProcessDate
	,unsigned4 ClientProcessDate
	,string1	ClientEligibleStatusIndicator
end;

export DBC := RECORD
		Collisions
					- [
						pri
						,matchset
						,LexID
						,SearchSequenceNumber
						,ClientSequenceNumber
						,SearchNCFFileDate
						,ClientNCFFileDate
						,SearchProcessDate
						,ClientProcessDate
						,ClientEligibleStatusIndicator
						]
		,string4 SequenceNumber
		,string1 LF:='\n'
	END;

export MSH:=record
		string1 ActivityType
		,string40 ActivitySource
		,string16 ESPTransactionId
		,string10 MRFRecordNumber
		,string20 DrupalUserLoginId
		,string15 DrupalUserIP
		,string20 EndUserName
		,string15 EndUserIP
		,string16 DrupalTransactionId
		,string4 QueryStatus
		,string70 QueryStatusMessage
		,string20 SearchCaseId
		,string20 SearchClientId
		,string60 SearchFullName
		,string30 SearchLastName
		,string25 SearchFirstName
		,string25 SearchMiddleName
		,string5 SearchSuffix
		,string9 SearchSSN
		,string8 SearchDOB
		,string1 SearchBenefitType
		,string6 SearchBenefitMonth
		,string70 SearchAddress1StreetAddress1
		,string70 SearchAddress1StreetAddress2
		,string30 SearchAddress1City
		,string2 SearchAddress1State
		,string9 SearchAddress1Zip
		,string70 SearchAddress2StreetAddress1
		,string70 SearchAddress2StreetAddress2
		,string30 SearchAddress2City
		,string2 SearchAddress2State
		,string9 SearchAddress2Zip
		,string1 IncludeTwelveMonthHistory
		,string2 CaseState
		,string1 CaseBenefitType
		,string6 CaseBenefitMonth
		,string20 CaseID
		,string30 CaseLastName
		,string25 CaseFirstName
		,string25 CaseMiddleName
		,string10 CasePhone1
		,string10 CasePhone2
		,string256 CaseEmail
		,string70 CasePhysicalStreet1
		,string70 CasePhysicalStreet2
		,string30 CasePhysicalCity
		,string2 CasePhysicalState
		,string9 CasePhysicalZip
		,string70 CaseMailStreet1
		,string70 CaseMailStreet2
		,string30 CaseMailCity
		,string2 CaseMailState
		,string9 CaseMailZip
		,string3 CaseCountyParishCode
		,string25 CaseCountyParishName
		,string20 ClientID
		,string30 ClientLastName
		,string25 ClientFirstName
		,string25 ClientMiddleName
		,string1 ClientGender
		,string1 ClientRace
		,string1 ClientEthnicity
		,string9 ClientSSN
		,string1 ClientSSNType
		,string8 ClientDOB
		,string1 ClientDOBType
		,string1 ClientEligibilityStatus
		,string8 ClientEligibilityDate
		,string10 ClientPhone
		,string256 ClientEmail
		,string50 StateContactName
		,string10 StateContactPhone
		,string10 StateContactPhoneExtension
		,string256 StateContactEmail
		,string3 LexIdScore
		,string10 MatchCodes
		,string84 TwelveMonthHistory
		,string4 SequenceNumber
		,string1 LF:='\n'
	end;

export fl_temp := RECORD
		load - [
			State_Contact_Name
		,	State_Contact_Phone
		,	State_Contact_Phone_Extension
		,	State_Contact_Email
		,	Filler ]
	END;

END;